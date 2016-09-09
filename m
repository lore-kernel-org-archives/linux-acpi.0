From: Borislav Petkov <bp@alien8.de>
Subject: [PATCH] ACPICA / Interpreter: Remove redundant newline
Date: Fri,  9 Sep 2016 18:12:53 +0200
Message-ID: <20160909161253.30952-1-bp@alien8.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:51494 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752344AbcIIQM6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 9 Sep 2016 12:12:58 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, devel@acpica.org

From: Borislav Petkov <bp@suse.de>

acpi_info() already issues a '\n' so remove it in the call.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Robert Moore <robert.moore@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org
Cc: devel@acpica.org
---
 drivers/acpi/acpica/tbxfload.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfload.c
index ac71abcd32bb..e7119b7ccd79 100644
--- a/drivers/acpi/acpica/tbxfload.c
+++ b/drivers/acpi/acpica/tbxfload.c
@@ -240,7 +240,7 @@ acpi_status acpi_tb_load_namespace(void)
 	}
 
 	if (!tables_failed) {
-		ACPI_INFO(("%u ACPI AML tables successfully acquired and loaded\n", tables_loaded));
+		ACPI_INFO(("%u ACPI AML tables successfully acquired and loaded", tables_loaded));
 	} else {
 		ACPI_ERROR((AE_INFO,
 			    "%u table load failures, %u successful",
-- 
2.10.0

