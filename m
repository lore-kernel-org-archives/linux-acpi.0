From: gengdongjiu <gengdj.1984@gmail.com>
Subject: Re: [PATCH v2] acpi: apei: fix the wrongly iterate generic error
 status block
Date: Wed, 16 Aug 2017 05:34:51 +0800
Message-ID: <CAMj-D2DDMYBJY5aW38Q=y+J59d-0tAy0JhmdP8goHKAbJSedag@mail.gmail.com>
References: <1502795713-20945-1-git-send-email-gengdongjiu@huawei.com>
 <CAMj-D2CXOurgPGGGbC7qHX-uWZeMYwh9EfLOS3p3hm+=BvPq7w@mail.gmail.com>
 <20170815161342.jxxf4rndqbs7t5rr@pd.tnic> <CAMj-D2AHjR70Fy61aBxof7AxnW+Bz_YgJq-5yOdK+VV8uaF3bA@mail.gmail.com>
 <20170815163239.xm5y6w5yeiaakekv@pd.tnic> <CAMj-D2C2S=RoZ7TyhnyX598nHH9xwKQt23mV+u=1tV3+YMMVsQ@mail.gmail.com>
 <20170815165551.4cwa344wm6eptj3d@pd.tnic> <7921a233-6971-6e3b-9164-01d6176d61c0@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vk0-f45.google.com ([209.85.213.45]:36357 "EHLO
        mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751624AbdHOVex (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Aug 2017 17:34:53 -0400
In-Reply-To: <7921a233-6971-6e3b-9164-01d6176d61c0@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Baicar, Tyler" <tbaicar@codeaurora.org>
Cc: Borislav Petkov <bp@suse.de>, rjw@rjwysocki.net, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com, John Garry <john.garry@huawei.com>, Shiju Jose <shiju.jose@huawei.com>, zhengqiang10@huawei.com, Xiongfeng Wang <wangxiongfeng2@huawei.com>, Huangshaoyu <huangshaoyu@huawei.com>, wuquanming <wuquanming@huawei.com>, James Morse <james.morse@arm.com>, Geliang Tang <geliangtang@gmail.com>, andriy.shevchenko@linux.intel.com, tony.luck@intel.com, austinwc@codeaurora.org, shameerali.kolothum.thodi@huawei.com, jonathan.cameron@huawei.com, huangdaode@hisilicon.com, wangzhou1@hisilicon.com

Hi Tyler ,

> Hello Boris,
>
> His patch fixes the define for apei_estatus_for_each_section which in turn
> should fix ghes_do_proc(). So my patch should no longer be needed. I'm going
> to test this out just to verify if fixes the issue I found.

I have verified the issue about the iteration for the revision 0x300
generic error data,
it works well. it is good that you will verify that in your  platform.

>
> Dongjiu,
>
> This patch changes cper_estatus_print() to use
> apei_estatus_for_each_section. Can you also make that same change to
> cper_estatus_check() since that function is doing the same iteration?

I will do it, Tyler.


>
> Thanks,
> Tyler
>
> --
> Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
> Technologies, Inc.
> Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project.
>
