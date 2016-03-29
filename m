From: Fu Wei <fu.wei@linaro.org>
Subject: Re: [RESEND PATCH v4 1/5] clocksource: move some enums and marcos to
 header file for arm_arch_timer
Date: Tue, 29 Mar 2016 17:38:49 +0800
Message-ID: <CADyBb7tZ5UDGoZw1C1Db5r4UTSXCTrdeJEAaXVWSMY7qbD9TFg@mail.gmail.com>
References: <1458288053-29031-1-git-send-email-fu.wei@linaro.org>
	<1458288053-29031-2-git-send-email-fu.wei@linaro.org>
	<alpine.DEB.2.11.1603181016560.3978@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:33242 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994AbcC2Jiu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Mar 2016 05:38:50 -0400
Received: by mail-oi0-f47.google.com with SMTP id d205so14103588oia.0
        for <linux-acpi@vger.kernel.org>; Tue, 29 Mar 2016 02:38:50 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1603181016560.3978@nanos>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, linux-arm-kernel@lists.infradead.org, Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Richard Ruigrok <rruigrok@codeaurora.org>, "Abdulhamid, Harb" <harba@codeaurora.org>, Christopher Covington <cov@codeaurora.org>, Timur Tabi <timur@codeaurora.org>, G Gregory <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>, Jon Masters <jcm@redhat.com>, wei@redhat.com, Arnd Bergmann <arnd@arndb.de>, Wim Van Sebroeck <wim@iguana.be>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, Leo Duran <leo.duran@amd.com>

Hi Thomas,

On 18 March 2016 at 17:27, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Fri, 18 Mar 2016, fu.wei@linaro.org wrote:
>
> Subject: clocksource: move some enums and marcos to header file for arm_arch_timer
>
> That sucks.
>
> 1) The prefix is crap. It suggests this is about the generic clocksource code
>
>    clocksource/drivers/arm_arch_timer:
>
>    Is the proper prefix
>
> 2) Sentences start with upper case letters
>
> 3) What exactly are 'marcos' ?
>
> So a useful subject line would be;
>
> clocksource/drivers/arm_arch_timer: Move enums and defines to header file
>
>> From: Fu Wei <fu.wei@linaro.org>
>>
>> The patch sorts out the code for arm_arch_timer:
>
> What does it sort out? Nothing, AFAICT.
>
> You miss to explain WHY you are doing this. The list below is completely
> useless because one can see that from the patch.
>
> So this wants to be something like this:
>
> To support the arm_arch_timer via ACPI we need to share defines and enums
> between the driver and the ACPI parser code.
>
> Split out the relevant defines and enums into arm_arch_timer.h. No functional
> change.
>
>>     (1)move enum ppi_nr to the header file
>>     (2)move "ARCH_*_TIMER" marcos to the header file
>>     (3)add enum spi_nr in the header file, and use it in the driver
>>     (4)add ARCH_WD_TIMER and ARCH_TIMER_MEM_MAX_FRAME marcos
>
> So this does 3 things at once.
>
>    1) Move existing defines and enums
>
>    2) Add a new enum and convert the driver to use it
>
>    3) Add new defines without using them
>
> So this needs to be seperate
>
>    #1) This patch
>
>    #2) Seperate patch which adds the new enum and converts the places in the
>        driver
>
>    #3) This needs to go into the patch which actually uses the defines.

Great thanks , will fix these following your suggestion :-)

>
> Thanks,
>
>         tglx



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat Software (Beijing) Co.,Ltd.Shanghai Branch
Ph: +86 21 61221326(direct)
Ph: +86 186 2020 4684 (mobile)
Room 1512, Regus One Corporate Avenue,Level 15,
One Corporate Avenue,222 Hubin Road,Huangpu District,
Shanghai,China 200021
