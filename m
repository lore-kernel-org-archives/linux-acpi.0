From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 12/16] ACPICA: Support Mac OS X in Makefile
Date: Sat,  8 Jun 2013 09:00:32 +0800
Message-ID: <a53763538a095e661d09786e2ffa3129b42c29b7.1369274559.git.lv.zheng@intel.com>
References: <cover.1369274558.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:45458 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753181Ab3FHBBI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 7 Jun 2013 21:01:08 -0400
In-Reply-To: <cover.1369274558.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

* gcc and clang both works.
* make install works.
* support PREFIX and HOST.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/platform/acenv.h |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/acpi/platform/acenv.h b/include/acpi/platform/acenv.h
index 2c2a0a8..974d3ef 100644
--- a/include/acpi/platform/acenv.h
+++ b/include/acpi/platform/acenv.h
@@ -148,6 +148,9 @@
 #if defined(_LINUX) || defined(__linux__)
 #include <acpi/platform/aclinux.h>
 
+#elif defined(_APPLE) || defined(__APPLE__)
+#include "acmacosx.h"
+
 #elif defined(__FreeBSD__) || defined(__FreeBSD_kernel__)
 #include "acfreebsd.h"
 
-- 
1.7.10

