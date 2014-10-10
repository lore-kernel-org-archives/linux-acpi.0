From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 09/10] ACPICA: acpiexec: Do not put STDIN into raw mode unless it is a terminal.
Date: Fri, 10 Oct 2014 10:40:19 +0800
Message-ID: <fa901070fc416f1a9d48f0b913228eab1ed68e80.1412907188.git.lv.zheng@intel.com>
References: <cover.1412907188.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:5950 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751064AbaJJCk1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 9 Oct 2014 22:40:27 -0400
In-Reply-To: <cover.1412907188.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

Eliminate an error message for batch-mode processing on unix
systems. ACPICA BZ 1114.

This patch is mainly for fixing the issues of acpiexec which is not in the
Linux upstream.

Link: https://bugs.acpica.org/show_bug.cgi?id=1114
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 tools/power/acpi/os_specific/service_layers/osunixxf.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/power/acpi/os_specific/service_layers/osunixxf.c b/tools/power/acpi/os_specific/service_layers/osunixxf.c
index 60b58cd..7ccb073 100644
--- a/tools/power/acpi/os_specific/service_layers/osunixxf.c
+++ b/tools/power/acpi/os_specific/service_layers/osunixxf.c
@@ -122,6 +122,14 @@ static void os_enter_line_edit_mode(void)
 {
 	struct termios local_term_attributes;
 
+	term_attributes_were_set = 0;
+
+	/* STDIN must be a terminal */
+
+	if (!isatty(STDIN_FILENO)) {
+		return;
+	}
+
 	/* Get and keep the original attributes */
 
 	if (tcgetattr(STDIN_FILENO, &original_term_attributes)) {
-- 
1.7.10

