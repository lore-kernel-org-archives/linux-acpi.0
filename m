From: Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH v10 00/21] Introduce ACPI for ARM64 based on ACPI 5.1
Date: Thu, 19 Mar 2015 12:09:33 +0800
Message-ID: <550A4BFD.4070804@huawei.com>
References: <1426077587-1561-1-git-send-email-hanjun.guo@linaro.org> <20150318190509.GM10863@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:52340 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750723AbbCSEKf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Mar 2015 00:10:35 -0400
In-Reply-To: <20150318190509.GM10863@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>
Cc: Catalin Marinas <Catalin.Marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Olof Johansson <olof@lixom.net>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <Mark.Rutland@arm.com>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, "jcm@redhat.com" <jcm@redhat.com>, Marc Zyngier <Marc.Zyngier@arm.com>, Mark Brown <broonie@kernel.org>, Robert Richter <rric@kernel.org>, Timur Tabi <timur@codeaurora.org>, Ashwin Chaugule <ashwinc@codeaurora.org>, "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linaro-acpi

On 2015/3/19 3:05, Will Deacon wrote:
> Hanjun,

Hi Will,

>
> On Wed, Mar 11, 2015 at 12:39:26PM +0000, Hanjun Guo wrote:
>> This patch set already tested on multi platforms:
>>  - AMD Seattle board;
>>  - Cavium Thunder board;
>>  - Huawei D02 board;
>>  - Qualcomm ARM64 platform
>>
>> This version 10 patch set address some minor comments and collect ACKs and
>> Reviewed-bys for v9:
>>
>>  - new Acks from Rafael, Olof, Grant, Lorenzo
>>  - new way to handle typdef phys_cpuid_t which suggested by Rafael,
>>    but no functional change
>>  - Remove if(!phys) for early ioremappings
>>  - Rework sleep function for ARM64
>>  - Introduce linux/acpi_irq.h to hold acpi_irq_init()
>>  - Disable ACPI if not HW_REDUCED_ACPI compliant
>>  - Remove the doc of why ACPI on ARM
> So I've had a look at the current state of this series and I think there
> are a few immediate things left to do:
>
>   (1) Resolve the acpi=force cmdline issue highlighted by Lorenzo and
>       Catalin

Sure, it will be done after the confirmation with Ard.

>
>   (2) I believe Sudeep and Lorenzo have concerns about patch 13 (SMP init),
>       so I'm assuming there will be additional patches from them that are
>       required.

Sorry, I assume that it is about the print information for PSCI absent for SMP init, right?

>
>   (3) I have an open comment about moving the IRQ domain code into the
>       core, which I'd like to see addressed.

I replied your email, please share your ideas for what I said.

>
>   (4) We need an ack from Daniel on the arch-timer patch

OK, thanks for your ping to Daniel :)

>
> If you can get that in place, I'm not opposed to putting this into
> linux-next ahead of the firmware summit in San Jose next week. Note that
> this is not a commitment for 4.1, since I'm keen to see the outcomes of
> next week before setting anything in stone.

OK, I will stick to this mailing list and respond as soon as I can.

>
> Also, there's no need to repost patches if you're just adding Acks. I
> think I'm up to speed with those on my local branch and the Tested-by
> party is starting to look a little silly.

Should I send another version, and add some incremental cleanup/fix patches
on top of that?

Thanks
Hanjun

