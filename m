From: =?ISO-8859-1?Q?=C2ngelo?= Miguel Arrifano <miknix@gmail.com>
Subject: Re: HP dv6535ep dmidecode
Date: Mon, 22 Oct 2007 00:41:44 +0100
Message-ID: <20071022004144.6e4240de.miknix@gmail.com>
References: <20070911171927.572087e0.miknix@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Mon__22_Oct_2007_00_41_44_+0100_ayzV8woO2E=c7_es"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:42240 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751067AbXJUXfy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 21 Oct 2007 19:35:54 -0400
Received: by ug-out-1314.google.com with SMTP id z38so834020ugc
        for <linux-acpi@vger.kernel.org>; Sun, 21 Oct 2007 16:35:53 -0700 (PDT)
In-Reply-To: <20070911171927.572087e0.miknix@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

--Signature=_Mon__22_Oct_2007_00_41_44_+0100_ayzV8woO2E=c7_es
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 11 Sep 2007 17:19:27 +0100
=C2ngelo Miguel Arrifano <miknix@gmail.com> wrote:

> Hello,
>=20
>   In sequence of
> ACPI: System BIOS is requesting _OSI(Linux)
> ACPI: Please test with "acpi_osi=3D!Linux"
> Please send dmidecode to linux-acpi@vger.kernel.org
>=20
> I'm sending information of my new laptop.
> It's a HP dv6535ep but should be simillar to the dv65xx series.
>=20
> Everything is working fine (one-touch hotkeys, suspend-to-ram
> by simply issuing echo "mem" > /sys/power/state, sound, ...)
> except the Fn+F7/Fn+F8 keys to increase/decrease DFP brightness
> (i really don't have more ideas how to set screen brightness : \).
> Also when I plug headphones, laptop speakers doesn't turn off
> but this should be a alsa problem.

I'm still unable to change the screen backlight intensity.
The headphones plug works properly when loading snd-hda-intel with model=3D=
laptop option.

>=20
> I tried disabling Linux OSI and comparing both dmesg but they are
> similar. Disabling Linux OSI and enabling 'Windows 2006' OSI
> makes GL acceleration crash the laptop.
>=20
> PS: I'm curious about 'processor CPU0 00000080 00000000' acpi
> event messages that I usually receive when compiling stuff.
> I think its about CPU temperature but according to Google it's=20
> a change on the number of CPU P-states. I'm trying to figure
> out what to do when receiving these events.
>=20
> Just another thing, there is a dsdt parsing error during boot:
> ACPI Error (dsopcode-0548): Field [I9MN] at 544 exceeds Buffer [IORT] siz=
e 464 (bits) [20070126]
> ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.LPC0=
.PMIO._CRS] (Node ffff81007ff40760), AE_AML_BUFFER_LIMIT
> ACPI Error (uteval-0236): Method execution failed [\_SB_.PCI0.LPC0.PMIO._=
CRS] (Node ffff81007ff40760), AE_AML_BUFFER_LIMIT
> pnp: PnPACPI: METHOD_NAME__CRS failure for PNP0c02
>=20
> is this '\_SB_.PCI0.LPC0.PMIO' important to my system?

