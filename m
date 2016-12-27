From: Pavel Machek <pavel@ucw.cz>
Subject: Re: v4.10-rc1: does not wake up from suspend-to-RAM
Date: Tue, 27 Dec 2016 17:57:08 +0100
Message-ID: <20161227165708.GA4229@amd>
References: <20161227130435.GA4535@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:48984 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933076AbcL0Q5L (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 27 Dec 2016 11:57:11 -0500
Content-Disposition: inline
In-Reply-To: <20161227130435.GA4535@amd>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: kernel list <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, ACPI mailing list <linux-acpi@vger.kernel.org>


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2016-12-27 14:04:35, Pavel Machek wrote:
> Hi!
>=20
> Machine is plain Intel desktop.
>=20
> Even power light does not turn on. Fun. If I force power off by
> holding power button down, power light stays off during the next
> boot. Interesting. I guess EC is confused.

Details from the machine:
										Pavel

00:00.0 Host bridge: Intel Corporation 4 Series Chipset DRAM Controller (re=
v 03)
00:01.0 PCI bridge: Intel Corporation 4 Series Chipset PCI Express Root Por=
t (rev 03)
00:02.0 VGA compatible controller: Intel Corporation 4 Series Chipset Integ=
rated Graphics Controller (rev 03)
00:02.1 Display controller: Intel Corporation 4 Series Chipset Integrated G=
raphics Controller (rev 03)
00:1b.0 Audio device: Intel Corporation NM10/ICH7 Family High Definition Au=
dio Controller (rev 01)
00:1c.0 PCI bridge: Intel Corporation NM10/ICH7 Family PCI Express Port 1 (=
rev 01)
00:1c.1 PCI bridge: Intel Corporation NM10/ICH7 Family PCI Express Port 2 (=
rev 01)
00:1d.0 USB controller: Intel Corporation NM10/ICH7 Family USB UHCI Control=
ler #1 (rev 01)
00:1d.1 USB controller: Intel Corporation NM10/ICH7 Family USB UHCI Control=
ler #2 (rev 01)
00:1d.2 USB controller: Intel Corporation NM10/ICH7 Family USB UHCI Control=
ler #3 (rev 01)
00:1d.3 USB controller: Intel Corporation NM10/ICH7 Family USB UHCI Control=
ler #4 (rev 01)
00:1d.7 USB controller: Intel Corporation NM10/ICH7 Family USB2 EHCI Contro=
ller (rev 01)
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev e1)
00:1f.0 ISA bridge: Intel Corporation 82801GB/GR (ICH7 Family) LPC Interfac=
e Bridge (rev 01)
00:1f.1 IDE interface: Intel Corporation 82801G (ICH7 Family) IDE Controlle=
r (rev 01)
00:1f.2 IDE interface: Intel Corporation NM10/ICH7 Family SATA Controller [=
IDE mode] (rev 01)
00:1f.3 SMBus: Intel Corporation NM10/ICH7 Family SMBus Controller (rev 01)
03:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8=
411 PCI Express Gigabit Ethernet Controller (rev 03)
pavel@amd:~$





--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlhinWQACgkQMOfwapXb+vJahACeKMbv87jb+o75TE4oefr4cs4p
SuwAoKL5N0iPr9blHsbmo4fEDR0b84Kz
=cyp6
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
