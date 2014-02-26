From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 04/18] ACPICA: Properly handle NULL entries in _PRT return packages.
Date: Wed, 26 Feb 2014 10:29:31 +0800
Message-ID: <4be9881d80841b15aa467fb6b223308b9d8ff0cd.1393379348.git.lv.zheng@intel.com>
References: <cover.1393379348.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:9857 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751088AbaBZC3i (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 25 Feb 2014 21:29:38 -0500
In-Reply-To: <cover.1393379348.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

This change enables proper handling of NULL package entries in a _PRT
return value, during construction of the PCI routing table.
Lv Zheng.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/rscreate.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/rscreate.c b/drivers/acpi/acpica/rscreate.c
index ca62804..f4cd6ca 100644
--- a/drivers/acpi/acpica/rscreate.c
+++ b/drivers/acpi/acpica/rscreate.c
@@ -292,7 +292,7 @@ acpi_rs_create_pci_routing_table(union acpi_operand_object *package_object,
 		/* 1) First subobject: Dereference the PRT.Address */
 
 		obj_desc = sub_object_list[0];
-		if (obj_desc->common.type != ACPI_TYPE_INTEGER) {
+		if (!obj_desc || obj_desc->common.type != ACPI_TYPE_INTEGER) {
 			ACPI_ERROR((AE_INFO,
 				    "(PRT[%u].Address) Need Integer, found %s",
 				    index,
@@ -305,7 +305,7 @@ acpi_rs_create_pci_routing_table(union acpi_operand_object *package_object,
 		/* 2) Second subobject: Dereference the PRT.Pin */
 
 		obj_desc = sub_object_list[1];
-		if (obj_desc->common.type != ACPI_TYPE_INTEGER) {
+		if (!obj_desc || obj_desc->common.type != ACPI_TYPE_INTEGER) {
 			ACPI_ERROR((AE_INFO,
 				    "(PRT[%u].Pin) Need Integer, found %s",
 				    index,
@@ -394,7 +394,7 @@ acpi_rs_create_pci_routing_table(union acpi_operand_object *package_object,
 		/* 4) Fourth subobject: Dereference the PRT.source_index */
 
 		obj_desc = sub_object_list[3];
-		if (obj_desc->common.type != ACPI_TYPE_INTEGER) {
+		if (!obj_desc || obj_desc->common.type != ACPI_TYPE_INTEGER) {
 			ACPI_ERROR((AE_INFO,
 				    "(PRT[%u].SourceIndex) Need Integer, found %s",
 				    index,
-- 
1.7.10

