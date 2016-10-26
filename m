From: Fu Wei <fu.wei@linaro.org>
Subject: Re: [PATCH v14 1/9] clocksource/drivers/arm_arch_timer: Move enums
 and defines to header file
Date: Wed, 26 Oct 2016 18:54:35 +0800
Message-ID: <CADyBb7vw3itsiHdcPMpMcbwoNj9SQNF7vZsOEiFNnk3uS60-jw@mail.gmail.com>
References: <1475086637-1914-1-git-send-email-fu.wei@linaro.org>
 <1475086637-1914-2-git-send-email-fu.wei@linaro.org> <20161020144510.GJ10234@leverpostej>
 <CADyBb7shWfCQycmo0GcheX2NSsrjYBpzdtYFqymvDNCKi0QM2A@mail.gmail.com> <20161026105144.GF19965@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161026105144.GF19965@leverpostej>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <marc.zyngier@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, linux-arm-kernel@lists.infradead.org, Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, rruigrok@codeaurora.org, "Abdulhamid, Harb" <harba@codeaurora.org>, Christopher Covington <cov@codeaurora.org>, Timur Tabi <timur@codeaurora.org>, G Gregory <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>, Jon Masters <jcm@redhat.com>
List-Id: linux-acpi@vger.kernel.org

Hi Mark

On 26 October 2016 at 18:51, Mark Rutland <mark.rutland@arm.com> wrote:
> On Wed, Oct 26, 2016 at 04:31:55PM +0800, Fu Wei wrote:
>> On 20 October 2016 at 22:45, Mark Rutland <mark.rutland@arm.com> wrote:
>> > On Thu, Sep 29, 2016 at 02:17:09AM +0800, fu.wei@linaro.org wrote:
>> >>  #include <linux/timecounter.h>
>> >>  #include <linux/types.h>
>> >>
>> >> +#define ARCH_CP15_TIMER                      BIT(0)
>> >> +#define ARCH_MEM_TIMER                       BIT(1)
>> >
>> > If we're going to expose these in a header, it would be better to rename
>> > them to something that makes their usage/meaning clear. These should
>> > probably be ARCH_TIMER_TYPE_{CP15,MEM}.
>
>> > With those changes (regardless of the ARCH_TIMER_TYPE_* bits):
>> >
>> > Acked-by: Mark Rutland <mark.rutland@arm.com>
>>
>> For ARCH_TIMER_TYPE_*, maybe I should add a patch at the end of this
>> patchset to fix it, OK ?
>
> Sure. If you could put that *earlier* in the patchset it would be
> preferable so as to minimize churn.

OK, NP, will do

>
> Thanks,
> Mark.



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
