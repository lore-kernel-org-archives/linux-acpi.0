From: Tony Vroon <tony@linx.net>
Subject: Re: why do drivers evaluate _INI?
Date: Tue, 23 Jun 2009 01:01:15 +0100
Message-ID: <1245715275.441.13.camel@localhost>
References: <200906221732.35993.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-HQeazKLaO6sBOhrb1eHr"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gold.linx.net ([195.66.232.40]:39187 "EHLO gold.linx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751955AbZFWAKi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 22 Jun 2009 20:10:38 -0400
In-Reply-To: <200906221732.35993.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Len Brown <lenb@kernel.org>, Eric Piel <eric.piel@tremplin-utc.net>, Pavel Machek <pavel@suse.cz>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, Mattia Dongili <malattia@linux.it>, linux-acpi@vger.kernel.org


--=-HQeazKLaO6sBOhrb1eHr
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2009-06-22 at 17:32 -0600, Bjorn Helgaas wrote:
> I see the following drivers using _INI:
>   drivers/platform/x86/fujitsu-laptop.c

Bjorn, can you send me an experimental patch where you remove it? I can
regression test that for you on the Lifebook S6420.

I'm happy to sign off on it if I see no functional regressions, and if
not at least we'll have an idea of what to look for.

Regards,
Tony V.

--=-HQeazKLaO6sBOhrb1eHr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iEYEABECAAYFAkpAG0sACgkQp5vW4rUFj5rEgQCeIM51beJ8h566pdfV9/k8vu3s
X+gAn1t/30tpP8SzDfDTeF+l/h/T8Sm6
=7z58
-----END PGP SIGNATURE-----

--=-HQeazKLaO6sBOhrb1eHr--

