From: Christoph Groth <cwg@falma.de>
Subject: /sys/class/power_supply/BAT0/ confusion
Date: Sat, 05 Nov 2011 09:46:46 +0100
Message-ID: <87wrbfot1l.fsf@falma.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:59607 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751059Ab1KEIuL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 5 Nov 2011 04:50:11 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-acpi-devel@m.gmane.org>)
	id 1RMbx3-0007WY-HC
	for linux-acpi@vger.kernel.org; Sat, 05 Nov 2011 09:50:09 +0100
Received: from dra38-5-82-246-248-175.fbx.proxad.net ([82.246.248.175])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Sat, 05 Nov 2011 09:50:09 +0100
Received: from cwg by dra38-5-82-246-248-175.fbx.proxad.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Sat, 05 Nov 2011 09:50:09 +0100
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello,

I'm running kernel 3.0.0 from Debian testing.  On my new Thinkpad X220,
I noticed that the "acpi" command gives way too optimistic "remaining
time on battery" estimates.

To calculate the remaining time, the "acpi" tools divides the
"charge_now" value by "current_now" which seems to make sense physicall=
y
if the units of these values would be what the names imply.  However,
this gives a remaining time of 5.35 hours which is way too high for the
small 4 cell battery I have.

Let's look at a snapshot of the BAT0 directory:

/sys/class/power_supply/BAT0% grep . *
alarm:156000
charge_full:3135000
charge_full_design:2886000
charge_now:2761000
current_now:516000
cycle_count:0
manufacturer:SANYO
model_name:42T4899
present:1
serial_number:19797
status:Discharging
technology:Li-ion
type:Battery
uevent:POWER_SUPPLY_NAME=3DBAT0
uevent:POWER_SUPPLY_STATUS=3DDischarging
uevent:POWER_SUPPLY_PRESENT=3D1
uevent:POWER_SUPPLY_TECHNOLOGY=3DLi-ion
uevent:POWER_SUPPLY_CYCLE_COUNT=3D0
uevent:POWER_SUPPLY_VOLTAGE_MIN_DESIGN=3D14800000
uevent:POWER_SUPPLY_VOLTAGE_NOW=3D15993000
uevent:POWER_SUPPLY_CURRENT_NOW=3D516000
uevent:POWER_SUPPLY_CHARGE_FULL_DESIGN=3D2886000
uevent:POWER_SUPPLY_CHARGE_FULL=3D3135000
uevent:POWER_SUPPLY_CHARGE_NOW=3D2761000
uevent:POWER_SUPPLY_MODEL_NAME=3D42T4899
uevent:POWER_SUPPLY_MANUFACTURER=3DSANYO
uevent:POWER_SUPPLY_SERIAL_NUMBER=3D19797
voltage_min_design:14800000
voltage_now:15993000

The nominal energy capacity of my battery is 29 Wh, so charge_now seems
to be in units of 10 =C2=B5Wh! (Yes, charge_now =3D=3D 2761000 seems to=
 mean that
the _energy_ is 27.61 Wh.)  This is bogus!

current_now and voltage_now seem to be in the reasonable units =C2=B5A =
and
=C2=B5V, as

current_now * voltage_now * 1e-12 =3D 8.25

which seems to be the correct power in Watts.  (This is also the power
which "powertop" is reporting.)

The remaining runtime in hours in my case seems to be given by

charge_now * 1e-5 / (current_now * voltage_now * 1e-12) =3D 3.35

which looks like a good estimate of the real situation.


This does not seem to be the way things are supposed to be.  The kernel
source file include/linux/power_supply.h states

/*
 * All voltages, currents, charges, energies, time and temperatures in =
uV,
 * =C2=B5A, =C2=B5Ah, =C2=B5Wh, seconds and tenths of degree Celsius un=
less otherwise
 * stated. It's driver's job to convert its raw values to units in whic=
h
 * this class operates.
 */

So this seems to be a bug of either the battery driver or the internal
battery software.

I hope this report will be useful for linux ACPI developers.

Christoph

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
