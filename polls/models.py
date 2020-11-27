from django.db import models


class Polls(models.Model):
    party = models.CharField(max_length=100, default=None, null=True, blank=True)
    vote_count = models.IntegerField(default=0)

    def __str__(self):return self.party
