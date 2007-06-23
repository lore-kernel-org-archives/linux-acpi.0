From: Rolf Eike Beer <eike-kernel@sf-tec.de>
Subject: Re: Add INPUT support to toshiba_acpi
Date: Sat, 23 Jun 2007 16:56:24 +0200
Message-ID: <200706231656.39597.eike-kernel@sf-tec.de>
References: <1180614979.2693.26.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1414674.dcvW7uzd5Z";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753782AbXFYJKX@vger.kernel.org>
In-Reply-To: <1180614979.2693.26.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Hughes <hughsient@gmail.com>
Cc: John Belmonte <john@neggie.net>, linux-kernel <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Bastien Nocera <hadess@hadess.net>
List-Id: linux-acpi@vger.kernel.org

--nextPart1414674.dcvW7uzd5Z
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Richard Hughes wrote:
> Attached patch adds a kernel thread to do polling on Toshiba hardware.

Is there something similar available to support other Toshiba laptops? I ow=
n a=20
A110-178 that is not supported by the driver but has a lot of keys that I=20
can't use currently:

=46n:
=2Dscreen zoom (I actually don't care about this one)
=2DS2RAM
=2DS2Disk
=2DMute*

Multimedia:
=2DBrowser
=2DVideo player
=2DPlay/pause
=2DStop
=2DForward
=2DReverse

*Mute: it's a bit special. If I use it I can an on screen display (mute/sou=
nd)=20
but regardless of which setting is displayed the sound is still there.

None of the above keys generated a key event. Neither does "Brightness down=
",=20
but it still works. "Brightness up" generates an event and works. Kpowersav=
e=20
tells me it can't do brightness switching in software (which works in=20
WinXtraPain).

If you need an acpidump or I can do some testing just ask.

Eike

--nextPart1414674.dcvW7uzd5Z
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBGfTSnXKSJPmm5/E4RAgM9AJ9H4BZl60u3ccagmhS3z4qBv15EDwCfYlx3
FmBTj7zQ9e7gmNX0/A8w9no=
=EEUF
-----END PGP SIGNATURE-----

--nextPart1414674.dcvW7uzd5Z--
