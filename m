From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v2] acpi: apei: Add SEI notification type support for
 ARMv8
Date: Wed, 27 Sep 2017 08:52:10 -0700
Message-ID: <20170927155210.GF457@codeaurora.org>
References: <1505373743-7780-1-git-send-email-gengdongjiu@huawei.com>
 <88a71a70-0704-6e47-de09-6f67b91967b6@codeaurora.org>
 <8a622b5b-bcf1-3906-a4be-c3c86b0876fe@huawei.com>
 <18fe5348-d339-f505-4b1b-c35501f40acc@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:51378 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752407AbdI0PwR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Sep 2017 11:52:17 -0400
Content-Disposition: inline
In-Reply-To: <18fe5348-d339-f505-4b1b-c35501f40acc@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tyler Baicar <tbaicar@codeaurora.org>
Cc: gengdongjiu <gengdongjiu@huawei.com>, will.deacon@arm.com, zjzhang@codeaurora.org, catalin.marinas@arm.com, bp@suse.de, james.morse@arm.com, geliangtang@gmail.com, andriy.shevchenko@linux.intel.com, tony.luck@intel.com, austinwc@codeaurora.org, rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com, john.garry@huawei.com, shiju.jose@huawei.com, zhengqiang10@huawei.com, wangxiongfeng2@huawei.com, huangshaoyu@huawei.com, wuquanming@huawei.com

On 09/27, Tyler Baicar wrote:
> On 9/27/2017 6:05 AM, gengdongjiu wrote:
> >Tyler, Stephen
> >
> >On 2017/9/27 3:23, Tyler Baicar wrote:
> >>>Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> >>Tested-by: Tyler Baicar <tbaicar@codeaurora.org>
> >>
> >>Tested this functionality using SEA support.
> >>
> >>++Stephen,
> >>
> >>Something to be aware of, this patch will conflict with https://lkml.org/lkml/2017/9/14/663
> >>It may make sense to just remove the conditions for the NMI configs as part of this patch or in a series with this patch to avoid merge conflicts.
> >In your patch, you only remove ACPI_APEI_SEA for the ARCH_HAVE_NMI_SAFE_CMPXCHG, do you need to remove it for the HAVE_NMI?
> From the latest comments it sounds like Stephen was going to remove
> it from both.
> https://lkml.org/lkml/2017/9/15/350

Sent it now.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
