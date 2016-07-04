From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v6 00/10] acpi, clocksource: add GTDT driver and GTDT
 support in arm_arch_timer
Date: Mon, 4 Jul 2016 16:19:33 +0200
Message-ID: <CAJZ5v0idNxDkS2BoOW20dYF1y4nu=R5GLqbn=nO5thLy8NZjLw@mail.gmail.com>
References: <1467224153-22873-1-git-send-email-fu.wei@linaro.org>
 <2435381.sM3CFAEXNR@vostro.rjw.lan> <57767782.6020509@linaro.org>
 <1643662.QIDsTbCMZg@vostro.rjw.lan> <577A6816.3050709@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33312 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753686AbcGDOTf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Jul 2016 10:19:35 -0400
In-Reply-To: <577A6816.3050709@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Hanjun Guo <hanjun.guo@linaro.org>, Fu Wei <fu.wei@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <marc.zyngier@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, rruigrok@codeaurora.org, harba@codeaurora.org, Christopher Covington <cov@codeaurora.org>, Timur Tabi <timur@codeaurora.org>, G Gregory <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>, Jon Masters <jcm@redhat.com>, wei@redhat.com, Arnd Bergmann <arnd@arndb.de>, Wim Van Sebroeck <wim>

On Mon, Jul 4, 2016 at 3:43 PM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> On 07/01/2016 11:01 PM, Rafael J. Wysocki wrote:
>> On Friday, July 01, 2016 04:00:34 PM Daniel Lezcano wrote:
>>> On 06/30/2016 03:27 PM, Rafael J. Wysocki wrote:
>>>
>
> [ ... ]
>
>>> clocksource-probe which is DT based with different drivers using it in
>>> drivers/clocksource with a pletore of different archs.
>>
>> So maybe the GTDT code should be there too?
>
> *maybe*
>
>>> Cstate code which is only used by x86 is in drivers/acpi, it is only
>>> used by x86/ia64 and it isn't a problem.
>>
>> It is a problem.
>
> Can you explain why it is a problem ?
>
>> drivers/acpi/ is not the right place for arch-specific code.
>
> I do not understand this assertion regarding what happened during the
> last years with different subsystems where the drivers were moved from
> their arch specific directories to the drivers directory (cpufreq,
> cpuidle, clockevent, clk, etc ...) and resulted at the end to a code
> refactoring and consolidation.
>
> Why ACPI should follow the opposite rule ?

Because drivers/acpi/ is for common and generic ACPI code.  Maybe it
should not be located under drivers/, but that's a different matter.

>>> There is a small chunk in arch/x86/kernel/acpi and it doesn't facilitate the
>>> comprehension of the code.
>>>
>>> IMHO, having all ACPI code in the same directory will encourage the
>>> consolidation.
>>
>> The consolidation of what exactly?
>
> The consolidation of the ACPI code in general which is the
> counter-example of self-contained code.

Do you actually realize how much ACPI code is there in the kernel and
that moving it all into one directory would be totally
counter-productive?

You seem to be thinking that ACPI is something like cpufreq, where you
have the core and the drivers and nothing but the drivers uses the
core, but that's not the case.

>> In particular, how does the GTDT code in drivers/acpi/ help to consolidate
>> anything?
>
> If I imagine we group all ACPI code under a common directory, the first
> example coming in my mind is the sharing of private headers, reducing
> the scope of exported functions and global variables (eg. acpi_disabled).
>
> That say, I can understand grouping all the ACPI into a single directory
> will make it fall under a single umbrella's maintainer and that could be
> a nightmare to maintain as it covers a lot of different features.
> However, I believe that could be solved by clearly identifying who takes
> care of what.

And one way of doing that is to put things in different places in the
kernel source tree.

Thanks,
Rafael
