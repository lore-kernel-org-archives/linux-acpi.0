From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] Revert "ACPI / bus: Parse tables as term_list for Dell XPS 9570 and Precision M5530"
Date: Mon, 23 Jul 2018 13:42:37 +0200
Message-ID: <5241523.N3ikpBZNhp@aspire.rjw.lan>
References: <20180719110030.9483-1-kai.heng.feng@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180719110030.9483-1-kai.heng.feng@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Erik Schmauss <erik.schmauss@intel.com>, Mario Limonciello <mario.limonciello@dell.com>
List-Id: linux-acpi@vger.kernel.org

On Thursday, July 19, 2018 1:00:30 PM CEST Kai-Heng Feng wrote:
> This reverts commit 36904703aeeeb6cd31993f1353c8325006229f9a.
> 
> Since commit 5a8361f7ecce ("ACPICA: Integrate package handling with
> module-level code"), acpi_gbl_execute_tables_as_methods is always true,
> so we can remove the quirk for XPS 9570/Precision M5530.
> 
> Cc: Erik Schmauss <erik.schmauss@intel.com>
> Cc: Mario Limonciello <mario.limonciello@dell.com>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/acpi/bus.c | 38 +++++++-------------------------------
>  1 file changed, 7 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 84b4a62018eb..f61f8927d843 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -66,37 +66,10 @@ static int set_copy_dsdt(const struct dmi_system_id *id)
>  	return 0;
>  }
>  #endif
> -static int set_gbl_term_list(const struct dmi_system_id *id)
> -{
> -	acpi_gbl_execute_tables_as_methods = 1;
> -	return 0;
> -}
>  
> -static const struct dmi_system_id acpi_quirks_dmi_table[] __initconst = {
> -	/*
> -	 * Touchpad on Dell XPS 9570/Precision M5530 doesn't work under I2C
> -	 * mode.
> -	 * https://bugzilla.kernel.org/show_bug.cgi?id=198515
> -	 */
> -	{
> -		.callback = set_gbl_term_list,
> -		.ident = "Dell Precision M5530",
> -		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "Precision M5530"),
> -		},
> -	},
> -	{
> -		.callback = set_gbl_term_list,
> -		.ident = "Dell XPS 15 9570",
> -		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "XPS 15 9570"),
> -		},
> -	},
> +static const struct dmi_system_id dsdt_dmi_table[] __initconst = {
>  	/*
>  	 * Invoke DSDT corruption work-around on all Toshiba Satellite.
> -	 * DSDT will be copied to memory.
>  	 * https://bugzilla.kernel.org/show_bug.cgi?id=14679
>  	 */
>  	{
> @@ -110,7 +83,7 @@ static const struct dmi_system_id acpi_quirks_dmi_table[] __initconst = {
>  	{}
>  };
>  #else
> -static const struct dmi_system_id acpi_quirks_dmi_table[] __initconst = {
> +static const struct dmi_system_id dsdt_dmi_table[] __initconst = {
>  	{}
>  };
>  #endif
> @@ -1060,8 +1033,11 @@ void __init acpi_early_init(void)
>  
>  	acpi_permanent_mmap = true;
>  
> -	/* Check machine-specific quirks */
> -	dmi_check_system(acpi_quirks_dmi_table);
> +	/*
> +	 * If the machine falls into the DMI check table,
> +	 * DSDT will be copied to memory
> +	 */
> +	dmi_check_system(dsdt_dmi_table);
>  
>  	status = acpi_reallocate_root_table();
>  	if (ACPI_FAILURE(status)) {
> 

Applied, thanks!
