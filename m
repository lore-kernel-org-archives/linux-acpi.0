From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 01/11] ACPICA: Predefine names: Add allowed argument types to master info table
Date: Fri, 12 Apr 2013 08:24:22 +0800
Message-ID: <b3716b66a3946a11059b4b8b2d21000b7517ac43.1365473141.git.lv.zheng@intel.com>
References: <cover.1364865215.git.lv.zheng@intel.com> <cover.1365473141.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:12816 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752280Ab3DLAYw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 11 Apr 2013 20:24:52 -0400
In-Reply-To: <cover.1365473141.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>

From: Bob Moore <robert.moore@intel.com>

This change adds the infrastructure to enable typechecking
on incoming arguments for the predefined methods/objects. It
does not actually contain the code that will fully utilize this
information. Also condenses some duplicate code for the predefined
names into a new module, utilities/utpredef.c

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/Makefile   |    1 +
 drivers/acpi/acpica/aclocal.h  |   13 +-
 drivers/acpi/acpica/acnamesp.h |    4 -
 drivers/acpi/acpica/acpredef.h | 1305 ++++++++++++++++++++++++++++------------
 drivers/acpi/acpica/acutils.h  |   20 +
 drivers/acpi/acpica/nseval.c   |   26 +-
 drivers/acpi/acpica/nspredef.c |  106 +---
 drivers/acpi/acpica/utpredef.c |  399 ++++++++++++
 8 files changed, 1361 insertions(+), 513 deletions(-)
 create mode 100644 drivers/acpi/acpica/utpredef.c

diff --git a/drivers/acpi/acpica/Makefile b/drivers/acpi/acpica/Makefile
index 5a542c8..7ddf29e 100644
--- a/drivers/acpi/acpica/Makefile
+++ b/drivers/acpi/acpica/Makefile
@@ -161,6 +161,7 @@ acpi-y +=		\
 	utobject.o	\
 	utosi.o		\
 	utownerid.o	\
+	utpredef.o	\
 	utresrc.o	\
 	utstate.o	\
 	utstring.o	\
diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 636658f..d5bfbd3 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -294,6 +294,8 @@ acpi_status(*acpi_internal_method) (struct acpi_walk_state * walk_state);
 #define ACPI_BTYPE_OBJECTS_AND_REFS     0x0001FFFF	/* ARG or LOCAL */
 #define ACPI_BTYPE_ALL_OBJECTS          0x0000FFFF
 
+#pragma pack(1)
+
 /*
  * Information structure for ACPI predefined names.
  * Each entry in the table contains the following items:
@@ -304,7 +306,7 @@ acpi_status(*acpi_internal_method) (struct acpi_walk_state * walk_state);
  */
 struct acpi_name_info {
 	char name[ACPI_NAME_SIZE];
-	u8 param_count;
+	u16 argument_list;
 	u8 expected_btypes;
 };
 
@@ -327,7 +329,7 @@ struct acpi_package_info {
 	u8 count1;
 	u8 object_type2;
 	u8 count2;
-	u8 reserved;
+	u16 reserved;
 };
 
 /* Used for ACPI_PTYPE2_FIXED */
@@ -336,6 +338,7 @@ struct acpi_package_info2 {
 	u8 type;
 	u8 count;
 	u8 object_type[4];
+	u8 reserved;
 };
 
 /* Used for ACPI_PTYPE1_OPTION */
