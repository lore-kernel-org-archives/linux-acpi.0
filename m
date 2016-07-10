From: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 06/17] tools/testing/nvdimm: simulate multiple flush
 hints per-dimm
Date: Sat, 09 Jul 2016 20:25:01 -0700
Message-ID: <146812110130.32932.15911789996959208475.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <146812106839.32932.2870621200867047059.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <146812106839.32932.2870621200867047059.stgit-p8uTFz9XbKj2zm6wflaqv1nYeNYlB/vhral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Cc: linux-fsdevel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hch-jcswGhMUV9g@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Sample nfit data to test the kernel's handling of the multiple
flush-hint case.

Signed-off-by: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 tools/testing/nvdimm/test/nfit.c |   55 +++++++++++++++++++++++---------------
 1 file changed, 33 insertions(+), 22 deletions(-)

diff --git a/tools/testing/nvdimm/test/nfit.c b/tools/testing/nvdimm/test/nfit.c
index 4fdd139f6e6c..ff09a28890ed 100644
--- a/tools/testing/nvdimm/test/nfit.c
+++ b/tools/testing/nvdimm/test/nfit.c
@@ -98,6 +98,7 @@
 enum {
 	NUM_PM  = 3,
 	NUM_DCR = 5,
+	NUM_HINTS = 8,
 	NUM_BDW = NUM_DCR,
 	NUM_SPA = NUM_PM + NUM_DCR + NUM_BDW,
 	NUM_MEM = NUM_DCR + NUM_BDW + 2 /* spa0 iset */ + 4 /* spa1 iset */,
@@ -569,7 +570,8 @@ static int nfit_test0_alloc(struct nfit_test *t)
 			+ offsetof(struct acpi_nfit_control_region,
 					window_size) * NUM_DCR
 			+ sizeof(struct acpi_nfit_data_region) * NUM_BDW
-			+ sizeof(struct acpi_nfit_flush_address) * NUM_DCR;
+			+ (sizeof(struct acpi_nfit_flush_address)
+					+ sizeof(u64) * NUM_HINTS) * NUM_DCR;
 	int i;
 
 	t->nfit_buf = test_alloc(t, nfit_size, &t->nfit_dma);
@@ -599,7 +601,8 @@ static int nfit_test0_alloc(struct nfit_test *t)
 			return -ENOMEM;
 		sprintf(t->label[i], "label%d", i);
 
-		t->flush[i] = test_alloc(t, 8, &t->flush_dma[i]);
+		t->flush[i] = test_alloc(t, sizeof(u64) * NUM_HINTS,
+				&t->flush_dma[i]);
 		if (!t->flush[i])
 			return -ENOMEM;
 	}
