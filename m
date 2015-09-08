From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH 1/5] acpi: Add basic device probing infrastructure
Date: Tue, 08 Sep 2015 21:01:20 +0800
Message-ID: <55EEDC20.6050803@linaro.org>
References: <1441386412-8139-1-git-send-email-marc.zyngier@arm.com> <1441386412-8139-2-git-send-email-marc.zyngier@arm.com> <2194763.hsLfaM94lK@vostro.rjw.lan> <55EEB125.1030708@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35295 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752702AbbIHNBe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Sep 2015 09:01:34 -0400
Received: by pacfv12 with SMTP id fv12so126831212pac.2
        for <linux-acpi@vger.kernel.org>; Tue, 08 Sep 2015 06:01:34 -0700 (PDT)
In-Reply-To: <55EEB125.1030708@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, Tomasz Nowicki <tn@semihalf.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, linaro-acpi@lists.linaro.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 09/08/2015 05:57 PM, Marc Zyngier wrote:
> On 07/09/15 22:29, Rafael J. Wysocki wrote:
>> On Friday, September 04, 2015 06:06:48 PM Marc Zyngier wrote:
>>> IRQ controllers and timers are the two types of device the kernel
>>> requires before being able to use the device driver model.
>>>
>>> ACPI so far lacks a proper probing infrastructure similar to the one
>>> we have with DT, where we're able to declare IRQ chips and
>>> clocksources inside the driver code, and let the core code pick it up
>>> and call us back on a match. This leads to all kind of really ugly
>>> hacks all over the arm64 code and even in the ACPI layer.
>>>
>>> In order to allow some basic probing based on the ACPI tables,
>>> introduce "struct acpi_probe_entry" which contains just enough
>>> data and callbacks to match a table, an optional subtable, and
>>> call a probe function. A driver can, at build time, register itself
>>> and expect being called if the right entry exists in the ACPI
>>> table.
>>>
>>> A acpi_probe_device_init() is provided, taking an ACPI table
>>> identifier, and iterating over the registered entries.
>>
>> What about things that are provided by the ACPI namespace (eg. via _MAT) rather
>> than in static tables?
>
> By the time we get to process non-static tables, the whole probing
> infrastructure (including the ACPI interpreter) should be up and
> running. I'm not seeing this stuff as a replacement for more dynamic
> things - quite the opposite. It is only to be used for early bring-up.

Yes, this framework is for static tables and used at boot time,
sometimes quite early, which is before acpi_early_init().

But for _MAT (which is used for dynamic device configuration), it's
really a good question, I think _MAT is mainly for CPU hotplug, and
it's not related to this framework (for GIC init and clock source).
To hot add/remove a whole ARM SoC with _MAT, I think we need more
time to make the spec ready first, that's long term work, and agian
it's nothing to do with this infrastructure if I understand correctly :)

Thanks
Hanjun
