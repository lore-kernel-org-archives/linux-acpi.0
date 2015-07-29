From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH v2] acpi: Use kstrtoul() instead of
 strtoul()/simple_strtoul()
Date: Wed, 29 Jul 2015 17:51:20 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37D329493@ORSMSX112.amr.corp.intel.com>
References: <1438043542-2960-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438043542-2960-1-git-send-email-linux@roeck-us.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "Zheng, Lv" <lv.zheng@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>
List-Id: linux-acpi@vger.kernel.org



> -----Original Message-----
> From: Guenter Roeck [mailto:linux@roeck-us.net]
> Sent: Monday, July 27, 2015 5:32 PM
> To: rjw@rjwysocki.net
> Cc: lenb@kernel.org; Moore, Robert; Zheng, Lv; linux-acpi@vger.kernel.org;
> linux-kernel@vger.kernel.org; devel@acpica.org; Guenter Roeck
> Subject: [PATCH v2] acpi: Use kstrtoul() instead of
> strtoul()/simple_strtoul()
> 
> simple_strtoul() is deprecated; replace with kstrtoul() and kstrtouint().

The ACPICA code is os-independent and cannot use these functions (at least not directly).





> Return an error if the value passed to the sysfs attribute is not a
> number.
> 
> Drop the definition of strtoul() since it is no longer needed.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: An additional use of strtoul() was introduced with commit 4fa4616e.
>     Replace it as well.
> 
>  drivers/acpi/acpica/evgpeinit.c | 5 +++--
>  drivers/acpi/sysfs.c            | 8 ++++++--
>  include/acpi/platform/aclinux.h | 1 -
>  3 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/acpi/acpica/evgpeinit.c
> b/drivers/acpi/acpica/evgpeinit.c index ea4c0d3fca2d..aa1e8c1f2d4a 100644
> --- a/drivers/acpi/acpica/evgpeinit.c
> +++ b/drivers/acpi/acpica/evgpeinit.c
> @@ -326,6 +326,7 @@ acpi_ev_match_gpe_method(acpi_handle obj_handle,
>  	u32 gpe_number;
>  	char name[ACPI_NAME_SIZE + 1];
>  	u8 type;
> +	int err;
> 
>  	ACPI_FUNCTION_TRACE(ev_match_gpe_method);
> 
> @@ -377,8 +378,8 @@ acpi_ev_match_gpe_method(acpi_handle obj_handle,
> 
>  	/* 4) The last two characters of the name are the hex GPE Number */
> 
> -	gpe_number = strtoul(&name[2], NULL, 16);
> -	if (gpe_number == ACPI_UINT32_MAX) {
> +	er = kstrtouint(&name[2], 16, &gpe_number);
> +	if (err < 0 || gpe_number == ACPI_UINT32_MAX) {
> 
>  		/* Conversion failed; invalid method, just ignore it */
> 
> diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c index
> 0876d77b3206..d6ea5712ec57 100644
> --- a/drivers/acpi/sysfs.c
> +++ b/drivers/acpi/sysfs.c
> @@ -616,8 +616,12 @@ static ssize_t counter_set(struct kobject *kobj,
>  			all_counters[index].count = tmp;
>  		else
>  			result = -EINVAL;
> -	} else
> -		all_counters[index].count = strtoul(buf, NULL, 0);
> +	} else {
> +		if (!kstrtoul(buf, 0, &tmp))
> +			all_counters[index].count = tmp;
> +		else
> +			result = -EINVAL;
> +	}
> 
>  	if (ACPI_FAILURE(result))
>  		result = -EINVAL;
> diff --git a/include/acpi/platform/aclinux.h
> b/include/acpi/platform/aclinux.h index 74ba46c8157a..9925c1d5d58f 100644
> --- a/include/acpi/platform/aclinux.h
> +++ b/include/acpi/platform/aclinux.h
> @@ -119,7 +119,6 @@
> 
>  #define ACPI_MACHINE_WIDTH          BITS_PER_LONG
>  #define ACPI_EXPORT_SYMBOL(symbol)  EXPORT_SYMBOL(symbol);
> -#define strtoul                     simple_strtoul
> 
>  #define acpi_cache_t                        struct kmem_cache
>  #define acpi_spinlock                       spinlock_t *
> --
> 2.1.0
