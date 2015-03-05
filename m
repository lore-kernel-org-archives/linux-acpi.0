From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v9 14/21] ACPI / processor: Make it possible to get CPU
 hardware ID via GICC
Date: Thu, 5 Mar 2015 14:13:58 +0100
Message-ID: <CAJZ5v0iHstGiXLT0DPHu2=xH3bD-kD=WCqfuB1XaTgNSnthcLQ@mail.gmail.com>
References: <1424853601-6675-1-git-send-email-hanjun.guo@linaro.org>
	<1424853601-6675-15-git-send-email-hanjun.guo@linaro.org>
	<2411054.s4TkmAUKjT@vostro.rjw.lan>
	<54F80DC9.3090808@huawei.com>
	<20150305112707.GB7712@e104818-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:41301 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754716AbbCENN7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Mar 2015 08:13:59 -0500
In-Reply-To: <20150305112707.GB7712@e104818-lin.cambridge.arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Hanjun Guo <guohanjun@huawei.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Hanjun Guo <hanjun.guo@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Ashwin Chaugule <ashwinc@codeaurora.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Robert Richter <rric@kernel.org>, Graeme Gregory <graeme.gregory@linaro.org>, Arnd Bergmann <arnd@arndb.de>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Marc Zyngier <marc.zyngier@arm.com>, Timur Tabi <timur@codeaurora.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Will Deacon <will.deacon@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@linaro.org>, Mark Brown <broonie@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, suravee.suthikulpanit@amd.com, Sudeep Holla <Sudeep.Holla@arm.com>, Olof Johansson <olof@lixom.>

On Thu, Mar 5, 2015 at 12:27 PM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> On Thu, Mar 05, 2015 at 04:03:21PM +0800, Hanjun Guo wrote:
>> On 2015/3/5 6:46, Rafael J. Wysocki wrote:
>> > IMO, you really need to define phys_cpuid_t in a common place or people will
>> > forget that it may be 64-bit, because they'll only be looking at their arch.
>>
>> Since x86 and ARM64 are using different types for phys_cpuid_t, we need to
>> introduce something like following if define it in common place:
>>
>> in linux/acpi.h,
>>
>> #if defined(CONFIG_X86) || defined(CONFIG_IA64)
>> typedef u32 phys_cpuid_t;
>> #define PHYS_CPUID_INVALID (phys_cpuid_t)(-1)
>> #else if defined(CONFIG_ARM64)
>> typedef u64 phys_cpuid_t;
>> #define PHYS_CPUID_INVALID INVALID_HWID
>> #endif
>>
>> I think it's awful, did I miss something?

Well, you can define the type and PHYS_CPUID_INVALID in the arch
code and then do this in a common header:

#ifndef PHYS_CPUID_INVALID
typedef u32 phys_cpuid_t;
#define PHYS_CPUID_INVALID (phys_cpuid_t)(-1)
#endif

That would allow you to avoid the need to duplicate the
definitions where it is not necessary.

> I also think that's awful. I'm rather in favour of a per-arch
> phys_cpuid_t.

OK, so what about the above?

Rafael
