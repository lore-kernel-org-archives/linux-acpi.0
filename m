From: Dave Jiang <dave.jiang@intel.com>
Subject: [PATCH v4 4/4] nfit-test: Add platform cap support from ACPI 6.2a
 to test
Date: Tue, 30 Jan 2018 17:21:39 -0700
Message-ID: <151735809953.47256.4760206674183250692.stgit@djiang5-desk3.ch.intel.com>
References: <151735800899.47256.2204307128644539213.stgit@djiang5-desk3.ch.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:41195 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932266AbeAaAVk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 30 Jan 2018 19:21:40 -0500
In-Reply-To: <151735800899.47256.2204307128644539213.stgit@djiang5-desk3.ch.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: dan.j.williams@intel.com, ross.zwisler@linux.intel.com
Cc: linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org

Adding NFIT platform capabilities sub table in nfit_test simulated ACPI
NFIT table. Only the first NFIT table is added with the capability
sub-table.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ross Zwisler <ross.zwisler@linux.intel.com>
---
 tools/testing/nvdimm/test/nfit.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/testing/nvdimm/test/nfit.c b/tools/testing/nvdimm/test/nfit.c
index 7217b2b953b5..f4791e6e70cf 100644
--- a/tools/testing/nvdimm/test/nfit.c
+++ b/tools/testing/nvdimm/test/nfit.c
@@ -881,7 +881,8 @@ static int nfit_test0_alloc(struct nfit_test *t)
 					window_size) * NUM_DCR
 			+ sizeof(struct acpi_nfit_data_region) * NUM_BDW
 			+ (sizeof(struct acpi_nfit_flush_address)
-					+ sizeof(u64) * NUM_HINTS) * NUM_DCR;
+					+ sizeof(u64) * NUM_HINTS) * NUM_DCR
+			+ sizeof(struct acpi_nfit_capabilities);
 	int i;
 
 	t->nfit_buf = test_alloc(t, nfit_size, &t->nfit_dma);
@@ -993,6 +994,7 @@ static void nfit_test0_setup(struct nfit_test *t)
 	struct acpi_nfit_control_region *dcr;
 	struct acpi_nfit_data_region *bdw;
 	struct acpi_nfit_flush_address *flush;
+	struct acpi_nfit_capabilities *pcap;
 	unsigned int offset, i;
 
 	/*
@@ -1500,8 +1502,16 @@ static void nfit_test0_setup(struct nfit_test *t)
 	for (i = 0; i < NUM_HINTS; i++)
 		flush->hint_address[i] = t->flush_dma[3] + i * sizeof(u64);
 
+	/* platform capabilities */
+	pcap = nfit_buf + offset + flush_hint_size * 4;
+	pcap->header.type = ACPI_NFIT_TYPE_CAPABILITIES;
+	pcap->header.length = sizeof(*pcap);
+	pcap->highest_capability = BIT(2);
+	pcap->capabilities = ACPI_NFIT_CAPABILITY_CACHE_FLUSH |
+		ACPI_NFIT_CAPABILITY_MEM_FLUSH;
+
 	if (t->setup_hotplug) {
-		offset = offset + flush_hint_size * 4;
+		offset = offset + flush_hint_size * 4 + sizeof(*pcap);
 		/* dcr-descriptor4: blk */
 		dcr = nfit_buf + offset;
 		dcr->header.type = ACPI_NFIT_TYPE_CONTROL_REGION;

