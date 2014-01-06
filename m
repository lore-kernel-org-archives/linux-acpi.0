From: Tang Chen <tangchen@cn.fujitsu.com>
Subject: [PATCH] acpi: Check if @id is NULL in acpi_table_parse()
Date: Mon, 6 Jan 2014 16:43:54 +0800
Message-ID: <1388997834-28028-1-git-send-email-tangchen@cn.fujitsu.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:64392 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751063AbaAFIl3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 6 Jan 2014 03:41:29 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@sisk.pl, lenb@kernel.org, toshi.kani@hp.com
Cc: tangchen@cn.fujitsu.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

strncmp() does not check if the params are NULL. In acpi_table_parse(),
if @id is NULL, the kernel will panic.

Signed-off-by: Tang Chen <tangchen@cn.fujitsu.com>
Acked-by: Toshi Kani <toshi.kani@hp.com>
---
 drivers/acpi/tables.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index d67a1fe..5a5263b 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -293,7 +293,7 @@ int __init acpi_table_parse(char *id, acpi_tbl_table_handler handler)
 	if (acpi_disabled)
 		return -ENODEV;
 
-	if (!handler)
+	if (!id || !handler)
 		return -EINVAL;
 
 	if (strncmp(id, ACPI_SIG_MADT, 4) == 0)
-- 
1.7.11.7

