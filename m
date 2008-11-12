From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] toshiba_acpi: fingers off backlight if video.ko is serving this functionality
Date: Wed, 12 Nov 2008 17:41:35 -0600
Message-ID: <200811121741.36296.trenn@suse.de>
References: <200811081637.45099.arvidjaar@mail.ru> <alpine.LFD.2.00.0811111331140.4480@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:45444 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756888AbYKLXll (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 Nov 2008 18:41:41 -0500
In-Reply-To: <alpine.LFD.2.00.0811111331140.4480@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Andrey Borzenkov <arvidjaar@mail.ru>, linux-acpi@vger.kernel.org

On Tuesday 11 November 2008 02:04:15 pm Len Brown wrote:
> This patch does what it is supposed to do, but it isn't clear
> if that is a step forward.
>
> I have satellite pro (original centrino about 4 years old)
4 years, that means it originally supported XP and Vista support got added?
That would explain both, vendor specific and generic brightness functions.

> where toshiba-acpi exports 8 brightness levels,
> and acpi exports just 3 (min, 40%, max)

> so when i apply this patch, i get fewer brightness levels.
> I prefer to have all 8 brightness levels.

The patch from Andrey is correct.
Looks like all, the ordinary user needs, and probably the way it works on a  
plain Vista OS is there: off, battery, full level.
You can still use the boot param for your specific needs:
acpi_display_output=vendor

     Thomas

> -Len
>
> On Sat, 8 Nov 2008, Andrey Borzenkov wrote:
> > Subject: [PATCH] toshiba_acpi: fingers off backlight if video.ko is
> > serving this functionality From: Andrey Borzenkov <arvidjaar@mail.ru>
> >
> > Signed-off-by: Andrey Borzenkov <arvidjaar@mail.ru>
> >
> > ---
> >
> > This completes backlight series; toshiba_acpi was missing.
> >
> >  drivers/acpi/toshiba_acpi.c |   19 ++++++++++---------
> >  1 files changed, 10 insertions(+), 9 deletions(-)
> >
> >
> > diff --git a/drivers/acpi/toshiba_acpi.c b/drivers/acpi/toshiba_acpi.c
> > index a7db0c2..c140709 100644
> > --- a/drivers/acpi/toshiba_acpi.c
> > +++ b/drivers/acpi/toshiba_acpi.c
> > @@ -780,19 +780,20 @@ static int __init toshiba_acpi_init(void)
> >  		}
> >  	}
> >
> > -	toshiba_backlight_device = backlight_device_register("toshiba",
> > +	if (!acpi_video_backlight_support()) {
> > +		toshiba_backlight_device = backlight_device_register("toshiba",
> >  						&toshiba_acpi.p_dev->dev,
> >  						NULL,
> >  						&toshiba_backlight_data);
> > -        if (IS_ERR(toshiba_backlight_device)) {
> > -		ret = PTR_ERR(toshiba_backlight_device);
> > -
> > -		printk(KERN_ERR "Could not register toshiba backlight device\n");
> > -		toshiba_backlight_device = NULL;
> > -		toshiba_acpi_exit();
> > -		return ret;
> > +		if (IS_ERR(toshiba_backlight_device)) {
> > +			ret = PTR_ERR(toshiba_backlight_device);
> > +			printk(KERN_ERR "Could not register toshiba backlight device\n");
> > +			toshiba_backlight_device = NULL;
> > +			toshiba_acpi_exit();
> > +			return ret;
> > +		}
> > +		toshiba_backlight_device->props.max_brightness =
> > HCI_LCD_BRIGHTNESS_LEVELS - 1; }
> > -        toshiba_backlight_device->props.max_brightness =
> > HCI_LCD_BRIGHTNESS_LEVELS - 1;
> >
> >  	/* Register rfkill switch for Bluetooth */
> >  	if (hci_get_bt_present(&bt_present) == HCI_SUCCESS && bt_present) {


