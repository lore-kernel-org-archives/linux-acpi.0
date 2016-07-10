From: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 01/17] nfit: always associate flush hints
Date: Sat, 09 Jul 2016 20:24:34 -0700
Message-ID: <146812107483.32932.3652950504167218008.stgit@dwillia2-desk3.amr.corp.intel.com>
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

Before enabling use of flush hints for pmem regions, we need to make
sure they are always associated.  Move the initialization of nfit_flush
out of the block-window specific init path to the general init path.

Cc: Ross Zwisler <ross.zwisler-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/acpi/nfit.c |   17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/nfit.c b/drivers/acpi/nfit.c
index 3e54157f02cc..d79837b9d07e 100644
--- a/drivers/acpi/nfit.c
+++ b/drivers/acpi/nfit.c
@@ -614,7 +614,6 @@ static void nfit_mem_init_bdw(struct acpi_nfit_desc *acpi_desc,
 {
 	u16 dcr = __to_nfit_memdev(nfit_mem)->region_index;
 	struct nfit_memdev *nfit_memdev;
-	struct nfit_flush *nfit_flush;
 	struct nfit_bdw *nfit_bdw;
 	struct nfit_idt *nfit_idt;
 	u16 idt_idx, range_index;
@@ -647,14 +646,6 @@ static void nfit_mem_init_bdw(struct acpi_nfit_desc *acpi_desc,
 			nfit_mem->idt_bdw = nfit_idt->idt;
 			break;
 		}
-
-		list_for_each_entry(nfit_flush, &acpi_desc->flushes, list) {
-			if (nfit_flush->flush->device_handle !=
-					nfit_memdev->memdev->device_handle)
-				continue;
-			nfit_mem->nfit_flush = nfit_flush;
-			break;
-		}
 		break;
 	}
 }
@@ -675,6 +666,7 @@ static int nfit_mem_dcr_init(struct acpi_nfit_desc *acpi_desc,
 	}
 
 	list_for_each_entry(nfit_memdev, &acpi_desc->memdevs, list) {
+		struct nfit_flush *nfit_flush;
 		struct nfit_dcr *nfit_dcr;
 		u32 device_handle;
 		u16 dcr;
@@ -721,6 +713,13 @@ static int nfit_mem_dcr_init(struct acpi_nfit_desc *acpi_desc,
 			break;
 		}
 
+		list_for_each_entry(nfit_flush, &acpi_desc->flushes, list) {
+			if (nfit_flush->flush->device_handle != device_handle)
+				continue;
+			nfit_mem->nfit_flush = nfit_flush;
+			break;
+		}
+
 		if (dcr && !nfit_mem->dcr) {
 			dev_err(acpi_desc->dev, "SPA %d missing DCR %d\n",
 					spa->range_index, dcr);
