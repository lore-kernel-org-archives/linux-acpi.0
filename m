From: Len Brown <lenb@kernel.org>
Subject: [PATCH 39/42] ACPICA: Header support for SLIC table
Date: Wed, 23 Mar 2011 02:42:52 -0400
Message-ID: <5cf4d7338ba23aa8d9eeaf313f16bb50494be369.1300862481.git.len.brown@intel.com>
References: <1300862575-10206-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:33781 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753345Ab1CWIHj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Mar 2011 04:07:39 -0400
Received: from localhost.localdomain ([unknown] [74.104.148.74])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LII00IQB3WFAQB4@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 23 Mar 2011 03:07:33 -0500 (CDT)
In-reply-to: <1300862575-10206-1-git-send-email-lenb@kernel.org>
In-reply-to: <073b4964b3b75fd9e19bf3933b26d9c23591c9db.1300862481.git.len.brown@intel.com>
References: <073b4964b3b75fd9e19bf3933b26d9c23591c9db.1300862481.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

We finally have the definition for this table.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
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
1.7.4.1.343.ga91df

