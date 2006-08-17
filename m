From: Lennart Poettering <mzxreary@0pointer.de>
Subject: Re: [PATCH,RFC]: acpi,backlight: MSI S270 - driver, second try
Date: Thu, 17 Aug 2006 18:03:39 +0200
Message-ID: <20060817160338.GA19502@tango.0pointer.de>
References: <20060810162329.GA11603@curacao> <20060817152101.GD5950@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tango.0pointer.de ([217.160.223.3]:58633 "EHLO
	tango.0pointer.de") by vger.kernel.org with ESMTP id S932557AbWHQQDl
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 17 Aug 2006 12:03:41 -0400
Content-Disposition: inline
In-Reply-To: <20060817152101.GD5950@ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@suse.cz>
Cc: len.brown@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Thu, 17.08.06 15:21, Pavel Machek (pavel@suse.cz) wrote:

> > This patch applies to 2.6.17 and requires the ACPI ec_transaction()
> > patch I posted earlier:
> > 
> > http://marc.theaimsgroup.com/?l=linux-acpi&m=115517193511970&w=2
> > 
> > Please comment and/or apply!
> 
> Looks ok to me...

Thanks!

> 
> > +static int auto_brightness;
> > +module_param(auto_brightness, int, 0);
> > +MODULE_PARM_DESC(auto_brightness, "Enable automatic brightness control (0: disabled; 1: enabled; 2: don't touch)");
> > +
> > +/*** Hardware access ***/
> > +
> > +static const uint8_t lcd_table[MSI_LCD_LEVEL_MAX] = {
> > +        0x00, 0x1f, 0x3e, 0x5d, 0x7c, 0x9b, 0xba, 0xd9, 0xf8
> > +};
> 
> Can we get 0xf8 levels and simplify code while we are at it?

Unfortunately not. The hardware only supports 9 levels of
brightness. 

However, I guess I could multiply the brightness level with 31 instead
of using the translation table above. 

I will fix that.

> > +        if ((result = ec_transaction(MSI_EC_COMMAND_LCD_LEVEL, &wdata, 1, &rdata, 1)) < 0)
> > +                return result;
> 
> Please split this into two lines.
> 
> result = ...;
> if (result.....)

Will do.

> > +static DEVICE_ATTR(bluetooth, 0444, show_bluetooth, NULL);
> > +static DEVICE_ATTR(wlan, 0444, show_wlan, NULL);
> 
> So bluetooth and wlan basically mirror physical switch state? Should
> we make these switches available through input subsystem one day?

Yes. Actually I've already been discussing with Ivo how to extend the
rfkill API to tell userspace whether an rfkill device is actually for
Bluetooth, for wlan, for uwb and so on. I will update my S270 code as
soon as rfkill enters the kernel to support this new API properly. The
driver will then register two rfkill devices, one for Bluetooth and
one for WLAN.

Lennart

-- 
Lennart Poettering; lennart [at] poettering [dot] net
ICQ# 11060553; GPG 0x1A015CC4; http://0pointer.net/lennart/
