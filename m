From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: [PATCH 2/3] asus-wmi: Use acpi_video_unregister_backlight instead
 of acpi_video_unregister
Date: Thu, 4 Jun 2015 15:42:46 +0100
Message-ID: <CAHR064jcPfqkEDZkySRx7atRnHtNf=1G3PsjO7aLb+v=YeZFqg@mail.gmail.com>
References: <1433150708-8498-1-git-send-email-hdegoede@redhat.com>
	<1433150708-8498-3-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:33559 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932125AbbFDOmr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Jun 2015 10:42:47 -0400
In-Reply-To: <1433150708-8498-3-git-send-email-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Darren Hart <dvhart@infradead.org>, Ben Skeggs <bskeggs@redhat.com>, "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, DRI <dri-devel@lists.freedesktop.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Aaron Lu <aaron.lu@intel.com>, linux acpi <linux-acpi@vger.kernel.org>, acpi4asus-user <acpi4asus-user@lists.sourceforge.net>

On Mon, Jun 1, 2015 at 10:25 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> acpi_video_unregister() not only unregisters the acpi-video backlight
> interface but also unregisters the acpi video bus event listener, causing
> e.g. brightness hotkey presses to no longer generate keypress events.
>
> The unregistering of the acpi video bus event listener usually is
> undesirable, which by itself is a good reason to switch to
> acpi_video_unregister_backlight().
>
> Another problem with using acpi_video_unregister() rather then using
> acpi_video_unregister_backlight() is that on systems with an intel video
> opregion (most systems) and a wmi_backlight_power quirk, whether or not
> the acpi video bus event listener actually gets unregistered depends on
> module load ordering:
>
> Scenario a:
> 1) acpi/video.ko gets loaded (*), does not do acpi_video_register as there
>    is an intel opregion.
> 2) intel.ko gets loaded, calls acpi_video_register() which registers both
>    the listener and the acpi backlight interface
> 3) asus-wmi.ko gets loaded, calls acpi_video_unregister() causing both
>    the listener and the acpi backlight interface to unregister
>
> Scenario b:
> 1) acpi/video.ko gets loaded (*), does not do acpi_video_register as there
>    is an intel opregion.
> 2) asus-wmi.ko gets loaded, calls acpi_video_dmi_promote_vendor(),
>    calls acpi_video_unregister(), which is a nop since acpi_video_register
>    has not yet been called
> 2) intel.ko gets loaded, calls acpi_video_register() which registers
>    the listener, but does not register the acpi backlight interface due to
>    the call to the preciding call to acpi_video_dmi_promote_vendor()
>
> *) acpi/video.ko always loads first as both other modules depend on it.
>
> So we end up with or without an acpi video bus event listener depending
> on module load ordering, not good.
>
> Switching to using acpi_video_unregister_backlight() means that independ
> of ordering we will always have an acpi video bus event listener fixing
> this.
>
> Note that this commit means that systems without an intel video opregion,
> and systems which were hitting scenario a wrt module load ordering, are
> now getting an acpi video bus event listener while before they were not!
>
> On some systems this may cause the brightness hotkeys to start generating
> keypresses while before they were not (good), while on other systems this
> may cause the brightness hotkeys to generate multiple keypress events for
> a single press (not so good). Since on most systems the acpi video bus is
> the canonical source for brightness events I believe that the latter case
> will needs to be handled on a case by case basis by filtering out the
> duplicate keypresses at the other source for them.
>
> Cc: Corentin Chary <corentin.chary@gmail.com>
> Cc: acpi4asus-user@lists.sourceforge.net
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/platform/x86/asus-wmi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 7543a56..945145d 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -1777,7 +1777,7 @@ static int asus_wmi_add(struct platform_device *pdev)
>                 acpi_video_dmi_promote_vendor();
>         if (!acpi_video_backlight_support()) {
>                 pr_info("Disabling ACPI video driver\n");
> -               acpi_video_unregister();
> +               acpi_video_unregister_backlight();
>                 err = asus_wmi_backlight_init(asus);
>                 if (err && err != -ENODEV)
>                         goto fail_backlight;
> --
> 2.4.2
>

Acked-by: Corentin Chary <corentin.chary@gmail.com)

-- 
Corentin Chary
http://xf.iksaif.net
