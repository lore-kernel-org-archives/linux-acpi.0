From: Al Stone <ahs3@redhat.com>
Subject: Re: [PATCH v2 1/1] ACPI / LPSS: change 'does not have' to 'has' in
 comment
Date: Tue, 22 Dec 2015 13:04:31 -0700
Message-ID: <5679ACCF.1000608@redhat.com>
References: <1450729869-115532-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34866 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933159AbbLVUEc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 22 Dec 2015 15:04:32 -0500
In-Reply-To: <1450729869-115532-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org

On 12/21/2015 01:31 PM, Andy Shevchenko wrote:
> The LPSS DMA device has neither _PS0 nor _PS3 method. Fix the wording in
> the comment line.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/acpi/acpi_lpss.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
> index 84d3d90..047281a6 100644
> --- a/drivers/acpi/acpi_lpss.c
> +++ b/drivers/acpi/acpi_lpss.c
> @@ -95,7 +95,7 @@ static unsigned int lpss_quirks;
>  /*
>   * LPSS_QUIRK_ALWAYS_POWER_ON: override power state for LPSS DMA device.
>   *
> - * The LPSS DMA controller does not have neither _PS0 nor _PS3 method. Moreover
> + * The LPSS DMA controller has neither _PS0 nor _PS3 method. Moreover
>   * it can be powered off automatically whenever the last LPSS device goes down.
>   * In case of no power any access to the DMA controller will hang the system.
>   * The behaviour is reproduced on some HP laptops based on Intel BayTrail as
> 

Much better :).  Thanks for the quick turnaround, Andy.

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3@redhat.com
-----------------------------------
