Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC474E780D;
	Wed, 30 Sep 2026 15:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790783886; cv=none; b=kduJ2vI5L6Sk1D55MXjX/mRxmb09rYW1NXWjjGT9Nvv7yVIZcusT/pH2P5y/2zW96vqCuagJHo3hmq2q3osC7sMf6MKtNQ7HUiD9cyT/5nlXXDwnJEPjX3x7ANef/jlGEIUBw6JaXittBvOfVQ2zUo2Ue0pPV1O545r+p/g+HOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790783886; c=relaxed/simple;
	bh=5jZg6iv6NWVEGrlBgZMC0jVgzD5L0hoB5RF/9I6xxy4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FNcpEmmOLYipCVK1FGQZee2o4dxWgXbGnhwYn/B8yVU5g9fQwyZQcu7LvXuz0qzL8/sAX50k3SDjWG2N0Qb2yCYE6EwuE5zHcvgg2ke/LT2a9ZMjspMnDa0Fo7BX+IxZ1W0SI27Ek9fCnQhMYGgi7ulc8oTI/ErJfD+1qPMcD8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Mn63Vh0C; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Mn63Vh0C"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2BAB497;
	Wed, 30 Sep 2026 08:57:54 -0700 (PDT)
Received: from [192.168.178.24] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9397F3F86F;
	Wed, 30 Sep 2026 08:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790783878; bh=5jZg6iv6NWVEGrlBgZMC0jVgzD5L0hoB5RF/9I6xxy4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Mn63Vh0CEm3S32fZ4038kKfpiBheiqU0mMpwlQMmGIeN9U+6ixpZS/XvdEfw+GM6a
	 DVVv2DH54oNeXf5FFOv/9LiZwPUZwI0I+Q2QyRanwiHKl9HYBIPOb9njPNGLLRfPLP
	 VxkYsrB3ZDONpR8iJT2BlB41SIf+9q0xetCUnTwU=
Message-ID: <c094216a-cef8-437f-90ba-a1c60384e1ce@arm.com>
Date: Wed, 30 Sep 2026 17:57:50 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 02/13] arm_mpam: propagate MSC access errors for
 hw_probe functions
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
 Ritwick Sharma <ritwick.sharma@arm.com>, Gavin Shan <gshan@redhat.com>,
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260924152739.2865510-1-andre.przywara@arm.com>
 <20260924152739.2865510-3-andre.przywara@arm.com>
 <4cc35ee7-c4d3-40c0-b1f9-24ef5a2f5844@arm.com>
Content-Language: en-GB
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <4cc35ee7-c4d3-40c0-b1f9-24ef5a2f5844@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ben,

