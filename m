From: Ocean He <oceanhehy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] ACPI: nfit: check dcr immediately following its assignment
 codes
Date: Wed,  8 Aug 2018 10:50:21 -0400
Message-ID: <1533739821-9864-1-git-send-email-oceanhehy@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ross.zwisler-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, vishal.l.verma-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dave.jiang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ocean He <hehy1-6jq1YtArVR3QT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

From: Ocean He <hehy1-6jq1YtArVR3QT0dZR+AlfA@public.gmane.org>

In commit 6697b2cf69d43632 ("nfit: fix multi-interface dimm handling,
acpi6.1 compatibility"), the check codes of dcr were just following its
assignment codes. But they were separated by commit ad9ac5e1957531a8
("nfit: always associate flush hints").

Just change the check codes back to original position, without function
change.

Signed-off-by: Ocean He <hehy1-6jq1YtArVR3QT0dZR+AlfA@public.gmane.org>
---
 drivers/acpi/nfit/core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 7c47900..c9e4c9a 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -1078,6 +1078,12 @@ static int __nfit_mem_init(struct acpi_nfit_desc *acpi_desc,
 			break;
 		}
 
+		if (dcr && !nfit_mem->dcr) {
+			dev_err(acpi_desc->dev, "SPA %d missing DCR %d\n",
+					spa->range_index, dcr);
+			return -ENODEV;
+		}
+
 		list_for_each_entry(nfit_flush, &acpi_desc->flushes, list) {
 			struct acpi_nfit_flush_address *flush;
 			u16 i;
@@ -1101,12 +1107,6 @@ static int __nfit_mem_init(struct acpi_nfit_desc *acpi_desc,
 			break;
 		}
 
-		if (dcr && !nfit_mem->dcr) {
-			dev_err(acpi_desc->dev, "SPA %d missing DCR %d\n",
-					spa->range_index, dcr);
-			return -ENODEV;
-		}
-
 		if (type == NFIT_SPA_DCR) {
 			struct nfit_idt *nfit_idt;
 			u16 idt_idx;
-- 
1.8.3.1
