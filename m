From: "Baicar, Tyler" <tbaicar@codeaurora.org>
Subject: Re: [PATCH V2] acpi: apei: clear error status before acknowledging
 the error
Date: Wed, 23 Aug 2017 14:55:09 -0600
Message-ID: <3b5fb362-c184-7dde-ca0a-b6f0842fec63@codeaurora.org>
References: <1501798351-10337-1-git-send-email-tbaicar@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:55340 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932407AbdHWUzN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Aug 2017 16:55:13 -0400
In-Reply-To: <1501798351-10337-1-git-send-email-tbaicar@codeaurora.org>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, will.deacon@arm.com, james.morse@arm.com, bp@suse.de, shiju.jose@huawei.com, geliangtang@gmail.com, andriy.shevchenko@linux.intel.com, tony.luck@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, austinwc@codeaurora.org

Hello Boris,

And input on this patch?

Thanks,
Tyler

On 8/3/2017 4:12 PM, Tyler Baicar wrote:
> Currently we acknowledge errors before clearing the error status.
> This could cause a new error to be populated by firmware in-between
> the error acknowledgment and the error status clearing which would
> cause the second error's status to be cleared without being handled.
> So, clear the error status before acknowledging the errors.
>
> Also, make sure to acknowledge the error if the error status read
> fails.
>
> V2: Only send error ack if there was an error populated
>      Remove curly braces that are no longer needed
>
> Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
> ---
>   drivers/acpi/apei/ghes.c | 9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index d661d45..cda4a4f 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -743,17 +743,14 @@ static int ghes_proc(struct ghes *ghes)
>   	}
>   	ghes_do_proc(ghes, ghes->estatus);
>   
> +out:
> +	ghes_clear_estatus(ghes);
>   	/*
>   	 * GHESv2 type HEST entries introduce support for error acknowledgment,
>   	 * so only acknowledge the error if this support is present.
>   	 */
> -	if (is_hest_type_generic_v2(ghes)) {
> +	if (is_hest_type_generic_v2(ghes) && rc != -ENOENT)
>   		rc = ghes_ack_error(ghes->generic_v2);
> -		if (rc)
> -			return rc;
> -	}
> -out:
> -	ghes_clear_estatus(ghes);
>   	return rc;
>   }
>   

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.

