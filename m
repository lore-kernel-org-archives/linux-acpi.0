From: Colin King <colin.king@canonical.com>
Subject: [PATCH] tools/acpi: fix inverted logic when closing fd
Date: Mon, 18 Apr 2016 23:17:51 +0100
Message-ID: <1461017871-5395-1-git-send-email-colin.king@canonical.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:42168 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751126AbcDRWR4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 18 Apr 2016 18:17:56 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org, devel@acpica.org
Cc: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The current close on fd only occurs when fd is -ve, it should
actually be closing the file if it a valid fd. Fix the inverted logic.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 tools/power/acpi/tools/acpidbg/acpidbg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/acpi/tools/acpidbg/acpidbg.c b/tools/power/acpi/tools/acpidbg/acpidbg.c
index d070fcc..ebe44dd 100644
--- a/tools/power/acpi/tools/acpidbg/acpidbg.c
+++ b/tools/power/acpi/tools/acpidbg/acpidbg.c
@@ -430,7 +430,7 @@ int main(int argc, char **argv)
 	acpi_aml_loop(fd);
 
 exit:
-	if (fd < 0)
+	if (fd >= 0)
 		close(fd);
 	if (acpi_aml_batch_cmd)
 		free(acpi_aml_batch_cmd);
-- 
2.7.4

