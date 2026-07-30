Received: from trager.us (trager.us [52.5.81.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD90A329E44;
	Thu, 30 Jul 2026 02:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.5.81.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785377288; cv=none; b=Uj+oP8zWe+L6LtDYDNDjjCuQDCzwjeYa+5vtZ7Pes3aUIFyJbJcvm03e80sILh3MKqHodZ+YVCOjTV6N6aFVP9++PqQpj5H2uXScRrdGyKWiWU/KN6Vw3MdnOIJam1+5reTPN09iJacgK08gDP1POVIXhSlOKbhgLhmTc9xbFSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785377288; c=relaxed/simple;
	bh=geHD1fRBFzvtUBLEeNi8h1FFZBM6jGW4i3szzg/Xa6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YibF88aXkwmtiNVblMCyYf/mzoAKCcYS5fYHRAFgKMMkJPJBFIvmeTr4gOJStTwo6ZhcnGsta3swYYBIKKLcQSCgBOmGi8uyTHiTI5mYIwX/Gf+EXNySFLAVXpNn2HaIWyPW3dqV3Rr27SVUZJO1cRBxVXLi006cZAy91tR6oRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trager.us; spf=pass smtp.mailfrom=trager.us; arc=none smtp.client-ip=52.5.81.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trager.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trager.us
Received: from c-73-254-161-40.hsd1.wa.comcast.net ([73.254.161.40] helo=[192.168.1.226])
	by trager.us with esmtpsa (TLSv1.3:TLS_AES_128_GCM_SHA256:128)
	(Exim 4.92.3)
	(envelope-from <lee@trager.us>)
	id 1wpFen-0008Ic-CM; Thu, 30 Jul 2026 01:33:57 +0000
Message-ID: <2228a2be-96b1-4c8a-9786-6ba07fd302c0@trager.us>
Date: Wed, 29 Jul 2026 18:33:49 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/10] arm_mpam: propagate MSC access errors for MBWU
 counters
To: Andre Przywara <andre.przywara@arm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 James Morse <james.morse@arm.com>, Ben Horgan <ben.horgan@arm.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Fenghua Yu <fenghuay@nvidia.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
 Srivathsa L Rao <srivathsa.rao@oss.qualcomm.com>,
 Ganapatrao Kulkarni <ganapatrao.kulkarni@oss.qualcomm.com>,
 Trilok Soni <tsoni@quicinc.com>, Srinivas Ramana <sramana@qti.qualcomm.com>,
 Niyas Sait <niyas.sait@arm.com>, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260729134124.2506269-1-andre.przywara@arm.com>
 <20260729134124.2506269-4-andre.przywara@arm.com>
Content-Language: en-US
From: Lee Trager <lee@trager.us>
In-Reply-To: <20260729134124.2506269-4-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/29/26 6:41 AM, Andre Przywara wrote:

> @@ -1767,6 +1781,7 @@ static int mpam_save_mbwu_state(void *arg)
>   {
>   	int i;
>   	u64 val;
> +	int ret;
>   	struct mon_cfg *cfg;
>   	u32 cur_flt, cur_ctl, mon_sel;
>   	struct mpam_msc_ris *ris = arg;
> @@ -1777,7 +1792,8 @@ static int mpam_save_mbwu_state(void *arg)
>   		mbwu_state = &ris->mbwu_state[i];
>   		cfg = &mbwu_state->cfg;
>   
> -		if (WARN_ON_ONCE(!mpam_mon_sel_lock(msc)))
> +		ACQUIRE(mon_sel_lock, guard)(msc);
> +		if (ACQUIRE_ERR(mon_sel_lock, &guard))
>   			return -EIO;
>   
>   		mon_sel = FIELD_PREP(MSMON_CFG_MON_SEL_MON_SEL, i) |
> @@ -1788,7 +1804,9 @@ static int mpam_save_mbwu_state(void *arg)
>   		mpam_write_monsel_reg(msc, CFG_MBWU_CTL, 0);
>   
>   		if (mpam_ris_has_mbwu_long_counter(ris)) {
> -			val = mpam_msc_read_mbwu_l(msc);
> +			ret = mpam_msc_read_mbwu_l(msc, &val);
> +			if (ret)
> +				return ret;
>   			mpam_msc_zero_mbwu_l(msc);
>   		} else {
>   			u32 val32;
I think checking for (val & MSMON____L_NRDRY) is still required before 
updating the saved state. mpam_msc_read_mbw_l() can return 0 while 
setting val to MSMON___L_NRDY when it cannot obtain a stable value. The 
state saving path later adds val to mbwu_state->correction, so the 
sentinel would corrupt the saved correction. Additionally, as Ben noted 
during the v3 review, hardware may also set the NRDY bit.
> @@ -1804,7 +1822,6 @@ static int mpam_save_mbwu_state(void *arg)
>   		cfg->partid = FIELD_GET(MSMON_CFG_x_FLT_PARTID, cur_flt);
>   		mbwu_state->correction += val;
>   		mbwu_state->enabled = FIELD_GET(MSMON_CFG_x_CTL_EN, cur_ctl);
> -		mpam_mon_sel_unlock(msc);
>   	}
>   
>   	return 0;
