From: Jaroslaw Gorny <jaroslav@aster.pl>
Subject: dock problem - Dell Latitude+2.6.18-rc2
Date: Tue, 18 Jul 2006 19:57:12 +0200
Message-ID: <200607181957.21224.jaroslav@aster.pl>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2268116.00BRQcUSQy";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail2.aster.pl ([212.76.33.47]:57491 "EHLO mail2.astercity.net")
	by vger.kernel.org with ESMTP id S932332AbWGRR4X (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 18 Jul 2006 13:56:23 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Kristen Accardi <kristen.c.accardi@intel.com>

--nextPart2268116.00BRQcUSQy
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,
I've got one Dell Latitude D505 with a dock-station, like this:
http://laptoptravel.com/product.aspx?pc=3DDELLDPORT&V=3DDT

Today I've built 2.6.18-rc2 kernel with dock module.
When I pushed "undock-request" button the following has happend:

1. Total system freeze for sth. like 20 seconds (no response, no sound, no=
=20
keyboard, no nothing). During that time "undock" LED was blinking.

2. After that system started to "work" again. But cpu usage jumped to 100%=
=20
and /var/log/messages was flooded with this:

<quote>
Jul 18 09:49:15 localhost kernel: [  360.989000] ACPI Exception=20
(acpi_bus-0071): AE_NOT_FOUND, No context for object [c14789a0] [20060707]
Jul 18 09:49:15 localhost kernel: [  360.991000] ACPI Exception=20
(acpi_bus-0071): AE_NOT_FOUND, No context for object [c14789a0] [20060707]
Jul 18 09:49:15 localhost kernel: [  360.992000] ACPI Exception=20
(acpi_bus-0071): AE_NOT_FOUND, No context for object [c14789a0] [20060707]
Jul 18 09:49:15 localhost kernel: [  360.994000] ACPI Exception=20
(acpi_bus-0071): AE_NOT_FOUND, No context for object [c14789a0] [20060707]
Jul 18 09:49:15 localhost kernel: [  360.996000] ACPI Exception
</quote>

3. To reboot I had to push power button for 3 seconds (simple powerdown did=
n't=20
work).


If I can provide any additional informations, or to test something - please=
=20
let me know.

By the way: this kernel for me is the first one with dock module.
Some time ago I just pushed the "undock-request" button to see what happens=
=2E=20
And of course nothing has happened. "undock" LED has blinked several times=
=20
and everything returned to normal state. Without any issues, without any=20
messages in /var/log/* files.

Regards,

=2D-=20
Jaroslaw Gorny
jaroslav@aster.pl


=2D----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GMU/E/CS d+/-- s+: a- c++ UL++/US P+>++ L+++>++++
E>++ W N++ o? K w--- !O M V- PS+++ PE++ Y PGP>++ t 5
X- R- tv--/!tv b++ DI-- D G- e++>+++ h-- r+++ z+++
=2D----END GEEK CODE BLOCK-----

--nextPart2268116.00BRQcUSQy
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)

iD8DBQBEvSEB6haYWsLTFVgRAvmLAJ0ZM7dgRNUcOaFFjX9Cam5dU/ss7gCdGWDb
NBWbQlKHnAM/jRMDDmL/57g=
=T9ad
-----END PGP SIGNATURE-----

--nextPart2268116.00BRQcUSQy--
