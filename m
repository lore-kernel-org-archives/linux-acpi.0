From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: [PATCH v3 2/5] Revert"x86/acpi: Enable MADT APIs to return disabled apicids"
Date: Fri, 3 Mar 2017 16:02:24 +0800
Message-ID: <1488528147-2279-3-git-send-email-douly.fnst@cn.fujitsu.com>
References: <1488528147-2279-1-git-send-email-douly.fnst@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1488528147-2279-1-git-send-email-douly.fnst@cn.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com, rjw@rjwysocki.net, lenb@kernel.org, xiaolong.ye@intel.com, guzheng1@huawei.com, izumi.taku@jp.fujitsu.com
Cc: x86@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Dou Liyang <douly.fnst@cn.fujitsu.com>
List-Id: linux-acpi@vger.kernel.org

Remove the leftovers of the boot time 'cpuid <-> nodeid' mapping approach.

Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
Tested-by: Xiaolong Ye <xiaolong.ye@intel.com>
---
 drivers/acpi/processor_core.c | 60 ++++++++++++++++---------------------------
 1 file changed, 22 insertions(+), 38 deletions(-)

diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index a843862..b933061 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -32,12 +32,12 @@ static struct acpi_table_madt *get_madt_table(void)
 }
 
 static int map_lapic_id(struct acpi_subtable_header *entry,
-		 u32 acpi_id, phys_cpuid_t *apic_id, bool ignore_disabled)
+		 u32 acpi_id, phys_cpuid_t *apic_id)
 {
 	struct acpi_madt_local_apic *lapic =
 		container_of(entry, struct acpi_madt_local_apic, header);
 
-	if (ignore_disabled && !(lapic->lapic_flags & ACPI_MADT_ENABLED))
+	if (!(lapic->lapic_flags & ACPI_MADT_ENABLED))
 		return -ENODEV;
 
 	if (lapic->processor_id != acpi_id)
@@ -48,13 +48,12 @@ static int map_lapic_id(struct acpi_subtable_header *entry,
 }
 
 static int map_x2apic_id(struct acpi_subtable_header *entry,
-		int device_declaration, u32 acpi_id, phys_cpuid_t *apic_id,
-		bool ignore_disabled)
+		int device_declaration, u32 acpi_id, phys_cpuid_t *apic_id)
 {
 	struct acpi_madt_local_x2apic *apic =
 		container_of(entry, struct acpi_madt_local_x2apic, header);
 
-	if (ignore_disabled && !(apic->lapic_flags & ACPI_MADT_ENABLED))
+	if (!(apic->lapic_flags & ACPI_MADT_ENABLED))
 		return -ENODEV;
 
 	if (device_declaration && (apic->uid == acpi_id)) {
@@ -66,13 +65,12 @@ static int map_x2apic_id(struct acpi_subtable_header *entry,
 }
 
 static int map_lsapic_id(struct acpi_subtable_header *entry,
-		int device_declaration, u32 acpi_id, phys_cpuid_t *apic_id,
-		bool ignore_disabled)
+		int device_declaration, u32 acpi_id, phys_cpuid_t *apic_id)
 {
 	struct acpi_madt_local_sapic *lsapic =
 		container_of(entry, struct acpi_madt_local_sapic, header);
 
-	if (ignore_disabled && !(lsapic->lapic_flags & ACPI_MADT_ENABLED))
+	if (!(lsapic->lapic_flags & ACPI_MADT_ENABLED))
 		return -ENODEV;
 
 	if (device_declaration) {
@@ -89,13 +87,12 @@ static int map_lsapic_id(struct acpi_subtable_header *entry,
  * Retrieve the ARM CPU physical identifier (MPIDR)
  */
 static int map_gicc_mpidr(struct acpi_subtable_header *entry,
-		int device_declaration, u32 acpi_id, phys_cpuid_t *mpidr,
-		bool ignore_disabled)
+		int device_declaration, u32 acpi_id, phys_cpuid_t *mpidr)
 {
 	struct acpi_madt_generic_interrupt *gicc =
 	    container_of(entry, struct acpi_madt_generic_interrupt, header);
 
-	if (ignore_disabled && !(gicc->flags & ACPI_MADT_ENABLED))
+	if (!(gicc->flags & ACPI_MADT_ENABLED))
 		return -ENODEV;
 
 	/* device_declaration means Device object in DSDT, in the
@@ -112,7 +109,7 @@ static int map_gicc_mpidr(struct acpi_subtable_header *entry,
 }
 
 static phys_cpuid_t map_madt_entry(struct acpi_table_madt *madt,
-				   int type, u32 acpi_id, bool ignore_disabled)
+				   int type, u32 acpi_id)
 {
 	unsigned long madt_end, entry;
 	phys_cpuid_t phys_id = PHYS_CPUID_INVALID;	/* CPU hardware ID */
@@ -130,20 +127,16 @@ static phys_cpuid_t map_madt_entry(struct acpi_table_madt *madt,
 		struct acpi_subtable_header *header =
 			(struct acpi_subtable_header *)entry;
 		if (header->type == ACPI_MADT_TYPE_LOCAL_APIC) {
-			if (!map_lapic_id(header, acpi_id, &phys_id,
-					  ignore_disabled))
+			if (!map_lapic_id(header, acpi_id, &phys_id))
 				break;
 		} else if (header->type == ACPI_MADT_TYPE_LOCAL_X2APIC) {
-			if (!map_x2apic_id(header, type, acpi_id, &phys_id,
-					   ignore_disabled))
+			if (!map_x2apic_id(header, type, acpi_id, &phys_id))
 				break;
 		} else if (header->type == ACPI_MADT_TYPE_LOCAL_SAPIC) {
-			if (!map_lsapic_id(header, type, acpi_id, &phys_id,
-					   ignore_disabled))
+			if (!map_lsapic_id(header, type, acpi_id, &phys_id))
 				break;
 		} else if (header->type == ACPI_MADT_TYPE_GENERIC_INTERRUPT) {
-			if (!map_gicc_mpidr(header, type, acpi_id, &phys_id,
-					    ignore_disabled))
+			if (!map_gicc_mpidr(header, type, acpi_id, &phys_id))
 				break;
 		}
 		entry += header->length;
@@ -161,15 +154,14 @@ phys_cpuid_t __init acpi_map_madt_entry(u32 acpi_id)
 	if (!madt)
 		return PHYS_CPUID_INVALID;
 
-	rv = map_madt_entry(madt, 1, acpi_id, true);
+	rv = map_madt_entry(madt, 1, acpi_id);
 
 	acpi_put_table((struct acpi_table_header *)madt);
 
 	return rv;
 }
 
-static phys_cpuid_t map_mat_entry(acpi_handle handle, int type, u32 acpi_id,
-				  bool ignore_disabled)
+static phys_cpuid_t map_mat_entry(acpi_handle handle, int type, u32 acpi_id)
 {
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 	union acpi_object *obj;
@@ -190,38 +182,30 @@ static phys_cpuid_t map_mat_entry(acpi_handle handle, int type, u32 acpi_id,
 
 	header = (struct acpi_subtable_header *)obj->buffer.pointer;
 	if (header->type == ACPI_MADT_TYPE_LOCAL_APIC)
-		map_lapic_id(header, acpi_id, &phys_id, ignore_disabled);
+		map_lapic_id(header, acpi_id, &phys_id);
 	else if (header->type == ACPI_MADT_TYPE_LOCAL_SAPIC)
-		map_lsapic_id(header, type, acpi_id, &phys_id, ignore_disabled);
+		map_lsapic_id(header, type, acpi_id, &phys_id);
 	else if (header->type == ACPI_MADT_TYPE_LOCAL_X2APIC)
-		map_x2apic_id(header, type, acpi_id, &phys_id, ignore_disabled);
+		map_x2apic_id(header, type, acpi_id, &phys_id);
 	else if (header->type == ACPI_MADT_TYPE_GENERIC_INTERRUPT)
-		map_gicc_mpidr(header, type, acpi_id, &phys_id,
-			       ignore_disabled);
+		map_gicc_mpidr(header, type, acpi_id, &phys_id);
 
 exit:
 	kfree(buffer.pointer);
 	return phys_id;
 }
 
-static phys_cpuid_t __acpi_get_phys_id(acpi_handle handle, int type,
-				       u32 acpi_id, bool ignore_disabled)
+phys_cpuid_t acpi_get_phys_id(acpi_handle handle, int type, u32 acpi_id)
 {
 	phys_cpuid_t phys_id;
 
-	phys_id = map_mat_entry(handle, type, acpi_id, ignore_disabled);
+	phys_id = map_mat_entry(handle, type, acpi_id);
 	if (invalid_phys_cpuid(phys_id))
-		phys_id = map_madt_entry(get_madt_table(), type, acpi_id,
-					   ignore_disabled);
+		phys_id = map_madt_entry(get_madt_table(), type, acpi_id);
 
 	return phys_id;
 }
 
-phys_cpuid_t acpi_get_phys_id(acpi_handle handle, int type, u32 acpi_id)
-{
-	return __acpi_get_phys_id(handle, type, acpi_id, true);
-}
-
 int acpi_map_cpuid(phys_cpuid_t phys_id, u32 acpi_id)
 {
 #ifdef CONFIG_SMP
-- 
2.5.5
