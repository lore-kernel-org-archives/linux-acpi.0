From: Thomas Renninger <trenn@suse.de>
Subject: Re: acpi/sensors temperature on nx6325
Date: Thu, 14 Jun 2007 22:22:19 +0200
Message-ID: <1181852539.20343.32.camel@fanta4.site>
References: <200706111310.25351.dev.list@mircea.bardac.net>
	 <466DA949.8050505@gmail.com>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:36985 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754810AbXFMWrh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 13 Jun 2007 18:47:37 -0400
In-Reply-To: <466DA949.8050505@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Maciej Rutecki <maciej.rutecki@gmail.com>
Cc: Mircea Bardac <dev.list@mircea.bardac.net>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

On Mon, 2007-06-11 at 21:58 +0200, Maciej Rutecki wrote:
> Mircea Bardac pisze:
> > Hi all,
> >=20
> > I'm currently running kernel 2.6.21.3 on a HP nx6325.
> >=20
> > I like having in the taskbar information about cpu/mem/temperature/=
etc. I=20
> > found a strange behaviour monitoring the ACPI provided temperature.=
 It=20
> > currently shows for example 48C constantly, for lots of minutes.=20
> >=20
> > Doing a: dd if=3D/dev/urandom of=3D/dev/null increases the CPU usag=
e and=20
> > temperature should increase too. The ACPI temperature stays the sam=
e though.
> >=20
> > I have also loaded the lm_sensors modules which, after some monitor=
ing, appear=20
> > to be working right, meaning "it shows an increasing temperature if=
 the CPU=20
> > usage increases".
> >=20
> > # cat /proc/acpi/thermal_zone/TZ1/temperature && sensors
> > temperature:             48 C
> > k8temp-pci-00c3
> > Adapter: PCI adapter
> > Core0 Temp:
> >              +54=C2=B0C
> > Core1 Temp:
> >              +53=C2=B0C
> >=20
> >=20
> > The ACPI temperature increases only when the trip-point is reached.=
 I hear the=20
> > fans starting. When the fans stop, the temperature drops "hard" to =
the=20
> > previous value.
> >=20
> > I've changed the polling frequency to 1:
> > # cat /proc/acpi/thermal_zone/TZ1/polling_frequency
> > polling frequency:       1 seconds
A value of 1 sec is a bad idea, I remember a report were things got
stuck because of too high polling freq.
The HPs normally throw thermal events correctly, better disable it and
set it to 0.
> >=20
> > I got the same effect: I can't see the temperature change dynamical=
ly, degree=20
> > by degree. Also, in a test, the sensor went up to 60-65C and the tr=
ip-point=20
> > did't activate. This was with polling set to 1.
> >=20
>=20
> Similar on nx6310. Sometimes when I turn on laptop when CPU temperatu=
re
> (first thermal zone - TZ0) is above 1st trip point the fan doesn't tu=
rn
> on now, but only when second trip point was reached.

I've sent a little How-To some days ago:
Documentation - How to debug ACPI Problems

Len, what is your opinion about the HowTo?
Will you add it as it is?

I'd start to disassemble the DSDT.
Have a look at the _TMP code. There often are hard coded temperature
values. I expect they come from some BIOS setting or could be triggered
through applications that access the fan/temp directly. It could also b=
e
that your EC is confused or something else.

You could (see the HowTo):
 - 3.2.3 Using ACPI_DEBUG ASL debug object
   -> Go to the _TMP func and cluster everything with
   store (MONITOR_VAR, debug)

 - 3.2.4 Using ACPI_DEBUG acpi_dbg_layer and acpi_dbg_level kernel
   variables
   -> Go to drivers/acpi/thermal.c when the temperature is invoked,
   increase acpi_debug_level before evaluate_...("_TMP",..) is invoked
   and decrease it afterwards. Only set flags you think are useful, I'd
   start with exec, value, IIRC there also is some I/O or hardware
   access flag. Always let the last 5 bit set 0x1F=20
   (err,warn,deb,info,..)

BTW: Temperature passed through _TMP is:
1/10 Kelvin
Means 40C is a value of:
(273 + 40 ) * 10 =3D 3130 (0xC3A)
You might search for a hard coded value like that which matches yours.

Which kernel are you using?
Best you try the latest...

Is psmouse compiled as module?

Psmouse is known that it could interfere with ACPI on HP laptops and
lm_sensor modules also. Is it better without?

If latest kernel is affected, you best open a bug bugzilla.kernel.org,
attach dmesg, acpidump and everything else you find out. Pls CC me then=
=2E

   Thomas

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
