From: Jon Masters <jcm@redhat.com>
Subject: Re: [PATCH v3 02/17] ARM64 / ACPI: Get RSDP and ACPI boot-time tables
Date: Tue, 09 Sep 2014 13:33:14 -0400
Message-ID: <540F39DA.9040802@redhat.com>
References: <1409583475-6978-1-git-send-email-hanjun.guo@linaro.org>
 <1409583475-6978-3-git-send-email-hanjun.guo@linaro.org>
 <20140909162648.GE2910@arm.com> <540F2DCF.1010104@redhat.com>
 <20140909171541.GD3896@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140909171541.GD3896@leverpostej>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Lv Zheng <lv.zheng@intel.com>, Rob Herring <robh@kernel.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Robert Moore <robert.moore@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, Robert Richter <rric@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <Marc.Zyngier@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Mark Brown <broonie@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Randy Dunlap <rdunlap@infradead.org>, "Rafael J. Wysocki" <rjw@rjwy>
List-Id: linux-acpi@vger.kernel.org

On 09/09/2014 01:15 PM, Mark Rutland wrote:
> On Tue, Sep 09, 2014 at 05:41:51PM +0100, Jon Masters wrote:
>> On 09/09/2014 12:26 PM, Catalin Marinas wrote:
>>> On Mon, Sep 01, 2014 at 03:57:40PM +0100, Hanjun Guo wrote:
>>>> diff --git a/arch/arm64/include/asm/acenv.h b/arch/arm64/include/asm/acenv.h
>>>> new file mode 100644
>>>> index 0000000..3899ee6
>>>> --- /dev/null
>>>> +++ b/arch/arm64/include/asm/acenv.h
>>>> @@ -0,0 +1,18 @@
>>>> +/*
>>>> + * ARM64 specific ACPICA environments and implementation
>>>> + *
>>>> + * Copyright (C) 2014, Linaro Ltd.
>>>> + *   Author: Hanjun Guo <hanjun.guo@linaro.org>
>>>> + *   Author: Graeme Gregory <graeme.gregory@linaro.org>
>>>> + *
>>>> + * This program is free software; you can redistribute it and/or modify
>>>> + * it under the terms of the GNU General Public License version 2 as
>>>> + * published by the Free Software Foundation.
>>>> + */
>>>> +
>>>> +#ifndef _ASM_ACENV_H
>>>> +#define _ASM_ACENV_H
>>>> +
>>>> +#define ACPI_FLUSH_CPU_CACHE() WARN_ONCE(1, "Not currently supported on ARM64")
>>>
>>> Does this mean that it will be supported at some point? Looking at the
>>> places where this function is called, I don't really see how this would
>>> ever work on ARM. Which means that we add such macro just to be able to
>>> compile code that would never be used on arm64. I would rather see the
>>> relevant ACPI files only compiled on x86/IA-64 rather than arm64.
>>
>> That specific cache behavior is a part of e.g. ACPI C3 state support
>> (e.g. ACPI5.1 8.1.4 Processor Power State C3).
> 
> Per table 5-35, if neither WBINVD or WBINVD_FLUSH are set in the FADT,
> we don't get S1, S2, or S3 states either.

That's not quite what it says. You could still define an \_S1 state on
such a system. That table simply makes an assumption that if the stride
parameters are not defined and neither is wbindv then there's no way to
reliably flush caches, which of course isn't a valid conclusion, it's
just language that needs to be updated to reflect reality. So it's not
"don't get", it's "machine cannot support", which is an assumption.

>> As you note, it's not going to work on 64-bit ARM as it does on x86,
>> but it's optional to implement C3 and early 64-bit ARM systems should
>> not report Wbindv flags in the FADT anyway.
> 
> Unless the arm cache architecture changes, I wouldn't expect any 64-bit
> ARM system to set either of the WBINVD flags.

Indeed.

>> They can also set FADT.P_LVL3_LAT > 1000, which has the effect of
>> disabling C3 support, while also allowing for use of _CST objects to
>> define more flexible C-States later on.
> 
> It sounds like we should be sanity checking these in the arm64 ACPI code
> for the moment. I don't want us to discover that current platforms
> report the wrong thing only when new platforms come out that might
> actually report things correctly.

It's reasonable to do this sooner rather than later, sure.

Jon.
