From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: Backlight device class redesign
Date: Thu, 03 Dec 2009 16:01:14 +0800
Message-ID: <1259827274.27069.50.camel@rzhang1-desktop>
References: <b170af450911271630k63fb857auf8314cecd6219eba@mail.gmail.com>
	 <b170af450911291209o33ebfc36n850826e54096f3b4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:57306 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752144AbZLCIAo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 3 Dec 2009 03:00:44 -0500
In-Reply-To: <b170af450911291209o33ebfc36n850826e54096f3b4@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Richard Purdie <rpurdie@rpsys.net>

On Mon, 2009-11-30 at 04:09 +0800, Rafa=C5=82 Mi=C5=82ecki wrote:
> W dniu 28 listopada 2009 01:30 u=C5=BCytkownik Rafa=C5=82 Mi=C5=82eck=
i
> <zajec5@gmail.com> napisa=C5=82:
> > As discussed in http://marc.info/?t=3D124947671300008&r=3D1&w=3D2 w=
e need to
> > redesign our backlight device class.
>=20
> I was trying to make it work this way:
> 1. Everytime register request comes, look for backlight_display with =
given name.
> 1. A. If needed, create new backlight_display
> 2. Add new device to devices list of backlight_display
> 3. Find best device on devices list of backlight_display
> 4. Register if under /sys/class/backlight/name_of_display
>=20
> This didn't work because of registering only the best device. Look at
> this code in drivers/acpi/video.c:
>=20

> device->backlight =3D backlight_device_register(name,
>     NULL, device, &acpi_backlight_ops);
> (...)
> result =3D sysfs_create_link(&device->backlight->dev.kobj,
>     &device->dev->dev.kobj, "device");
>=20
IMO, we should create one device for one display.
=46or example, device /sys/class/backlight/panel0 is created the first
time a backlight_ops for this display is registered.
And create the symbol link from the backlight class device to "physical
device" (device that invokes backlight_device_register) in the backligh=
t
class device driver, if we really need it.
Remove and recreate a link pointing to the new physical device when the
backlight mode is changed.

thanks,
rui

> It expects device to be registered (have dev.kobj) after calling
> backlight_device_register.
>=20
> So in summary we just can not do lazy registration. Every device
> passed to backlight_device_register has to be registered in that
> function or never.
>=20
> So I think we have to register every device and just keep symlink
> /sys/class/backlight/display_name pointing best device. We could
> register devices in
> 1) /sys/class/backlight/.devicename (hidden)
> 2) some /sys/class/internal-usage/devicename
>=20
> Do you agree on this?
>=20


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
