From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 05/22] ACPICA: Executer: Add back pointing reference of method operand.
Date: Thu, 23 Jul 2015 12:52:31 +0800
Message-ID: <24a0bb6f3554c13461e8336d52a8585308efd50b.1437627016.git.lv.zheng@intel.com>
References: <cover.1437627016.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:46049 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752507AbbGWEwj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 23 Jul 2015 00:52:39 -0400
In-Reply-To: <cover.1437627016.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

ACPICA commit 9dcd124e914e87495fbd1786d9484b962e0823e0

This patch adds back pointing reference of the namespace node for a method
operand. The namespace node then can be used in
acpi_ds_terminate_control_method() to obtain method full path to be used by
tracing facilities. Lv Zheng.

Link: https://github.com/acpica/acpica/commit/9dcd124e
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/acobject.h |    1 +
 drivers/acpi/acpica/excreate.c |    1 +
 drivers/acpi/acpica/utdelete.c |    3 +++
 3 files changed, 5 insertions(+)

diff --git a/drivers/acpi/acpica/acobject.h b/drivers/acpi/acpica/acobject.h
index c81d98d..0bd02c4 100644
--- a/drivers/acpi/acpica/acobject.h
+++ b/drivers/acpi/acpica/acobject.h
@@ -176,6 +176,7 @@ struct acpi_object_method {
 	u8 param_count;
 	u8 sync_level;
 	union acpi_operand_object *mutex;
+	union acpi_operand_object *node;
 	u8 *aml_start;
 	union {
 		acpi_internal_method implementation;
diff --git a/drivers/acpi/acpica/excreate.c b/drivers/acpi/acpica/excreate.c
index aaeea48..ccb7219 100644
--- a/drivers/acpi/acpica/excreate.c
+++ b/drivers/acpi/acpica/excreate.c
@@ -486,6 +486,7 @@ acpi_ex_create_method(u8 * aml_start,
 
 	obj_desc->method.aml_start = aml_start;
 	obj_desc->method.aml_length = aml_length;
+	obj_desc->method.node = operand[0];
 
 	/*
 	 * Disassemble the method flags. Split off the arg_count, Serialized
diff --git a/drivers/acpi/acpica/utdelete.c b/drivers/acpi/acpica/utdelete.c
index 71fce38..1638312 100644
--- a/drivers/acpi/acpica/utdelete.c
+++ b/drivers/acpi/acpica/utdelete.c
@@ -209,6 +209,9 @@ static void acpi_ut_delete_internal_obj(union acpi_operand_object *object)
 			acpi_ut_delete_object_desc(object->method.mutex);
 			object->method.mutex = NULL;
 		}
+		if (object->method.node) {
+			object->method.node = NULL;
+		}
 		break;
 
 	case ACPI_TYPE_REGION:
-- 
1.7.10

