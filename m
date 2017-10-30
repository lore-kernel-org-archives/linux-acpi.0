From: Tyler Baicar <tbaicar@codeaurora.org>
Subject: Re: [PATCH] Bug fix: Clear ack of GHES table which contain wrong
 Error status block, let new error can fill GHES table.
Date: Mon, 30 Oct 2017 09:53:39 -0400
Message-ID: <61027894-b8ab-b90d-05fa-c8a04acfa42d@codeaurora.org>
References: <1509326594-201050-1-git-send-email-zhengqiang10@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:59004 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751572AbdJ3Nxm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Oct 2017 09:53:42 -0400
In-Reply-To: <1509326594-201050-1-git-send-email-zhengqiang10@huawei.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Qiang Zheng <zhengqiang10@huawei.com>, will.deacon@arm.com, james.morse@arm.com, shiju.jose@huawei.com, rjw@rjwysocki.net
Cc: gengdongjiu@huawei.com, wangxiongfeng2@huawei.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com

On 10/29/2017 9:23 PM, Qiang Zheng wrote:
> Current Error status block processing flow, if wrong format is checked,
> GHES table ack is not cleared.
> It will cause new error can not be filled GHES table, because UEFI
> need check ack to know if error was handled by OS.
>
> This patch solved issue, no matter Error status block format is wrong,
> But GHES table format is corrected, we clear ack.
>
> Signed-off-by: Qiang Zheng <zhengqiang10@huawei.com>
> ---
>   drivers/acpi/apei/ghes.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 077f9ba..b0e0782 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -743,6 +743,7 @@ static int ghes_proc(struct ghes *ghes)
>   	}
>   	ghes_do_proc(ghes, ghes->estatus);
>   
> +out:
The out goto is already at this location. Please sync to the tip:

         ghes_do_proc(ghes, ghes->estatus);

out:
         ghes_clear_estatus(ghes);

         if (rc == -ENOENT)
                 return rc;

         /*
          * GHESv2 type HEST entries introduce support for error acknowledgment,
          * so only acknowledge the error if this support is present.
          */
         if (is_hest_type_generic_v2(ghes))
                 return ghes_ack_error(ghes->generic_v2);

         return rc;


>   	/*
>   	 * GHESv2 type HEST entries introduce support for error acknowledgment,
>   	 * so only acknowledge the error if this support is present.
> @@ -752,7 +753,7 @@ static int ghes_proc(struct ghes *ghes)
>   		if (rc)
>   			return rc;
>   	}
> -out:
> +
>   	ghes_clear_estatus(ghes);
>   	return rc;
>   }

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.