@@ -345,7 +348,7 @@ struct acpi_package_info3 {
 	u8 count;
 	u8 object_type[2];
 	u8 tail_object_type;
-	u8 reserved;
+	u16 reserved;
 };
 
 union acpi_predefined_info {
@@ -355,6 +358,10 @@ union acpi_predefined_info {
 	struct acpi_package_info3 ret_info3;
 };
 
+/* Reset to default packing */
+
+#pragma pack()
+
 /* Data block used during object validation */
 
 struct acpi_predefined_data {
diff --git a/drivers/acpi/acpica/acnamesp.h b/drivers/acpi/acpica/acnamesp.h
index 6475962..d2e4918 100644
--- a/drivers/acpi/acpica/acnamesp.h
+++ b/drivers/acpi/acpica/acnamesp.h
@@ -231,10 +231,6 @@ acpi_ns_check_predefined_names(struct acpi_namespace_node *node,
 			       acpi_status return_status,
 			       union acpi_operand_object **return_object);
 
-const union acpi_predefined_info *acpi_ns_check_for_predefined_name(struct
-								    acpi_namespace_node
-								    *node);
-
 void
 acpi_ns_check_parameter_count(char *pathname,
 			      struct acpi_namespace_node *node,
diff --git a/drivers/acpi/acpica/acpredef.h b/drivers/acpi/acpica/acpredef.h
index 752cc40..b22b709 100644
--- a/drivers/acpi/acpica/acpredef.h
+++ b/drivers/acpi/acpica/acpredef.h
@@ -56,7 +56,7 @@
  *      object type
  *      count
  *
- * ACPI_PTYPE1_VAR: Variable-length length:
+ * ACPI_PTYPE1_VAR: Variable-length length. Zero-length package is allowed:
  *      object type (Int/Buf/Ref)
  *
  * ACPI_PTYPE1_OPTION: Package has some required and some optional elements
@@ -66,14 +66,16 @@
  * 2) PTYPE2 packages contain a Variable-length number of sub-packages. Each
  *    of the different types describe the contents of each of the sub-packages.
  *
- * ACPI_PTYPE2: Each subpackage contains 1 or 2 object types:
+ * ACPI_PTYPE2: Each subpackage contains 1 or 2 object types. Zero-length
+ *      parent package is allowed:
  *      object type
  *      count
  *      object type
  *      count
  *      (Used for _ALR,_MLS,_PSS,_TRT,_TSS)
  *
- * ACPI_PTYPE2_COUNT: Each subpackage has a count as first element:
+ * ACPI_PTYPE2_COUNT: Each subpackage has a count as first element.
+ *      Zero-length parent package is allowed:
  *      object type
  *      (Used for _CSD,_PSD,_TSD)
  *
@@ -84,17 +86,19 @@
  *      count
  *      (Used for _CST)
  *
- * ACPI_PTYPE2_FIXED: Each subpackage is of Fixed-length
+ * ACPI_PTYPE2_FIXED: Each subpackage is of Fixed-length. Zero-length
+ *      parent package is allowed.
  *      (Used for _PRT)
  *
- * ACPI_PTYPE2_MIN: Each subpackage has a Variable-length but minimum length
+ * ACPI_PTYPE2_MIN: Each subpackage has a Variable-length but minimum length.
+ *      Zero-length parent package is allowed:
  *      (Used for _HPX)
  *
  * ACPI_PTYPE2_REV_FIXED: Revision at start, each subpackage is Fixed-length
  *      (Used for _ART, _FPS)
  *
  * ACPI_PTYPE2_FIX_VAR: Each subpackage consists of some fixed-length elements
- *      followed by an optional element
+ *      followed by an optional element. Zero-length parent package is allowed.
  *      object type
  *      count
  *      object type
@@ -116,8 +120,47 @@ enum acpi_return_package_types {
 	ACPI_PTYPE2_FIX_VAR = 10
 };
 
+/* Support macros for users of the predefined info table */
+
+#define METHOD_PREDEF_ARGS_MAX          4
+#define METHOD_ARG_BIT_WIDTH            3
+#define METHOD_ARG_MASK                 0x0007
+#define ARG_COUNT_IS_MINIMUM            0x8000
+#define METHOD_MAX_ARG_TYPE             ACPI_TYPE_PACKAGE
+
+#define METHOD_GET_COUNT(arg_list)      (arg_list & METHOD_ARG_MASK)
+#define METHOD_GET_NEXT_ARG(arg_list)   (arg_list >> METHOD_ARG_BIT_WIDTH)
+
+/* Macros used to build the predefined info table */
+
+#define METHOD_0ARGS                    0
+#define METHOD_1ARGS(a1)                (1 | (a1 << 3))
+#define METHOD_2ARGS(a1,a2)             (2 | (a1 << 3) | (a2 << 6))
+#define METHOD_3ARGS(a1,a2,a3)          (3 | (a1 << 3) | (a2 << 6) | (a3 << 9))
+#define METHOD_4ARGS(a1,a2,a3,a4)       (4 | (a1 << 3) | (a2 << 6) | (a3 << 9) | (a4 << 12))
+
+#define METHOD_RETURNS(type)            (type)
+#define METHOD_NO_RETURN_VALUE          0
+
+#define PACKAGE_INFO(a,b,c,d,e,f)       {{{(a),(b),(c),(d)}, ((((u16)(f)) << 8) | (e)), 0}}
+
+/* Support macros for the resource descriptor info table */
+
+#define WIDTH_1                         0x0001
+#define WIDTH_2                         0x0002
+#define WIDTH_3                         0x0004
+#define WIDTH_8                         0x0008
+#define WIDTH_16                        0x0010
+#define WIDTH_32                        0x0020
+#define WIDTH_64                        0x0040
+#define VARIABLE_DATA                   0x0080
+#define NUM_RESOURCE_WIDTHS             8
+
+#define WIDTH_ADDRESS                   WIDTH_16 | WIDTH_32 | WIDTH_64
+
 #ifdef ACPI_CREATE_PREDEFINED_TABLE
-/*
+/******************************************************************************
+ *
  * Predefined method/object information table.
  *
  * These are the names that can actually be evaluated via acpi_evaluate_object.
@@ -125,23 +168,24 @@ enum acpi_return_package_types {
  *
  *      1) Predefined/Reserved names that are never evaluated via
  *         acpi_evaluate_object:
- *          _Lxx and _Exx GPE methods
- *          _Qxx EC methods
- *          _T_x compiler temporary variables
+ *              _Lxx and _Exx GPE methods
+ *              _Qxx EC methods
+ *              _T_x compiler temporary variables
+ *              _Wxx wake events
  *
  *      2) Predefined names that never actually exist within the AML code:
- *          Predefined resource descriptor field names
+ *              Predefined resource descriptor field names
  *
  *      3) Predefined names that are implemented within ACPICA:
- *          _OSI
- *
- *      4) Some predefined names that are not documented within the ACPI spec.
- *          _WDG, _WED
+ *              _OSI
  *
  * The main entries in the table each contain the following items:
  *
  * name                 - The ACPI reserved name
- * param_count          - Number of arguments to the method
+ * argument_list        - Contains (in 16 bits), the number of required
+ *                        arguments to the method (3 bits), and a 3-bit type
+ *                        field for each argument (up to 4 arguments). The
+ *                        METHOD_?ARGS macros generate the correct packed data.
  * expected_btypes      - Allowed type(s) for the return value.
  *                        0 means that no return value is expected.
  *
@@ -151,256 +195,511 @@ enum acpi_return_package_types {
  * overall size of the stored data.
  *
  * Note: The additional braces are intended to promote portability.
- */
-static const union acpi_predefined_info predefined_names[] = {
-	{{"_AC0", 0, ACPI_RTYPE_INTEGER}},
-	{{"_AC1", 0, ACPI_RTYPE_INTEGER}},
-	{{"_AC2", 0, ACPI_RTYPE_INTEGER}},
-	{{"_AC3", 0, ACPI_RTYPE_INTEGER}},
-	{{"_AC4", 0, ACPI_RTYPE_INTEGER}},
-	{{"_AC5", 0, ACPI_RTYPE_INTEGER}},
-	{{"_AC6", 0, ACPI_RTYPE_INTEGER}},
-	{{"_AC7", 0, ACPI_RTYPE_INTEGER}},
-	{{"_AC8", 0, ACPI_RTYPE_INTEGER}},
-	{{"_AC9", 0, ACPI_RTYPE_INTEGER}},
-	{{"_ADR", 0, ACPI_RTYPE_INTEGER}},
-	{{"_AEI", 0, ACPI_RTYPE_BUFFER}},
-	{{"_AL0", 0, ACPI_RTYPE_PACKAGE}}, /* Variable-length (Refs) */
-			  {{{ACPI_PTYPE1_VAR, ACPI_RTYPE_REFERENCE, 0,0}, 0,0}},
-
-	{{"_AL1", 0, ACPI_RTYPE_PACKAGE}}, /* Variable-length (Refs) */
-			  {{{ACPI_PTYPE1_VAR, ACPI_RTYPE_REFERENCE, 0,0}, 0,0}},
-
-	{{"_AL2", 0, ACPI_RTYPE_PACKAGE}}, /* Variable-length (Refs) */
-			  {{{ACPI_PTYPE1_VAR, ACPI_RTYPE_REFERENCE, 0,0}, 0,0}},
-
-	{{"_AL3", 0, ACPI_RTYPE_PACKAGE}}, /* Variable-length (Refs) */
-			  {{{ACPI_PTYPE1_VAR, ACPI_RTYPE_REFERENCE, 0,0}, 0,0}},
-
-	{{"_AL4", 0, ACPI_RTYPE_PACKAGE}}, /* Variable-length (Refs) */
-			  {{{ACPI_PTYPE1_VAR, ACPI_RTYPE_REFERENCE, 0,0}, 0,0}},
-
-	{{"_AL5", 0, ACPI_RTYPE_PACKAGE}}, /* Variable-length (Refs) */
-			  {{{ACPI_PTYPE1_VAR, ACPI_RTYPE_REFERENCE, 0,0}, 0,0}},
-
-	{{"_AL6", 0, ACPI_RTYPE_PACKAGE}}, /* Variable-length (Refs) */
-			  {{{ACPI_PTYPE1_VAR, ACPI_RTYPE_REFERENCE, 0,0}, 0,0}},
-
-	{{"_AL7", 0, ACPI_RTYPE_PACKAGE}}, /* Variable-length (Refs) */
-			  {{{ACPI_PTYPE1_VAR, ACPI_RTYPE_REFERENCE, 0,0}, 0,0}},
-
-	{{"_AL8", 0, ACPI_RTYPE_PACKAGE}}, /* Variable-length (Refs) */
-			  {{{ACPI_PTYPE1_VAR, ACPI_RTYPE_REFERENCE, 0,0}, 0,0}},
-
-	{{"_AL9", 0, ACPI_RTYPE_PACKAGE}}, /* Variable-length (Refs) */
-			  {{{ACPI_PTYPE1_VAR, ACPI_RTYPE_REFERENCE, 0,0}, 0,0}},
-
-	{{"_ALC", 0, ACPI_RTYPE_INTEGER}},
-	{{"_ALI", 0, ACPI_RTYPE_INTEGER}},
-	{{"_ALP", 0, ACPI_RTYPE_INTEGER}},
-	{{"_ALR", 0, ACPI_RTYPE_PACKAGE}}, /* Variable-length (Pkgs) each 2 (Ints) */
-			  {{{ACPI_PTYPE2, ACPI_RTYPE_INTEGER, 2,0}, 0,0}},
-
-	{{"_ALT", 0, ACPI_RTYPE_INTEGER}},
-	{{"_ART", 0, ACPI_RTYPE_PACKAGE}},	/* Variable-length (1 Int(rev), n Pkg (2 Ref/11 Int) */
-	{{{ACPI_PTYPE2_REV_FIXED, ACPI_RTYPE_REFERENCE, 2, ACPI_RTYPE_INTEGER},
-	  11, 0}},
-
-	{{"_BBN", 0, ACPI_RTYPE_INTEGER}},
-	{{"_BCL", 0, ACPI_RTYPE_PACKAGE}}, /* Variable-length (Ints) */
-			  {{{ACPI_PTYPE1_VAR, ACPI_RTYPE_INTEGER, 0,0}, 0,0}},
-
-	{{"_BCM", 1, 0}},
-	{{"_BCT", 1, ACPI_RTYPE_INTEGER}},
-	{{"_BDN", 0, ACPI_RTYPE_INTEGER}},
-	{{"_BFS", 1, 0}},
-	{{"_BIF", 0, ACPI_RTYPE_PACKAGE}},	/* Fixed-length (9 Int),(4 Str) */
-	{{{ACPI_PTYPE1_FIXED, ACPI_RTYPE_INTEGER, 9, ACPI_RTYPE_STRING}, 4, 0}},
-
-	{{"_BIX", 0, ACPI_RTYPE_PACKAGE}},	/* Fixed-length (16 Int),(4 Str) */
-	{{{ACPI_PTYPE1_FIXED, ACPI_RTYPE_INTEGER, 16, ACPI_RTYPE_STRING}, 4,
-	  0}},
-
-	{{"_BLT", 3, 0}},
-	{{"_BMA", 1, ACPI_RTYPE_INTEGER}},
-	{{"_BMC", 1, 0}},
-	{{"_BMD", 0, ACPI_RTYPE_PACKAGE}}, /* Fixed-length (5 Int) */
-			  {{{ACPI_PTYPE1_FIXED, ACPI_RTYPE_INTEGER, 5,0}, 0,0}},
-
-	{{"_BMS", 1, ACPI_RTYPE_INTEGER}},
-	{{"_BQC", 0, ACPI_RTYPE_INTEGER}},
-	{{"_BST", 0, ACPI_RTYPE_PACKAGE}}, /* Fixed-length (4 Int) */
-			  {{{ACPI_PTYPE1_FIXED, ACPI_RTYPE_INTEGER, 4,0}, 0,0}},
-
-	{{"_BTM", 1, ACPI_RTYPE_INTEGER}},
-	{{"_BTP", 1, 0}},
-	{{"_CBA", 0, ACPI_RTYPE_INTEGER}}, /* See PCI firmware spec 3.0 */
-	{{"_CDM", 0, ACPI_RTYPE_INTEGER}},
-	{{"_CID", 0, ACPI_RTYPE_INTEGER | ACPI_RTYPE_STRING | ACPI_RTYPE_PACKAGE}}, /* Variable-length (Ints/Strs) */
-	{{{ACPI_PTYPE1_VAR, ACPI_RTYPE_INTEGER | ACPI_RTYPE_STRING, 0, 0}, 0,
-	  0}},
-
-	{{"_CLS", 0, ACPI_RTYPE_PACKAGE}},	/* Fixed-length (3 Int) */
-	{{{ACPI_PTYPE1_FIXED, ACPI_RTYPE_INTEGER, 3, 0}, 0, 0}},
-
-	{{"_CPC", 0, ACPI_RTYPE_PACKAGE}},	/* Variable-length (Ints/Bufs) */
-	{{{ACPI_PTYPE1_VAR, ACPI_RTYPE_INTEGER | ACPI_RTYPE_BUFFER, 0, 0}, 0,
-	  0}},
-
-	{{"_CRS", 0, ACPI_RTYPE_BUFFER}},
-	{{"_CRT", 0, ACPI_RTYPE_INTEGER}},
-	{{"_CSD", 0, ACPI_RTYPE_PACKAGE}}, /* Variable-length (1 Int(n), n-1 Int) */
-			  {{{ACPI_PTYPE2_COUNT, ACPI_RTYPE_INTEGER, 0,0}, 0,0}},
-
-	{{"_CST", 0, ACPI_RTYPE_PACKAGE}}, /* Variable-length (1 Int(n), n Pkg (1 Buf/3 Int) */
-	{{{ACPI_PTYPE2_PKG_COUNT, ACPI_RTYPE_BUFFER, 1, ACPI_RTYPE_INTEGER}, 3,
-	  0}},
-
-	{{"_CWS", 1, ACPI_RTYPE_INTEGER}},
-	{{"_DCK", 1, ACPI_RTYPE_INTEGER}},
-	{{"_DCS", 0, ACPI_RTYPE_INTEGER}},
-	{{"_DDC", 1, ACPI_RTYPE_INTEGER | ACPI_RTYPE_BUFFER}},
-	{{"_DDN", 0, ACPI_RTYPE_STRING}},
-	{{"_DEP", 0, ACPI_RTYPE_PACKAGE}},	/* Variable-length (Refs) */
-	{{{ACPI_PTYPE1_VAR, ACPI_RTYPE_REFERENCE, 0, 0}, 0, 0}},
-
-	{{"_DGS", 0, ACPI_RTYPE_INTEGER}},
-	{{"_DIS", 0, 0}},
-
-	{{"_DLM", 0, ACPI_RTYPE_PACKAGE}},	/* Variable-length (Pkgs) each (1 Ref, 0/1 Optional Buf/Ref) */
-	{{{ACPI_PTYPE2_FIX_VAR, ACPI_RTYPE_REFERENCE, 1,
-	   ACPI_RTYPE_REFERENCE | ACPI_RTYPE_BUFFER}, 0, 0}},
-
-	{{"_DMA", 0, ACPI_RTYPE_BUFFER}},
-	{{"_DOD", 0, ACPI_RTYPE_PACKAGE}}, /* Variable-length (Ints) */
-			  {{{ACPI_PTYPE1_VAR, ACPI_RTYPE_INTEGER, 0,0}, 0,0}},
-
-	{{"_DOS", 1, 0}},
-	{{"_DSM", 4, ACPI_RTYPE_ALL}},     /* Must return a type, but it can be of any type */
-	{{"_DSS", 1, 0}},
-	{{"_DSW", 3, 0}},
-	{{"_DTI", 1, 0}},
-	{{"_EC_", 0, ACPI_RTYPE_INTEGER}},
-	{{"_EDL", 0, ACPI_RTYPE_PACKAGE}}, /* Variable-length (Refs)*/
-			  {{{ACPI_PTYPE1_VAR, ACPI_RTYPE_REFERENCE, 0,0}, 0,0}},
-
-	{{"_EJ0", 1, 0}},
-	{{"_EJ1", 1, 0}},
-	{{"_EJ2", 1, 0}},
-	{{"_EJ3", 1, 0}},
-	{{"_EJ4", 1, 0}},
-	{{"_EJD", 0, ACPI_RTYPE_STRING}},
-	{{"_EVT", 1, 0}},
-	{{"_FDE", 0, ACPI_RTYPE_BUFFER}},
-	{{"_FDI", 0, ACPI_RTYPE_PACKAGE}}, /* Fixed-length (16 Int) */
-			  {{{ACPI_PTYPE1_FIXED, ACPI_RTYPE_INTEGER, 16,0}, 0,0}},
-
-	{{"_FDM", 1, 0}},
-	{{"_FIF", 0, ACPI_RTYPE_PACKAGE}},	/* Fixed-length (4 Int) */
-			  {{{ACPI_PTYPE1_FIXED, ACPI_RTYPE_INTEGER, 4, 0}, 0, 0}},
-
-	{{"_FIX", 0, ACPI_RTYPE_PACKAGE}}, /* Variable-length (Ints) */
-			  {{{ACPI_PTYPE1_VAR, ACPI_RTYPE_INTEGER, 0,0}, 0,0}},
-
-	{{"_FPS", 0, ACPI_RTYPE_PACKAGE}},	/* Variable-length (1 Int(rev), n Pkg (5 Int) */
-	{{{ACPI_PTYPE2_REV_FIXED, ACPI_RTYPE_INTEGER, 5, 0}, 0, 0}},
-
-	{{"_FSL", 1, 0}},
-	{{"_FST", 0, ACPI_RTYPE_PACKAGE}},	/* Fixed-length (3 Int) */
-	{{{ACPI_PTYPE1_FIXED, ACPI_RTYPE_INTEGER, 3, 0}, 0, 0}},
-
-	{{"_GAI", 0, ACPI_RTYPE_INTEGER}},
-	{{"_GCP", 0, ACPI_RTYPE_INTEGER}},
-	{{"_GHL", 0, ACPI_RTYPE_INTEGER}},
-	{{"_GLK", 0, ACPI_RTYPE_INTEGER}},
-	{{"_GPD", 0, ACPI_RTYPE_INTEGER}},
-	{{"_GPE", 0, ACPI_RTYPE_INTEGER}}, /* _GPE method, not _GPE scope */
-	{{"_GRT", 0, ACPI_RTYPE_BUFFER}},
-	{{"_GSB", 0, ACPI_RTYPE_INTEGER}},
-	{{"_GTF", 0, ACPI_RTYPE_BUFFER}},
-	{{"_GTM", 0, ACPI_RTYPE_BUFFER}},
-	{{"_GTS", 1, 0}},
-	{{"_GWS", 1, ACPI_RTYPE_INTEGER}},
-	{{"_HID", 0, ACPI_RTYPE_INTEGER | ACPI_RTYPE_STRING}},
-	{{"_HOT", 0, ACPI_RTYPE_INTEGER}},
-	{{"_HPP", 0, ACPI_RTYPE_PACKAGE}}, /* Fixed-length (4 Int) */
-			  {{{ACPI_PTYPE1_FIXED, ACPI_RTYPE_INTEGER, 4,0}, 0,0}},
+ *
+ * Note2: Table is used by the kernel-resident subsystem, the iASL compiler,
+ * and the acpi_help utility.
+ *
+ * TBD: _PRT - currently ignore reversed entries. Attempt to fix in nsrepair.
+ * Possibly fixing package elements like _BIF, etc.
+ *
+ *****************************************************************************/
+
+const union acpi_predefined_info acpi_gbl_predefined_methods[] = {
+	{{"_AC0", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_AC1", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_AC2", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_AC3", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_AC4", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_AC5", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_AC6", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_AC7", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_AC8", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_AC9", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_ADR", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_AEI", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_BUFFER)}},
+
+	{{"_AL0", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Variable-length (Refs) */
+	PACKAGE_INFO(ACPI_PTYPE1_VAR, ACPI_RTYPE_REFERENCE, 0, 0, 0, 0),
+
+	{{"_AL1", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Variable-length (Refs) */
+	PACKAGE_INFO(ACPI_PTYPE1_VAR, ACPI_RTYPE_REFERENCE, 0, 0, 0, 0),
+
+	{{"_AL2", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Variable-length (Refs) */
+	PACKAGE_INFO(ACPI_PTYPE1_VAR, ACPI_RTYPE_REFERENCE, 0, 0, 0, 0),
+
+	{{"_AL3", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Variable-length (Refs) */
+	PACKAGE_INFO(ACPI_PTYPE1_VAR, ACPI_RTYPE_REFERENCE, 0, 0, 0, 0),
+
+	{{"_AL4", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Variable-length (Refs) */
+	PACKAGE_INFO(ACPI_PTYPE1_VAR, ACPI_RTYPE_REFERENCE, 0, 0, 0, 0),
+
+	{{"_AL5", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Variable-length (Refs) */
+	PACKAGE_INFO(ACPI_PTYPE1_VAR, ACPI_RTYPE_REFERENCE, 0, 0, 0, 0),
+
+	{{"_AL6", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Variable-length (Refs) */
+	PACKAGE_INFO(ACPI_PTYPE1_VAR, ACPI_RTYPE_REFERENCE, 0, 0, 0, 0),
+
+	{{"_AL7", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Variable-length (Refs) */
+	PACKAGE_INFO(ACPI_PTYPE1_VAR, ACPI_RTYPE_REFERENCE, 0, 0, 0, 0),
+
+	{{"_AL8", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Variable-length (Refs) */
+	PACKAGE_INFO(ACPI_PTYPE1_VAR, ACPI_RTYPE_REFERENCE, 0, 0, 0, 0),
+
+	{{"_AL9", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Variable-length (Refs) */
+	PACKAGE_INFO(ACPI_PTYPE1_VAR, ACPI_RTYPE_REFERENCE, 0, 0, 0, 0),
+
+	{{"_ALC", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_ALI", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_ALP", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_ALR", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Variable-length (Pkgs) each 2 (Ints) */
+	PACKAGE_INFO(ACPI_PTYPE2, ACPI_RTYPE_INTEGER, 2, 0, 0, 0),
+
+	{{"_ALT", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_ART", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Variable-length (1 Int(rev), n Pkg (2 Ref/11 Int) */
+	PACKAGE_INFO(ACPI_PTYPE2_REV_FIXED, ACPI_RTYPE_REFERENCE, 2,
+		     ACPI_RTYPE_INTEGER, 11, 0),
+
+	{{"_BBN", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_BCL", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Variable-length (Ints) */
+	PACKAGE_INFO(ACPI_PTYPE1_VAR, ACPI_RTYPE_INTEGER, 0, 0, 0, 0),
+
+	{{"_BCM", METHOD_1ARGS(ACPI_TYPE_INTEGER),
+	  METHOD_NO_RETURN_VALUE}},
+
+	{{"_BCT", METHOD_1ARGS(ACPI_TYPE_INTEGER),
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_BDN", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_BFS", METHOD_1ARGS(ACPI_TYPE_INTEGER),
+	  METHOD_NO_RETURN_VALUE}},
+
+	{{"_BIF", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Fixed-length (9 Int),(4 Str) */
+	PACKAGE_INFO(ACPI_PTYPE1_FIXED, ACPI_RTYPE_INTEGER, 9,
+		     ACPI_RTYPE_STRING, 4, 0),
+
+	{{"_BIX", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Fixed-length (16 Int),(4 Str) */
+	PACKAGE_INFO(ACPI_PTYPE1_FIXED, ACPI_RTYPE_INTEGER, 16,
+		     ACPI_RTYPE_STRING, 4, 0),
+
+	{{"_BLT",
+	  METHOD_3ARGS(ACPI_TYPE_INTEGER, ACPI_TYPE_INTEGER, ACPI_TYPE_INTEGER),
+	  METHOD_NO_RETURN_VALUE}},
+
+	{{"_BMA", METHOD_1ARGS(ACPI_TYPE_INTEGER),
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_BMC", METHOD_1ARGS(ACPI_TYPE_INTEGER),
+	  METHOD_NO_RETURN_VALUE}},
+
+	{{"_BMD", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Fixed-length (5 Int) */
+	PACKAGE_INFO(ACPI_PTYPE1_FIXED, ACPI_RTYPE_INTEGER, 5, 0, 0, 0),
+
+	{{"_BMS", METHOD_1ARGS(ACPI_TYPE_INTEGER),
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_BQC", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_BST", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Fixed-length (4 Int) */
+	PACKAGE_INFO(ACPI_PTYPE1_FIXED, ACPI_RTYPE_INTEGER, 4, 0, 0, 0),
+
+	{{"_BTM", METHOD_1ARGS(ACPI_TYPE_INTEGER),
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_BTP", METHOD_1ARGS(ACPI_TYPE_INTEGER),
+	  METHOD_NO_RETURN_VALUE}},
+
+	{{"_CBA", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},	/* See PCI firmware spec 3.0 */
+
+	{{"_CDM", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_CID", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER | ACPI_RTYPE_STRING | ACPI_RTYPE_PACKAGE)}},	/* Variable-length (Ints/Strs) */
+	PACKAGE_INFO(ACPI_PTYPE1_VAR, ACPI_RTYPE_INTEGER | ACPI_RTYPE_STRING, 0,
+		     0, 0, 0),
+
+	{{"_CLS", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Fixed-length (3 Int) */
+	PACKAGE_INFO(ACPI_PTYPE1_FIXED, ACPI_RTYPE_INTEGER, 3, 0, 0, 0),
+
+	{{"_CPC", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Variable-length (Ints/Bufs) */
+	PACKAGE_INFO(ACPI_PTYPE1_VAR, ACPI_RTYPE_INTEGER | ACPI_RTYPE_BUFFER, 0,
+		     0, 0, 0),
+
+	{{"_CRS", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_BUFFER)}},
+
+	{{"_CRT", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_CSD", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Variable-length (1 Int(n), n-1 Int) */
+	PACKAGE_INFO(ACPI_PTYPE2_COUNT, ACPI_RTYPE_INTEGER, 0, 0, 0, 0),
+
+	{{"_CST", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Variable-length (1 Int(n), n Pkg (1 Buf/3 Int) */
+	PACKAGE_INFO(ACPI_PTYPE2_PKG_COUNT, ACPI_RTYPE_BUFFER, 1,
+		     ACPI_RTYPE_INTEGER, 3, 0),
+
+	{{"_CWS", METHOD_1ARGS(ACPI_TYPE_INTEGER),
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_DCK", METHOD_1ARGS(ACPI_TYPE_INTEGER),
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_DCS", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_DDC", METHOD_1ARGS(ACPI_TYPE_INTEGER),
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER | ACPI_RTYPE_BUFFER)}},
+
+	{{"_DDN", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_STRING)}},
+
+	{{"_DEP", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Variable-length (Refs) */
+	PACKAGE_INFO(ACPI_PTYPE1_VAR, ACPI_RTYPE_REFERENCE, 0, 0, 0, 0),
+
+	{{"_DGS", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_DIS", METHOD_0ARGS,
+	  METHOD_NO_RETURN_VALUE}},
+
+	{{"_DLM", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Variable-length (Pkgs) each (1 Ref, 0/1 Optional Buf/Ref) */
+	PACKAGE_INFO(ACPI_PTYPE2_FIX_VAR, ACPI_RTYPE_REFERENCE, 1,
+		     ACPI_RTYPE_REFERENCE | ACPI_RTYPE_BUFFER, 0, 0),
+
+	{{"_DMA", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_BUFFER)}},
+
+	{{"_DOD", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Variable-length (Ints) */
+	PACKAGE_INFO(ACPI_PTYPE1_VAR, ACPI_RTYPE_INTEGER, 0, 0, 0, 0),
+
+	{{"_DOS", METHOD_1ARGS(ACPI_TYPE_INTEGER),
+	  METHOD_NO_RETURN_VALUE}},
+
+	{{"_DSM",
+	  METHOD_4ARGS(ACPI_TYPE_BUFFER, ACPI_TYPE_INTEGER, ACPI_TYPE_INTEGER,
+		       ACPI_TYPE_PACKAGE),
+	  METHOD_RETURNS(ACPI_RTYPE_ALL)}},	/* Must return a value, but it can be of any type */
+
+	{{"_DSS", METHOD_1ARGS(ACPI_TYPE_INTEGER),
+	  METHOD_NO_RETURN_VALUE}},
+
+	{{"_DSW",
+	  METHOD_3ARGS(ACPI_TYPE_INTEGER, ACPI_TYPE_INTEGER, ACPI_TYPE_INTEGER),
+	  METHOD_NO_RETURN_VALUE}},
+
+	{{"_DTI", METHOD_1ARGS(ACPI_TYPE_INTEGER),
+	  METHOD_NO_RETURN_VALUE}},
+
+	{{"_EC_", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_EDL", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Variable-length (Refs) */
+	PACKAGE_INFO(ACPI_PTYPE1_VAR, ACPI_RTYPE_REFERENCE, 0, 0, 0, 0),
+
+	{{"_EJ0", METHOD_1ARGS(ACPI_TYPE_INTEGER),
+	  METHOD_NO_RETURN_VALUE}},
+
+	{{"_EJ1", METHOD_1ARGS(ACPI_TYPE_INTEGER),
+	  METHOD_NO_RETURN_VALUE}},
+
+	{{"_EJ2", METHOD_1ARGS(ACPI_TYPE_INTEGER),
+	  METHOD_NO_RETURN_VALUE}},
+
+	{{"_EJ3", METHOD_1ARGS(ACPI_TYPE_INTEGER),
+	  METHOD_NO_RETURN_VALUE}},
+
+	{{"_EJ4", METHOD_1ARGS(ACPI_TYPE_INTEGER),
+	  METHOD_NO_RETURN_VALUE}},
+
+	{{"_EJD", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_STRING)}},
+
+	{{"_ERR",
+	  METHOD_3ARGS(ACPI_TYPE_INTEGER, ACPI_TYPE_STRING, ACPI_TYPE_INTEGER),
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},	/* Internal use only, used by ACPICA test suites */
+
+	{{"_EVT", METHOD_1ARGS(ACPI_TYPE_INTEGER),
+	  METHOD_NO_RETURN_VALUE}},
+
+	{{"_FDE", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_BUFFER)}},
+
+	{{"_FDI", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Fixed-length (16 Int) */
+	PACKAGE_INFO(ACPI_PTYPE1_FIXED, ACPI_RTYPE_INTEGER, 16, 0, 0, 0),
+
+	{{"_FDM", METHOD_1ARGS(ACPI_TYPE_INTEGER),
+	  METHOD_NO_RETURN_VALUE}},
+
+	{{"_FIF", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Fixed-length (4 Int) */
+	PACKAGE_INFO(ACPI_PTYPE1_FIXED, ACPI_RTYPE_INTEGER, 4, 0, 0, 0),
+
+	{{"_FIX", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Variable-length (Ints) */
+	PACKAGE_INFO(ACPI_PTYPE1_VAR, ACPI_RTYPE_INTEGER, 0, 0, 0, 0),
+
+	{{"_FPS", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Variable-length (1 Int(rev), n Pkg (5 Int) */
+	PACKAGE_INFO(ACPI_PTYPE2_REV_FIXED, ACPI_RTYPE_INTEGER, 5, 0, 0, 0),
+
+	{{"_FSL", METHOD_1ARGS(ACPI_TYPE_INTEGER),
+	  METHOD_NO_RETURN_VALUE}},
+
+	{{"_FST", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Fixed-length (3 Int) */
+	PACKAGE_INFO(ACPI_PTYPE1_FIXED, ACPI_RTYPE_INTEGER, 3, 0, 0, 0),
+
+	{{"_GAI", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_GCP", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_GHL", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_GLK", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_GPD", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_GPE", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},	/* _GPE method, not _GPE scope */
+
+	{{"_GRT", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_BUFFER)}},
+
+	{{"_GSB", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_GTF", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_BUFFER)}},
+
+	{{"_GTM", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_BUFFER)}},
+
+	{{"_GTS", METHOD_1ARGS(ACPI_TYPE_INTEGER),
+	  METHOD_NO_RETURN_VALUE}},
+
+	{{"_GWS", METHOD_1ARGS(ACPI_TYPE_INTEGER),
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_HID", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER | ACPI_RTYPE_STRING)}},
+
+	{{"_HOT", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_HPP", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Fixed-length (4 Int) */
+	PACKAGE_INFO(ACPI_PTYPE1_FIXED, ACPI_RTYPE_INTEGER, 4, 0, 0, 0),
 
 	/*
-	 * For _HPX, a single package is returned, containing a Variable-length number
+	 * For _HPX, a single package is returned, containing a variable-length number
 	 * of sub-packages. Each sub-package contains a PCI record setting.
 	 * There are several different type of record settings, of different
 	 * lengths, but all elements of all settings are Integers.
 	 */
-	{{"_HPX", 0, ACPI_RTYPE_PACKAGE}}, /* Variable-length (Pkgs) each (var Ints) */
-			  {{{ACPI_PTYPE2_MIN, ACPI_RTYPE_INTEGER, 5,0}, 0,0}},
-
-	{{"_HRV", 0, ACPI_RTYPE_INTEGER}},
-	{{"_IFT", 0, ACPI_RTYPE_INTEGER}}, /* See IPMI spec */
-	{{"_INI", 0, 0}},
-	{{"_IRC", 0, 0}},
-	{{"_LCK", 1, 0}},
-	{{"_LID", 0, ACPI_RTYPE_INTEGER}},
-	{{"_MAT", 0, ACPI_RTYPE_BUFFER}},
-	{{"_MBM", 0, ACPI_RTYPE_PACKAGE}},	/* Fixed-length (8 Int) */
-	{{{ACPI_PTYPE1_FIXED, ACPI_RTYPE_INTEGER, 8, 0}, 0, 0}},
-
-	{{"_MLS", 0, ACPI_RTYPE_PACKAGE}},	/* Variable-length (Pkgs) each (1 Str/1 Buf) */
-	{{{ACPI_PTYPE2, ACPI_RTYPE_STRING, 1, ACPI_RTYPE_BUFFER}, 1, 0}},
-
-	{{"_MSG", 1, 0}},
-	{{"_MSM", 4, ACPI_RTYPE_INTEGER}},
-	{{"_NTT", 0, ACPI_RTYPE_INTEGER}},
-	{{"_OFF", 0, 0}},
-	{{"_ON_", 0, 0}},
-	{{"_OS_", 0, ACPI_RTYPE_STRING}},
-	{{"_OSC", 4, ACPI_RTYPE_BUFFER}},
-	{{"_OST", 3, 0}},
-	{{"_PAI", 1, ACPI_RTYPE_INTEGER}},
-	{{"_PCL", 0, ACPI_RTYPE_PACKAGE}}, /* Variable-length (Refs) */
-			  {{{ACPI_PTYPE1_VAR, ACPI_RTYPE_REFERENCE, 0,0}, 0,0}},
-
-	{{"_PCT", 0, ACPI_RTYPE_PACKAGE}}, /* Fixed-length (2 Buf) */
-			  {{{ACPI_PTYPE1_FIXED, ACPI_RTYPE_BUFFER, 2,0}, 0,0}},
-
-	{{"_PDC", 1, 0}},
-	{{"_PDL", 0, ACPI_RTYPE_INTEGER}},
-	{{"_PIC", 1, 0}},
-	{{"_PIF", 0, ACPI_RTYPE_PACKAGE}},	/* Fixed-length (3 Int),(3 Str) */
-	{{{ACPI_PTYPE1_FIXED, ACPI_RTYPE_INTEGER, 3, ACPI_RTYPE_STRING}, 3, 0}},
-
-	{{"_PLD", 0, ACPI_RTYPE_PACKAGE}}, /* Variable-length (Bufs) */
-			  {{{ACPI_PTYPE1_VAR, ACPI_RTYPE_BUFFER, 0,0}, 0,0}},
-
-	{{"_PMC", 0, ACPI_RTYPE_PACKAGE}},	/* Fixed-length (11 Int),(3 Str) */
-	{{{ACPI_PTYPE1_FIXED, ACPI_RTYPE_INTEGER, 11, ACPI_RTYPE_STRING}, 3,
-	  0}},
-
-	{{"_PMD", 0, ACPI_RTYPE_PACKAGE}},	/* Variable-length (Refs) */
-	{{{ACPI_PTYPE1_VAR, ACPI_RTYPE_REFERENCE, 0, 0}, 0, 0}},
-
-	{{"_PMM", 0, ACPI_RTYPE_INTEGER}},
-	{{"_PPC", 0, ACPI_RTYPE_INTEGER}},
-	{{"_PPE", 0, ACPI_RTYPE_INTEGER}}, /* See dig64 spec */
-	{{"_PR0", 0, ACPI_RTYPE_PACKAGE}}, /* Variable-length (Refs) */
-			  {{{ACPI_PTYPE1_VAR, ACPI_RTYPE_REFERENCE, 0,0}, 0,0}},
-
-	{{"_PR1", 0, ACPI_RTYPE_PACKAGE}}, /* Variable-length (Refs) */
-			  {{{ACPI_PTYPE1_VAR, ACPI_RTYPE_REFERENCE, 0,0}, 0,0}},
-
-	{{"_PR2", 0, ACPI_RTYPE_PACKAGE}}, /* Variable-length (Refs) */
-			  {{{ACPI_PTYPE1_VAR, ACPI_RTYPE_REFERENCE, 0,0}, 0,0}},
-
-	{{"_PR3", 0, ACPI_RTYPE_PACKAGE}},	/* Variable-length (Refs) */
-	{{{ACPI_PTYPE1_VAR, ACPI_RTYPE_REFERENCE, 0, 0}, 0, 0}},
-
-	{{"_PRE", 0, ACPI_RTYPE_PACKAGE}},	/* Variable-length (Refs) */
-	{{{ACPI_PTYPE1_VAR, ACPI_RTYPE_REFERENCE, 0, 0}, 0, 0}},
-
-	{{"_PRL", 0, ACPI_RTYPE_PACKAGE}},	/* Variable-length (Refs) */
-	{{{ACPI_PTYPE1_VAR, ACPI_RTYPE_REFERENCE, 0, 0}, 0, 0}},
-
-	{{"_PRS", 0, ACPI_RTYPE_BUFFER}},
+	{{"_HPX", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Variable-length (Pkgs) each (var Ints) */
+	PACKAGE_INFO(ACPI_PTYPE2_MIN, ACPI_RTYPE_INTEGER, 5, 0, 0, 0),
+
+	{{"_HRV", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_IFT", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},	/* See IPMI spec */
+
+	{{"_INI", METHOD_0ARGS,
+	  METHOD_NO_RETURN_VALUE}},
+
+	{{"_IRC", METHOD_0ARGS,
+	  METHOD_NO_RETURN_VALUE}},
+
+	{{"_LCK", METHOD_1ARGS(ACPI_TYPE_INTEGER),
+	  METHOD_NO_RETURN_VALUE}},
+
+	{{"_LID", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_MAT", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_BUFFER)}},
+
+	{{"_MBM", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Fixed-length (8 Int) */
+	PACKAGE_INFO(ACPI_PTYPE1_FIXED, ACPI_RTYPE_INTEGER, 8, 0, 0, 0),
+
+	{{"_MLS", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Variable-length (Pkgs) each (1 Str/1 Buf) */
+	PACKAGE_INFO(ACPI_PTYPE2, ACPI_RTYPE_STRING, 1, ACPI_RTYPE_BUFFER, 1,
+		     0),
+
+	{{"_MSG", METHOD_1ARGS(ACPI_TYPE_INTEGER),
+	  METHOD_NO_RETURN_VALUE}},
+
+	{{"_MSM",
+	  METHOD_4ARGS(ACPI_TYPE_INTEGER, ACPI_TYPE_INTEGER, ACPI_TYPE_INTEGER,
+		       ACPI_TYPE_INTEGER),
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_NTT", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_OFF", METHOD_0ARGS,
+	  METHOD_NO_RETURN_VALUE}},
+
+	{{"_ON_", METHOD_0ARGS,
+	  METHOD_NO_RETURN_VALUE}},
+
+	{{"_OS_", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_STRING)}},
+
+	{{"_OSC",
+	  METHOD_4ARGS(ACPI_TYPE_BUFFER, ACPI_TYPE_INTEGER, ACPI_TYPE_INTEGER,
+		       ACPI_TYPE_BUFFER),
+	  METHOD_RETURNS(ACPI_RTYPE_BUFFER)}},
+
+	{{"_OST",
+	  METHOD_3ARGS(ACPI_TYPE_INTEGER, ACPI_TYPE_INTEGER, ACPI_TYPE_BUFFER),
+	  METHOD_NO_RETURN_VALUE}},
+
+	{{"_PAI", METHOD_1ARGS(ACPI_TYPE_INTEGER),
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_PCL", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Variable-length (Refs) */
+	PACKAGE_INFO(ACPI_PTYPE1_VAR, ACPI_RTYPE_REFERENCE, 0, 0, 0, 0),
+
+	{{"_PCT", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Fixed-length (2 Buf) */
+	PACKAGE_INFO(ACPI_PTYPE1_FIXED, ACPI_RTYPE_BUFFER, 2, 0, 0, 0),
+
+	{{"_PDC", METHOD_1ARGS(ACPI_TYPE_BUFFER),
+	  METHOD_NO_RETURN_VALUE}},
+
+	{{"_PDL", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_PIC", METHOD_1ARGS(ACPI_TYPE_INTEGER),
+	  METHOD_NO_RETURN_VALUE}},
+
+	{{"_PIF", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Fixed-length (3 Int),(3 Str) */
+	PACKAGE_INFO(ACPI_PTYPE1_FIXED, ACPI_RTYPE_INTEGER, 3,
+		     ACPI_RTYPE_STRING, 3, 0),
+
+	{{"_PLD", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Variable-length (Bufs) */
+	PACKAGE_INFO(ACPI_PTYPE1_VAR, ACPI_RTYPE_BUFFER, 0, 0, 0, 0),
+
+	{{"_PMC", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Fixed-length (11 Int),(3 Str) */
+	PACKAGE_INFO(ACPI_PTYPE1_FIXED, ACPI_RTYPE_INTEGER, 11,
+		     ACPI_RTYPE_STRING, 3, 0),
+
+	{{"_PMD", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Variable-length (Refs) */
+	PACKAGE_INFO(ACPI_PTYPE1_VAR, ACPI_RTYPE_REFERENCE, 0, 0, 0, 0),
+
+	{{"_PMM", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_PPC", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_PPE", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},	/* See dig64 spec */
+
+	{{"_PR0", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Variable-length (Refs) */
+	PACKAGE_INFO(ACPI_PTYPE1_VAR, ACPI_RTYPE_REFERENCE, 0, 0, 0, 0),
+
+	{{"_PR1", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Variable-length (Refs) */
+	PACKAGE_INFO(ACPI_PTYPE1_VAR, ACPI_RTYPE_REFERENCE, 0, 0, 0, 0),
+
+	{{"_PR2", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Variable-length (Refs) */
+	PACKAGE_INFO(ACPI_PTYPE1_VAR, ACPI_RTYPE_REFERENCE, 0, 0, 0, 0),
+
+	{{"_PR3", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Variable-length (Refs) */
+	PACKAGE_INFO(ACPI_PTYPE1_VAR, ACPI_RTYPE_REFERENCE, 0, 0, 0, 0),
+
+	{{"_PRE", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Variable-length (Refs) */
+	PACKAGE_INFO(ACPI_PTYPE1_VAR, ACPI_RTYPE_REFERENCE, 0, 0, 0, 0),
+
+	{{"_PRL", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Variable-length (Refs) */
+	PACKAGE_INFO(ACPI_PTYPE1_VAR, ACPI_RTYPE_REFERENCE, 0, 0, 0, 0),
+
+	{{"_PRS", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_BUFFER)}},
 
 	/*
 	 * For _PRT, many BIOSs reverse the 3rd and 4th Package elements (Source
@@ -410,47 +709,89 @@ static const union acpi_predefined_info predefined_names[] = {
 	 * warning, add the ACPI_RTYPE_REFERENCE type to the 4th element (index 3)
 	 * in the statement below.
 	 */
-	{{"_PRT", 0, ACPI_RTYPE_PACKAGE}}, /* Variable-length (Pkgs) each (4): Int,Int,Int/Ref,Int */
-			  {{{ACPI_PTYPE2_FIXED, 4, ACPI_RTYPE_INTEGER,ACPI_RTYPE_INTEGER},
-			  ACPI_RTYPE_INTEGER | ACPI_RTYPE_REFERENCE,
-			  ACPI_RTYPE_INTEGER}},
-
-	{{"_PRW", 0, ACPI_RTYPE_PACKAGE}}, /* Variable-length (Pkgs) each: Pkg/Int,Int,[Variable-length Refs] (Pkg is Ref/Int) */
-			  {{{ACPI_PTYPE1_OPTION, 2, ACPI_RTYPE_INTEGER | ACPI_RTYPE_PACKAGE,
-			  ACPI_RTYPE_INTEGER}, ACPI_RTYPE_REFERENCE,0}},
-
-	{{"_PS0", 0, 0}},
-	{{"_PS1", 0, 0}},
-	{{"_PS2", 0, 0}},
-	{{"_PS3", 0, 0}},
-	{{"_PSC", 0, ACPI_RTYPE_INTEGER}},
-	{{"_PSD", 0, ACPI_RTYPE_PACKAGE}}, /* Variable-length (Pkgs) each (5 Int) with count */
-			  {{{ACPI_PTYPE2_COUNT, ACPI_RTYPE_INTEGER,0,0}, 0,0}},
-
-	{{"_PSE", 1, 0}},
-	{{"_PSL", 0, ACPI_RTYPE_PACKAGE}}, /* Variable-length (Refs) */
-			  {{{ACPI_PTYPE1_VAR, ACPI_RTYPE_REFERENCE, 0,0}, 0,0}},
-
-	{{"_PSR", 0, ACPI_RTYPE_INTEGER}},
-	{{"_PSS", 0, ACPI_RTYPE_PACKAGE}}, /* Variable-length (Pkgs) each (6 Int) */
-			  {{{ACPI_PTYPE2, ACPI_RTYPE_INTEGER, 6,0}, 0,0}},
-
-	{{"_PSV", 0, ACPI_RTYPE_INTEGER}},
-	{{"_PSW", 1, 0}},
-	{{"_PTC", 0, ACPI_RTYPE_PACKAGE}}, /* Fixed-length (2 Buf) */
-			  {{{ACPI_PTYPE1_FIXED, ACPI_RTYPE_BUFFER, 2,0}, 0,0}},
-
-	{{"_PTP", 2, ACPI_RTYPE_INTEGER}},
-	{{"_PTS", 1, 0}},
-	{{"_PUR", 0, ACPI_RTYPE_PACKAGE}},	/* Fixed-length (2 Int) */
-	{{{ACPI_PTYPE1_FIXED, ACPI_RTYPE_INTEGER, 2, 0}, 0, 0}},
-
-	{{"_PXM", 0, ACPI_RTYPE_INTEGER}},
-	{{"_REG", 2, 0}},
-	{{"_REV", 0, ACPI_RTYPE_INTEGER}},
-	{{"_RMV", 0, ACPI_RTYPE_INTEGER}},
-	{{"_ROM", 2, ACPI_RTYPE_BUFFER}},
-	{{"_RTV", 0, ACPI_RTYPE_INTEGER}},
+	{{"_PRT", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Variable-length (Pkgs) each (4): Int,Int,Int/Ref,Int */
+	PACKAGE_INFO(ACPI_PTYPE2_FIXED, 4, ACPI_RTYPE_INTEGER,
+		     ACPI_RTYPE_INTEGER,
+		     ACPI_RTYPE_INTEGER | ACPI_RTYPE_REFERENCE,
+		     ACPI_RTYPE_INTEGER),
+
+	{{"_PRW", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Variable-length (Pkgs) each: Pkg/Int,Int,[Variable-length Refs] (Pkg is Ref/Int) */
+	PACKAGE_INFO(ACPI_PTYPE1_OPTION, 2,
+		     ACPI_RTYPE_INTEGER | ACPI_RTYPE_PACKAGE,
+		     ACPI_RTYPE_INTEGER, ACPI_RTYPE_REFERENCE, 0),
+
+	{{"_PS0", METHOD_0ARGS,
+	  METHOD_NO_RETURN_VALUE}},
+
+	{{"_PS1", METHOD_0ARGS,
+	  METHOD_NO_RETURN_VALUE}},
+
+	{{"_PS2", METHOD_0ARGS,
+	  METHOD_NO_RETURN_VALUE}},
+
+	{{"_PS3", METHOD_0ARGS,
+	  METHOD_NO_RETURN_VALUE}},
+
+	{{"_PSC", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_PSD", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Variable-length (Pkgs) each (5 Int) with count */
+	PACKAGE_INFO(ACPI_PTYPE2_COUNT, ACPI_RTYPE_INTEGER, 0, 0, 0, 0),
+
+	{{"_PSE", METHOD_1ARGS(ACPI_TYPE_INTEGER),
+	  METHOD_NO_RETURN_VALUE}},
+
+	{{"_PSL", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Variable-length (Refs) */
+	PACKAGE_INFO(ACPI_PTYPE1_VAR, ACPI_RTYPE_REFERENCE, 0, 0, 0, 0),
+
+	{{"_PSR", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_PSS", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Variable-length (Pkgs) each (6 Int) */
+	PACKAGE_INFO(ACPI_PTYPE2, ACPI_RTYPE_INTEGER, 6, 0, 0, 0),
+
+	{{"_PSV", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_PSW", METHOD_1ARGS(ACPI_TYPE_INTEGER),
+	  METHOD_NO_RETURN_VALUE}},
+
+	{{"_PTC", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Fixed-length (2 Buf) */
+	PACKAGE_INFO(ACPI_PTYPE1_FIXED, ACPI_RTYPE_BUFFER, 2, 0, 0, 0),
+
+	{{"_PTP", METHOD_2ARGS(ACPI_TYPE_INTEGER, ACPI_TYPE_INTEGER),
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_PTS", METHOD_1ARGS(ACPI_TYPE_INTEGER),
+	  METHOD_NO_RETURN_VALUE}},
+
+	{{"_PUR", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Fixed-length (2 Int) */
+	PACKAGE_INFO(ACPI_PTYPE1_FIXED, ACPI_RTYPE_INTEGER, 2, 0, 0, 0),
+
+	{{"_PXM", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_REG", METHOD_2ARGS(ACPI_TYPE_INTEGER, ACPI_TYPE_INTEGER),
+	  METHOD_NO_RETURN_VALUE}},
+
+	{{"_REV", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_RMV", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_ROM", METHOD_2ARGS(ACPI_TYPE_INTEGER, ACPI_TYPE_INTEGER),
+	  METHOD_RETURNS(ACPI_RTYPE_BUFFER)}},
+
+	{{"_RTV", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
 
 	/*
 	 * For _S0_ through _S5_, the ACPI spec defines a return Package
@@ -458,111 +799,285 @@ static const union acpi_predefined_info predefined_names[] = {
 	 * Allow this by making the objects "Variable-length length", but all elements
 	 * must be Integers.
 	 */
-	{{"_S0_", 0, ACPI_RTYPE_PACKAGE}}, /* Fixed-length (1 Int) */
-			  {{{ACPI_PTYPE1_VAR, ACPI_RTYPE_INTEGER, 1,0}, 0,0}},
-
-	{{"_S1_", 0, ACPI_RTYPE_PACKAGE}}, /* Fixed-length (1 Int) */
-			  {{{ACPI_PTYPE1_VAR, ACPI_RTYPE_INTEGER, 1,0}, 0,0}},
-
-	{{"_S2_", 0, ACPI_RTYPE_PACKAGE}}, /* Fixed-length (1 Int) */
-			  {{{ACPI_PTYPE1_VAR, ACPI_RTYPE_INTEGER, 1,0}, 0,0}},
-
-	{{"_S3_", 0, ACPI_RTYPE_PACKAGE}}, /* Fixed-length (1 Int) */
-			  {{{ACPI_PTYPE1_VAR, ACPI_RTYPE_INTEGER, 1,0}, 0,0}},
-
-	{{"_S4_", 0, ACPI_RTYPE_PACKAGE}}, /* Fixed-length (1 Int) */
-			  {{{ACPI_PTYPE1_VAR, ACPI_RTYPE_INTEGER, 1,0}, 0,0}},
-
-	{{"_S5_", 0, ACPI_RTYPE_PACKAGE}}, /* Fixed-length (1 Int) */
-			  {{{ACPI_PTYPE1_VAR, ACPI_RTYPE_INTEGER, 1,0}, 0,0}},
-
-	{{"_S1D", 0, ACPI_RTYPE_INTEGER}},
-	{{"_S2D", 0, ACPI_RTYPE_INTEGER}},
-	{{"_S3D", 0, ACPI_RTYPE_INTEGER}},
-	{{"_S4D", 0, ACPI_RTYPE_INTEGER}},
-	{{"_S0W", 0, ACPI_RTYPE_INTEGER}},
-	{{"_S1W", 0, ACPI_RTYPE_INTEGER}},
-	{{"_S2W", 0, ACPI_RTYPE_INTEGER}},
-	{{"_S3W", 0, ACPI_RTYPE_INTEGER}},
-	{{"_S4W", 0, ACPI_RTYPE_INTEGER}},
-	{{"_SBS", 0, ACPI_RTYPE_INTEGER}},
-	{{"_SCP", 0x13, 0}},               /* Acpi 1.0 allowed 1 arg. Acpi 3.0 expanded to 3 args. Allow both. */
-			   /* Note: the 3-arg definition may be removed for ACPI 4.0 */
-	{{"_SDD", 1, 0}},
-	{{"_SEG", 0, ACPI_RTYPE_INTEGER}},
-	{{"_SHL", 1, ACPI_RTYPE_INTEGER}},
-	{{"_SLI", 0, ACPI_RTYPE_BUFFER}},
-	{{"_SPD", 1, ACPI_RTYPE_INTEGER}},
-	{{"_SRS", 1, 0}},
-	{{"_SRT", 1, ACPI_RTYPE_INTEGER}},
-	{{"_SRV", 0, ACPI_RTYPE_INTEGER}}, /* See IPMI spec */
-	{{"_SST", 1, 0}},
-	{{"_STA", 0, ACPI_RTYPE_INTEGER}},
-	{{"_STM", 3, 0}},
-	{{"_STP", 2, ACPI_RTYPE_INTEGER}},
-	{{"_STR", 0, ACPI_RTYPE_BUFFER}},
-	{{"_STV", 2, ACPI_RTYPE_INTEGER}},
-	{{"_SUB", 0, ACPI_RTYPE_STRING}},
-	{{"_SUN", 0, ACPI_RTYPE_INTEGER}},
-	{{"_SWS", 0, ACPI_RTYPE_INTEGER}},
-	{{"_TC1", 0, ACPI_RTYPE_INTEGER}},
-	{{"_TC2", 0, ACPI_RTYPE_INTEGER}},
-	{{"_TDL", 0, ACPI_RTYPE_INTEGER}},
-	{{"_TIP", 1, ACPI_RTYPE_INTEGER}},
-	{{"_TIV", 1, ACPI_RTYPE_INTEGER}},
-	{{"_TMP", 0, ACPI_RTYPE_INTEGER}},
-	{{"_TPC", 0, ACPI_RTYPE_INTEGER}},
-	{{"_TPT", 1, 0}},
-	{{"_TRT", 0, ACPI_RTYPE_PACKAGE}}, /* Variable-length (Pkgs) each 2 Ref/6 Int */
-			  {{{ACPI_PTYPE2, ACPI_RTYPE_REFERENCE, 2, ACPI_RTYPE_INTEGER}, 6, 0}},
-
-	{{"_TSD", 0, ACPI_RTYPE_PACKAGE}}, /* Variable-length (Pkgs) each 5 Int with count */
-			  {{{ACPI_PTYPE2_COUNT,ACPI_RTYPE_INTEGER, 5,0}, 0,0}},
-
-	{{"_TSP", 0, ACPI_RTYPE_INTEGER}},
-	{{"_TSS", 0, ACPI_RTYPE_PACKAGE}}, /* Variable-length (Pkgs) each 5 Int */
-			  {{{ACPI_PTYPE2, ACPI_RTYPE_INTEGER, 5,0}, 0,0}},
-
-	{{"_TST", 0, ACPI_RTYPE_INTEGER}},
-	{{"_TTS", 1, 0}},
-	{{"_TZD", 0, ACPI_RTYPE_PACKAGE}}, /* Variable-length (Refs) */
-			  {{{ACPI_PTYPE1_VAR, ACPI_RTYPE_REFERENCE, 0,0}, 0,0}},
-
-	{{"_TZM", 0, ACPI_RTYPE_REFERENCE}},
-	{{"_TZP", 0, ACPI_RTYPE_INTEGER}},
-	{{"_UID", 0, ACPI_RTYPE_INTEGER | ACPI_RTYPE_STRING}},
-	{{"_UPC", 0, ACPI_RTYPE_PACKAGE}}, /* Fixed-length (4 Int) */
-			  {{{ACPI_PTYPE1_FIXED, ACPI_RTYPE_INTEGER, 4,0}, 0,0}},
-
-	{{"_UPD", 0, ACPI_RTYPE_INTEGER}},
-	{{"_UPP", 0, ACPI_RTYPE_INTEGER}},
-	{{"_VPO", 0, ACPI_RTYPE_INTEGER}},
+	{{"_S0_", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Fixed-length (1 Int) */
+	PACKAGE_INFO(ACPI_PTYPE1_VAR, ACPI_RTYPE_INTEGER, 1, 0, 0, 0),
+
+	{{"_S1_", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Fixed-length (1 Int) */
+	PACKAGE_INFO(ACPI_PTYPE1_VAR, ACPI_RTYPE_INTEGER, 1, 0, 0, 0),
+
+	{{"_S2_", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Fixed-length (1 Int) */
+	PACKAGE_INFO(ACPI_PTYPE1_VAR, ACPI_RTYPE_INTEGER, 1, 0, 0, 0),
+
+	{{"_S3_", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Fixed-length (1 Int) */
+	PACKAGE_INFO(ACPI_PTYPE1_VAR, ACPI_RTYPE_INTEGER, 1, 0, 0, 0),
+
+	{{"_S4_", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Fixed-length (1 Int) */
+	PACKAGE_INFO(ACPI_PTYPE1_VAR, ACPI_RTYPE_INTEGER, 1, 0, 0, 0),
+
+	{{"_S5_", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Fixed-length (1 Int) */
+	PACKAGE_INFO(ACPI_PTYPE1_VAR, ACPI_RTYPE_INTEGER, 1, 0, 0, 0),
+
+	{{"_S1D", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_S2D", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_S3D", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_S4D", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_S0W", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_S1W", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_S2W", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_S3W", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_S4W", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_SBS", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_SCP", METHOD_1ARGS(ACPI_TYPE_INTEGER) | ARG_COUNT_IS_MINIMUM,
+	  METHOD_NO_RETURN_VALUE}},	/* Acpi 1.0 allowed 1 integer arg. Acpi 3.0 expanded to 3 args. Allow both. */
+
+	{{"_SDD", METHOD_1ARGS(ACPI_TYPE_BUFFER),
+	  METHOD_NO_RETURN_VALUE}},
+
+	{{"_SEG", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_SHL", METHOD_1ARGS(ACPI_TYPE_INTEGER),
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_SLI", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_BUFFER)}},
+
+	{{"_SPD", METHOD_1ARGS(ACPI_TYPE_INTEGER),
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_SRS", METHOD_1ARGS(ACPI_TYPE_BUFFER),
+	  METHOD_NO_RETURN_VALUE}},
+
+	{{"_SRT", METHOD_1ARGS(ACPI_TYPE_BUFFER),
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_SRV", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},	/* See IPMI spec */
+
+	{{"_SST", METHOD_1ARGS(ACPI_TYPE_INTEGER),
+	  METHOD_NO_RETURN_VALUE}},
+
+	{{"_STA", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_STM",
+	  METHOD_3ARGS(ACPI_TYPE_BUFFER, ACPI_TYPE_BUFFER, ACPI_TYPE_BUFFER),
+	  METHOD_NO_RETURN_VALUE}},
+
+	{{"_STP", METHOD_2ARGS(ACPI_TYPE_INTEGER, ACPI_TYPE_INTEGER),
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_STR", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_BUFFER)}},
+
+	{{"_STV", METHOD_2ARGS(ACPI_TYPE_INTEGER, ACPI_TYPE_INTEGER),
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_SUB", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_STRING)}},
+
+	{{"_SUN", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_SWS", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_TC1", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_TC2", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_TDL", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_TIP", METHOD_1ARGS(ACPI_TYPE_INTEGER),
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_TIV", METHOD_1ARGS(ACPI_TYPE_INTEGER),
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_TMP", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_TPC", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_TPT", METHOD_1ARGS(ACPI_TYPE_INTEGER),
+	  METHOD_NO_RETURN_VALUE}},
+
+	{{"_TRT", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Variable-length (Pkgs) each 2 Ref/6 Int */
+	PACKAGE_INFO(ACPI_PTYPE2, ACPI_RTYPE_REFERENCE, 2, ACPI_RTYPE_INTEGER,
+		     6, 0),
+
+	{{"_TSD", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Variable-length (Pkgs) each 5 Int with count */
+	PACKAGE_INFO(ACPI_PTYPE2_COUNT, ACPI_RTYPE_INTEGER, 5, 0, 0, 0),
+
+	{{"_TSP", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_TSS", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Variable-length (Pkgs) each 5 Int */
+	PACKAGE_INFO(ACPI_PTYPE2, ACPI_RTYPE_INTEGER, 5, 0, 0, 0),
+
+	{{"_TST", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_TTS", METHOD_1ARGS(ACPI_TYPE_INTEGER),
+	  METHOD_NO_RETURN_VALUE}},
+
+	{{"_TZD", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Variable-length (Refs) */
+	PACKAGE_INFO(ACPI_PTYPE1_VAR, ACPI_RTYPE_REFERENCE, 0, 0, 0, 0),
+
+	{{"_TZM", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_REFERENCE)}},
+
+	{{"_TZP", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_UID", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER | ACPI_RTYPE_STRING)}},
+
+	{{"_UPC", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_PACKAGE)}},	/* Fixed-length (4 Int) */
+	PACKAGE_INFO(ACPI_PTYPE1_FIXED, ACPI_RTYPE_INTEGER, 4, 0, 0, 0),
+
+	{{"_UPD", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_UPP", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
+
+	{{"_VPO", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER)}},
 
 	/* Acpi 1.0 defined _WAK with no return value. Later, it was changed to return a package */
 
-	{{"_WAK", 1,
-          ACPI_RTYPE_NONE | ACPI_RTYPE_INTEGER | ACPI_RTYPE_PACKAGE}},
-			  {{{ACPI_PTYPE1_FIXED, ACPI_RTYPE_INTEGER, 2,0}, 0,0}}, /* Fixed-length (2 Int), but is optional */
+	{{"_WAK", METHOD_1ARGS(ACPI_TYPE_INTEGER),
+	  METHOD_RETURNS(ACPI_RTYPE_NONE | ACPI_RTYPE_INTEGER |
+			 ACPI_RTYPE_PACKAGE)}},
+	PACKAGE_INFO(ACPI_PTYPE1_FIXED, ACPI_RTYPE_INTEGER, 2, 0, 0, 0),	/* Fixed-length (2 Int), but is optional */
 
 	/* _WDG/_WED are MS extensions defined by "Windows Instrumentation" */
 
-	{{"_WDG", 0, ACPI_RTYPE_BUFFER}},
-	{{"_WED", 1,
-	  ACPI_RTYPE_INTEGER | ACPI_RTYPE_STRING | ACPI_RTYPE_BUFFER}},
+	{{"_WDG", METHOD_0ARGS,
+	  METHOD_RETURNS(ACPI_RTYPE_BUFFER)}},
+
+	{{"_WED", METHOD_1ARGS(ACPI_TYPE_INTEGER),
+	  METHOD_RETURNS(ACPI_RTYPE_INTEGER | ACPI_RTYPE_STRING |
+			 ACPI_RTYPE_BUFFER)}},
 
-	{{{0, 0, 0, 0}, 0, 0}}  /* Table terminator */
+	PACKAGE_INFO(0, 0, 0, 0, 0, 0)	/* Table terminator */
 };
+#else
+extern const union acpi_predefined_info acpi_gbl_predefined_methods[];
+#endif
 
-#if 0
+#if (defined ACPI_CREATE_RESOURCE_TABLE && defined ACPI_APPLICATION)
+/******************************************************************************
+ *
+ * Predefined names for use in Resource Descriptors. These names do not
+ * appear in the global Predefined Name table (since these names never
+ * appear in actual AML byte code, only in the original ASL)
+ *
+ * Note: Used by iASL compiler and acpi_help utility only.
+ *
+ *****************************************************************************/
 
-	/* This is an internally implemented control method, no need to check */
-{ {
-"_OSI", 1, ACPI_RTYPE_INTEGER}},
+const union acpi_predefined_info acpi_gbl_resource_names[] = {
+	{{"_ADR", WIDTH_16 | WIDTH_64, 0}},
+	{{"_ALN", WIDTH_8 | WIDTH_16 | WIDTH_32, 0}},
+	{{"_ASI", WIDTH_8, 0}},
+	{{"_ASZ", WIDTH_8, 0}},
+	{{"_ATT", WIDTH_64, 0}},
+	{{"_BAS", WIDTH_16 | WIDTH_32, 0}},
+	{{"_BM_", WIDTH_1, 0}},
+	{{"_DBT", WIDTH_16, 0}},	/* Acpi 5.0 */
+	{{"_DEC", WIDTH_1, 0}},
+	{{"_DMA", WIDTH_8, 0}},
+	{{"_DPL", WIDTH_1, 0}},	/* Acpi 5.0 */
+	{{"_DRS", WIDTH_16, 0}},	/* Acpi 5.0 */
+	{{"_END", WIDTH_1, 0}},	/* Acpi 5.0 */
+	{{"_FLC", WIDTH_2, 0}},	/* Acpi 5.0 */
+	{{"_GRA", WIDTH_ADDRESS, 0}},
+	{{"_HE_", WIDTH_1, 0}},
+	{{"_INT", WIDTH_16 | WIDTH_32, 0}},
+	{{"_IOR", WIDTH_2, 0}},	/* Acpi 5.0 */
+	{{"_LEN", WIDTH_8 | WIDTH_ADDRESS, 0}},
+	{{"_LIN", WIDTH_8, 0}},	/* Acpi 5.0 */
+	{{"_LL_", WIDTH_1, 0}},
+	{{"_MAF", WIDTH_1, 0}},
+	{{"_MAX", WIDTH_ADDRESS, 0}},
+	{{"_MEM", WIDTH_2, 0}},
+	{{"_MIF", WIDTH_1, 0}},
+	{{"_MIN", WIDTH_ADDRESS, 0}},
+	{{"_MOD", WIDTH_1, 0}},	/* Acpi 5.0 */
+	{{"_MTP", WIDTH_2, 0}},
+	{{"_PAR", WIDTH_8, 0}},	/* Acpi 5.0 */
+	{{"_PHA", WIDTH_1, 0}},	/* Acpi 5.0 */
+	{{"_PIN", WIDTH_16, 0}},	/* Acpi 5.0 */
+	{{"_PPI", WIDTH_8, 0}},	/* Acpi 5.0 */
+	{{"_POL", WIDTH_1 | WIDTH_2, 0}},	/* Acpi 5.0 */
+	{{"_RBO", WIDTH_8, 0}},
+	{{"_RBW", WIDTH_8, 0}},
+	{{"_RNG", WIDTH_1, 0}},
+	{{"_RT_", WIDTH_8, 0}},	/* Acpi 3.0 */
+	{{"_RW_", WIDTH_1, 0}},
+	{{"_RXL", WIDTH_16, 0}},	/* Acpi 5.0 */
+	{{"_SHR", WIDTH_2, 0}},
+	{{"_SIZ", WIDTH_2, 0}},
+	{{"_SLV", WIDTH_1, 0}},	/* Acpi 5.0 */
+	{{"_SPE", WIDTH_32, 0}},	/* Acpi 5.0 */
+	{{"_STB", WIDTH_2, 0}},	/* Acpi 5.0 */
+	{{"_TRA", WIDTH_ADDRESS, 0}},
+	{{"_TRS", WIDTH_1, 0}},
+	{{"_TSF", WIDTH_8, 0}},	/* Acpi 3.0 */
+	{{"_TTP", WIDTH_1, 0}},
+	{{"_TXL", WIDTH_16, 0}},	/* Acpi 5.0 */
+	{{"_TYP", WIDTH_2 | WIDTH_16, 0}},
+	{{"_VEN", VARIABLE_DATA, 0}},	/* Acpi 5.0 */
+	PACKAGE_INFO(0, 0, 0, 0, 0, 0)	/* Table terminator */
+};
 
-	/* TBD: */
-	_PRT - currently ignore reversed entries. attempt to fix here?
-	think about possibly fixing package elements like _BIF, etc.
+static const union acpi_predefined_info acpi_gbl_scope_names[] = {
+	{{"_GPE", 0, 0}},
+	{{"_PR_", 0, 0}},
+	{{"_SB_", 0, 0}},
+	{{"_SI_", 0, 0}},
+	{{"_TZ_", 0, 0}},
+	PACKAGE_INFO(0, 0, 0, 0, 0, 0)	/* Table terminator */
+};
+#else
+extern const union acpi_predefined_info acpi_gbl_resource_names[];
 #endif
 
 #endif
-#endif
diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index c01f1a1..8c25bb0 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -432,6 +432,26 @@ struct acpi_interface_info *acpi_ut_get_interface(acpi_string interface_name);
 acpi_status acpi_ut_osi_implementation(struct acpi_walk_state *walk_state);
 
 /*
+ * utpredef - support for predefined names
+ */
+const union acpi_predefined_info *acpi_ut_get_next_predefined_method(const union
+								     acpi_predefined_info
+								     *this_name);
+
+const union acpi_predefined_info *acpi_ut_match_predefined_method(char *name);
+
+const union acpi_predefined_info *acpi_ut_match_resource_name(char *name);
+
+void
+acpi_ut_display_predefined_method(char *buffer,
+				  const union acpi_predefined_info *this_name,
+				  u8 multi_line);
+
+void acpi_ut_get_expected_return_types(char *buffer, u32 expected_btypes);
+
+u32 acpi_ut_get_resource_bit_width(char *buffer, u16 types);
+
+/*
  * utstate - Generic state creation/cache routines
  */
 void
diff --git a/drivers/acpi/acpica/nseval.c b/drivers/acpi/acpica/nseval.c
index 1538f3e..b61db69 100644
--- a/drivers/acpi/acpica/nseval.c
+++ b/drivers/acpi/acpica/nseval.c
@@ -98,17 +98,21 @@ acpi_status acpi_ns_evaluate(struct acpi_evaluate_info * info)
 	info->return_object = NULL;
 	info->param_count = 0;
 
-	/*
-	 * Get the actual namespace node for the target object. Handles these cases:
-	 *
-	 * 1) Null node, Pathname (absolute path)
-	 * 2) Node, Pathname (path relative to Node)
-	 * 3) Node, Null Pathname
-	 */
-	status = acpi_ns_get_node(info->prefix_node, info->pathname,
-				  ACPI_NS_NO_UPSEARCH, &info->resolved_node);
-	if (ACPI_FAILURE(status)) {
-		return_ACPI_STATUS(status);
+	if (!info->resolved_node) {
+		/*
+		 * Get the actual namespace node for the target object if we need to.
+		 * Handles these cases:
+		 *
+		 * 1) Null node, Pathname (absolute path)
+		 * 2) Node, Pathname (path relative to Node)
+		 * 3) Node, Null Pathname
+		 */
+		status = acpi_ns_get_node(info->prefix_node, info->pathname,
+					  ACPI_NS_NO_UPSEARCH,
+					  &info->resolved_node);
+		if (ACPI_FAILURE(status)) {
+			return_ACPI_STATUS(status);
+		}
 	}
 
 	/*
diff --git a/drivers/acpi/acpica/nspredef.c b/drivers/acpi/acpica/nspredef.c
index 36f7240..8a52916 100644
--- a/drivers/acpi/acpica/nspredef.c
+++ b/drivers/acpi/acpica/nspredef.c
@@ -76,22 +76,8 @@ static acpi_status
 acpi_ns_check_reference(struct acpi_predefined_data *data,
 			union acpi_operand_object *return_object);
 
-static void acpi_ns_get_expected_types(char *buffer, u32 expected_btypes);
-
 static u32 acpi_ns_get_bitmapped_type(union acpi_operand_object *return_object);
 
-/*
- * Names for the types that can be returned by the predefined objects.
- * Used for warning messages. Must be in the same order as the ACPI_RTYPEs
- */
-static const char *acpi_rtype_names[] = {
-	"/Integer",
-	"/String",
-	"/Buffer",
-	"/Package",
-	"/Reference",
-};
-
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ns_check_predefined_names
@@ -121,7 +107,7 @@ acpi_ns_check_predefined_names(struct acpi_namespace_node *node,
 
 	/* Match the name for this method/object against the predefined list */
 
-	predefined = acpi_ns_check_for_predefined_name(node);
+	predefined = acpi_ut_match_predefined_method(node->name.ascii);
 
 	/* Get the full pathname to the object, for use in warning messages */
 
@@ -292,8 +278,10 @@ acpi_ns_check_parameter_count(char *pathname,
 	 * Validate the user-supplied parameter count.
 	 * Allow two different legal argument counts (_SCP, etc.)
 	 */
-	required_params_current = predefined->info.param_count & 0x0F;
-	required_params_old = predefined->info.param_count >> 4;
+	required_params_current =
+	    predefined->info.argument_list & METHOD_ARG_MASK;
+	required_params_old =
+	    predefined->info.argument_list >> METHOD_ARG_BIT_WIDTH;
 
 	if (user_param_count != ACPI_UINT32_MAX) {
 		if ((user_param_count != required_params_current) &&
@@ -322,52 +310,6 @@ acpi_ns_check_parameter_count(char *pathname,
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_ns_check_for_predefined_name
- *
- * PARAMETERS:  node            - Namespace node for the method/object
- *
- * RETURN:      Pointer to entry in predefined table. NULL indicates not found.
- *
- * DESCRIPTION: Check an object name against the predefined object list.
- *
- ******************************************************************************/
-
-const union acpi_predefined_info *acpi_ns_check_for_predefined_name(struct
-								    acpi_namespace_node
-								    *node)
-{
-	const union acpi_predefined_info *this_name;
-
-	/* Quick check for a predefined name, first character must be underscore */
-
-	if (node->name.ascii[0] != '_') {
-		return (NULL);
-	}
-
-	/* Search info table for a predefined method/object name */
-
-	this_name = predefined_names;
-	while (this_name->info.name[0]) {
-		if (ACPI_COMPARE_NAME(node->name.ascii, this_name->info.name)) {
-			return (this_name);
-		}
-
-		/*
-		 * Skip next entry in the table if this name returns a Package
-		 * (next entry contains the package info)
-		 */
-		if (this_name->info.expected_btypes & ACPI_RTYPE_PACKAGE) {
-			this_name++;
-		}
-
-		this_name++;
-	}
-
-	return (NULL);		/* Not found */
-}
-
-/*******************************************************************************
- *
  * FUNCTION:    acpi_ns_check_object_type
  *
  * PARAMETERS:  data            - Pointer to validation data structure
@@ -438,7 +380,7 @@ acpi_ns_check_object_type(struct acpi_predefined_data *data,
 
 	/* Create a string with all expected types for this predefined object */
 
-	acpi_ns_get_expected_types(type_buffer, expected_btypes);
+	acpi_ut_get_expected_return_types(type_buffer, expected_btypes);
 
 	if (package_index == ACPI_NOT_PACKAGE_ELEMENT) {
 		ACPI_WARN_PREDEFINED((AE_INFO, data->pathname, data->node_flags,
@@ -548,39 +490,3 @@ static u32 acpi_ns_get_bitmapped_type(union acpi_operand_object *return_object)
 
 	return (return_btype);
 }
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_ns_get_expected_types
- *
- * PARAMETERS:  buffer          - Pointer to where the string is returned
- *              expected_btypes - Bitmap of expected return type(s)
- *
- * RETURN:      Buffer is populated with type names.
- *
- * DESCRIPTION: Translate the expected types bitmap into a string of ascii
- *              names of expected types, for use in warning messages.
- *
- ******************************************************************************/
-
-static void acpi_ns_get_expected_types(char *buffer, u32 expected_btypes)
-{
-	u32 this_rtype;
-	u32 i;
-	u32 j;
-
-	j = 1;
-	buffer[0] = 0;
-	this_rtype = ACPI_RTYPE_INTEGER;
-
-	for (i = 0; i < ACPI_NUM_RTYPES; i++) {
-
-		/* If one of the expected types, concatenate the name of this type */
-
-		if (expected_btypes & this_rtype) {
-			ACPI_STRCAT(buffer, &acpi_rtype_names[i][j]);
-			j = 0;	/* Use name separator from now on */
-		}
-		this_rtype <<= 1;	/* Next Rtype */
-	}
-}
diff --git a/drivers/acpi/acpica/utpredef.c b/drivers/acpi/acpica/utpredef.c
new file mode 100644
index 0000000..2945947
--- /dev/null
+++ b/drivers/acpi/acpica/utpredef.c
@@ -0,0 +1,399 @@
+/******************************************************************************
+ *
+ * Module Name: utpredef - support functions for predefined names
+ *
+ *****************************************************************************/
+
+/*
+ * Copyright (C) 2000 - 2013, Intel Corp.
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions, and the following disclaimer,
+ *    without modification.
+ * 2. Redistributions in binary form must reproduce at minimum a disclaimer
+ *    substantially similar to the "NO WARRANTY" disclaimer below
+ *    ("Disclaimer") and any redistribution must be conditioned upon
+ *    including a substantially similar Disclaimer requirement for further
+ *    binary redistribution.
+ * 3. Neither the names of the above-listed copyright holders nor the names
+ *    of any contributors may be used to endorse or promote products derived
+ *    from this software without specific prior written permission.
+ *
+ * Alternatively, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") version 2 as published by the Free
+ * Software Foundation.
+ *
+ * NO WARRANTY
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR
+ * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ * HOLDERS OR CONTRIBUTORS BE LIABLE FOR SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
+ * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+ * POSSIBILITY OF SUCH DAMAGES.
+ */
+
+#include <acpi/acpi.h>
+#include "accommon.h"
+#include "acpredef.h"
+
+#define _COMPONENT          ACPI_UTILITIES
+ACPI_MODULE_NAME("utpredef")
+
+/*
+ * Names for the types that can be returned by the predefined objects.
+ * Used for warning messages. Must be in the same order as the ACPI_RTYPEs
+ */
+static const char *ut_rtype_names[] = {
+	"/Integer",
+	"/String",
+	"/Buffer",
+	"/Package",
+	"/Reference",
+};
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_get_next_predefined_method
+ *
+ * PARAMETERS:  this_name           - Entry in the predefined method/name table
+ *
+ * RETURN:      Pointer to next entry in predefined table.
+ *
+ * DESCRIPTION: Get the next entry in the predefine method table. Handles the
+ *              cases where a package info entry follows a method name that
+ *              returns a package.
+ *
+ ******************************************************************************/
+
+const union acpi_predefined_info *acpi_ut_get_next_predefined_method(const union
+								     acpi_predefined_info
+								     *this_name)
+{
+
+	/*
+	 * Skip next entry in the table if this name returns a Package
+	 * (next entry contains the package info)
+	 */
+	if ((this_name->info.expected_btypes & ACPI_RTYPE_PACKAGE) &&
+	    (this_name->info.expected_btypes != ACPI_RTYPE_ALL)) {
+		this_name++;
+	}
+
+	this_name++;
+	return (this_name);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_match_predefined_method
+ *
+ * PARAMETERS:  name                - Name to find
+ *
+ * RETURN:      Pointer to entry in predefined table. NULL indicates not found.
+ *
+ * DESCRIPTION: Check an object name against the predefined object list.
+ *
+ ******************************************************************************/
+
+const union acpi_predefined_info *acpi_ut_match_predefined_method(char *name)
+{
+	const union acpi_predefined_info *this_name;
+
+	/* Quick check for a predefined name, first character must be underscore */
+
+	if (name[0] != '_') {
+		return (NULL);
+	}
+
+	/* Search info table for a predefined method/object name */
+
+	this_name = acpi_gbl_predefined_methods;
+	while (this_name->info.name[0]) {
+		if (ACPI_COMPARE_NAME(name, this_name->info.name)) {
+			return (this_name);
+		}
+
+		this_name = acpi_ut_get_next_predefined_method(this_name);
+	}
+
+	return (NULL);		/* Not found */
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_get_expected_return_types
+ *
+ * PARAMETERS:  buffer              - Where the formatted string is returned
+ *              expected_Btypes     - Bitfield of expected data types
+ *
+ * RETURN:      Formatted string in Buffer.
+ *
+ * DESCRIPTION: Format the expected object types into a printable string.
+ *
+ ******************************************************************************/
+
+void acpi_ut_get_expected_return_types(char *buffer, u32 expected_btypes)
+{
+	u32 this_rtype;
+	u32 i;
+	u32 j;
+
+	j = 1;
+	buffer[0] = 0;
+	this_rtype = ACPI_RTYPE_INTEGER;
+
+	for (i = 0; i < ACPI_NUM_RTYPES; i++) {
+
+		/* If one of the expected types, concatenate the name of this type */
+
+		if (expected_btypes & this_rtype) {
+			ACPI_STRCAT(buffer, &ut_rtype_names[i][j]);
+			j = 0;	/* Use name separator from now on */
+		}
+
+		this_rtype <<= 1;	/* Next Rtype */
+	}
+}
+
+/*******************************************************************************
+ *
+ * The remaining functions are used by iASL and acpi_help only
+ *
+ ******************************************************************************/
+
+#if (defined ACPI_ASL_COMPILER || defined ACPI_HELP_APP)
+#include <stdio.h>
+#include <string.h>
+
+/* Local prototypes */
+
+static u32 acpi_ut_get_argument_types(char *buffer, u16 argument_types);
+
+/* Types that can be returned externally by a predefined name */
+
+static const char *ut_external_type_names[] =	/* Indexed by ACPI_TYPE_* */
+{
+	", UNSUPPORTED-TYPE",
+	", Integer",
+	", String",
+	", Buffer",
+	", Package"
+};
+
+/* Bit widths for resource descriptor predefined names */
+
+static const char *ut_resource_type_names[] = {
+	"/1",
+	"/2",
+	"/3",
+	"/8",
+	"/16",
+	"/32",
+	"/64",
+	"/variable",
+};
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_match_resource_name
+ *
+ * PARAMETERS:  name                - Name to find
+ *
+ * RETURN:      Pointer to entry in the resource table. NULL indicates not
+ *              found.
+ *
+ * DESCRIPTION: Check an object name against the predefined resource
+ *              descriptor object list.
+ *
+ ******************************************************************************/
+
+const union acpi_predefined_info *acpi_ut_match_resource_name(char *name)
+{
+	const union acpi_predefined_info *this_name;
+
+	/* Quick check for a predefined name, first character must be underscore */
+
+	if (name[0] != '_') {
+		return (NULL);
+	}
+
+	/* Search info table for a predefined method/object name */
+
+	this_name = acpi_gbl_resource_names;
+	while (this_name->info.name[0]) {
+		if (ACPI_COMPARE_NAME(name, this_name->info.name)) {
+			return (this_name);
+		}
+
+		this_name++;
+	}
+
+	return (NULL);		/* Not found */
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_display_predefined_method
+ *
+ * PARAMETERS:  buffer              - Scratch buffer for this function
+ *              this_name           - Entry in the predefined method/name table
+ *              multi_line          - TRUE if output should be on >1 line
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Display information about a predefined method. Number and
+ *              type of the input arguments, and expected type(s) for the
+ *              return value, if any.
+ *
+ ******************************************************************************/
+
+void
+acpi_ut_display_predefined_method(char *buffer,
+				  const union acpi_predefined_info *this_name,
+				  u8 multi_line)
+{
+	u32 arg_count;
+
+	/*
+	 * Get the argument count and the string buffer
+	 * containing all argument types
+	 */
+	arg_count = acpi_ut_get_argument_types(buffer,
+					       this_name->info.argument_list);
+
+	if (multi_line) {
+		printf("      ");
+	}
+
+	printf("%4.4s    Requires %s%u argument%s",
+	       this_name->info.name,
+	       (this_name->info.argument_list & ARG_COUNT_IS_MINIMUM) ?
+	       "(at least) " : "", arg_count, arg_count != 1 ? "s" : "");
+
+	/* Display the types for any arguments */
+
+	if (arg_count > 0) {
+		printf(" (%s)", buffer);
+	}
+
+	if (multi_line) {
+		printf("\n    ");
+	}
+
+	/* Get the return value type(s) allowed */
+
+	if (this_name->info.expected_btypes) {
+		acpi_ut_get_expected_return_types(buffer,
+						  this_name->info.
+						  expected_btypes);
+		printf("  Return value types: %s\n", buffer);
+	} else {
+		printf("  No return value\n");
+	}
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_get_argument_types
+ *
+ * PARAMETERS:  buffer              - Where to return the formatted types
+ *              argument_types      - Types field for this method
+ *
+ * RETURN:      count - the number of arguments required for this method
+ *
+ * DESCRIPTION: Format the required data types for this method (Integer,
+ *              String, Buffer, or Package) and return the required argument
+ *              count.
+ *
+ ******************************************************************************/
+
+static u32 acpi_ut_get_argument_types(char *buffer, u16 argument_types)
+{
+	u16 this_argument_type;
+	u16 sub_index;
+	u16 arg_count;
+	u32 i;
+
+	*buffer = 0;
+	sub_index = 2;
+
+	/* First field in the types list is the count of args to follow */
+
+	arg_count = (argument_types & METHOD_ARG_MASK);
+	argument_types >>= METHOD_ARG_BIT_WIDTH;
+
+	if (arg_count > METHOD_PREDEF_ARGS_MAX) {
+		printf("**** Invalid argument count (%u) "
+		       "in predefined info structure\n", arg_count);
+		return (arg_count);
+	}
+
+	/* Get each argument from the list, convert to ascii, store to buffer */
+
+	for (i = 0; i < arg_count; i++) {
+		this_argument_type = (argument_types & METHOD_ARG_MASK);
+		if (!this_argument_type
+		    || (this_argument_type > METHOD_MAX_ARG_TYPE)) {
+			printf("**** Invalid argument type (%u) "
+			       "in predefined info structure\n",
+			       this_argument_type);
+			return (arg_count);
+		}
+
+		strcat(buffer,
+		       ut_external_type_names[this_argument_type] + sub_index);
+
+		/* Shift to next argument type field */
+
+		argument_types >>= METHOD_ARG_BIT_WIDTH;
+		sub_index = 0;
+	}
+
+	return (arg_count);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_get_resource_bit_width
+ *
+ * PARAMETERS:  buffer              - Where the formatted string is returned
+ *              types               - Bitfield of expected data types
+ *
+ * RETURN:      Count of return types. Formatted string in Buffer.
+ *
+ * DESCRIPTION: Format the resource bit widths into a printable string.
+ *
+ ******************************************************************************/
+
+u32 acpi_ut_get_resource_bit_width(char *buffer, u16 types)
+{
+	u32 i;
+	u16 sub_index;
+	u32 found;
+
+	*buffer = 0;
+	sub_index = 1;
+	found = 0;
+
+	for (i = 0; i < NUM_RESOURCE_WIDTHS; i++) {
+		if (types & 1) {
+			strcat(buffer, &(ut_resource_type_names[i][sub_index]));
+			sub_index = 0;
+			found++;
+		}
+
+		types >>= 1;
+	}
+
+	return (found);
+}
+#endif
-- 
1.7.10

