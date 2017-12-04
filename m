From: Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC PATCH 3/4] edac: Add new memory type for non-volatile DIMMs
Date: Mon, 4 Dec 2017 23:37:11 +0100
Message-ID: <20171204223711.4l7gbd7op7yvsrza@pd.tnic>
References: <cover.1512070562.git.tony.luck@intel.com>
 <862104c26398781e4937c3fca3994cbe75d820ff.1512070562.git.tony.luck@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:36942 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751428AbdLDWhU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 4 Dec 2017 17:37:20 -0500
Content-Disposition: inline
In-Reply-To: <862104c26398781e4937c3fca3994cbe75d820ff.1512070562.git.tony.luck@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tony Luck <tony.luck@intel.com>
Cc: linux-edac@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Jean Delvare <jdelvare@suse.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org, Lv Zheng <lv.zheng@intel.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Aristeu Rozanski <aris@redhat.com>

On Thu, Nov 30, 2017 at 12:40:41PM -0800, Tony Luck wrote:
> There are now non-volatile versions of DIMMs. Add a new entry to
> "enum mem_type" and update places that use it with new strings.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  drivers/edac/edac_mc.c       | 1 +
>  drivers/edac/edac_mc_sysfs.c | 3 ++-
>  include/linux/edac.h         | 3 +++
>  3 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
> index 480072139b7a..8178e74decbf 100644
> --- a/drivers/edac/edac_mc.c
> +++ b/drivers/edac/edac_mc.c
> @@ -215,6 +215,7 @@ const char * const edac_mem_types[] = {
>  	[MEM_LRDDR3]	= "Load-Reduced DDR3 RAM",
>  	[MEM_DDR4]	= "Unbuffered DDR4 RAM",
>  	[MEM_RDDR4]	= "Registered DDR4 RAM",
> +	[MEM_NVDIMM]	= "Non-volatile RAM",
>  };
>  EXPORT_SYMBOL_GPL(edac_mem_types);
>  
> diff --git a/drivers/edac/edac_mc_sysfs.c b/drivers/edac/edac_mc_sysfs.c
> index e4fcfa84fbd3..53cbb3518efc 100644
> --- a/drivers/edac/edac_mc_sysfs.c
> +++ b/drivers/edac/edac_mc_sysfs.c
> @@ -110,7 +110,8 @@ static const char * const mem_types[] = {
>  	[MEM_DDR3] = "Unbuffered-DDR3",
>  	[MEM_RDDR3] = "Registered-DDR3",
>  	[MEM_DDR4] = "Unbuffered-DDR4",
> -	[MEM_RDDR4] = "Registered-DDR4"
> +	[MEM_RDDR4] = "Registered-DDR4",
> +	[MEM_NVDIMM] = "Non-volatile RAM",
>  };

WTF, there are *two* string arrays with memory types?! How did that
happen?

Can you please remove that above in a prepatch and switch to
edac_mem_types? Or should we switch to this mem_types array instead and
kill edac_mem_types since former is visible in sysfs?

:-( Grrr.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
