From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 07/12] ACPI: do not reserve memory regions for some FADT entries in HW reduced mode
Date: Sun, 17 Nov 2013 23:15:19 +0100
Message-ID: <3035370.UsTsGZpP6E@vostro.rjw.lan>
References: <1384047382-20623-1-git-send-email-al.stone@linaro.org> <1384047382-20623-8-git-send-email-al.stone@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:63567 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751267Ab3KQWCo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 17 Nov 2013 17:02:44 -0500
In-Reply-To: <1384047382-20623-8-git-send-email-al.stone@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: al.stone@linaro.org
Cc: linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, Al Stone <ahs3@redhat.com>

On Saturday, November 09, 2013 06:36:17 PM al.stone@linaro.org wrote:
> From: Al Stone <ahs3@redhat.com>
> 
> Since some of the FADT fields reserved are not to be used by the OSPM,

"are not to be used by the OSPM in the HW reduced mode" would be clearer.

> do not map in the memory areas that the FADT fields reference.
>
> Signed-off-by: Al Stone <al.stone@linaro.org>
> ---
>  drivers/acpi/osl.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index 075545e..2750cb5 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -160,6 +160,9 @@ static u32 acpi_osi_handler(acpi_string interface, u32 supported)
>  	return supported;
>  }
>  
> +#ifdef CONFIG_ACPI_REDUCED_HARDWARE
> +static int __init acpi_reserve_resources(void) { return 0; }
> +#else
>  static void __init acpi_request_region (struct acpi_generic_address *gas,
>  	unsigned int length, char *desc)
>  {
> @@ -209,6 +212,7 @@ static int __init acpi_reserve_resources(void)
>  
>  	return 0;
>  }
> +#endif
>  device_initcall(acpi_reserve_resources);

Do we need the device_initcall() above at all if CONFIG_ACPI_REDUCED_HARDWARE
is unset?

>  void acpi_os_printf(const char *fmt, ...)
> @@ -1782,6 +1786,9 @@ static int __init acpi_no_auto_ssdt_setup(char *s)
>  
>  __setup("acpi_no_auto_ssdt", acpi_no_auto_ssdt_setup);
>  
> +#ifdef CONFIG_ACPI_REDUCED_HARDWARE
> +acpi_status __init acpi_os_initialize(void) { return AE_OK; }
> +#else
>  acpi_status __init acpi_os_initialize(void)
>  {
>  	acpi_os_map_generic_address(&acpi_gbl_FADT.xpm1a_event_block);
> @@ -1791,6 +1798,7 @@ acpi_status __init acpi_os_initialize(void)
>  
>  	return AE_OK;
>  }
> +#endif
>  
>  acpi_status __init acpi_os_initialize1(void)
>  {
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
