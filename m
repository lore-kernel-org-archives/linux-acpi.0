From: Marc Deop i =?iso-8859-1?q?Argem=ED?= <damnshock@gmail.com>
Subject: Suspend to ram on Toshiba U200
Date: Wed, 21 Nov 2007 01:45:28 +0100
Message-ID: <200711210145.32384.damnshock@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4436509.Hdq54t0IZ2";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:3729 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754819AbXKUApo (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Tue, 20 Nov 2007 19:45:44 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1290005ugc
        for <Linux-acpi@vger.kernel.org>; Tue, 20 Nov 2007 16:45:43 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux-acpi@vger.kernel.org

--nextPart4436509.Hdq54t0IZ2
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi everybody,

I have this mentioned laptop, exactly a Toshiba U200-141. Well, the reason =
of=20
this email is that with the actual kernel I have the known problem of=20
spending 5 to 10 minutes to get the laptop to suspend to ram.

Well, looking at my dmidecode and the drivers/ata/ata_piix.c I see an=20
=BFimportant?  difference:

dmidecode: Product Name: SATELLITE U200

ata_piix.c:   .ident =3D "Satellite U200",
                  DMI_MATCH(DMI_PRODUCT_NAME, "Satellite U200"),

Notice the capital letters on my dmidecode. I have changed the ata_piix.c t=
o=20
have the name in capital letters and now the laptop suspends correctly.

Is this information usefull? Don't really know if this list is where I shou=
ld=20
write to...

Damnshock

--nextPart4436509.Hdq54t0IZ2
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBHQ3+pX9+cS9fjQ4QRAv56AKCKC99rbC7A6YbSLGaSUrCMHjwcMwCfbCpi
H8/hDg+sQM24m5e5AVFnBNk=
=eodX
-----END PGP SIGNATURE-----

--nextPart4436509.Hdq54t0IZ2--
