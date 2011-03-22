From: Lin Ming <ming.m.lin@intel.com>
Subject: ACPICA release 20110316 linuxized patches
Date: Tue, 22 Mar 2011 13:40:47 +0800
Message-ID: <1300772447.31224.8.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-Abk/TebXrSV/8XNoa+nS"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:52754 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754112Ab1CVFlD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 22 Mar 2011 01:41:03 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>


--=-Abk/TebXrSV/8XNoa+nS
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi, Len

ACPICA release 20110316 linuxized patches attached.
This is a small release and below 2 patches from Rafael have been merged
into kernel, so I don't include them here.

ACPI / ACPICA: Avoid crashing if _PRW is defined for the root object
(2d55951)
ACPI / ACPICA: Fix global lock acquisition (9cd03144)

[PATCH 1/2] ACPICA: Header support for SLIC table
[PATCH 2/2] ACPICA: Update version to 20110316

Thanks,
Lin Ming

--=-Abk/TebXrSV/8XNoa+nS
Content-Disposition: attachment; filename="acpica-v20110316.patch"
Content-Type: text/x-patch; name="acpica-v20110316.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

>From ee698b664e05255c7d4305f76b47de9dc5992343 Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Fri, 18 Mar 2011 09:49:41 +0800
Subject: [PATCH 1/2] ACPICA: Header support for SLIC table

We finally have the definition for this table.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 include/acpi/actbl2.h |   64 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 63 insertions(+), 1 deletions(-)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 0fc15df..58bdd05 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -1,6 +1,6 @@
 /******************************************************************************
  *
- * Name: actbl2.h - ACPI Specification Revision 2.0 Tables
+ * Name: actbl2.h - ACPI Table Definitions (tables not in ACPI spec)
  *
  *****************************************************************************/
 
@@ -716,6 +716,68 @@ struct acpi_table_mchi {
 
 /*******************************************************************************
  *
+ * SLIC - Software Licensing Description Table
+ *        Version 1
+ *
+ * Conforms to "OEM Activation 2.0 for Windows Vista Operating Systems",
+ * Copyright 2006
+ *
+ ******************************************************************************/
+
+/* Basic SLIC table is only the common ACPI header */
+
+struct acpi_table_slic {
+	struct acpi_table_header header;	/* Common ACPI table header */
+};
+
+/* Common SLIC subtable header */
+
+struct acpi_slic_header {
+	u32 type;
+	u32 length;
+};
+
+/* Values for Type field above */
+
+enum acpi_slic_type {
+	ACPI_SLIC_TYPE_PUBLIC_KEY = 0,
+	ACPI_SLIC_TYPE_WINDOWS_MARKER = 1,
+	ACPI_SLIC_TYPE_RESERVED = 2	/* 2 and greater are reserved */
+};
+
+/*
+ * SLIC Sub-tables, correspond to Type in struct acpi_slic_header
+ */
+
+/* 0: Public Key Structure */
+
+struct acpi_slic_key {
+	struct acpi_slic_header header;
+	u8 key_type;
+	u8 version;
+	u16 reserved;
+	u32 algorithm;
+	char magic[4];
+	u32 bit_length;
+	u32 exponent;
+	u8 modulus[128];
+};
+
+/* 1: Windows Marker Structure */
+
+struct acpi_slic_marker {
+	struct acpi_slic_header header;
+	u32 version;
+	char oem_id[ACPI_OEM_ID_SIZE];	/* ASCII OEM identification */
+	char oem_table_id[ACPI_OEM_TABLE_ID_SIZE];	/* ASCII OEM table identification */
+	char windows_flag[8];
+	u32 slic_version;
+	u8 reserved[16];
+	u8 signature[128];
+};
+
+/*******************************************************************************
+ *
  * SPCR - Serial Port Console Redirection table
  *        Version 1
  *
-- 
1.7.3

>From ebfc844afec33c50c580e778a3743d77f8904409 Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Tue, 22 Mar 2011 11:27:29 +0800
Subject: [PATCH 2/2] ACPICA: Update version to 20110316

Version 20110316.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 include/acpi/acpixf.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index ec90854..f6ad63d 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -47,7 +47,7 @@
 
 /* Current ACPICA subsystem version in YYYYMMDD format */
 
-#define ACPI_CA_VERSION                 0x20110211
+#define ACPI_CA_VERSION                 0x20110316
 
 #include "actypes.h"
 #include "actbl.h"
-- 
1.7.3


--=-Abk/TebXrSV/8XNoa+nS--

