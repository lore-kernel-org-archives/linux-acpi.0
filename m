From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH][v3] ACPI: Do not report _OSI("Darwin") when
 acpi_osi=!Darwin provided
Date: Mon, 22 Feb 2016 07:57:02 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E883BB4DAB4@SHSMSX101.ccr.corp.intel.com>
References: <1454377278-3398-1-git-send-email-yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1454377278-3398-1-git-send-email-yu.c.chen@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "lenb@kernel.org" <lenb@kernel.org>, "matthew.garrett@nebula.com" <matthew.garrett@nebula.com>, "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>, "Chen, Yu C" <yu.c.chen@intel.com>
List-Id: linux-acpi@vger.kernel.org

Hi, Yu

> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> owner@vger.kernel.org] On Behalf Of Chen Yu
> Subject: [PATCH][v3] ACPI: Do not report _OSI("Darwin") when
> acpi_osi=!Darwin provided
> 
> Commit 7bc5a2bad0b8 ("ACPI: Support _OSI("Darwin") correctly") always
> reports positive value when Apple hardware queries _OSI("Darwin").
> But sometimes the users might want to tell the hardware they don't
> need the Darwin feature, for example, users may leverage the hardware
> to power off the Thunderbolt, by appending acpi_osi=!Darwin in command
> line, thus Apple hardware regards it as an incompatible OS X system,
> hence turns off the Thunderbolt.
[Lv Zheng] 
Both this patch and the original commit that is from Matthew look wrong to me.
IMO, the feature should be done with an entirely different approach.
Without test, I'm not sure if my comment is helpful for you.
So could you let me take over to fix this issue?

Thanks and best regards
-Lv

> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=92111
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
> v3:
>  - Simplify acpi_osi_setup_disabled suggested by Andy Shevchenko.
> v2:
>  - Convert osi_setup_entries to non-initdata variable, to
>    eliminate the warning from 0-DAY test infrastructure.
> ---
>  drivers/acpi/osl.c | 26 +++++++++++++++++++++++---
>  1 file changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index 67da6fb..8bb3a93 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -97,6 +97,7 @@ static LIST_HEAD(acpi_ioremaps);
>  static DEFINE_MUTEX(acpi_ioremap_lock);
> 
>  static void __init acpi_osi_setup_late(void);
> +static bool acpi_osi_setup_disabled(char *str);
> 
>  /*
>   * The story of _OSI(Linux)
> @@ -149,11 +150,13 @@ static u32 acpi_osi_handler(acpi_string interface,
> u32 supported)
>  			osi_linux.dmi ? " via DMI" : "");
>  	}
> 
> -	if (!strcmp("Darwin", interface)) {
> +	if (!strcmp("Darwin", interface) &&
> +	    !acpi_osi_setup_disabled(interface)) {
>  		/*
>  		 * Apple firmware will behave poorly if it receives positive
>  		 * answers to "Darwin" and any other OS. Respond positively
> -		 * to Darwin and then disable all other vendor strings.
> +		 * to Darwin and then disable all other vendor strings if
> +		 * acpi_osi="!Darwin" is not appended in cmdline.
>  		 */
> 
> 	acpi_update_interfaces(ACPI_DISABLE_ALL_VENDOR_STRINGS);
>  		supported = ACPI_UINT32_MAX;
> @@ -1688,13 +1691,30 @@ struct osi_setup_entry {
>  };
> 
>  static struct osi_setup_entry
> -		osi_setup_entries[OSI_STRING_ENTRIES_MAX] __initdata = {
> +		osi_setup_entries[OSI_STRING_ENTRIES_MAX] = {
>  	{"Module Device", true},
>  	{"Processor Device", true},
>  	{"3.0 _SCP Extensions", true},
>  	{"Processor Aggregator Device", true},
>  };
> 
> +static bool acpi_osi_setup_disabled(char *str)
> +{
> +	int i;
> +	struct osi_setup_entry *osi;
> +
> +	if (str == NULL || *str == '\0')
> +		return false;
> +
> +	for (i = 0; i < OSI_STRING_ENTRIES_MAX; i++) {
> +		osi = &osi_setup_entries[i];
> +		if (!strcmp(osi->string, str))
> +			return !osi->enable;
> +	}
> +
> +	return false;
> +}
> +
>  void __init acpi_osi_setup(char *str)
>  {
>  	struct osi_setup_entry *osi;
> --
> 1.8.4.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