I *think* I fixed this one by doing this:

  Device (PMIO)
  {
    //(...)
    Method (_CRS, 0, NotSerialized)
    {
      //(...)
      Name (IORT, ResourceTemplate ()
      {
        IO (Decode16,
            0x0000,             // Range Minimum
            0x0000,             // Range Maximum
            0x01,               // Alignment
            0x80,               // Length
            _Y02)
        //(...)
        IO (Decode16,
            0x0000,             // Range Minimum
            0x0000,             // Range Maximum
            0x01,               // Alignment
            0x80,               // Length
            _Y07)
        IO (Decode16,
            0x0000,             // Range Minimum
            0x0000,             // Range Maximum
            0x01,               // Alignment
            0x40,               // Length
-           )
+           _Y09)
        //(...)
        CreateWordField (IORT, \_SB.PCI0.LPC0.PMIO._CRS._Y02._MIN, I1MN)
        CreateWordField (IORT, \_SB.PCI0.LPC0.PMIO._CRS._Y02._MAX, I1MX)
        //(...)
        CreateWordField (IORT, \_SB.PCI0.LPC0.PMIO._CRS._Y07._MIN, I6MN)
        CreateWordField (IORT, \_SB.PCI0.LPC0.PMIO._CRS._Y07._MAX, I6MX)
-       CreateWordField (IORT, 0x42, I9MN)
-       CreateWordField (IORT, 0x44, I9MX)
+       CreateWordField (IORT, \_SB.PCI0.LPC0.PMIO._CRS._Y09._MIN, I9MN)
+       CreateWordField (IORT, \_SB.PCI0.LPC0.PMIO._CRS._Y09._MAX, I9MX)

I'm not sure about this.. I have only imitated previous statements :D

Although, after fixing a few more common compile errors and compiling the d=
sdt, the kernel
boots without acpi errors and it even detects more devices.
Here is the difference:

Before:
ACPI Error (dsopcode-0548): Field [I9MN] at 544 exceeds Buffer [IORT] size =
464 (bits) [20070126]
ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.LPC0.P=
MIO._CRS] (Node ffff81007ff1cc70), AE_AML_BUFFER_LIMIT
ACPI Error (uteval-0236): Method execution failed [\_SB_.PCI0.LPC0.PMIO._CR=
S] (Node ffff81007ff1cc70), AE_AML_BUFFER_LIMIT
pnp: PnPACPI: METHOD_NAME__CRS failure for PNP0c02
pnp: PnP ACPI: found 11 devices
pnp: 00:0a: iomem range 0xffc00000-0xffffffff could not be reserved
pnp: 00:0a: iomem range 0xfec00000-0xfec00fff could not be reserved
pnp: 00:0a: iomem range 0xfed00000-0xfed00fff has been reserved
pnp: 00:0a: iomem range 0xfec80000-0xfec80fff has been reserved

After:
pnp: PnP ACPI: found 12 devices
pnp: 00:03: ioport range 0x1000-0x107f has been reserved
pnp: 00:03: ioport range 0x1080-0x10ff has been reserved
pnp: 00:03: ioport range 0x1400-0x147f has been reserved
pnp: 00:03: ioport range 0x1480-0x14ff has been reserved
pnp: 00:03: ioport range 0x1800-0x187f has been reserved
pnp: 00:03: ioport range 0x1880-0x18ff has been reserved
pnp: 00:03: ioport range 0x2000-0x203f has been reserved
pnp: 00:0b: iomem range 0xffc00000-0xffffffff could not be reserved
pnp: 00:0b: iomem range 0xfec00000-0xfec00fff could not be reserved
pnp: 00:0b: iomem range 0xfed00000-0xfed00fff has been reserved
pnp: 00:0b: iomem range 0xfec80000-0xfec80fff has been reserved

Don't know what this new device is.. Also I didn't notice any change
on laptop behaviour.
>=20
> Best regards
> --=20
> Angelo Arrifano AKA MiKNiX
> IT Student at UBI, Portugal
> Gentoo Linux AMD64 Arch Tester
> miknix@gmail.com
> http://miknix.homelinux.com
>=20
>=20

Cheers,
--=20
Angelo Arrifano AKA MiKNiX
IT Student at UBI, Portugal
Gentoo Linux AMD64 Arch Tester
miknix@gmail.com
http://miknix.homelinux.com


--Signature=_Mon__22_Oct_2007_00_41_44_+0100_ayzV8woO2E=c7_es
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHG+O4NahyoD2SuwsRAiTQAKCFNlJA5/plgq+0fOmuTnwcSRSY5ACeL5wO
/B6kTslVXhemXgUEo+7EpeM=
=4PTQ
-----END PGP SIGNATURE-----

--Signature=_Mon__22_Oct_2007_00_41_44_+0100_ayzV8woO2E=c7_es--
