From: Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 5/5] EDAC, skx_edac: Detect non-volatile DIMMs
Date: Thu, 22 Feb 2018 11:58:11 -0800
Message-ID: <20180222195811.27237-6-tony.luck@intel.com>
References: <20180222195811.27237-1-tony.luck@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <20180222195811.27237-1-tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: Borislav Petkov <bp-l3A5Bk7waGM@public.gmane.org>
Cc: Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org, Aristeu Rozanski <aris-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Qiuxu Zhuo <qiuxu.zhuo-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, Lv Zheng <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Mauro Carvalho Chehab <mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This just covers the topology function of the EDAC driver.
We locate which DIMM slots are populated with NVDIMMs and
query the NFIT and SMBIOS tables to get the size.

Signed-off-by: Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/edac/Kconfig    |  5 +++-
 drivers/edac/skx_edac.c | 68 ++++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 66 insertions(+), 7 deletions(-)

diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 3c4017007647..c12e34564557 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -232,9 +232,12 @@ config EDAC_SBRIDGE
 config EDAC_SKX
 	tristate "Intel Skylake server Integrated MC"
 	depends on PCI && X86_64 && X86_MCE_INTEL && PCI_MMCONFIG
+	select DMI
 	help
 	  Support for error detection and correction the Intel
-	  Skylake server Integrated Memory Controllers.
+	  Skylake server Integrated Memory Controllers. If your
+	  system has non-volatile DIMMs you should also manually
+	  select CONFIG_ACPI_NFIT
 
 config EDAC_PND2
 	tristate "Intel Pondicherry2"
diff --git a/drivers/edac/skx_edac.c b/drivers/edac/skx_edac.c
index 912c4930c9ef..f34c60638c4b 100644
--- a/drivers/edac/skx_edac.c
+++ b/drivers/edac/skx_edac.c
@@ -14,6 +14,8 @@
 
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/acpi.h>
+#include <linux/dmi.h>
 #include <linux/pci.h>
 #include <linux/pci_ids.h>
 #include <linux/slab.h>
@@ -24,6 +26,7 @@
 #include <linux/bitmap.h>
 #include <linux/math64.h>
 #include <linux/mod_devicetable.h>
+#include <acpi/nfit.h>
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
 #include <asm/processor.h>
@@ -302,6 +305,7 @@ static int get_dimm_attr(u32 reg, int lobit, int hibit, int add, int minval,
 }
 
 #define IS_DIMM_PRESENT(mtr)		GET_BITFIELD((mtr), 15, 15)
+#define IS_NVDIMM_PRESENT(mcddrtcfg, i)	GET_BITFIELD((mcddrtcfg), (i), (i))
 
 #define numrank(reg) get_dimm_attr((reg), 12, 13, 0, 0, 2, "ranks")
 #define numrow(reg) get_dimm_attr((reg), 2, 4, 12, 1, 6, "rows")
