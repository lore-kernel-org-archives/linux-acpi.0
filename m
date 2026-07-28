Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA8E4334D1;
	Tue, 28 Jul 2026 12:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785241632; cv=none; b=RvOo/tCD2wdw5f70r1s8EaV49zBfhdLYyNWNjTb9secPvnO0Wht2J6RugciS+XgMv9lKL9BJmKFwBY4brTtszYDDIBGxJH0M05kMMHv20POV8DiP/ycsbDrfwCJKnQ2i77mEG7TRjgES1qTkMhP0/zhDUCT45AaMKI407Oewrys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785241632; c=relaxed/simple;
	bh=sYYt6cI0080YA60MeNLf3+IrwQthG96nJA0VrCXztJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HGfMGGmFdW+ZIYRX8KARZOn7aa1bVASLC8Zd9et1hBo23la+7ew5Lm8tV499iZur2+M6b6pnjJaQefZ9WJ+fcy0RyahcwvXKLc9Qm95gL7uzwqDEKxGFDhQb7YWekzM5gg1nI3qngB5iMi6KBw3MmGWgDlwlZW2E5urGKb/Vqws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=e/tMzIaz; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="e/tMzIaz"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B99E169E;
	Tue, 28 Jul 2026 05:27:05 -0700 (PDT)
Received: from [192.168.178.24] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3100B3F86F;
	Tue, 28 Jul 2026 05:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785241629; bh=sYYt6cI0080YA60MeNLf3+IrwQthG96nJA0VrCXztJQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=e/tMzIazapcHE8Y5I2uvyIENrVnHroCCalDfCKuYAiVeBjo0L7hAc1sdETKNEpFKU
	 6xYMybDFAlq7wJYF4aXXKlFLP/K0jgov6FS0KoLcR8Mszl/9Vj0mvKgRuMwVO9UNsg
	 c3c8z1JGdughm9tnhKM71P8o6AqovBc2afARpahE=
Message-ID: <7219109a-82ac-4a7a-9706-e4db9c243eb5@arm.com>
Date: Tue, 28 Jul 2026 14:27:01 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/10] arm_mpam: add MPAM-Fb MSC firmware access
 support
To: Sudeep Holla <sudeep.holla@kernel.org>, Ben Horgan <ben.horgan@arm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Hanjun Guo <guohanjun@huawei.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 James Morse <james.morse@arm.com>,
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
 <b9502a40-8075-48fc-8ff1-3ae17741ea73@arm.com>
 <20260724-mule-of-sudden-gaiety-9e3933@sudeepholla>
Content-Language: en-GB
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20260724-mule-of-sudden-gaiety-9e3933@sudeepholla>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 7/24/26 20:03, Sudeep Holla wrote:
> On Fri, Jul 24, 2026 at 06:08:52PM +0100, Ben Horgan wrote:
>> Hi Andre,
>>
>> On 7/23/26 16:54, Andre Przywara wrote:
>>> The Arm MPAM Firmware-backed (Fb) Profile document[1] describes an
>>> alternative way of accessing the "Memory System Components" (MSC) in an
>>> MPAM enabled system.
>>>
>>> Normally the MSCs are MMIO mapped, but in some implementations this
>>> might not be possible (MSC located outside of the local socket, MSC
>>> mapped secure-only) or desirable (direct MMIO access too slow or needs
>>> to be mediated through a control processor). MPAM-fb standardises a
>>> protocol to abstract MSC accesses, building on the SCMI protocol.
>>>
>>> Add functions that do an MSC read or write access by redirecting the
>>> request through a firmware interface. For now this done via an ACPI
>>> PCC shared memory and mailbox combination.
>>>
>>> Since the protocol used is only a small subset of the full SCMI spec,
>>> and the SCMI protocol has no full ACPI support anyway, open-code the
>>> (simple) SCMI message generation, for just the fields we need.
>>>
>>> [1] https://developer.arm.com/documentation/den0144/latest
>>>
>>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>>> ---
>>>   drivers/resctrl/Makefile        |   2 +-
>>>   drivers/resctrl/mpam_devices.c  |  27 ++++-
>>>   drivers/resctrl/mpam_fb.c       | 197 ++++++++++++++++++++++++++++++++
>>>   drivers/resctrl/mpam_internal.h |  20 ++++
>>>   include/linux/arm_mpam.h        |   2 +-
>>>   5 files changed, 240 insertions(+), 8 deletions(-)
>>>   create mode 100644 drivers/resctrl/mpam_fb.c
>>>
> 
> [...]

[ ... ]

>>> +
>>> +	writel_relaxed(PCC_CHAN_FLAGS_IRQ, &pcc_shmem->flags);
>>
>> Are you sure it's ok to unconditionally set this irq bit? I know we found out that we do need it set
>> sometimes. What does setting it actually based on what the platform does look like?
>>
> 
> You need to set it if you are not polling the PCC channels for completions.

So I was wondering about that: why does the PCC *user* need to set it 
here? That's probably more of a protocol issue, but to me it breaks the 
abstraction: MPAM-Fb just uses the mailbox provided via PCC, and doesn't 
care about whether it's polling or using an interrupt, because that is a 
PCC detail.
So is there a way to figure this out cleanly? I only found that one 
could possibly chase down the "struct mbox_chan" controller struct, then 
look at txdone_method, or something similar, but that sounds very dodgy?

Do you have any ideas on this?

Cheers,
Andre
