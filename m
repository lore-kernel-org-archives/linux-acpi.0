From: Al Stone <ahs3@redhat.com>
Subject: Re: [PATCH v1 1/1] ACPI / LPSS: change 'does not' to 'does' in
 comment
Date: Mon, 21 Dec 2015 10:59:07 -0700
Message-ID: <56783DEB.7040304@redhat.com>
References: <1450720245-67575-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46672 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750965AbbLUR7I (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 Dec 2015 12:59:08 -0500
In-Reply-To: <1450720245-67575-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org

On 12/21/2015 10:50 AM, Andy Shevchenko wrote:
> The LPSS DMA device does have neither _PS0 nor _PS3 method. Fix the wording in
> the comment line.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/acpi/acpi_lpss.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
> index 84d3d90..6c6661d 100644
> --- a/drivers/acpi/acpi_lpss.c
> +++ b/drivers/acpi/acpi_lpss.c
> @@ -95,7 +95,7 @@ static unsigned int lpss_quirks;
>  /*
>   * LPSS_QUIRK_ALWAYS_POWER_ON: override power state for LPSS DMA device.
>   *
> - * The LPSS DMA controller does not have neither _PS0 nor _PS3 method. Moreover
> + * The LPSS DMA controller does have neither _PS0 nor _PS3 method. Moreover

Neither of the above are very clear.  I think proper English would be:

    The LPSS DMA controller has neither a _PS0 nor a _PS3 method.

or, alternatively:

    The LPSS DMA controller does not have either a _PS0 or a _PS3 method.

This assumes that the point of the statement is to say that _PS0 and _PS3
methods do not exist for the LPSS DMA controller.

>   * it can be powered off automatically whenever the last LPSS device goes down.
>   * In case of no power any access to the DMA controller will hang the system.
>   * The behaviour is reproduced on some HP laptops based on Intel BayTrail as
> 


-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3@redhat.com
-----------------------------------
