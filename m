From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 0/3] [-mm]: ACPI: duplicate ACPI procfs functions in sysfs
Date: Sun, 21 Jan 2007 13:48:41 +0800
Message-ID: <1169358521.5691.2.camel@localhost.localdomain>
References: <1168083306.5619.34.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:23003 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751197AbXAUFr6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 21 Jan 2007 00:47:58 -0500
In-Reply-To: <1168083306.5619.34.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: "linux-acpi@vger" <linux-acpi@vger.kernel.org>

This patch set is against acpi-test sysfs branch,
and will duplicate several ACPI procfs functions in sysfs.

Patch 01:
add a Kconfig option to make ACPI procfs configurable.
This will be used by all the following sysfs conversion patches.

Patch 02:
add ACPI debug attribute in sysfs.
/proc/acpi/debug_layer && debug_level is deprecated by
/sys/module/acpi/parameter/debug_layer && debug_level.

Patch 03:
add ACPICA version in sysfs.
/proc/acpi/info is deprecated by /sys/firmware/acpi/version.

Wish list:

Sysfs interfaces for all the ACPI tables, like the multiple ssdts and
dynamic loaded ssdts, which are likely to be listed under
/sys/firmware/acpi/tables/...

"wakeup" attribute for ACPI wakeup devices.
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
