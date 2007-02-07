From: Len Brown <lenb@kernel.org>
Subject: [PATCH 39/140] ACPI: delete unused acpi_device_get_debug_info()
Date: Wed,  7 Feb 2007 13:50:53 -0500
Message-ID: <11708744253790-git-send-email-lenb@kernel.org>
References: <11708743541314-git-send-email-lenb@kernel.org> <11708743561383-git-send-email-lenb@kernel.org> <117087435785-git-send-email-lenb@kernel.org> <11708743582090-git-send-email-lenb@kernel.org> <11708743611662-git-send-email-lenb@kernel.org> <11708743653073-git-send-email-lenb@kernel.org> <11708743674006-git-send-email-lenb@kernel.org> <11708743693386-git-send-email-lenb@kernel.org> <11708743702194-git-send-email-lenb@kernel.org> <11708743723353-git-send-email-lenb@kernel.org> <11708743783727-git-send-email-lenb@kernel.org> <11708743802558-git-send-email-lenb@kernel.org> <11708743821259-git-send-email-lenb@kernel.org> <11708743853573-git-send-email-lenb@kernel.org> <11708743871468-git-send-email-lenb@kernel.org> <1170874390715-git-send-email-lenb@kernel.org> <1170874393736-git-send-email-lenb@kernel.org> <11708743943108-git-send-email-lenb@kernel.org> <11708743962377-git-send-ema
 il-lenb@kernel.org> <11708743972593-git-send-email-lenb@kernel.org> <1170874398386-git-send-email-lenb@kernel.org> <11708743993414-git-send-email-lenb@kernel.org> <11708744003959-git-send-email-lenb@kernel.org> <11708744023872-git-send-email-lenb@kernel.org> <11708744032427-git-send-email-lenb@kernel.org> <11708744053556-git-send-email-lenb@kernel.org> <11708744062538-git-send-email-lenb@kernel.org> <11708744071019-git-send-email-lenb@kernel.org> <11708744093818-git-send-email-lenb@kernel.org> <11708744101300-git-send-email-lenb@kernel.org> <1170874412494-git-send-email-lenb@kernel.org> <11708744142658-git-send-email-lenb@kernel.org> <1170874415464-git-send-email-lenb@kernel.org> <1170874417392-git-send-email-lenb@kernel.org> <1170874418134-git-send-email-lenb@kernel.org> <11708744191642-git-send-email-lenb@kernel.org> <11708744203492-git-send-email-lenb@kernel.org> <1170874421658-git-
 send-email-lenb@kernel.org> <1170874422581-git-send-email-lenb@kernel.org> <117087442385-git-send-email-lenb@kernel.org> <1170874424332-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:31476 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422759AbXBGSx7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 13:53:59 -0500
In-Reply-To: <1170874424332-git-send-email-lenb@kernel.org>
Message-Id: <7ac2735462349ca35d8807d93d66cf4d9ea7b729.1170873816.git.len.brown@intel.com>
In-Reply-To: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
References: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/scan.c |   45 ---------------------------------------------
 1 files changed, 0 insertions(+), 45 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 0bd788a..2e0fc8c 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -888,49 +888,6 @@ static int acpi_device_set_context(struct acpi_device *device, int type)
 	return result;
 }
 
-static void acpi_device_get_debug_info(struct acpi_device *device,
-				       acpi_handle handle, int type)
-{
-#ifdef ACPI_DEBUG_OUTPUT
-	char *type_string = NULL;
-	char name[80] = { '?', '\0' };
-	struct acpi_buffer buffer = { sizeof(name), name };
-
-	switch (type) {
-	case ACPI_BUS_TYPE_DEVICE:
-		type_string = "Device";
-		acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer);
-		break;
-	case ACPI_BUS_TYPE_POWER:
-		type_string = "Power Resource";
-		acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer);
-		break;
-	case ACPI_BUS_TYPE_PROCESSOR:
-		type_string = "Processor";
-		acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer);
-		break;
-	case ACPI_BUS_TYPE_SYSTEM:
-		type_string = "System";
-		acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer);
-		break;
-	case ACPI_BUS_TYPE_THERMAL:
-		type_string = "Thermal Zone";
-		acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer);
-		break;
-	case ACPI_BUS_TYPE_POWER_BUTTON:
-		type_string = "Power Button";
-		sprintf(name, "PWRB");
-		break;
-	case ACPI_BUS_TYPE_SLEEP_BUTTON:
-		type_string = "Sleep Button";
-		sprintf(name, "SLPB");
-		break;
-	}
-
-	printk(KERN_DEBUG "Found %s %s [%p]\n", type_string, name, handle);
-#endif				/* ACPI_DEBUG_OUTPUT */
-}
-
 static int acpi_bus_remove(struct acpi_device *dev, int rmdevice)
 {
 	int result = 0;
@@ -1076,8 +1033,6 @@ acpi_add_single_object(struct acpi_device **child,
 	if ((result = acpi_device_set_context(device, type)))
 		goto end;
 
-	acpi_device_get_debug_info(device, handle, type);
-
 	acpi_device_register(device, parent);
 
 	/*
-- 
1.5.0.rc3.39.gec804
