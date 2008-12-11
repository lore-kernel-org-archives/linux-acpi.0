From: Tony Vroon <tony@linx.net>
Subject: Re: Fuijtsu Lifebook RFKILL support
Date: Thu, 11 Dec 2008 17:33:47 +0000
Message-ID: <1229016827.6446.6.camel@localhost>
References: <1228957506.4045.11.camel@localhost>
	 <20081211165247.GA4844@khazad-dum.debian.net>
Reply-To: tony@linx.net
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-mNdmq+8DvvR/g+uHgo2E"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gold.linx.net ([195.66.232.40]:37150 "EHLO gold.linx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756554AbYLKRe3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 11 Dec 2008 12:34:29 -0500
In-Reply-To: <20081211165247.GA4844@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Ivo van Doorn <ivdoorn@gmail.com>, linux-acpi@vger.kernel.org, jwoithe@physics.adelaide.edu.au


--=-mNdmq+8DvvR/g+uHgo2E
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2008-12-11 at 14:52 -0200, Henrique de Moraes Holschuh wrote:
> That is an input device, that should issue EV_SW SW_RFKILL_ALL events (an=
d
> not EV_KEY, etc).

Okay, glad I asked.
Can I combine EV_SW & EV_KEY on a single input device (as there is
already a FUJ02E3 input device within the device driver) or would that
break things?

Also, would there be a clear acknowledgement of an rfkill state change
in Gnome?

> So, you won't even #include <linux/rfkill.h>.

Noted, include removed.=20

> The only pitfall I know of is that you have to re-sync the input layer at=
 every point it could have missed
> a state change.  This means you must issue gratuitous EV_SW SW_RFKILL_ALL
> events with the current state of the switch after you created the input
> device, after resume (from S3/S4), and when you get the notifier from ACP=
I
> that the switch state could have changed.

Done at input device creation and when notified. I have no resume
callback to hook into.

Regards,
Tony V.

--=-mNdmq+8DvvR/g+uHgo2E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklBTvsACgkQp5vW4rUFj5ptFQCcDg5V28quE8UFrAUWNX2UySRU
JcoAn3+Zecb9bC/juD7lE2WDppzNvtmU
=y6Q/
-----END PGP SIGNATURE-----

--=-mNdmq+8DvvR/g+uHgo2E--

