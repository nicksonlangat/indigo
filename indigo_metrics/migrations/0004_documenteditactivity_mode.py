# Generated by Django 3.2.13 on 2023-05-05 15:06

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('indigo_metrics', '0003_document_edit_activity'),
    ]

    operations = [
        migrations.AddField(
            model_name='documenteditactivity',
            name='mode',
            field=models.CharField(blank=True, choices=[('text', 'text'), ('table', 'table')], max_length=20, null=True),
        ),
    ]