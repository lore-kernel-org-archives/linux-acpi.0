From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v2] tools/testing/nvdimm: add virtual ramdisk range
Date: Fri, 15 Jul 2016 12:35:58 -0700
Message-ID: <146861130048.16896.9105590813517990661.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:2591 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751548AbcGOTiK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 15 Jul 2016 15:38:10 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-nvdimm@lists.01.org
Cc: "Lee, Chun-Yi" <jlee@suse.com>, linux-acpi@vger.kernel.org

Test the virtual disk ranges that platform firmware like EDK2/OVMF might
emit.

Cc: "Lee, Chun-Yi" <jlee@suse.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
Changes since v1:

* Move this test range to nfit_test.1 to not break the spa ordering
  expected by the nfit_test.0 tests.

 tools/testing/nvdimm/test/nfit.c |   18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/tools/testing/nvdimm/test/nfit.c b/tools/testing/nvdimm/test/nfit.c
index 52df3c20231d..d4a4635c1186 100644
--- a/tools/testing/nvdimm/test/nfit.c
+++ b/tools/testing/nvdimm/test/nfit.c
@@ -104,6 +104,7 @@ enum {
 	NUM_MEM = NUM_DCR + NUM_BDW + 2 /* spa0 iset */ + 4 /* spa1 iset */,
 	DIMM_SIZE = SZ_32M,
 	LABEL_SIZE = SZ_128K,
+	SPA_VCD_SIZE = SZ_4M,
 	SPA0_SIZE = DIMM_SIZE,
 	SPA1_SIZE = DIMM_SIZE*2,
 	SPA2_SIZE = DIMM_SIZE,
@@ -618,7 +619,7 @@ static int nfit_test0_alloc(struct nfit_test *t)
 
 static int nfit_test1_alloc(struct nfit_test *t)
 {
-	size_t nfit_size = sizeof(struct acpi_nfit_system_address)
+	size_t nfit_size = sizeof(struct acpi_nfit_system_address) * 2
 		+ sizeof(struct acpi_nfit_memory_map)
 		+ offsetof(struct acpi_nfit_control_region, window_size);
 
@@ -631,6 +632,10 @@ static int nfit_test1_alloc(struct nfit_test *t)
 	if (!t->spa_set[0])
 		return -ENOMEM;
 
+	t->spa_set[1] = test_alloc(t, SPA_VCD_SIZE, &t->spa_set_dma[1]);
+	if (!t->spa_set[1])
+		return -ENOMEM;
+
 	return ars_state_init(&t->pdev.dev, &t->ars_state);
 }
 
@@ -1335,7 +1340,16 @@ static void nfit_test1_setup(struct nfit_test *t)
 	spa->address = t->spa_set_dma[0];
 	spa->length = SPA2_SIZE;
 
-	offset += sizeof(*spa);
+	/* virtual cd region */
+	spa = nfit_buf + sizeof(*spa);
+	spa->header.type = ACPI_NFIT_TYPE_SYSTEM_ADDRESS;
+	spa->header.length = sizeof(*spa);
+	memcpy(spa->range_guid, to_nfit_uuid(NFIT_SPA_VCD), 16);
+	spa->range_index = 0;
+	spa->address = t->spa_set_dma[1];
+	spa->length = SPA_VCD_SIZE;
+
+	offset += sizeof(*spa) * 2;
 	/* mem-region0 (spa0, dimm0) */
 	memdev = nfit_buf + offset;
 	memdev->header.type = ACPI_NFIT_TYPE_MEMORY_MAP;

