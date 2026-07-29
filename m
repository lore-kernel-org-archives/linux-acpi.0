Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2153B346ADA;
	Wed, 29 Jul 2026 08:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785312440; cv=none; b=fWceXnDyDbwwcEOULYoquPq1ks6C/WBBD/tSiKJGNGDwZZohL/Pjwk1F14lJMDe4DZj3rYGcUXlpUGhU7vK2i2vRMkTqstNGri9vBQ0LuPIBswjPHh7HTzNGH6MmGoVGGxVtbznB4eSGV/Lp8ksg450BFfX4Pt7ceqdev2V6Kgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785312440; c=relaxed/simple;
	bh=i7PzkEehVu75EIC0APFs4hTtDTk14MQooNuNPKdMABQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tah0zKPZ6mk4RoyyIWYiQIdJYggg2YiSYVrYeT2s70TKvW0gMnLHmsRZSKkJUcHlHvu51Mlw52Bi+FxhZbgpK6wDQwv+kuACQVzSaeXfKF6Y4GPXAXXISWjEUp6qY/JCStA4v5OMPlej/x9QGC4m6Zz2yeTANYJBE4TzwYam4ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=kCiN/vwi; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="kCiN/vwi"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AEB94169C;
	Wed, 29 Jul 2026 01:07:12 -0700 (PDT)
Received: from [192.168.178.24] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AB2CB3F66F;
	Wed, 29 Jul 2026 01:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785312436; bh=i7PzkEehVu75EIC0APFs4hTtDTk14MQooNuNPKdMABQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kCiN/vwi8GU+jvEG4eydMgSMVsQ2h8LtD9QF1NjLDD3kUSOB469NTPI6HK3Ec4OCH
	 lKiR7aQWYwFxR8imPiElpVNCSTX5payzo/ZciWfDJzyAh+RTBnZlepTAzndloWo4my
	 5+qyE/Szo6JsyB7f6bgldX8zH4nbgtEQ+/bbx5bQ=
Message-ID: <2eaa5334-5677-4b52-9459-63005cfcc23f@arm.com>
Date: Wed, 29 Jul 2026 10:07:12 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/10] arm_mpam: add MPAM-Fb MSC firmware access
 support
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 James Morse <james.morse@arm.com>, Ben Horgan <ben.horgan@arm.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Fenghua Yu
 <fenghuay@nvidia.com>, Srivathsa L Rao <srivathsa.rao@oss.qualcomm.com>,
 Ganapatrao Kulkarni <ganapatrao.kulkarni@oss.qualcomm.com>,
 Trilok Soni <tsoni@quicinc.com>, Srinivas Ramana <sramana@qti.qualcomm.com>,
 Niyas Sait <niyas.sait@arm.com>, Lee Trager <lee@trager.us>,
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260723155454.1760823-1-andre.przywara@arm.com>
 <20260723155454.1760823-9-andre.przywara@arm.com>
 <20260728002252.77064c3b@jic23-huawei>
Content-Language: en-GB
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20260728002252.77064c3b@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jonathan,

On 7/28/26 01:22, Jonathan Cameron wrote:
> On Thu, 23 Jul 2026 17:54:52 +0200
> Andre Przywara <andre.przywara@arm.com> wrote:
> 
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
> Just a couple of suggestions that you can ignore if you like
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

Thanks!

> 
>> diff --git a/drivers/resctrl/mpam_fb.c b/drivers/resctrl/mpam_fb.c
>> new file mode 100644
>> index 000000000000..ec4bf0dd9182
>> --- /dev/null
>> +++ b/drivers/resctrl/mpam_fb.c
>> @@ -0,0 +1,197 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +// Copyright (C) 2024 Arm Ltd.
> 
> Arm has either been working on this for rather a long time or that's a cut
> and paste.  Even if 2024 is a good start given changes during revisions
> seems reasonable to include 2026 as well.

===================
Date:   Tue May 21 11:26:16 2024 +0100

     firmware: arm_scmi: add MPAM-FB SCMI protocol stub
========================

So yes, it's been in the making for a while, although in a different 
shape and form.
But will surely add the current year to the range.

>> +struct mpam_fb_read_payload {
>> +	u32 msc_id;
>> +	u32 flags;
>> +	u32 reg_offset;
>> +} __packed;
>> +
>> +struct mpam_fb_write_payload {
> 
> Given these are only used in the specific functions that build the
> messages you could move the structure definitions to be local to those
> functions.
> 
> Alternatively you could move all these to the header and get the advantage
> of using a union to get the maximum message size rather than a number
> currently picked out of the air.

A union sounds nice, but it feels a bit over the top, and I think 
keeping the structs local to their users trumps this. After all this is 
what mpam_fb.c does: deal with the protocol internals, without bothering 
the rest of the code.

> 
>> +	u32 msc_id;
>> +	u32 flags;
>> +	u32 reg_offset;
>> +	u32 value;
>> +} __packed;
> 
> 
> 
>> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
>> index b3a6ed9ed175..e4686ff0ba2e 100644
>> --- a/drivers/resctrl/mpam_internal.h
>> +++ b/drivers/resctrl/mpam_internal.h
> 
> ...
> 
>> +#define MPAM_FB_PROT_HEADER_LEN	sizeof(u32)
>> +#define MPAM_FB_MAX_MSG_SIZE	(MPAM_FB_PROT_HEADER_LEN + 4 * sizeof(u32))
> 
> Doesn't seem to be used until patch 10.  Might be more sensible to bring it
> in there. A spec reference might also be good for this.  I think longest
> is current the MPAM_MSC_WRITE.  A note above that one option would be
> to make this explicit by having the message structure definitions in this
> header.

Yes, but I will not boil the ocean, and just add a comment.

Thanks,
Andre
