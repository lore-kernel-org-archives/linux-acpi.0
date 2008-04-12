From: Len Brown <lenb@kernel.org>
Subject: [PATCH 66/73] ACPICA: Fix to handle NULL package elements correctly
Date: Sat, 12 Apr 2008 00:25:49 -0400
Message-ID: <c0d590f3637728569d2a91765cd1a43a9271ffad.1207973800.git.len.brown@intel.com>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:45175 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752496AbYDLE2N (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Apr 2008 00:28:13 -0400
In-Reply-To: <1207974356-30687-1-git-send-email-lenb@kernel.org>
In-Reply-To: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
References: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Fixed problem where NULL package elements were not returned to
the AcpiEvaluateObject interface correctly. Instead of returning a
NULL ACPI_OBJECT package element, the element was simply ignored,
potentially causing a buffer overflow and/or confusing the caller
who expected a fixed number of elements. BZ 10132 (Lin Ming,
Bob Moore)

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/utilities/utobject.c |    5 ++---
 include/acpi/actypes.h            |   29 +++++++++++++++++------------
 2 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/utilities/utobject.c b/drivers/acpi/utilities/utobject.c
index 1eccd3d..cdb8ff5 100644
--- a/drivers/acpi/utilities/utobject.c
+++ b/drivers/acpi/utilities/utobject.c
@@ -470,9 +470,8 @@ acpi_ut_get_simple_object_size(union acpi_operand_object *internal_object,
 	case ACPI_TYPE_PROCESSOR:
 	case ACPI_TYPE_POWER:
 
-		/*
-		 * No extra data for these types
-		 */
+		/* No extra data for these types */
+
 		break;
 
 	case ACPI_TYPE_LOCAL_REFERENCE:
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 599657e..75ec153 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -639,46 +639,51 @@ typedef u8 acpi_adr_space_type;
 /*
  * External ACPI object definition
  */
+
+/*
+ * Note: Type == ACPI_TYPE_ANY (0) is used to indicate a NULL package element
+ * or an unresolved named reference.
+ */
 union acpi_object {
 	acpi_object_type type;	/* See definition of acpi_ns_type for values */
 	struct {
-		acpi_object_type type;
+		acpi_object_type type;	/* ACPI_TYPE_INTEGER */
 		acpi_integer value;	/* The actual number */
 	} integer;
 
 	struct {
-		acpi_object_type type;
+		acpi_object_type type;	/* ACPI_TYPE_STRING */
 		u32 length;	/* # of bytes in string, excluding trailing null */
 		char *pointer;	/* points to the string value */
 	} string;
 
 	struct {
-		acpi_object_type type;
+		acpi_object_type type;	/* ACPI_TYPE_BUFFER */
 		u32 length;	/* # of bytes in buffer */
 		u8 *pointer;	/* points to the buffer */
 	} buffer;
 
 	struct {
-		acpi_object_type type;
-		u32 fill1;
-		acpi_handle handle;	/* object reference */
-	} reference;
-
-	struct {
-		acpi_object_type type;
+		acpi_object_type type;	/* ACPI_TYPE_PACKAGE */
 		u32 count;	/* # of elements in package */
 		union acpi_object *elements;	/* Pointer to an array of ACPI_OBJECTs */
 	} package;
 
 	struct {
-		acpi_object_type type;
+		acpi_object_type type;	/* ACPI_TYPE_LOCAL_REFERENCE */
+		acpi_object_type actual_type;	/* Type associated with the Handle */
+		acpi_handle handle;	/* object reference */
+	} reference;
+
+	struct {
+		acpi_object_type type;	/* ACPI_TYPE_PROCESSOR */
 		u32 proc_id;
 		acpi_io_address pblk_address;
 		u32 pblk_length;
 	} processor;
 
 	struct {
-		acpi_object_type type;
+		acpi_object_type type;	/* ACPI_TYPE_POWER */
 		u32 system_level;
 		u32 resource_order;
 	} power_resource;
-- 
1.5.5.29.g7134

