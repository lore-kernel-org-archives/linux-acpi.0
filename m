Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA772448B90;
	Thu, 24 Sep 2026 10:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790246156; cv=none; b=PNdwNRME5oOnT3HgARo2GOuNCxzwvdL7hgHfYaqYOmEOkJGpoERgQlsiz+Ab2osRXEvtyPLv8ea+Nut++GzGSogx2JINMz7k/ueSeYBidXxYmv8v+a86VB5DjGcsqSdpat+4Ad3LQfW/Eig1LhDfJnu6jkpbPHfkoiJSuiZDwF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790246156; c=relaxed/simple;
	bh=6cyMeBMhrGavK9oDVUWeQnMviClTnzNiDHf2LfBUEFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sM6VgWj3qydBt5DG0iMxhU3MOb1Adyl7AyPZ/w8K6vIeQmEaII98rzvAwfuIPvGEkKSsEW6xLU+Is8GgJyVKax0O1znlPuD0N2scZtEMxZcUemiQIJ2QHGlI/BsvocAY/ybMt8qi/7yTlYQbmqBRA0Mu+sFk2sT5+pF1R1GNKOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=UiDcv+bD; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="UiDcv+bD"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 558AE1516;
	Thu, 24 Sep 2026 03:35:50 -0700 (PDT)
Received: from [192.168.178.24] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D66343F86C;
	Thu, 24 Sep 2026 03:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790246153; bh=6cyMeBMhrGavK9oDVUWeQnMviClTnzNiDHf2LfBUEFI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UiDcv+bDUZWdPZJfaaloYomd7k8j0fBSIHRpGls/xrzxvnzSVPLqHUDPAJ9zwmIT+
	 WpftGglC7ZUCwPI8q24A+v/3sZK02m1/LND/uqGLBHik19UH1BvfmfUrH1nqaTB2Rq
	 8cuOdlAWaZB1ohf5s9IiTnqKcp4ZDJtnAsaA9JCo=
Message-ID: <ca773e60-e709-4b07-bf7f-14f92b8e3e5e@arm.com>
Date: Thu, 24 Sep 2026 12:35:48 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 12/14] arm_mpam: detect and enable MPAM-Fb PCC support
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
 Ritwick Sharma <ritwick.sharma@arm.com>, Gavin Shan <gshan@redhat.com>,
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260911112835.714162-1-andre.przywara@arm.com>
 <20260911112835.714162-13-andre.przywara@arm.com>
 <3e7bdafd-d6ea-422c-82ff-e278a17280ff@arm.com>
 <a314ee8f-4152-4b29-8348-6cd750eced40@arm.com>
 <d96cbb8f-631c-433f-a553-6a6e20531f68@arm.com>
 <20260924-snobbish-brainy-velociraptor-06bdd4@sudeepholla>
Content-Language: en-GB
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20260924-snobbish-brainy-velociraptor-06bdd4@sudeepholla>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Sudeep,

On 9/24/26 11:48, Sudeep Holla wrote:
> On Mon, Sep 21, 2026 at 05:28:27PM +0100, Ben Horgan wrote:
>> Hi Andre,
>>
>> On 21/09/2026 17:09, Andre Przywara wrote:
>>> Hi Ben,
>>>
>>> On 9/11/26 17:09, Ben Horgan wrote:
>>>> Hi Andre,
>>>>
> 
> [...]
> 
>>>>
>>>> This looks like the change earlier in the series to
>>>> drivers/acpi/arm64/mpam.c makes no functional effect unless the proposed
>>>> spec changes are accepted; the default is msc->id. I'd just move the
>>>
>>> Yes, but it reduces churn, and more importantly, is more true to the
>>> MPAM-Fb spec, which says:"The MSC identifiers are sequential and start from
>>> 0 for each agent which uses this protocol." So this requires that we have
>>> per-channel IDs for the MSCs, that's why I think it's justified to
>>> introduce this already now, even when it's somewhat redundant as the code
>>> stands now, as we always assign the system-wide ID to it.
>>>
>>> I can of course move that out (and have that already on top of v9,
>>> internally), but wanted to check this with you.
>>
>> I don't really mind. If Lorenzo/Sudeep are happy with doing the preparation
>> work in drivers/acpi/arm64/mpam.c then I'm ok with it. It's currently a
>> non-functional change but does make the expected path forward slightly
>> clearer.
>>
> 
> Sure, I am okay to have it added here if we plan to use it in the future.
> We can always rip it off if the spec changes its direction or gets deemed
> as broken 😉.
Many thanks, will keep it in then.

Cheers,
Andre
