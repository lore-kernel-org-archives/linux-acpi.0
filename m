From: "Chen, Gong" <gong.chen@linux.intel.com>
Subject: Re: [PATCH v2 1/2] ACPI, APEI, GHES: Remove strict check for memory
 error handling
Date: Mon, 16 Dec 2013 09:40:49 -0500
Message-ID: <20131216144049.GC8397@gchen.bj.intel.com>
References: <1385363701-12387-1-git-send-email-gong.chen@linux.intel.com>
 <529463BD.3070305@linux.vnet.ibm.com>
 <20131126093136.GA27271@gchen.bj.intel.com>
 <20131214134256.GC2823@gchen.bj.intel.com>
 <20131216145129.GA9683@pd.tnic>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3siQDZowHQqNOShm"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:39449 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754222Ab3LPPAA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 16 Dec 2013 10:00:00 -0500
Content-Disposition: inline
In-Reply-To: <20131216145129.GA9683@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, tony.luck@intel.com, linux-acpi@vger.kernel.org


--3siQDZowHQqNOShm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2013 at 03:51:29PM +0100, Borislav Petkov wrote:
> Date: Mon, 16 Dec 2013 15:51:29 +0100
> From: Borislav Petkov <bp@alien8.de>
> To: "Chen, Gong" <gong.chen@linux.intel.com>
> Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, tony.luck@intel.co=
m,
>  linux-acpi@vger.kernel.org
> Subject: Re: [PATCH v2 1/2] ACPI, APEI, GHES: Remove strict check for
>  memory error handling
> User-Agent: Mutt/1.5.21 (2010-09-15)
>=20
> On Sat, Dec 14, 2013 at 08:42:56AM -0500, Chen, Gong wrote:
> > Will you pick up this patch in your RAS request pull?
>=20
> Applied, with commit message massaging and s/corrected/severity/
> automatic variable change, version below:
>=20
Thanks very much for your effort.

--3siQDZowHQqNOShm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSrxDxAAoJEI01n1+kOSLH2ZgP/1U3U+tOLzYkacrWLCE6irVf
e9svHQJigJDzI0obCW/Wh0OrB1MBBq9lvzkhDH0F+e0yojlhaHKQsGw803QRC04e
rjX0bNQCs3Q/Uf+IYb8VjqGh+ZEev+OG0xTyucipHUffBeRL7S3q601UpQaFR4cX
xkmDY715x5TtjNNZGnHSZw7GYO8WAf2xXkHP++RmHGMHCHF1/L0Qslx+8cw6+fuz
ruKg2/vwis0eQ2J6MJorNcKvKlzlrknv5xUQE6nJvumjTzHkis3yjEGDJSmNzOpi
YCmKqQv/8uxmvqEoUkx0ltWcpFrNZK9+8+JmJg85O4J0GGzD0+xGt+iwdcRbfdQV
Sz4taZa5NyPZHSqFgNfpCm4sdU1dOMoYicNF4mGsLHor7MMmFpTwgZRtqB9CK3Ma
Kg8WafYUxoLC+gp4dVG/HXvSpOI5sw8GIX0ZWAMNVC+S64n19OZYMS7SRm5+/Itg
EfsGt1LbXP8hlxN+e0TRiWBpVwGYsBQncLTbF+7et78Zz8zctjgIHVbpIp1Cumkn
U7rzEZaMP4Oaq39wMdMjLXyeV6OngD8OaJSlzlFx8bAloLzO31fjtoD0IdVDQxM3
CXbmtjGC6aIEpM8VuK+V/YBi3iVXFOeUzy8OJSUSyMxtsHNr7YzgThn0O1FaqS4Z
oquTi6nzOtCw5lQTzolY
=xx8n
-----END PGP SIGNATURE-----

--3siQDZowHQqNOShm--
