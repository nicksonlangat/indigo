# -*- coding: utf-8 -*-
# Generated by Django 1.11.20 on 2019-05-24 15:57
from __future__ import unicode_literals

from django.conf import settings
from django.db import migrations, models
from django.contrib.contenttypes.models import ContentType
import django.db.models.deletion


def populate_closed_by(apps, schema_editor):
    Action = apps.get_model("actstream", "action")
    Task = apps.get_model("indigo_api", "Task")
    db_alias = schema_editor.connection.alias

    content_type = ContentType.objects.get_for_model(Task)

    # backfill task.closed_by_user
    for action in Action.objects.using(db_alias).filter(verb='closed', action_object_content_type_id=content_type.pk):
        Task.objects.filter(pk=action.action_object_object_id).update(closed_by_user_id=action.actor_object_id)


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('indigo_api', '0097_workproperty'),
    ]

    operations = [
        migrations.AddField(
            model_name='task',
            name='closed_by_user',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, related_name='+', to=settings.AUTH_USER_MODEL),
        ),
        migrations.AddField(
            model_name='task',
            name='code',
            field=models.CharField(blank=True, max_length=100, null=True),
        ),
        migrations.RunPython(populate_closed_by, migrations.RunPython.noop),
    ]
