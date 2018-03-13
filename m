From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH 5/5] EDAC, skx_edac: Detect non-volatile DIMMs
Date: Tue, 13 Mar 2018 10:59:01 +0100
Message-ID: <20180313105901.0f18d027@endymion>
References: <CAPcyv4iHr9nUAS0SiFeqqDkU8NXZ_x=rkD3YS010Dy-nbHJXmA@mail.gmail.com>
 <20180312182430.10335-1-tony.luck@intel.com>
 <20180312182430.10335-6-tony.luck@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <20180312182430.10335-6-tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
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
Cc: Mauro Carvalho Chehab <mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Qiuxu Zhuo <qiuxu.zhuo-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, Aristeu Rozanski <aris-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Borislav Petkov <bp-l3A5Bk7waGM@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Tony,

On Mon, 12 Mar 2018 11:24:30 -0700, Tony Luck wrote:
> This just covers the topology function of the EDAC driver.
> We locate which DIMM slots are populated with NVDIMMs and
> query the NFIT and SMBIOS tables to get the size.
> 
> Signed-off-by: Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/edac/Kconfig    |  5 +++-
>  drivers/edac/skx_edac.c | 66 ++++++++++++++++++++++++++++++++++++++++++++-----
>  2 files changed, 64 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> index 3c4017007647..c12e34564557 100644
> --- a/drivers/edac/Kconfig
> +++ b/drivers/edac/Kconfig
> @@ -232,9 +232,12 @@ config EDAC_SBRIDGE
>  config EDAC_SKX
>  	tristate "Intel Skylake server Integrated MC"
>  	depends on PCI && X86_64 && X86_MCE_INTEL && PCI_MMCONFIG
> +	select DMI
>  	help
>  	  Support for error detection and correction the Intel
> -	  Skylake server Integrated Memory Controllers.
> +	  Skylake server Integrated Memory Controllers. If your
> +	  system has non-volatile DIMMs you should also manually
> +	  select CONFIG_ACPI_NFIT

Nitpicking: trailing dot is missing.

>  
>  config EDAC_PND2
>  	tristate "Intel Pondicherry2"
> diff --git a/drivers/edac/skx_edac.c b/drivers/edac/skx_edac.c
> index 912c4930c9ef..84c18bb1e0cd 100644
> --- a/drivers/edac/skx_edac.c
> +++ b/drivers/edac/skx_edac.c
> (...)
> +static int get_nvdimm_info(struct dimm_info *dimm, struct skx_imc *imc,
> +			   int chan, int dimmno)
> +{
> +	int smbios_handle;
> +	u32 dev_handle;
> +	u16 flags;
> +	u64 size = 0;
> +
> +	dev_handle = ACPI_NFIT_BUILD_DEVICE_HANDLE(dimmno, chan, imc->lmc,
> +						   imc->src_id, 0);
> +
> +	smbios_handle = nfit_get_smbios_id(dev_handle, &flags);
> +	if (smbios_handle == -EOPNOTSUPP) {
> +		pr_warn_once("skx_edac: can't find size of NVDIMM. Try enabling CONFIG_ACPI_NFIT\n");
> +		goto unknown_size;
> +	}
> +	if (smbios_handle < 0) {
> +		skx_printk(KERN_ERR, "Can't find handle for NVDIMM ADR=%x\n", dev_handle);
> +		goto unknown_size;
> +	}
> +
> +	if (flags & ACPI_NFIT_MEM_MAP_FAILED) {
> +		skx_printk(KERN_ERR, "NVDIMM ADR=%x is not mapped\n", dev_handle);
> +		goto unknown_size;
> +	}
> +
> +	size = dmi_memdev_size(smbios_handle);
> +	if (size == ~0ull)
> +		skx_printk(KERN_ERR, "Can't find size for NVDIMM ADR=%x/SMBIOS=%x\n",
> +			   dev_handle, smbios_handle);
> +
> +unknown_size:
> +	dimm->nr_pages = size >> PAGE_SHIFT;
> +	dimm->grain = 32;
> +	dimm->dtype = DEV_UNKNOWN;
> +	dimm->mtype = MEM_NVDIMM;
> +	dimm->edac_mode = EDAC_SECDED; /* likely better than this */
> +
> +	edac_dbg(0, "mc#%d: channel %d, dimm %d, %llu Mb (%u pages)\n",

I did not notice on previous review, but I think "b" in general means
bit not byte, so "MB" would be better.

> +		 imc->mc, chan, dimmno, size >> 20, dimm->nr_pages);
> +
> +	snprintf(dimm->label, sizeof(dimm->label), "CPU_SrcID#%u_MC#%u_Chan#%u_DIMM#%u",
> +		 imc->src_id, imc->lmc, chan, dimmno);
> +
> +	return 1;
> +}

Now this function always return 1, that doesn't make a lot of sense?

Other than these details, the dmi-related code looks good to me now.

Reviewed-by: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org> # for DMI

-- 
Jean Delvare
SUSE L3 Support
