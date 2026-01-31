from django.contrib.auth.forms import UserChangeForm, UserCreationForm

from .models import Account


class AccountCreationForm(UserCreationForm):
    class Meta:
        model = Account
        fields = (
            "email",
            "password",
        )


class AccountChangeForm(UserChangeForm):
    class Meta:
        model = Account
        fields = (
            "email",
            "password",
        )
