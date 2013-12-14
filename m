From: "Chen, Gong" <gong.chen@linux.intel.com>
Subject: Re: [PATCH v3] ACPI, APEI: Cleanup alignment related codes for APEI
Date: Sat, 14 Dec 2013 08:41:44 -0500
Message-ID: <20131214134144.GA2823@gchen.bj.intel.com>
References: <20131114122956.GE13376@pd.tnic>
 <1384494356-4034-1-git-send-email-gong.chen@linux.intel.com>
 <20131116114803.GG18306@pd.tnic>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:39410 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753397Ab3LNOAB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 14 Dec 2013 09:00:01 -0500
Content-Disposition: inline
In-Reply-To: <20131116114803.GG18306@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: tony.luck@intel.com, linux-acpi@vger.kernel.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 16, 2013 at 12:48:03PM +0100, Borislav Petkov wrote:
> Date: Sat, 16 Nov 2013 12:48:03 +0100
> From: Borislav Petkov <bp@alien8.de>
> To: "Chen, Gong" <gong.chen@linux.intel.com>
> Cc: tony.luck@intel.com, linux-acpi@vger.kernel.org
> Subject: Re: [PATCH v3] ACPI, APEI: Cleanup alignment related codes for A=
PEI
> User-Agent: Mutt/1.5.21 (2010-09-15)
>=20
> On Fri, Nov 15, 2013 at 12:45:56AM -0500, Chen, Gong wrote:
> > We ever used *memcpy* to avoid access alignment issue between
> > firmware and OS. Now we can use a better and standard way
> > to avoid this issue. In the meanwhile, simplify some variable names
> > to avoid the limit of 80 characters per line and use structure
> > assignment instead of unnecessary memcpy. No functional changes.
> >=20
> > v3->v2: Fix an evaluation error.
> > v2->v1: Make description information clearer.
> >=20
> > Signed-off-by: Chen, Gong <gong.chen@linux.intel.com>
>=20
> Acked-by: Borislav Petkov <bp@suse.de>
>=20
> --=20
> Regards/Gruss,
>     Boris.
>=20
Hi, Boris

I notice that you sent a new RAS pull request. So will you pick up
this patch or miss it?

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSrGAYAAoJEI01n1+kOSLH+HAP/2vJiINrge0vgJIXLAWTFa49
gcPFO3QcsFngfg89G6cRc9ZjJNYOudZKlm/0cn1E2Urzlyu3ejuTGo6rN4ZmVNgT
rnIMahvnBH+qRv5gvnnrzjt2xYz2Ts3atdkNO8+qhQboDVOgzSSaqA88lMdzIgUn
jgrXwaT/aHqlUyYiB1LJ1gkTibCK5TsJRC0XZ4NyE/txhLcd2g4VlNQYXsE4Twk7
5KrDXNrKy9jMJYuZtirjQaAjVR2xqilFYq7LfeINL7DVznrs5MqZg1sba9q2akz+
huv3BbiGqwA6iIq7SQtCfC+HZ8aFMWX5pOLu9vYo4OIkpJ9ni6yye070RsZguH/4
v41O/RlauAIAuhOeWXISOjayLj8ZP9IzyYsiaKx8O/2hgOXJERGy85JSNF0awB1G
AuRBURNi/IXTYgvO5i3FzT0COH3m1IgUg1HoIewUkK6DwR3SHnB8rb4a9areBouv
rlMg1a0ocohf5upY894dqnmgNH7CLe/MV8Rsx+4tHvTwT/ohGQ53iEhfwfAkhTxt
wLRFDQOCT49Ty/pX/7k8jqUnNgiNSLwJx0hBf8Lw9r8IqLCEzhwi2R3JdHHSw3Uh
f+9p67LhPOsQx7kMh3j5UYkhEG/ibXY2Qtw52ZyUSYlzyC43Q7RKiPlyJlWOxiBd
nbstzISXwCnB4+TkIVar
=DFpG
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
