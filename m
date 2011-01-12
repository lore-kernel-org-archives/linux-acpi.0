From: Len Brown <lenb@kernel.org>
Subject: [PATCH 20/48] ACPI / PM: Do not enable multiple devices to wake up
 simultaneously
Date: Wed, 12 Jan 2011 05:19:14 -0500
Message-ID: <b014f4f1aad3f25d5c7d877a394869645ea0c96b.1294827492.git.len.brown@intel.com>
References: <1294827582-4620-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:49045 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752988Ab1ALSAN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jan 2011 13:00:13 -0500
Received: from localhost.localdomain ([unknown] [108.7.58.61])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LEX007SA8OAUAI1@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 12 Jan 2011 12:00:12 -0600 (CST)
In-reply-to: <1294827582-4620-1-git-send-email-lenb@kernel.org>
In-reply-to: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1294827492.git.len.brown@intel.com>
References: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1294827492.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

If a device is enabled to wake up the system from sleep states via
/proc/acpi/wakeup and there are other devices associated with the
same wakeup GPE, all of these devices are automatically enabled to
wake up the system.  This isn't correct, because the fact the GPE is
shared need not imply that wakeup power has to be enabled for all the
devices at the same time (i.e. it is possible that one device will
have its wakeup power enabled and it will wake up the system from a
sleep state if the shared wakeup GPE is enabled, while another device
having its wakeup power disabled will not wake up the system even
though the GPE is enabled).  Rework acpi_system_write_wakeup_device()
so that it only enables wakeup for one device at a time.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/proc.c |   26 +-------------------------
 1 files changed, 1 insertions(+), 25 deletions(-)

diff --git a/drivers/acpi/proc.c b/drivers/acpi/proc.c
index afad677..129effb 100644
--- a/drivers/acpi/proc.c
+++ b/drivers/acpi/proc.c
@@ -341,7 +341,6 @@ acpi_system_write_wakeup_device(struct file *file,
 	char strbuf[5];
 	char str[5] = "";
 	unsigned int len = count;
-	struct acpi_device *found_dev = NULL;
 
 	if (len > 4)
 		len = 4;
@@ -363,33 +362,10 @@ acpi_system_write_wakeup_device(struct file *file,
 		if (!strncmp(dev->pnp.bus_id, str, 4)) {
 			dev->wakeup.state.enabled =
 			    dev->wakeup.state.enabled ? 0 : 1;
-			found_dev = dev;
+			physical_device_enable_wakeup(dev);
 			break;
 		}
 	}
-	if (found_dev) {
-		physical_device_enable_wakeup(found_dev);
-		list_for_each_safe(node, next, &acpi_wakeup_device_list) {
-			struct acpi_device *dev = container_of(node,
-							       struct
-							       acpi_device,
-							       wakeup_list);
-
-			if ((dev != found_dev) &&
-			    (dev->wakeup.gpe_number ==
-			     found_dev->wakeup.gpe_number)
-			    && (dev->wakeup.gpe_device ==
-				found_dev->wakeup.gpe_device)) {
-				printk(KERN_WARNING
-				       "ACPI: '%s' and '%s' have the same GPE, "
-				       "can't disable/enable one separately\n",
-				       dev->pnp.bus_id, found_dev->pnp.bus_id);
-				dev->wakeup.state.enabled =
-				    found_dev->wakeup.state.enabled;
-				physical_device_enable_wakeup(dev);
-			}
-		}
-	}
 	mutex_unlock(&acpi_device_lock);
 	return count;
 }
-- 
1.7.4.rc1.7.g2cf08

