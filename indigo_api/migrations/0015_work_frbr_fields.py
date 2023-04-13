# Generated by Django 3.2.15 on 2022-09-23 17:34

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('indigo_api', '0014_remove_tags'),
    ]

    operations = [
        migrations.AddField(
            model_name='work',
            name='actor',
            field=models.CharField(help_text='FRBR actor', max_length=512, null=True, blank=True),
        ),
        migrations.AddField(
            model_name='work',
            name='date',
            field=models.CharField(help_text='FRBR date', max_length=10, null=True, blank=True),
        ),
        migrations.AddField(
            model_name='work',
            name='doctype',
            field=models.CharField(help_text='FRBR doctype', max_length=64, null=True, blank=True),
        ),
        migrations.AddField(
            model_name='work',
            name='number',
            field=models.CharField(help_text='FRBR number', max_length=512, null=True, blank=True),
        ),
        migrations.AddField(
            model_name='work',
            name='subtype',
            field=models.CharField(help_text='FRBR subtype', max_length=512, null=True, blank=True),
        ),
        migrations.AlterField(
            model_name='annotation',
            name='selectors',
            field=models.JSONField(null=True),
        ),
        migrations.AlterField(
            model_name='commencement',
            name='provisions',
            field=models.JSONField(default=list),
        ),
        migrations.AlterField(
            model_name='task',
            name='extra_data',
            field=models.JSONField(blank=True, null=True),
        ),
        migrations.AlterField(
            model_name='work',
            name='properties',
            field=models.JSONField(blank=True, default=dict),
        ),
    ]
