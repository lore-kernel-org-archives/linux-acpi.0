From: Pavel Machek <pavel@ucw.cz>
Subject: Re: v4.10-rc1: does not wake up from suspend-to-RAM
Date: Tue, 27 Dec 2016 21:31:18 +0100
Message-ID: <20161227203118.GA9658@amd>
References: <20161227130435.GA4535@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:54347 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755038AbcL0UbV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 27 Dec 2016 15:31:21 -0500
Content-Disposition: inline
In-Reply-To: <20161227130435.GA4535@amd>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: kernel list <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux-pm mailing list <linux-pm@lists.osdl.org>, ACPI mailing list <linux-acpi@vger.kernel.org>


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Machine is plain Intel desktop.
>=20
> Even power light does not turn on. Fun. If I force power off by
> holding power button down, power light stays off during the next
> boot. Interesting. I guess EC is confused.
>=20
> Thinkpad X60 with similar kernel config works.

Acer notebook does not work, either. Same config as x60.

Handle 0x0001, DMI type 1, 27 bytes
System Information
        Manufacturer: Acer
 Product Name: Aspire 5732Z
 Version: V3.07
		=09
pavel@half:~$ lspci
00:00.0 Host bridge: Intel Corporation Mobile 4 Series Chipset Memory Contr=
oller Hub (rev 07)
00:01.0 PCI bridge: Intel Corporation Mobile 4 Series Chipset PCI Express G=
raphics Port (rev 07)
00:1a.0 USB controller: Intel Corporation 82801I (ICH9 Family) USB UHCI Con=
troller #4 (rev 03)
00:1a.7 USB controller: Intel Corporation 82801I (ICH9 Family) USB2 EHCI Co=
ntroller #2 (rev 03)
00:1b.0 Audio device: Intel Corporation 82801I (ICH9 Family) HD Audio Contr=
oller (rev 03)
00:1c.0 PCI bridge: Intel Corporation 82801I (ICH9 Family) PCI Express Port=
 1 (rev 03)
00:1c.1 PCI bridge: Intel Corporation 82801I (ICH9 Family) PCI Express Port=
 2 (rev 03)
00:1c.2 PCI bridge: Intel Corporation 82801I (ICH9 Family) PCI Express Port=
 3 (rev 03)
00:1d.0 USB controller: Intel Corporation 82801I (ICH9 Family) USB UHCI Con=
troller #1 (rev 03)
00:1d.1 USB controller: Intel Corporation 82801I (ICH9 Family) USB UHCI Con=
troller #2 (rev 03)
00:1d.2 USB controller: Intel Corporation 82801I (ICH9 Family) USB UHCI Con=
troller #3 (rev 03)
00:1d.3 USB controller: Intel Corporation 82801I (ICH9 Family) USB UHCI Con=
troller #6 (rev 03)
00:1d.7 USB controller: Intel Corporation 82801I (ICH9 Family) USB2 EHCI Co=
ntroller #1 (rev 03)
00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev 93)
00:1f.0 ISA bridge: Intel Corporation ICH9M LPC Interface Controller (rev 0=
3)
00:1f.2 SATA controller: Intel Corporation 82801IBM/IEM (ICH9M/ICH9M-E) 4 p=
ort SATA Controller [AHCI mode] (rev 03)
00:1f.3 SMBus: Intel Corporation 82801I (ICH9 Family) SMBus Controller (rev=
 03)
01:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] R=
V710/M92 [Mobility Radeon HD 4530/4570/545v]
04:00.0 Network controller: Broadcom Corporation BCM43225 802.11b/g/n (rev =
01)
05:00.0 Ethernet controller: Qualcomm Atheros AR8132 Fast Ethernet (rev c0)
pavel@half:~$

Any ideas? Does it work for you?

							Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlhiz5YACgkQMOfwapXb+vLv4gCgo6NXkgGuUlKegZ0Uxi8l9mzP
4T0AmwUhBb4jY0Gas5huRqY/RS/Enrur
=cJYE
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
