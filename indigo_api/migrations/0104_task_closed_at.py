# -*- coding: utf-8 -*-
# Generated by Django 1.11.20 on 2019-07-02 16:44
from __future__ import unicode_literals

from django.db import migrations, models
from django.contrib.contenttypes.models import ContentType


def populate_closed_at(apps, schema_editor):
    Action = apps.get_model("actstream", "action")
    Task = apps.get_model("indigo_api", "Task")
    db_alias = schema_editor.connection.alias

    content_type = ContentType.objects.get_for_model(Task)

    # backfill task.closed_at
    for action in Action.objects.using(db_alias).filter(verb__in=['approved', 'cancelled'], action_object_content_type_id=content_type.pk):
        Task.objects.filter(pk=action.action_object_object_id).update(closed_at=action.timestamp)


class Migration(migrations.Migration):

    dependencies = [
        ('indigo_api', '0103_add_extra_data_field'),
    ]

    operations = [
        migrations.AddField(
            model_name='task',
            name='closed_at',
            field=models.DateTimeField(help_text=b'When the task was marked as done or cancelled.', null=True),
        ),
        migrations.RunPython(populate_closed_at, migrations.RunPython.noop),
    ]
