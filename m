From: "Baicar, Tyler" <tbaicar@codeaurora.org>
Subject: Re: [PATCH v2] acpi: apei: fix the wrongly iterate generic error
 status block
Date: Tue, 15 Aug 2017 12:31:14 -0600
Message-ID: <7921a233-6971-6e3b-9164-01d6176d61c0@codeaurora.org>
References: <1502795713-20945-1-git-send-email-gengdongjiu@huawei.com>
 <CAMj-D2CXOurgPGGGbC7qHX-uWZeMYwh9EfLOS3p3hm+=BvPq7w@mail.gmail.com>
 <20170815161342.jxxf4rndqbs7t5rr@pd.tnic>
 <CAMj-D2AHjR70Fy61aBxof7AxnW+Bz_YgJq-5yOdK+VV8uaF3bA@mail.gmail.com>
 <20170815163239.xm5y6w5yeiaakekv@pd.tnic>
 <CAMj-D2C2S=RoZ7TyhnyX598nHH9xwKQt23mV+u=1tV3+YMMVsQ@mail.gmail.com>
 <20170815165551.4cwa344wm6eptj3d@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:45616 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752577AbdHOSbU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Aug 2017 14:31:20 -0400
In-Reply-To: <20170815165551.4cwa344wm6eptj3d@pd.tnic>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@suse.de>, gengdongjiu <gengdj.1984@gmail.com>
Cc: rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com, john.garry@huawei.com, shiju.jose@huawei.com, zhengqiang10@huawei.com, wangxiongfeng2@huawei.com, huangshaoyu@huawei.com, wuquanming@huawei.com, james.morse@arm.com, geliangtang@gmail.com, andriy.shevchenko@linux.intel.com, tony.luck@intel.com, austinwc@codeaurora.org, shameerali.kolothum.thodi@huawei.com, jonathan.cameron@huawei.com, huangdaode@hisilicon.com, wangzhou1@hisilicon.com

On 8/15/2017 10:55 AM, Borislav Petkov wrote:
> On Wed, Aug 16, 2017 at 12:42:43AM +0800, gengdongjiu wrote:
>> I ever discuss it with Tyler about it, as shown below link, thanks
>>
>> https://lkml.org/lkml/2017/8/14/355
> Tyler's patch fixes ghes_do_proc() - yours cper_estatus_print(). How is
> that merged?
>
Hello Boris,

His patch fixes the define for apei_estatus_for_each_section which in 
turn should fix ghes_do_proc(). So my patch should no longer be needed. 
I'm going to test this out just to verify if fixes the issue I found.

Dongjiu,

This patch changes cper_estatus_print() to use 
apei_estatus_for_each_section. Can you also make that same change to 
cper_estatus_check() since that function is doing the same iteration?

Thanks,
Tyler

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.

