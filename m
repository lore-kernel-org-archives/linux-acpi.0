From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 05/12] ACPI: ARM: exclude calls on ARM platforms, not include them on x86
Date: Sun, 17 Nov 2013 23:08:26 +0100
Message-ID: <17533512.3VVEMyRe92@vostro.rjw.lan>
References: <1384047382-20623-1-git-send-email-al.stone@linaro.org> <1384047382-20623-6-git-send-email-al.stone@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:54651 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751680Ab3KQVzv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 17 Nov 2013 16:55:51 -0500
In-Reply-To: <1384047382-20623-6-git-send-email-al.stone@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: al.stone@linaro.org
Cc: linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, Al Stone <ahs3@redhat.com>

On Saturday, November 09, 2013 06:36:15 PM al.stone@linaro.org wrote:
> From: Al Stone <ahs3@redhat.com>
> 
> Corrected #ifdef so that DMI is not used on ARM platforms which are
> currently implementing reduced HW mode.

Please define an empty dmi_check_system() stub for ARM/ARM64 then.

Generally, please avoid adding compiler directives into function bodies if
possible.

> Signed-off-by: Al Stone <al.stone@linaro.org>
> ---
>  drivers/acpi/bus.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 6a54dd5..f41949a 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -513,11 +513,15 @@ void __init acpi_early_init(void)
>  
>  	acpi_gbl_permanent_mmap = 1;
>  
> +#if !(CONFIG_ARM || CONFIG_ARM64)
>  	/*
> +	 * NB: ARM does not use DMI at present.
> +	 *
>  	 * If the machine falls into the DMI check table,
>  	 * DSDT will be copied to memory
>  	 */
>  	dmi_check_system(dsdt_dmi_table);
> +#endif
>  
>  	status = acpi_reallocate_root_table();
>  	if (ACPI_FAILURE(status)) {
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
