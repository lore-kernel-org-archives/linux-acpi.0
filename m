From: "Chen, Gong" <gong.chen@linux.intel.com>
Subject: Re: [PATCH 6/7 v3] trace, eMCA: Add a knob to adjust where to save
 event log
Date: Wed, 21 May 2014 19:46:26 -0400
Message-ID: <20140521234626.GA1644@gchen.bj.intel.com>
References: <1400142646-10127-1-git-send-email-gong.chen@linux.intel.com>
 <1400142646-10127-7-git-send-email-gong.chen@linux.intel.com>
 <20140521110630.GG21205@pd.tnic>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:28521 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753717AbaEVAOA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 21 May 2014 20:14:00 -0400
Content-Disposition: inline
In-Reply-To: <20140521110630.GG21205@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: tony.luck@intel.com, m.chehab@samsung.com, linux-acpi@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2014 at 01:06:31PM +0200, Borislav Petkov wrote:
> > +	if (ras_userspace_consumers() =3D=3D 0) {
>=20
> 	if (!ras_userspace_consumers())
>=20
No, it is not a pointer so I don't think it is very
meaningful just to save some bytes.

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTfTrSAAoJEI01n1+kOSLH1EwQALcU7gijLawdXbIf8XjCkIc8
7q9ATnvNEKRTuuNKeVTwWHickcQgYqcN4JDWQYBlLZWj0zJMMVarsNcwyIXwL9od
mw7mM1ONwqD9jGfoNTq/JN5BgeWaL1he9E1BzWjS43znmyvwrMoJZbe52/aSSv8C
ji91Kjr0IhwLdltP38pOLfR9pHs1WnIMXxEsfkNrLTKAouyALdgj8HWoRR/M5P9w
/N46Ahs2mFDdVlTdbR4sUcITHvn0+AkrFjpjb452y/y7xUkcoe/AAQCaeUMYj4V6
r74LqO717EFlm5xm8x5Q6o8Jzlh35H0itSJDDHco719tpio2BCf65AOspZGnFNjc
db0Skl5Rh3TfWM3v7QR0KMMUHrGWcx3t1ghyvkzlKo/UCK51V2hCymRAVuwT0jv8
CkDQblnXdEO1qpI9PNm6Zxwt2xk8HIbRDr5Ao+ShAl71Qjlb+IE6UQv1VbiBLgjY
0YSL3MD11L1A9HFCQomKOmITYh9mYQjlPddmgbX2S/SoDcgBpJXWW32UuuM0Up5e
RmvxJVPVOka7lPDzSE+lvSpkbdRa8pPVEUrJcnRwR5rLNsP7Z7sfFzQICrumD1Mk
R4NO+5vOO1vD87+iVBzfkeYdX1iX4PSFRpqiItsFZlVbPL98RzOYx2naWe1RkccS
jCOVW4fezkQB/2P8kGB5
=Dbma
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
