From: gengdongjiu <gengdongjiu@huawei.com>
Subject: Re: [PATCH v2] acpi: apei: Add SEI notification type support for
 ARMv8
Date: Wed, 27 Sep 2017 09:30:25 +0800
Message-ID: <56038746-a5ee-3957-e27b-2a20c628377b@huawei.com>
References: <1505373743-7780-1-git-send-email-gengdongjiu@huawei.com>
 <88a71a70-0704-6e47-de09-6f67b91967b6@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga05-in.huawei.com ([45.249.212.191]:7028 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934797AbdI0Bbg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 26 Sep 2017 21:31:36 -0400
In-Reply-To: <88a71a70-0704-6e47-de09-6f67b91967b6@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tyler Baicar <tbaicar@codeaurora.org>, will.deacon@arm.com, zjzhang@codeaurora.org, catalin.marinas@arm.com, bp@suse.de, james.morse@arm.com, geliangtang@gmail.com, andriy.shevchenko@linux.intel.com, tony.luck@intel.com, austinwc@codeaurora.org, rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com, john.garry@huawei.com, shiju.jose@huawei.com, zhengqiang10@huawei.com, wangxiongfeng2@huawei.com, Stephen Boyd <sboyd@codeaurora.org>
Cc: huangshaoyu@huawei.com, wuquanming@huawei.com

Hi Tyler,

   Thank you very much for your test and comments.

On 2017/9/27 3:23, Tyler Baicar wrote:
>> should identify the address to a invalid value.
>>
>> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> Tested-by: Tyler Baicar <tbaicar@codeaurora.org>
> 
> Tested this functionality using SEA support.

Thanks for your test.

> 
> ++Stephen,
> 
> Something to be aware of, this patch will conflict with https://lkml.org/lkml/2017/9/14/663
> It may make sense to just remove the conditions for the NMI configs as part of this patch or in a series with this patch to avoid merge conflicts.

Ok, Today I will modify it. Thanks for the pointing out.


> 
> Thanks,
> Tyler

