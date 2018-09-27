from django.core.management.base import BaseCommand

from indigo_social.badges import PermissionBadge


class Command(BaseCommand):
    help = 'Checks that all users have appropriate badges'

    def handle(self, *args, **options):
        PermissionBadge.synch()
