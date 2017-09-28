From: gengdongjiu <gengdongjiu@huawei.com>
Subject: Re: [PATCH v2] acpi: apei: Add SEI notification type support for
 ARMv8
Date: Thu, 28 Sep 2017 20:29:13 +0800
Message-ID: <e33b84a1-def7-7098-cbcf-627de0a24295@huawei.com>
References: <1505373743-7780-1-git-send-email-gengdongjiu@huawei.com>
 <88a71a70-0704-6e47-de09-6f67b91967b6@codeaurora.org>
 <8a622b5b-bcf1-3906-a4be-c3c86b0876fe@huawei.com>
 <18fe5348-d339-f505-4b1b-c35501f40acc@codeaurora.org>
 <20170927155210.GF457@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:7465 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752851AbdI1M3p (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 28 Sep 2017 08:29:45 -0400
In-Reply-To: <20170927155210.GF457@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>, Tyler Baicar <tbaicar@codeaurora.org>
Cc: will.deacon@arm.com, zjzhang@codeaurora.org, catalin.marinas@arm.com, bp@suse.de, james.morse@arm.com, geliangtang@gmail.com, andriy.shevchenko@linux.intel.com, tony.luck@intel.com, austinwc@codeaurora.org, rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com, john.garry@huawei.com, shiju.jose@huawei.com, zhengqiang10@huawei.com, wangxiongfeng2@huawei.com, huangshaoyu@huawei.com, wuquanming@huawei.com

Hi Stephen, Tyler

On 2017/9/27 23:52, Stephen Boyd wrote:
>>>> Something to be aware of, this patch will conflict with https://lkml.org/lkml/2017/9/14/663
>>>> It may make sense to just remove the conditions for the NMI configs as part of this patch or in a series with this patch to avoid merge conflicts.
>>> In your patch, you only remove ACPI_APEI_SEA for the ARCH_HAVE_NMI_SAFE_CMPXCHG, do you need to remove it for the HAVE_NMI?
>> From the latest comments it sounds like Stephen was going to remove
>> it from both.
>> https://lkml.org/lkml/2017/9/15/350
> Sent it now.

I updated my patches. hope you can review again. only a little change. thanks

[PATCH v3 1/2] acpi: apei: remove the unused dead-code for SEA notification type
[PATCH v3 2/2] acpi: apei: Add SEI notification type support for ARMv8

