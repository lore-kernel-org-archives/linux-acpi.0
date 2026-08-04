Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168003F39D1;
	Tue,  4 Aug 2026 09:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785837283; cv=none; b=tTCAi8q76H75/NXCrQpygDKPKur91EGye/8+ma+qcayrMc7CcvxmlzWED1aJbDiPE9U1WZzWESDnQo6lMMp521uCqYXLa3cczGV1eOLJUh5v4x5ceOuLJGMDI5ctX4jFFIQYdfEW8eWjxr7tQaQx6XhonErKqcFRwwWNLzIA54g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785837283; c=relaxed/simple;
	bh=XHZ8Hn1v8UipXDtFoVeXGBoWJHqviZySPsof6RP0r40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hePFgOHUf2Cj+bx6tHTYOAvMeYqXJiZIlKYJDCcM4IGAzpGNfPefxx6N/p7Y6nPjfezT42uQ4rx6+bqi4y1pkVv47PIqKe6JOkhU3Td7U+Fgs+2XaEq4eQYJs7A2J9OTwwhRsHTsE7a7Lk4xkq2VG5suaI9bJk5xRFbHxF/WGns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=S1+IOk0W; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="S1+IOk0W"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D26601476;
	Tue,  4 Aug 2026 02:54:35 -0700 (PDT)
Received: from [192.168.178.24] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EEBF03F66F;
	Tue,  4 Aug 2026 02:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785837279; bh=XHZ8Hn1v8UipXDtFoVeXGBoWJHqviZySPsof6RP0r40=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=S1+IOk0W+TSwCHa0LsWc7vuTiAIYvzmGB8EH+zDJ+rwqGOjxDsYXhJFHcsZZbB8xK
	 ZlJpgJLhu2475SS1WnJmA5Om/MTrDqmFoW9TfNbg/4WU1+xpzrNvqNWGIDbRyCxIhV
	 GUDksdC4d0BLkEQAaWEritumj0kjMca+EWf/MBcY=
Message-ID: <2aa75a48-d514-42a2-afda-d7b3357c585a@arm.com>
Date: Tue, 4 Aug 2026 11:54:33 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 07/11] arm_mpam: propagate MSC access errors for
 mpam_reprogram_ris_partid()
To: Srivathsa L Rao <srivathsa.rao@oss.qualcomm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 James Morse <james.morse@arm.com>, Ben Horgan <ben.horgan@arm.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Fenghua Yu <fenghuay@nvidia.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
 Ganapatrao Kulkarni <ganapatrao.kulkarni@oss.qualcomm.com>,
 Trilok Soni <tsoni@quicinc.com>, Srinivas Ramana <sramana@qti.qualcomm.com>,
 Niyas Sait <niyas.sait@arm.com>, Lee Trager <lee@trager.us>,
 Ritwick Sharma <ritwick.sharma@arm.com>, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260731170324.2927758-1-andre.przywara@arm.com>
 <20260731170324.2927758-8-andre.przywara@arm.com>
 <836c6c2b-6ab0-4dba-9964-aa65ddcb7381@oss.qualcomm.com>
Content-Language: en-GB
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <836c6c2b-6ab0-4dba-9964-aa65ddcb7381@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 8/4/26 07:57, Srivathsa L Rao wrote:
> Hi Andre,
> 
> mpam_reprogram_ris_partid() writes hardware registers sequentially.
> If a write fails midway (possible on PCC MSCs via SCMI), the earlier
> writes are already committed and the hardware is left in a partially
> configured state.
> Currently this is safe only because mpam_fb_disable_mpam() tears
> everything down on any firmware error. If that behavior is ever
> relaxed (e.g. for transient BUSY handling), a partial state could
> persist and produce weird behavior?
> 
> I wanted to point this as a design note.

Yes, this might be a potential problem, but as you said at the moment we 
tear down MPAM anyway.
I don't know if we can ever really handle MPAM-Fb errors in a meaningful 
way, but indeed a retry-if-busy seems a worthwhile addition - at a later 
time ;-)

Thanks for all the reviews and comments!

Cheers,
Andre

> On 7/31/2026 10:33 PM, Andre Przywara wrote:
>> Allow the mpam_reprogram_ris_partid() function check for and return
>> errors, and propagate MSC read and write errors from the lower level up.
>> This also covers the callers of this function: mpam_reset_ris() and
>> apply_config().
>>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>> ---
>>   drivers/resctrl/mpam_devices.c | 136 ++++++++++++++++++++++-----------
>>   1 file changed, 93 insertions(+), 43 deletions(-)
>>
>> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/ 
>> mpam_devices.c
>> index 38450c55e45e..32088ad1d67e 100644
>> --- a/drivers/resctrl/mpam_devices.c
>> +++ b/drivers/resctrl/mpam_devices.c
>> @@ -1601,7 +1601,7 @@ void mpam_msmon_reset_mbwu(struct mpam_component 
>> *comp, struct mon_cfg *ctx)
>>       }
>>   }
>>   ...
> 
>> +static int mpam_reprogram_ris_partid(struct mpam_msc_ris *ris, u16 
>> partid,
>> +                     struct mpam_config *cfg)
>>   {
>>       u32 pri_val = 0;
>>       ..
>> -    mutex_unlock(&msc->part_sel_lock);
>> +    return 0;
>>   }
> -- 
> 
> Best Regards,
> Srivathsa

