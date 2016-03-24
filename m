From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH] tools/power/acpi: close file only if it is open
Date: Thu, 24 Mar 2016 13:01:28 +0800
Message-ID: <1458795688-2147-1-git-send-email-lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:17718 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751104AbcCXFCA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 24 Mar 2016 01:02:00 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

The logic on the test for a valid fd to close is incorrect.
This was just a mistake and was pointed out by Colin Ian King.

Link: https://patchwork.kernel.org/patch/8620201/
Original-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 tools/power/acpi/tools/acpidbg/acpidbg.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/power/acpi/tools/acpidbg/acpidbg.c b/tools/power/acpi/tools/acpidbg/acpidbg.c
index d070fcc..a88ac45 100644
--- a/tools/power/acpi/tools/acpidbg/acpidbg.c
+++ b/tools/power/acpi/tools/acpidbg/acpidbg.c
@@ -375,7 +375,7 @@ void usage(FILE *file, char *progname)
 
 int main(int argc, char **argv)
 {
-	int fd = 0;
+	int fd = -1;
 	int ch;
 	int len;
 	int ret = EXIT_SUCCESS;
@@ -430,7 +430,7 @@ int main(int argc, char **argv)
 	acpi_aml_loop(fd);
 
 exit:
-	if (fd < 0)
+	if (fd >= 0)
 		close(fd);
 	if (acpi_aml_batch_cmd)
 		free(acpi_aml_batch_cmd);
-- 
1.7.10

