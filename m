From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 01/20] ACPICA: Ensure that debug output is immediately disabled on termination.
Date: Tue, 29 Oct 2013 09:28:49 +0800
Message-ID: <c7f53383d5249baea33feac7db59623af0fe75ea.1383009405.git.lv.zheng@intel.com>
References: <cover.1383009405.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:48166 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756441Ab3J2B27 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 28 Oct 2013 21:28:59 -0400
In-Reply-To: <cover.1383009405.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org, Tomasz Nowicki <tomasz.nowicki@linaro.org>

From: Tomasz Nowicki <tomasz.nowicki@linaro.org>

Since the debugger is not shipped in the Linux kernel upstream, this
change doesn't affect Linux kernel's behaviors.

Set the global debug flag to "no output" when the debugger is shutdown.
ACPICA BZ 1011. Tomasz Nowicki.

Buglink: https://bugs.acpica.org/show_bug.cgi?id=1011
Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/aclocal.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index be9e30e..dafa0f6 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -1094,6 +1094,7 @@ struct acpi_integrity_info {
 	u32 objects;
 };
 
+#define ACPI_DB_DISABLE_OUTPUT          0x00
 #define ACPI_DB_REDIRECTABLE_OUTPUT     0x01
 #define ACPI_DB_CONSOLE_OUTPUT          0x02
 #define ACPI_DB_DUPLICATE_OUTPUT        0x03
-- 
1.7.10

