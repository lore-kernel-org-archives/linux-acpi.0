From: Aaron Lu <aaron.lwe@gmail.com>
Subject: Re: acpi_backlight=vendor no longer working around buggy laptop from
 hell
Date: Mon, 29 Jul 2013 09:05:58 +0800
Message-ID: <51F5BFF6.7080506@gmail.com>
References: <51F40114.9060607@opensuse.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:61993 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751812Ab3G2BFU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 28 Jul 2013 21:05:20 -0400
In-Reply-To: <51F40114.9060607@opensuse.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?UTF-8?B?Q3Jpc3RpYW4gUm9kcsOtZ3Vleg==?= <crrodriguez@opensuse.org>
Cc: linux-kernel@vger.kernel.org, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>

On 07/28/2013 01:19 AM, Cristian Rodr=C3=ADguez wrote:
> Hi:
>=20
> I have a DELL XPS 15z laptop with the latest BIOS (A12).
>=20
> This piece of crap have never worked properly without special boot=20
> parameters. Up to kernel 3.10, passing acpi_backlight=3Dvendor was en=
ough=20
> to allow the machine to complete boot and be usable.
>=20
> Now with 3.11 rc2 (also with today's linus tree) unbootable machine=20
> problem is back.
>=20
> In the past I spent many hours figuring out workarounds and they go=20
> _now_ as the following.
>=20
> Booting with:
>=20
> "nox2apic" --> machine works, flawless.

I've seen bug report with similar symptom:
https://bugzilla.kernel.org/show_bug.cgi?id=3D56051

It is possible the BIOS is not x2apic aware while Linux enabled x2apic,
then some ACPI control method to do things like change backlight
brightness level triggered SMI handler and freeze would occur. This
might be the reason why adding acpi_backlight=3Dvendor fixed your probl=
em,
since it would block ACPI video module's handling of backlight.

So does adding nox2apic still work for you with latest Linus' tree?

>=20
> "x2apic_phys acpi_backlight=3Dvendor" --> machine works, except for t=
he=20
> big problem that the laptop keyboard and touchpad are unresponsive, I=
=20
> have to plug USB keyboard/mouse to get anything done.
>=20
> With no boot parameters the machine hangs at random points in the boo=
t=20
> sequence either:
>=20
> -Very early at boot and there is no way to retrieve any useful debug=20
> info. [OR]

Maybe this is when video.ko is loaded.

>=20
> - Somehow it looses "connection" with the ATA controller and the=20
> filesystems cannot be mounted. [OR]
>=20
> - In very few ocassions, the boot proceeds with no keyboard or touchp=
ad=20
> then the iwlwifi wireless card does something stupid (firmware error.=
=2E.)

All sounds like related to irq problem.

>=20
> The only possible hint in the logs I could ever find is:
>=20
> [    3.844586] [Firmware Bug]: ACPI(PEGP) defines _DOD but not _DOS

This is subtle, meaning the BIOS doesn't provide the required method.

-Aaron

>=20
>=20
> I tried in the past to obtain any debug information, with no luck.
>=20
> Help is appreciated to get to the bottom of the problem. ;)
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
