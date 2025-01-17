from django.test import TestCase

from indigo.analysis.work_detail import BaseWorkDetail
from indigo_api.models import Work, Country


class BaseWorkDetailTestCase(TestCase):
    fixtures = ['languages_data', 'countries', 'subtype']

    def setUp(self):
        self.country = Country.objects.first()
        self.plugin = BaseWorkDetail()

    def test_numbered_title_simple(self):
        work = Work.objects.create(
            country=self.country,
            title="test",
            frbr_uri="/akn/za/act/1999/32"
        )
        self.assertEqual('Act 32 of 1999', self.plugin.work_numbered_title(work))

    def test_numbered_title_caps(self):
        work = Work.objects.create(
            country=self.country,
            title="test",
            frbr_uri="/akn/za/act/gn/1999/r32"
        )
        self.assertEqual('Government Notice R32 of 1999', self.plugin.work_numbered_title(work))

    def test_numbered_title_none(self):
        work = Work.objects.create(
            country=self.country,
            title="test",
            frbr_uri="/akn/za/act/1999/constitution"
        )
        self.assertIsNone(self.plugin.work_numbered_title(work))

        work = Work.objects.create(
            country=self.country,
            title="test",
            frbr_uri="/akn/za/act/2012/constitution-seventeenth-amendment"
        )
        self.assertIsNone(self.plugin.work_numbered_title(work))

    def test_numbered_title_ignore_subtype(self):
        plugin = BaseWorkDetail()
        plugin.no_numbered_title_subtypes = ['gn']
        work = Work.objects.create(
            country=self.country,
            title="test",
            frbr_uri="/akn/za/act/gn/1999/32"
        )
        self.assertIsNone(plugin.work_numbered_title(work))
