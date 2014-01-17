From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH] ACPI / processor: Return specific error value when mapping lapic id
Date: Fri, 17 Jan 2014 12:37:02 +0800
Message-ID: <1389933422-10016-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, patches@linaro.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, linaro-acpi@lists.linaro.org, Hanjun Guo <hanjun.guo@linaro.org>
List-Id: linux-acpi@vger.kernel.org

we usually return 0 for success in int returned function, and negative
value when failed, but in processor_core.c, some function return 1
for success and 0 for failure which leads confusion sometimes,
replace with specific error values to fix that.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/acpi/processor_core.c |   26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index b3171f3..24c87ef 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -45,13 +45,13 @@ static int map_lapic_id(struct acpi_subtable_header *entry,
 		(struct acpi_madt_local_apic *)entry;
 
 	if (!(lapic->lapic_flags & ACPI_MADT_ENABLED))
-		return 0;
+		return -ENODEV;
 
 	if (lapic->processor_id != acpi_id)
-		return 0;
+		return -EINVAL;
 
 	*apic_id = lapic->id;
-	return 1;
+	return 0;
 }
 
 static int map_x2apic_id(struct acpi_subtable_header *entry,
@@ -61,14 +61,14 @@ static int map_x2apic_id(struct acpi_subtable_header *entry,
 		(struct acpi_madt_local_x2apic *)entry;
 
 	if (!(apic->lapic_flags & ACPI_MADT_ENABLED))
-		return 0;
+		return -ENODEV;
 
 	if (device_declaration && (apic->uid == acpi_id)) {
 		*apic_id = apic->local_apic_id;
-		return 1;
+		return 0;
 	}
 
-	return 0;
+	return -EINVAL;
 }
 
 static int map_lsapic_id(struct acpi_subtable_header *entry,
@@ -78,16 +78,16 @@ static int map_lsapic_id(struct acpi_subtable_header *entry,
 		(struct acpi_madt_local_sapic *)entry;
 
 	if (!(lsapic->lapic_flags & ACPI_MADT_ENABLED))
-		return 0;
+		return -ENODEV;
 
 	if (device_declaration) {
 		if ((entry->length < 16) || (lsapic->uid != acpi_id))
-			return 0;
+			return -EINVAL;
 	} else if (lsapic->processor_id != acpi_id)
-		return 0;
+		return -EINVAL;
 
 	*apic_id = (lsapic->id << 8) | lsapic->eid;
-	return 1;
+	return 0;
 }
 
 static int map_madt_entry(int type, u32 acpi_id)
@@ -117,13 +117,13 @@ static int map_madt_entry(int type, u32 acpi_id)
 		struct acpi_subtable_header *header =
 			(struct acpi_subtable_header *)entry;
 		if (header->type == ACPI_MADT_TYPE_LOCAL_APIC) {
-			if (map_lapic_id(header, acpi_id, &apic_id))
+			if (!map_lapic_id(header, acpi_id, &apic_id))
 				break;
 		} else if (header->type == ACPI_MADT_TYPE_LOCAL_X2APIC) {
-			if (map_x2apic_id(header, type, acpi_id, &apic_id))
+			if (!map_x2apic_id(header, type, acpi_id, &apic_id))
 				break;
 		} else if (header->type == ACPI_MADT_TYPE_LOCAL_SAPIC) {
-			if (map_lsapic_id(header, type, acpi_id, &apic_id))
+			if (!map_lsapic_id(header, type, acpi_id, &apic_id))
 				break;
 		}
 		entry += header->length;
-- 
1.7.9.5
