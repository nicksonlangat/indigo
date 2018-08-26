# -*- coding: utf-8 -*-
# Generated by Django 1.11 on 2018-08-23 19:19
from __future__ import unicode_literals

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('indigo_api', '0070_remove_old_work_country'),
    ]

    operations = [
        migrations.AlterField(
            model_name='work',
            name='country',
            field=models.ForeignKey(null=False, on_delete=django.db.models.deletion.PROTECT, to='indigo_api.Country'),
        ),
    ]
