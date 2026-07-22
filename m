Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800F13E5EF0;
	Wed, 22 Jul 2026 15:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784735612; cv=none; b=csM34dhRu4U9R7SPWqotMXs4xdfdwvb8gX0DW40w6WtLiP2fmVEAQCQ6akny29JJEnaYIHlNda8n8BIXFr5EXM5dCylgIoNoMI9bNkqly+oBXf7wS3o5T3gXavLFcWLke4KJa5FYbm3ZvNkMbdOqDYhqbe+SD2/NTCj3DO2p/Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784735612; c=relaxed/simple;
	bh=dcp6HTSyuOWcjJDMfXlAQoNquO+oXsqnobogH3j6v8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rlaIlM7FQgv/01/NNYjxZCKk7/1u/4540YGDqF8xXW41PgN22kZEMImcv5rSXR1OgdDaAGVLmVCE4RUdbGB7MuAqu4hDZqedhRX1FbgpaFOAnh3c0P2Z/5dJo4TSM70ofcrZc95OMMaxWviGKTMvHTe8/cgQqD1C5ky48zEySuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=cABz2ofc; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="cABz2ofc"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97C001595;
	Wed, 22 Jul 2026 08:53:26 -0700 (PDT)
Received: from [192.168.178.24] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 15F543F66F;
	Wed, 22 Jul 2026 08:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784735610; bh=dcp6HTSyuOWcjJDMfXlAQoNquO+oXsqnobogH3j6v8g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cABz2ofccR8DvclNcEDmORPHdPNFDAr1BWe7QCujRVuzOrM0iUm+128bKYrP4DyWB
	 jAhv4u8hWJWVJY3pg7BwaH8EydZp53TxLEdkRHgwU3BHyZHz4LJ58kRl6QWqaPZXBa
	 Qut1QGdQ1Mm81GQEyO3Q0wMWPwj2aZLiA+evQqBE=
Message-ID: <e5cfe018-4b04-4f65-8142-d9ae19eee6a4@arm.com>
Date: Wed, 22 Jul 2026 17:53:28 +0200
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

I just used devm_mutex_init() now, like we already do for the other mutexes.

Cheers,
Andre

> 
>>   }
>>   
>>   /* Bits for mpam features bitmaps */
> 

