From: Christoph Groth <cwg@falma.de>
Subject: Re: /sys/class/power_supply/BAT0/ confusion
Date: Sun, 13 Nov 2011 10:45:55 +0100
Message-ID: <87ty68bbjg.fsf@falma.de>
References: <87wrbfot1l.fsf@falma.de>
	<625BA99ED14B2D499DC4E29D8138F1506526C6FC7E@shsmsx502.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:32856 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751754Ab1KMJqJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 13 Nov 2011 04:46:09 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-acpi-devel@m.gmane.org>)
	id 1RPWdZ-0007Cj-JV
	for linux-acpi@vger.kernel.org; Sun, 13 Nov 2011 10:46:05 +0100
Received: from dra38-5-82-246-248-175.fbx.proxad.net ([82.246.248.175])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Sun, 13 Nov 2011 10:46:05 +0100
Received: from cwg by dra38-5-82-246-248-175.fbx.proxad.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Sun, 13 Nov 2011 10:46:05 +0100
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: tianyu.lan@intel.com

"Lan, Tianyu" <tianyu.lan@intel.com> writes:

> 	The unit of charge_now is =C2=B5A.
> 	What is data shown on the battery?
> 	29 Wh?
> 	Can you test on 3.1 or higher version?=20

I tested v3.2-rc1-282-g3439a8d

The problem is still the same.  After suspend to RAM the presented
interface changes and everything seems OK.

I attach the outputs of "date; grep . *" taken in the
/sys/class/power_supply/BAT0/ directory and a third one taken after
waking up from suspend to RAM.

Christoph


################ running on battery, after boot
Sun Nov 13 10:14:27 CET 2011
alarm:156000
charge_full:3132000
charge_full_design:2886000
charge_now:2970000
current_now:469000
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
uevent:POWER_SUPPLY_VOLTAGE_NOW=3D16162000
uevent:POWER_SUPPLY_CURRENT_NOW=3D469000
uevent:POWER_SUPPLY_CHARGE_FULL_DESIGN=3D2886000
uevent:POWER_SUPPLY_CHARGE_FULL=3D3132000
uevent:POWER_SUPPLY_CHARGE_NOW=3D2970000
uevent:POWER_SUPPLY_MODEL_NAME=3D42T4899
uevent:POWER_SUPPLY_MANUFACTURER=3DSANYO
uevent:POWER_SUPPLY_SERIAL_NUMBER=3D19797
voltage_min_design:14800000
voltage_now:16162000

################ running on battery, after boot, a few minutes later
Sun Nov 13 10:18:42 CET 2011
alarm:156000
charge_full:3132000
charge_full_design:2886000
charge_now:2909000
current_now:470000
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
uevent:POWER_SUPPLY_VOLTAGE_NOW=3D16132000
uevent:POWER_SUPPLY_CURRENT_NOW=3D470000
uevent:POWER_SUPPLY_CHARGE_FULL_DESIGN=3D2886000
uevent:POWER_SUPPLY_CHARGE_FULL=3D3132000
uevent:POWER_SUPPLY_CHARGE_NOW=3D2909000
uevent:POWER_SUPPLY_MODEL_NAME=3D42T4899
uevent:POWER_SUPPLY_MANUFACTURER=3DSANYO
uevent:POWER_SUPPLY_SERIAL_NUMBER=3D19797
voltage_min_design:14800000
voltage_now:16132000

################ running on battery, after wakeup from suspend to RAM
Sun Nov 13 10:26:02 CET 2011
alarm:1566000
cycle_count:0
energy_full:31320000
energy_full_design:28860000
energy_now:27770000
manufacturer:SANYO
model_name:42T4899
power_now:7746000
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
uevent:POWER_SUPPLY_VOLTAGE_NOW=3D16006000
uevent:POWER_SUPPLY_POWER_NOW=3D7746000
uevent:POWER_SUPPLY_ENERGY_FULL_DESIGN=3D28860000
uevent:POWER_SUPPLY_ENERGY_FULL=3D31320000
uevent:POWER_SUPPLY_ENERGY_NOW=3D27770000
uevent:POWER_SUPPLY_MODEL_NAME=3D42T4899
uevent:POWER_SUPPLY_MANUFACTURER=3DSANYO
uevent:POWER_SUPPLY_SERIAL_NUMBER=3D19797
voltage_min_design:14800000
voltage_now:16006000

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
