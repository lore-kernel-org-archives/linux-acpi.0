From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 12/15] ACPICA: Update compilation environment settings.
Date: Thu, 31 Oct 2013 09:31:06 +0800
Message-ID: <d6c4b422bc857ee29c43cb2e050d50d0361465cb.1383182393.git.lv.zheng@intel.com>
References: <cover.1383009405.git.lv.zheng@intel.com> <cover.1383182392.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:52685 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751742Ab3JaBbz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 30 Oct 2013 21:31:55 -0400
In-Reply-To: <cover.1383182392.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

This patch does not affect the generation of the Linux binary.
This patch decreases 3 lines of divergences.

This patch updates architecture specific environment settings to reduce
source differences between Linux and ACPICA upstream.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/platform/acenv.h |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/acpi/platform/acenv.h b/include/acpi/platform/acenv.h
index ef04b36..9b3966c 100644
--- a/include/acpi/platform/acenv.h
+++ b/include/acpi/platform/acenv.h
@@ -147,6 +147,9 @@
 #if defined(_LINUX) || defined(__linux__)
 #include <acpi/platform/aclinux.h>
 
+#elif defined(_APPLE) || defined(__APPLE__)
+#include "acmacosx.h"
+
 #elif defined(__FreeBSD__) || defined(__FreeBSD_kernel__)
 #include "acfreebsd.h"
 
-- 
1.7.10

