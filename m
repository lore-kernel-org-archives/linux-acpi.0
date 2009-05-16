From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: Battery information in sysfs for userspace tools
Date: Sun, 17 May 2009 01:06:52 +0400
Message-ID: <4A0F2AEC.9060802@gmail.com>
References: <1242374864.3992.15.camel@miria>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f174.google.com ([209.85.218.174]:46651 "EHLO
	mail-bw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753479AbZEPVGw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 16 May 2009 17:06:52 -0400
Received: by bwz22 with SMTP id 22so2543470bwz.37
        for <linux-acpi@vger.kernel.org>; Sat, 16 May 2009 14:06:52 -0700 (PDT)
In-Reply-To: <1242374864.3992.15.camel@miria>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yves-Alexis Perez <corsac@debian.org>
Cc: linux-acpi@vger.kernel.org, Evgeni Golov <evgeni@debian.org>


Yves-Alexis Perez wrote:
> Hi,
>
> Evgeni Golov (CC:ed) is currently taking care of fixing acpitool wrt.
> sysfs support (which is badly broken).=20
>
> Using the files in /sys/class/power_supply/BAT*/ we have some wonderi=
ng
> about units.
>
> For the current rate, for example, we have:
>
> corsac@hidalgo: grep . /sys/class/power_supply/BAT0/*now   =20
> /sys/class/power_supply/BAT0/current_now:14415000
> /sys/class/power_supply/BAT0/energy_now:44170000
> /sys/class/power_supply/BAT0/voltage_now:12481000
> corsac@hidalgo: grep . /sys/devices/platform/smapi/BAT0/*now
> /sys/devices/platform/smapi/BAT0/current_now:1151
> /sys/devices/platform/smapi/BAT0/power_now:14365
>
> I'm a bit puzzled with the differences in current_now (the battery is
> charging at that time), and don't really know if we can trust the uni=
ts.
>
> I would assume (in /sys/class/power_supply):
> current_now to be in uA
> energy_now to be in uWh
> voltage_now to be in uV
>
> as said in include/linux/power_supply.h
>
> /*
>  * All voltages, currents, charges, energies, time and temperatures i=
n uV,
>  * =B5A, =B5Ah, =B5Wh, seconds and tenths of degree Celsius unless ot=
herwise
>  * stated. It's driver's job to convert its raw values to units in wh=
ich
>  * this class operates.
>  */
>
>
> and the current (dis)charging rate in W to be
> (current_now/1.000.000)*(energy_now/1.000.000). But that gives, for a=
n
> end of charge, a charging rate of:
>
>  =20
Currently, sysfs interface repeats brokenness of /proc/acpi/battery=20
interface.
it is possible to have battery info in energy units and charge units.
If you see 'energy_now' variable, then 'current_now' and more=20
appropriate 'power_now'
will report in uW units.
But if you have 'charge_now', then 'current_now' will report in uA=20
units, and you will not see 'power_now'.
So, in short, 'charge_now' reports in same units (sans *h) as capacity,=
=20
either 'charge_now' or 'energy_now'.
The proper way to handle it is to check for 'energy_now' and if it is=20
present, look for 'power_now'. It should be
present in 2.6.30 and later kernels (remaining time=20
energy_now/power_now). If it is not present (as in 2.6.29), then you=20
should assume that 'current_now' has value in uW, and remaining time is=
=20
energy_now/current_now.
If you have 'charge_now', remaining time is charge_now/current_now=20
without any complications.

Regards,
Alex.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
