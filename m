From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH] acpi: update struct acpi_table_tpm2
Date: Mon,  8 Jun 2015 16:38:26 +0300
Message-ID: <1433770706-3332-1-git-send-email-jarkko.sakkinen@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:10105 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932137AbbFHNlk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 8 Jun 2015 09:41:40 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: robert.moore@intel.com
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, "open list:ACPI COMPONENT AR..." <linux-acpi@vger.kernel.org>, "open list:ACPI COMPONENT AR..." <devel@acpica.org>, open list <linux-kernel@vger.kernel.org>

Updated struct acpi_table_tpm2 to conform to the official TCG ACPI
spec.

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 include/acpi/actbl3.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h
index 440ca81..33df1dd 100644
--- a/include/acpi/actbl3.h
+++ b/include/acpi/actbl3.h
@@ -688,13 +688,14 @@ enum acpi_rasf_status {
  * TPM2 - Trusted Platform Module (TPM) 2.0 Hardware Interface Table
  *        Version 3
  *
- * Conforms to "TPM 2.0 Hardware Interface Table (TPM2)" 29 November 2011
+ * Conforms to "TCG ACPI Specification for Family 1.2 and 2.0" 19 December 2014
  *
  ******************************************************************************/
 
 struct acpi_table_tpm2 {
 	struct acpi_table_header header;	/* Common ACPI table header */
-	u32 flags;
+	u16 platform_class;
+	u16 reserved;
 	u64 control_address;
 	u32 start_method;
 };
-- 
2.1.4

