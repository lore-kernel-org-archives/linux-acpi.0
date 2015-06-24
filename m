From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 12/28] ACPICA: Add dragon_fly support to unix file mapping file.
Date: Wed, 24 Jun 2015 11:04:02 +0800
Message-ID: <a3994f58dde3953b4583d2742fb1cf233736f4f9.1435114811.git.lv.zheng@intel.com>
References: <cover.1434684719.git.lv.zheng@intel.com> <cover.1435114811.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:14122 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755158AbbFXDEI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 23 Jun 2015 23:04:08 -0400
In-Reply-To: <cover.1435114811.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Sascha Wildner <swildner@gmail.com>, Bob Moore <robert.moore@intel.com>

From: Sascha Wildner <swildner@gmail.com>

ACPICA commit 795b215d6fd062386f0a1c23dff9ffa244683c4f

ACPICA BZ 1130

This patch doesn't affect Linux kernel.

Link: https://bugs.acpica.org/show_bug.cgi?id=1130
Link: https://github.com/acpica/acpica/commit/795b215d
Signed-off-by: Sascha Wildner <swildner@gmail.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 tools/power/acpi/os_specific/service_layers/osunixmap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/acpi/os_specific/service_layers/osunixmap.c b/tools/power/acpi/os_specific/service_layers/osunixmap.c
index 0b1fa29..44ad488 100644
--- a/tools/power/acpi/os_specific/service_layers/osunixmap.c
+++ b/tools/power/acpi/os_specific/service_layers/osunixmap.c
@@ -54,7 +54,7 @@ ACPI_MODULE_NAME("osunixmap")
 #ifndef O_BINARY
 #define O_BINARY 0
 #endif
-#ifdef _free_BSD
+#if defined(_dragon_fly) || defined(_free_BSD)
 #define MMAP_FLAGS          MAP_SHARED
 #else
 #define MMAP_FLAGS          MAP_PRIVATE
-- 
1.7.10

