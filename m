From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [RFC PATCH 1/5] ACPI video: check the return value of
	acpi_video_device_lcd_get_level_current
Date: Thu, 12 Mar 2009 14:28:32 +0800
Message-ID: <1236839312.2807.12.camel@rzhang-dt>
References: <1236672205.2820.119.camel@rzhang-dt>
	 <200903111356.01710.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:22526 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750949AbZCLG1f (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 12 Mar 2009 02:27:35 -0400
In-Reply-To: <200903111356.01710.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>

On Wed, 2009-03-11 at 20:56 +0800, Thomas Renninger wrote:
> On Tuesday 10 March 2009 09:03:25 Zhang Rui wrote:
> > Subject: check the return value of=20
> acpi_video_device_lcd_get_level_current
> > From: Zhang Rui <rui.zhang@intel.com>
> >=20
> > check the return value of acpi_video_device_lcd_get_level_current
> >=20
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > ---
> >  drivers/acpi/video.c |   69=20
> ++++++++++++++++++++++++++++++++++-----------------
> >  1 file changed, 47 insertions(+), 22 deletions(-)
> >=20
> > Index: linux-2.6/drivers/acpi/video.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-2.6.orig/drivers/acpi/video.c
> > +++ linux-2.6/drivers/acpi/video.c
> > @@ -502,11 +505,29 @@ static int
> >  acpi_video_device_lcd_get_level_current(struct acpi_video_device=20
> *device,
> >  					unsigned long long *level)
> >  {
> > -	if (device->cap._BQC)
> > -		return acpi_evaluate_integer(device->dev->handle, "_BQC", NULL,
> > -					     level);
> > +	acpi_status status =3D AE_OK;
> > +
> > +	if (device->cap._BQC) {
> > +		status =3D acpi_evaluate_integer(device->dev->handle, "_BQC",
> > +						NULL, level);
> > +		if (ACPI_SUCCESS(status)) {
> > +			device->brightness->curr =3D *level;
> > +			return 0;
> > +		} else {
> > +			/* Fixme:
> > +			 * should we return an error or ignore this failure?
> > +			 * dev->brightness->curr is a cached value which stores
> > +			 * the correct current backlight level in most cases.
> > +			 * ACPI video backlight still works w/ buggy _BQC.
> > +			 * http://bugzilla.kernel.org/show_bug.cgi?id=3D12233
> > +			 */
> I wonder what should go wrong there at all.
> We should add a warning (using printk(.. FW_BUG...)) if we do ACPI vi=
deo=20
> brightness switching without _BQC. This should be supported, but is a=
=20
> firmware bug and likely fails.
I think we should do it in video_detect.c
a simple patch like this:

---
 drivers/acpi/video_detect.c |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-2.6/drivers/acpi/video_detect.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/drivers/acpi/video_detect.c
+++ linux-2.6/drivers/acpi/video_detect.c
@@ -55,6 +55,8 @@ acpi_backlight_cap_match(acpi_handle han
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found generic backlight "
 				  "support\n"));
 		*cap |=3D ACPI_VIDEO_BACKLIGHT;
+		if (ACPI_FAILURE(acpi_get_handle(handle, "_BQC", &h_dummy)))
+			printk(KERN_WARNING FW_BUG "No _BQC available\n");
 		/* We have backlight support, no need to scan further */
 		return AE_CTRL_TERMINATE;
 	}

But the ACPI warning here is still needed, because the _BQC method is
implemented but there are some errors when evaluating it.

> (BTW, I recently saw a BIOS with _BCQ function. They said they are go=
ing to=20
> fix it, but it may be more widespread, e.g. this also is often the ca=
se=20
> (missing _BQC) on Samsung). I found it by luck disassembling and=20
> recompiling the DSDT, a runtime warning would be nice (if it does not=
=20
> already exist).
Interesting, if this is tree, we can add the support for _BCQ in a
separate patch.
BTW: could you please attach the acpidump of that box please because I
never noticed this problem before. :)

> Anyway, if we have _BQC (cap._BQC), evaluation should not fail?
> Ok, double checking is always a good idea...
>=20
No, evaluating _BQC may return fail, like the one in bug 12233,
        Method (_BQC, 0, NotSerialized)
        {
            And (\_SB.PCI0.LPCB.FJEX.GBLS, 0xFF, Local0)
            Return (DerefOf (Index (BCLP, Add (Local0, 0x02))))
        }
but =EF=BB=BF\_SB.PCI0.LPCB.FJEX.GBLS doesn't exist at all...

> > +			ACPI_WARNING((AE_INFO, "Evaluating _BQC failed"));
> > +			device->cap._BQC =3D 0;
> > +		}
> > +	}
> > +
> >  	*level =3D device->brightness->curr;
> > -	return AE_OK;
> > +	return 0;
> >  }
> > =20
> >  static int
> > @@ -773,18 +794,8 @@ static void acpi_video_device_find_cap(s
> >  		device->backlight =3D backlight_device_register(name,
> >  			NULL, device, &acpi_backlight_ops);
> >  		device->backlight->props.max_brightness =3D device->brightness->=
count-3;
> > -		/*
> > -		 * If there exists the _BQC object, the _BQC object will be
> > -		 * called to get the current backlight brightness. Otherwise
> > -		 * the brightness will be set to the maximum.
> > -		 */
> > -		if (device->cap._BQC)
> > -			device->backlight->props.brightness =3D
> > -				acpi_video_get_brightness(device->backlight);
> > -		else
> > -			device->backlight->props.brightness =3D
> > -				device->backlight->props.max_brightness;
> > -		backlight_update_status(device->backlight);
> > +		device->backlight->props.brightness =3D
> > +			acpi_video_get_brightness(device->backlight);
> I could imagine this introduces a regression on machines without _BQC=
=2E
> IIRC the value which brightness is currently active must be initializ=
ed if=20
> there is no _BQC function and that seems to happen here.
>=20
right, this should probably be done in patch 5.
where we have set the backlight in acpi_video_init_brightness already.

thanks,
rui

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
