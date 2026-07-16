Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E0336A35E;
	Thu, 16 Jul 2026 08:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784191351; cv=none; b=SL0H4FaRJj6BbLvsBlsk9/DlRQvVaw0bRa2q+1HL1pbtqRcVdGkq1c9ITvGd+fusMBiFceSffxjILR3z7jX/lernybzaBcJVPE3mH9vciVDNz6VwiW5pA8CQx2j36jE35Gx9j/gOt0T32x1v+N/8QRnun6hbrU6fBt50DBAvKYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784191351; c=relaxed/simple;
	bh=AkwPQwean6bJOLieEq5NCfM20lWebUz2uC3qETyOcvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZBvPGoaZmhfoWEDEeN2gScsFQBje7idLgEPZ4T2cVqEHAZnx52rEceV4+uHDLUtvmEmE/SWdJ40N/Ge3Bg+xw86/gEX1vSjVJZ2iAR9eFek6L4aDAkcD2WJ/fHxOeq4PhbOmKB4qZnrx+oiNzKlbWyDb6WxfJN+ghoZwH4KtG1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=o11U1Etg; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="o11U1Etg"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF4C8339;
	Thu, 16 Jul 2026 01:42:24 -0700 (PDT)
Received: from [10.2.212.8] (e134344.arm.com [10.2.212.8])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE8D53F7B4;
	Thu, 16 Jul 2026 01:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784191348; bh=AkwPQwean6bJOLieEq5NCfM20lWebUz2uC3qETyOcvo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=o11U1Etg0MT7MzmigGKzPHOk8/Abs4lqfkEwGaDptWAWhO9fFwb3ADmFvpv+YOJ93
	 IxZn93adAI0GhCveDZb2RsxMijGjp2IDYkQiBxGcwyukDuocrB5nrROh9wxXhA6Bnz
	 cdKNBUyYYPN6/mANS6tBUos752Aug+zr/kCtAg/c=
Message-ID: <4e911af5-1604-4cf4-8a1d-1ec59bbb7939@arm.com>
Date: Thu, 16 Jul 2026 09:42:23 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Thunderbird Daily
Subject: Re: [PATCH v3 06/16] arm_mpam: propagate MSC read errors for
 __ris_msmon_read()
To: Lee Trager <lee@trager.us>, Andre Przywara <andre.przywara@arm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 James Morse <james.morse@arm.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Fenghua Yu <fenghuay@nvidia.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
 Srivathsa L Rao <srivathsa.rao@oss.qualcomm.com>,
 Ganapatrao Kulkarni <ganapatrao.kulkarni@oss.qualcomm.com>,
 Trilok Soni <tsoni@quicinc.com>, Srinivas Ramana <sramana@qti.qualcomm.com>,
 Niyas Sait <niyas.sait@arm.com>, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260710144520.917375-1-andre.przywara@arm.com>
 <20260710144520.917375-7-andre.przywara@arm.com>
 <673b79c0-d2e6-44a6-a1a8-a2ff92f2ff53@trager.us>
Content-Language: en-US
From: Ben Horgan <ben.horgan@arm.com>
In-Reply-To: <673b79c0-d2e6-44a6-a1a8-a2ff92f2ff53@trager.us>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Lee,

On 7/15/26 20:52, Lee Trager wrote:
> On 7/10/26 7:45 AM, Andre Przywara wrote:
> 
>> @@ -1748,6 +1758,7 @@ static int mpam_restore_mbwu_state(void *_ris)
>>   {
>>       int i;
>>       u64 val;
>> +    int ret = 0;
>>       struct mon_read mwbu_arg;
>>       struct mpam_msc_ris *ris = _ris;
>>       struct mpam_class *class = ris->vmsc->comp->class;
>> @@ -1760,10 +1771,14 @@ static int mpam_restore_mbwu_state(void *_ris)
>>               mwbu_arg.val = &val;
>>                 __ris_msmon_read(&mwbu_arg);
>> +            if (mwbu_arg.err) {
>> +                ret = mwbu_arg.err;
>> +                break;
>> +            }
>>           }
>>       }
>>   -    return 0;
>> +    return ret;
>>   }
>>     /* Call with MSC cfg_lock held */
> 
> 
> mwbu_arg is never initialized and __ris_msmon_read() only writes ->err on failure. If on a
> successful read mwb_arg.err tests stack garbage it can spuriously break ot of the loop, leaving the
> remaining monitors unrestored, and return a junk error code.
> 
> Setting `struct mon_read mwbu_arg = {};` matches what mpam_msmon_read() already does. Additionally
> val should be initialized to 0 too. __ris_msmon_reaD() does *m->val += now, and although the result
> is discarded here, KMSAN would flag the uninitialized read.
> 

Thanks for the bug report.

I have a proposed change here which aims to address this existing issue, [1]. Please could you check
and confirm whether this fixes the problem.

[1] https://lore.kernel.org/lkml/20260710115546.29644-8-ben.horgan@arm.com/

Thanks,

Ben
