From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH 01/12] ACPI: introduce CONFIG_ACPI_REDUCED_HARDWARE to
 enable this ACPI mode
Date: Fri, 22 Nov 2013 06:14:18 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E880248C95D@SHSMSX101.ccr.corp.intel.com>
References: <1384047382-20623-1-git-send-email-al.stone@linaro.org>
 <1384047382-20623-2-git-send-email-al.stone@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:38136 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751242Ab3KVGOW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 22 Nov 2013 01:14:22 -0500
In-Reply-To: <1384047382-20623-2-git-send-email-al.stone@linaro.org>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "al.stone@linaro.org" <al.stone@linaro.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc: "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Al Stone <ahs3@redhat.com>, Hanjun Guo <hanjun.guo@linaro.org>

> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of al.stone@linaro.org
> Sent: Sunday, November 10, 2013 9:36 AM
> 
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

Maybe you put this here because of my previous wrong comment.

For ACPICA environments that work like Kconfigs for Linux, it is good to define them before including any ACPICA files.
While putting things here cannot cover <asm/acpi.h>.

Normally, I will do:

...

#ifdef __KERNEL__

/* some comment */
(one empty line as ACPICA enforces 1 empty line after 1 line comment and no empty lines after a block of comments)
#ifdef CONFIG_ACPI_REDUCED_HARDWARE
#define ACPI_REDUCED_HARDWARE(spaces not tabs here according to ACPICA's coding style)TRUE
#endif

#include <linux/string.h>

The coding style can help ACPICA release process to generate correct Linuxized patches.
It would be good to Linux developers to follow this currently for ACPICA internal code or we may see a small useless divergences commit generated from a back ported Linux commit :-( .
I'm sorry for the inconvenience.

Thanks
-Lv

>  #define ACPI_MACHINE_WIDTH          BITS_PER_LONG
>  #define ACPI_EXPORT_SYMBOL(symbol)  EXPORT_SYMBOL(symbol);
>  #define strtoul                     simple_strtoul
> --
> 1.8.3.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
