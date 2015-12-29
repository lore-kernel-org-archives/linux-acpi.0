From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 2/3] device property: the secondary fwnode needs to
 depend on the primary
Date: Tue, 29 Dec 2015 12:57:03 +0200
Message-ID: <1451386623.30729.353.camel@linux.intel.com>
References: <1450877684-76316-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1450877684-76316-3-git-send-email-andriy.shevchenko@linux.intel.com>
	 <20151229084020.GA19870@kuha.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:2557 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751198AbbL2K4o (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 29 Dec 2015 05:56:44 -0500
In-Reply-To: <20151229084020.GA19870@kuha.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org

On Tue, 2015-12-29 at 10:40 +0200, Heikki Krogerus wrote:
> Hi Andy,
>=20
> Found a bug from my code..
>=20
> > diff --git a/drivers/base/property.c b/drivers/base/property.c
> > index 0b22c8a..6c04d18 100644
> > --- a/drivers/base/property.c
> > +++ b/drivers/base/property.c
> > @@ -218,7 +218,7 @@ bool fwnode_property_present(struct
> > fwnode_handle *fwnode, const char *propname)
> > =C2=A0	bool ret;
> > =C2=A0
> > =C2=A0	ret =3D __fwnode_property_present(fwnode, propname);
> > -	if (ret =3D=3D false && fwnode->secondary)
> > +	if (ret =3D=3D false && fwnode && fwnode->secondary)
> > =C2=A0		ret =3D __fwnode_property_present(fwnode->secondary,=20
> > propname);
> > =C2=A0	return ret;
> > =C2=A0}
> > @@ -423,7 +423,7 @@
> > EXPORT_SYMBOL_GPL(device_property_match_string);
> > =C2=A0	int _ret_;						=09
> > 		\
> > =C2=A0	_ret_ =3D FWNODE_PROP_READ(_fwnode_, _propname_, _type_,
> > _proptype_,		\
> > =C2=A0				=C2=A0_val_, _nval_);		=09
> > 		\
> > -	if (_ret_ =3D=3D -EINVAL && _fwnode_->secondary)	=09
> > 			\
> > +	if (_ret_ =3D=3D -EINVAL && fwnode && _fwnode_->secondary)=09
> > 			\
>=20
> This should be .._fwnode_ && _fwnode_->secondary)

Yeah, we compiled it correctly due to fwnode presents in all
occurrences of this macro.

I will fix and resend a new version.

>=20
> > =C2=A0		_ret_ =3D FWNODE_PROP_READ(_fwnode_->secondary,
> > _propname_, _type_,	\
> > =C2=A0				_proptype_, _val_, _nval_);=09
> > 			\
> > =C2=A0	_ret_;						=09
> > 			\
>=20
>=20
> Cheers,
>=20

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
