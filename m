From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH] ACPICA / hwreg: Use acpi_gbl_reduced_hardware to
 prevent accessing PM registers
Date: Tue, 24 Sep 2013 00:09:29 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E8802465915@SHSMSX101.ccr.corp.intel.com>
References: <1379066741-23689-1-git-send-email-hanjun.guo@linaro.org>
 <94F2FBAB4432B54E8AACC7DFDE6C92E36FEEBC6A@ORSMSX103.amr.corp.intel.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E36FEEC15B@ORSMSX103.amr.corp.intel.com>
 <52366F91.30204@linaro.org>
 <94F2FBAB4432B54E8AACC7DFDE6C92E36FEEC56A@ORSMSX103.amr.corp.intel.com>
 <52397239.9080606@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:49487 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752566Ab3IXAJj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Sep 2013 20:09:39 -0400
In-Reply-To: <52397239.9080606@linaro.org>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>, "Moore, Robert" <robert.moore@intel.com>
Cc: "'Rafael J. Wysocki'" <rjw@sisk.pl>, 'Len Brown' <lenb@kernel.org>, "Box, David E" <david.e.box@intel.com>, "'linux-acpi@vger.kernel.org'" <linux-acpi@vger.kernel.org>, "'patches@linaro.org'" <patches@linaro.org>, "'linaro-kernel@lists.linaro.org'" <linaro-kernel@lists.linaro.org>, "'linaro-acpi@lists.linaro.org'" <linaro-acpi@lists.linaro.org>



> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Hanjun Guo
> Sent: Wednesday, September 18, 2013 5:28 PM
> To: Moore, Robert
> Cc: 'Rafael J. Wysocki'; 'Len Brown'; Box, David E; Zheng, Lv; 'linux-acpi@vger.kernel.org'; 'patches@linaro.org';
> 'linaro-kernel@lists.linaro.org'; 'linaro-acpi@lists.linaro.org'
> Subject: Re: [PATCH] ACPICA / hwreg: Use acpi_gbl_reduced_hardware to prevent accessing PM registers
> 
> On 2013-9-17 1:26, Moore, Robert wrote:
> > + #define ACPI_REDUCED_HARDWARE           TRUE
> >
> > The intent of this feature is of course, to remove all code that is not needed -- specifically for hardware-reduced machines where the size
> of the kernel is important.
> 
> Ok, how about this patch below, is it reasonable to you?
> 
> From b10bc1d2f9a3ff09abfb6990412aa1cf62d56937 Mon Sep 17 00:00:00 2001
> From: Hanjun Guo <hanjun.guo@linaro.org>
> Date: Wed, 18 Sep 2013 17:19:23 +0800
> Subject: [PATCH] ACPI: Introduce CONFIG_ACPI_REDUCED_HARDWARE to enable
>  reduced hardware
> 
> If we want to enable reduced hardware ACPI on some platform (such as ARM),
> we need to modify the kernel code and set ACPI_REDUCED_HARDWARE to TRUE.
> 
> This is not reasonable, so introduce a kernel config to enable it, and
> no need for kernel modification when we use hardware-reduced ACPI.
> 
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  drivers/acpi/Kconfig    |    8 ++++++++
>  include/acpi/acconfig.h |    4 ++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 0d7f6eb..1232a7b 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -413,6 +413,14 @@ config ACPI_BGRT
>           data from the firmware boot splash. It will appear under
>           /sys/firmware/acpi/bgrt/ .
> 
> +config ACPI_REDUCED_HARDWARE
> +       bool "Hardware-reduced ACPI support"
> +       depends on ARM || ARM64
> +        help
> +         This config adds support for Hardware-reduced ACPI. When this option
> +         is selected, will generate a specialized version of ACPICA that ONLY
> +         supports the ACPI 5.0 "reduced hardware".
> +
>  source "drivers/acpi/apei/Kconfig"
> 
>  endif  # ACPI
> diff --git a/include/acpi/acconfig.h b/include/acpi/acconfig.h
> index 1c16f82..15254f5 100644
> --- a/include/acpi/acconfig.h
> +++ b/include/acpi/acconfig.h
> @@ -100,7 +100,11 @@
>   *      ACPI PM timer
>   *      FACS table (Waking vectors and Global Lock)
>   */
> +#ifdef CONFIG_ACPI_REDUCED_HARDWARE
> +#define ACPI_REDUCED_HARDWARE           TRUE
> +#else
>  #define ACPI_REDUCED_HARDWARE           FALSE
> +#endif /* CONFIG_ACPI_REDUCED_HARDWARE */

The acconfig.h is not meant to be modified by OSPM and CONFIG_ACPI_REDUCED_HARDWARE does not belong to ACPICA, so it should go into include/acpi/platform/aclinux.h.
Well, I believe no one has ever tested the codes marked out by the ACPI_REDUCED_HARDWARE configurable.

Thanks
-Lv

> 
>  /******************************************************************************
>   *
> --
> 1.7.9.5
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
