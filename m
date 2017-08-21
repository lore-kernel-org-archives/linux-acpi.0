From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v3 2/5] intel_pstate: convert to use
 acpi_match_platform_list()
Date: Mon, 21 Aug 2017 10:53:05 -0700
Message-ID: <1503337985.6726.28.camel@linux.intel.com>
References: <20170818194644.14538-1-toshi.kani@hpe.com>
         <20170818194644.14538-3-toshi.kani@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:55149 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753959AbdHURxg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 21 Aug 2017 13:53:36 -0400
In-Reply-To: <20170818194644.14538-3-toshi.kani@hpe.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Toshi Kani <toshi.kani@hpe.com>, rjw@rjwysocki.net, bp@alien8.de
Cc: mchehab@kernel.org, tony.luck@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 2017-08-18 at 13:46 -0600, Toshi Kani wrote:
> Convert to use acpi_match_platform_list() for the platform check.
> There is no change in functionality.
> 
> Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
Can't test but the change itself is OK.

Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
>  drivers/cpufreq/intel_pstate.c |   64 ++++++++++++++++------------
> ------------
>  1 file changed, 25 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c
> b/drivers/cpufreq/intel_pstate.c
> index 65ee4fc..ad713cd 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -2466,39 +2466,31 @@ enum {
>  	PPC,
>  };
>  
> -struct hw_vendor_info {
> -	u16  valid;
> -	char oem_id[ACPI_OEM_ID_SIZE];
> -	char oem_table_id[ACPI_OEM_TABLE_ID_SIZE];
> -	int  oem_pwr_table;
> -};
> -
>  /* Hardware vendor-specific info that has its own power management
> modes */
> -static struct hw_vendor_info vendor_info[] __initdata = {
> -	{1, "HP    ", "ProLiant", PSS},
> -	{1, "ORACLE", "X4-2    ", PPC},
> -	{1, "ORACLE", "X4-2L   ", PPC},
> -	{1, "ORACLE", "X4-2B   ", PPC},
> -	{1, "ORACLE", "X3-2    ", PPC},
> -	{1, "ORACLE", "X3-2L   ", PPC},
> -	{1, "ORACLE", "X3-2B   ", PPC},
> -	{1, "ORACLE", "X4470M2 ", PPC},
> -	{1, "ORACLE", "X4270M3 ", PPC},
> -	{1, "ORACLE", "X4270M2 ", PPC},
> -	{1, "ORACLE", "X4170M2 ", PPC},
> -	{1, "ORACLE", "X4170 M3", PPC},
> -	{1, "ORACLE", "X4275 M3", PPC},
> -	{1, "ORACLE", "X6-2    ", PPC},
> -	{1, "ORACLE", "Sudbury ", PPC},
> -	{0, "", ""},
> +static struct acpi_platform_list plat_info[] __initdata = {
> +	{"HP    ", "ProLiant", 0, ACPI_SIG_FADT, all_versions, 0,
> PSS},
> +	{"ORACLE", "X4-2    ", 0, ACPI_SIG_FADT, all_versions, 0,
> PPC},
> +	{"ORACLE", "X4-2L   ", 0, ACPI_SIG_FADT, all_versions, 0,
> PPC},
> +	{"ORACLE", "X4-2B   ", 0, ACPI_SIG_FADT, all_versions, 0,
> PPC},
> +	{"ORACLE", "X3-2    ", 0, ACPI_SIG_FADT, all_versions, 0,
> PPC},
> +	{"ORACLE", "X3-2L   ", 0, ACPI_SIG_FADT, all_versions, 0,
> PPC},
> +	{"ORACLE", "X3-2B   ", 0, ACPI_SIG_FADT, all_versions, 0,
> PPC},
> +	{"ORACLE", "X4470M2 ", 0, ACPI_SIG_FADT, all_versions, 0,
> PPC},
> +	{"ORACLE", "X4270M3 ", 0, ACPI_SIG_FADT, all_versions, 0,
> PPC},
> +	{"ORACLE", "X4270M2 ", 0, ACPI_SIG_FADT, all_versions, 0,
> PPC},
> +	{"ORACLE", "X4170M2 ", 0, ACPI_SIG_FADT, all_versions, 0,
> PPC},
> +	{"ORACLE", "X4170 M3", 0, ACPI_SIG_FADT, all_versions, 0,
> PPC},
> +	{"ORACLE", "X4275 M3", 0, ACPI_SIG_FADT, all_versions, 0,
> PPC},
> +	{"ORACLE", "X6-2    ", 0, ACPI_SIG_FADT, all_versions, 0,
> PPC},
> +	{"ORACLE", "Sudbury ", 0, ACPI_SIG_FADT, all_versions, 0,
> PPC},
> +	{ } /* End */
>  };
>  
>  static bool __init intel_pstate_platform_pwr_mgmt_exists(void)
>  {
> -	struct acpi_table_header hdr;
> -	struct hw_vendor_info *v_info;
>  	const struct x86_cpu_id *id;
>  	u64 misc_pwr;
> +	int idx;
>  
>  	id = x86_match_cpu(intel_pstate_cpu_oob_ids);
>  	if (id) {
> @@ -2507,21 +2499,15 @@ static bool __init
> intel_pstate_platform_pwr_mgmt_exists(void)
>  			return true;
>  	}
>  
> -	if (acpi_disabled ||
> -	    ACPI_FAILURE(acpi_get_table_header(ACPI_SIG_FADT, 0,
> &hdr)))
> +	idx = acpi_match_platform_list(plat_info);
> +	if (idx < 0)
>  		return false;
>  
> -	for (v_info = vendor_info; v_info->valid; v_info++) {
> -		if (!strncmp(hdr.oem_id, v_info->oem_id,
> ACPI_OEM_ID_SIZE) &&
> -			!strncmp(hdr.oem_table_id, v_info-
> >oem_table_id,
> -						ACPI_OEM_TABLE_ID_SI
> ZE))
> -			switch (v_info->oem_pwr_table) {
> -			case PSS:
> -				return intel_pstate_no_acpi_pss();
> -			case PPC:
> -				return intel_pstate_has_acpi_ppc()
> &&
> -					(!force_load);
> -			}
> +	switch (plat_info[idx].data) {
> +	case PSS:
> +		return intel_pstate_no_acpi_pss();
> +	case PPC:
> +		return intel_pstate_has_acpi_ppc() && !force_load;
>  	}
>  
>  	return false;
