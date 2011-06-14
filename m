From: Lin Ming <ming.m.lin@intel.com>
Subject: ACPICA release 20110527 linuxized patches
Date: Tue, 14 Jun 2011 10:59:40 +0800
Message-ID: <1308020380.4011.17.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-kshKnQHFFt62P7TL0vl3"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:64776 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751959Ab1FNC5E (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 13 Jun 2011 22:57:04 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb <lenb@kernel.org>
Cc: "Moore, Robert" <robert.moore@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>


--=-kshKnQHFFt62P7TL0vl3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi, Len

The linuxized patches for ACPICA release 20110527 attached.

[PATCH 1/3] ACPICA: Load operator: re-instate most restrictions on incoming table signature
[PATCH 2/3] ACPICA: Add missing _TDL to list of predefined names
[PATCH 3/3] ACPICA: Update to version 20110527

Lin Ming


--=-kshKnQHFFt62P7TL0vl3
Content-Disposition: attachment; filename="acpica-v20110527.patch"
Content-Type: text/x-patch; name="acpica-v20110527.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

>From c8f1e6fd30c0c274a4c251f86ad30e4e509e4319 Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Tue, 14 Jun 2011 10:42:53 +0800
Subject: [PATCH 1/3] ACPICA: Load operator: re-instate most restrictions on incoming table signature

Now, only allow "SSDT" "OEM", and a null signature.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/tbinstal.c |   27 ++++++++++++++++++++++-----
 1 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/acpica/tbinstal.c b/drivers/acpi/acpica/tbinstal.c
index 48db094..62365f6 100644
--- a/drivers/acpi/acpica/tbinstal.c
+++ b/drivers/acpi/acpica/tbinstal.c
@@ -126,12 +126,29 @@ acpi_tb_add_table(struct acpi_table_desc *table_desc, u32 *table_index)
 	}
 
 	/*
-	 * Originally, we checked the table signature for "SSDT" or "PSDT" here.
-	 * Next, we added support for OEMx tables, signature "OEM".
-	 * Valid tables were encountered with a null signature, so we've just
-	 * given up on validating the signature, since it seems to be a waste
-	 * of code. The original code was removed (05/2008).
+	 * Validate the incoming table signature.
+	 *
+	 * 1) Originally, we checked the table signature for "SSDT" or "PSDT".
+	 * 2) We added support for OEMx tables, signature "OEM".
+	 * 3) Valid tables were encountered with a null signature, so we just
+	 *    gave up on validating the signature, (05/2008).
+	 * 4) We encountered non-AML tables such as the MADT, which caused
+	 *    interpreter errors and kernel faults. So now, we once again allow
+	 *    only "SSDT", "OEMx", and now, also a null signature. (05/2011).
 	 */
+	if ((table_desc->pointer->signature[0] != 0x00) &&
+	    (!ACPI_COMPARE_NAME(table_desc->pointer->signature, ACPI_SIG_SSDT))
+	    && (ACPI_STRNCMP(table_desc->pointer->signature, "OEM", 3))) {
+		ACPI_ERROR((AE_INFO,
+			    "Table has invalid signature [%4.4s] (0x%8.8X), must be SSDT or OEMx",
+			    acpi_ut_valid_acpi_name(*(u32 *)table_desc->
+						    pointer->
+						    signature) ? table_desc->
+			    pointer->signature : "????",
+			    *(u32 *)table_desc->pointer->signature));
+
+		return_ACPI_STATUS(AE_BAD_SIGNATURE);
+	}
 
 	(void)acpi_ut_acquire_mutex(ACPI_MTX_TABLES);
 

>From f683079b2774c7aeb3725a5c2e6aa7a52198cb81 Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Tue, 14 Jun 2011 10:44:51 +0800
Subject: [PATCH 2/3] ACPICA: Add missing _TDL to list of predefined names

Affects both iASL and core ACPICA.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/acpredef.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/acpica/acpredef.h b/drivers/acpi/acpica/acpredef.h
index 94e73c9..c445cca 100644
--- a/drivers/acpi/acpica/acpredef.h
+++ b/drivers/acpi/acpica/acpredef.h
@@ -468,6 +468,7 @@ static const union acpi_predefined_info predefined_names[] =
 	{{"_SWS", 0, ACPI_RTYPE_INTEGER}},
 	{{"_TC1", 0, ACPI_RTYPE_INTEGER}},
 	{{"_TC2", 0, ACPI_RTYPE_INTEGER}},
+	{{"_TDL", 0, ACPI_RTYPE_INTEGER}},
 	{{"_TIP", 1, ACPI_RTYPE_INTEGER}},
 	{{"_TIV", 1, ACPI_RTYPE_INTEGER}},
 	{{"_TMP", 0, ACPI_RTYPE_INTEGER}},

>From 0e91fd3fed4ed134f6f68695596b7b4d1d0f47e3 Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Tue, 14 Jun 2011 10:45:57 +0800
Subject: [PATCH 3/3] ACPICA: Update to version 20110527

Version 20110527.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 include/acpi/acpixf.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 2ed0a84..06853f7 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -47,7 +47,7 @@
 
 /* Current ACPICA subsystem version in YYYYMMDD format */
 
-#define ACPI_CA_VERSION                 0x20110413
+#define ACPI_CA_VERSION                 0x20110527
 
 #include "actypes.h"
 #include "actbl.h"


--=-kshKnQHFFt62P7TL0vl3--

