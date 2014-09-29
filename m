From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] dell-wmi: Fix access out of memory
Date: Tue, 30 Sep 2014 01:26:03 +0200
Message-ID: <3073358.myrKz9QbdW@vostro.rjw.lan>
References: <1411996251-13455-1-git-send-email-pali.rohar@gmail.com> <20140929213028.GB34181@vmdeb7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:55734 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751946AbaI2XGK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Sep 2014 19:06:10 -0400
In-Reply-To: <20140929213028.GB34181@vmdeb7>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Matthew Garrett <mjg59@srcf.ucam.org>, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Monday, September 29, 2014 02:30:29 PM Darren Hart wrote:
> On Mon, Sep 29, 2014 at 03:10:51PM +0200, Pali Roh=C3=A1r wrote:
> > Without this patch driver dell-wmi is trying to access elements of =
dynamically
> > allocated array without checking array size. This can lead to memor=
y corruption
> > or kernel panic. This patch adds missing checks for array size.
> >=20
> > Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
>=20
> Looks good to me. Rafael, any concerns?

Not anything obvious.

>=20
> Cc: linux-acpi

Thanks!


> > ---
> > This patch should be probably applied to stable kernel trees as it =
fixing
> > possible memory corruption.
> > ---
> >  drivers/platform/x86/dell-wmi.c |   12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/platform/x86/dell-wmi.c b/drivers/platform/x86=
/dell-wmi.c
> > index 390e8e3..25721bf 100644
> > --- a/drivers/platform/x86/dell-wmi.c
> > +++ b/drivers/platform/x86/dell-wmi.c
> > @@ -163,18 +163,24 @@ static void dell_wmi_notify(u32 value, void *=
context)
> >  		const struct key_entry *key;
> >  		int reported_key;
> >  		u16 *buffer_entry =3D (u16 *)obj->buffer.pointer;
> > +		int buffer_size =3D obj->buffer.length/2;
> > =20
> > -		if (dell_new_hk_type && (buffer_entry[1] !=3D 0x10)) {
> > +		if (buffer_size >=3D 2 && dell_new_hk_type && buffer_entry[1] !=3D=
 0x10) {
> >  			pr_info("Received unknown WMI event (0x%x)\n",
> >  				buffer_entry[1]);
> >  			kfree(obj);
> >  			return;
> >  		}
> > =20
> > -		if (dell_new_hk_type || buffer_entry[1] =3D=3D 0x0)
> > +		if (buffer_size >=3D 3 && (dell_new_hk_type || buffer_entry[1] =3D=
=3D 0x0))
> >  			reported_key =3D (int)buffer_entry[2];
> > -		else
> > +		else if (buffer_size >=3D 2)
> >  			reported_key =3D (int)buffer_entry[1] & 0xffff;
> > +		else {
> > +			pr_info("Received unknown WMI event\n");
> > +			kfree(obj);
> > +			return;
> > +		}
> > =20
> >  		key =3D sparse_keymap_entry_from_scancode(dell_wmi_input_dev,
> >  							reported_key);
>=20
>=20

--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
