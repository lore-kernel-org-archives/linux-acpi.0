From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v6 00/10] acpi, clocksource: add GTDT driver and GTDT
 support in arm_arch_timer
Date: Sat, 9 Jul 2016 11:00:07 +0800
Message-ID: <2f0f9522-2d91-4f2f-e4bb-9c63f7676e78@linaro.org>
References: <1467224153-22873-1-git-send-email-fu.wei@linaro.org>
 <1890708.ZTyM2PUGdP@vostro.rjw.lan> <20160707134023.GA655@red-moon>
 <1603704.EGiVTcCxLR@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:34164 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932915AbcGIDAf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Jul 2016 23:00:35 -0400
Received: by mail-pf0-f173.google.com with SMTP id h14so18093949pfe.1
        for <linux-acpi@vger.kernel.org>; Fri, 08 Jul 2016 20:00:35 -0700 (PDT)
In-Reply-To: <1603704.EGiVTcCxLR@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Graeme Gregory <gg@slimlogic.co.uk>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Fu Wei <fu.wei@linaro.org>, Len Brown <lenb@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <marc.zyngier@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, rruigrok@codeaurora.org, harba@codeaurora.org, Christopher Covington <cov@codeaurora.org>, Timur Tabi <timur@codeaurora.org>, G Gregory <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>, Jon Masters <jcm@redhat.com>, wei@redhat.com, Arnd Bergmann <arnd@arndb.de>, Wim

On 2016/7/7 21:58, Rafael J. Wysocki wrote:
> On Thursday, July 07, 2016 02:40:23 PM Lorenzo Pieralisi wrote:
>> [+Sudeep]
>>
>> On Thu, Jul 07, 2016 at 02:03:17PM +0200, Rafael J. Wysocki wrote:
>>
>> [...]
>>
>>>>>> So is this a documentation issue in which case Fu Wei can add that to
>>>>>> the file to explain its limited to ARM64. Or we could even rename the
>>>>>> file acpi_arm64_gtdt.c
>>>>>>
>>>>>> It seems a pity as the comment on this series were minors to block
>>>>>> things on a filename/location.
>>>>>
>>>>> Let me repeat what I said above:
>>>>>
>>>>> I'm mostly concerned about how (and by whom) that code is going to be
>>>>> maintained going forward.
>>>>>
>>>>> This is not about documentation, it is about responsibility.
>>>>>
>>>>> Honestly, I don't think I'm the right maintainer to apply the patch
>>>>> introducing this code and then handle bug reports regarding it and so
>>>>> on.  That has to be done by somebody else.
>>>>
>>>> I'm working on ACPI for years and upstreamed the ARM64 ACPI core
>>>> support (with lots of people's help), I'm willing to maintain the ARM64
>>>> ACPI code under drivers/acpi/ if no objections.
>>>
>>> OK
>>
>> I would ask you please to add Sudeep and myself for the ARM64 specific
>> ACPI code maintainership too.
>
> OK
>
>>> Can the ARM64-specific code go under drivers/acpi/arm64/ then, for clarity?

I'm fine with it as it helps for maintain.

Thanks
Hanjun
