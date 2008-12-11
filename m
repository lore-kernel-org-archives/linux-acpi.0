From: Tony Vroon <tony@linx.net>
Subject: Fuijtsu Lifebook RFKILL support
Date: Thu, 11 Dec 2008 01:05:06 +0000
Message-ID: <1228957506.4045.11.camel@localhost>
Reply-To: tony@linx.net
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-FzZ+Fwi0mIYZGTCfhqld"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gold.linx.net ([195.66.232.40]:34162 "EHLO gold.linx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752309AbYLKBQd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 10 Dec 2008 20:16:33 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ivo van Doorn <ivdoorn@gmail.com>
Cc: linux-acpi@vger.kernel.org, jwoithe@physics.adelaide.edu.au


--=-FzZ+Fwi0mIYZGTCfhqld
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Good morning,

There is preliminary code ready to implement RFKILL support on Fujitsu
laptops. Unfortunately, I can't see how to express this specific switch
type within the existing framework.
The laptop has one "big" kill switch that kills everything,
WLAN/Bluetooth/3G, you name it. I have no means to turn individual
radios on or off, all I'll get is a big notifier (from which I can fire
up a query to see whether the kill switch state got changed).

As such, I have 1 rfkill interface that I'd like to call "all", which
supports states RFKILL_STATE_HARD_BLOCKED and RFKILL_STATE_UNBLOCKED. I
can implement get_state, but toggle_radio is marked mandatory.

I can't do anything meaningful in response to toggle_radio, but I could
unconditionally report failure. Ivo, does that violate the spirit of the
interface? To me it seems useful to have the notifiers, but I figured
I'd ask the subsystem maintainer first.

Jonathan, if you have DSDTs for machines other then a Lifebook S6410,
S6420 or E8410 could you please e-mail these to me. I would like to see
whether the callbacks I'm using are present.

Regards,
Tony V.

--=-FzZ+Fwi0mIYZGTCfhqld
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklAZ0IACgkQp5vW4rUFj5o10ACdEz0zhP89/D0HjDuHfdNkttHY
HfEAoJyzTBX1JydVYTbLwBhWihOhvsT6
=6p4L
-----END PGP SIGNATURE-----

--=-FzZ+Fwi0mIYZGTCfhqld--

