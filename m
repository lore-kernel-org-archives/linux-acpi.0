From: Yves-Alexis Perez <corsac@debian.org>
Subject: Battery information in sysfs for userspace tools
Date: Fri, 15 May 2009 10:07:44 +0200
Message-ID: <1242374864.3992.15.camel@miria>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2-g21.free.fr ([212.27.42.2]:45231 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755673AbZEOINJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 15 May 2009 04:13:09 -0400
Received: from smtp2-g21.free.fr (localhost [127.0.0.1])
	by smtp2-g21.free.fr (Postfix) with ESMTP id 381FC4B0179
	for <linux-acpi@vger.kernel.org>; Fri, 15 May 2009 10:13:04 +0200 (CEST)
Received: from molly.corsac.net (molly.corsac.net [81.57.48.219])
	by smtp2-g21.free.fr (Postfix) with ESMTP id 50DB84B015E
	for <linux-acpi@vger.kernel.org>; Fri, 15 May 2009 10:13:02 +0200 (CEST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Evgeni Golov <evgeni@debian.org>

Hi,

Evgeni Golov (CC:ed) is currently taking care of fixing acpitool wrt.
sysfs support (which is badly broken).=20

Using the files in /sys/class/power_supply/BAT*/ we have some wondering
about units.

=46or the current rate, for example, we have:

corsac@hidalgo: grep . /sys/class/power_supply/BAT0/*now   =20
/sys/class/power_supply/BAT0/current_now:14415000
/sys/class/power_supply/BAT0/energy_now:44170000
/sys/class/power_supply/BAT0/voltage_now:12481000
corsac@hidalgo: grep . /sys/devices/platform/smapi/BAT0/*now
/sys/devices/platform/smapi/BAT0/current_now:1151
/sys/devices/platform/smapi/BAT0/power_now:14365

I'm a bit puzzled with the differences in current_now (the battery is
charging at that time), and don't really know if we can trust the units=
=2E

I would assume (in /sys/class/power_supply):
current_now to be in uA
energy_now to be in uWh
voltage_now to be in uV

as said in include/linux/power_supply.h

/*
 * All voltages, currents, charges, energies, time and temperatures in =
uV,
 * =C2=B5A, =C2=B5Ah, =C2=B5Wh, seconds and tenths of degree Celsius un=
less otherwise
 * stated. It's driver's job to convert its raw values to units in whic=
h
 * this class operates.
 */


and the current (dis)charging rate in W to be
(current_now/1.000.000)*(energy_now/1.000.000). But that gives, for an
end of charge, a charging rate of:

(14415000 / 1000000) * (12481000 / 1000000) =3D approx. 179.91362

which seems definitely wrong.

Where am I mistaken?

Btw this is on 2.6.29.2 on a Thinkpad T61, and tp-smapi is loaded.

Cheers,
--=20
Yves-Alexis

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
