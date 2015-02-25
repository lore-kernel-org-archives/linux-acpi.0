From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH v9 01/21] ACPI / table: Use pr_debug() instead of pr_info() for MADT table scanning
Date: Wed, 25 Feb 2015 16:39:41 +0800
Message-ID: <1424853601-6675-2-git-send-email-hanjun.guo@linaro.org>
References: <1424853601-6675-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:36604 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752245AbbBYIkq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Feb 2015 03:40:46 -0500
Received: by pdjp10 with SMTP id p10so3409994pdj.3
        for <linux-acpi@vger.kernel.org>; Wed, 25 Feb 2015 00:40:46 -0800 (PST)
In-Reply-To: <1424853601-6675-1-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <will.deacon@arm.com>, Olof Johansson <olof@lixom.net>, Grant Likely <grant.likely@linaro.org>
Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Graeme Gregory <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Jon Masters <jcm@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, Mark Brown <broonie@kernel.org>, Robert Richter <rric@kernel.org>, Timur Tabi <timur@codeaurora.org>, Ashwin Chaugule <ashwinc@codeaurora.org>, suravee.suthikulpanit@amd.com, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, Hanjun Guo <hanjun.guo@linaro.org>

For a normal 8 cpu sockets system, it will up to 240 cpu threads (Xeon E7
v2 family for now), and we need 240 entries for local apic or local x2apic
in MADT table, so it will be much verbose information printed with a slow
uart console when system booted, this will be even worse with large system
with 16/32 cpu sockets.

This patch just use pr_debug() instead of pr_info() for ioapic/iosapic,
local apic/x2apic/sapic structures when scanning the MADT table to remove
those verbose information, but leave other structures unchanged.

CC: Rafael J Wysocki <rjw@rjwysocki.net>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/acpi/tables.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 93b8152..f4e5b88 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -23,6 +23,8 @@
  *
  */
 
+/* Uncomment next line to get verbose printout */
+/* #define DEBUG */
 #define pr_fmt(fmt) "ACPI: " fmt
 
 #include <linux/init.h>
@@ -61,9 +63,9 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
 		{
 			struct acpi_madt_local_apic *p =
 			    (struct acpi_madt_local_apic *)header;
-			pr_info("LAPIC (acpi_id[0x%02x] lapic_id[0x%02x] %s)\n",
-				p->processor_id, p->id,
-				(p->lapic_flags & ACPI_MADT_ENABLED) ? "enabled" : "disabled");
+			pr_debug("LAPIC (acpi_id[0x%02x] lapic_id[0x%02x] %s)\n",
+				 p->processor_id, p->id,
+				 (p->lapic_flags & ACPI_MADT_ENABLED) ? "enabled" : "disabled");
 		}
 		break;
 
@@ -71,9 +73,9 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
 		{
 			struct acpi_madt_local_x2apic *p =
 			    (struct acpi_madt_local_x2apic *)header;
-			pr_info("X2APIC (apic_id[0x%02x] uid[0x%02x] %s)\n",
-				p->local_apic_id, p->uid,
-				(p->lapic_flags & ACPI_MADT_ENABLED) ? "enabled" : "disabled");
+			pr_debug("X2APIC (apic_id[0x%02x] uid[0x%02x] %s)\n",
+				 p->local_apic_id, p->uid,
+				 (p->lapic_flags & ACPI_MADT_ENABLED) ? "enabled" : "disabled");
 		}
 		break;
 
@@ -81,8 +83,8 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
 		{
 			struct acpi_madt_io_apic *p =
 			    (struct acpi_madt_io_apic *)header;
-			pr_info("IOAPIC (id[0x%02x] address[0x%08x] gsi_base[%d])\n",
-				p->id, p->address, p->global_irq_base);
+			pr_debug("IOAPIC (id[0x%02x] address[0x%08x] gsi_base[%d])\n",
+				 p->id, p->address, p->global_irq_base);
 		}
 		break;
 
@@ -155,9 +157,9 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
 		{
 			struct acpi_madt_io_sapic *p =
 			    (struct acpi_madt_io_sapic *)header;
-			pr_info("IOSAPIC (id[0x%x] address[%p] gsi_base[%d])\n",
-				p->id, (void *)(unsigned long)p->address,
-				p->global_irq_base);
+			pr_debug("IOSAPIC (id[0x%x] address[%p] gsi_base[%d])\n",
+				 p->id, (void *)(unsigned long)p->address,
+				 p->global_irq_base);
 		}
 		break;
 
@@ -165,9 +167,9 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
 		{
 			struct acpi_madt_local_sapic *p =
 			    (struct acpi_madt_local_sapic *)header;
-			pr_info("LSAPIC (acpi_id[0x%02x] lsapic_id[0x%02x] lsapic_eid[0x%02x] %s)\n",
-				p->processor_id, p->id, p->eid,
-				(p->lapic_flags & ACPI_MADT_ENABLED) ? "enabled" : "disabled");
+			pr_debug("LSAPIC (acpi_id[0x%02x] lsapic_id[0x%02x] lsapic_eid[0x%02x] %s)\n",
+				 p->processor_id, p->id, p->eid,
+				 (p->lapic_flags & ACPI_MADT_ENABLED) ? "enabled" : "disabled");
 		}
 		break;
 
-- 
1.9.1

