Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE9DC77B7D
	for <linux-acpi@archiver.kernel.org>; Mon,  8 May 2023 01:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjEHBz3 (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Sun, 7 May 2023 21:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjEHBz1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 7 May 2023 21:55:27 -0400
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E9AA24B;
        Sun,  7 May 2023 18:55:26 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0Vhyn0p8_1683510918;
Received: from 30.240.112.215(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Vhyn0p8_1683510918)
          by smtp.aliyun-inc.com;
          Mon, 08 May 2023 09:55:21 +0800
Message-ID: <1694e1b3-c4ad-abfe-bf3a-e3210473b3b5@linux.alibaba.com>
Date:   Mon, 8 May 2023 09:55:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH v7 0/2] ACPI: APEI: handle synchronous exceptions with
 proper si_code
Content-Language: en-US
From:   Shuai Xue <xueshuai@linux.alibaba.com>
To:     rafael@kernel.org, wangkefeng.wang@huawei.com,
        tanxiaofei@huawei.com, mawupeng1@huawei.com, tony.luck@intel.com,
        naoya.horiguchi@nec.com
Cc:     linux-acpi@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, justin.he@arm.com,
        akpm@linux-foundation.org, ardb@kernel.org, ashish.kalra@amd.com,
        baolin.wang@linux.alibaba.com, bp@alien8.de,
        cuibixuan@linux.alibaba.com, dave.hansen@linux.intel.com,
        james.morse@arm.com, jarkko@kernel.org, lenb@kernel.org,
        linmiaohe@huawei.com, lvying6@huawei.com, xiexiuqi@huawei.com,
        zhuo.song@linux.alibaba.com
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
 <20230417011407.58319-1-xueshuai@linux.alibaba.com>
 <92f2642e-ab44-913f-24fa-3313acd905f8@linux.alibaba.com>
In-Reply-To: <92f2642e-ab44-913f-24fa-3313acd905f8@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 2023/4/24 14:24, Shuai Xue wrote:
> 
> 
> On 2023/4/17 AM9:14, Shuai Xue wrote:
>> changes since v6:
>> - add more explicty error message suggested by Xiaofei
>> - pick up reviewed-by tag from Xiaofei
>> - pick up internal reviewed-by tag from Baolin
>>
>> changes since v5 by addressing comments from Kefeng:
>> - document return value of memory_failure()
>> - drop redundant comments in call site of memory_failure() 
>> - make ghes_do_proc void and handle abnormal case within it
>> - pick up reviewed-by tag from Kefeng Wang 
>>
>> changes since v4 by addressing comments from Xiaofei:
>> - do a force kill only for abnormal sync errors
>>
>> changes since v3 by addressing comments from Xiaofei:
>> - do a force kill for abnormal memory failure error such as invalid PA,
>> unexpected severity, OOM, etc
>> - pcik up tested-by tag from Ma Wupeng
>>
>> changes since v2 by addressing comments from Naoya:
>> - rename mce_task_work to sync_task_work
>> - drop ACPI_HEST_NOTIFY_MCE case in is_hest_sync_notify()
>> - add steps to reproduce this problem in cover letter
>>
>> changes since v1:
>> - synchronous events by notify type
>> - Link: https://lore.kernel.org/lkml/20221206153354.92394-3-xueshuai@linux.alibaba.com/
>>
>> Shuai Xue (2):
>>   ACPI: APEI: set memory failure flags as MF_ACTION_REQUIRED on
>>     synchronous events
>>   ACPI: APEI: handle synchronous exceptions in task work
>>
>>  arch/x86/kernel/cpu/mce/core.c |   9 +--
>>  drivers/acpi/apei/ghes.c       | 113 ++++++++++++++++++++++-----------
>>  include/acpi/ghes.h            |   3 -
>>  mm/memory-failure.c            |  17 +----
>>  4 files changed, 79 insertions(+), 63 deletions(-)
>>
> 
> Hi, Rafael,
> 
> Gentle ping. Are you happy to queue this patch set into your next tree, so that we can merge
> that in next merge window.
> 
> Thank you.
> 

Gentle ping :)

Thanks.

> Best Regards,
> Shuai