@@ -350,8 +354,6 @@ static int get_dimm_info(u32 mtr, u32 amap, struct dimm_info *dimm,
 	int  banks = 16, ranks, rows, cols, npages;
 	u64 size;
 
-	if (!IS_DIMM_PRESENT(mtr))
-		return 0;
 	ranks = numrank(mtr);
 	rows = numrow(mtr);
 	cols = numcol(mtr);
@@ -383,6 +385,55 @@ static int get_dimm_info(u32 mtr, u32 amap, struct dimm_info *dimm,
 	return 1;
 }
 
+static int get_nvdimm_info(struct dimm_info *dimm, struct skx_imc *imc,
+			   int chan, int dimmno)
+{
+	int smbios_handle;
+	u32 dev_handle;
+	u16 flags;
+	u64 size = 0;
+
+	dev_handle = ACPI_NFIT_BUILD_DEVICE_HANDLE(dimmno, chan, imc->lmc,
+						   imc->src_id, 0);
+
+	smbios_handle = nfit_get_smbios_id(dev_handle, &flags);
+	if (smbios_handle == -EOPNOTSUPP) {
+		pr_warn_once("skx_edac: can't find size of NVDIMM. Try enabling CONFIG_ACPI_NFIT\n");
+		goto unknown_size;
+	}
+	if (smbios_handle < 0) {
+		skx_printk(KERN_ERR, "Can't find handle for NVDIMM ADR=%x\n", dev_handle);
+		return 0;
+	}
+
+	if (flags & ACPI_NFIT_MEM_MAP_FAILED) {
+		skx_printk(KERN_ERR, "NVDIMM ADR=%x is not mapped\n", dev_handle);
+		return 0;
+	}
+
+	size = dmi_memdev_size(smbios_handle);
+	if (size == ~0ul) {
+		skx_printk(KERN_ERR, "Can't find size for NVDIMM ADR=%x/SMBIOS=%x\n",
+			   dev_handle, smbios_handle);
+		return 0;
+	}
+
+unknown_size:
+	edac_dbg(0, "mc#%d: channel %d, dimm %d, %lld Mb (%lld pages)\n",
+		 imc->mc, chan, dimmno, size >> 20, size >> PAGE_SHIFT);
+
+	dimm->nr_pages = size >> PAGE_SHIFT;
+	dimm->grain = 32;
+	dimm->dtype = DEV_UNKNOWN;
+	dimm->mtype = MEM_NVDIMM;
+	dimm->edac_mode = EDAC_SECDED; /* likely better than this */
+
+	snprintf(dimm->label, sizeof(dimm->label), "CPU_SrcID#%u_MC#%u_Chan#%u_DIMM#%u",
+		 imc->src_id, imc->lmc, chan, dimmno);
+
+	return 1;
+}
+
 #define SKX_GET_MTMTR(dev, reg) \
 	pci_read_config_dword((dev), 0x87c, &reg)
 
@@ -399,20 +450,24 @@ static int skx_get_dimm_config(struct mem_ctl_info *mci)
 {
 	struct skx_pvt *pvt = mci->pvt_info;
 	struct skx_imc *imc = pvt->imc;
+	u32 mtr, amap, mcddrtcfg;
 	struct dimm_info *dimm;
 	int i, j;
-	u32 mtr, amap;
 	int ndimms;
 
 	for (i = 0; i < NUM_CHANNELS; i++) {
 		ndimms = 0;
 		pci_read_config_dword(imc->chan[i].cdev, 0x8C, &amap);
+		pci_read_config_dword(imc->chan[i].cdev, 0x400, &mcddrtcfg);
 		for (j = 0; j < NUM_DIMMS; j++) {
 			dimm = EDAC_DIMM_PTR(mci->layers, mci->dimms,
 					     mci->n_layers, i, j, 0);
 			pci_read_config_dword(imc->chan[i].cdev,
 					0x80 + 4*j, &mtr);
-			ndimms += get_dimm_info(mtr, amap, dimm, imc, i, j);
+			if (IS_DIMM_PRESENT(mtr))
+				ndimms += get_dimm_info(mtr, amap, dimm, imc, i, j);
+			else if (IS_NVDIMM_PRESENT(mcddrtcfg, j))
+				ndimms += get_nvdimm_info(dimm, imc, i, j);
 		}
 		if (ndimms && !skx_check_ecc(imc->chan[0].cdev)) {
 			skx_printk(KERN_ERR, "ECC is disabled on imc %d\n", imc->mc);
@@ -468,13 +523,14 @@ static int skx_register_mci(struct skx_imc *imc)
 	pvt = mci->pvt_info;
 	pvt->imc = imc;
 
-	mci->ctl_name = kasprintf(GFP_KERNEL, "Skylake Socket#%d IMC#%d", imc->node_id, imc->lmc);
+	mci->ctl_name = kasprintf(GFP_KERNEL, "Skylake Socket#%d IMC#%d",
+				  imc->node_id, imc->lmc);
 	if (!mci->ctl_name) {
 		rc = -ENOMEM;
 		goto fail0;
 	}
 
-	mci->mtype_cap = MEM_FLAG_DDR4;
+	mci->mtype_cap = MEM_FLAG_DDR4 | MEM_FLAG_NVDIMM;
 	mci->edac_ctl_cap = EDAC_FLAG_NONE;
 	mci->edac_cap = EDAC_FLAG_NONE;
 	mci->mod_name = EDAC_MOD_STR;
-- 
2.14.1
