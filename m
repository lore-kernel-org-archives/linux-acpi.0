Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B582A2931D0;
	Wed, 15 Jul 2026 16:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784131288; cv=none; b=Nd11O9Qj9yjVL78kSjc9b8VIXuKoHAgHW9GEnZ6ULMBaBnfwZI2E9japsWK/8VQamDR3YcKWMCnPF4mkOARKawVD+OpDDh+p17MIwV+aigpaEJJ8pFJ+BLeuu61EcEkycFJLyZnvSLo/HMP3IAczTW+DdunvpdIqArgglgWm6Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784131288; c=relaxed/simple;
	bh=mJJklrROHEk/tA5Mbwt+AYggUFwOMun7Z1dh7jn/DRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U+06setksoRncRss6gf/NpHXfDbPuIfaPIJN48su5YYrlZ1vWmixbSlV4F+M3/PNhAb5Ek2zpgeR0KMKJ6Ow+DAFgqx2br6ce9RYSdZ+jMY+QOH2PmVWH+o2pyW+TEW4cbPzlp56+NBfJtmmPnUsalsbiuPOVrkzfgNvbJXjclo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=FKpGyqfy; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="FKpGyqfy"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B11481477;
	Wed, 15 Jul 2026 09:01:21 -0700 (PDT)
Received: from [10.2.212.8] (e134344.arm.com [10.2.212.8])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3315C3F905;
	Wed, 15 Jul 2026 09:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784131285; bh=mJJklrROHEk/tA5Mbwt+AYggUFwOMun7Z1dh7jn/DRE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FKpGyqfyRetwxovw7y092KStA6+osWVtZ6nL37lpeA8y6aLmqMjEoPzX4rOKopVqf
	 StzSCYj2CtYBlVW8jVmM/BWw8XRB3Ehp2QslU5myRNBlRXGCN95lC1FngFDDiBOko2
	 HLz4+DH1EIFjanOUJBaTfLaP2VZms3VeDHYZly4M=
Message-ID: <7cbb06bc-7fac-4323-915a-9a6fc3330f5d@arm.com>
Date: Wed, 15 Jul 2026 17:01:21 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Thunderbird Daily
Subject: Re: [PATCH v3 01/16] arm_mpam: let low level MSC read accessors
 return an error
To: Andre Przywara <andre.przywara@arm.com>,
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 James Morse <james.morse@arm.com>,
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
 <6b2845cf-e7ba-4588-b65a-c52f8ea40237@arm.com>
Content-Language: en-US
From: Ben Horgan <ben.horgan@arm.com>
In-Reply-To: <6b2845cf-e7ba-4588-b65a-c52f8ea40237@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andre,

On 7/10/26 22:40, Andre Przywara wrote:
> Hi Jonathan,
> 
> many thanks for the time you spent on this - though it wasn't particularly pretty, I guess.
> 
> This is just a quick reply, unfortunately (well...) I will be on holidays next week, so cannot reply
> in detail now.
> 
> On 7/10/26 20:11, Jonathan Cameron wrote:
>> On Fri, 10 Jul 2026 16:45:05 +0200
>> Andre Przywara <andre.przywara@arm.com> wrote:
>>
>>> The upcoming MPAM-Fb support does not use MMIO primitives to access an
>>> MSC, but employs a shared-memory/doorbell based firmware protocol.
>>> Its complexity means that is must be able to handle errors, whereas we
>>> always assume an MSC access succeeds today.
>>>
>>> Change the __mpam_read_reg() low level accessor function to return the
>>> requested data through a pointer, and return an error code instead.
>>> At the moment this is always 0, but this will change with alternative
>>> MSC access methods.
>>> Change all users of those MSC read wrappers to comply with the new
>>> prototype, though at the moment without propagating any errors.
>>>
>>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>>
>> Why do it in this order? It seems like it is a path for some code churn
>> from patch to path.
> 
> Well, this is pain however you do this - as you figured. And I knew this before, that's why I
> avoided this in v1, but then found we have to bite the bullet at some point anyway, so we could as
> well just do it now.
> 
> So I did the change in one go, and the diff was completely unreadable and even more so unreviewable.
> Then I figured to start with the actual root cause: the low level accessors, to show the motivation,
> then split the rest up in reasonably small chunks. And with the unavoidable dependencies, this led
> to the structure you see, with the added churn of requested changes and refactors between v2 and v3.
> 

From my point view, I think the order of the patches is ok and I'd consider it a bonus if you do
find a clean way to avoid changing the same line twice in this patch set. What I'm more interested
in is that the code itself is clean and consistent but with correctness trumping everything. I
hadn't discovered the ACQUIRE() and ACQUIRE_ERR() before but I do expect that, as Jonathan points
out, they could be used judiciously to make the code clearer.

Thanks,

Ben
