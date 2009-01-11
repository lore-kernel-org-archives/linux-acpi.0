From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 02/13] ACPI: thinkpad-acpi: struct device - replace bus_id with dev_name(), dev_set_name()
Date: Sun, 11 Jan 2009 03:00:59 -0200
Message-ID: <1231650070-21722-3-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:48429 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750779AbZAKFBP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 11 Jan 2009 00:01:15 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, Kay Sievers <kay.sievers@vrfy.org>

From: Kay Sievers <kay.sievers@vrfy.org>

Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>
Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
Acked-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
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
1.5.6.5

