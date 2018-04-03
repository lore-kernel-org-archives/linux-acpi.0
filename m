From: Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH 1/6] nfit: fix region registration vs block-data-window
 ranges
Date: Tue, 3 Apr 2018 08:30:46 -0700
Message-ID: <1bda9083-5066-c577-ac2d-02eb518fcbbe@intel.com>
References: <152273076087.38372.4803377088477706610.stgit@dwillia2-desk3.amr.corp.intel.com>
 <152273076649.38372.8379231668189794225.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <152273076649.38372.8379231668189794225.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>, linux-nvdimm@lists.01.org
Cc: stable@vger.kernel.org, vishal.l.verma@intel.com, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org


On 4/2/2018 9:46 PM, Dan Williams wrote:
> Commit 1cf03c00e7c1 "nfit: scrub and register regions in a workqueue"
> mistakenly attempts to register a region per BLK aperture. There is
> nothing to register for individual apertures as they belong as a set to
> a BLK aperture group that are registered with a corresponding
> DIMM-control-region. Filter them for registration to prevent some
> needless devm_kzalloc() allocations.
>
> Cc: <stable@vger.kernel.org>
> Fixes: 1cf03c00e7c1 ("nfit: scrub and register regions in a workqueue")
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/acpi/nfit/core.c |   22 ++++++++++++++--------
>   1 file changed, 14 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index 12fb414fa678..ea9f3e727fef 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -3018,15 +3018,21 @@ static void acpi_nfit_scrub(struct work_struct *work)
>   static int acpi_nfit_register_regions(struct acpi_nfit_desc *acpi_desc)
>   {
>   	struct nfit_spa *nfit_spa;
> -	int rc;
>   
> -	list_for_each_entry(nfit_spa, &acpi_desc->spas, list)
> -		if (nfit_spa_type(nfit_spa->spa) == NFIT_SPA_DCR) {
> -			/* BLK regions don't need to wait for ars results */
> -			rc = acpi_nfit_register_region(acpi_desc, nfit_spa);
> -			if (rc)
> -				return rc;
> -		}
> +	list_for_each_entry(nfit_spa, &acpi_desc->spas, list) {
> +		int rc, type = nfit_spa_type(nfit_spa->spa);
> +
> +		/* PMEM and VMEM will be registered by the ARS workqueue */
> +		if (type == NFIT_SPA_PM || type == NFIT_SPA_VOLATILE)
> +			continue;
> +		/* BLK apertures belong to BLK region registration below */
> +		if (type == NFIT_SPA_BDW)
> +			continue;
> +		/* BLK regions don't need to wait for ARS results */
> +		rc = acpi_nfit_register_region(acpi_desc, nfit_spa);
> +		if (rc)
> +			return rc;
> +	}
>   
>   	acpi_desc->ars_start_flags = 0;
>   	if (!acpi_desc->cancel)
>
