From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] ACPI / ARM64: Remove EXPERT dependency for ACPI on ARM64
Date: Thu, 14 Apr 2016 11:02:15 -0700
Message-ID: <CAOesGMgULvTmzG-kGjWwntbgoRxpTTc2f72Yoj0H4DArGsLAEw@mail.gmail.com>
References: <1459360718-24125-1-git-send-email-broonie@kernel.org>
	<20160412172315.GH8066@e104818-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-io0-f181.google.com ([209.85.223.181]:36678 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753116AbcDNSCQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Apr 2016 14:02:16 -0400
Received: by mail-io0-f181.google.com with SMTP id u185so111556959iod.3
        for <linux-acpi@vger.kernel.org>; Thu, 14 Apr 2016 11:02:16 -0700 (PDT)
In-Reply-To: <20160412172315.GH8066@e104818-lin.cambridge.arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mark Brown <broonie@kernel.org>, Will Deacon <will.deacon@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Steve Capper <steve.capper@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Arnd Bergmann <arnd@arndb.de>

On Tue, Apr 12, 2016 at 10:23 AM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> On Wed, Mar 30, 2016 at 10:58:38AM -0700, Mark Brown wrote:
>> When ACPI was originally merged for arm64 it had only been tested on
>> emulators and not on real physical platforms and no platforms were
>> relying on it.  This meant that there were concerns that there might be
>> serious issues attempting to use it on practical systems so it had a
>> dependency on EXPERT added to warn people that it was in an early stage
>> of development with very little practical testing.  Since then things
>> have moved on a bit.  We have seen people testing on real hardware and
>> now have people starting to produce some platforms (the most prominent
>> being the 96boards Cello) which only have ACPI support and which build
>> and run to some useful extent with mainline.
>>
>> This is not to say that ACPI support or support for these systems is
>> completely done, there are still areas being worked on such as PCI, but
>> at this point it seems that we can be reasonably sure that ACPI will be
>> viable for use on ARM64 and that the already merged support works for
>> the cases it handles.  For the AMD Seattle based platforms support
>> outside of PCI has been fairly complete in mainline a few releases now.
>>
>> This is also not to say that we don't have vendors working with ACPI who
>> are trying do things that we would not consider optimal but it does not
>> appear that the EXPERT dependency is having a substantial impact on
>> these vendors.
>>
>> Given all this it seems that at this point the EXPERT dependency mainly
>> creates inconvenience for users with systems that are doing the right
>> thing and gets in the way of including the ACPI code in the testing that
>> people are doing on mainline.  Removing it should help our ongoing
>> testing cover those platforms with only ACPI support and help ensure
>> that when ACPI code is merged any problems it causes for other users are
>> more easily discovered.
>>
>> Signed-off-by: Mark Brown <broonie@kernel.org>
>
> I'm fine with dropping the EXPERT dependency (of course, not a cc
> stable). While arm64 ACPI is not "done" yet (nor is DT; there are
> important ongoing developments like PCIe, IORT), I think the core arm64
> ACPI support passed the EXPERT stage. I also don't think a default y
> would imply any maintainer endorsement; vendors targeting ACPI are
> already doing this for various reasons (distro requirement, certain ACPI
> features like RAS). But, hopefully, it will encourage more vendors to
> start upstreaming their ACPI-related patches.
>
> However, building ACPI by default on arm64 doesn't mean that we can
> ignore potential misuses like PRP0001+_DSD blindly following DT
> (mis)concepts, breaking compatibility with older/newer firmware (this
> goes in both directions) or using ACPI for SoCs where it is clearly not
> suitable (e.g. non-SBSA). Such patches should be NAK'ed accordingly.
>
>> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
>> index 82b96ee8624c..bf5dc1ac3446 100644
>> --- a/drivers/acpi/Kconfig
>> +++ b/drivers/acpi/Kconfig
>> @@ -5,7 +5,7 @@
>>  menuconfig ACPI
>>       bool "ACPI (Advanced Configuration and Power Interface) Support"
>>       depends on !IA64_HP_SIM
>> -     depends on IA64 || X86 || (ARM64 && EXPERT)
>> +     depends on IA64 || X86 || ARM64
>>       depends on PCI
>>       select PNP
>>       default y
>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
>
> That said, I'd like to see an opinion from the arm-soc maintainers since
> they were active on the original arm64 ACPI threads introducing this
> dependency (and I think they have the right to veto ;)).

Switch the default from y to n on ARM64 (or default !ARM64) and I'll
be happy to ack it.

Mostly because it doesn't make sense for people building their own
configs for embedded systems to get it turned on by default. Anyone
running on a server is likely to clone an existing distro config in
the first place.


-Olof
