Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107E53783B0;
	Fri,  3 Jul 2026 08:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783068150; cv=none; b=Xx1R8LYRD9ZWONQjSOiHJgNosw4hzp86CjOC6XuwoH/3rkpDvXvTlP9NeMJht9RSQu4SzZZ/0OZWW2scEL5mrqnKtnDCrCNZx0FA4R2cRNcv5uf8s8YZhFa7dMvMUcsfr9nIgPTD9faKD9KQC3mGVAUTzxaKJXl46s6WKxCsNNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783068150; c=relaxed/simple;
	bh=qPN+0EoXG8L0C7DiygFnkIw7nf3VUC+KuOM6KpifZ7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HCNvu0ytPKRVh/sFLEIyqVPhQhlFhQ0sDvPzPNyfauAj5vPLio+95aQNPLPIRlqnufZeFh+t1DuvGIYhbpv6PD+osdVlWtQMtXGqm0FaYzMsD3NTPDwO2dhJeWK1rGaHr8Q1C85hAaYlcZD3dJ/hcfN8dUDOwk5ypkBLu6MvWo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=XaKFecEs; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="XaKFecEs"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3FE8F1F60;
	Fri,  3 Jul 2026 01:42:20 -0700 (PDT)
Received: from [10.211.55.3] (unknown [10.57.73.238])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4A2B93F905;
	Fri,  3 Jul 2026 01:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783068144; bh=qPN+0EoXG8L0C7DiygFnkIw7nf3VUC+KuOM6KpifZ7o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XaKFecEsN7h+h2apNY8Z5g5/vb6bQ8rBudcHUdrG+LIyv62g4MFnziVs7rErL/mOH
	 JIv2BmjgLfeoUjXKH5MdWvdQ3zmKcxHfRIZSgjQo7wtUdTrp05GtUza/5xKeoDWO+K
	 G2meiIX+/C8s2tppnOtBnTkhwI0ddASocLXfKZiM=
Message-ID: <a628a34f-fd1a-4bd1-ba45-73d49922cc13@arm.com>
Date: Wed, 1 Jul 2026 21:00:56 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Thunderbird Daily
Subject: Re: [PATCH v2 03/15] arm_mpam: propagate MSC read errors for hw_probe
 functions
To: Andre Przywara <andre.przywara@arm.com>,
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
References: <20260702162229.4008659-1-andre.przywara@arm.com>
 <20260702162229.4008659-4-andre.przywara@arm.com>
Content-Language: en-US
From: Ben Horgan <ben.horgan@arm.com>
In-Reply-To: <20260702162229.4008659-4-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andre,

On 7/2/26 17:22, Andre Przywara wrote:
> Allow the functions probing for MSC hardware and features to return an
> error, and propagate read errors from the lower level up.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  drivers/resctrl/mpam_devices.c | 62 ++++++++++++++++++++++++----------
>  1 file changed, 44 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index ce8738adb6ff..011d1e3544d7 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -800,20 +800,22 @@ static bool mpam_ris_hw_probe_csu_nrdy(struct mpam_msc_ris *ris)
>  	mpam_write_monsel_reg(msc, CFG_CSU_CTL, ctl_val);
>  
>  	_mpam_write_monsel_reg(msc, MSMON_CSU, MSMON___NRDY);
> -	_mpam_read_monsel_reg(msc, MSMON_CSU, &now);
> +	if (_mpam_read_monsel_reg(msc, MSMON_CSU, &now))
> +		return false;

This early return leaves the mon_sel lock held.

>  	can_set = now & MSMON___NRDY;

As you're adding early returns to this function does it make sense to
return early if can_set is false?

Thanks,

Ben

