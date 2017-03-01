From: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/2] tools/testing/nvdimm: make iset cookie predictable
Date: Wed, 01 Mar 2017 01:11:24 -0800
Message-ID: <148835948457.28806.60862861470412098.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <148835947931.28806.15339584183213827869.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <148835947931.28806.15339584183213827869.stgit-p8uTFz9XbKj2zm6wflaqv1nYeNYlB/vhral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
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
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

For testing changes to the iset cookie algorithm we need a value that is
constant from run-to-run.

Stop including dynamic data in the emulated region_offset values. Also,
pick values that sort in a different order depending on whether the
comparison is a memcmp() of two 8-byte arrays or subtraction of two
64-bit values.

Signed-off-by: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 tools/testing/nvdimm/test/nfit.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/testing/nvdimm/test/nfit.c b/tools/testing/nvdimm/test/nfit.c
index 45be8b55a663..798f17655433 100644
--- a/tools/testing/nvdimm/test/nfit.c
+++ b/tools/testing/nvdimm/test/nfit.c
@@ -887,7 +887,7 @@ static void nfit_test0_setup(struct nfit_test *t)
 	memdev->range_index = 0+1;
 	memdev->region_index = 4+1;
 	memdev->region_size = SPA0_SIZE/2;
-	memdev->region_offset = t->spa_set_dma[0];
+	memdev->region_offset = 1;
 	memdev->address = 0;
 	memdev->interleave_index = 0;
 	memdev->interleave_ways = 2;
@@ -902,7 +902,7 @@ static void nfit_test0_setup(struct nfit_test *t)
 	memdev->range_index = 0+1;
 	memdev->region_index = 5+1;
 	memdev->region_size = SPA0_SIZE/2;
-	memdev->region_offset = t->spa_set_dma[0] + SPA0_SIZE/2;
+	memdev->region_offset = (1 << 8);
 	memdev->address = 0;
 	memdev->interleave_index = 0;
 	memdev->interleave_ways = 2;
@@ -917,7 +917,7 @@ static void nfit_test0_setup(struct nfit_test *t)
 	memdev->range_index = 1+1;
 	memdev->region_index = 4+1;
 	memdev->region_size = SPA1_SIZE/4;
-	memdev->region_offset = t->spa_set_dma[1];
+	memdev->region_offset = (1 << 16);
 	memdev->address = SPA0_SIZE/2;
 	memdev->interleave_index = 0;
 	memdev->interleave_ways = 4;
@@ -932,7 +932,7 @@ static void nfit_test0_setup(struct nfit_test *t)
 	memdev->range_index = 1+1;
 	memdev->region_index = 5+1;
 	memdev->region_size = SPA1_SIZE/4;
-	memdev->region_offset = t->spa_set_dma[1] + SPA1_SIZE/4;
+	memdev->region_offset = (1 << 24);
 	memdev->address = SPA0_SIZE/2;
 	memdev->interleave_index = 0;
 	memdev->interleave_ways = 4;
@@ -947,7 +947,7 @@ static void nfit_test0_setup(struct nfit_test *t)
 	memdev->range_index = 1+1;
 	memdev->region_index = 6+1;
 	memdev->region_size = SPA1_SIZE/4;
-	memdev->region_offset = t->spa_set_dma[1] + 2*SPA1_SIZE/4;
+	memdev->region_offset = (1ULL << 32);
 	memdev->address = SPA0_SIZE/2;
 	memdev->interleave_index = 0;
 	memdev->interleave_ways = 4;
@@ -962,7 +962,7 @@ static void nfit_test0_setup(struct nfit_test *t)
 	memdev->range_index = 1+1;
 	memdev->region_index = 7+1;
 	memdev->region_size = SPA1_SIZE/4;
-	memdev->region_offset = t->spa_set_dma[1] + 3*SPA1_SIZE/4;
+	memdev->region_offset = (1ULL << 40);
 	memdev->address = SPA0_SIZE/2;
 	memdev->interleave_index = 0;
 	memdev->interleave_ways = 4;
@@ -1380,7 +1380,7 @@ static void nfit_test0_setup(struct nfit_test *t)
 		memdev->range_index = 11+1;
 		memdev->region_index = 9+1;
 		memdev->region_size = SPA0_SIZE;
-		memdev->region_offset = t->spa_set_dma[2];
+		memdev->region_offset = (1ULL << 48);
 		memdev->address = 0;
 		memdev->interleave_index = 0;
 		memdev->interleave_ways = 1;