@@ -633,6 +636,8 @@ static int nfit_test1_alloc(struct nfit_test *t)
 
 static void nfit_test0_setup(struct nfit_test *t)
 {
+	const int flush_hint_size = sizeof(struct acpi_nfit_flush_address)
+		+ (sizeof(u64) * NUM_HINTS);
 	struct acpi_nfit_desc *acpi_desc;
 	struct acpi_nfit_memory_map *memdev;
 	void *nfit_buf = t->nfit_buf;
@@ -640,7 +645,7 @@ static void nfit_test0_setup(struct nfit_test *t)
 	struct acpi_nfit_control_region *dcr;
 	struct acpi_nfit_data_region *bdw;
 	struct acpi_nfit_flush_address *flush;
-	unsigned int offset;
+	unsigned int offset, i;
 
 	/*
 	 * spa0 (interleave first half of dimm0 and dimm1, note storage
@@ -1126,37 +1131,41 @@ static void nfit_test0_setup(struct nfit_test *t)
 	/* flush0 (dimm0) */
 	flush = nfit_buf + offset;
 	flush->header.type = ACPI_NFIT_TYPE_FLUSH_ADDRESS;
-	flush->header.length = sizeof(struct acpi_nfit_flush_address);
+	flush->header.length = flush_hint_size;
 	flush->device_handle = handle[0];
-	flush->hint_count = 1;
-	flush->hint_address[0] = t->flush_dma[0];
+	flush->hint_count = NUM_HINTS;
+	for (i = 0; i < NUM_HINTS; i++)
+		flush->hint_address[i] = t->flush_dma[0] + i * sizeof(u64);
 
 	/* flush1 (dimm1) */
-	flush = nfit_buf + offset + sizeof(struct acpi_nfit_flush_address) * 1;
+	flush = nfit_buf + offset + flush_hint_size * 1;
 	flush->header.type = ACPI_NFIT_TYPE_FLUSH_ADDRESS;
-	flush->header.length = sizeof(struct acpi_nfit_flush_address);
+	flush->header.length = flush_hint_size;
 	flush->device_handle = handle[1];
-	flush->hint_count = 1;
-	flush->hint_address[0] = t->flush_dma[1];
+	flush->hint_count = NUM_HINTS;
+	for (i = 0; i < NUM_HINTS; i++)
+		flush->hint_address[i] = t->flush_dma[1] + i * sizeof(u64);
 
 	/* flush2 (dimm2) */
-	flush = nfit_buf + offset + sizeof(struct acpi_nfit_flush_address) * 2;
+	flush = nfit_buf + offset + flush_hint_size  * 2;
 	flush->header.type = ACPI_NFIT_TYPE_FLUSH_ADDRESS;
-	flush->header.length = sizeof(struct acpi_nfit_flush_address);
+	flush->header.length = flush_hint_size;
 	flush->device_handle = handle[2];
-	flush->hint_count = 1;
-	flush->hint_address[0] = t->flush_dma[2];
+	flush->hint_count = NUM_HINTS;
+	for (i = 0; i < NUM_HINTS; i++)
+		flush->hint_address[i] = t->flush_dma[2] + i * sizeof(u64);
 
 	/* flush3 (dimm3) */
-	flush = nfit_buf + offset + sizeof(struct acpi_nfit_flush_address) * 3;
+	flush = nfit_buf + offset + flush_hint_size * 3;
 	flush->header.type = ACPI_NFIT_TYPE_FLUSH_ADDRESS;
-	flush->header.length = sizeof(struct acpi_nfit_flush_address);
+	flush->header.length = flush_hint_size;
 	flush->device_handle = handle[3];
-	flush->hint_count = 1;
-	flush->hint_address[0] = t->flush_dma[3];
+	flush->hint_count = NUM_HINTS;
+	for (i = 0; i < NUM_HINTS; i++)
+		flush->hint_address[i] = t->flush_dma[3] + i * sizeof(u64);
 
 	if (t->setup_hotplug) {
-		offset = offset + sizeof(struct acpi_nfit_flush_address) * 4;
+		offset = offset + flush_hint_size * 4;
 		/* dcr-descriptor4: blk */
 		dcr = nfit_buf + offset;
 		dcr->header.type = ACPI_NFIT_TYPE_CONTROL_REGION;
@@ -1285,10 +1294,12 @@ static void nfit_test0_setup(struct nfit_test *t)
 		/* flush3 (dimm4) */
 		flush = nfit_buf + offset;
 		flush->header.type = ACPI_NFIT_TYPE_FLUSH_ADDRESS;
-		flush->header.length = sizeof(struct acpi_nfit_flush_address);
+		flush->header.length = flush_hint_size;
 		flush->device_handle = handle[4];
-		flush->hint_count = 1;
-		flush->hint_address[0] = t->flush_dma[4];
+		flush->hint_count = NUM_HINTS;
+		for (i = 0; i < NUM_HINTS; i++)
+			flush->hint_address[i] = t->flush_dma[4]
+				+ i * sizeof(u64);
 	}
 
 	post_ars_status(&t->ars_state, t->spa_set_dma[0], SPA0_SIZE);
