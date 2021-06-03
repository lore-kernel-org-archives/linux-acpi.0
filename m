Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB2CC4708F
	for <linux-acpi@archiver.kernel.org>; Thu,  3 Jun 2021 02:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0C5B613EE
	for <linux-acpi@archiver.kernel.org>; Thu,  3 Jun 2021 02:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbhFCCyq (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Wed, 2 Jun 2021 22:54:46 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2971 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhFCCyp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Jun 2021 22:54:45 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FwVk207rdz6tq7;
        Thu,  3 Jun 2021 10:50:02 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 3 Jun 2021 10:53:00 +0800
Received: from [10.174.179.71] (10.174.179.71) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 3 Jun 2021 10:53:00 +0800
Subject: Re: [PATCH] Revert "ACPI: sleep: Put the FACS table after using it"
To:     Zhang Rui <rui.zhang@intel.com>, <linux-acpi@vger.kernel.org>
CC:     <rjw@rjwysocki.net>
References: <20210603023414.2389-1-rui.zhang@intel.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <473f220f-b16f-b813-4246-2d1456b60d38@huawei.com>
Date:   Thu, 3 Jun 2021 10:52:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20210603023414.2389-1-rui.zhang@intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.71]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2021/6/3 10:34, Zhang Rui wrote:
> Commit 95722237cb2a ("ACPI: sleep: Put the FACS table after using it")
> puts the FACS table during initialization.
> But the hardware signature bits in the FACS table need to be accessed,
> after every hibernation, to compare with the original hardware signature.
> 
> So there is no reason to release the FACS table mapping after
> initialization.
> 
> This reverts commit 95722237cb2ae4f7b73471058cdb19e8f4057c93.
> 
> An alternative solution is to use acpi_gbl_FACS variable instead, which
> is mapped by the ACPICA core and never released.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=212277
> Reported-by: Stephan Hohe <sth.dev@tejp.de>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>   drivers/acpi/sleep.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index df386571da98..3bb2adef8490 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -1009,10 +1009,8 @@ static void acpi_sleep_hibernate_setup(void)
>   		return;
>   
>   	acpi_get_table(ACPI_SIG_FACS, 1, (struct acpi_table_header **)&facs);
> -	if (facs) {
> +	if (facs)
>   		s4_hardware_signature = facs->hardware_signature;
> -		acpi_put_table((struct acpi_table_header *)facs);
> -	}
>   }
>   #else /* !CONFIG_HIBERNATION */
>   static inline void acpi_sleep_hibernate_setup(void) {}

My bad, thanks for the fix.

Patches for ACPI subsystem, subject will have the prefix "ACPI: ",
could you please add that?

Thanks
Hanjun
