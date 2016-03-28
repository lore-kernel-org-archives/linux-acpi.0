From: Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH] ACPICA: Remove unnecessary "\n" from an ACPI_INFO boot message
Date: Mon, 28 Mar 2016 14:59:27 -0300
Message-ID: <74bc15316c48bb33c0954d94c0595720ee0955bd.1459187689.git.bristot@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59388 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751156AbcC1R7y (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 28 Mar 2016 13:59:54 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org, linux-kernel@vger.kernel.org

A "\n" at the end of bellow ACPI_INFO message is causing a blank line
in the kernel log:

  ACPI_INFO(("%u ACPI AML tables successfully acquired and loaded\n", tables_loaded));

This patch removes the "\n".

Kernel log before this patch:
	ACPI: Core revision 20160108
	ACPI: 2 ACPI AML tables successfully acquired and loaded

	Security Framework initialized

Kernel log after this patch:
	ACPI: Core revision 20160108
	ACPI: 2 ACPI AML tables successfully acquired and loaded
	Security Framework initialized

Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>

diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfload.c
index 3151968..e435b84 100644
--- a/drivers/acpi/acpica/tbxfload.c
+++ b/drivers/acpi/acpica/tbxfload.c
@@ -240,7 +240,8 @@ acpi_status acpi_tb_load_namespace(void)
 	}
 
 	if (!tables_failed) {
-		ACPI_INFO(("%u ACPI AML tables successfully acquired and loaded\n", tables_loaded));
+		ACPI_INFO(("%u ACPI AML tables successfully acquired and loaded",
+			   tables_loaded));
 	} else {
 		ACPI_ERROR((AE_INFO,
 			    "%u table load failures, %u successful",
-- 
2.5.0

