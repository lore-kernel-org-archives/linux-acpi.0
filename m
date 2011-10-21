From: "Luck, Tony" <tony.luck@intel.com>
Subject: [PATCH] Convert width in bits to bytes in __acpi_ioremap_fast()
Date: Fri, 21 Oct 2011 14:42:55 -0700
Message-ID: <4ea1e75f5296b6c6b@agluck-desktop.sc.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:31984 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752853Ab1JUVm4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 21 Oct 2011 17:42:56 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org, Huang Ying <ying.huang@intel.com>

Callers to __acpi_ioremap_fast() pass the bit_width that they found in the
acpi_generic_address structure. Convert from bits to bytes when passing to
__acpi_find_iomap() - as it wants to see bytes, not bits.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 drivers/acpi/atomicio.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/atomicio.c b/drivers/acpi/atomicio.c
index 252888f..70ffb71 100644
--- a/drivers/acpi/atomicio.c
+++ b/drivers/acpi/atomicio.c
@@ -78,7 +78,7 @@ static void __iomem *__acpi_ioremap_fast(phys_addr_t paddr,
 {
 	struct acpi_iomap *map;
 
-	map = __acpi_find_iomap(paddr, size);
+	map = __acpi_find_iomap(paddr, size/8);
 	if (map)
 		return map->vaddr + (paddr - map->paddr);
 	else
-- 
1.7.3.1

