From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: 2.6.24-rc1 acpi battery driver -> sysfs interface does not update
 correctly
Date: Sat, 27 Oct 2007 21:22:49 +0400
Message-ID: <472373E9.3040207@gmail.com>
References: <3e7b9f4b0710241114u73ad1d4bl34070b4fd2b18d63@mail.gmail.com>	 <3e7b9f4b0710241252y731aec1sd46ca8c36438e9a6@mail.gmail.com>	 <3e7b9f4b0710241323p5bbee5a8r582264d0a2b10f60@mail.gmail.com>	 <471FABF5.1030406@gmail.com>	 <3e7b9f4b0710241417i7f0edeel6d11b8a3e4048243@mail.gmail.com>	 <471FBDF5.7000906@gmail.com>	 <3e7b9f4b0710241528j403e2ecboc29e03438034349a@mail.gmail.com>	 <3e7b9f4b0710241537i1d3db590u2220900e30ae0d1b@mail.gmail.com>	 <472008C5.8030906@gmail.com>	 <3e7b9f4b0710250231p2e562989s97033ee50d2e5ec2@mail.gmail.com> <3e7b9f4b0710270952r3e7ff889qe628cf9ff0c8361e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090607050903000902060207"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:37279 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753735AbXJ0RXP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 27 Oct 2007 13:23:15 -0400
Received: by ug-out-1314.google.com with SMTP id z38so817769ugc
        for <linux-acpi@vger.kernel.org>; Sat, 27 Oct 2007 10:23:13 -0700 (PDT)
In-Reply-To: <3e7b9f4b0710270952r3e7ff889qe628cf9ff0c8361e@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ash Milsted <thatistosayiseenem@gawab.com>
Cc: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------090607050903000902060207
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Ash Milsted wrote:
> Hi again,
> I just thought I'd say that this is still occuring with the current
> linux-acpi-2.6 git tree on top of Linus' latest.. I don't get
> (dis)charge uevents and, oddly, the sysfs charge_now value is
As I remember, you did not found uevents in 2.6.23 as well?
> initially wrong on boot-up. For some reason it gives a value of about
> half the full charge of the battery (no matter what the true value is)
> until I read it a couple of times, at which point it corrects itself.
> I attach a few extra details, in case they help.
your acpidump output might be usefull at this point.
> 
> cat /sys/class/power_supply/BAT1/uevent
> POWER_SUPPLY_NAME=BAT1
> POWER_SUPPLY_TYPE=Battery
> POWER_SUPPLY_STATUS=Charging
> POWER_SUPPLY_PRESENT=1
> POWER_SUPPLY_TECHNOLOGY=Unknown
> POWER_SUPPLY_VOLTAGE_MIN_DESIGN=14800000
> POWER_SUPPLY_VOLTAGE_NOW=14800000
> POWER_SUPPLY_CURRENT_NOW=0
> POWER_SUPPLY_CHARGE_FULL_DESIGN=4000000
> POWER_SUPPLY_CHARGE_FULL=4000000
> POWER_SUPPLY_CHARGE_NOW=1960000
> POWER_SUPPLY_MODEL_NAME=PABAS005
> POWER_SUPPLY_MANUFACTURER=TOSHIBA
> 
> One odd thing about this is the TECHNOLOGY field - with the procfs
> interface it is reported as lion, not "Unknown". As before, if I any
> other info would help, just ask.
I check against "LION" (strcasecmp), so lion should be recognized.
Please take a look on dmesg with attached patch

Thanks,
Alex.

--------------090607050903000902060207
Content-Type: text/x-diff;
 name="x.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="x.patch"

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 6c06879..bcd489c 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -127,6 +127,7 @@ static int acpi_battery_technology(struct acpi_battery *battery)
 		return POWER_SUPPLY_TECHNOLOGY_LION;
 	if (!strcasecmp("LiP", battery->type))
 		return POWER_SUPPLY_TECHNOLOGY_LIPO;
+printk(KERN_ERR PREFIX "unmatched technology '%s'\n", battery->type);
 	return POWER_SUPPLY_TECHNOLOGY_UNKNOWN;
 }
 

--------------090607050903000902060207--
