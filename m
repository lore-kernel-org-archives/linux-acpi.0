From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH V2] ACPI/Battery: Add a _BIX quirk for NEC LZ750/LS
Date: Mon, 6 Jan 2014 09:59:12 -0800
Message-ID: <20140106175912.GA2754@core.coreip.homeip.net>
References: <1389019837-13619-1-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1389019837-13619-1-git-send-email-tianyu.lan@intel.com>
Sender: stable-owner@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: lenb@kernel.org, rjw@rjwysocki.net, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, fcr@adinet.com.uy, l@dorileo.org, "3.8+" <stable@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi Lan,

On Mon, Jan 06, 2014 at 10:50:37PM +0800, Lan Tianyu wrote:
> The aml method _BIX of NEC LZ750/LS returns a broken package which
> skip the first member "Revision" according ACPI 5.0 spec Table 10-234.
> 
> This patch is to add a quirk for this machine to skip member "Revision"
> during parsing _BIX returned package.
> 
> Reported-and-tested-by: Francisco Castro <fcr@adinet.com.uy>
> Reference: https://bugzilla.kernel.org/show_bug.cgi?id=67351
> Cc: 3.8+ <stable@vger.kernel.org>
> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
> ---
> Change since v1:
> 	Remove battery_bix_package_quirk() function and set
> battery_bix_broken_package flag according the returned value
> of dmi_check_system().
> 
>  drivers/acpi/battery.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index e90ef8b..d21cc1a 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -61,6 +61,7 @@ MODULE_AUTHOR("Alexey Starikovskiy <astarikovskiy@suse.de>");
>  MODULE_DESCRIPTION("ACPI Battery Driver");
>  MODULE_LICENSE("GPL");
>  
> +static int battery_bix_broken_package;
>  static unsigned int cache_time = 1000;
>  module_param(cache_time, uint, 0644);
>  MODULE_PARM_DESC(cache_time, "cache time in milliseconds");
> @@ -415,7 +416,12 @@ static int acpi_battery_get_info(struct acpi_battery *battery)
>  		ACPI_EXCEPTION((AE_INFO, status, "Evaluating %s", name));
>  		return -ENODEV;
>  	}
> -	if (test_bit(ACPI_BATTERY_XINFO_PRESENT, &battery->flags))
> +
> +	if (battery_bix_broken_package)
> +		result = extract_package(battery, buffer.pointer,
> +				extended_info_offsets + 1,
> +				ARRAY_SIZE(extended_info_offsets) - 1);
> +	else if (test_bit(ACPI_BATTERY_XINFO_PRESENT, &battery->flags))
>  		result = extract_package(battery, buffer.pointer,
>  				extended_info_offsets,
>  				ARRAY_SIZE(extended_info_offsets));
> @@ -753,6 +759,17 @@ static int battery_notify(struct notifier_block *nb,
>  	return 0;
>  }
>  
> +static struct dmi_system_id bat_dmi_table[] = {
> +	{
> +	.ident = "NEC LZ750/LS",
> +	.matches = {
> +		DMI_MATCH(DMI_SYS_VENDOR, "NEC"),
> +		DMI_MATCH(DMI_PRODUCT_NAME, "PC-LZ750LS"),
> +		},

This does not appear at be indented properly. I see there some
inventive formatting in drivers/acpi, but I believe the proper form is:

static struct dmi_system_id bat_dmi_table[] = {
	{
		.ident = "NEC LZ750/LS",
		.matches = {
			DMI_MATCH(DMI_SYS_VENDOR, "NEC"),
			DMI_MATCH(DMI_PRODUCT_NAME, "PC-LZ750LS"),
		},
	},
	{}
};

Otherwise:

Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks.

-- 
Dmitry
