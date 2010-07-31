From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH] acpi: x2apic entry with uid < 255 could use processor statement
Date: Fri, 30 Jul 2010 23:51:19 -0700
Message-ID: <4C53C7E7.4040204@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rcsinet10.oracle.com ([148.87.113.121]:65528 "EHLO
	rcsinet10.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755151Ab0GaGxD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 31 Jul 2010 02:53:03 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, Suresh Siddha <suresh.b.siddha@intel.com>, Andrew Morton <akpm@linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>


According to Intel x2apic spec page 46

" The hand-off to
OSPM will have processor IDs in the range of 0 to 254 for xAPIC/x2APIC and 0 to 255
for SAPIC declared as either Processor() or Device() objects, but not both. Processor
IDs outside these ranges must be declared as Device() objects."

So only check if Device is used when acpi_id >=255.

that will help system with less 255 cpus, but some cpus apic id > 255,
still can use Processor statement instead of Device() objects.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>

---
 drivers/acpi/processor_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/drivers/acpi/processor_core.c
===================================================================
--- linux-2.6.orig/drivers/acpi/processor_core.c
+++ linux-2.6/drivers/acpi/processor_core.c
@@ -69,7 +69,7 @@ static int map_x2apic_id(struct acpi_sub
 	if (!(apic->lapic_flags & ACPI_MADT_ENABLED))
 		return 0;
 
-	if (device_declaration && (apic->uid == acpi_id)) {
+	if ((device_declaration || (acpi_id < 255)) && (apic->uid == acpi_id)) {
 		*apic_id = apic->local_apic_id;
 		return 1;
 	}
