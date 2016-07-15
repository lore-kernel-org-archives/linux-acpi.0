From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH] tools/testing/nvdimm: add virtual ramdisk range
Date: Thu, 14 Jul 2016 22:28:40 -0700
Message-ID: <146856052024.34333.9532520454252164419.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:13448 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750870AbcGOFav (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 15 Jul 2016 01:30:51 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-nvdimm@lists.01.org
Cc: "Lee, Chun-Yi" <jlee@suse.com>, linux-acpi@vger.kernel.org

Test the virtual disk ranges that platform firmware like EDK2/OVMF might
emit.

Cc: "Lee, Chun-Yi" <jlee@suse.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 tools/testing/nvdimm/test/nfit.c |   17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/testing/nvdimm/test/nfit.c b/tools/testing/nvdimm/test/nfit.c
index ff09a28890ed..0a803f63307a 100644
--- a/tools/testing/nvdimm/test/nfit.c
+++ b/tools/testing/nvdimm/test/nfit.c
@@ -96,7 +96,7 @@
  *    reference an NVDIMM.
  */
 enum {
-	NUM_PM  = 3,
+	NUM_PM  = 4,
 	NUM_DCR = 5,
 	NUM_HINTS = 8,
 	NUM_BDW = NUM_DCR,
@@ -591,6 +591,10 @@ static int nfit_test0_alloc(struct nfit_test *t)
 	if (!t->spa_set[2])
 		return -ENOMEM;
 
+	t->spa_set[3] = test_alloc(t, SPA0_SIZE, &t->spa_set_dma[3]);
+	if (!t->spa_set[3])
+		return -ENOMEM;
+
 	for (i = 0; i < NUM_DCR; i++) {
 		t->dimm[i] = test_alloc(t, DIMM_SIZE, &t->dimm_dma[i]);
 		if (!t->dimm[i])
@@ -745,7 +749,16 @@ static void nfit_test0_setup(struct nfit_test *t)
 	spa->address = t->dimm_dma[3];
 	spa->length = DIMM_SIZE;
 
-	offset = sizeof(*spa) * 10;
+	/* virtual cd region */
+	spa = nfit_buf + sizeof(*spa) * 10;
+	spa->header.type = ACPI_NFIT_TYPE_SYSTEM_ADDRESS;
+	spa->header.length = sizeof(*spa);
+	memcpy(spa->range_guid, to_nfit_uuid(NFIT_SPA_VCD), 16);
+	spa->range_index = 0;
+	spa->address = t->spa_set_dma[3];
+	spa->length = SPA0_SIZE;
+
+	offset = sizeof(*spa) * 11;
 	/* mem-region0 (spa0, dimm0) */
 	memdev = nfit_buf + offset;
 	memdev->header.type = ACPI_NFIT_TYPE_MEMORY_MAP;

