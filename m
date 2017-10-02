From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ACPI / sysfs: make function param_set_trace_method_name static
Date: Mon,  2 Oct 2017 15:40:33 +0100
Message-ID: <20171002144033.26965-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:47214 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751120AbdJBOkg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 2 Oct 2017 10:40:36 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The function param_set_trace_method_name is local to the source and does
not need to be in global scope, so make it static.

Cleans up sparse warning:
symbol 'param_set_trace_method_name' was not declared. Should it be static?

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/acpi/sysfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index 78a5a23010ab..ca80e13aeeb1 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -168,7 +168,8 @@ module_param_cb(debug_level, &param_ops_debug_level, &acpi_dbg_level, 0644);
 
 static char trace_method_name[1024];
 
-int param_set_trace_method_name(const char *val, const struct kernel_param *kp)
+static int param_set_trace_method_name(const char *val,
+				       const struct kernel_param *kp)
 {
 	u32 saved_flags = 0;
 	bool is_abs_path = true;
-- 
2.14.1

