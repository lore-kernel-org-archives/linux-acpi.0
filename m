From: Linda Knippers <linda.knippers@hpe.com>
Subject: Re: [PATCH] nfit: add a module parameter to ignore ars errors
Date: Wed, 06 Jan 2016 12:12:06 -0500
Message-ID: <568D4AE6.5020601@hpe.com>
References: <1451946883-28092-1-git-send-email-vishal.l.verma@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g2t4619.austin.hp.com ([15.73.212.82]:48475 "EHLO
	g2t4619.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751572AbcAFRMK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Jan 2016 12:12:10 -0500
In-Reply-To: <1451946883-28092-1-git-send-email-vishal.l.verma@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Vishal Verma <vishal.l.verma@intel.com>, linux-nvdimm@lists.01.org
Cc: linux-acpi@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Jeff Moyer <jmoyer@redhat.com>

On 1/4/2016 5:34 PM, Vishal Verma wrote:
> Normally, if a platform does not advertise support for Address Range
> Scrub (ARS), we skip it. But if ARS is advertised, it is expected to
> always succeed. If it fails, we normally fail initialization at that
> point.
> 
> Add a module parameter to nfit that lets it ignore ARS failures and
> continue with initialization for debugging.

Could ARS be so broken that you might want to just ignore it altogether
and not even make the requests?

-- ljk
> 
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
> 
> This applies on top of both of the previous error handling series
> (badblocks and libnvdimm poison list). The tree at:
> https://git.kernel.org/cgit/linux/kernel/git/vishal/nvdimm.git/log/?h=err_handling_latest
> has been updated with this patch.
> 
>  drivers/acpi/nfit.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/nfit.c b/drivers/acpi/nfit.c
> index ad6d8c6..0a152f1 100644
> --- a/drivers/acpi/nfit.c
> +++ b/drivers/acpi/nfit.c
> @@ -34,6 +34,10 @@ static bool force_enable_dimms;
>  module_param(force_enable_dimms, bool, S_IRUGO|S_IWUSR);
>  MODULE_PARM_DESC(force_enable_dimms, "Ignore _STA (ACPI DIMM device) status");
>  
> +static bool ignore_ars;
> +module_param(ignore_ars, bool, S_IRUGO|S_IWUSR);
> +MODULE_PARM_DESC(ignore_ars, "Ignore ARS (Address Range Scrub) failures");
> +
>  struct nfit_table_prev {
>  	struct list_head spas;
>  	struct list_head memdevs;
> @@ -1786,7 +1790,10 @@ static int acpi_nfit_register_region(struct acpi_nfit_desc *acpi_desc,
>  			dev_err(acpi_desc->dev,
>  				"error while performing ARS to find poison: %d\n",
>  				rc);
> -			return rc;
> +			if (ignore_ars)
> +				; /* continue initialization */
> +			else
> +				return rc;
>  		}
>  		if (!nvdimm_pmem_region_create(nvdimm_bus, ndr_desc))
>  			return -ENOMEM;
> 

