From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v6 4/5] arm64: add support for ACPI Low Power Idle(LPI)
Date: Mon, 27 Jun 2016 18:58:58 +0100
Message-ID: <57716962.1040106@arm.com>
References: <1465915719-8409-1-git-send-email-sudeep.holla@arm.com>
 <1465915719-8409-5-git-send-email-sudeep.holla@arm.com>
 <20160622141700.GB2733@red-moon> <57715463.5040305@linaro.org>
 <57715D6F.3060608@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:41754 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751644AbcF0R7D (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 27 Jun 2016 13:59:03 -0400
In-Reply-To: <57715D6F.3060608@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, linux-acpi@vger.kernel.org, Vikas Sajjan <vikas.cha.sajjan@hpe.com>, Sunil <sunil.vl@hpe.com>, Prashanth Prakash <pprakash@codeaurora.org>, Al Stone <al.stone@linaro.org>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org



On 27/06/16 18:07, Sudeep Holla wrote:
>
>
> On 27/06/16 17:29, Daniel Lezcano wrote:

[...]

>>
>> acpi_disabled - acpi_disabled - acpi_disabled everywhere :/
>>
>> The enable-method approach is not straightforward and now it is polluted
>> by acpi-disabled.
>>
>> So IIUC,
>>
>> smp_init_cpus (contains acpi_disabled)
>>    smp_cpu_setup
>>      cpu_read_ops
>>        cpu_read_enable_method (contains acpi_disabled)
>>          acpi_get_enable_method (returns 'psci' after checking
>> psci_is_present)
>>
>> Then psci_cpu_init_idle is called... and check again acpi_disabled.
>>
>> IMO, the circumlocution with the psci vs acpi vs acpi_disabled is
>> getting unnecessary too complex, is prone to error and will lead to
>> unmaintainable code very soon.
>>
>> I suggest to sort out encapsulation and self-contained code before
>> adding more feature in this area.
>>
>
> I understand your concern but I have no idea on how to clean up. Lorenzo
> asked to factor our common code between psci_{dt,acpi}_cpu_init_idle and
> I think you might not like the refactoring[1]. I didn't want to change
> cpuidle_ops and hence psci_dt_cpu_init_idle parameters. I will see if
> changing that simplifies things.
>

One of the reasons for adding acpi_disabled check is to keep the other
logic at the same place. Otherwise we end up duplicating that code which
is what I have done in psci_{dt,acpi}_cpu_init_idle at the first place.

-- 
Regards,
Sudeep
