From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 6/7] EDAC: add edac_check_mc_owner() to check MC owner
Date: Fri, 4 Aug 2017 10:30:07 +0200
Message-ID: <20170804083007.GA15617@nazgul.tnic>
References: <20170803215753.30553-1-toshi.kani@hpe.com>
 <20170803215753.30553-7-toshi.kani@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:49140 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751284AbdHDIbA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 4 Aug 2017 04:31:00 -0400
Content-Disposition: inline
In-Reply-To: <20170803215753.30553-7-toshi.kani@hpe.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Toshi Kani <toshi.kani@hpe.com>
Cc: rjw@rjwysocki.net, mchehab@kernel.org, tony.luck@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Aug 03, 2017 at 03:57:52PM -0600, Toshi Kani wrote:
> Only a single edac driver can be enabled for EDAC MC.  When ghes_edac
> is enabled, a regular edac driver for the CPU type / platform still
> attempts to register itself and fails in edac_mc_add_mc().
> 
> Add edac_check_mc_owner() so that regular edac drivers can check
> the owner of EDAC MC at the beginning of initialization.
> 
> Also change the owner check to string comparison from address check.
> 
> Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Tony Luck <tony.luck@intel.com>
> ---
>  drivers/edac/edac_mc.c |   15 ++++++++++++++-
>  drivers/edac/edac_mc.h |   12 ++++++++++++
>  2 files changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
> index 4800721..52d8d5e 100644
> --- a/drivers/edac/edac_mc.c
> +++ b/drivers/edac/edac_mc.c
> @@ -701,6 +701,19 @@ struct mem_ctl_info *edac_mc_find(int idx)
>  }
>  EXPORT_SYMBOL(edac_mc_find);
>  
> +/*
> + * Returns:
> + *	1 when EDAC MC is free or owned by the module name

1 for free OR owned?!? WTF?

> + *	0 when EDAC MC is owned by other module
> + */
> +int edac_check_mc_owner(const char *mod_name)
> +{
> +	if (edac_mc_owner && strcmp(edac_mc_owner, mod_name))

strncmp() of course, with sensible maximal string length.

> +		return 0;
> +
> +	return 1;
> +}
> +EXPORT_SYMBOL(edac_check_mc_owner);

EXPORT_SYMBOL_GPL

>  
>  /* FIXME - should a warning be printed if no error detection? correction? */
>  int edac_mc_add_mc_with_groups(struct mem_ctl_info *mci,
> @@ -742,7 +755,7 @@ int edac_mc_add_mc_with_groups(struct mem_ctl_info *mci,
>  #endif
>  	mutex_lock(&mem_ctls_mutex);
>  
> -	if (edac_mc_owner && edac_mc_owner != mci->mod_name) {
> +	if (!edac_check_mc_owner(mci->mod_name)) {
>  		ret = -EPERM;
>  		goto fail0;
>  	}
> diff --git a/drivers/edac/edac_mc.h b/drivers/edac/edac_mc.h
> index 5357800..0e95eba 100644
> --- a/drivers/edac/edac_mc.h
> +++ b/drivers/edac/edac_mc.h
> @@ -128,6 +128,18 @@ struct mem_ctl_info *edac_mc_alloc(unsigned mc_num,
>  				   unsigned sz_pvt);
>  
>  /**
> + *
> + * edac_check_mc_owner - Check the owner of EDAC MC
> + *
> + * @mod_name: pointer to the module name
> + *
> + * Returns:
> + *	1 when EDAC MC is free or owned by the module name
> + *	0 when EDAC MC is owned by other module
> + */

Documenting that function only once is enough.

> +extern int edac_check_mc_owner(const char *mod_name);
> +
> +/*
>   * edac_mc_add_mc_with_groups() - Insert the @mci structure into the mci
>   *	global list and create sysfs entries associated with @mci structure.
>   *

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
