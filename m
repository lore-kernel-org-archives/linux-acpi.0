From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 2/9] ACPICA: Emit all unresolved method externals in a text block
Date: Thu,  8 Aug 2013 15:29:27 +0800
Message-ID: <0345882b5fa7c8274bd504667cfaf5409b8922fa.1375946725.git.lv.zheng@intel.com>
References: <cover.1375946725.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:55994 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751211Ab3HHH3m (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 8 Aug 2013 03:29:42 -0400
In-Reply-To: <cover.1375946725.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

Put all of the unresolved external method declarations in a single block,
since they are important and may cause the resulting disassembled ASL file
to not compile.
This patch only affects ACPICA utilities and is necessary to avoid adding
source code divergences between Linux and ACPICA upstream.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/aclocal.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index b0e3d15..0ed0066 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -1033,6 +1033,7 @@ struct acpi_external_list {
 	u8 type;
 	u8 flags;
 	u8 resolved;
+	u8 emitted;
 };
 
 /* Values for Flags field above */
-- 
1.7.10

