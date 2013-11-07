From: "Chen, Gong" <gong.chen@linux.intel.com>
Subject: Re: [patch 2/2] ACPI, extlog: remove unneeded NULL check
Date: Thu, 7 Nov 2013 02:22:30 -0500
Message-ID: <20131107072230.GA32127@gchen.bj.intel.com>
References: <20131105202007.GB3949@elgon.mountain>
 <4572462.cKQzNDzG5Z@vostro.rjw.lan>
 <CA+8MBb+5-o=XoWb61q7FkbhGK-LWTbRyxgSVK+Rb0a1U20nAcw@mail.gmail.com>
 <1904928.e3mTdgXtnf@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:41777 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751315Ab3KGHic (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 7 Nov 2013 02:38:32 -0500
Content-Disposition: inline
In-Reply-To: <1904928.e3mTdgXtnf@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Tony Luck <tony.luck@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, kernel-janitors@vger.kernel.org


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 07, 2013 at 01:09:38AM +0100, Rafael J. Wysocki wrote:
> Date: Thu, 07 Nov 2013 01:09:38 +0100
> From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> To: Tony Luck <tony.luck@gmail.com>
> Cc: Dan Carpenter <dan.carpenter@oracle.com>, Len Brown <lenb@kernel.org>,
>  Gong <gong.chen@linux.intel.com>, linux-acpi <linux-acpi@vger.kernel.org=
>,
>  kernel-janitors@vger.kernel.org
> Subject: Re: [patch 2/2] ACPI, extlog: remove unneeded NULL check
> User-Agent: KMail/4.10.5 (Linux/3.12.0-rc6+; KDE/4.10.5; x86_64; ; )
>=20
> On Wednesday, November 06, 2013 02:45:18 PM Tony Luck wrote:
> > On Wed, Nov 6, 2013 at 2:06 PM, Rafael J. Wysocki <rjw@rjwysocki.net> w=
rote:
> > > I'm wondering what kernel you have checked, because drivers/acpi/acpi=
_extlog.c
> > > is not present in the mainline or even in linux-next?
> >=20
> > It's in the "tip" tree ... and seems to be in next-20131106
>=20
> Well, OK.  Who's going to maintain this file?
>=20
> Rafael
>=20
It's me. I will maintain this file.

BTW, Dan

According to your codes, I think elog_addr check can be removed, too.
Can you send out a updated version?

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSez+2AAoJEI01n1+kOSLHlucP/057PRy404xYqHrOj3r9K2ds
yMYCBnivw0DYK+3FmyaANoYF53oKFMz/LLZQtee1Pbi5o/Np01Ta+4dmKJlis0Wq
MitMgP7ckdhTnBtFA9LsW/l2SXU5D3eOVMjY3I1wIjMAdwtND0ElYy6Ot0P6m6l6
mi3uzvZKtx/Xr/zirVAD8nDf8yv+Tlj+XmMfDmwSCpzqNFpkKoEm/DhXkiQwcML+
2oZLsCXYxZxHi96cyk8kO3ZUpOfSJrmk3nxgUyheN0796SQqkyef1EgByvb05OAL
dOdup++zAKFXYdrRJgjpP+amzDtRUdO9kQmMhq1aGzupCXaTuExJR3Jw8H0PNkxV
h2KuS9QFYx4fm/fxb+6iK1k88ZMFAbTVgU4CeYYBIqhal8oMxgu57cGGB7t6o1cR
6YIvKbytxSu+/Q25LzHm/NVSDA3wbKhokvuCq4p6FRFdfHgpuRcEdtt556ub7pvW
9UTzb5095kfo/zYZoquAvSLZwl78sB/81t1rndc5sA1l+XlN0/y5J18b0ltvxHKK
MMXtwsLFkwmCslSkIC4dumSkZXnMi7VUHoz94Q/vUuBdExRi3TBLSc7TzHateKYV
A87x+o+uqnvVBJ/47oZi4tukjsFrxK3bCQRl2NsT1AOOkPMO6IqHjuPIU0fUDk3J
hOoBbRp5XGnL7Hy1KFpU
=PR8M
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--
