From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v9 00/21] Introduce ACPI for ARM64 based on ACPI 5.1
Date: Fri, 27 Feb 2015 15:05:47 -0600
Message-ID: <54F0DC2B.5010802@codeaurora.org>
References: <1424853601-6675-1-git-send-email-hanjun.guo@linaro.org>	<54EFE282.1090305@codeaurora.org> <CAKv+Gu-LxaX6X=qApp=zhzfmNfv=tjfscf9npFCpNW314pZvvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:56740 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753340AbbB0VFv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 27 Feb 2015 16:05:51 -0500
In-Reply-To: <CAKv+Gu-LxaX6X=qApp=zhzfmNfv=tjfscf9npFCpNW314pZvvg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Hanjun Guo <hanjun.guo@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <will.deacon@arm.com>, Olof Johansson <olof@lixom.net>, Grant Likely <grant.likely@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Ashwin Chaugule <ashwinc@codeaurora.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Robert Richter <rric@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Graeme Gregory <graeme.gregory@linaro.org>, Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, Jon Masters <jcm@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Sudeep Holla <Sudeep.Holla@arm.com>

On 02/27/2015 02:50 AM, Ard Biesheuvel wrote:
> On 27 February 2015 at 03:20, Timur Tabi <timur@codeaurora.org> wrote:
>> On 02/25/2015 02:39 AM, Hanjun Guo wrote:
>>>
>>> Changes since v8:
>>
>>
>> I'm still debugging it, but v9 on the 4.0-rc1 kernel crashes after calling
>> the UEFI boot time services exit function.  That is, this line:
>>
>> status = sys_table->boottime->exit_boot_services(handle, mmap_key);
>>
>> in allocate_new_fdt_and_exit_boot() gets called, and then soon after it
>> returns, the kernel crashes.  It's really early because the UEFI exception
>> handler is called.
>>
>> I did not have this problem with v8 patchset on 3.19.
>>
>
> Are you not seeing this on v4.0-rc1 without the patchset applied?

You're right -- I get the same crash even without the patchset applied.

> Could the crash be inside the subsequent call to
> SetVirtualAddressMap() instead of inside ExitBootServices()?

It looks that way.  I'm going to have to debug that.

> If so, you have a firmware bug: Mark Rutland spotted a similar bug in
> the AMD Seattle firmware, which has been fixed in the mean time.
> It has to do with the firmware dereferencing the virtual mapping as it
> is being installed, which violates the UEFI spec.

Thanks.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
