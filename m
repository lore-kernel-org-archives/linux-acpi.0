From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 31/42] ACPICA: Update for CondRefOf and RefOf operators
Date: Tue, 29 Dec 2015 14:01:46 +0800
Message-ID: <de10ae7631e0b329e9d814ea1c083c10cba54f93.1451367389.git.lv.zheng@intel.com>
References: <cover.1451367388.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:54781 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752543AbbL2GBv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 29 Dec 2015 01:01:51 -0500
In-Reply-To: <cover.1451367388.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 725c094f1a7a2ae28e623ee77be400af1c36b180

The SuperName parameters for these operators were incorrect. This
represents two problems in the ACPI specification itself.

Link: https://github.com/acpica/acpica/commit/725c094f
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acopcode.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/acopcode.h b/drivers/acpi/acpica/acopcode.h
index c6b2f42..324512d 100644
--- a/drivers/acpi/acpica/acopcode.h
+++ b/drivers/acpi/acpica/acopcode.h
@@ -92,7 +92,7 @@
 #define ARGP_BYTELIST_OP                ARGP_LIST1 (ARGP_NAMESTRING)
 #define ARGP_CONCAT_OP                  ARGP_LIST3 (ARGP_TERMARG,    ARGP_TERMARG,       ARGP_TARGET)
 #define ARGP_CONCAT_RES_OP              ARGP_LIST3 (ARGP_TERMARG,    ARGP_TERMARG,       ARGP_TARGET)
-#define ARGP_COND_REF_OF_OP             ARGP_LIST2 (ARGP_SUPERNAME,  ARGP_SUPERNAME)
+#define ARGP_COND_REF_OF_OP             ARGP_LIST2 (ARGP_NAME_OR_REF,ARGP_TARGET)
 #define ARGP_CONNECTFIELD_OP            ARGP_LIST1 (ARGP_NAMESTRING)
 #define ARGP_CONTINUE_OP                ARG_NONE
 #define ARGP_COPY_OP                    ARGP_LIST2 (ARGP_TERMARG,    ARGP_SIMPLENAME)
@@ -159,7 +159,7 @@
 #define ARGP_POWER_RES_OP               ARGP_LIST5 (ARGP_PKGLENGTH,  ARGP_NAME,          ARGP_BYTEDATA,  ARGP_WORDDATA,  ARGP_OBJLIST)
 #define ARGP_PROCESSOR_OP               ARGP_LIST6 (ARGP_PKGLENGTH,  ARGP_NAME,          ARGP_BYTEDATA,  ARGP_DWORDDATA, ARGP_BYTEDATA,  ARGP_OBJLIST)
 #define ARGP_QWORD_OP                   ARGP_LIST1 (ARGP_QWORDDATA)
-#define ARGP_REF_OF_OP                  ARGP_LIST1 (ARGP_SUPERNAME)
+#define ARGP_REF_OF_OP                  ARGP_LIST1 (ARGP_NAME_OR_REF)
 #define ARGP_REGION_OP                  ARGP_LIST4 (ARGP_NAME,       ARGP_BYTEDATA,      ARGP_TERMARG,   ARGP_TERMARG)
 #define ARGP_RELEASE_OP                 ARGP_LIST1 (ARGP_SUPERNAME)
 #define ARGP_RESERVEDFIELD_OP           ARGP_LIST1 (ARGP_NAMESTRING)
-- 
1.7.10

