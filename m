From: Frederik Gladhorn <gladhorn@kde.org>
Subject: acer aspire 4820gt (timeline x) battery/temp cannot be read
Date: Mon, 21 Jun 2010 14:04:04 +0200
Message-ID: <201006211404.10654.gladhorn@kde.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2657630.ubKKDl6LQe";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ww0-f46.google.com ([74.125.82.46]:53370 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754184Ab0FUMER (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Jun 2010 08:04:17 -0400
Received: by wwb13 with SMTP id 13so378384wwb.19
        for <linux-acpi@vger.kernel.org>; Mon, 21 Jun 2010 05:04:13 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

--nextPart2657630.ubKKDl6LQe
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,
on the Acer Aspire 4820 GT laptop the battery and temperature cannot be rea=
d.
I tested with kernel versions 2.6.32 (Ubuntu) and vanilla kernel 2.6.34/35-
rc3.
The battery is found as BAT1 but always shows 0% charge state.
Temperature is always read as 40=B0C.

I suspect the acpi tables are at fault.

I filed a bug with the acpi dumps and dsl files here:
https://bugzilla.kernel.org/show_bug.cgi?id=3D16218

Any help in how to figure this out would be much appreciated. Not knowing t=
he=20
remaining battery charge is really annoying.

Regards
=46rederik


--nextPart2657630.ubKKDl6LQe
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkwfVTUACgkQcZKJUyELiPd2JgCgjsBWHOP1xqmUo4DePYQxoog3
Q9EAnAn5VfefNnutaC0yN7MgW+e3xE2P
=OWnz
-----END PGP SIGNATURE-----

--nextPart2657630.ubKKDl6LQe--
