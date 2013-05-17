From: Chen Gong <gong.chen@linux.intel.com>
Subject: Re: [PATCH 2/2] ACPI/APEI: Update einj documentation for
 param1/param2
Date: Fri, 17 May 2013 01:10:40 -0400
Message-ID: <20130517051040.GB30122@gchen.bj.intel.com>
References: <1368671347-22415-1-git-send-email-gong.chen@linux.intel.com>
 <1368671347-22415-3-git-send-email-gong.chen@linux.intel.com>
 <20130516110705.GD31373@pd.tnic>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="98e8jtXdkpgskNou"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:52184 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751490Ab3EQFQ6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 17 May 2013 01:16:58 -0400
Content-Disposition: inline
In-Reply-To: <20130516110705.GD31373@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: tony.luck@intel.com, linux-acpi@vger.kernel.org


--98e8jtXdkpgskNou
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2013 at 01:07:05PM +0200, Borislav Petkov wrote:
> Date: Thu, 16 May 2013 13:07:05 +0200
> From: Borislav Petkov <bp@alien8.de>
> To: Chen Gong <gong.chen@linux.intel.com>
> Cc: tony.luck@intel.com, linux-acpi@vger.kernel.org
> Subject: Re: [PATCH 2/2] ACPI/APEI: Update einj documentation for
>  param1/param2
> User-Agent: Mutt/1.5.21 (2010-09-15)
>=20
> On Wed, May 15, 2013 at 10:29:07PM -0400, Chen Gong wrote:
> > To ensure EINJ working well when injecting errors via EINJ
> > table, add some attentions for param1/param2.
> >=20
> > Signed-off-by: Chen Gong <gong.chen@linux.intel.com>
> > ---
> >  Documentation/acpi/apei/einj.txt |    8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/Documentation/acpi/apei/einj.txt b/Documentation/acpi/apei=
/einj.txt
> > index e20b6da..80c4ab2 100644
> > --- a/Documentation/acpi/apei/einj.txt
> > +++ b/Documentation/acpi/apei/einj.txt
> > @@ -47,11 +47,15 @@ directory apei/einj. The following files are provid=
ed.
> > =20
> >  - param1
> >    This file is used to set the first error parameter value. Effect of
> > -  parameter depends on error_type specified.
> > +  parameter depends on error_type specified. For exmaple, if error
> > +  type is memory relatd type, the param1 should be a valid physical
> > +  memory address.
> > =20
> >  - param2
> >    This file is used to set the second error parameter value. Effect of
> > -  parameter depends on error_type specified.
> > +  parameter depends on error_type specified. For example, if error
> > +  type is memory relatd type, the param2 should be a valid physical
> > +  memory address mask, say, 0xfffffffffffff000.
> > =20
> >  - notrigger
> >    The EINJ mechanism is a two step process. First inject the error, th=
en
>=20
> Please run those through the spell checker.
>=20
OK, I will(exmaple & relatd).

> Thanks.
>=20
> --=20
> Regards/Gruss,
>     Boris.
>=20
> Sent from a fat crate under my desk. Formatting is fine.
> --

--98e8jtXdkpgskNou
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRlbvPAAoJEI01n1+kOSLHHagP/3AHQPwLcyOpNnp9omC4HF0y
3Kb2iqu1DVo1USesdeP9zraQZ1H/uIXPVwzNNeOnd3ojcb40/atlX0fi9GNPeCDN
uT8PZWPEq3/dtVVRAc4MkyUQ5MLB0E1jH2I4wfyro5T05J2VcqhIH5f3pCXrH9pN
l9ce1Ube3QYfMgaX0faU9bb82JOrnrA/geJeUApNjwQQni7VLleUlGWUawrCafbo
457UfTFn73viTdUzDHNvpJk+JFcUsGeuWRf66S4xpYdt+OdZHQD4nhuAgN/ikzpk
mkUJ6b98QEL3x1/epNuJR4Hr8JLpuB7GTLFC/F3uduKBEihjee+1LVtWpLIMdac8
zEjuUztBw+HkCzVbgQxqq8gxQalUFOFvhIoU46Q5sDocyIji9Z8d51H8ZBNYmevN
VcmFM8ejxqj6vLIJTnRwKzAFwNWuYBxzhIZzYn+rHwbg2zaZVG3RdUj4Moz/i2ki
twFkGQFcOwfUPo4+z9L/vzjypRl4/YL36QNCcPLs8uQJOPIAmh1MxR334KY2RtPR
gZheCFRJFQe3Q1vGy/tyy+b5436fgn6ZttN74J50v/xwafYnZe2t+glB2HjRp9Me
bMVt91t2ps8lD1uaz21hrw9a918OVEzqmJP8J745LpIHH6snNUTzpEW2TsqLMzPh
rUUo6cC7TFTCbFznQ8cy
=+xJb
-----END PGP SIGNATURE-----

--98e8jtXdkpgskNou--
