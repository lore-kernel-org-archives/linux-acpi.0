From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 15/45] drivers: pnp: remove duplicate includes
Date: Fri, 8 Dec 2017 01:37:14 +0100
Message-ID: <9d1e8f06-f687-7ee2-f565-efbb2bb17bc1@intel.com>
References: <1512579654-5549-1-git-send-email-pravin.shedge4linux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:65004 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752248AbdLHAhR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 7 Dec 2017 19:37:17 -0500
In-Reply-To: <1512579654-5549-1-git-send-email-pravin.shedge4linux@gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pravin Shedge <pravin.shedge4linux@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On 12/6/2017 6:00 PM, Pravin Shedge wrote:
> These duplicate includes have been found with scripts/checkincludes.pl but
> they have been removed manually to avoid removing false positives.
>
> Signed-off-by: Pravin Shedge <pravin.shedge4linux@gmail.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Or do you want me to apply this?

> ---
>   drivers/pnp/quirks.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/drivers/pnp/quirks.c b/drivers/pnp/quirks.c
> index f054cdd..a0f9a91 100644
> --- a/drivers/pnp/quirks.c
> +++ b/drivers/pnp/quirks.c
> @@ -227,8 +227,6 @@ static void quirk_ad1815_mpu_resources(struct pnp_dev *dev)
>   	dev_info(&dev->dev, "made independent IRQ optional\n");
>   }
>   
> -#include <linux/pci.h>
> -
>   static void quirk_system_pci_resources(struct pnp_dev *dev)
>   {
>   	struct pci_dev *pdev = NULL;


