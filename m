From: "Baicar, Tyler" <tbaicar@codeaurora.org>
Subject: Re: [PATCH] acpi: apei: fix the wrongly parse generic error status
 block
Date: Thu, 10 Aug 2017 11:48:00 -0600
Message-ID: <9ea70eed-f743-0c8b-2a70-27ce4c0d8705@codeaurora.org>
References: <1502388412-20273-1-git-send-email-gengdongjiu@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:53894 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753145AbdHJRsC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Aug 2017 13:48:02 -0400
In-Reply-To: <1502388412-20273-1-git-send-email-gengdongjiu@huawei.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dongjiu Geng <gengdongjiu@huawei.com>, rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Hello,

I have already posted a patch fixing this. Please see:

https://lkml.org/lkml/2017/8/3/824

This makes the loop identical to the CPER code which prints the estatus 
blocks to the kernel logs.

Thanks,

Tyler


On 8/10/2017 12:06 PM, Dongjiu Geng wrote:
> The revision 0x300 generic error data entry is different with the old
> version. when ghes_do_proc traverses to get the data entry, it does not
> consider this difference. so when error status block has revision 0x300
> data entry, it will have issue.
>
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> ---
>   drivers/acpi/apei/apei-internal.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/apei/apei-internal.h b/drivers/acpi/apei/apei-internal.h
> index 6e9f14c0a71b..6491f1c4a96e 100644
> --- a/drivers/acpi/apei/apei-internal.h
> +++ b/drivers/acpi/apei/apei-internal.h
> @@ -122,8 +122,8 @@ struct dentry *apei_get_debugfs_dir(void);
>   
>   #define apei_estatus_for_each_section(estatus, section)			\
>   	for (section = (struct acpi_hest_generic_data *)(estatus + 1);	\
> -	     (void *)section - (void *)estatus < estatus->data_length;	\
> -	     section = (void *)(section+1) + section->error_data_length)
> +	     (void *)section - (void *)(estatus + 1) < estatus->data_length; \
> +	     section = acpi_hest_get_next(section))
>   
>   static inline u32 cper_estatus_len(struct acpi_hest_generic_status *estatus)
>   {

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.

