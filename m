From: "Baicar, Tyler" <tbaicar@codeaurora.org>
Subject: Re: [PATCH] ACPI / GED: use late init to allow other drivers init
Date: Mon, 24 Apr 2017 16:49:59 -0600
Message-ID: <f9fd6291-8439-7add-b6b2-f7e99dcbc558@codeaurora.org>
References: <1492813704-32280-1-git-send-email-okaya@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:53472 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S977711AbdDXWuC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Apr 2017 18:50:02 -0400
In-Reply-To: <1492813704-32280-1-git-send-email-okaya@codeaurora.org>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sinan Kaya <okaya@codeaurora.org>, linux-acpi@vger.kernel.org, timur@codeaurora.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org

On 4/21/2017 4:28 PM, Sinan Kaya wrote:
> GED driver is currently set up as a platform driver. On modern operating
> systems, most of the drivers are compiled as kernel modules. It is possible
> that a GED interrupt event is received and the driver such as GHES/GPIO/I2C
> to service it is not available yet. To accommodate this use case, delay
> GED driver load to the late init phase.
>
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
Tested-by: Tyler Baicar <tbaicar@codeaurora.org>

This resolves the GHES issue described here: 
https://lkml.org/lkml/2017/3/28/1083

Thanks,
Tyler
> ---
>   drivers/acpi/evged.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/evged.c b/drivers/acpi/evged.c
> index 46f0603..30e638b 100644
> --- a/drivers/acpi/evged.c
> +++ b/drivers/acpi/evged.c
> @@ -151,4 +151,10 @@ static int ged_probe(struct platform_device *pdev)
>   		.acpi_match_table = ACPI_PTR(ged_acpi_ids),
>   	},
>   };
> -builtin_platform_driver(ged_driver);
> +
> +static __init int ged_init(void)
> +{
> +	return platform_driver_register(&ged_driver);
> +}
> +
> +late_initcall(ged_init);

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.

