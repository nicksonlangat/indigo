# Generated by Django 3.2.12 on 2022-02-15 08:39

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('indigo_api', '0013_eol_to_br'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='document',
            name='tags',
        ),
    ]