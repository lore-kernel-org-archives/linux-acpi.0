From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/2] i2c / ACPI: Assign IRQ for devices that have GpioInt
 automatically
Date: Wed, 29 Apr 2015 11:56:06 +0200
Message-ID: <20150429095605.GA2470@katana>
References: <1430233507-29389-1-git-send-email-mika.westerberg@linux.intel.com>
 <1430233507-29389-3-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:56120 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031647AbbD2J4R (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 29 Apr 2015 05:56:17 -0400
Content-Disposition: inline
In-Reply-To: <1430233507-29389-3-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Octavian Purdila <octavian.purdila@intel.com>, Robert Dolca <robert.dolca@intel.com>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> -	if (!client->irq && dev->of_node) {
> -		int irq = of_irq_get(dev->of_node, 0);
> +	if (client->irq <= 0) {
> +		int irq = -ENOENT;

Why the move from !client->irq to <= 0? If I didn't miss something,
interrupt numbers are still a sleeping dog with all the unsigned vs
signed fuzz. If this change is needed, this needs proper description and
ideally a seperate patch.


--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVQKq1AAoJEBQN5MwUoCm28nIP/Auuh9ImyjChU2OW5Jc+Dm/v
3K7hAMm/R6Vj4/2/qtEDN7hd4rXQ82xvOeSUfWIHrjlIVtE4oP6YH+tLTCwUYP2M
zS3RUhFTs4Xn9ve3CmY8FaZan+vPYZWhOGtBIVLooEp2H/pVbWCm0Z1zb3cZZxrb
E8xM5Hp0z0BkWXgX9HJa8nYK/EAtVkxqp9xwlMG1V+ZChPMHMzWAbmopdt/AysNA
j/cvJTrkrUHuTc+WNIF2YFU8LrhisLoIePYrcf01MGoXcGM6q5/sjE+T40WEUuKM
avafglP0vxosyRkLeoF26Y1CWNP0Cc3in0Q6izL8qFnGNfDMP1RziVo/Q3RIoGIB
mE2A++/EfysqwFlicmxNP9XxJSeY5Uvgjgvrm2Isv5+x2r3mu71P40aOFcfDXdor
9wKTuyeeWcSUETOqej6w1Vd8l/P743aY3EVSFp4g9OJStmmO3MAIJF5qeA/2x9bj
zsIMgq4pzztolEiIXsWzc+yVCPmuoLJoWQEIwUWNdXKNypEacZg8VzYMU/sK8G3g
tIpC6gFfx8VTR5VD1K7sIw4y2dRcS61UnWJq4744LU1HW5MR9XuebyNykIFAdLFp
P/M1myMnp2yXB54UNRwE2Q6qtRnL/vbxU5FPTD+NereXkmN95uXv2KCHlEi+GnGa
A5oIGwjaIBBiG/WlSyar
=QPJV
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
