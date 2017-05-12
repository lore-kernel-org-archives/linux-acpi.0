From: "Luck, Tony" <tony.luck@intel.com>
Subject: [PATCH v2 2/2] ACPI / APEI: No remaining users of struct acpi_bert_region
Date: Fri, 12 May 2017 14:42:12 -0700
Message-ID: <e5482112927d6b31aba43b88f1faba6c9fd96ab3.1494624795.git.tony.luck@intel.com>
References: <20170512120118.zwhgtcbf4u4zshbn@pd.tnic>
 <cover.1494624795.git.tony.luck@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:65355 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758767AbdELVnU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 12 May 2017 17:43:20 -0400
In-Reply-To: <cover.1494624795.git.tony.luck@intel.com>
In-Reply-To: <cover.1494624795.git.tony.luck@intel.com>
References: <cover.1494624795.git.tony.luck@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Tony Luck <tony.luck@intel.com>, Len Brown <lenb@kernel.org>, Huang Ying <ying.huang@intel.com>, Borislav Petkov <bp@suse.de>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Jonathan Zhang <zjzhang@codeaurora.org>, Tyler Baicar <tbaicar@codeaurora.org>, linux-acpi@vger.kernel.org

From: Tony Luck <tony.luck@intel.com>

Version 6.1 of the ACPI specification. Section 18.3.1 "Boot Error
Source" clarified that the format of the Boot Error Region is a "Generic
Error Status Block". So we don't need separate (but identical) "struct
acpi_bert_region" and "struct acpi_hest_generic_status".

Code using acpi_bert_region has been changed to use acpi_hest_generic_status
instead. So we can delete the definition now.

Cc: Len Brown <lenb@kernel.org>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Cc: Jonathan (Zhixiong) Zhang <zjzhang@codeaurora.org>
Cc: Tyler Baicar <tbaicar@codeaurora.org>
Cc: linux-acpi@vger.kernel.org
Reviewed-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 include/acpi/actbl1.h | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index b4ce55c008b0..b44663a87bd1 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -126,17 +126,11 @@ struct acpi_whea_header {
 struct acpi_table_bert {
 	struct acpi_table_header header;	/* Common ACPI table header */
 	u32 region_length;	/* Length of the boot error region */
-	u64 address;		/* Physical address of the error region */
-};
-
-/* Boot Error Region (not a subtable, pointed to by Address field above) */
-
-struct acpi_bert_region {
-	u32 block_status;	/* Type of error information */
-	u32 raw_data_offset;	/* Offset to raw error data */
-	u32 raw_data_length;	/* Length of raw error data */
-	u32 data_length;	/* Length of generic error data */
-	u32 error_severity;	/* Severity code */
+	u64 address;		/*
+				 * Physical address of the error region
+				 * which is a Generic Error Status Block
+				 * (struct acpi_hest_generic_status)
+				 */
 };
 
 /* Values for block_status flags above */
-- 
2.11.0

