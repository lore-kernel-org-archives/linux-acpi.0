From: Igor Gnatenko <i.gnatenko.brain@gmail.com>
Subject: Re: [Update][PATCH] ACPI / video / i915: Remove ACPI backlight if
 firmware expects Windows 8
Date: Wed, 17 Jul 2013 09:16:38 +0400
Message-ID: <1374038198.1884.1.camel@ThinkPad-X230.localdomain>
References: <1370818899-8595-1-git-send-email-matthew.garrett@nebula.com>
	 <1373981554.1956.5.camel@ThinkPad-X230.localdomain>
	 <1373994495.9314.1.camel@x230> <2132122.eIEvjmIrrj@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:48186 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751112Ab3GQFQo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 17 Jul 2013 01:16:44 -0400
In-Reply-To: <2132122.eIEvjmIrrj@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Matthew Garrett <matthew.garrett@nebula.com>, Aaron Lu <aaron.lwe@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>, "seth.forshee@canonical.com" <seth.forshee@canonical.com>, "joeyli.kernel@gmail.com" <joeyli.kernel@gmail.com>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>

On Wed, 2013-07-17 at 00:01 +0200, Rafael J. Wysocki wrote:
> On Tuesday, July 16, 2013 05:08:16 PM Matthew Garrett wrote:
> > On Tue, 2013-07-16 at 17:32 +0400, Igor Gnatenko wrote:
> > > Hmm. I found regression in user-space. In GNOME (maybe and other =
DEs) we no longer see switch status of backlight.
> >=20
> > Yeah, I can duplicate that. Rafael, we have to call
> > acpi_video_init_brightness() even if we're not going to initialise =
the
> > backlight - Thinkpads seem to use this as the trigger for enabling =
ACPI
> > notifications rather than handling it in firmware. This seems to do=
 the
> > job:
>=20
> Igor, does this additional patch from Matthew help?
Yes. With this patch I have backlight switch indicator on my ThinkPad X=
230.
>=20
> Rafael
>=20
>=20
Tested-by: Igor Gnatenko <i.gnatenko.brain@gmail.com>
> > diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
> > index 01b1a25..71865f7 100644
> > --- a/drivers/acpi/video.c
> > +++ b/drivers/acpi/video.c
> > @@ -900,6 +900,9 @@ static void acpi_video_device_find_cap(struct
> > acpi_video_device *device)
> >  		device->cap._DDC =3D 1;
> >  	}
> > =20
> > +	if (acpi_video_init_brightness(device))
> > +		return;
> > +
> >  	if (acpi_video_verify_backlight_support()) {
> >  		struct backlight_properties props;
> >  		struct pci_dev *pdev;
> > @@ -909,9 +912,6 @@ static void acpi_video_device_find_cap(struct
> > acpi_video_device *device)
> >  		static int count =3D 0;
> >  		char *name;
> > =20
> > -		result =3D acpi_video_init_brightness(device);
> > -		if (result)
> > -			return;
> >  		name =3D kasprintf(GFP_KERNEL, "acpi_video%d", count);
> >  		if (!name)
> >  			return;
> >=20
> >=20
> > --=20
> > Matthew Garrett | mjg59@srcf.ucam.org
> >=20
--=20
Igor Gnatenko
=46edora release 19 (Schr=C3=B6dinger=E2=80=99s Cat)
Linux 3.11.0-0.rc0.git7.1.fc20.x86_64

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
