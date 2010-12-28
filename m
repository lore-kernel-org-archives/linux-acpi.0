From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 1/4] ACPI / PM: Do not enable multiple devices to wake up simultaneously
Date: Tue, 28 Dec 2010 16:28:58 +0100
Message-ID: <201012281628.59239.rjw@sisk.pl>
References: <201012281625.36191.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:60271 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752263Ab0L1PcZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 28 Dec 2010 10:32:25 -0500
In-Reply-To: <201012281625.36191.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>

From: Rafael J. Wysocki <rjw@sisk.pl>

If a device is enabled to wake up the system from sleep states via
/proc/acpi/wakeup and there are other devices associated with the
same wakeup GPE, all of these devices are automatically enabled to
wake up the system.  This isn't correct, because the fact that the
GPE is shared need not imply that wakeup power has to be enabled for
all the devices at the same time (i.e. it is possible that one device
will have its wakeup power enabled and it will wake up the system
from sleep states if the shared wakeup GPE is enabled, while another
device having its wakeup power disabled will not wake up the system
even though the GPE is enabled).

Rework acpi_system_write_wakeup_device() so that it only enables
wakeup for one device at a time.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/proc.c |   26 +-------------------------
 1 file changed, 1 insertion(+), 25 deletions(-)

Index: linux-2.6/drivers/acpi/proc.c
===================================================================
--- linux-2.6.orig/drivers/acpi/proc.c
+++ linux-2.6/drivers/acpi/proc.c
@@ -341,7 +341,6 @@ acpi_system_write_wakeup_device(struct f
 	char strbuf[5];
 	char str[5] = "";
 	unsigned int len = count;
-	struct acpi_device *found_dev = NULL;
 
 	if (len > 4)
 		len = 4;
@@ -363,33 +362,10 @@ acpi_system_write_wakeup_device(struct f
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