On 9/30/26 16:01, Ben Horgan wrote:
> Hi Andre,
> 
> On 24/09/2026 16:27, Andre Przywara wrote:
>> Allow the functions probing for MSC hardware and features to return an
>> error, and propagate read and write errors from the lower level up.
>> This uses some "scoped cleanup" functions like scoped_guard() and
>> ACQUIRE() to avoid the complexity of error handling when a lock has been
>> taken. Since the mon_sel_lock is a bit special (even more so in an
>> upcoming patch), we define a new GUARD type for it.
>>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
>> Reviewed-by: Ben Horgan <ben.horgan@arm.com>
>> Reviewed-by: Gavin Shan <gshan@redhat.com>
>> Tested-by: Gavin Shan <gshan@redhat.com> # on NVIDIA Grace Hopper
>> ---
>>   drivers/resctrl/mpam_devices.c  | 126 +++++++++++++++++++++-----------
>>   drivers/resctrl/mpam_internal.h |   4 +
>>   2 files changed, 87 insertions(+), 43 deletions(-)
>>
>> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
>> index c7686d3799653..22069e7f7bb05 100644
>> --- a/drivers/resctrl/mpam_devices.c
>> +++ b/drivers/resctrl/mpam_devices.c
>> @@ -798,38 +798,46 @@ static bool mpam_ris_hw_probe_csu_nrdy(struct mpam_msc_ris *ris)
>>   	bool can_set, can_clear;
>>   	struct mpam_msc *msc = ris->vmsc->msc;
>>   
>> -	if (WARN_ON_ONCE(!mpam_mon_sel_lock(msc)))
>> +	ACQUIRE(mon_sel_lock, guard)(msc);
>> +	if (ACQUIRE_ERR(mon_sel_lock, &guard))
>>   		return false;
>>   
>>   	mon_sel = FIELD_PREP(MSMON_CFG_MON_SEL_MON_SEL, 0) |
>>   		  FIELD_PREP(MSMON_CFG_MON_SEL_RIS, ris->ris_idx);
>> -	mpam_write_monsel_reg(msc, CFG_MON_SEL, mon_sel);
>> +	if (mpam_write_monsel_reg(msc, CFG_MON_SEL, mon_sel))
>> +		return false;
>>   
>>   	/* Hardware might ignore nrdy if it's not enabled */
>>   	ctl_val = MSMON_CFG_CSU_CTL_TYPE_CSU;
>>   	ctl_val |= MSMON_CFG_x_CTL_MATCH_PARTID;
>>   	ctl_val |= MSMON_CFG_x_CTL_MATCH_PMG;
>>   	ctl_val |= MSMON_CFG_x_CTL_EN;
>> -	mpam_write_monsel_reg(msc, CFG_CSU_FLT, 0);
>> -	mpam_write_monsel_reg(msc, CFG_CSU_CTL, ctl_val);
>> +	if (mpam_write_monsel_reg(msc, CFG_CSU_FLT, 0))
>> +		return false;
>> +	if (mpam_write_monsel_reg(msc, CFG_CSU_CTL, ctl_val))
>> +		return false;
>>   
>> -	_mpam_write_monsel_reg(msc, MSMON_CSU, MSMON___NRDY);
>> -	_mpam_read_monsel_reg(msc, MSMON_CSU, &now);
>> +	if (_mpam_write_monsel_reg(msc, MSMON_CSU, MSMON___NRDY))
>> +		return false;
>> +	if (_mpam_read_monsel_reg(msc, MSMON_CSU, &now))
>> +		return false;
>>   	can_set = now & MSMON___NRDY;
>>   
>> -	_mpam_write_monsel_reg(msc, MSMON_CSU, 0);
>> +	if (_mpam_write_monsel_reg(msc, MSMON_CSU, 0))
>> +		return false;
>>   	/* Configuration change to try and coax hardware into setting nrdy */
>> -	mpam_write_monsel_reg(msc, CFG_CSU_FLT, 0x1);
>> -	_mpam_read_monsel_reg(msc, MSMON_CSU, &now);
>> +	if (mpam_write_monsel_reg(msc, CFG_CSU_FLT, 0x1))
>> +		return false;
>> +	if (_mpam_read_monsel_reg(msc, MSMON_CSU, &now))
>> +		return false;
>>   	can_clear = !(now & MSMON___NRDY);
>> -	mpam_mon_sel_unlock(msc);
>>   
>>   	return (!can_set || !can_clear);
>>   }
> 
> I've had a look at the Sashiko reports [1] for these patches. I'll call out the things that I feel
> need answering.
> 
> As sashiko says, mpam_ris_hw_probe_csu_nrdy(), this swallows the error rather than propagating. It
> would be better if this returned success/error and the answer to whether or not the h/w supports
> nrdy separately. As we make other accesses to the msc later it is unlikely this will ever cause a
> failing probe to report success though.

Well, what I could offer is to make mpam_ris_hw_probe_csu_nrdy() return 
an int, with negative values meaning an error, 0 meaning false, and 1 
being true.
Then, in the caller, do:
	err = mpam_ris_hw_probe_csu_nrdy(ris);
	if (err < 0)
		return err;
	hw_managed = err;

I think a fairly straight-forward change, does this sound OK?

