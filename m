From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH] ACPICA: arm64: fix compile apci tools fail for arm64
Date: Thu, 20 Oct 2016 18:42:00 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886A256324@SHSMSX101.ccr.corp.intel.com>
References: <1476402698-40963-1-git-send-email-xieyisheng1@huawei.com>
 <1AE640813FDE7649BE1B193DEA596E886A253666@SHSMSX101.ccr.corp.intel.com>
 <696226b1-7024-a4d6-8bea-ddbf6d08a564@huawei.com>
 <1AE640813FDE7649BE1B193DEA596E886A253FBF@SHSMSX101.ccr.corp.intel.com>
 <c88b5433-fbf0-1a15-11b2-b47c1872d48d@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:2132 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933059AbcJTSmF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 20 Oct 2016 14:42:05 -0400
In-Reply-To: <c88b5433-fbf0-1a15-11b2-b47c1872d48d@huawei.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yisheng Xie <xieyisheng1@huawei.com>, "Moore, Robert" <robert.moore@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "wmiles@sgl.com" <wmiles@sgl.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "guohanjun@huawei.com" <guohanjun@huawei.com>, "wangxiongfeng2@huawei.com" <wangxiongfeng2@huawei.com>

Hi,

> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Yisheng
> Xie
> Subject: Re: [PATCH] ACPICA: arm64: fix compile apci tools fail for arm64
> 
> Hi,
> 
> On 2016/10/19 6:07, Zheng, Lv wrote:
> > Hi,
> >
> > I'm not sure what you mean.
> > I mean you need ACPI_USE_SYSTEM_INTTYPES in case s64 has already been defined in that environment.
> > Are you sure s64 should be defined for your environment?
> >
> s64 is not defined in my build environment but in kernel code.

Yes, in-kernel ACPICA applications trickily reused this to get it compiled in kernel source tree with minimal porting effort.
And it is working on x86.

> 
> > IMO, s64 is kernel space specific, while you are compiling user space tools.
> > It looks to me like there is something wrong with ARM kernel's asm/types.h.
> >
> >> I listed in change log. And I also have tried that way.
> >> However, it still have many other errors.(I am sorry to not have listed all of them.)
> >>
> >> From the following log, you can see, all of the conflict type is from signal.h.
> >> And maybe this patch is a better way to fix these compile error, without too much
> >> change of code.
> >>
> >> Are you sure that it will cause order problem when build ACPICA on other build
> >> environment, for it only effect aarch64.
> >
> > I'm not sure what this is.
> > How did you get this?
> > Were you compiling kernel acpi tools or compiling the kernel itself?
> >
> It's about compiling kernel acpi tools.
> 
> > For tool compilation, are you sure you have correctly configured your cross-compilation environment?
> Maybe it is not my cross-compilation environment problem, for your also can reproduce it,
> as your said in another email, right?

Yes, I reproduced it.
By commenting out <signal.h> inclusion from acenv.h.
Tools can be built by aarch64-linux-gnu tool chain downloaded from linaro.

However this is still not the root cause, IMO.

Thanks
Lv

> 
> > Will you see problems in compiling ACPICA applications from:
> > https://github.com/acpica/acpica
> >
> 
> > Thanks
> > Lv
> >
> > .
> >
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
