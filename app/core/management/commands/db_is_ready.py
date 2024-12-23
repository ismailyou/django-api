"""
    Django management command to check if the database is ready.
"""
import time
from psycopg2 import OperationalError as Psycopg2OperationalError

from django.db.utils import OperationalError
from django.core.management.base import BaseCommand

class Command(BaseCommand):
    help = 'Check if the database is ready'

    def handle(self, *args, **options):
        self.stdout.write(self.style.SUCCESS('Waiting for datatabse!'))
        db_up = False
        while db_up is False:
            try:
                self.check(databases=['default'])
                db_up = True
            except (Psycopg2OperationalError, OperationalError):
                self.stdout.write(self.style.ERROR('Database is not ready! waiting for 1s...'))
                time.sleep(1)
        self.stdout.write(self.style.SUCCESS('Database is ready!'))