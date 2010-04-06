From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 02/12] ACPI / PM: Move ACPI video resume to a PM notifier
Date: Tue, 6 Apr 2010 20:55:43 +0200
Message-ID: <201004062055.43290.rjw@sisk.pl>
References: <1270537583-8756-1-git-send-email-lenb@kernel.org>  <c8cf3a14a6615e06504664cd50ca90baa5f2ef7d.1270537380.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:33159 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757084Ab0DFSwY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Apr 2010 14:52:24 -0400
In-Reply-To: <c8cf3a14a6615e06504664cd50ca90baa5f2ef7d.1270537380.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>, Zhang Rui <rui.zhang@intel.com>

On Tuesday 06 April 2010, Len Brown wrote:
> From: Rafael Wysocki <rjw@sisk.pl>
>=20
> There is a problem with the ACPI video resume routine that it's
> executed before the GPU that may be accessed by it.  To fix this
> issue, move the ACPI video resume to a power management notifier,
> so that it's executed after resuming all devices, including the GPU.
>=20
> http://bugzilla.kernel.org/show_bug.cgi?id=3D15096
>=20
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> Acked-by: Matthew Garrett <mjg@redhat.com>
> Tested-by: Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com>
> Signed-off-by: Len Brown <len.brown@intel.com>

Thanks, but this requires the appended patch on top.

I sent a replacement version yesterday,
https://patchwork.kernel.org/patch/90593/, but you haven't received it,
apparently.

Rafael

---
=46rom: Rafael J. Wysocki <rjw@sisk.pl>
Subject: ACPI / video: Save initial backlight brightness in props

The initial backlight brightness has to be written to
device->backlight->props in case it has to be restored before
there's a chance to call acpi_video_device_lcd_set_level().

Something like this happens during boot, when the kernel checks if
a hibernation image is present and executes power management
notifiers (in either case).  One of these notifiers tries to restore
the previous brightness level, but this won't work if the initial
brightness is not saved by acpi_video_device_find_cap().

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/video.c |    7 +++++++
 1 file changed, 7 insertions(+)

Index: linux-2.6/drivers/acpi/video.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/drivers/acpi/video.c
+++ linux-2.6/drivers/acpi/video.c
@@ -1020,6 +1020,13 @@ static void acpi_video_device_find_cap(s
 		if (IS_ERR(device->backlight))
 			return;
=20
+		/*
+		 * Save current brightness level in case we have to restore it
+		 * before acpi_video_device_lcd_set_level() is called next time.
+		 */
+		device->backlight->props.brightness =3D
+				acpi_video_get_brightness(device->backlight);
+
 		result =3D sysfs_create_link(&device->backlight->dev.kobj,
 					   &device->dev->dev.kobj, "device");
 		if (result)
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
