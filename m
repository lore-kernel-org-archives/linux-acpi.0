From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 12/18] ACPICA: Utilities: Update debug output
Date: Wed, 28 Dec 2016 15:29:22 +0800
Message-ID: <896454f3b2edb5535d51b06a6e2be93484f4fc4c.1482821486.git.lv.zheng@intel.com>
References: <cover.1482821486.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1482821486.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 082b5b3ee31f74735e166858eeda025288604a5a

Enhancement of miscellaneous debug output.

Link: https://github.com/acpica/acpica/commit/082b5b3e
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/utdecode.c | 4 ++--
 drivers/acpi/acpica/utdelete.c | 6 ++++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpica/utdecode.c b/drivers/acpi/acpica/utdecode.c
index b3d8421..c6f2ce1 100644
--- a/drivers/acpi/acpica/utdecode.c
+++ b/drivers/acpi/acpica/utdecode.c
@@ -238,7 +238,7 @@ const char *acpi_ut_get_object_type_name(union acpi_operand_object *obj_desc)
 
 	if (!obj_desc) {
 		ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "Null Object Descriptor\n"));
-		return_PTR("[NULL Object Descriptor]");
+		return_STR("[NULL Object Descriptor]");
 	}
 
 	/* These descriptor types share a common area */
@@ -251,7 +251,7 @@ const char *acpi_ut_get_object_type_name(union acpi_operand_object *obj_desc)
 				  acpi_ut_get_descriptor_name(obj_desc),
 				  obj_desc));
 
-		return_PTR("Invalid object");
+		return_STR("Invalid object");
 	}
 
 	return_STR(acpi_ut_get_type_name(obj_desc->common.type));
diff --git a/drivers/acpi/acpica/utdelete.c b/drivers/acpi/acpica/utdelete.c
index 529d6c3..5cdd707 100644
--- a/drivers/acpi/acpica/utdelete.c
+++ b/drivers/acpi/acpica/utdelete.c
@@ -421,8 +421,10 @@ acpi_ut_update_ref_count(union acpi_operand_object *object, u32 action)
 		}
 
 		ACPI_DEBUG_PRINT((ACPI_DB_ALLOCATIONS,
-				  "Obj %p Type %.2X Refs %.2X [Incremented]\n",
-				  object, object->common.type, new_count));
+				  "Obj %p Type %.2X [%s] Refs %.2X [Incremented]\n",
+				  object, object->common.type,
+				  acpi_ut_get_object_type_name(object),
+				  new_count));
 		break;
 
 	case REF_DECREMENT:
-- 
2.7.4
