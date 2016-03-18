From: Colin King <colin.king@canonical.com>
Subject: [PATCH] tools/power/acpi: close file only if it is open
Date: Fri, 18 Mar 2016 14:28:32 +0000
Message-ID: <1458311312-23330-1-git-send-email-colin.king@canonical.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:35680 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934048AbcCRO2g (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Mar 2016 10:28:36 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org, devel@acpica.org
Cc: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

the logic on the test for a valid fd to close is incorrect and
the current code will close -ve fd's which is not was intended.
Since the only path to the exit label is on a failed open, we
may as well just close fd if it has been opened successfully
before the exit label and also remove the valid fd check.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 tools/power/acpi/tools/acpidbg/acpidbg.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/power/acpi/tools/acpidbg/acpidbg.c b/tools/power/acpi/tools/acpidbg/acpidbg.c
index d070fcc..38ccac9 100644
--- a/tools/power/acpi/tools/acpidbg/acpidbg.c
+++ b/tools/power/acpi/tools/acpidbg/acpidbg.c
@@ -429,9 +429,8 @@ int main(int argc, char **argv)
 		acpi_aml_flush(fd);
 	acpi_aml_loop(fd);
 
+	close(fd);
 exit:
-	if (fd < 0)
-		close(fd);
 	if (acpi_aml_batch_cmd)
 		free(acpi_aml_batch_cmd);
 	return ret;
-- 
2.7.3

