From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH] ACPICA: Remove unnecessary '\n' in the end of ACPI_INFO output
Date: Sat,  6 Aug 2016 23:27:49 +0600
Message-ID: <20160806172749.6315-1-kuleshovmail@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36547 "EHLO
	mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750947AbcHFVxW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 6 Aug 2016 17:53:22 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Robert Moore <robert.moore@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, devel@acpica.org, linux-kernel@vger.kernel.org, Alexander Kuleshov <kuleshovmail@gmail.com>

as the ACPI_INFO already prints `\n` in the end itself.

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 drivers/acpi/acpica/tbxfload.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfload.c
index ac71abc..e7119b7 100644
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
2.8.0.rc3.1353.gea9bdc0

