From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH v1 3/4] ACPI / sleep: Re-use new dmi_get_bios_year()
 helper
Date: Mon, 26 Feb 2018 17:31:37 +0100
Message-ID: <20180226173137.3749baa7@endymion>
References: <20180222125923.57385-1-andriy.shevchenko@linux.intel.com>
        <20180222125923.57385-3-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180222125923.57385-3-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thu, 22 Feb 2018 14:59:22 +0200, Andy Shevchenko wrote:
> ...instead of open coding its functionality.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/acpi/sleep.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index 46cde0912762..b35923e3a926 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -376,12 +376,10 @@ void __init acpi_sleep_no_blacklist(void)
>  
>  static void __init acpi_sleep_dmi_check(void)
>  {
> -	int year;
> -
>  	if (ignore_blacklist)
>  		return;
>  
> -	if (dmi_get_date(DMI_BIOS_DATE, &year, NULL, NULL) && year >= 2012)
> +	if (dmi_get_bios_year() >= 2012)
>  		acpi_nvs_nosave_s3();
>  
>  	dmi_check_system(acpisleep_dmi_table);

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support
