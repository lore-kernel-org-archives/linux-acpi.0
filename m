Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82DF3BB680;
	Fri, 10 Jul 2026 21:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783719647; cv=none; b=kQZ0GcrpxNdd1H/dzHjvaFY/MJLXgXpqEAK710QyJDyIUOSzve/Q03DkN6xixbgj+cSfV64kKwC3kRd8dVdUeNwtbQLo0bd7Yw2z2iIG53/TVpW4vJttXVhMDhzHBkQRAL3l04hIN5Sb5GCKIgAi8bvFbFTtg5/IKmB9HNVn8ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783719647; c=relaxed/simple;
	bh=BaNahvn2h3Vv8JzR4dyMjs4FnPXEyIdEigSNsI7/27g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Eh4ps1Vwjc1Jg467L7zLOsCItHalq10MmOXiBv2EYetOF38sI/QO4zojF/0BV+hIGiyieICjztSAm1KKOi1UcppVfOOTiGibYdnmYgX+PuJMe9twG0xcwj9anvnztRjEvkmTpqwmPPiSiP23Dr0BlOgJ9doYqjFMgUe8DFoZ2uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lwYt9NCo; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lwYt9NCo"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6CC8616A3;
	Fri, 10 Jul 2026 14:40:39 -0700 (PDT)
Received: from [10.20.1.47] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B2C0C3F99C;
	Fri, 10 Jul 2026 14:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783719643; bh=BaNahvn2h3Vv8JzR4dyMjs4FnPXEyIdEigSNsI7/27g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lwYt9NCo+PKUMG6PhHT/mBAiSGNqqBXfRE4XSJC/QJnLmxTaBbxYvbdNli8CivxI0
	 Uh23DQAT9P4A78gQp01gbOkjI1ZHTp4KCN0ipb9krLlcnXP33VtZPqIi1+sec3pGOa
	 taRRhQTeqy41TAGmAl4RpyuBQIeYHpWZeyLDASBs=
Message-ID: <6b2845cf-e7ba-4588-b65a-c52f8ea40237@arm.com>
Date: Fri, 10 Jul 2026 23:40:39 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/16] arm_mpam: let low level MSC read accessors
 return an error
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
 <20260710144520.917375-2-andre.przywara@arm.com>
 <20260710111159.00001367@oss.qualcomm.com>
Content-Language: en-GB
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20260710111159.00001367@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jonathan,

many thanks for the time you spent on this - though it wasn't 
particularly pretty, I guess.

This is just a quick reply, unfortunately (well...) I will be on 
holidays next week, so cannot reply in detail now.

On 7/10/26 20:11, Jonathan Cameron wrote:
> On Fri, 10 Jul 2026 16:45:05 +0200
> Andre Przywara <andre.przywara@arm.com> wrote:
> 
>> The upcoming MPAM-Fb support does not use MMIO primitives to access an
>> MSC, but employs a shared-memory/doorbell based firmware protocol.
>> Its complexity means that is must be able to handle errors, whereas we
>> always assume an MSC access succeeds today.
>>
>> Change the __mpam_read_reg() low level accessor function to return the
>> requested data through a pointer, and return an error code instead.
>> At the moment this is always 0, but this will change with alternative
>> MSC access methods.
>> Change all users of those MSC read wrappers to comply with the new
>> prototype, though at the moment without propagating any errors.
>>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> 
> Why do it in this order? It seems like it is a path for some code churn
> from patch to path.

Well, this is pain however you do this - as you figured. And I knew this 
before, that's why I avoided this in v1, but then found we have to bite 
the bullet at some point anyway, so we could as well just do it now.

So I did the change in one go, and the diff was completely unreadable 
and even more so unreviewable. Then I figured to start with the actual 
root cause: the low level accessors, to show the motivation, then split 
the rest up in reasonably small chunks. And with the unavoidable 
dependencies, this led to the structure you see, with the added churn of 
requested changes and refactors between v2 and v3.

> If you started at the outermost calls and
> worked in adding error handling at each layer, you wouldn't end up with
> the change here to add the parameter, then the same lines changed again
> to stash the new return value. Those lines would change just once.
> Maybe I'm wrong though and it ends up even messier.

Well, I guess there are a few ways to do this, but I doubt there is a 
really great one. And as you can imagine, there is little fun in trying 
a number of them, then comparing them. Doing this the first time was 
already painful. So I thought to just pick one approach and see what 
people say - I guess this was the wrong approach then :-(

> Or as you suggest, maybe just squash the patches, which will also
> remove the churn.
> 
> Jonathan
> 
>> @@ -226,10 +230,11 @@ static inline void _mpam_write_monsel_reg(struct mpam_msc *msc, u16 reg, u32 val
>>   
>>   static bool mpam_msc_check_aidr(struct mpam_msc *msc)
>>   {
>> -	u32 aidr = __mpam_read_reg(msc, MPAMF_AIDR);
>> -	u32 major = FIELD_GET(MPAMF_AIDR_ARCH_MAJOR_REV, aidr);
>> -	u32 minor = FIELD_GET(MPAMF_AIDR_ARCH_MINOR_REV, aidr);
>> +	u32 aidr, major, minor;
>>   
>> +	__mpam_read_reg(msc, MPAMF_AIDR, &aidr);
> 
> This will need updating to handle the error.  If you were to instead do
> the patches in the opposite order. So add return value to the outer
> most calls that is always 0 then work your way in it should end up
> as a fair bit less code churn.

But is it really better to review? You later say code lines are cheap, 
I'd say commits are cheap as well, but reviews are not. The idea was to 
allow separate, contained reviews, without forcing people to sit through 
all of this in one go - which you apparently did, so my condolences.
So yes, it's not the best to touch lines several times, but do we really 
care so much? Is it just about git blame?

Cheers,
Andre

> That update is in a later patch.
> 
>> +	major = FIELD_GET(MPAMF_AIDR_ARCH_MAJOR_REV, aidr);
>> +	minor = FIELD_GET(MPAMF_AIDR_ARCH_MINOR_REV, aidr);
>>   	/*
>>   	 * v0.0 and >v2.x aren't supported, but anything else should be backward
>>   	 * compatible to v0.1 or v1.0.

