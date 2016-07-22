From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v3 2/3] tools/power/acpi/acpidbg: Use new flushing mechanism
Date: Fri, 22 Jul 2016 12:17:05 +0800
Message-ID: <b8d45e07cbdb73252e5b152bbf31afec321f5a1c.1469155242.git.lv.zheng@intel.com>
References: <cover.1468464391.git.lv.zheng@intel.com> <cover.1469155242.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:27842 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751907AbcGVERJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 22 Jul 2016 00:17:09 -0400
In-Reply-To: <cover.1469155242.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

This patch converts tools/power/acpi/tools/acpidbg/acpidbg to use the new
flushing mechanism.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 tools/power/acpi/tools/acpidbg/acpidbg.c |   51 ++++--------------------------
 1 file changed, 7 insertions(+), 44 deletions(-)

diff --git a/tools/power/acpi/tools/acpidbg/acpidbg.c b/tools/power/acpi/tools/acpidbg/acpidbg.c
index a88ac45..f5542b9 100644
--- a/tools/power/acpi/tools/acpidbg/acpidbg.c
+++ b/tools/power/acpi/tools/acpidbg/acpidbg.c
@@ -15,7 +15,9 @@
 #include <stdbool.h>
 #include <fcntl.h>
 #include <assert.h>
+#include <sys/ioctl.h>
 #include <linux/circ_buf.h>
+#include <uapi/linux/acpi-ioctls.h>
 
 #define ACPI_AML_FILE		"/sys/kernel/debug/acpi/acpidbg"
 #define ACPI_AML_SEC_TICK	1
@@ -83,7 +85,6 @@ static const char *acpi_aml_file_path = ACPI_AML_FILE;
 static unsigned long acpi_aml_mode = ACPI_AML_INTERACTIVE;
 static bool acpi_aml_exit;
 
-static bool acpi_aml_batch_drain;
 static unsigned long acpi_aml_batch_state;
 static char acpi_aml_batch_prompt;
 static char acpi_aml_batch_roll;
@@ -239,11 +240,9 @@ static int acpi_aml_write_batch_log(int fd, struct circ_buf *crc)
 
 	p = &crc->buf[crc->tail];
 	len = circ_count_to_end(crc);
-	if (!acpi_aml_batch_drain) {
-		len = write(fd, p, len);
-		if (len < 0)
-			perror("write");
-	}
+	len = write(fd, p, len);
+	if (len < 0)
+		perror("write");
 	if (len > 0)
 		crc->tail = (crc->tail + len) & (ACPI_AML_BUF_SIZE - 1);
 	return len;
@@ -270,10 +269,7 @@ static void acpi_aml_loop(int fd)
 	if (acpi_aml_mode == ACPI_AML_BATCH) {
 		acpi_aml_log_state = ACPI_AML_LOG_START;
 		acpi_aml_batch_pos = acpi_aml_batch_cmd;
-		if (acpi_aml_batch_drain)
-			acpi_aml_batch_state = ACPI_AML_BATCH_READ_LOG;
-		else
-			acpi_aml_batch_state = ACPI_AML_BATCH_WRITE_CMD;
+		acpi_aml_batch_state = ACPI_AML_BATCH_WRITE_CMD;
 	}
 	acpi_aml_exit = false;
 	while (!acpi_aml_exit) {
@@ -330,39 +326,6 @@ static void acpi_aml_loop(int fd)
 	}
 }
 
-static bool acpi_aml_readable(int fd)
-{
-	fd_set rfds;
-	struct timeval tv;
-	int ret;
-	int maxfd = 0;
-
-	tv.tv_sec = 0;
-	tv.tv_usec = ACPI_AML_USEC_PEEK;
-	FD_ZERO(&rfds);
-	maxfd = acpi_aml_set_fd(fd, maxfd, &rfds);
-	ret = select(maxfd+1, &rfds, NULL, NULL, &tv);
-	if (ret < 0)
-		perror("select");
-	if (ret > 0 && FD_ISSET(fd, &rfds))
-		return true;
-	return false;
-}
-
-/*
- * This is a userspace IO flush implementation, replying on the prompt
- * characters and can be turned into a flush() call after kernel implements
- * .flush() filesystem operation.
- */
-static void acpi_aml_flush(int fd)
-{
-	while (acpi_aml_readable(fd)) {
-		acpi_aml_batch_drain = true;
-		acpi_aml_loop(fd);
-		acpi_aml_batch_drain = false;
-	}
-}
-
 void usage(FILE *file, char *progname)
 {
 	fprintf(file, "usage: %s [-b cmd] [-f file] [-h]\n", progname);
@@ -426,7 +389,7 @@ int main(int argc, char **argv)
 	acpi_aml_set_fl(STDOUT_FILENO, O_NONBLOCK);
 
 	if (acpi_aml_mode == ACPI_AML_BATCH)
-		acpi_aml_flush(fd);
+		ioctl(fd, ACPI_IOCTL_DEBUGGER_FLUSH);
 	acpi_aml_loop(fd);
 
 exit:
-- 
1.7.10

