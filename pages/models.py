from wagtail.admin.panels import FieldPanel
from wagtail.fields import RichTextField
from wagtail.models import Page


class HomePage(Page):
    intro = RichTextField(blank=True)

    content_panels = Page.content_panels + [
        FieldPanel("intro"),
    ]
