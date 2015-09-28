From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [Linaro-acpi] [PATCH v2 0/5] ACPI probing infrastructure
Date: Mon, 28 Sep 2015 21:49:48 +0200
Message-ID: <CAJZ5v0iKjgStXDd-On1Q93izKJgccAuKZPje_yuy9kU4r1DpnQ@mail.gmail.com>
References: <1442152943-24493-1-git-send-email-marc.zyngier@arm.com>
	<1698028.ftHN1K8oZa@vostro.rjw.lan>
	<560939A7.3030603@arm.com>
	<39030379.kalO2V72FV@vostro.rjw.lan>
	<56094589.504@arm.com>
	<5609984D.70702@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:36762 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750907AbbI1Ttu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 28 Sep 2015 15:49:50 -0400
In-Reply-To: <5609984D.70702@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Al Stone <al.stone@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <catalin.marinas@arm.com>, Jason Cooper <jason@lakedaemon.net>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Will Deacon <will.deacon@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, Thomas Gleixner <tglx@linutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Len Brown <lenb@kernel.org>

Hi,

On Mon, Sep 28, 2015 at 9:43 PM, Al Stone <al.stone@linaro.org> wrote:
> On 09/28/2015 07:50 AM, Marc Zyngier wrote:
>> On 28/09/15 14:53, Rafael J. Wysocki wrote:
>>> On Monday, September 28, 2015 01:59:19 PM Marc Zyngier wrote:
>>>> Hi Rafael,
>>>>
>>>> On 26/09/15 00:45, Rafael J. Wysocki wrote:
>>>>
>>>>>> Marc Zyngier (5):
>>>>>>   acpi: Add basic device probing infrastructure
>>>>>>   irqchip/acpi: Add probing infrastructure for ACPI-based irqchips
>>>>>>   irqchip/gic: Convert the GIC driver to ACPI probing
>>>>>>   clocksource/acpi: Add probing infrastructure for ACPI-based
>>>>>>     clocksources
>>>>>>   clocksource/arm_arch_timer: Convert to ACPI probing
>>>>>
>>>>> I'm generally fine with this (modulo a couple of super-minor nits in the
>>>>> first patch), but it needs ACKs from Thomas for the irqchip-related and
>>>>> clocksource-related patches.
>>>>
>>>> Sure. I've now addressed your comments, and I'll post the updated series
>>>> later today.
>>>>
>>>>> Plus [3/5] needs to be rebased on top of the Al's patches removing BAD_MADT_ENTRY
>>>>> (currently in my bleeding-edge branch).
>>>>
>>>> Al's patches were there on Friday, but vanished over the weekend. Do you
>>>> have another (stable?) branch with these patches in (assuming they are
>>>> still aimed at 4.4)?
>>>
>>> The Al's patches are gone for now, because they introduced a 0-day testing
>>> regression.
>>>
>>> I guess this means I can apply your patches first and ask Al to rebase his
>>> next version on them.
>>
>> OK. I'll rebase them on the current bleeding-edge, and post that.
>>
>> Thanks,
>>
>>       M.
>>
>
> Yeah, sorry about that; I had some bad info from the 1.0 version of the ACPI
> spec.  And I was busy with family stuff all weekend.
>
> Rafael, I'll look for Marc's patches to show up in bleeding-edge and rebase on
> top of that.

Sounds good, thanks!

Rafael
