From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 7/7] edac drivers: add MC owner check in init
Date: Fri, 4 Aug 2017 10:39:22 +0200
Message-ID: <20170804083922.GC15617@nazgul.tnic>
References: <20170803215753.30553-1-toshi.kani@hpe.com>
 <20170803215753.30553-8-toshi.kani@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170803215753.30553-8-toshi.kani@hpe.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Toshi Kani <toshi.kani@hpe.com>
Cc: rjw@rjwysocki.net, mchehab@kernel.org, tony.luck@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Aug 03, 2017 at 03:57:53PM -0600, Toshi Kani wrote:
> Change generic x86 edac drivers, which probe CPU type with
> x86_match_cpu(), to call edac_check_mc_owner() in their
> module init functions.  This allows them to fail their init
> at the beginning when ghes_edac is enabled.  Similar change
> can be made to other edac drivers as necessary.
> 
> This is an optimization and there is no functional change.
> 
> Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
> Suggested-by: Borislav Petkov <bp@alien8.de>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Tony Luck <tony.luck@intel.com>
> ---
>  drivers/edac/amd64_edac.c |    3 +++
>  drivers/edac/pnd2_edac.c  |    7 ++++++-
>  drivers/edac/sb_edac.c    |    7 +++++--
>  drivers/edac/skx_edac.c   |    6 +++++-
>  4 files changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index 3aea556..cdb40d6 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -3444,6 +3444,9 @@ static int __init amd64_edac_init(void)
>  	if (amd_cache_northbridges() < 0)
>  		return -ENODEV;
>  
> +	if (!edac_check_mc_owner(EDAC_MOD_STR))
> +		return -EBUSY;
> +

That needs to happen first in the init function.

>  	opstate_init();
>  
>  	err = -ENOMEM;
> diff --git a/drivers/edac/pnd2_edac.c b/drivers/edac/pnd2_edac.c
> index 8e59949..a5b7855 100644
> --- a/drivers/edac/pnd2_edac.c
> +++ b/drivers/edac/pnd2_edac.c
> @@ -45,6 +45,8 @@
>  #include "edac_module.h"
>  #include "pnd2_edac.h"
>  
> +#define PND2_MOD_NAME		"pnd2_edac.c"

EDAC_MOD_STR and look how the other drivers define it, i.e., without the ".c"

> +
>  #define APL_NUM_CHANNELS	4
>  #define DNV_NUM_CHANNELS	2
>  #define DNV_MAX_DIMMS		2 /* Max DIMMs per channel */
> @@ -1313,7 +1315,7 @@ static int pnd2_register_mci(struct mem_ctl_info **ppmci)
>  	pvt = mci->pvt_info;
>  	memset(pvt, 0, sizeof(*pvt));
>  
> -	mci->mod_name = "pnd2_edac.c";
> +	mci->mod_name = PND2_MOD_NAME;
>  	mci->dev_name = ops->name;
>  	mci->ctl_name = "Pondicherry2";
>  
> @@ -1513,6 +1515,9 @@ static int __init pnd2_init(void)
>  	if (!id)
>  		return -ENODEV;
>  
> +	if (!edac_check_mc_owner(PND2_MOD_NAME))
> +		return -EBUSY;

Also first thing to do in the function.

> +
>  	ops = (struct dunit_ops *)id->driver_data;
>  
>  	/* Ensure that the OPSTATE is set correctly for POLL or NMI */
> diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c
> index 80d860c..71bd66e 100644
> --- a/drivers/edac/sb_edac.c
> +++ b/drivers/edac/sb_edac.c
> @@ -36,7 +36,7 @@ static LIST_HEAD(sbridge_edac_list);
>   * Alter this version for the module when modifications are made
>   */
>  #define SBRIDGE_REVISION    " Ver: 1.1.2 "
> -#define EDAC_MOD_STR      "sbridge_edac"
> +#define SBRIDGE_MOD_NAME    "sb_edac.c"

Why? EDAC_MOD_STR is just fine.

>  /*
>   * Debug macros
> @@ -3124,7 +3124,7 @@ static int sbridge_register_mci(struct sbridge_dev *sbridge_dev, enum type type)
>  		MEM_FLAG_DDR4 : MEM_FLAG_DDR3;
>  	mci->edac_ctl_cap = EDAC_FLAG_NONE;
>  	mci->edac_cap = EDAC_FLAG_NONE;
> -	mci->mod_name = "sb_edac.c";
> +	mci->mod_name = SBRIDGE_MOD_NAME;
>  	mci->mod_ver = SBRIDGE_REVISION;
>  	mci->dev_name = pci_name(pdev);
>  	mci->ctl_page_to_phys = NULL;
> @@ -3380,6 +3380,9 @@ static int __init sbridge_init(void)
>  	if (!id)
>  		return -ENODEV;
>  
> +	if (!edac_check_mc_owner(SBRIDGE_MOD_NAME))
> +		return -EBUSY;

See above.

> +
>  	/* Ensure that the OPSTATE is set correctly for POLL or NMI */
>  	opstate_init();
>  
> diff --git a/drivers/edac/skx_edac.c b/drivers/edac/skx_edac.c
> index 64bef6c9..8347969 100644
> --- a/drivers/edac/skx_edac.c
> +++ b/drivers/edac/skx_edac.c
> @@ -31,6 +31,7 @@
>  
>  #include "edac_module.h"
>  
> +#define SKX_MOD_NAME    "skx_edac.c"
>  #define SKX_REVISION    " Ver: 1.0 "

Ditto.

>  
>  /*
> @@ -471,7 +472,7 @@ static int skx_register_mci(struct skx_imc *imc)
>  	mci->mtype_cap = MEM_FLAG_DDR4;
>  	mci->edac_ctl_cap = EDAC_FLAG_NONE;
>  	mci->edac_cap = EDAC_FLAG_NONE;
> -	mci->mod_name = "skx_edac.c";
> +	mci->mod_name = SKX_MOD_NAME;
>  	mci->dev_name = pci_name(imc->chan[0].cdev);
>  	mci->mod_ver = SKX_REVISION;
>  	mci->ctl_page_to_phys = NULL;
> @@ -1052,6 +1053,9 @@ static int __init skx_init(void)
>  	if (!id)
>  		return -ENODEV;
>  
> +	if (!edac_check_mc_owner(SKX_MOD_NAME))
> +		return -EBUSY;
> +

Ditto.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
