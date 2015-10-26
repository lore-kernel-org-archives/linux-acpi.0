From: Toshi Kani <toshi.kani@hpe.com>
Subject: [PATCH v2 UPDATE 3/3] ACPI/APEI/EINJ: Allow memory error injection to NVDIMM
Date: Mon, 26 Oct 2015 09:03:03 -0600
Message-ID: <1445871783-18365-1-git-send-email-toshi.kani@hpe.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t6219.austin.hp.com ([15.73.96.127]:34461 "EHLO
	g1t6219.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751874AbbJZPG5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 26 Oct 2015 11:06:57 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: bp@alien8.de, tony.luck@intel.com, akpm@linux-foundation.org, dan.j.williams@intel.com, rjw@rjwysocki.net
Cc: linux-mm@kvack.org, linux-nvdimm@lists.01.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Toshi Kani <toshi.kani@hpe.com>

In the case of memory error injection, einj_error_inject() checks
if a target address is regular RAM.  Update this check to add a call
to region_intersects_pmem() to verify if a target address range is
NVDIMM.  This allows injecting a memory error to both RAM and NVDIMM
for testing.

Also, the current RAM check, page_is_ram(), is replaced with
region_intersects_ram() so that it can verify a target address
range with the requested size.

Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
Add a blank line before if-statement. (Borislav Petkov)
---
 drivers/acpi/apei/einj.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index 0431883..db21efe 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -519,7 +519,7 @@ static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 			     u64 param3, u64 param4)
 {
 	int rc;
-	unsigned long pfn;
+	u64 base_addr, size;
 
 	/* If user manually set "flags", make sure it is legal */
 	if (flags && (flags &
@@ -545,10 +545,15 @@ static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 	/*
 	 * Disallow crazy address masks that give BIOS leeway to pick
 	 * injection address almost anywhere. Insist on page or
-	 * better granularity and that target address is normal RAM.
+	 * better granularity and that target address is normal RAM or
+	 * NVDIMM.
 	 */
-	pfn = PFN_DOWN(param1 & param2);
-	if (!page_is_ram(pfn) || ((param2 & PAGE_MASK) != PAGE_MASK))
+	base_addr = param1 & param2;
+	size = (~param2) + 1;
+
+	if (((region_intersects_ram(base_addr, size) != REGION_INTERSECTS) &&
+	     (region_intersects_pmem(base_addr, size) != REGION_INTERSECTS)) ||
+	    ((param2 & PAGE_MASK) != PAGE_MASK))
 		return -EINVAL;
 
 inject:
