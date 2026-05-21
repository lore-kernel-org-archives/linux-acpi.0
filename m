Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FE4368D70;
	Thu, 21 May 2026 15:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779379187; cv=none; b=sidmW3rOP3NlrxsG1RTk3PvjNl/3kKyoI+uccu5jc+yO4JA3SwFLX2TFdnTnB/r5EWceLcqzXZQib/9mvLDlbXfVkfrLibgo7+3i3YLbbp8UmoUq4q6D6Th4pi75lj7iOY21wr147fua2rZRZn1XQGBiGr0QnpnHll2jm24ddp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779379187; c=relaxed/simple;
	bh=6gbYbC+enanhE/vbMG0bE/ubhoI+jp5XIb+TrXnz5A4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n98wJzyyY9bUBGTdXv6235U6WYh+kt+IKTgGvVtL77ps3e3JSH3uDWvOtqYg1DkBKnTmPmaaI+4HPlvQdl34V69i4RhFbK5vIhyBDgTNQKvBGQmwGrtHARJpPZhk1AS1vRFvXUy+6aFfGAAB6apUI15Y858LCAnUj8jM1NOzx8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=k5fEs6og; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="k5fEs6og"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E73B12BCB;
	Thu, 21 May 2026 08:59:40 -0700 (PDT)
Received: from [192.168.178.24] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3ECA13F632;
	Thu, 21 May 2026 08:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1779379186; bh=6gbYbC+enanhE/vbMG0bE/ubhoI+jp5XIb+TrXnz5A4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=k5fEs6ogf0PPgJ73jUKlAGx+ncWEUg0nY2vpS0iY8PBofwq1AHzv2iE7j3/o3jNzV
	 q3OPAohgxJfyEaXqzkmGDQD3oZZCG07gpefaf/sUPGXWfXmT0XyOMhLvKy69XtD9SK
	 vLkHWzj+R0liSp1lB1QT2IoV9hZwc1N4W7HfbbJs=
Message-ID: <573653c0-7ab5-49b1-99c1-beb21d1788b0@arm.com>
Date: Thu, 21 May 2026 17:59:37 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] arm_mpam: prevent MPAM-Fb accesses inside IRQ handler
To: Niyas Sait <niyas.sait@arm.com>
Cc: ben.horgan@arm.com, catalin.marinas@arm.com, fenghuay@nvidia.com,
 guohanjun@huawei.com, james.morse@arm.com, jic23@kernel.org,
 lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 lpieralisi@kernel.org, rafael@kernel.org, reinette.chatre@intel.com,
 sudeep.holla@kernel.org, will@kernel.org
References: <20260429141339.3171205-5-andre.przywara@arm.com>
 <20260518105708.3268174-1-niyas.sait@arm.com>
Content-Language: en-US
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20260518105708.3268174-1-niyas.sait@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Niyas,

thanks for the reply!

On 5/18/26 12:57, Niyas Sait wrote:
> Hi Andre,
> 
> On Wed, Apr 29, 2026 at 04:13:38PM +0200, Andre Przywara wrote:
> 
>> This error report relies on reading the MSC's error status register
>> (ESR) in the IRQ handler, which is not possible for MPAM-Fb based
>> MSC accesses, since they involve mailbox routines that might sleep.
> 
> I think there are a few other places where we may still end up invoking
> the MPAM-Fb path from atomic/IRQ context.
> 
> For example, _msmon_read() uses smp_call_function_any(), which runs
> __ris_msmon_read() in callback/atomic context

Ah, good point, I thought that the running CPU always being in the mask 
would avoid the IPI - and it does, but it drops the code into atomic 
context anyway, courtesy of disabling preemption when calling get_cpu().
So I just avoid that by checking the interface type and just calling 
__ris_msmon_read() directly for PCC. Maybe there is a smarter solution 
to this, but that seems simple enough.
Will be part of v2.

Many thanks for finding this!

Cheers,
Andre

> 
> static int _msmon_read(struct mpam_component *comp, struct mon_read *arg)
> {
>      ...
>      err = smp_call_function_any(&msc->accessibility,
>                      __ris_msmon_read, arg,
>                      true);
>      ...
> }
> 
> For MPAM-Fb, I think we could potentially avoid the smp_call_function_any() path entirely
> and invoke directly from the current CPU. Since PCC accesses are effectively CPU agnostic,
> I think that should be fine for the MPAM-Fb case.
> 
> Thanks,
> Niyas

