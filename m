From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 14/32] ACPICA: Add dragon_fly support to unix file mapping file.
Date: Fri, 19 Jun 2015 11:39:47 +0800
Message-ID: <49e861e42bd5279ebb183949432d78656173e60f.1434684720.git.lv.zheng@intel.com>
References: <cover.1434684719.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:27670 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932231AbbFSDjw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 18 Jun 2015 23:39:52 -0400
In-Reply-To: <cover.1434684719.git.lv.zheng@intel.com>
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

