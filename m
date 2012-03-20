From: joeyli <jlee@suse.com>
Subject: Re: [PATCH] video: add quirk table for video backlight vendor mode
Date: Tue, 20 Mar 2012 11:49:19 +0800
Message-ID: <1332215359.10557.289.camel@linux-s257.site>
References: <1332137027-28327-1-git-send-email-jlee@suse.com>
	 <20120319133129.GA413@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nat.nue.novell.com ([195.135.221.2]:47681 "EHLO
	nat.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758019Ab2CTDvG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 19 Mar 2012 23:51:06 -0400
In-Reply-To: <20120319133129.GA413@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, Thomas Renninger <trenn@suse.de>

Hi Matthew,=20

=E6=96=BC =E4=B8=80=EF=BC=8C2012-03-19 =E6=96=BC 13:31 +0000=EF=BC=8CMa=
tthew Garrett =E6=8F=90=E5=88=B0=EF=BC=9A
> On Mon, Mar 19, 2012 at 02:03:47PM +0800, Lee, Chun-Yi wrote:
>=20
> > diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detec=
t.c
> > index f3f0fe7..acb15d6 100644
> > --- a/drivers/acpi/video_detect.c
> > +++ b/drivers/acpi/video_detect.c
> > @@ -132,6 +132,32 @@ find_video(acpi_handle handle, u32 lvl, void *=
context, void **rv)
> >  	return AE_OK;
> >  }
> > =20
> > +static int video_set_backlight_vendor(const struct dmi_system_id *=
d)
> > +{
> > +	acpi_video_support |=3D ACPI_VIDEO_BACKLIGHT_DMI_VENDOR;
> > +	return 0;
> > +}
> > +
> > +static const struct dmi_system_id video_vendor_dmi_table[] =3D {
> > +	{
> > +	 .callback =3D video_set_backlight_vendor,
> > +	 .ident =3D "Acer Aspire 4736",
> > +	 .matches =3D {
> > +		DMI_MATCH(DMI_BOARD_VENDOR, "Acer"),
> > +		DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 4736"),
> > +		},
> > +	},
> > +	{
> > +	 .callback =3D video_set_backlight_vendor,
> > +	 .ident =3D "Acer TravelMate 4750",
> > +	 .matches =3D {
> > +		DMI_MATCH(DMI_BOARD_VENDOR, "Acer"),
> > +		DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate 4750"),
> > +		},
> > +	},
> > +	{}
> > +};
> > +
>=20
> I think it would be neater to put this in the Acer driver and have it=
=20
> call unregister_acpi_video().
>=20

Thanks for your review and suggestion.
I will send out a new patch for acer-wmi.


Thanks a lot!
Joey Lee


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
