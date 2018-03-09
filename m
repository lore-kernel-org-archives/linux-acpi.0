From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH 5/5] EDAC, skx_edac: Detect non-volatile DIMMs
Date: Fri, 9 Mar 2018 11:38:01 +0100
Message-ID: <20180309113801.14b06cdf@endymion>
References: <20180222195811.27237-1-tony.luck@intel.com>
 <20180222195811.27237-6-tony.luck@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <20180222195811.27237-6-tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
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
Cc: Mauro Carvalho Chehab <mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org, Aristeu Rozanski <aris-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "Rafael
 J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Qiuxu Zhuo <qiuxu.zhuo-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, Lv Zheng <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Borislav Petkov <bp-l3A5Bk7waGM@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Tony,

On Thu, 22 Feb 2018 11:58:11 -0800, Tony Luck wrote:
> This just covers the topology function of the EDAC driver.
> We locate which DIMM slots are populated with NVDIMMs and
> query the NFIT and SMBIOS tables to get the size.
> 
> Signed-off-by: Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/edac/Kconfig    |  5 +++-
>  drivers/edac/skx_edac.c | 68 ++++++++++++++++++++++++++++++++++++++++++++-----
>  2 files changed, 66 insertions(+), 7 deletions(-)
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

I'm curious why you continue in this (worse) error case, but stop on
all other (some presumably less critical) error cases? Specifically I
can't see how an unknown size returned by the dmi subsystem can be worse
than not being able to query the size at all.

> +	}
> +	if (smbios_handle < 0) {
> +		skx_printk(KERN_ERR, "Can't find handle for NVDIMM ADR=%x\n", dev_handle);
> +		return 0;
> +	}
> +
> +	if (flags & ACPI_NFIT_MEM_MAP_FAILED) {
> +		skx_printk(KERN_ERR, "NVDIMM ADR=%x is not mapped\n", dev_handle);
> +		return 0;
> +	}
> +
> +	size = dmi_memdev_size(smbios_handle);
> +	if (size == ~0ul) {

If you agree with my comment on previous patch then this becomes ~0ull.

> +		skx_printk(KERN_ERR, "Can't find size for NVDIMM ADR=%x/SMBIOS=%x\n",
> +			   dev_handle, smbios_handle);
> +		return 0;
> +	}
> +
> +unknown_size:
> +	edac_dbg(0, "mc#%d: channel %d, dimm %d, %lld Mb (%lld pages)\n",

%llu instead of %lld (twice)?

> +		 imc->mc, chan, dimmno, size >> 20, size >> PAGE_SHIFT);
> +
> +	dimm->nr_pages = size >> PAGE_SHIFT;

If you moved the debug print after, you wouldn't have to do the shift
twice.

> +	dimm->grain = 32;
> +	dimm->dtype = DEV_UNKNOWN;
> +	dimm->mtype = MEM_NVDIMM;
> +	dimm->edac_mode = EDAC_SECDED; /* likely better than this */
> +
> +	snprintf(dimm->label, sizeof(dimm->label), "CPU_SrcID#%u_MC#%u_Chan#%u_DIMM#%u",
> +		 imc->src_id, imc->lmc, chan, dimmno);
> +
> +	return 1;
> +}

-- 
Jean Delvare
SUSE L3 Support
