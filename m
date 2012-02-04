From: Kamil Iskra <kamil.54002@iskra.name>
Subject: Patch to correct battery capacity values on Thinkpads
Date: Fri, 3 Feb 2012 23:59:55 -0600
Message-ID: <20120204055955.GB5617@scooby.iskra.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from scooby.iskra.name ([184.171.245.232]:33819 "EHLO
	mail.iskra.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751152Ab2BDG0z (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 4 Feb 2012 01:26:55 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, lenb@kernel.org

[ Note: this is a follow-up on
https://bugzilla.kernel.org/show_bug.cgi?id=41062 ]

Please find below a patch to drivers/acpi/battery.c that adds a quirk to
correctly report battery capacity on recent Lenovo Thinkpad models.  The
2010 and 2011 Thinkpad models that I tested (x201, t410, t410s, and x220)
exhibit a problem where, when battery capacity reporting unit is mAh, the
values being reported are wrong.

For some reason, these Thinkpads switch the reporting unit between mAh and
mWh; generally, mAh is used when a laptop is plugged in and mWh when it's
unplugged, although a suspend/resume or rmmod/modprobe is needed for the
switch to take an effect.

Anyway, the values reported in mAh are *always* wrong.  I tested back to
kernel 2.6.34, with multiple machines and BIOS versions.  Simply plugging a
laptop into mains before turning it on is enough to reproduce the problem.
Here's a sample /proc/acpi/battery/BAT0/info from Thinkpad x220 with a
4-cell battery:

present:                 yes
design capacity:         2886 mAh
last full capacity:      2909 mAh
battery technology:      rechargeable
design voltage:          14800 mV
design capacity warning: 145 mAh
design capacity low:     13 mAh
cycle count:              0
capacity granularity 1:  1 mAh
capacity granularity 2:  1 mAh
model number:            42T4899
serial number:           21064
battery type:            LION
OEM info:                SANYO

Once the laptop switches the unit to mWh, the output changes to:

present:                 yes
design capacity:         28860 mWh
last full capacity:      29090 mWh
battery technology:      rechargeable
design voltage:          14800 mV
design capacity warning: 1454 mWh
design capacity low:     200 mWh
cycle count:              0
capacity granularity 1:  1 mWh
capacity granularity 2:  1 mWh
model number:            42T4899
serial number:           21064
battery type:            LION
OEM info:                SANYO

Can you see how the values for "design capacity", etc., differ by a factor
of 10 instead of 14.8 (the design voltage of this battery)?  On the battery
itself it says: 14.8V, 1.95Ah, 29Wh, so clearly the values reported in mWh
are correct and the ones in mAh are not.

My guess is that this problem has been around ever since those machines
have been released, but because the most common Thinkpad batteries are
rated at 10.8V, the error (8%) is small enough that it simply hasn't been
noticed or at least nobody could be bothered to look into it.

Pre-2010 Thinkpads (tested with t42, t61, t500, x200, x300) appear to
always report in mWh, so they should be fine.

My patch works around the problem by adjusting the incorrectly reported mAh
values by "10000 / design_voltage".  The patch also has code to figure out
if it should be activated or not.  The patch only activates on Lenovo
Thinkpads, and only when the battery capacity reported through ACPI does
not match what is reported through DMI.  It should thus be safe on all
machines, including future models.

I've been using this patch for sever months on several systems without any
problems.  I believe it is ready to be applied, although I lack kernel
hacking experience to make that determination.  Obviously, a better
solution would be to somehow force the machines to always report the
battery capacity in mWh, which does not require correction and would thus
make this patch unnecessary, but I have no idea how to do that or if it is
even possible at all.

Note that I'm not on the list so I would appreciate a Cc on any replies.  I
will also try to monitor the list archives.

Kamil Iskra


--- battery.c.orig	2011-08-08 21:47:15.812854942 -0500
+++ battery.c	2011-09-03 23:16:02.203031764 -0500
@@ -34,6 +34,7 @@
 #include <linux/dmi.h>
 #include <linux/slab.h>
 #include <linux/suspend.h>
+#include <asm/unaligned.h>
 
 #ifdef CONFIG_ACPI_PROCFS_POWER
 #include <linux/proc_fs.h>
@@ -95,6 +96,14 @@ enum {
 	ACPI_BATTERY_ALARM_PRESENT,
 	ACPI_BATTERY_XINFO_PRESENT,
 	ACPI_BATTERY_QUIRK_PERCENTAGE_CAPACITY,
+	/* Starting with the 2010 Lenovo Thinkpad models, the power unit
+	   switches between mWh and mAh depending on whether the system
+	   is running on battery or not.  When mAh is the unit, most
+	   reported values are incorrect and need to be adjusted by
+	   10000/design_voltage.  Verified on x201, t410, t410s, and x220.
+	   It appears that the pre-2010 Thinkpads always report in mWh and
+	   are thus unaffected (tested with t42, t61, t500, x200, x300).  */
+	ACPI_BATTERY_QUIRK_THINKPAD_MAH,
 };
 
 struct acpi_battery {
@@ -429,6 +438,21 @@ static int acpi_battery_get_info(struct
 	kfree(buffer.pointer);
 	if (test_bit(ACPI_BATTERY_QUIRK_PERCENTAGE_CAPACITY, &battery->flags))
 		battery->full_charge_capacity = battery->design_capacity;
+	if (test_bit(ACPI_BATTERY_QUIRK_THINKPAD_MAH, &battery->flags) &&
+	    battery->power_unit && battery->design_voltage) {
+		battery->design_capacity = battery->design_capacity *
+		    10000 / battery->design_voltage;
+		battery->full_charge_capacity = battery->full_charge_capacity *
+		    10000 / battery->design_voltage;
+		battery->design_capacity_warning =
+		    battery->design_capacity_warning *
+		    10000 / battery->design_voltage;
+		/* Curiously, design_capacity_low, unlike the rest of them,
+		   is correct.  */
+		/* capacity_granularity_* equal 1 on the systems tested, so
+		   it's impossible to tell if they would need an adjustment
+		   or not if their values were higher.  */
+	}
 	return result;
 }
 
@@ -477,6 +501,11 @@ static int acpi_battery_get_state(struct
 	    && battery->capacity_now >= 0 && battery->capacity_now <= 100)
 		battery->capacity_now = (battery->capacity_now *
 				battery->full_charge_capacity) / 100;
+	if (test_bit(ACPI_BATTERY_QUIRK_THINKPAD_MAH, &battery->flags) &&
+	    battery->power_unit && battery->design_voltage) {
+		battery->capacity_now = battery->capacity_now *
+		    10000 / battery->design_voltage;
+	}
 	return result;
 }
 
@@ -586,6 +615,24 @@ static void sysfs_remove_battery(struct
 	mutex_unlock(&battery->sysfs_lock);
 }
 
+static void find_battery(const struct dmi_header *dm, void *private)
+{
+	struct acpi_battery *battery = (struct acpi_battery *)private;
+	/* Note: the hardcoded offsets below have been extracted from
+	   the source code of dmidecode.  */
+	if (dm->type == DMI_ENTRY_PORTABLE_BATTERY && dm->length >= 8) {
+		const u8 *dmi_data = (const u8 *)(dm + 1);
+		int dmi_capacity = get_unaligned((const u16 *)(dmi_data + 6));
+		if (dm->length >= 18)
+			dmi_capacity *= dmi_data[17];
+		if (battery->design_capacity * battery->design_voltage / 1000
+		    != dmi_capacity &&
+		    battery->design_capacity * 10 == dmi_capacity)
+			set_bit(ACPI_BATTERY_QUIRK_THINKPAD_MAH,
+				&battery->flags);
+	}
+}
+
 /*
  * According to the ACPI spec, some kinds of primary batteries can
  * report percentage battery remaining capacity directly to OS.
@@ -611,6 +658,32 @@ static void acpi_battery_quirks(struct a
 		battery->capacity_now = (battery->capacity_now *
 				battery->full_charge_capacity) / 100;
 	}
+
+	if (test_bit(ACPI_BATTERY_QUIRK_THINKPAD_MAH, &battery->flags))
+		return ;
+
+	if (battery->power_unit && dmi_name_in_vendors("LENOVO")) {
+		const char *s;
+		s = dmi_get_system_info(DMI_PRODUCT_VERSION);
+		if (s && !strnicmp(s, "ThinkPad", 8)) {
+			dmi_walk(find_battery, battery);
+			if (test_bit(ACPI_BATTERY_QUIRK_THINKPAD_MAH,
+				     &battery->flags) &&
+			    battery->design_voltage) {
+				battery->design_capacity =
+				    battery->design_capacity *
+				    10000 / battery->design_voltage;
+				battery->full_charge_capacity =
+				    battery->full_charge_capacity *
+				    10000 / battery->design_voltage;
+				battery->design_capacity_warning =
+				    battery->design_capacity_warning *
+				    10000 / battery->design_voltage;
+				battery->capacity_now = battery->capacity_now *
+				    10000 / battery->design_voltage;
+			}
+		}
+	}
 }
 
 static int acpi_battery_update(struct acpi_battery *battery)
