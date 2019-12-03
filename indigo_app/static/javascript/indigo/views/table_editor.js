(function(exports) {
  "use strict";

  if (!exports.Indigo) exports.Indigo = {};
  Indigo = exports.Indigo;

  /* The TableEditorView handles inline editing of tables.
   * CKEditor provides the actual editing support and enforces decent HTML.
   */
  Indigo.TableEditorView = Backbone.View.extend({
    el: 'body',
    events: {
      'click .table-insert-row-above': 'insertRowAbove',
      'click .table-insert-row-below': 'insertRowBelow',
      'click .table-insert-column-left': 'insertColumnLeft',
      'click .table-insert-column-right': 'insertColumnRight',
      'click .table-delete-row': 'deleteRow',
      'click .table-delete-column': 'deleteColumn',
      'click .table-merge-cells': 'toggleMergeCells',
      'click .table-toggle-heading': 'toggleHeading',
      'click .save-edit-table': 'saveChanges',
      'click .cancel-edit-table': 'discardChanges',
    },

    initialize: function(options) {
      var self = this;

      this.parent = options.parent;
      this.documentContent = options.documentContent;
      this.tableWrapper = this.$('.table-editor-wrapper').removeClass('d-none').remove()[0];
      this.editing = false;

      this.ckeditor = null;
      // setup CKEditor
      CKEDITOR.disableAutoInline = true;
      // make TH and TD editable
      CKEDITOR.dtd.$editable.th = 1;
      CKEDITOR.dtd.$editable.td = 1;

      // setup transforms
      var htmlTransform = new XSLTProcessor();
      $.get('/static/xsl/html_to_akn.xsl')
        .then(function(xml) {
          htmlTransform.importStylesheet(xml);
          self.htmlTransform = htmlTransform;
        });
    },

    saveChanges: function(e) {
      if (!this.editing) return;

      var table,
          oldTable = this.documentContent.xmlDocument.getElementById(this.table.getAttribute('data-id'));

      table = $.parseHTML(this.ckeditor.getData())[0];
      if (table.tagName != 'TABLE') table = table.querySelector('table');

      // stop editing
      this.editTable(null);

      // get new xml
      table = this.tableToAkn(table);

      // update DOM
      this.documentContent.replaceNode(oldTable, [table]);
      this.parent.render();
    },

    tableToAkn: function(table) {
      if (!this.htmlTransform) return null;

      // html -> string -> xhtml so that the XML is well formed
      var xml = $.parseXML(new XMLSerializer().serializeToString(table));

      // xhtml -> akn
      xml = this.htmlTransform.transformToFragment(xml.firstChild, this.documentContent.xmlDocument);

      // strip whitespace at start of first p tag in table cells
      xml.querySelectorAll('table td > p:first-child, table th > p:first-child').forEach(function(p) {
        var text = p.firstChild;

        if (text && text.nodeType === text.TEXT_NODE) {
          text.textContent = text.textContent.replace(/^\s+/, '');
        }
      });

      // strip whitespace at end of last p tag in table cells
      xml.querySelectorAll('table td > p:last-child, table th > p:last-child').forEach(function(p) {
        var text = p.lastChild;

        if (text && text.nodeType === text.TEXT_NODE) {
          text.textContent = text.textContent.replace(/\s+$/, '');
        }
      });

      return xml;
    },

    discardChanges: function(e, force) {
      if (!this.editing) return;
      if (!force && !confirm("You'll lose your changes, are you sure?")) return;

      var container = this.table.parentElement,
          initialTable = this.initialTable;

      this.editTable(null);

      // undo changes
      container.replaceChild(initialTable, container.querySelector('table'));
    },

    // start editing an HTML table
    editTable: function(table) {
      var self = this,
          editable;

      if (this.table === table) return;

      if (table) {
        // cancel existing edit
        if (this.table) {
          this.discardChanges(null, true);
        }

        this.observers = [];
        this.initialTable = table.cloneNode(true);
        $(table).closest('.table-editor-wrapper').addClass('table-editor-active');

        editable = table.parentElement;
        editable.contentEditable = true;

        CKEDITOR.on('instanceReady', function(evt) {
          evt.removeListener();
          self.table = editable.querySelector('table');
          self.manageTableWidth(self.table);
        });

        this.ckeditor = CKEDITOR.inline(editable, {
          enterMode: CKEDITOR.ENTER_BR,
          shiftEnterMode: CKEDITOR.ENTER_BR,
          toolbar: [],
          allowedContent: 'a[!data-href,!href]; img[!src,!data-src]; span(akn-remark); span(akn-p); ' +
                          'table[id, data-id]; thead; tbody; tr; th{width}[colspan,rowspan]; td{width}[colspan,rowspan]; p;',
          on: {
            selectionChange: _.bind(this.selectionChanged, this),
          },
        });

        this.editing = true;
        this.trigger('start');
      } else {
        // clean up observers
        this.observers.forEach(function(observer) { observer.disconnect(); });
        this.observers = [];

        this.table.parentElement.contentEditable = false;
        $(this.table).closest('.table-editor-wrapper').removeClass('table-editor-active');

        this.ckeditor.destroy();
        this.ckeditor = null;

        this.initialTable = null;
        this.table = null;
        this.editing = false;
        this.trigger('finish');
      }
    },

    /* Set up observers to:
     * 1. ensure that the table width isn't changed
     * 2. change pixel-based column widths to percentages
     */
    manageTableWidth: function(table) {
      // Discard fixed pixel widths on the table itself. This are applied by CKEditor's
      // table resizer.
      var observer = new MutationObserver(function(mutations, observer) {
        for (var i = 0; i < mutations.length; i++) {
          var mutation = mutations[i];

          // discard fixed pixel widths
          if (mutation.target.style.width) {
            mutation.target.style.removeProperty('width');
          }
        }
      });
      observer.observe(table, {attributes: true, attributeFilter: ['style']});
      this.observers.push(observer);

      // change pixel width columns to percentages
      observer = new MutationObserver(function(mutations, observer) {
        for (var i = 0; i < mutations.length; i++) {
          var mutation = mutations[i],
              tag = mutation.target.tagName;

          if ((tag === 'TD' || tag === 'TH') && mutation.target.style.width.slice(-2) === "px") {
            mutation.target.style.setProperty(
              'width',
              parseInt(mutation.target.style.width.slice(0, -2)) / table.clientWidth * 100 + '%');
          }
        }
      });
      observer.observe(table, {subtree: true, attributes: true, attributeFilter: ['style']});
      this.observers.push(observer);
    },

    selectionChanged: function(evt) {
      var selected = this.getSelectedCells(),
          merged = _.any(selected, function(c) { return c.colSpan > 1 || c.rowSpan > 1; }),
          headings = _.any(selected, function(c) { return c.tagName === 'TH'; });

      $('.table-merge-cells').toggleClass('active', merged);
      $('.table-toggle-heading').toggleClass('active', headings);
    },

    insertRowAbove: function() {
      this.ckeditor.execCommand("rowInsertBefore");
    },

    insertRowBelow: function() {
      this.ckeditor.execCommand("rowInsertAfter");
    },

    insertColumnLeft: function(e) {
      this.ckeditor.execCommand("columnInsertBefore");
    },

    insertColumnRight: function(e) {
      this.ckeditor.execCommand("columnInsertAfter");
    },

    deleteRow: function(e) {
      if (this.table.rows.length > 1) this.ckeditor.execCommand("rowDelete");
    },

    deleteColumn: function(e) {
      // there needs to be at least one row with more than one column
      var okay = false;

      for (var i = 0; i < this.table.rows.length; i++) {
        if (this.table.rows[i].cells.length > 1 || this.table.rows[i].cells[0].colSpan > 1) {
          okay = true;
          break;
        }
      }

      if (okay) this.ckeditor.execCommand("columnDelete");
    },

    toggleMergeCells: function(e) {
      var self = this,
          cells = this.getSelectedCells(),
          merged = _.any(cells, function(c) { return c.colSpan > 1 || c.rowSpan > 1; });

      if (merged) {
        cells.forEach(function(cell) {
          self.ckeditor.getSelection().selectElement(new CKEDITOR.dom.element(cell));
          if (cell.colSpan > 1) self.ckeditor.execCommand("cellVerticalSplit");
          if (cell.rowSpan > 1) self.ckeditor.execCommand("cellHorizontalSplit");
        });
      } else {
        this.ckeditor.execCommand("cellMerge");
      }
    },

    toggleHeading: function(e) {
      var self = this,
          cells = this.getSelectedCells(),
          makeHeading = !_.any(cells, function(c) { return c.tagName === 'TH'; });

      cells.forEach(function(cell) {
        if (cell.tagName === 'TH' && makeHeading) return;
        if (cell.tagName === 'TD' && !makeHeading) return;

        cell.parentElement.replaceChild(
          self.renameNode(cell, makeHeading ? 'th' : 'td'),
          cell);
      });
    },

    renameNode: function(node, newname) {
      var newnode = node.ownerDocument.createElement(newname),
        attrs = node.attributes;

      for (var i = 0; i < attrs.length; i++) {
        newnode.setAttribute(attrs[i].name, attrs[i].value);
      }

      while (node.childNodes.length > 0) {
        newnode.appendChild(node.childNodes[0]);
      }

      return newnode;
    },

    getSelectedCells: function() {
      var cells = Array.from(this.table.querySelectorAll('.cke_table-faked-selection'));

      if (!cells.length) {
        // selection is the currently active cell
        var ranges = this.ckeditor.getSelection().getRanges();
        if (ranges.length) {
          var cell = ranges[0].startContainer.getAscendant({th: 1, td: 1}, true);
          if (cell) cells = [cell.$];
        }
      }

      return cells;
    },
  });
})(window);
