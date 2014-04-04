From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 09/28] ACPI: Merge divergence of the commmit: ACPICA: Linux-specific header: Update support for Linux/acpi applications.
Date: Fri,  4 Apr 2014 12:37:59 +0800
Message-ID: <233980ce727ab471c444498cd7c37986a7395e68.1396581591.git.lv.zheng@intel.com>
References: <cover.1396581591.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:45677 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750965AbaDDEiC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 4 Apr 2014 00:38:02 -0400
In-Reply-To: <cover.1396581591.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

When the following commmit is back ported to ACPICA, comments have been
updated:
  Subject: ACPICA: Linux-specific header: Update support for Linux/acpi
           applications.

This patch back ports the differences between the ACPICA upstream and
Linux.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 include/acpi/platform/aclinux.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
index 93c55ed..0d94be8 100644
--- a/include/acpi/platform/aclinux.h
+++ b/include/acpi/platform/aclinux.h
@@ -91,7 +91,7 @@
 #include <ctype.h>
 #include <unistd.h>
 
-/* Disable kernel specific declarators */
+/* Define/disable kernel-specific declarators */
 
 #ifndef __init
 #define __init
-- 
1.7.10

