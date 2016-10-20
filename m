From: "Baicar, Tyler" <tbaicar@codeaurora.org>
Subject: Re: [PATCH] acpi/apei: Fix in-correct return value
Date: Thu, 20 Oct 2016 13:51:31 -0600
Message-ID: <a159bf94-223b-7ec5-b4a5-16ab65662e1e@codeaurora.org>
References: <20161018160719.31252-1-punit.agrawal@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:44485 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932694AbcJTTve (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Oct 2016 15:51:34 -0400
In-Reply-To: <20161018160719.31252-1-punit.agrawal@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Punit Agrawal <punit.agrawal@arm.com>, linux-acpi@vger.kernel.org, rjw@rjwysocki.net
Cc: linux-kernel@vger.kernel.org, bp@suse.de, Len Brown <lenb@kernel.org>

On 10/18/2016 10:07 AM, Punit Agrawal wrote:
> Although ghes_proc tests for error while reading the error status, it
> always return success (0). Fix this by propagating the return value.
>
> Fixes: d334a49113a4a33 ("ACPI, APEI, Generic Hardware Error Source memory error support")
> Signed-of-by: Punit Agrawal <punit.agrawa.@arm.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
Tested-by: Tyler Baicar <tbaicar@codeaurora.org>

Thanks,
Tyler
> ---
>   drivers/acpi/apei/ghes.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index f0a029e..0d099a2 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -662,7 +662,7 @@ static int ghes_proc(struct ghes *ghes)
>   	ghes_do_proc(ghes, ghes->estatus);
>   out:
>   	ghes_clear_estatus(ghes);
> -	return 0;
> +	return rc;
>   }
>   
>   static void ghes_add_timer(struct ghes *ghes)

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.