Cheers,
Andre
> 
> Thanks,
> 
> Ben
> 
> [1] https://sashiko.dev/#/patchset/20260924152739.2865510-1-andre.przywara%40arm.com
> 
>>   
>> -static void mpam_ris_hw_probe(struct mpam_msc_ris *ris)
>> +static int mpam_ris_hw_probe(struct mpam_msc_ris *ris)
>>   {
>> -	int err;
>> +	int fw_has_nrdy_err, err;
>>   	struct mpam_msc *msc = ris->vmsc->msc;
>>   	struct device *dev = &msc->pdev->dev;
>>   	struct mpam_props *props = &ris->props;
>> @@ -842,7 +850,9 @@ static void mpam_ris_hw_probe(struct mpam_msc_ris *ris)
>>   	if (FIELD_GET(MPAMF_IDR_HAS_CCAP_PART, ris->idr)) {
>>   		u32 ccap_features;
>>   
>> -		mpam_read_partsel_reg(msc, CCAP_IDR, &ccap_features);
>> +		err = mpam_read_partsel_reg(msc, CCAP_IDR, &ccap_features);
>> +		if (err)
>> +			return err;
>>   
>>   		props->cmax_wd = FIELD_GET(MPAMF_CCAP_IDR_CMAX_WD, ccap_features);
>>   		if (props->cmax_wd &&
>> @@ -867,7 +877,9 @@ static void mpam_ris_hw_probe(struct mpam_msc_ris *ris)
>>   	if (FIELD_GET(MPAMF_IDR_HAS_CPOR_PART, ris->idr)) {
>>   		u32 cpor_features;
>>   
>> -		mpam_read_partsel_reg(msc, CPOR_IDR, &cpor_features);
>> +		err = mpam_read_partsel_reg(msc, CPOR_IDR, &cpor_features);
>> +		if (err)
>> +			return err;
>>   
>>   		props->cpbm_wd = FIELD_GET(MPAMF_CPOR_IDR_CPBM_WD, cpor_features);
>>   		if (props->cpbm_wd)
>> @@ -877,8 +889,9 @@ static void mpam_ris_hw_probe(struct mpam_msc_ris *ris)
>>   	/* Memory bandwidth partitioning */
>>   	if (FIELD_GET(MPAMF_IDR_HAS_MBW_PART, ris->idr)) {
>>   		u32 mbw_features;
>> -
>> -		mpam_read_partsel_reg(msc, MBW_IDR, &mbw_features);
>> +		err = mpam_read_partsel_reg(msc, MBW_IDR, &mbw_features);
>> +		if (err)
>> +			return err;
>>   
>>   		/* portion bitmap resolution */
>>   		props->mbw_pbm_bits = FIELD_GET(MPAMF_MBW_IDR_BWPBM_WD, mbw_features);
>> @@ -907,8 +920,9 @@ static void mpam_ris_hw_probe(struct mpam_msc_ris *ris)
>>   	/* Priority partitioning */
>>   	if (FIELD_GET(MPAMF_IDR_HAS_PRI_PART, ris->idr)) {
>>   		u32 pri_features;
>> -
>> -		mpam_read_partsel_reg(msc, PRI_IDR, &pri_features);
>> +		err = mpam_read_partsel_reg(msc, PRI_IDR, &pri_features);
>> +		if (err)
>> +			return err;
>>   
>>   		props->intpri_wd = FIELD_GET(MPAMF_PRI_IDR_INTPRI_WD, pri_features);
>>   		if (props->intpri_wd && FIELD_GET(MPAMF_PRI_IDR_HAS_INTPRI, pri_features)) {
>> @@ -929,20 +943,24 @@ static void mpam_ris_hw_probe(struct mpam_msc_ris *ris)
>>   	if (FIELD_GET(MPAMF_IDR_HAS_MSMON, ris->idr)) {
>>   		u32 msmon_features;
>>   
>> -		mpam_read_partsel_reg(msc, MSMON_IDR, &msmon_features);
>> +		err = mpam_read_partsel_reg(msc, MSMON_IDR, &msmon_features);
>> +		if (err)
>> +			return err;
>>   
>>   		/*
>>   		 * If the firmware max-nrdy-us property is missing, the
>>   		 * CSU counters can't be used. Should we wait forever?
>>   		 */
>> -		err = device_property_read_u32(&msc->pdev->dev,
>> -					       "arm,not-ready-us",
>> -					       &msc->nrdy_usec);
>> +		fw_has_nrdy_err = device_property_read_u32(&msc->pdev->dev,
>> +							   "arm,not-ready-us",
>> +							   &msc->nrdy_usec);
>>   
>>   		if (FIELD_GET(MPAMF_MSMON_IDR_MSMON_CSU, msmon_features)) {
>>   			u32 csumonidr;
>>   
>> -			mpam_read_partsel_reg(msc, CSUMON_IDR, &csumonidr);
>> +			err = mpam_read_partsel_reg(msc, CSUMON_IDR, &csumonidr);
>> +			if (err)
>> +				return err;
>>   
>>   			props->num_csu_mon = FIELD_GET(MPAMF_CSUMON_IDR_NUM_MON, csumonidr);
>>   			if (props->num_csu_mon) {
>> @@ -960,7 +978,7 @@ static void mpam_ris_hw_probe(struct mpam_msc_ris *ris)
>>   				 * Accept the missing firmware property if NRDY appears
>>   				 * un-implemented.
>>   				 */
>> -				if (err && hw_managed)
>> +				if (fw_has_nrdy_err && hw_managed)
>>   					dev_err_once(dev, "Counters are not usable because not-ready timeout was not provided by firmware.");
>>   			}
>>   		}
>> @@ -968,7 +986,9 @@ static void mpam_ris_hw_probe(struct mpam_msc_ris *ris)
>>   			bool has_long;
>>   			u32 mbwumon_idr;
>>   
>> -			mpam_read_partsel_reg(msc, MBWUMON_IDR, &mbwumon_idr);
>> +			err = mpam_read_partsel_reg(msc, MBWUMON_IDR, &mbwumon_idr);
>> +			if (err)
>> +				return err;
>>   
>>   			props->num_mbwu_mon = FIELD_GET(MPAMF_MBWUMON_IDR_NUM_MON, mbwumon_idr);
>>   			if (props->num_mbwu_mon) {
>> @@ -1001,16 +1021,22 @@ static void mpam_ris_hw_probe(struct mpam_msc_ris *ris)
>>   		u16 partid_max;
>>   		u32 nrwidr;
>>   
>> -		mpam_read_partsel_reg(msc, PARTID_NRW_IDR, &nrwidr);
>> +		err = mpam_read_partsel_reg(msc, PARTID_NRW_IDR, &nrwidr);
>> +		if (err)
>> +			return err;
>> +
>>   		partid_max = FIELD_GET(MPAMF_PARTID_NRW_IDR_INTPARTID_MAX, nrwidr);
>>   
>>   		mpam_set_feature(mpam_feat_partid_nrw, props);
>>   		msc->partid_max = min(msc->partid_max, partid_max);
>>   	}
>> +
>> +	return 0;
>>   }
>>   
>>   static int mpam_msc_hw_probe(struct mpam_msc *msc)
>>   {
>> +	int ret;
>>   	u64 idr;
>>   	u16 partid_max;
>>   	u8 ris_idx, pmg_max;
>> @@ -1025,11 +1051,15 @@ static int mpam_msc_hw_probe(struct mpam_msc *msc)
>>   	}
>>   
>>   	/* Grab an IDR value to find out how many RIS there are */
>> -	mutex_lock(&msc->part_sel_lock);
>> -	mpam_msc_read_idr(msc, &idr);
>> -	mpam_read_partsel_reg(msc, IIDR, &msc->iidr);
>> +	scoped_guard(mutex, &msc->part_sel_lock) {
>> +		ret = mpam_msc_read_idr(msc, &idr);
>> +		if (ret)
>> +			return ret;
>>   
>> -	mutex_unlock(&msc->part_sel_lock);
>> +		ret = mpam_read_partsel_reg(msc, IIDR, &msc->iidr);
>> +		if (ret)
>> +			return ret;
>> +	}
>>   
>>   	mpam_enable_quirks(msc);
>>   
>> @@ -1040,10 +1070,15 @@ static int mpam_msc_hw_probe(struct mpam_msc *msc)
>>   	msc->pmg_max = FIELD_GET(MPAMF_IDR_PMG_MAX, idr);
>>   
>>   	for (ris_idx = 0; ris_idx <= msc->ris_max; ris_idx++) {
>> -		mutex_lock(&msc->part_sel_lock);
>> -		__mpam_part_sel(ris_idx, 0, msc);
>> -		mpam_msc_read_idr(msc, &idr);
>> -		mutex_unlock(&msc->part_sel_lock);
>> +		scoped_guard(mutex, &msc->part_sel_lock) {
>> +			ret = __mpam_part_sel(ris_idx, 0, msc);
>> +			if (ret)
>> +				return ret;
>> +
>> +			ret = mpam_msc_read_idr(msc, &idr);
>> +			if (ret)
>> +				return ret;
>> +		}
>>   
>>   		partid_max = FIELD_GET(MPAMF_IDR_PARTID_MAX, idr);
>>   		pmg_max = FIELD_GET(MPAMF_IDR_PMG_MAX, idr);
>> @@ -1051,17 +1086,22 @@ static int mpam_msc_hw_probe(struct mpam_msc *msc)
>>   		msc->pmg_max = min(msc->pmg_max, pmg_max);
>>   		msc->has_extd_esr = FIELD_GET(MPAMF_IDR_HAS_EXTD_ESR, idr);
>>   
>> -		mutex_lock(&mpam_list_lock);
>> -		ris = mpam_get_or_create_ris(msc, ris_idx);
>> -		mutex_unlock(&mpam_list_lock);
>> -		if (IS_ERR(ris))
>> -			return PTR_ERR(ris);
>> +		scoped_guard(mutex, &mpam_list_lock) {
>> +			ris = mpam_get_or_create_ris(msc, ris_idx);
>> +			if (IS_ERR(ris))
>> +				return PTR_ERR(ris);
>> +		}
>>   		ris->idr = idr;
>>   
>> -		mutex_lock(&msc->part_sel_lock);
>> -		__mpam_part_sel(ris_idx, 0, msc);
>> -		mpam_ris_hw_probe(ris);
>> -		mutex_unlock(&msc->part_sel_lock);
>> +		scoped_guard(mutex, &msc->part_sel_lock) {
>> +			ret = __mpam_part_sel(ris_idx, 0, msc);
>> +			if (ret)
>> +				return ret;
>> +
>> +			ret = mpam_ris_hw_probe(ris);
>> +			if (ret)
>> +				return ret;
>> +		}
>>   	}
>>   
>>   	/* Clear any stale errors */
>> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
>> index def0e3a65c230..68a6cf2b9cc73 100644
>> --- a/drivers/resctrl/mpam_internal.h
>> +++ b/drivers/resctrl/mpam_internal.h
>> @@ -162,6 +162,10 @@ static inline void mpam_mon_sel_lock_init(struct mpam_msc *msc)
>>   	raw_spin_lock_init(&msc->_mon_sel_lock);
>>   }
>>   
>> +DEFINE_GUARD(mon_sel, struct mpam_msc *,
>> +	     mpam_mon_sel_lock(_T), mpam_mon_sel_unlock(_T));
>> +DEFINE_GUARD_COND(mon_sel, _lock, mpam_mon_sel_lock(_T), _RET);
>> +
>>   /* Bits for mpam features bitmaps */
>>   enum mpam_device_features {
>>   	mpam_feat_cpor_part,
> 

