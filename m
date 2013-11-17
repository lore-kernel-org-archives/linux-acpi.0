From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 12/12] ACPI: correct #ifdef so compilation without ACPI_REDUCED_HARDWARE works
Date: Sun, 17 Nov 2013 23:28:56 +0100
Message-ID: <1685828.kuHnzG34kb@vostro.rjw.lan>
References: <1384047382-20623-1-git-send-email-al.stone@linaro.org> <1384047382-20623-13-git-send-email-al.stone@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:53242 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751546Ab3KQWQV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 17 Nov 2013 17:16:21 -0500
In-Reply-To: <1384047382-20623-13-git-send-email-al.stone@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: al.stone@linaro.org
Cc: linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, Al Stone <ahs3@redhat.com>

On Saturday, November 09, 2013 06:36:22 PM al.stone@linaro.org wrote:
> From: Al Stone <ahs3@redhat.com>

Doesn't this fix problems with one of the previous patches in the series?

> Signed-off-by: Al Stone <al.stone@linaro.org>
> ---
>  drivers/acpi/bus.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index f41949a..e868de3 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -513,7 +513,7 @@ void __init acpi_early_init(void)
>  
>  	acpi_gbl_permanent_mmap = 1;
>  
> -#if !(CONFIG_ARM || CONFIG_ARM64)
> +#if !(defined(CONFIG_ARM) || defined(CONFIG_ARM64))
>  	/*
>  	 * NB: ARM does not use DMI at present.
>  	 *
> @@ -544,7 +544,7 @@ void __init acpi_early_init(void)
>  		goto error0;
>  	}
>  
> -#if (!CONFIG_ACPI_REDUCED_HARDWARE)
> +#if !(defined(CONFIG_ARM) || defined(CONFIG_ARM64)) && (!ACPI_REDUCED_HARDWARE)
>  	/* NB: in HW reduced mode, FADT sci_interrupt has no meaning */
>  	if (!acpi_ioapic) {
>  		/* compatible (0) means level (3) */
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
