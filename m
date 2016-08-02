From: Ross Zwisler <ross.zwisler-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v2] libnvdimm, nd_blk: mask off reserved status bits
Date: Tue,  2 Aug 2016 12:26:53 -0600
Message-ID: <20160802182653.6647-1-ross.zwisler@linux.intel.com>
References: <20160729205912.20436-1-ross.zwisler@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <20160729205912.20436-1-ross.zwisler-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "Lee,
 Chun-Yi" <jlee-IBi9RG/b67k@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org#v4.2+, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

The "NVDIMM Block Window Driver Writer's Guide":

http://pmem.io/documents/
http://pmem.io/documents/NVDIMM_DriverWritersGuide-July-2016.pdf

defines the layout of the block window status register.  For the July 2016
version of the spec linked to above, this happens in Figure 4 on page 26.

The only bits defined in this spec are bits 31, 5, 4, 2, 1 and 0.  The rest
of the bits in the status register are reserved, and there is a warning
following the diagram that says:

  Note: The driver cannot assume the value of the RESERVED bits in the
  status register are zero. These reserved bits need to be masked off, and
  the driver must avoid checking the state of those bits.

This change ensures that for hardware implementations that set these
reserved bits in the status register, the driver won't incorrectly fail the
block I/Os.

Signed-off-by: Ross Zwisler <ross.zwisler-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Reviewed-by: Lee, Chun-Yi <jlee-IBi9RG/b67k@public.gmane.org>
Cc: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org # v4.2+
---

Changes from V1:
 - Rebased onto the v4.8 merge tree.  As Joey points out the ND BLK code
   recently moved from drivers/acpi/nfit.c to drivers/acpi/nfit/core.c.
   Since we were in the merge window for v4.8 I didn't know what to use as
   a baseline, so I just used v4.7, which was apparently incorrect.  Sorry
   about that.

 - Added Joey's reviewed-by.

For stable kernels v4.2 and beyond the v1 patch for drivers/acpi/nfit.c
applies cleanly and should be used.

---
 drivers/acpi/nfit/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 8c234dd..80cc7c0 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -1527,11 +1527,12 @@ static u32 read_blk_stat(struct nfit_blk *nfit_blk, unsigned int bw)
 {
 	struct nfit_blk_mmio *mmio = &nfit_blk->mmio[DCR];
 	u64 offset = nfit_blk->stat_offset + mmio->size * bw;
+	const u32 STATUS_MASK = 0x80000037;
 
 	if (mmio->num_lines)
 		offset = to_interleave_offset(offset, mmio);
 
-	return readl(mmio->addr.base + offset);
+	return readl(mmio->addr.base + offset) & STATUS_MASK;
 }
 
 static void write_blk_ctl(struct nfit_blk *nfit_blk, unsigned int bw,
-- 
2.9.0
