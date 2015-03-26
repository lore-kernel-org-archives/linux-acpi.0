From: Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [patch v11 13/23] ACPI / processor: Introduce phys_cpuid_t for
 CPU hardware ID
Date: Thu, 26 Mar 2015 11:49:33 +0800
Message-ID: <551381CD.5010804@huawei.com>
References: <1427205776-5060-1-git-send-email-hanjun.guo@linaro.org> <1427205776-5060-14-git-send-email-hanjun.guo@linaro.org> <20150325172109.GJ14585@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:49763 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751850AbbCZDuN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Mar 2015 23:50:13 -0400
In-Reply-To: <20150325172109.GJ14585@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Hanjun Guo <hanjun.guo@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Robert Richter <rric@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Ashwin Chaugule <ashwinc@codeaurora.org>, linaro-acpi@lists.linaro.org, Marc Zyngier <marc.zyngier@arm.com>, Timur Tabi <timur@codeaurora.org>, Mark Salter <msalter@redhat.com>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Sudeep Holla <Sudeep.Holla@arm.com>, Grant Likely <grant.likely@linaro.org>, Mark Brown <broonie@kernel.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Jon Masters <jcm@redhat.com>, Olof Johansson <olof@lixom.net>, Graeme Gregory <graeme.gregory@linaro.org>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 2015/3/26 1:21, Catalin Marinas wrote:
> On Tue, Mar 24, 2015 at 10:02:46PM +0800, Hanjun Guo wrote:
>> CPU hardware ID (phys_id) is defined as u32 in structure acpi_processor,
>> but phys_id is used as int in acpi processor driver, so it will lead to
>> some inconsistence for the drivers.
>>
>> Furthermore, to cater for ACPI arch ports that implement 64 bits CPU
>> ids a generic CPU physical id type is required.
>>
>> So introduce typedef u32 phys_cpuid_t in a common file, and introduce
>> a macro PHYS_CPUID_INVALID as (phys_cpuid_t)(-1) if it's not defined
>> by other archs, this will solve the inconsistence in acpi processor driver,
>> and will prepare for the ACPI on ARM64 for the 64 bit CPU hardware ID
>> in the following patch.
>>
>> CC: Rafael J Wysocki <rjw@rjwysocki.net>
>> Suggested-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Reviewed-by: Grant Likely <grant.likely@linaro.org>
>> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
>> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
>> [hj: reworked cpu physid map return codes]
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> BTW, am I still the author of this patch? If yes, it's missing a From:
> line.

Oops, you should be the author, can Will fix this in his tree?

>
>> --- a/drivers/acpi/acpi_processor.c
>> +++ b/drivers/acpi/acpi_processor.c
>> @@ -170,7 +170,7 @@ static int acpi_processor_hotadd_init(struct acpi_processor *pr)
>>  	acpi_status status;
>>  	int ret;
>>  
>> -	if (pr->phys_id == -1)
>> +	if (pr->phys_id == PHYS_CPUID_INVALID)
>>  		return -ENODEV;
> If PHYS_CPUID_INVALID is the same as INVALID_HWID, we should get rid of
> the latter in the arm64 code (as a subsequent clean-up patch).

OK, I'm preparing a patch set to introduce invalid_phys_cpuid() and invalid_logical_cpuid()
to remove the direct comparison of PHYS_CPUID_INVALID and -1 in ACPI processor drivers,
which is suggested by Rafael, I will cleanup PHYS_CPUID_INVALID in this patch set.

Thanks
Hanjun
>


