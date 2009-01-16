From: Len Brown <lenb@kernel.org>
Subject: [PATCH 02/23] ACPI: thinkpad-acpi: struct device - replace bus_id with
 dev_name(), dev_set_name()
Date: Fri, 16 Jan 2009 15:24:51 -0500
Message-ID: <e0b36fc5efd610a208b6b80e821a49302ca424ab.1232137452.git.len.brown@intel.com>
References: <1232137512-17327-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:60431 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758756AbZAPUZW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Jan 2009 15:25:22 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173009.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KDK008QRZ66MLT3@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 16 Jan 2009 14:20:30 -0600 (CST)
In-reply-to: <1232137512-17327-1-git-send-email-lenb@kernel.org>
In-reply-to: <9abf0eea877d6107d3a8a5c6913450e961fb7050.1232137452.git.len.brown@intel.com>
References: <9abf0eea877d6107d3a8a5c6913450e961fb7050.1232137452.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Kay Sievers <kay.sievers@vrfy.org>, Len Brown <len.brown@intel.com>

From: Kay Sievers <kay.sievers@vrfy.org>

Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>
Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
Acked-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/thinkpad_acpi.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 3478453..ee3fa00 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -2375,7 +2375,7 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 		/* forward it to userspace, maybe it knows how to handle it */
 		acpi_bus_generate_netlink_event(
 					ibm->acpi->device->pnp.device_class,
-					ibm->acpi->device->dev.bus_id,
+					dev_name(&ibm->acpi->device->dev),
 					event, 0);
 		return;
 	}
@@ -2505,7 +2505,7 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 		if (!ignore_acpi_ev && send_acpi_ev) {
 			acpi_bus_generate_netlink_event(
 					ibm->acpi->device->pnp.device_class,
-					ibm->acpi->device->dev.bus_id,
+					dev_name(&ibm->acpi->device->dev),
 					event, hkey);
 		}
 	}
@@ -3724,7 +3724,7 @@ static void dock_notify(struct ibm_struct *ibm, u32 event)
 	}
 	acpi_bus_generate_proc_event(ibm->acpi->device, event, data);
 	acpi_bus_generate_netlink_event(ibm->acpi->device->pnp.device_class,
-					  ibm->acpi->device->dev.bus_id,
+					  dev_name(&ibm->acpi->device->dev),
 					  event, data);
 }
 
@@ -3826,7 +3826,7 @@ static void bay_notify(struct ibm_struct *ibm, u32 event)
 {
 	acpi_bus_generate_proc_event(ibm->acpi->device, event, 0);
 	acpi_bus_generate_netlink_event(ibm->acpi->device->pnp.device_class,
-					  ibm->acpi->device->dev.bus_id,
+					  dev_name(&ibm->acpi->device->dev),
 					  event, 0);
 }
 
-- 
1.5.6.6

