From: Dave Jiang <dave.jiang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v3 4/4] nfit-test: Add platform cap support from ACPI 6.2a
 to test
Date: Tue, 30 Jan 2018 17:01:29 -0700
Message-ID: <151735688977.34477.282640453822790328.stgit@djiang5-desk3.ch.intel.com>
References: <151735668391.34477.11820724492631561208.stgit@djiang5-desk3.ch.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <151735668391.34477.11820724492631561208.stgit-Cxk7aZI4ujnJARH06PadV2t3HXsI98Cx0E9HWUfgJXw@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ross.zwisler-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Adding NFIT platform capabilities sub table in nfit_test simulated ACPI
NFIT table. Only the first NFIT table is added with the capability
sub-table.

Signed-off-by: Dave Jiang <dave.jiang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
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
