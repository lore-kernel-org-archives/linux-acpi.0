From: Fu Wei <fu.wei@linaro.org>
Subject: Re: [PATCH v22 00/11] acpi, clocksource: add GTDT driver and GTDT
 support in arm_arch_timer
Date: Tue, 28 Mar 2017 22:29:10 +0800
Message-ID: <CADyBb7vddnQ4TZXaem3q=+v=vC41J7O4cVsokn04S2jGGU8veA@mail.gmail.com>
References: <20170321163122.9183-1-fu.wei@linaro.org> <1cc5a994-0af6-79ea-930d-44b3fc789427@jonmasters.org>
 <CADyBb7ujZKDF0aUJZRUN81jor04mZ-V5ESWScAjaxoHQUeVFSA@mail.gmail.com> <20170328130552.GA8643@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170328130552.GA8643@leverpostej>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Jon Masters <jcm@jonmasters.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <marc.zyngier@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, linux-arm-kernel@lists.infradead.org, Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, rruigrok@codeaurora.org, "Abdulhamid, Harb" <harba@codeaurora.org>, Christopher Covington <cov@codeaurora.org>, Timur Tabi <timur@codeaurora.org>, G Gregory <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro>
List-Id: linux-acpi@vger.kernel.org

Hi Mark,

On 28 March 2017 at 21:05, Mark Rutland <mark.rutland@arm.com> wrote:
> On Tue, Mar 28, 2017 at 08:34:12PM +0800, Fu Wei wrote:
>> Hi Jon,
>>
>> Thanks for your email
>>  An hour ago, I just got some feedback from Lorenzo, will update my
>> patchset ASAP according to his suggestion.
>>
>> But I still need some feedback form Mark, I can see some progress here:
>> https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=arch-timer/gtdt
>>
>> I guess I should rebase my patchset to his gtdt branch for v23.
>>
>> So now, I am waiting for Mark's feedback to move on.
>
> Sorry for the delay; I have not had the time to focus on this as I would
> like to. I'm happy with patches 1-4, but from patch 5 onwards, there's
> one change I'd like to see.
>
> I'd prefer that mmio timer frame rame N was always stored at
> arch_timer_mem::frame[N], rather than arch_timer_mem::frame[] being in
> an arbitrary order. That will make arch_timer_mem_frame::frame_nr
> redundant.
>
> To allow arch_timer_mem::frame[] this to be sparse, I'm happy to have a
> bool arch_timer_mem_frame::valid field that we set when probing each
> frame. Then we don't need arch_timer_mem::num_frames.
>
> This will make iterating over the frames far less confusing, and makes
> it simple to detect when a frame number is erroneously reused.
>
> Otherwise, I'm largely happy to pick the rest and apply any fixups
> myself.

Great thanks for your feedback!
I will follow your suggestion to improve my patches, then post it in a day.

So I will rebase my patchset on arch-timer/gtdt branch of your REPO
https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=arch-timer/gtdt

>
> Thanks,
> Mark.



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
