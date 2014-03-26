From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH] Revert "ACPI / processor: Make it possible to get APIC ID via GIC"
Date: Wed, 26 Mar 2014 08:36:23 +0800
Message-ID: <1395794183-28098-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:57785 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753126AbaCZAgn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Mar 2014 20:36:43 -0400
Received: by mail-pd0-f172.google.com with SMTP id p10so1156281pdj.3
        for <linux-acpi@vger.kernel.org>; Tue, 25 Mar 2014 17:36:43 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Sudeep Holla <Sudeep.Holla@arm.com>, linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, Hanjun Guo <hanjun.guo@linaro.org>

This reverts commit df86f5df79d8c2035a88fb985925e49475c0cdca.

APIC ID refers the hardware ID of the CPU, which means MPIDR on
ARM/ARM64, but in ACPI 5.0, GIC ID feild in GIC structure have
no explicit definition and may not refer to the MPIDR.

This patch just assume gic->gic_id as MPIDR which is not suitable,
revert it for now and wait for the explicit definition of GIC
structure is ready.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/acpi/processor_core.c |   27 ---------------------------
 1 file changed, 27 deletions(-)

diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index 86d73d5..71e2065 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -70,28 +70,6 @@ static int map_lsapic_id(struct acpi_subtable_header *entry,
 	return 0;
 }
 
-static int map_gic_id(struct acpi_subtable_header *entry,
-		int device_declaration, u32 acpi_id, int *apic_id)
-{
-	struct acpi_madt_generic_interrupt *gic =
-		(struct acpi_madt_generic_interrupt *)entry;
-
-	if (!(gic->flags & ACPI_MADT_ENABLED))
-		return -ENODEV;
-
-	/*
-	 * In the GIC interrupt model, logical processors are
-	 * required to have a Processor Device object in the DSDT,
-	 * so we should check device_declaration here
-	 */
-	if (device_declaration && (gic->uid == acpi_id)) {
-		*apic_id = gic->gic_id;
-		return 0;
-	}
-
-	return -EINVAL;
-}
-
 static int map_madt_entry(int type, u32 acpi_id)
 {
 	unsigned long madt_end, entry;
@@ -127,9 +105,6 @@ static int map_madt_entry(int type, u32 acpi_id)
 		} else if (header->type == ACPI_MADT_TYPE_LOCAL_SAPIC) {
 			if (!map_lsapic_id(header, type, acpi_id, &apic_id))
 				break;
-		} else if (header->type == ACPI_MADT_TYPE_GENERIC_INTERRUPT) {
-			if (!map_gic_id(header, type, acpi_id, &apic_id))
-				break;
 		}
 		entry += header->length;
 	}
@@ -160,8 +135,6 @@ static int map_mat_entry(acpi_handle handle, int type, u32 acpi_id)
 		map_lapic_id(header, acpi_id, &apic_id);
 	} else if (header->type == ACPI_MADT_TYPE_LOCAL_SAPIC) {
 		map_lsapic_id(header, type, acpi_id, &apic_id);
-	} else if (header->type == ACPI_MADT_TYPE_GENERIC_INTERRUPT) {
-		map_gic_id(header, type, acpi_id, &apic_id);
 	}
 
 exit:
-- 
1.7.9.5

