# Generated by Django 3.2.12 on 2022-10-18 10:15

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('indigo_api', '0017_work_frbr_fields_non_null'),
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('indigo_metrics', '0002_documentmetrics'),
    ]

    operations = [
        migrations.CreateModel(
            name='DocumentEditActivity',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('started_at', models.DateTimeField()),
                ('ended_at', models.DateTimeField()),
                ('duration_secs', models.IntegerField()),
                ('document', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='edit_activities', to='indigo_api.document')),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
        ),
    ]
