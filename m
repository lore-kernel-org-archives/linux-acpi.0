From: Len Brown <lenb@kernel.org>
Subject: [PATCH 11/16] ACPICA: Update flags for operand object
Date: Fri, 04 Jun 2010 15:51:41 -0400
Message-ID: <b39cffd52a802c797608dfc7ae21df049644b2f9.1275680880.git.len.brown@intel.com>
References: <1275681106-8450-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:61797 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756217Ab0FHTmR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Jun 2010 15:42:17 -0400
Received: from localhost.localdomain ([unknown] [98.118.125.200])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L3P00KKCO2A66I4@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 08 Jun 2010 14:42:16 -0500 (CDT)
In-reply-to: <1275681106-8450-1-git-send-email-lenb@kernel.org>
In-reply-to: <8aa4b14eb023fecaa48d55402e98bdf84b375c4a.1275680880.git.len.brown@intel.com>
References: <8aa4b14eb023fecaa48d55402e98bdf84b375c4a.1275680880.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Remove obsolete AOPOBJ_SINGLE_DATUM. Add AOPOBJ_INVALID for
use if the host OS rejects the address of an operation region
(currently only used by Linux.)

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/acobject.h |   16 ++++++++--------
 drivers/acpi/acpica/exprep.c   |    9 ---------
 2 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/acpica/acobject.h b/drivers/acpi/acpica/acobject.h
index cde18ea..54857fa 100644
--- a/drivers/acpi/acpica/acobject.h
+++ b/drivers/acpi/acpica/acobject.h
@@ -91,14 +91,14 @@
 
 /* Values for Flag byte above */
 
-#define AOPOBJ_AML_CONSTANT         0x01
-#define AOPOBJ_STATIC_POINTER       0x02
-#define AOPOBJ_DATA_VALID           0x04
-#define AOPOBJ_OBJECT_INITIALIZED   0x08
-#define AOPOBJ_SETUP_COMPLETE       0x10
-#define AOPOBJ_SINGLE_DATUM         0x20
-#define AOPOBJ_INVALID              0x40	/* Used if host OS won't allow an op_region address */
-#define AOPOBJ_MODULE_LEVEL         0x80
+#define AOPOBJ_AML_CONSTANT         0x01	/* Integer is an AML constant */
+#define AOPOBJ_STATIC_POINTER       0x02	/* Data is part of an ACPI table, don't delete */
+#define AOPOBJ_DATA_VALID           0x04	/* Object is intialized and data is valid */
+#define AOPOBJ_OBJECT_INITIALIZED   0x08	/* Region is initialized, _REG was run */
+#define AOPOBJ_SETUP_COMPLETE       0x10	/* Region setup is complete */
+#define AOPOBJ_INVALID              0x20	/* Host OS won't allow a Region address */
+#define AOPOBJ_MODULE_LEVEL         0x40	/* Method is actually module-level code */
+#define AOPOBJ_MODIFIED_NAMESPACE   0x80	/* Method modified the namespace */
 
 /******************************************************************************
  *
diff --git a/drivers/acpi/acpica/exprep.c b/drivers/acpi/acpica/exprep.c
index 0686f27..98a331d 100644
--- a/drivers/acpi/acpica/exprep.c
+++ b/drivers/acpi/acpica/exprep.c
@@ -385,15 +385,6 @@ acpi_ex_prep_common_field_object(union acpi_operand_object *obj_desc,
 	    (field_bit_position -
 	     ACPI_MUL_8(obj_desc->common_field.base_byte_offset));
 
-	/*
-	 * Does the entire field fit within a single field access element? (datum)
-	 * (i.e., without crossing a datum boundary)
-	 */
-	if ((obj_desc->common_field.start_field_bit_offset +
-	     field_bit_length) <= (u16) access_bit_width) {
-		obj_desc->common.flags |= AOPOBJ_SINGLE_DATUM;
-	}
-
 	return_ACPI_STATUS(AE_OK);
 }
 
-- 
1.6.0.6

