Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC793128D7;
	Fri, 31 Jul 2026 08:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785485794; cv=none; b=qS5hUS2AgYPPq4PcNVZSG3kfwFBMvJrcmgwMQAuwrMbowYP6WeMjQMdgKtpnM7QHiBEhoVpdG9LyPR1D3yO8FhdO/qRFndy9YiVRgaiQXZO0UEQqbJq4UnNQUchhWV6mcMlK/LjSr/0/ETCsO8Wf4AKcNhD4V4cHSxvcN+3wjyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785485794; c=relaxed/simple;
	bh=ODD+RQ3c0scVEL717WO54IAEdEQGya0ubicBxFrbSIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jQoEInTxrPlJAlJhSNZS4f6VoLDfg/R32003iRg12qd/MOTp6DFTJbF4YfuA5bRi1cU360Q8NcMZ+YpgScT14nqCp/A+ncJFZc0/sm2QOqRgbl7Q5zkNoJ2YemKEKykimeSY1QzUE6u6Md+eys7wmRRUoNHvT+E2Di1TLxGP2yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=DdPztJIQ; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="DdPztJIQ"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 87C0C204C;
	Fri, 31 Jul 2026 01:16:25 -0700 (PDT)
Received: from [192.168.178.24] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C4503F86F;
	Fri, 31 Jul 2026 01:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785485789; bh=ODD+RQ3c0scVEL717WO54IAEdEQGya0ubicBxFrbSIc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DdPztJIQ7rODWoZdz9EXRz6whXe2bm/U/1uJqikbIUFxF/8lvx87RA4hyN+dP19y1
	 BvP2OVdH2MYw6Le7L43/rvpHVXqwegrztZA5dIL8CBUjtoyT1nhZK8VPJ/8ajA8Hg/
	 OIx7uEQXQzNZFbeuXamGSqibAERYQFNi6barE1LE=
Message-ID: <b3224280-4925-41ed-8e45-838eb212d093@arm.com>
Date: Fri, 31 Jul 2026 10:16:24 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 10/10] arm_mpam: detect and enable MPAM-Fb PCC support
To: Ben Horgan <ben.horgan@arm.com>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, Hanjun Guo <guohanjun@huawei.com>,
 Sudeep Holla <sudeep.holla@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 James Morse <james.morse@arm.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Fenghua Yu <fenghuay@nvidia.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
 Srivathsa L Rao <srivathsa.rao@oss.qualcomm.com>,
 Ganapatrao Kulkarni <ganapatrao.kulkarni@oss.qualcomm.com>,
 Trilok Soni <tsoni@quicinc.com>, Srinivas Ramana <sramana@qti.qualcomm.com>,
 Niyas Sait <niyas.sait@arm.com>, Lee Trager <lee@trager.us>,
 Ritwick Sharma <ritwick.sharma@arm.com>, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260730152539.2712312-1-andre.przywara@arm.com>
 <20260730152539.2712312-11-andre.przywara@arm.com>
 <e09e7d37-59bb-4a4f-b47e-a014c674796e@arm.com>
Content-Language: en-GB
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <e09e7d37-59bb-4a4f-b47e-a014c674796e@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ben,

On 7/30/26 18:13, Ben Horgan wrote:
> Hi Andre,
> 
> On 7/30/26 16:25, Andre Przywara wrote:
>> The Arm MPAM-Fb specification [1] describes a protocol to access MSC
>> registers through a firmware interface. This requires a shared memory
>> region to hold the message, and a mailbox to trigger the access.
>> For ACPI this is wrapped as a PCC channel, described using existing
>> ACPI abstractions.
>>
>> Add code to parse those PCC table descriptions associated with an MSC,
>> and store the parsed information in the MSC struct.
>> There can be multiple PCC channels, and each channel can serve multiple
>> MSCs, so we need to keep track of the channel usage, using a list and
>> a refcount.
>>
>> This will be used by the MPAM-Fb access wrapper code.
>>
>> [1] https://developer.arm.com/documentation/den0144/latest
>>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>> Tested-by: Ritwick Sharma <ritwick.sharma@arm.com>
> Ritwick gave his Tested-by for the series on v5. Any reason to just add the tag on this patch?

submitting-patches.rst says:
"Both Tested-by and Reviewed-by tags, once received on mailing list from 
tester or reviewer, should be added by author to the *applicable* 
patches when sending next versions."

I think this system relies on MPAM-Fb, so he couldn't test each patch in 
isolation, but "just" that MPAM-Fb works, which is what only patch 10/10 
enables.

So I find tags given for the whole series always tricky to handle, but 
in this case I figured patch 10/10 would be the right target.

> I guess patch 9 has significant enough changes to drop tags but I don't see it for the others.

Well, even smaller changes could ruin a whole thing, but IIUC in this 
case Ritwick's setup doesn't even enable error IRQs, so this part wasn't 
tested anyway.

Cheers,
Andre.

