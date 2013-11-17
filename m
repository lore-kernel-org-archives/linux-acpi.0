From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 01/12] ACPI: introduce CONFIG_ACPI_REDUCED_HARDWARE to enable this ACPI mode
Date: Sun, 17 Nov 2013 23:29:30 +0100
Message-ID: <76934632.melfpCVyMM@vostro.rjw.lan>
References: <1384047382-20623-1-git-send-email-al.stone@linaro.org> <1384047382-20623-2-git-send-email-al.stone@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:52818 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751750Ab3KQWQz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 17 Nov 2013 17:16:55 -0500
In-Reply-To: <1384047382-20623-2-git-send-email-al.stone@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: al.stone@linaro.org
Cc: linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, Al Stone <ahs3@redhat.com>, Hanjun Guo <hanjun.guo@linaro.org>

On Saturday, November 09, 2013 06:36:11 PM al.stone@linaro.org wrote:
> From: Al Stone <ahs3@redhat.com>
> 
> To enable the hardware reduced mode of ACPI on some platforms (such as
> ARM), we need to modify the kernel code and set ACPI_REDUCED_HARDWARE
> to TRUE in the ACPICA source.
> 
> This can be done more resonably by introducing a kernel config item
> to enable/disable ACPI_REDUCED_HARDWARE.  We can then change the kernel
> config instead of having to modify the kernel source directly to enable
> the reduced hardware mode of ACPI.
> 
> Lv Zheng suggested that this configuration item does not belong in ACPICA,
> the upstream source for much of the ACPI internals, but rather to the
> Linux kernel itself.  Hence, we introduce this flag so that we can make
> ACPI_REDUCED_HARDWARE configurable.  For the details of the discussion,
> please refer to: http://www.spinics.net/lists/linux-acpi/msg46369.html
> 
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Signed-off-by: Al Stone <al.stone@linaro.org>
> ---
>  drivers/acpi/Kconfig            | 8 ++++++++
>  include/acpi/platform/aclinux.h | 4 ++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 589da05..7bbd3b0 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -354,6 +354,14 @@ config ACPI_BGRT
>  	  data from the firmware boot splash. It will appear under
>  	  /sys/firmware/acpi/bgrt/ .
>  
> +config ACPI_REDUCED_HARDWARE
> +	bool "Hardware-reduced ACPI support"
> +	depends on !(IA64 || X86)

Why don't you use 

	depends on (ARM || ARM64)

here instead?

> +	help
> +	This config adds support for Hardware-reduced ACPI. When this option
> +	is selected, will generate a specialized version of ACPICA that ONLY
> +	supports the ACPI "reduced hardware".
> +
>  source "drivers/acpi/apei/Kconfig"
>  
>  endif	# ACPI
> diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
> index 28f4f4d..ae93a91 100644
> --- a/include/acpi/platform/aclinux.h
> +++ b/include/acpi/platform/aclinux.h
> @@ -67,6 +67,10 @@
>  
>  /* Host-dependent types and defines for in-kernel ACPICA */
>  
> +#ifdef CONFIG_ACPI_REDUCED_HARDWARE
> +#define ACPI_REDUCED_HARDWARE TRUE
> +#endif
> +
>  #define ACPI_MACHINE_WIDTH          BITS_PER_LONG
>  #define ACPI_EXPORT_SYMBOL(symbol)  EXPORT_SYMBOL(symbol);
>  #define strtoul                     simple_strtoul
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
