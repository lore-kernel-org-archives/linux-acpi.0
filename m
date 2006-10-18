From: Yasunori Goto <y-goto@jp.fujitsu.com>
Subject: [PATCH](acpi:memory hotplug) Change log level of a message of acpi_memhotplug to KERN_DEBUG
Date: Wed, 18 Oct 2006 23:21:10 +0900
Message-ID: <20061018230110.2AE0.Y-GOTO@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:36564 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1030256AbWJROVZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 18 Oct 2006 10:21:25 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com>, ACPI-ML <linux-acpi@vger.kernel.org>, Linux Hotplug Memory Support <lhms-devel@lists.sourceforge.net>, Linux Kernel ML <linux-kernel@vger.kernel.org>

This patch may be a bit trivial. But, I suppose this message seems
quite useless except debugging. It just shows "Hotplug Mem Device".
System admin can't know anything by this message.
So, I would like to change it to KERN_DEBUG.

This patch is for 2.6.19-rc2.

Please apply.

Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>

---
 drivers/acpi/acpi_memhotplug.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

---

Index: linux-2.6.18/drivers/acpi/acpi_memhotplug.c
===================================================================
--- linux-2.6.18.orig/drivers/acpi/acpi_memhotplug.c	2006-10-18 22:50:44.000000000 +0900
+++ linux-2.6.18/drivers/acpi/acpi_memhotplug.c	2006-10-18 22:51:47.000000000 +0900
@@ -416,7 +416,7 @@
 	/* Set the device state */
 	mem_device->state = MEMORY_POWER_ON_STATE;
 
-	printk(KERN_INFO "%s \n", acpi_device_name(device));
+	printk(KERN_DEBUG "%s \n", acpi_device_name(device));
 
 	return result;
 }

-- 
Yasunori Goto 


