From: Daniel Egger <degger-Gv7zc1CdiNM@public.gmane.org>
Subject: Re: [PATCH] 2.4.23-pre3 ACPI fixes series (1/3)
Date: Wed, 10 Sep 2003 17:31:21 +0200
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <1063207880.7657.1.camel@sonja>
References: <200309051958.02818.adq_dvb@lidskialf.net>
	 <200309060016.16545.adq_dvb@lidskialf.net> <3F590E28.6090101@pobox.com>
	 <200309060115.24340.adq_dvb@lidskialf.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-KeEGG+OvUDx0iu/mawmN"
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200309060115.24340.adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
To: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Cc: Jeff Garzik <jgarzik-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>, torvalds-3NddpPZAyC0@public.gmane.org, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-acpi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--=-KeEGG+OvUDx0iu/mawmN
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Sam, 2003-09-06 um 02.15 schrieb Andrew de Quincey:

> This patch allows ACPI to drop back to PIC mode if ACPI mode setup fails.

Those patches work miracles for me. Finally I can use my ECS L7VTA with
KT400 chipset with IO-APIC in ACPI mode.

egger@alex:/proc$ cat /proc/interrupts
           CPU0
  0:     119774    IO-APIC-edge  timer
  1:        881    IO-APIC-edge  keyboard
  2:          0          XT-PIC  cascade
  8:          1    IO-APIC-edge  rtc
  9:          0    IO-APIC-edge  acpi
 14:          7    IO-APIC-edge  ide0
 15:         39    IO-APIC-edge  ide1
 16:         57   IO-APIC-level  ohci1394
 17:          0   IO-APIC-level  eth1
 19:          2   IO-APIC-level  ymfpci
 21:          0   IO-APIC-level  usb-uhci, usb-uhci, usb-uhci, ehci_hcd
 23:     253525   IO-APIC-level  eth0
NMI:          0
LOC:     119715
ERR:          0
MIS:          0

--=20
Servus,
       Daniel

--=-KeEGG+OvUDx0iu/mawmN
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/X0PIchlzsq9KoIYRAsHyAJ9WSEkn9d3InzndOoziHL25O242DACgynpk
GUQ01q1oYmD40Ak2x6Im+c0=
=2CHn
-----END PGP SIGNATURE-----

--=-KeEGG+OvUDx0iu/mawmN--
