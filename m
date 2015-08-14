From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] ACPI / osl: remove unused code
Date: Fri, 14 Aug 2015 18:39:25 +0300
Message-ID: <1439566765-60490-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:19030 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755140AbbHNPj7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 14 Aug 2015 11:39:59 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

The readq() and writeq() helpers are available in the
asm-generic/io-64-nonatomic-hi-lo.h and asm-generic/io-64-nonatomic-lo-hi.h
headers. Someone may use them when it's needed.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/osl.c | 28 ----------------------------
 1 file changed, 28 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 21c1e71..11c32ff 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -944,21 +944,6 @@ acpi_status acpi_os_write_port(acpi_io_address port, u32 value, u32 width)
 
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
@@ -1005,19 +990,6 @@ acpi_os_read_memory(acpi_physical_address phys_addr, u64 *value, u32 width)
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
-- 
2.5.0

