From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 1/3] device property: add spaces to
 PROPERTY_ENTRY_STRING macro
Date: Mon, 28 Dec 2015 13:24:13 +0200
Message-ID: <1451301853.30729.326.camel@linux.intel.com>
References: <1450877684-76316-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1450877684-76316-2-git-send-email-andriy.shevchenko@linux.intel.com>
	 <4285778.gtB2L18Hsx@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:43473 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751004AbbL1LX4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 28 Dec 2015 06:23:56 -0500
In-Reply-To: <4285778.gtB2L18Hsx@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, heikki.krogerus@linux.intel.com, linux-acpi@vger.kernel.org

On Mon, 2015-12-28 at 02:12 +0100, Rafael J. Wysocki wrote:
> On Wednesday, December 23, 2015 03:34:42 PM Andy Shevchenko wrote:
> > Just a style fix, no functional changes.
> >=20
> > To be folded to Andrew's patch.
>=20
> What patch?

In linux-next from Andrew:

e39ece7 include-linux-propertyh-fix-build-issues-with-gcc-444-fix
40bb8a1 include/linux/property.h: fix build issues with gcc-4.4.4

>=20
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> > =C2=A0include/linux/property.h | 2 +-
> > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/include/linux/property.h b/include/linux/property.h
> > index b8c4e42..b51fcd3 100644
> > --- a/include/linux/property.h
> > +++ b/include/linux/property.h
> > @@ -230,7 +230,7 @@ struct property_entry {
> > =C2=A0	.name =3D _name_,					\
> > =C2=A0	.length =3D sizeof(_val_),			\
> > =C2=A0	.is_string =3D true,				\
> > -	{ .value =3D {.str =3D _val_} },			\
> > +	{ .value =3D { .str =3D _val_ } },			\
> > =C2=A0}
> > =C2=A0
> > =C2=A0#define PROPERTY_ENTRY_BOOL(_name_)		\
> >=20
>=20
> Thanks,
> Rafael
>=20

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
