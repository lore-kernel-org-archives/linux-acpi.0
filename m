From: Lin Ming <ming.m.lin@intel.com>
Subject: [PATCH 2/2] ACPICA: fix leak of acpi_os_validate_address
Date: Tue, 28 Jul 2009 10:44:05 +0800
Message-ID: <1248749045.3166.66.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:43072 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752568AbZG1Cmi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 27 Jul 2009 22:42:38 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Thomas Renninger <trenn@suse.de>, "Moore, Robert" <robert.moore@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>

>From b41e50dff230992745638749e37f5813487ffd4f Mon Sep 17 00:00:00 2001
From: Lin Ming <ming.m.lin@intel.com>
Date: Tue, 28 Jul 2009 10:37:19 +0800
Subject: [PATCH] ACPICA: fix leak of acpi_os_validate_address

http://bugzilla.kernel.org/show_bug.cgi?id=13620

Reverting commit f9ca058 is on approach, but in looking
at the code doing so could cause a memory leak.

1) add a new field "count" to struct acpi_res_list.

   When inserting, if the region(addr, len) is already in the resource
   list, we just increase "count", otherwise, the region is inserted
   with count=1.

   When deleting, the "count" is decreased, if it's decreased to 0,
   the region is deleted from the resource list.

   With "count", the region with same address and length can only be
   inserted to the resource list once, so prevent potential memory leak.

2) add a new function acpi_os_invalidate_address, which is called when
   region is deleted.

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/utdelete.c |    6 +++
 drivers/acpi/osl.c             |   93 ++++++++++++++++++++++++++++++++++++++-
 include/acpi/acpiosxf.h        |    4 ++
 3 files changed, 100 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/utdelete.c b/drivers/acpi/acpica/utdelete.c
index bc17103..96e26e7 100644
--- a/drivers/acpi/acpica/utdelete.c
+++ b/drivers/acpi/acpica/utdelete.c
@@ -215,6 +215,12 @@ static void acpi_ut_delete_internal_obj(union acpi_operand_object *object)
 		ACPI_DEBUG_PRINT((ACPI_DB_ALLOCATIONS,
 				  "***** Region %p\n", object));
 
+		/* Invalidate the region address/length via the host OS */
+
+		acpi_os_invalidate_address(object->region.space_id,
+					  object->region.address,
+					  (acpi_size) object->region.length);
+
 		second_desc = acpi_ns_get_secondary_object(object);
 		if (second_desc) {
 			/*
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 7167071..620a65a 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -88,6 +88,7 @@ struct acpi_res_list {
 	char name[5];   /* only can have a length of 4 chars, make use of this
 			   one instead of res->name, no need to kalloc then */
 	struct list_head resource_list;
+	int count;
 };
 
 static LIST_HEAD(resource_list_head);
@@ -1333,6 +1334,88 @@ acpi_os_validate_interface (char *interface)
 	return AE_SUPPORT;
 }
 
+static inline int acpi_res_list_add(struct acpi_res_list *res)
+{
+	struct acpi_res_list *res_list_elem;
+
+	list_for_each_entry(res_list_elem, &resource_list_head,
+			    resource_list) {
+
+		if (res->resource_type == res_list_elem->resource_type &&
+		    res->start == res_list_elem->start &&
+		    res->end == res_list_elem->end) {
+
+			/*
+			 * The Region(addr,len) already exist in the list,
+			 * just increase the count
+			 */
+
+			res_list_elem->count++;
+			return 0;
+		}
+	}
+
+	res->count = 1;
+	list_add(&res->resource_list, &resource_list_head);
+	return 1;
+}
+
+static inline void acpi_res_list_del(struct acpi_res_list *res)
+{
+	struct acpi_res_list *res_list_elem;
+
+	list_for_each_entry(res_list_elem, &resource_list_head,
+			    resource_list) {
+
+		if (res->resource_type == res_list_elem->resource_type &&
+		    res->start == res_list_elem->start &&
+		    res->end == res_list_elem->end) {
+
+			/*
+			 * If the res count is decreased to 0, remove and free it
+			 */
+
+			if (--res_list_elem->count == 0) {
+				list_del(&res_list_elem->resource_list);
+				kfree(res_list_elem);
+			}
+			return;
+		}
+	}
+}
+
+acpi_status
+acpi_os_invalidate_address(
+    u8                   space_id,
+    acpi_physical_address   address,
+    acpi_size               length)
+{
+	struct acpi_res_list res;
+
+	switch (space_id) {
+	case ACPI_ADR_SPACE_SYSTEM_IO:
+	case ACPI_ADR_SPACE_SYSTEM_MEMORY:
+		/* Only interference checks against SystemIO and SytemMemory
+		   are needed */
+		res.start = address;
+		res.end = address + length - 1;
+		res.resource_type = space_id;
+		spin_lock(&acpi_res_lock);
+		acpi_res_list_del(&res);
+		spin_unlock(&acpi_res_lock);
+		break;
+	case ACPI_ADR_SPACE_PCI_CONFIG:
+	case ACPI_ADR_SPACE_EC:
+	case ACPI_ADR_SPACE_SMBUS:
+	case ACPI_ADR_SPACE_CMOS:
+	case ACPI_ADR_SPACE_PCI_BAR_TARGET:
+	case ACPI_ADR_SPACE_DATA_TABLE:
+	case ACPI_ADR_SPACE_FIXED_HARDWARE:
+		break;
+	}
+	return AE_OK;
+}
+
 /******************************************************************************
  *
  * FUNCTION:    acpi_os_validate_address
@@ -1357,6 +1440,7 @@ acpi_os_validate_address (
     char *name)
 {
 	struct acpi_res_list *res;
+	int added;
 	if (acpi_enforce_resources == ENFORCE_RESOURCES_NO)
 		return AE_OK;
 
@@ -1374,14 +1458,17 @@ acpi_os_validate_address (
 		res->end = address + length - 1;
 		res->resource_type = space_id;
 		spin_lock(&acpi_res_lock);
-		list_add(&res->resource_list, &resource_list_head);
+		added = acpi_res_list_add(res);
 		spin_unlock(&acpi_res_lock);
-		pr_debug("Added %s resource: start: 0x%llx, end: 0x%llx, "
-			 "name: %s\n", (space_id == ACPI_ADR_SPACE_SYSTEM_IO)
+		pr_debug("%s %s resource: start: 0x%llx, end: 0x%llx, "
+			 "name: %s\n", added ? "Added" : "Already exist",
+			 (space_id == ACPI_ADR_SPACE_SYSTEM_IO)
 			 ? "SystemIO" : "System Memory",
 			 (unsigned long long)res->start,
 			 (unsigned long long)res->end,
 			 res->name);
+		if (!added)
+			kfree(res);
 		break;
 	case ACPI_ADR_SPACE_PCI_CONFIG:
 	case ACPI_ADR_SPACE_EC:
diff --git a/include/acpi/acpiosxf.h b/include/acpi/acpiosxf.h
index ab0b85c..14d40bf 100644
--- a/include/acpi/acpiosxf.h
+++ b/include/acpi/acpiosxf.h
@@ -246,6 +246,10 @@ acpi_status
 acpi_os_validate_address(u8 space_id, acpi_physical_address address,
 			 acpi_size length, char *name);
 
+acpi_status
+acpi_os_invalidate_address(u8 space_id, acpi_physical_address address,
+			 acpi_size length);
+
 u64 acpi_os_get_timer(void);
 
 acpi_status acpi_os_signal(u32 function, void *info);


