From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2 4/5] ACPI / processor_idle : introduce
 ARCH_SUPPORTS_ACPI_PROCESSOR_CSTATE
Date: Thu, 24 Sep 2015 14:05:13 +0100
Message-ID: <5603F509.1090307@arm.com>
References: <1438710406-3822-1-git-send-email-sudeep.holla@arm.com>
 <1442411963-14398-1-git-send-email-sudeep.holla@arm.com>
 <1442411963-14398-5-git-send-email-sudeep.holla@arm.com>
 <CAJ5Y-eb6SfQtR0aigPo4F-ueDk+J93NKf62KCM_NiK44nBQ3Sw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:38379 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753294AbbIXNFR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 24 Sep 2015 09:05:17 -0400
In-Reply-To: <CAJ5Y-eb6SfQtR0aigPo4F-ueDk+J93NKf62KCM_NiK44nBQ3Sw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux acpi <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, lkml <linux-kernel@vger.kernel.org>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, Al Stone <al.stone@linaro.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mahesh Sivasubramanian <msivasub@codeaurora.org>



On 24/09/15 11:31, Ashwin Chaugule wrote:
> Hi Sudeep,
>
> On 16 September 2015 at 09:59, Sudeep Holla <sudeep.holla@arm.com> wrote:
>> ACPI 6.0 adds a new method to specify the CPU idle states(C-states)
>> called Low Power Idle(LPI) states. Since new architectures like ARM64
>> use only LPIs, introduce ARCH_SUPPORTS_ACPI_PROCESSOR_CSTATE to
>> encapsulate all the code supporting the old style C-states(_CST)
>>
>> This patch will help to extend the processor_idle module to support
>> LPI.
>>
>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

[...]

>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index 7aef2d52daa0..173075c48df8 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -34,6 +34,7 @@ config X86
>>          select ARCH_MIGHT_HAVE_ACPI_PDC         if ACPI
>>          select ARCH_MIGHT_HAVE_PC_PARPORT
>>          select ARCH_MIGHT_HAVE_PC_SERIO
>> +       select ARCH_SUPPORTS_ACPI_PROCESSOR_CSTATE if ACPI
>>          select ARCH_SUPPORTS_ATOMIC_RMW
>>          select ARCH_SUPPORTS_DEFERRED_STRUCT_PAGE_INIT
>>          select ARCH_SUPPORTS_INT128             if X86_64
>> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
>> index 5d1015c26ff4..1eb0b8a84a65 100644
>> --- a/drivers/acpi/Kconfig
>> +++ b/drivers/acpi/Kconfig
>> @@ -48,6 +48,9 @@ config ACPI_LEGACY_TABLES_LOOKUP
>>   config ARCH_MIGHT_HAVE_ACPI_PDC
>>          bool
>>
>> +config ARCH_SUPPORTS_ACPI_PROCESSOR_CSTATE
>> +       bool
>> +
>>   config ACPI_GENERIC_GSI
>>          bool
>>
>
> Can't this be auto selected under ACPI_PROCESSOR_IDLE if X86 || IA64
> instead?

It can be done. The idea was to have ACPI_PROCESSOR_IDLE selected on
both x86 and ARM64.

processor_idle driver will support both _CST and _LPI
1. to avoid some code duplication
2. for easy enabling of _LPI on x86 if needed in future

Regards,
Sudeep
