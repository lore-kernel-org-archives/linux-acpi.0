From: Rolf Kutz <rk@vzsze.de>
Subject: Re: New: After Hibernation the battery charging information is not
	working any more.
Date: Mon, 28 Jan 2008 16:45:16 +0100
Message-ID: <20080128154515.GD8471@vzsze.de>
References: <bug-9835-10286@http.bugzilla.kernel.org/> <20080128045053.a07f6539.akpm@linux-foundation.org> <20080128125755.GB8471@vzsze.de> <200801281616.51861.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6Nae48J/T25AfBN4"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp3.netcologne.de ([194.8.194.66]:44187 "EHLO
	smtp3.netcologne.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213AbYA1Ppb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 28 Jan 2008 10:45:31 -0500
Content-Disposition: inline
In-Reply-To: <200801281616.51861.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, bugme-daemon@bugzilla.kernel.org


--6Nae48J/T25AfBN4
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 28/01/08 16:16 +0100, Rafael J. Wysocki wrote:
>On Monday, 28 of January 2008, Rolf Kutz wrote:
>>=20
>> I will provide additional information if needed.
>
>One of the following commits might be responsible:
>
>http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dcom=
mit;h=3Dc04209a7948b95e8c52084e8595e74e9428653d3
>http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dcom=
mit;h=3D9f9adecd2d0e4f88fa0e8cb06c6ec207748df70a
>http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dcom=
mit;h=3Dd1ec7298fcefd7e4d1ca612da402ce9e5d5e2c13
>http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dcom=
mit;h=3D96c2a8766bf4fe91abac863749c11637fabcc64f
>
>Can you please check if reverting any of them helps?

I will, but what version should I test them with?
I'm getting rejects with 2.6.24 and I'm not really
much into C.

regards, Rolf

--6Nae48J/T25AfBN4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHnfiL+ZqCAlXyvMsRAluLAJ4zwkmKeox0J/u2wzczh92gUz/l1QCfR9+Y
//I6mkLQxElBx0sG3DPtZ5U=
=g+ME
-----END PGP SIGNATURE-----

--6Nae48J/T25AfBN4--
