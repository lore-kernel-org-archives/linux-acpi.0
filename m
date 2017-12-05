From: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Subject: Re: [RFC PATCH 4/4] EDAC, skx_edac: Detect non-volatile DIMMs
Date: Tue, 5 Dec 2017 11:54:51 +0100
Message-ID: <20171205105451.ob23asixm726hysb@pd.tnic>
References: <cover.1512070562.git.tony.luck@intel.com>
 <da4c989314e82ec29195804ba5349ac3136f74c0.1512070562.git.tony.luck@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <da4c989314e82ec29195804ba5349ac3136f74c0.1512070562.git.tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org, Mauro Carvalho Chehab <mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Aristeu Rozanski <aris-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Qiuxu Zhuo <qiuxu.zhuo-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Lv Zheng <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-edac-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Nov 30, 2017 at 12:40:42PM -0800, Tony Luck wrote:
> This just covers the topology function of the EDAC driver.
> We locate which DIMM slots are populated with NVDIMMs and
> query the NFIT and SMBIOS tables to get the size.
> 
> Signed-off-by: Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/edac/Kconfig    |  2 ++
>  drivers/edac/skx_edac.c | 56 ++++++++++++++++++++++++++++++++++++++++++++-----
>  2 files changed, 53 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> index 96afb2aeed18..5c0c4a358f67 100644
> --- a/drivers/edac/Kconfig
> +++ b/drivers/edac/Kconfig
> @@ -232,6 +232,8 @@ config EDAC_SBRIDGE
>  config EDAC_SKX
>  	tristate "Intel Skylake server Integrated MC"
>  	depends on PCI && X86_64 && X86_MCE_INTEL && PCI_MMCONFIG
> +	select DMI
> +	select ACPI_NFIT

Hmm, that ACPI_NFIT depends on a bunch of stuff and enabling EDAC_SKX
would pull in all that. Should we make this a user choice instead?

I mean, there could be boxes which don't have nvdimms so all that code
would be dead weight there...

>  	help
>  	  Support for error detection and correction the Intel
>  	  Skylake server Integrated Memory Controllers.
> diff --git a/drivers/edac/skx_edac.c b/drivers/edac/skx_edac.c
> index 16dea97568a1..814a5245029c 100644
> --- a/drivers/edac/skx_edac.c
> +++ b/drivers/edac/skx_edac.c
> @@ -14,6 +14,8 @@
>  
>  #include <linux/module.h>
>  #include <linux/init.h>
> +#include <linux/acpi.h>
> +#include <linux/dmi.h>
>  #include <linux/pci.h>
>  #include <linux/pci_ids.h>
>  #include <linux/slab.h>
> @@ -24,6 +26,7 @@
>  #include <linux/bitmap.h>
>  #include <linux/math64.h>
>  #include <linux/mod_devicetable.h>
> +#include <acpi/nfit.h>
>  #include <asm/cpu_device_id.h>
>  #include <asm/intel-family.h>
>  #include <asm/processor.h>
> @@ -298,6 +301,7 @@ static int get_dimm_attr(u32 reg, int lobit, int hibit, int add, int minval,
>  }
>  
>  #define IS_DIMM_PRESENT(mtr)		GET_BITFIELD((mtr), 15, 15)
> +#define IS_NVDIMM_PRESENT(mcddrtcfg, i)	GET_BITFIELD((mcddrtcfg), (i), (i))
>  
>  #define numrank(reg) get_dimm_attr((reg), 12, 13, 0, 1, 2, "ranks")
>  #define numrow(reg) get_dimm_attr((reg), 2, 4, 12, 1, 6, "rows")
> @@ -346,8 +350,6 @@ static int get_dimm_info(u32 mtr, u32 amap, struct dimm_info *dimm,
>  	int  banks = 16, ranks, rows, cols, npages;
>  	u64 size;
>  
> -	if (!IS_DIMM_PRESENT(mtr))
> -		return 0;
>  	ranks = numrank(mtr);
>  	rows = numrow(mtr);
>  	cols = numcol(mtr);
> @@ -379,6 +381,46 @@ static int get_dimm_info(u32 mtr, u32 amap, struct dimm_info *dimm,
>  	return 1;
>  }
>  
> +static int get_nvdimm_info(struct dimm_info *dimm, struct skx_imc *imc,
> +			   int chan, int dimmno)
> +{
> +	int smbios_handle;
> +	u32 dev_handle;
> +	u16 flags;
> +	u64 size;
> +
> +	dev_handle = ACPI_NFIT_BUILD_DEVICE_HANDLE(dimmno, chan, imc->lmc,
> +						   imc->src_id, 0);
> +
> +	smbios_handle = nfit_get_smbios_id(dev_handle, &flags);
> +	if (smbios_handle < 0) {
> +		skx_printk(KERN_ERR, "Can't find handle for NVDIMM ADR=%x\n", dev_handle);
> +		return 0;
> +	}

<---- newline here.

> +	if (flags & ACPI_NFIT_MEM_MAP_FAILED) {
> +		skx_printk(KERN_ERR, "NVDIMM ADR=%x is not mapped\n", dev_handle);
> +		return 0;
> +	}

<---- newline here.

> +	size = dmi_memdev_size(smbios_handle);
> +	if (size == ~0ul) {
> +		skx_printk(KERN_ERR, "Can't find size for NVDIMM ADR=%x/SMBIOS=%x\n",
> +			   dev_handle, smbios_handle);
> +		return 0;
> +	}

Ditto.

> +	edac_dbg(0, "mc#%d: channel %d, dimm %d, %lld Mb (%lld pages)\n",
> +		 imc->mc, chan, dimmno, size >> 20, size >> PAGE_SHIFT);
> +
> +	dimm->nr_pages = size >> PAGE_SHIFT;
> +	dimm->grain = 32;
> +	dimm->dtype = DEV_UNKNOWN;
> +	dimm->mtype = MEM_NVDIMM;
> +	dimm->edac_mode = EDAC_SECDED; /* likely better than this */

Ditto.

/me hands aegl a bunch of newlines - seems he's all out of \n's

> +	snprintf(dimm->label, sizeof(dimm->label), "CPU_SrcID#%u_MC#%u_Chan#%u_DIMM#%u",
> +		 imc->src_id, imc->lmc, chan, dimmno);
> +
> +	return 1;
> +}
> +
>  #define SKX_GET_MTMTR(dev, reg) \
>  	pci_read_config_dword((dev), 0x87c, &reg)

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
