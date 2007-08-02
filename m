From: Len Brown <lenb@kernel.org>
Subject: Re: 2.6.22 regression: thermal trip points
Date: Thu, 2 Aug 2007 17:56:30 -0400
Message-ID: <200708021756.30776.lenb@kernel.org>
References: <46B1988C.3090302@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:50434 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753438AbXHBV5Q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Aug 2007 17:57:16 -0400
In-Reply-To: <46B1988C.3090302@t-online.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Knut Petersen <Knut_Petersen@t-online.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>, trenn@suse.de, pavel@ucw.cz, mjg59@srcf.ucam.org, linux-acpi@vger.kernel.org

On Thursday 02 August 2007 04:40, Knut Petersen wrote:

> Kernel 2.6.22 decreases performance by about 50% on my system.
> No, I do not like that. The reason is a broken BIOS, granted, but the=
re
> was a perfect workaround in the kernel that has been dropped.
>=20
> mainboard: AOpen i915GMm-hfs, AWARD BIOS
> cpu: Pentium-M 750 (0.8 to 1.86 MHz)
> openSuSE 10.2 with kernel 2.6.22.1
>=20
> The cpu fan can not be controled by linux kernel.
> The BIOS will switch on the cpu fan a bit above 50 deg. Celsius.
> The active and passive trip points both are set to 50 deg. Celsius.
> Temperature of the idle cpu at 800 Mhz: 34 to 42 deg. C.
> The BIOS never changes the trip points.
> Cpufreq does work perfectly.
>=20
> Previously there was the possibility  to add something like
>=20
> echo  "100:0:65:70:0" > /proc/acpi/thermal_zone/THRM/trip_points
> echo  2 > /proc/acpi/thermal_zone/THRM/polling_frequency
> echo ondemand > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
>=20
> to e.g. /etc/init.d/boot.local. With 2.6.22 that solution does not ex=
ist
> any longer. Now the code in thermal.c slows down the cpu under load
> to prevent "overheating". Kernel compile time increases from about 12
> to 18 minutes. No, I don=B4t like that, nobody would.
=20

Thanks for the sighting, Knut!
This regression is dramatic when put in the terms of 50% performance hi=
t!
I guess the good news is that thermal throttling is doing the job
we are asking it to:-)

The statement above regarding the existence of active trip points
and the kernel not being able to control the fan are inconsistent
with each other.

Please open a sighting for this machine here:

http://bugzilla.kernel.org/enter_bug.cgi?product=3DACPI
vs. Power-Thermal
and attach the output from acpidump, cat /proc/acpi/thermal_zone/*/*
and assign it to len.brown@intel.com

BTW. does the board boot and run properly with "acpi=3Doff"?

thanks,
-Len
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
