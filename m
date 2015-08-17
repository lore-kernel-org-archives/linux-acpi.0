From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/1] ACPI / osl: replace custom implementation of readq / writeq
Date: Mon, 17 Aug 2015 17:28:46 +0300
Message-ID: <1439821726-146561-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:57228 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754674AbbHQO2t (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 17 Aug 2015 10:28:49 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

The readq() and writeq() helpers are available in the
asm-generic/io-64-nonatomic-hi-lo.h and asm-generic/io-64-nonatomic-lo-hi.h
headers. Replace custom implementation by the generic helpers.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
Since v1:
- test with CONFIG_ACPI=y
- update commit message and patch accordingly
- tested on Intel Braswell platform
 drivers/acpi/osl.c | 33 +++------------------------------
 1 file changed, 3 insertions(+), 30 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 21c1e71..739a4a6 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -43,6 +43,7 @@
 
 #include <asm/io.h>
 #include <asm/uaccess.h>
+#include <asm-generic/io-64-nonatomic-lo-hi.h>
 
 #include "internal.h"
 
@@ -944,21 +945,6 @@ acpi_status acpi_os_write_port(acpi_io_address port, u32 value, u32 width)
 
 EXPORT_SYMBOL(acpi_os_write_port);
 
-#ifdef readq
-static inline u64 read64(const volatile void __iomem *addr)
-{
-	return readq(addr);
-}
-#else
-static inline u64 read64(const volatile void __iomem *addr)
-{
-	u64 l, h;
-	l = readl(addr);
-	h = readl(addr+4);
-	return l | (h << 32);
-}
-#endif
-
 acpi_status
 acpi_os_read_memory(acpi_physical_address phys_addr, u64 *value, u32 width)
 {
@@ -991,7 +977,7 @@ acpi_os_read_memory(acpi_physical_address phys_addr, u64 *value, u32 width)
 		*(u32 *) value = readl(virt_addr);
 		break;
 	case 64:
-		*(u64 *) value = read64(virt_addr);
+		*(u64 *) value = readq(virt_addr);
 		break;
 	default:
 		BUG();
@@ -1005,19 +991,6 @@ acpi_os_read_memory(acpi_physical_address phys_addr, u64 *value, u32 width)
 	return AE_OK;
 }
 
-#ifdef writeq
-static inline void write64(u64 val, volatile void __iomem *addr)
-{
-	writeq(val, addr);
-}
-#else
-static inline void write64(u64 val, volatile void __iomem *addr)
-{
-	writel(val, addr);
-	writel(val>>32, addr+4);
-}
-#endif
-
 acpi_status
 acpi_os_write_memory(acpi_physical_address phys_addr, u64 value, u32 width)
 {
@@ -1046,7 +1019,7 @@ acpi_os_write_memory(acpi_physical_address phys_addr, u64 value, u32 width)
 		writel(value, virt_addr);
 		break;
 	case 64:
-		write64(value, virt_addr);
+		writeq(value, virt_addr);
 		break;
 	default:
 		BUG();
-- 
2.5.0

