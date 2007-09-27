From: Zhang Rui <rui.zhang@intel.com>
Subject: Bug: linux/acpi may execute notify handler that has been removed
Date: Thu, 27 Sep 2007 11:30:33 +0800
Message-ID: <1190863833.26892.63.camel@acpi-hp.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:36044 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751579AbXI0DZI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 26 Sep 2007 23:25:08 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: rebort.moore@intel.com, astarikovskiy@suse.de

Hi, all,

I found a bug that linux/acpi may execute notify handler that
has been removed.

When a system notify(0~0x7f) is received, linux/acpi will
first invoke the generic system notify handler (acpi_bus_notify)
and then invoke the per-device notify handler if present.

In my case, I add some code in acpi_bus_notify for battery
hotplug support, so that the generic system notify handler will
remove the battery device, including the per-device notify handler
acpi_battery_notify() when receiving notification
ACPI_NOTIFY_EJECT_REQUEST.
But linux/acpi invokes the per-device notify handler soon and
this breaks the system.

Further more, device hot-removal is not the only case to encounter
this bug. For example, linux/acpi receives a notification and adds it
in the workqueue, and then the driver(notify handler) is removed
before kacpid_notify invoke it...

Attachment is the patch for battery hotplug support.
Any ideas about this bug?

Thanks,
Rui
