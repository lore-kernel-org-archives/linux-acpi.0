From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 0/4] ACPI: Battery hotplug support
Date: Thu, 17 Jan 2008 09:19:23 +0800
Message-ID: <1200532763.2935.66.camel@acpi-sony.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:15339 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752262AbYAQBOE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Jan 2008 20:14:04 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, astarikovskiy@suse.de

Hi, all,

This patch series is for battery hotplug support.
Please refer to http://bugzilla.kernel.org/show_bug.cgi?id=2884

Patch 01 flushes kacpi_notify_wq before removing the notify handler
	 as well as the kacpid_wq.
Patch 02 adds a new acpi execute type, OSL_DEVICE_HOTPLUG_HANDLER,
	 This is used for the device hotplug notify handler which will be
	 queued in keventd_wq so that it can flush the kacpi_notify_wq.
Patch 03 support battery hotplug in the global system-level notify handler
	 acpi_bus_notify.
Patch 04 fix the deadlock when pokiing the "eject" sysfs attribute
	 which is used to eject a device in user space.

I've tested this patch set on my t43 laptop and it works well.
Any comment is appreciated. :)

Thanks,
Rui

