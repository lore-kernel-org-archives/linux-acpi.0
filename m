From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v4 3/5] ghes_edac: add platform check to enable ghes_edac
Date: Thu, 31 Aug 2017 12:56:47 +0200
Message-ID: <20170831105647.a7ypixekv6jybqyu@pd.tnic>
References: <20170823225447.15608-1-toshi.kani@hpe.com>
 <20170823225447.15608-4-toshi.kani@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170823225447.15608-4-toshi.kani@hpe.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Toshi Kani <toshi.kani@hpe.com>
Cc: rjw@rjwysocki.net, mchehab@kernel.org, tony.luck@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Aug 23, 2017 at 04:54:45PM -0600, Toshi Kani wrote:
> The ghes_edac driver was introduced in 2013 [1], but it has not
> been enabled by any distro yet.  This driver obtains error info
> from firmware interfaces, which are not properly implemented on
> many platforms, as the driver always emits the messages below:
> 
>  This EDAC driver relies on BIOS to enumerate memory and get error reports.
>  Unfortunately, not all BIOSes reflect the memory layout correctly
>  So, the end result of using this driver varies from vendor to vendor
>  If you find incorrect reports, please contact your hardware vendor
>  to correct its BIOS.
> 
> To get out from this situation, add a platform check to selectively
> enable the driver on the platforms that are known to have proper
> firmware implementation.  Platform vendors can add their platforms
> to the list when they support ghes_edac.
> 
> "ghes_edac.force_load=1" skips this platform check.
> 
> [1]: https://lwn.net/Articles/538438/
> Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Tony Luck <tony.luck@intel.com>
> ---
>  drivers/edac/ghes_edac.c |   29 ++++++++++++++++++++++++-----
>  1 file changed, 24 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
> index 8d904df..0030a09 100644
> --- a/drivers/edac/ghes_edac.c
> +++ b/drivers/edac/ghes_edac.c
> @@ -38,6 +38,10 @@ static struct ghes_edac_pvt *ghes_pvt;
>   */
>  static DEFINE_SPINLOCK(ghes_lock);
>  
> +/* Set 1 to skip the platform check */
> +static bool __read_mostly ghes_edac_force_load;

It is static - "force_load" as a bool name is enough.

> +module_param_named(force_load, ghes_edac_force_load, bool, 0);

ERROR: Use 4 digit octal (0777) not decimal permissions
#53: FILE: drivers/edac/ghes_edac.c:43:
+module_param_named(force_load, ghes_edac_force_load, bool, 0);

This last param is @perm: visibility in sysfs. Why not visible in sysfs?

> +
>  /* Memory Device - Type 17 of SMBIOS spec */
>  struct memdev_dmi_entry {
>  	u8 type;
> @@ -415,6 +419,15 @@ void ghes_edac_report_mem_error(struct ghes *ghes, int sev,
>  	spin_unlock_irqrestore(&ghes_lock, flags);
>  }
>  
> +/*
> + * Known systems that are safe to enable this module.
> + * "ghes_edac.force_load=1" skips this check if necessary.

Put this second sentence over the parameter definition.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
