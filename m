From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 0/6] [-mm]: ACPI: duplicate ACPI procfs functions in
	sysfs
Date: Thu, 18 Jan 2007 14:53:02 +0800
Message-ID: <1169103182.1585.67.camel@localhost.localdomain>
References: <1168083306.5619.34.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:14548 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751909AbXARGw1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 18 Jan 2007 01:52:27 -0500
In-Reply-To: <1168083306.5619.34.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: "linux-acpi@vger" <linux-acpi@vger.kernel.org>, david-b@pacbell.net, mjg59@srcf.ucam.org, pavel@ucw.cz, randy.dunlap@oracle.com, fiodor.f.suietov@intel.com

> Patch 01:
> 	add a Kconfig option which is used to make ACPI procfs interface configurable.
> 	This will be used by all the following sysfs conversion patches.
> 
> Patch 02:
> 	add ACPI debug attribute in sysfs.
> 	By applying this patch, /proc/acpi/debug_layer && debug_level is deprecated by
> 	/sys/module/acpi/parameter/debug_layer && debug_level.
> 
> Patch 03-05:
> 	add ACPI sleep attributes in sysfs.
> 	/proc/acpi/sleep is already deprecated by /sys/power/state.
> 	/proc/acpi/alarm is deprecated by /sys/power/alarm.
> 	For those devices that support "wake" attribute, two files, "sleep_state" and "wakeup", are created for these devices.
> 	"sleep_state" indicates the lowest sleeping state that can be entered while still providing wake functionality.
> 	"wakeup" can be used to enable/disable the device's ability to wake a sleeping system.
> 	So /proc/acpi/wakeup is deprecated by /sys/devices/acpi_system/.../xxx/sleep_state && wakeup.
> 
Len,
Now, I'm thinking of dropping patch 03-05.
"alarm" is ACPI specific and /sys/power/alarm is not a good idea.
In addition, it can't handle multiple RTCs as David described.
So, if the new rtc-cmos driver written by David works well,
this's not needed any more. :)

"wakeup" attribute for ACPI wakeup devices is in the wish list.
	1. Try to map ACPI devices to the physical devices.
	   It's not very easy, as we can not find a generic method to
	   map ACPI wakeup devices to physical devices. So I have to
	   divide them into several groups, e.g. PCI, legacy serial,
	   legacy PS2, etc. And verify which group the ACPI device 
	   belongs to.
	2. add "wakeup" properly to /sys/device/(not ACPI)/...
	   I'll investigate the possibility of integrating this one into
	   /sys/device/.../power/wakeup.
	3. consolidate all wakeup devices in one place for convenience.
	   E.g. /sys/power/wakeup/, symbolic links with useful names.
	   (note that links here are from "real" devices node in sysfs,
	   so it's a generic interface for systems both w/ and w/o ACPI)
	4. remove /proc/acpi/wakeup,
	   since it's replaced by /sys/power/wakeup/...
> Patch 06:
> 	add ACPI info in sysfs which indicates ACPICA version.
> 	/sys/firmware/acpi/info is create and /proc/acpi/info is marked as deprecated.
I'll refresh the patch 01,02,06 and resend them.
Thanks for your comments, David, Matthew, Pavel, Randy and Suietov. :)
