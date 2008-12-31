From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 1/2] video: always update the brightness when poking
	"brightness"
Date: Wed, 31 Dec 2008 10:58:48 +0800
Message-ID: <1230692328.562.289.camel@rzhang-dt>
References: <1230088058.562.219.camel@rzhang-dt>
	 <1230633250.5328.8.camel@dax.rpnet.com>
	 <1230687781.562.249.camel@rzhang-dt> <20081231020146.GA24861@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:33376 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755932AbYLaDBa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 30 Dec 2008 22:01:30 -0500
In-Reply-To: <20081231020146.GA24861@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Richard Purdie <rpurdie@rpsys.net>, linux-acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Wed, 2008-12-31 at 10:01 +0800, Matthew Garrett wrote:
> On Wed, Dec 31, 2008 at 09:43:01AM +0800, Zhang Rui wrote:
>=20
> > then how about this case:
> > =EF=BB=BF1. set the brightness level to 5 via sysfs I/F
> > 2. set the backlight to another level via HOTKEYS.
> > 3. setting it back to 5 doesn't work because bd->props.brightness
> > is still 5.
>=20
> If they're using the ACPI interface then video.c should update=20
> props.brightness itself.
>=20
> > IMO, the real problem is that bd->props.brightness doesn't reflect =
the
> > actual brightness.
>=20
> If you want the actual brightness, why aren't you reading=20
> actual_brightness?
>=20
right, that's the problem.
because IMO, we don't need the actual_brightness any more. :)
And if you agree that =EF=BB=BFbd->props.brightness doesn't reflect the=
 actual
brightness, we can see that
                        if (bd->props.brightness !=3D brightness) {
                                bd->props.brightness =3D brightness;
                                backlight_update_status(bd);
                        }
doesn't make sense because =EF=BB=BF"bd->props.brightness !=3D brightne=
ss" doesn't
mean anything.

But if =EF=BB=BFbd->props.brightness does reflect the actual brightness=
, then do
we need "actual_brightness" any more?

=EF=BB=BF
> If they're using the ACPI interface then video.c should update=20
> props.brightness itself.
that also makes sense, patch attached.
But anyway, we still need some changes in the video backlight class.
right?

=46rom: Zhang Rui <rui.zhang@intel.com>
Subject: always update =EF=BB=BFprops.brightness when brightness is cha=
nged

always update pros.brightness no matter the backlight is changed
via procfs, hotkeys or sysfs.

Sighed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/video.c |    5 +++++
 1 file changed, 5 insertions(+)

Index: linux-2.6/drivers/acpi/video.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/drivers/acpi/video.c
+++ linux-2.6/drivers/acpi/video.c
@@ -481,6 +481,7 @@ acpi_video_device_lcd_set_level(struct a
 	int status =3D AE_OK;
 	union acpi_object arg0 =3D { ACPI_TYPE_INTEGER };
 	struct acpi_object_list args =3D { 1, &arg0 };
+	int state;
=20
=20
 	arg0.integer.value =3D level;
@@ -489,6 +490,10 @@ acpi_video_device_lcd_set_level(struct a
 		status =3D acpi_evaluate_object(device->dev->handle, "_BCM",
 					      &args, NULL);
 	device->brightness->curr =3D level;
+	for (state =3D 2; state < device->brightness->count; state++)
+		if (level =3D=3D device->brightness->levels[state])
+			device->backlight->props.brightness =3D state - 2;
+
 	return status;
 }
=20


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
