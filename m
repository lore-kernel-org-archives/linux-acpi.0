From: "Chen, Gong" <gong.chen@linux.intel.com>
Subject: Re: [PATCH 3/7 v4] CPER: Adjust code flow of some functions
Date: Mon, 26 May 2014 06:42:21 -0400
Message-ID: <20140526104221.GA20940@gchen.bj.intel.com>
References: <1400142646-10127-1-git-send-email-gong.chen@linux.intel.com>
 <1400142646-10127-4-git-send-email-gong.chen@linux.intel.com>
 <20140521110521.GF21205@pd.tnic>
 <20140521235159.GB1644@gchen.bj.intel.com>
 <20140522105242.GG4383@pd.tnic>
 <20140523014910.GB16945@gchen.bj.intel.com>
 <20140523093703.GB21332@pd.tnic>
 <20140523101143.GC21332@pd.tnic>
 <20140526015944.GA31035@gchen.bj.intel.com>
 <20140526102151.GE25732@pd.tnic>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:42201 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752314AbaEZLJz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 26 May 2014 07:09:55 -0400
Content-Disposition: inline
In-Reply-To: <20140526102151.GE25732@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: tony.luck@intel.com, m.chehab@samsung.com, linux-acpi@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 26, 2014 at 12:21:51PM +0200, Borislav Petkov wrote:
> Date: Mon, 26 May 2014 12:21:51 +0200
> From: Borislav Petkov <bp@alien8.de>
> To: "Chen, Gong" <gong.chen@linux.intel.com>
> Cc: tony.luck@intel.com, m.chehab@samsung.com, linux-acpi@vger.kernel.org
> Subject: Re: [PATCH 3/7 v4] CPER: Adjust code flow of some functions
> User-Agent: Mutt/1.5.23 (2014-03-12)
>=20
> On Sun, May 25, 2014 at 09:59:44PM -0400, Chen, Gong wrote:
> > On Fri, May 23, 2014 at 12:11:43PM +0200, Borislav Petkov wrote:
> > > +	TP_printk("%d %s error: %s %s %llx (mask lsb: %x), %s%s",
> > What if pa_mask_lsb not existing?
>=20
> Then you make it the default which says that all bits in the mask are
> invalid: -1, i.e. 255.
>=20
> This becomes part of the interface then, just like phys_addr is
> 0xfffff... ,i.e. -1 in the invalid case.
>=20
OK, fine to me. I will update it soon.

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTgxqNAAoJEI01n1+kOSLH0KgP/itmuZnJbepFQkQF4FLIUsJZ
161zTwRMghnywihETsvMuIBJ3vcz5m4CXnOpnTYDrBO6TT77rlemB7Zr9Q5D3nkj
ovkwSAY7+qewR3V0zFPJwOMb7M9MynvW+P/sYOqxH6SzC7KyHg7Z7Mor29+ZDPSl
WKH5TzI99QBSsoWKPOeXW79L5rEj8OmbqqgtA36FYxaJ0Q4c/R6V2nZDANwEs7dA
cP48nTGo7TbHjHeyK3vVFoWMz0NM+k+0EgGnPHFUvwD6TeDic5dNKxPPQ1eb1LdX
wZlRiRv/7FX7ygvgFJMjgVHiqxngh/F8B777zM4DlZFUTJk77/YJvbgQl1Hrin7p
edRMZ6Z750w5cLqn51n2tnN3KwCOQde+TAupIE/68G07zXokQ4F00hEd/JfaHI6j
JjnGBgeYQDZsah7G3uyJ47T5EERDfRQgaztlzDO0LeWVdROZiXhVStPSE3zbjJbo
MvcU17NXQ001p5DcuofD070fJXY2yh5Hp6W4cYMgmh3+Ro1FNotnEy5/uHS3s1Ao
rq9d+0M70IenRhoVNqHeP9TrTIWey3/VdlP3iWrZx+G50yFA2uP1HzEZO1e4iAKq
ZLA1NIeIlQbvMXFDvctWBIU72VG+r+7FUgOnWn8com2cm4kCOIlqK5ait0kFgoA1
EdjoDDTcgE8BTJafqtSo
=zyhr
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