>  
>  	_mpam_write_monsel_reg(msc, MSMON_CSU, 0);
>  	/* Configuration change to try and coax hardware into setting nrdy */
>  	mpam_write_monsel_reg(msc, CFG_CSU_FLT, 0x1);
> -	_mpam_read_monsel_reg(msc, MSMON_CSU, &now);
> +	if (_mpam_read_monsel_reg(msc, MSMON_CSU, &now))
> +		return false;
>  	can_clear = !(now & MSMON___NRDY);
>  	mpam_mon_sel_unlock(msc);
>  
>  	return (!can_set || !can_clear);
>  }
>  
> -static void mpam_ris_hw_probe(struct mpam_msc_ris *ris)
> +static int mpam_ris_hw_probe(struct mpam_msc_ris *ris)
>  {
>  	int err;
>  	struct mpam_msc *msc = ris->vmsc->msc;
> @@ -828,7 +830,9 @@ static void mpam_ris_hw_probe(struct mpam_msc_ris *ris)
>  	if (FIELD_GET(MPAMF_IDR_HAS_CCAP_PART, ris->idr)) {
>  		u32 ccap_features;
>  
> -		mpam_read_partsel_reg(msc, CCAP_IDR, &ccap_features);
> +		err = mpam_read_partsel_reg(msc, CCAP_IDR, &ccap_features);
> +		if (err)
> +			return err;
>  
>  		props->cmax_wd = FIELD_GET(MPAMF_CCAP_IDR_CMAX_WD, ccap_features);
>  		if (props->cmax_wd &&
> @@ -853,7 +857,9 @@ static void mpam_ris_hw_probe(struct mpam_msc_ris *ris)
>  	if (FIELD_GET(MPAMF_IDR_HAS_CPOR_PART, ris->idr)) {
>  		u32 cpor_features;
>  
> -		mpam_read_partsel_reg(msc, CPOR_IDR, &cpor_features);
> +		err = mpam_read_partsel_reg(msc, CPOR_IDR, &cpor_features);
> +		if (err)
> +			return err;
>  
>  		props->cpbm_wd = FIELD_GET(MPAMF_CPOR_IDR_CPBM_WD, cpor_features);
>  		if (props->cpbm_wd)
> @@ -863,8 +869,9 @@ static void mpam_ris_hw_probe(struct mpam_msc_ris *ris)
>  	/* Memory bandwidth partitioning */
>  	if (FIELD_GET(MPAMF_IDR_HAS_MBW_PART, ris->idr)) {
>  		u32 mbw_features;
> -
> -		mpam_read_partsel_reg(msc, MBW_IDR, &mbw_features);
> +		err = mpam_read_partsel_reg(msc, MBW_IDR, &mbw_features);
> +		if (err)
> +			return err;
>  
>  		/* portion bitmap resolution */
>  		props->mbw_pbm_bits = FIELD_GET(MPAMF_MBW_IDR_BWPBM_WD, mbw_features);
> @@ -893,8 +900,9 @@ static void mpam_ris_hw_probe(struct mpam_msc_ris *ris)
>  	/* Priority partitioning */
>  	if (FIELD_GET(MPAMF_IDR_HAS_PRI_PART, ris->idr)) {
>  		u32 pri_features;
> -
> -		mpam_read_partsel_reg(msc, PRI_IDR, &pri_features);
> +		err = mpam_read_partsel_reg(msc, PRI_IDR, &pri_features);
> +		if (err)
> +			return err;
>  
>  		props->intpri_wd = FIELD_GET(MPAMF_PRI_IDR_INTPRI_WD, pri_features);
>  		if (props->intpri_wd && FIELD_GET(MPAMF_PRI_IDR_HAS_INTPRI, pri_features)) {
> @@ -915,7 +923,9 @@ static void mpam_ris_hw_probe(struct mpam_msc_ris *ris)
>  	if (FIELD_GET(MPAMF_IDR_HAS_MSMON, ris->idr)) {
>  		u32 msmon_features;
>  
> -		mpam_read_partsel_reg(msc, MSMON_IDR, &msmon_features);
> +		err = mpam_read_partsel_reg(msc, MSMON_IDR, &msmon_features);
> +		if (err)
> +			return err;
>  
>  		/*
>  		 * If the firmware max-nrdy-us property is missing, the
> @@ -928,7 +938,9 @@ static void mpam_ris_hw_probe(struct mpam_msc_ris *ris)
>  		if (FIELD_GET(MPAMF_MSMON_IDR_MSMON_CSU, msmon_features)) {
>  			u32 csumonidr;
>  
> -			mpam_read_partsel_reg(msc, CSUMON_IDR, &csumonidr);
> +			err = mpam_read_partsel_reg(msc, CSUMON_IDR, &csumonidr);
> +			if (err)
> +				return err;
>  
>  			props->num_csu_mon = FIELD_GET(MPAMF_CSUMON_IDR_NUM_MON, csumonidr);
>  			if (props->num_csu_mon) {
> @@ -954,7 +966,9 @@ static void mpam_ris_hw_probe(struct mpam_msc_ris *ris)
>  			bool has_long;
>  			u32 mbwumon_idr;
>  
> -			mpam_read_partsel_reg(msc, MBWUMON_IDR, &mbwumon_idr);
> +			err = mpam_read_partsel_reg(msc, MBWUMON_IDR, &mbwumon_idr);
> +			if (err)
> +				return err;
>  
>  			props->num_mbwu_mon = FIELD_GET(MPAMF_MBWUMON_IDR_NUM_MON, mbwumon_idr);
>  			if (props->num_mbwu_mon) {
> @@ -987,16 +1001,22 @@ static void mpam_ris_hw_probe(struct mpam_msc_ris *ris)
>  		u16 partid_max;
>  		u32 nrwidr;
>  
> -		mpam_read_partsel_reg(msc, PARTID_NRW_IDR, &nrwidr);
> +		err = mpam_read_partsel_reg(msc, PARTID_NRW_IDR, &nrwidr);
> +		if (err)
> +			return err;
> +
>  		partid_max = FIELD_GET(MPAMF_PARTID_NRW_IDR_INTPARTID_MAX, nrwidr);
>  
>  		mpam_set_feature(mpam_feat_partid_nrw, props);
>  		msc->partid_max = min(msc->partid_max, partid_max);
>  	}
> +
> +	return 0;
>  }
>  
>  static int mpam_msc_hw_probe(struct mpam_msc *msc)
>  {
> +	int ret;
>  	u64 idr;
>  	u16 partid_max;
>  	u8 ris_idx, pmg_max;
> @@ -1012,10 +1032,12 @@ static int mpam_msc_hw_probe(struct mpam_msc *msc)
>  
>  	/* Grab an IDR value to find out how many RIS there are */
>  	mutex_lock(&msc->part_sel_lock);
> -	mpam_msc_read_idr(msc, &idr);
> -	mpam_read_partsel_reg(msc, IIDR, &msc->iidr);
> -
> +	ret = mpam_msc_read_idr(msc, &idr);
> +	if (!ret)
> +		ret = mpam_read_partsel_reg(msc, IIDR, &msc->iidr);
>  	mutex_unlock(&msc->part_sel_lock);
> +	if (ret)
> +		return ret;
>  
>  	mpam_enable_quirks(msc);
>  
> @@ -1028,8 +1050,10 @@ static int mpam_msc_hw_probe(struct mpam_msc *msc)
>  	for (ris_idx = 0; ris_idx <= msc->ris_max; ris_idx++) {
>  		mutex_lock(&msc->part_sel_lock);
>  		__mpam_part_sel(ris_idx, 0, msc);
> -		mpam_msc_read_idr(msc, &idr);
> +		ret = mpam_msc_read_idr(msc, &idr);
>  		mutex_unlock(&msc->part_sel_lock);
> +		if (ret)
> +			return ret;
>  
>  		partid_max = FIELD_GET(MPAMF_IDR_PARTID_MAX, idr);
>  		pmg_max = FIELD_GET(MPAMF_IDR_PMG_MAX, idr);
> @@ -1046,8 +1070,10 @@ static int mpam_msc_hw_probe(struct mpam_msc *msc)
>  
>  		mutex_lock(&msc->part_sel_lock);
>  		__mpam_part_sel(ris_idx, 0, msc);
> -		mpam_ris_hw_probe(ris);
> +		ret = mpam_ris_hw_probe(ris);
>  		mutex_unlock(&msc->part_sel_lock);
> +		if (ret)
> +			return ret;
>  	}
>  
>  	/* Clear any stale errors */

