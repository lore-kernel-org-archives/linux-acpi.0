From: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 3/5] tools/testing/nvdimm: test acpi 6.1 health state flags
Date: Fri, 14 Apr 2017 09:58:27 -0700
Message-ID: <149218910710.3926.17481274995820010446.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <149218909065.3926.1234846095650907678.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <149218909065.3926.1234846095650907678.stgit-p8uTFz9XbKj2zm6wflaqv1nYeNYlB/vhral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
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
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Add a simulated dimm with an ACPI_NFIT_MEM_MAP_FAILED indication, and
set the ACPI_NFIT_MEM_HEALTH_ENABLED flag on all the dimms where
nfit_test simulates health events, but spread it out over several
redundant memdev entries to test that the nfit driver coalesces all the
flags.

Signed-off-by: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 tools/testing/nvdimm/test/nfit.c |   40 +++++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/tools/testing/nvdimm/test/nfit.c b/tools/testing/nvdimm/test/nfit.c
index 798f17655433..bc02f28ed8b8 100644
--- a/tools/testing/nvdimm/test/nfit.c
+++ b/tools/testing/nvdimm/test/nfit.c
@@ -132,6 +132,7 @@ static u32 handle[] = {
 	[3] = NFIT_DIMM_HANDLE(0, 0, 1, 0, 1),
 	[4] = NFIT_DIMM_HANDLE(0, 1, 0, 0, 0),
 	[5] = NFIT_DIMM_HANDLE(1, 0, 0, 0, 0),
+	[6] = NFIT_DIMM_HANDLE(1, 0, 0, 0, 1),
 };
 
 static unsigned long dimm_fail_cmd_flags[NUM_DCR];
@@ -728,8 +729,8 @@ static int nfit_test0_alloc(struct nfit_test *t)
 static int nfit_test1_alloc(struct nfit_test *t)
 {
 	size_t nfit_size = sizeof(struct acpi_nfit_system_address) * 2
-		+ sizeof(struct acpi_nfit_memory_map)
-		+ offsetof(struct acpi_nfit_control_region, window_size);
+		+ sizeof(struct acpi_nfit_memory_map) * 2
+		+ offsetof(struct acpi_nfit_control_region, window_size) * 2;
 	int i;
 
 	t->nfit_buf = test_alloc(t, nfit_size, &t->nfit_dma);
@@ -906,6 +907,7 @@ static void nfit_test0_setup(struct nfit_test *t)
 	memdev->address = 0;
 	memdev->interleave_index = 0;
 	memdev->interleave_ways = 2;
+	memdev->flags = ACPI_NFIT_MEM_HEALTH_ENABLED;
 
 	/* mem-region2 (spa1, dimm0) */
 	memdev = nfit_buf + offset + sizeof(struct acpi_nfit_memory_map) * 2;
@@ -921,6 +923,7 @@ static void nfit_test0_setup(struct nfit_test *t)
 	memdev->address = SPA0_SIZE/2;
 	memdev->interleave_index = 0;
 	memdev->interleave_ways = 4;
+	memdev->flags = ACPI_NFIT_MEM_HEALTH_ENABLED;
 
 	/* mem-region3 (spa1, dimm1) */
 	memdev = nfit_buf + offset + sizeof(struct acpi_nfit_memory_map) * 3;
@@ -951,6 +954,7 @@ static void nfit_test0_setup(struct nfit_test *t)
 	memdev->address = SPA0_SIZE/2;
 	memdev->interleave_index = 0;
 	memdev->interleave_ways = 4;
+	memdev->flags = ACPI_NFIT_MEM_HEALTH_ENABLED;
 
 	/* mem-region5 (spa1, dimm3) */
 	memdev = nfit_buf + offset + sizeof(struct acpi_nfit_memory_map) * 5;
@@ -1086,6 +1090,7 @@ static void nfit_test0_setup(struct nfit_test *t)
 	memdev->address = 0;
 	memdev->interleave_index = 0;
 	memdev->interleave_ways = 1;
+	memdev->flags = ACPI_NFIT_MEM_HEALTH_ENABLED;
 
 	offset = offset + sizeof(struct acpi_nfit_memory_map) * 14;
 	/* dcr-descriptor0: blk */
@@ -1384,6 +1389,7 @@ static void nfit_test0_setup(struct nfit_test *t)
 		memdev->address = 0;
 		memdev->interleave_index = 0;
 		memdev->interleave_ways = 1;
+		memdev->flags = ACPI_NFIT_MEM_HEALTH_ENABLED;
 
 		/* mem-region16 (spa/bdw4, dimm4) */
 		memdev = nfit_buf + offset +
@@ -1486,6 +1492,34 @@ static void nfit_test1_setup(struct nfit_test *t)
 	dcr->code = NFIT_FIC_BYTE;
 	dcr->windows = 0;
 
+	offset += dcr->header.length;
+	memdev = nfit_buf + offset;
+	memdev->header.type = ACPI_NFIT_TYPE_MEMORY_MAP;
+	memdev->header.length = sizeof(*memdev);
+	memdev->device_handle = handle[6];
+	memdev->physical_id = 0;
+	memdev->region_id = 0;
+	memdev->range_index = 0;
+	memdev->region_index = 0+2;
+	memdev->region_size = SPA2_SIZE;
+	memdev->region_offset = 0;
+	memdev->address = 0;
+	memdev->interleave_index = 0;
+	memdev->interleave_ways = 1;
+	memdev->flags = ACPI_NFIT_MEM_MAP_FAILED;
+
+	/* dcr-descriptor1 */
+	offset += sizeof(*memdev);
+	dcr = nfit_buf + offset;
+	dcr->header.type = ACPI_NFIT_TYPE_CONTROL_REGION;
+	dcr->header.length = offsetof(struct acpi_nfit_control_region,
+			window_size);
+	dcr->region_index = 0+2;
+	dcr_common_init(dcr);
+	dcr->serial_number = ~handle[6];
+	dcr->code = NFIT_FIC_BYTE;
+	dcr->windows = 0;
+
 	post_ars_status(&t->ars_state, t->spa_set_dma[0], SPA2_SIZE);
 
 	acpi_desc = &t->acpi_desc;
@@ -1907,7 +1941,7 @@ static __init int nfit_test_init(void)
 		case 1:
 			nfit_test->num_pm = 1;
 			nfit_test->dcr_idx = NUM_DCR;
-			nfit_test->num_dcr = 1;
+			nfit_test->num_dcr = 2;
 			nfit_test->alloc = nfit_test1_alloc;
 			nfit_test->setup = nfit_test1_setup;
 			break;
