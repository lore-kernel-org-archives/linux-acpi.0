From: "Baicar, Tyler" <tbaicar@codeaurora.org>
Subject: Re: [PATCH v2] acpi: apei: fix the wrongly iterate generic error
 status block
Date: Tue, 15 Aug 2017 17:26:50 -0600
Message-ID: <3747a14c-0801-fe10-f36e-af6458fd7bdf@codeaurora.org>
References: <1502795713-20945-1-git-send-email-gengdongjiu@huawei.com>
 <CAMj-D2CXOurgPGGGbC7qHX-uWZeMYwh9EfLOS3p3hm+=BvPq7w@mail.gmail.com>
 <20170815161342.jxxf4rndqbs7t5rr@pd.tnic>
 <CAMj-D2AHjR70Fy61aBxof7AxnW+Bz_YgJq-5yOdK+VV8uaF3bA@mail.gmail.com>
 <20170815163239.xm5y6w5yeiaakekv@pd.tnic>
 <CAMj-D2C2S=RoZ7TyhnyX598nHH9xwKQt23mV+u=1tV3+YMMVsQ@mail.gmail.com>
 <20170815165551.4cwa344wm6eptj3d@pd.tnic>
 <7921a233-6971-6e3b-9164-01d6176d61c0@codeaurora.org>
 <CAMj-D2DDMYBJY5aW38Q=y+J59d-0tAy0JhmdP8goHKAbJSedag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMj-D2DDMYBJY5aW38Q=y+J59d-0tAy0JhmdP8goHKAbJSedag@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: gengdongjiu <gengdj.1984@gmail.com>
Cc: Borislav Petkov <bp@suse.de>, rjw@rjwysocki.net, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com, John Garry <john.garry@huawei.com>, Shiju Jose <shiju.jose@huawei.com>, zhengqiang10@huawei.com, Xiongfeng Wang <wangxiongfeng2@huawei.com>, Huangshaoyu <huangshaoyu@huawei.com>, wuquanming <wuquanming@huawei.com>, James Morse <james.morse@arm.com>, Geliang Tang <geliangtang@gmail.com>, andriy.shevchenko@linux.intel.com, tony.luck@intel.com, austinwc@codeaurora.org, shameerali.kolothum.thodi@huawei.com, jonathan.cameron@huawei.com, huangdaode@hisilicon.com, wangzhou1@hisilicon.com
List-Id: linux-acpi@vger.kernel.org

On 8/15/2017 3:34 PM, gengdongjiu wrote:
> Hi Tyler ,
>
>> Hello Boris,
>>
>> His patch fixes the define for apei_estatus_for_each_section which in turn
>> should fix ghes_do_proc(). So my patch should no longer be needed. I'm going
>> to test this out just to verify if fixes the issue I found.
> I have verified the issue about the iteration for the revision 0x300
> generic error data,
> it works well. it is good that you will verify that in your  platform.
I've verified that this resolves the issue as well! I'll re-test with 
the next version that adds this usage to cper_estatus_check() and add my 
tested-by after that.

Thanks,
Tyler

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
