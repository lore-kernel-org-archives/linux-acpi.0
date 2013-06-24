From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI / processor: Remove unused macros in processor_driver.c
Date: Tue, 25 Jun 2013 00:32:58 +0200
Message-ID: <4395311.6MOHcFYYSc@vostro.rjw.lan>
References: <1372059393-15996-1-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:49496 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750745Ab3FXWXc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 24 Jun 2013 18:23:32 -0400
In-Reply-To: <1372059393-15996-1-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, patches@linaro.org, linaro-kernel@lists.linaro.org

On Monday, June 24, 2013 03:36:33 PM Hanjun Guo wrote:
> ACPI_PROCESSOR_FILE_INFO, ACPI_PROCESSOR_FILE_THROTTLING and
> ACPI_PROCESSOR_FILE_LIMIT are used for procfs, but this feature was removed
> in commit d09fe555 (ACPI processor: remove deprecated ACPI procfs I/F) long
> ago. So, these macros should also be removed.
> 
> ACPI_PROCESSOR_LIMIT_USER and ACPI_PROCESSOR_LIMIT_THERMAL are not used
> by any code, remove them too.
> 
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>

Queued up for 3.11.

Thanks,
Rafael


> ---
>  drivers/acpi/processor_driver.c |    6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
> index d93963f..823be116 100644
> --- a/drivers/acpi/processor_driver.c
> +++ b/drivers/acpi/processor_driver.c
> @@ -43,16 +43,10 @@
>  
>  #define PREFIX "ACPI: "
>  
> -#define ACPI_PROCESSOR_FILE_INFO	"info"
> -#define ACPI_PROCESSOR_FILE_THROTTLING	"throttling"
> -#define ACPI_PROCESSOR_FILE_LIMIT	"limit"
>  #define ACPI_PROCESSOR_NOTIFY_PERFORMANCE 0x80
>  #define ACPI_PROCESSOR_NOTIFY_POWER	0x81
>  #define ACPI_PROCESSOR_NOTIFY_THROTTLING	0x82
>  
> -#define ACPI_PROCESSOR_LIMIT_USER	0
> -#define ACPI_PROCESSOR_LIMIT_THERMAL	1
> -
>  #define _COMPONENT		ACPI_PROCESSOR_COMPONENT
>  ACPI_MODULE_NAME("processor_driver");
>  
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
