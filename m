From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3 2/5] intel_pstate: convert to use
 acpi_match_platform_list()
Date: Wed, 23 Aug 2017 17:46:16 +0200
Message-ID: <20170823154615.bqbz2cpywlie2zh7@pd.tnic>
References: <20170818194644.14538-1-toshi.kani@hpe.com>
 <20170818194644.14538-3-toshi.kani@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170818194644.14538-3-toshi.kani@hpe.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Toshi Kani <toshi.kani@hpe.com>
Cc: rjw@rjwysocki.net, mchehab@kernel.org, tony.luck@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

On Fri, Aug 18, 2017 at 01:46:41PM -0600, Toshi Kani wrote:
> Convert to use acpi_match_platform_list() for the platform check.
> There is no change in functionality.
> 
> Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> ---
>  drivers/cpufreq/intel_pstate.c |   64 ++++++++++++++++------------------------
>  1 file changed, 25 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 65ee4fc..ad713cd 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -2466,39 +2466,31 @@ enum {
>  	PPC,
>  };
>  
> -struct hw_vendor_info {
> -	u16  valid;
> -	char oem_id[ACPI_OEM_ID_SIZE];
> -	char oem_table_id[ACPI_OEM_TABLE_ID_SIZE];
> -	int  oem_pwr_table;
> -};
> -
>  /* Hardware vendor-specific info that has its own power management modes */
> -static struct hw_vendor_info vendor_info[] __initdata = {
> -	{1, "HP    ", "ProLiant", PSS},
> -	{1, "ORACLE", "X4-2    ", PPC},
> -	{1, "ORACLE", "X4-2L   ", PPC},
> -	{1, "ORACLE", "X4-2B   ", PPC},
> -	{1, "ORACLE", "X3-2    ", PPC},
> -	{1, "ORACLE", "X3-2L   ", PPC},
> -	{1, "ORACLE", "X3-2B   ", PPC},
> -	{1, "ORACLE", "X4470M2 ", PPC},
> -	{1, "ORACLE", "X4270M3 ", PPC},
> -	{1, "ORACLE", "X4270M2 ", PPC},
> -	{1, "ORACLE", "X4170M2 ", PPC},
> -	{1, "ORACLE", "X4170 M3", PPC},
> -	{1, "ORACLE", "X4275 M3", PPC},
> -	{1, "ORACLE", "X6-2    ", PPC},
> -	{1, "ORACLE", "Sudbury ", PPC},
> -	{0, "", ""},
> +static struct acpi_platform_list plat_info[] __initdata = {
> +	{"HP    ", "ProLiant", 0, ACPI_SIG_FADT, all_versions, 0, PSS},

Btw, why is that ACPI_SIG_FADT's description not "FADT" ?

#define ACPI_SIG_FADT           "FACP"  /* Fixed ACPI Description Table */

More ACPI fun? I don't think I can take any more fun.

Oh well,

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
