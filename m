From: "Chen, Gong" <gong.chen@linux.intel.com>
Subject: Re: [PATCH v3] ACPI, APEI: Cleanup alignment related codes for APEI
Date: Tue, 17 Dec 2013 00:34:52 -0500
Message-ID: <20131217053451.GB11278@gchen.bj.intel.com>
References: <20131114122956.GE13376@pd.tnic>
 <1384494356-4034-1-git-send-email-gong.chen@linux.intel.com>
 <20131216141906.GC4922@pd.tnic>
 <20131216143934.GB8397@gchen.bj.intel.com>
 <20131216175551.GD9683@pd.tnic>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MfFXiAuoTsnnDAfZ"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:29216 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751118Ab3LQFxQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 17 Dec 2013 00:53:16 -0500
Content-Disposition: inline
In-Reply-To: <20131216175551.GD9683@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: tony.luck@intel.com, linux-acpi@vger.kernel.org


--MfFXiAuoTsnnDAfZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2013 at 06:55:51PM +0100, Borislav Petkov wrote:
> Date: Mon, 16 Dec 2013 18:55:51 +0100
> From: Borislav Petkov <bp@alien8.de>
> To: tony.luck@intel.com, linux-acpi@vger.kernel.org, "Chen, Gong"
>  <gong.chen@linux.intel.com>
> Subject: Re: [PATCH v3] ACPI, APEI: Cleanup alignment related codes for A=
PEI
> User-Agent: Mutt/1.5.21 (2010-09-15)
>=20
> On Mon, Dec 16, 2013 at 09:39:34AM -0500, Chen, Gong wrote:
> > erst record id cache is implemented in the memory to increase the
> > access speed via caching ERST content, so it doesn't matter with
> > firmware access.
>=20
> So what's with the memcpy in __erst_record_id_cache_add_one()?
>=20
I think you mean
=2E..
                memcpy(new_entries, entries,
                       erst_record_id_cache.len *
                       sizeof(entries[0]));
=2E..                      =20

It is a copy from one integer array to another one(from old ID array
to new bigger ID array), so I can't use a simple evaluation to get this goa=
l.

--MfFXiAuoTsnnDAfZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSr+J7AAoJEI01n1+kOSLHij8QAKpDQQtghPG0lzI4hlgYBFt9
oNsC/713xdso4FcnlaVUuICU69M8Y0/nHXxy+0lR1ucNXBhYD5RlA6l+SjZOtZdr
O2nq2jprjmkZ+o3Tkwh6eslHOtUG4+dAoVKHPsdNWGla0wMtQxgZSEqBhs+hW5Zn
Y6AfLVRbtKPoICYcssma++J+m3isusYjrMEgd4xRUPyG8RbnzfmZSzO/5eVWk1IV
WCGlEj7BnU0K6l1qDlz6Mg+UEDA9viBRmZg5oiNlbsuZsN288C0YDd437trOquMv
Apz35P51lknJTgaSlXi9FBfUQ/wSajrc4kNOZ44yhhsSwaRizUSkfVZCT1Us2zuq
3pHNsW2fBXsIglZuvJsfhbKai6CQMDauoY+c9thK0ZwCjgWk35WEFww/yfLcMRTz
XAPBitQUNyS5+7s4Ica4g8AuBMHYsauzumZ1pvst2YiW0zk7nKxtaJ9BYi3B8bLV
W9njOOrbe3w7Rx/gosANVR47ntJYRS8VFbhOErWp/CwaD3tAwCGHt7TVdCZxhik/
JlXFyLoMOwRWArNTIfRG86QJ/ragHeBbCoC6yEqbXg00YpOjN4knQtNcHe1OhM1j
/hjJ6zcC01sXtCpXosZOeUefdFcMY2AOccR50+S8mpv/HJRWSFTFgrMU9tQX4UEx
aCSNgrqxDUGLUONl3fFs
=Zp+U
-----END PGP SIGNATURE-----

--MfFXiAuoTsnnDAfZ--
