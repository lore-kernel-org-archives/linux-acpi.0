From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 14/15] ACPICA: Fix build for FreeBSD kernel.
Date: Wed, 26 Apr 2017 16:20:07 +0800
Message-ID: <a0d9b9d4157864a37f45d58594d747cd21aa4ab1.1493194142.git.lv.zheng@intel.com>
References: <cover.1493194142.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:1827 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1953202AbdDZIUN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 26 Apr 2017 04:20:13 -0400
In-Reply-To: <cover.1493194142.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <lv.zheng@intel.com>, "David E . Box" <david.e.box@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Jung-uk Kim <jkim@FreeBSD.org>

From: Jung-uk Kim <jkim@FreeBSD.org>

ACPICA commit a65c1df7e6b4bad8e37df822018c40c6c446add9

FILE is only defined in user land.

Link: https://github.com/acpica/acpica/commit/a65c1df7
Signed-off-by: Jung-uk Kim <jkim@FreeBSD.org>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/aclocal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index e822280..4d608db 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -838,7 +838,7 @@ struct acpi_comment_addr_node {
  * depdendency tree for the -ca option
  */
 struct acpi_file_node {
-	FILE *file;
+	void *file;
 	char *filename;
 	char *file_start;	/* Points to AML and indicates when the AML for this particular file starts. */
 	char *file_end;		/* Points to AML and indicates when the AML for this particular file ends. */
-- 
2.7.4

