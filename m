From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] ACPI: fix section mismatch warning
Date: Thu, 09 Dec 2010 13:05:15 +0800
Message-ID: <1291871115.1715.116.camel@rui>
References: <1291865712-31557-1-git-send-email-namhyung@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:54298 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750711Ab0LIFE5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 9 Dec 2010 00:04:57 -0500
In-Reply-To: <1291865712-31557-1-git-send-email-namhyung@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Namhyung Kim <namhyung@gmail.com>
Cc: Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, 2010-12-09 at 11:35 +0800, Namhyung Kim wrote:
> Annotate acpi_os_initialize1() as __init to fix following warning:
> 
>   LD      vmlinux.o
>   MODPOST vmlinux.o
> WARNING: vmlinux.o(.text+0x231587): Section mismatch in reference from the function
> 	 acpi_os_initialize1() to the function .init.text:acpi_osi_setup_late()
> The function acpi_os_initialize1() references
> the function __init acpi_osi_setup_late().
> This is often because acpi_os_initialize1 lacks a __init
> annotation or the annotation of acpi_osi_setup_late is wrong.
> 
> Signed-off-by: Namhyung Kim <namhyung@gmail.com>

yes, this is the same patch as
https://patchwork.kernel.org/patch/389432/

thanks,
rui

> ---
>  drivers/acpi/osl.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index 966feddf6b1b..f7227e990b0f 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -1530,7 +1530,7 @@ acpi_status __init acpi_os_initialize(void)
>  	return AE_OK;
>  }
>  
> -acpi_status acpi_os_initialize1(void)
> +acpi_status __init acpi_os_initialize1(void)
>  {
>  	kacpid_wq = create_workqueue("kacpid");
>  	kacpi_notify_wq = create_workqueue("kacpi_notify");


