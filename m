Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74AF24E3778;
	Tue, 21 Jul 2026 15:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784647363; cv=none; b=bBySUmOUmlyhlKv/pou4+fSirB2cd3jCAjn9zIPrbIYkUyr9sBBx0i1BU58l3Orz5uVTjDx7ik8uM8wMCTgCcLu6vnEiK4bHyZBQTKIiVLFiwr+16z4dKu28xjWRqfcMrFCOBQyUkCOd8Qq5yBtEgyEtNoWf9xuN1vii4eMmeV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784647363; c=relaxed/simple;
	bh=ebC/KIEEoNmoB2LEHpuG7uefGwo6M6AiHFPKN8Met2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YVsVeLo7bARv1VN8sNCBY5ZIQjhXGuHDCScRfLqQmn36M3Oa9n8t6Eg7mucdvcT1ZgbYxGzjAHZeJ5HjNnjhjIAgh9K0Zl7vL2iNbNGlifkAtyg5/WsDPL/Fz1ZRSS2m+vfVduYMPbulu4IJP2snO0ryijrNCp6GaUkVIGCjBME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Ycj3DZbj; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Ycj3DZbj"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D90B4152B;
	Tue, 21 Jul 2026 08:22:36 -0700 (PDT)
Received: from [192.168.178.24] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB6B43F58B;
	Tue, 21 Jul 2026 08:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784647361; bh=ebC/KIEEoNmoB2LEHpuG7uefGwo6M6AiHFPKN8Met2Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ycj3DZbj847kTPAxwJhBzvfoukDVrAiT1VmAJT/yy9IzWzXwRYTIsSj3/Fw1zu8vr
	 Fn4Qwmaz32lEQkRbF6XDJDv3iqDy6L7AvEZ7nUIYqU+g6pe+GiEanoDYmijTYfet/2
	 resCUEeLHD+AIs0N73DPsB2jl539HR0JN0qUKxv0=
Message-ID: <e00593bb-acc3-4e1d-967b-7102259d556b@arm.com>
Date: Tue, 21 Jul 2026 17:22:39 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/16] arm_mpam: prepare mon_sel locking for MPAM-Fb
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 James Morse <james.morse@arm.com>, Ben Horgan <ben.horgan@arm.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Fenghua Yu
 <fenghuay@nvidia.com>, Jonathan Cameron <jic23@kernel.org>,
 Srivathsa L Rao <srivathsa.rao@oss.qualcomm.com>,
 Ganapatrao Kulkarni <ganapatrao.kulkarni@oss.qualcomm.com>,
 Trilok Soni <tsoni@quicinc.com>, Srinivas Ramana <sramana@qti.qualcomm.com>,
 Niyas Sait <niyas.sait@arm.com>, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260710144520.917375-1-andre.przywara@arm.com>
 <20260710144520.917375-14-andre.przywara@arm.com>
 <20260710121433.00001ad6@oss.qualcomm.com>
Content-Language: en-GB
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20260710121433.00001ad6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 7/10/26 21:14, Jonathan Cameron wrote:
> On Fri, 10 Jul 2026 16:45:17 +0200
> Andre Przywara <andre.przywara@arm.com> wrote:
> 
>> The MSC MON_SEL register needs to be accessed from hardirq for the overflow
>> interrupt, and when taking an IPI to access these registers on platforms
>> where MSC are not accesible from every CPU. This makes an irqsave
>> spinlock the obvious lock to protect these registers. On systems with SCMI
>> mailboxes it must be able to sleep, meaning a mutex must be used. The
>> SCMI platforms can't support an overflow interrupt.
>> Clearly these two can't exist for one MSC at the same time.
>>
>> Change the mon_sel locking wrapper function to only use a spinlock when
>> the MSC is accessed directly via MMIO. In case of MPAM-Fb, we use a
>> mutex, but only if we are in a sleepable context. If that's not the
>> case, we return an error. This should not happen, as MPAM-Fb by design
>> does not require an MSC access to happen from a specific CPU, so there
>> is no need for any IPIs or preemption disabling to satisfy CPU
>> constraints. And since overflow interrupts are not supported at the moment
>> anyway, we also wouldn't meet the other case.
>>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> 
> I've not been paying attention to this topic, so I might come back
> with some more feedback after I've had time to think about it a bit!
> So trivial stuff only for now.
> 
>>   
>>   static inline void mpam_mon_sel_lock_init(struct mpam_msc *msc)
>>   {
>>   	raw_spin_lock_init(&msc->_mon_sel_lock);
>> +	mutex_init(&msc->mon_sel_mutex);
> 
> I'm not that fussed, but maybe add a call to mutex_destroy().
> Most likely it'll never help catch anything in this code though..

I figured I can follow the rest of the code and extract the dev pointer 
from struct mpam_msc, then use devm_mutex_init().

Cheers,
Andre

> 
>>   }
>>   
>>   /* Bits for mpam features bitmaps */
> 

