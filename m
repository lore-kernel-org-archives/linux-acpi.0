From: Yisheng Xie <xieyisheng1@huawei.com>
Subject: Re: [PATCH] ACPICA: arm64: fix compile apci tools fail for arm64
Date: Thu, 20 Oct 2016 09:45:43 +0800
Message-ID: <c88b5433-fbf0-1a15-11b2-b47c1872d48d@huawei.com>
References: <1476402698-40963-1-git-send-email-xieyisheng1@huawei.com>
 <1AE640813FDE7649BE1B193DEA596E886A253666@SHSMSX101.ccr.corp.intel.com>
 <696226b1-7024-a4d6-8bea-ddbf6d08a564@huawei.com>
 <1AE640813FDE7649BE1B193DEA596E886A253FBF@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:29901 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756600AbcJTBqL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Oct 2016 21:46:11 -0400
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E886A253FBF@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>, "Moore, Robert" <robert.moore@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "wmiles@sgl.com" <wmiles@sgl.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "guohanjun@huawei.com" <guohanjun@huawei.com>, "wangxiongfeng2@huawei.com" <wangxiongfeng2@huawei.com>

Hi,

On 2016/10/19 6:07, Zheng, Lv wrote:
> Hi,
> 
> I'm not sure what you mean.
> I mean you need ACPI_USE_SYSTEM_INTTYPES in case s64 has already been defined in that environment.
> Are you sure s64 should be defined for your environment?
> 
s64 is not defined in my build environment but in kernel code.

> IMO, s64 is kernel space specific, while you are compiling user space tools.
> It looks to me like there is something wrong with ARM kernel's asm/types.h.
> 
>> I listed in change log. And I also have tried that way.
>> However, it still have many other errors.(I am sorry to not have listed all of them.)
>>
>> From the following log, you can see, all of the conflict type is from signal.h.
>> And maybe this patch is a better way to fix these compile error, without too much
>> change of code.
>>
>> Are you sure that it will cause order problem when build ACPICA on other build
>> environment, for it only effect aarch64.
> 
> I'm not sure what this is.
> How did you get this?
> Were you compiling kernel acpi tools or compiling the kernel itself?
> 
It's about compiling kernel acpi tools.

> For tool compilation, are you sure you have correctly configured your cross-compilation environment?
Maybe it is not my cross-compilation environment problem, for your also can reproduce it,
as your said in another email, right?

> Will you see problems in compiling ACPICA applications from:
> https://github.com/acpica/acpica
> 

> Thanks
> Lv
> 
> .
> 

