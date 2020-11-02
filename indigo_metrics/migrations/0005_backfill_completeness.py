# -*- coding: utf-8 -*-
# Generated by Django 1.11.20 on 2019-05-11 07:11
from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('indigo_metrics', '0004_auto_20190511_0643'),
    ]

    operations = [
        migrations.RunSQL("""
UPDATE
  indigo_metrics_daily_workmetrics
SET
  p_breadth_complete = CASE WHEN n_works = 0 THEN 0 ELSE (100::float * n_complete_works / n_works)::int END,
  p_depth_complete = CASE WHEN n_expected_expressions = 0 THEN 100 ELSE (100::float * n_expressions / n_expected_expressions)::int END,
  p_complete       = (
    CASE WHEN n_works = 0 THEN 0 ELSE (100::float * n_complete_works / n_works)::int END +
    CASE WHEN n_expected_expressions = 0 THEN 100 ELSE (100::float * n_expressions / n_expected_expressions)::int END) / 2
WHERE
  p_depth_complete IS NULL
  AND p_breadth_complete IS NULL
  AND p_complete IS NULL
""", migrations.RunSQL.noop, elidable=True)
    ]
