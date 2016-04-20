From: David Daney <ddaney.cavm@gmail.com>
Subject: Re: [PATCH v5 12/14] arm64, acpi, numa: NUMA support based on SRAT
 and SLIT
Date: Wed, 20 Apr 2016 09:29:45 -0700
Message-ID: <5717AE79.5060605@gmail.com>
References: <1461116439-22991-1-git-send-email-ddaney.cavm@gmail.com> <1461116439-22991-13-git-send-email-ddaney.cavm@gmail.com> <CADKHWaeZPj7UWU4znf7NRo3JO8+JGrBP4WJE6S5gVM0KvydNug@mail.gmail.com> <CAFpQJXXeQKKrgObdhxu8QaTm-wb81yddLtwFreed4eS5Qi1TPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33069 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751302AbcDTQ3t (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Apr 2016 12:29:49 -0400
In-Reply-To: <CAFpQJXXeQKKrgObdhxu8QaTm-wb81yddLtwFreed4eS5Qi1TPw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ganapatrao Kulkarni <gpkulkarni@gmail.com>
Cc: Dennis Chen <dennis.chen@linaro.org>, Mark Rutland <mark.rutland@arm.com>, linux-ia64@vger.kernel.org, David Daney <david.daney@cavium.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Lv Zheng <lv.zheng@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Frank Rowand <frowand.list@gmail.com>, x86@kernel.org, Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Grant Likely <grant.likely@linaro.org>, Len Brown <lenb@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, Marc Zyngier <Marc.Zyngier@arm.com>, Robert Richter <rrichter@cavium.com>, Rob Herring <robh+dt@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, devel@acpica.org, Tony Luck <tony.luck@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@v

On 04/20/2016 01:31 AM, Ganapatrao Kulkarni wrote:
> On Wed, Apr 20, 2016 at 1:11 PM, Dennis Chen <dennis.chen@linaro.org> wrote:
>> On 20 April 2016 at 09:40, David Daney <ddaney.cavm@gmail.com> wrote:
[...]
>>> @@ -388,7 +389,9 @@ static int __init dummy_numa_init(void)
>>>   void __init arm64_numa_init(void)
>>>   {
>>>          if (!numa_off) {
>>> -               if (!numa_init(of_numa_init))
>>> +               if (!acpi_disabled && !numa_init(arm64_acpi_numa_init))
>>> +                       return;
>>> +               if (acpi_disabled && !numa_init(of_numa_init))
>>>                          return;
>>>          }
>>>
>> On top of the latest version of the dt-based numa patch, if 'numa=off'
>> specified in the command line,
>> this function will fallback to invoke dummy_numa_init(), which give
>> rise the question here is, do we need to
>> touch any ACPI related stuff in the case? If not, then the output
>
> no, ACPI is not fallback configuration for DT and vice versa.
>
>> message "No NUMA configuration found" followed
>> seems is not necessary since it's a little bit confusing in case of
>> numa has already been turned off explicitly.
>
> thanks, this print can be moved out.
> from function dummy_numa_init and it can be added in function arm64_numa_init
> as a last line of if (!numa_off) to indicate, ACPI/DT based NUMA
> configuration failed.
>
> more appropriate would be,
> pr_info("%s\n", "NUMA configuration failed or not found");
>

Although purely cosmetic, I agree that we need to improve the messages 
as to not confuse people.

I will rework the messages with your suggestions in mind to see if we 
can get something that is both concise and unambiguously reflects what 
the user asked for.

David.



