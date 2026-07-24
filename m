Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A97437466;
	Fri, 24 Jul 2026 11:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784891875; cv=none; b=GIGNKD8QJs+cttlGLdGGxjmnPuExjfOxq+bY0ibo8xwmZLTgx3Kis6Wh4CWVi9sirHLH4OTYsj89Dsh5LGC+vo+1lnhyvr//+sWJkkYZ5flGTunFIPrEu98W8UztabaypG8jstbg6NEvTWzj0uMnUfEVjwJdFUBq5yvUIe//khU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784891875; c=relaxed/simple;
	bh=nRhQGNdV3NsNtoyXHQTSsEbqe72lGzHbtCTadOTmg7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=en3HMsm5qKbnBpxqI2WrhQtoPNNtgkI8AZHH1ZFYNACHoHGWluRaOYacMeCa7MRBgmAz/JMerEb6gu/yg5SgJptHtfxpF2JRXdVNCWvtyn4WAj+w+PTWht1nd/ug7ZAVfq+JxnPek7JfC8OMfwst5o8adDwqWz1A/x0Tb699ur0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=QW5fiAKT; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="QW5fiAKT"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3797A1477;
	Fri, 24 Jul 2026 04:17:44 -0700 (PDT)
Received: from [192.168.178.24] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3E52C3F59E;
	Fri, 24 Jul 2026 04:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784891868; bh=nRhQGNdV3NsNtoyXHQTSsEbqe72lGzHbtCTadOTmg7A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QW5fiAKTizvxmC9c2ol0J4mipfSYnLhE5IIQ/t4rR++hGC7GNaLsYFgdbPJTG1a+Z
	 jfEiCVsWkoroObSk+451XSen8vzeUQaJVFKrwJjiBGugxdl2E/4IPwqwuShEHsTHOa
	 JVbHPGH1GYa462tMSVMwm7oKeXeJsIEHHztJf6X0=
Message-ID: <9d5fd63a-5e9d-4e44-8f63-864764caf20d@arm.com>
Date: Fri, 24 Jul 2026 13:17:41 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/10] arm_mpam: add MPAM-Fb MSC firmware access
 support
To: Sudeep Holla <sudeep.holla@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Hanjun Guo <guohanjun@huawei.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 James Morse <james.morse@arm.com>, Ben Horgan <ben.horgan@arm.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Fenghua Yu
 <fenghuay@nvidia.com>, Jonathan Cameron <jic23@kernel.org>,
 Srivathsa L Rao <srivathsa.rao@oss.qualcomm.com>,
 Ganapatrao Kulkarni <ganapatrao.kulkarni@oss.qualcomm.com>,
 Trilok Soni <tsoni@quicinc.com>, Srinivas Ramana <sramana@qti.qualcomm.com>,
 Niyas Sait <niyas.sait@arm.com>, Lee Trager <lee@trager.us>,
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260723155454.1760823-1-andre.przywara@arm.com>
 <20260723155454.1760823-9-andre.przywara@arm.com>
 <20260724-imposing-lurking-toucanet-cfe22c@sudeepholla>
Content-Language: en-GB
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20260724-imposing-lurking-toucanet-cfe22c@sudeepholla>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sudeep,

many thanks for having a look!

On 7/24/26 11:55, Sudeep Holla wrote:
> On Thu, Jul 23, 2026 at 05:54:52PM +0200, Andre Przywara wrote:
>> The Arm MPAM Firmware-backed (Fb) Profile document[1] describes an
>> alternative way of accessing the "Memory System Components" (MSC) in an
>> MPAM enabled system.
>>
>> Normally the MSCs are MMIO mapped, but in some implementations this
>> might not be possible (MSC located outside of the local socket, MSC
>> mapped secure-only) or desirable (direct MMIO access too slow or needs
>> to be mediated through a control processor). MPAM-fb standardises a
>> protocol to abstract MSC accesses, building on the SCMI protocol.
>>
>> Add functions that do an MSC read or write access by redirecting the
>> request through a firmware interface. For now this done via an ACPI
>> PCC shared memory and mailbox combination.
>>
>> Since the protocol used is only a small subset of the full SCMI spec,
>> and the SCMI protocol has no full ACPI support anyway, open-code the
>> (simple) SCMI message generation, for just the fields we need.
>>
>> [1] https://developer.arm.com/documentation/den0144/latest
>>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>> ---
>>   drivers/resctrl/Makefile        |   2 +-
>>   drivers/resctrl/mpam_devices.c  |  27 ++++-
>>   drivers/resctrl/mpam_fb.c       | 197 ++++++++++++++++++++++++++++++++
>>   drivers/resctrl/mpam_internal.h |  20 ++++
>>   include/linux/arm_mpam.h        |   2 +-
>>   5 files changed, 240 insertions(+), 8 deletions(-)
>>   create mode 100644 drivers/resctrl/mpam_fb.c
>>
>> diff --git a/drivers/resctrl/Makefile b/drivers/resctrl/Makefile
>> index 4f6d0e81f9b8..097c036724e9 100644
>> --- a/drivers/resctrl/Makefile
>> +++ b/drivers/resctrl/Makefile
>> @@ -1,5 +1,5 @@
>>   obj-$(CONFIG_ARM64_MPAM_DRIVER)			+= mpam.o
>> -mpam-y						+= mpam_devices.o
>> +mpam-y						+= mpam_devices.o mpam_fb.o
>>   mpam-$(CONFIG_ARM64_MPAM_RESCTRL_FS)		+= mpam_resctrl.o
>>   
>>   ccflags-$(CONFIG_ARM64_MPAM_DRIVER_DEBUG)	+= -DDEBUG
>> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
>> index e2cb884eacf4..b8108ed4b32c 100644
>> --- a/drivers/resctrl/mpam_devices.c
>> +++ b/drivers/resctrl/mpam_devices.c
>> @@ -181,6 +181,9 @@ static int __mpam_read_reg(struct mpam_msc *msc, u16 reg, u32 *res)
>>   {
>>   	WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(), &msc->accessibility));
>>
> 
> The above doesn't make any sense for PCC accesses, perhaps need to be pushed
> down ?

Well, the idea was that the mask would always encompass all CPUs when 
using MPAM-Fb, but to consider this an implementation detail of MPAM-Fb.
We can of course move this out of the way for MPAM-Fb.

> 
>> +	if (msc->iface == MPAM_IFACE_PCC)
>> +		return mpam_fb_send_read_request(msc, reg, res);
>> +
>>   	*res = readl_relaxed(msc->mapped_hwpage + reg);
>>   
>>   	return 0;
>> @@ -197,9 +200,12 @@ static inline int _mpam_read_partsel_reg(struct mpam_msc *msc, u16 reg,
>>   
>>   static int __mpam_write_reg(struct mpam_msc *msc, u16 reg, u32 val)
>>   {
>> -	WARN_ON_ONCE(reg + sizeof(u32) > msc->mapped_hwpage_sz);
>>   	WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(), &msc->accessibility));
>>   
> 

And by the way: I think the hwpage_sz check should belong to the probe 
function, not be done on every access. Or are there optional registers 
that might not be part of the mapping on devices that don't support them?

Cheers,
Andre



