Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93315389116;
	Fri,  3 Jul 2026 09:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783069259; cv=none; b=bi1E2o0m/prqrscgqdZEgf6aAdj9eIksoi6KDPsiT9W2wDw9fgRcW9oT3pMaY7kiajGinIOUuqJLisisQBcrSyLtQ1SA4KqEeu3UrgSNqQfiH4xB9BZDN2DhFGRB8ngwOTwjPS458x8T+S0ihPz8/Ype+92SFlpP2wNfXNqsaIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783069259; c=relaxed/simple;
	bh=FaTU6ZiyPyiPxJG4iwJWWSF1yEgoyNUyWDD0Eltw0Nc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N3Gl972a/iZ7bdQIjYfKqPl3KHWSjQKjLz5tOaxdtjA1dmJ+zY+iqHDHeXapAswMZM+IpP/deCiLa2YlTjQfc7Z5s2FUFzyVpos5WGaRr6VuHgfyx2vogVFPxkIv3POh60BLyUt0sMuWNk45Z7HuS/A4WPc7iDjbT7bWMr85ROQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lN7tnWTi; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lN7tnWTi"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84C9B1684;
	Fri,  3 Jul 2026 02:00:52 -0700 (PDT)
Received: from [10.211.55.3] (unknown [10.57.73.238])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 58C973F905;
	Fri,  3 Jul 2026 02:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783069256; bh=FaTU6ZiyPyiPxJG4iwJWWSF1yEgoyNUyWDD0Eltw0Nc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lN7tnWTipISpo9m4CaYXRl0gVWPXXDKsf7gAD4vvvnJ/Z4/jkg6moMIhL/WWyqExu
	 2p0O7hjGjA1NK3XdyTd7HNkneZ+hFShU5sf2L4PtUuBSxpMvEhQkIsRe2eKcPosD3T
	 O+0OMCcSvHl2wEQqYAMeWyW7RCewAh8P1/gyzpJw=
Message-ID: <fa9440a9-cfbe-4eef-a255-a4aed196640e@arm.com>
Date: Wed, 1 Jul 2026 21:19:28 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Thunderbird Daily
Subject: Re: [PATCH v2 07/15] arm_mpam: propagate MSC read errors for state
 saving functions
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
 <20260702162229.4008659-8-andre.przywara@arm.com>
Content-Language: en-US
From: Ben Horgan <ben.horgan@arm.com>
In-Reply-To: <20260702162229.4008659-8-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andre,

On 7/2/26 17:22, Andre Przywara wrote:
> Allow the mpam_save_mbwu_state() function to return an error, and
> propagate read errors from the lower level up.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  drivers/resctrl/mpam_devices.c | 47 +++++++++++++++++++++-------------
>  1 file changed, 29 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index d18c7be86aaa..c50ca0e4f426 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -1773,6 +1773,7 @@ static int mpam_save_mbwu_state(void *arg)
>  {
>  	int i;
>  	u64 val;
> +	int ret;
>  	struct mon_cfg *cfg;
>  	u32 cur_flt, cur_ctl, mon_sel;
>  	struct mpam_msc_ris *ris = arg;
> @@ -1789,31 +1790,41 @@ static int mpam_save_mbwu_state(void *arg)
>  		mon_sel = FIELD_PREP(MSMON_CFG_MON_SEL_MON_SEL, i) |
>  			  FIELD_PREP(MSMON_CFG_MON_SEL_RIS, ris->ris_idx);
>  		mpam_write_monsel_reg(msc, CFG_MON_SEL, mon_sel);
> -		mpam_read_monsel_reg(msc, CFG_MBWU_FLT, &cur_flt);
> -		mpam_read_monsel_reg(msc, CFG_MBWU_CTL, &cur_ctl);
> -		mpam_write_monsel_reg(msc, CFG_MBWU_CTL, 0);
> +		ret = mpam_read_monsel_reg(msc, CFG_MBWU_FLT, &cur_flt);
> +		if (!ret)
> +			ret = mpam_read_monsel_reg(msc, CFG_MBWU_CTL, &cur_ctl);
> +		if (!ret)
> +			mpam_write_monsel_reg(msc, CFG_MBWU_CTL, 0);
>  
> -		if (mpam_ris_has_mbwu_long_counter(ris)) {
> -			val = mpam_msc_read_mbwu_l(msc);
> -			mpam_msc_zero_mbwu_l(msc);
> -		} else {
> -			u32 val32;
> +		if (!ret) {
> +			if (mpam_ris_has_mbwu_long_counter(ris)) {
> +				val = mpam_msc_read_mbwu_l(msc);
> +				mpam_msc_zero_mbwu_l(msc);
> +			} else {
> +				u32 val32;
>  
> -			mpam_read_monsel_reg(msc, MBWU, &val32);
> -			val = val32;
> -			mpam_write_monsel_reg(msc, MBWU, 0);
> +				ret = mpam_read_monsel_reg(msc, MBWU, &val32);
> +				if (!ret) {
> +					val = val32;
> +					mpam_write_monsel_reg(msc, MBWU, 0);
> +				}
> +			}
>  		}
>  
> -		cfg->mon = i;
> -		cfg->pmg = FIELD_GET(MSMON_CFG_x_FLT_PMG, cur_flt);
> -		cfg->match_pmg = FIELD_GET(MSMON_CFG_x_CTL_MATCH_PMG, cur_ctl);
> -		cfg->partid = FIELD_GET(MSMON_CFG_x_FLT_PARTID, cur_flt);
> -		mbwu_state->correction += val;
> -		mbwu_state->enabled = FIELD_GET(MSMON_CFG_x_CTL_EN, cur_ctl);
> +		if (!ret && val != MSMON___L_NRDY) {
> +			cfg->mon = i;
> +			cfg->pmg = FIELD_GET(MSMON_CFG_x_FLT_PMG, cur_flt);
> +			cfg->match_pmg = FIELD_GET(MSMON_CFG_x_CTL_MATCH_PMG, cur_ctl);
> +			cfg->partid = FIELD_GET(MSMON_CFG_x_FLT_PARTID, cur_flt);
> +			mbwu_state->correction += val;
> +			mbwu_state->enabled = FIELD_GET(MSMON_CFG_x_CTL_EN, cur_ctl);
> +		}
>  		mpam_mon_sel_unlock(msc);
> +		if (ret)
> +			break;

There is a lot of if(!ret) in this loop. Does it not end up cleaner to
add an out_unlock label after the loop and jump to that in the failure
cases?

Thanks,

Ben

>  	}
>  
> -	return 0;
> +	return ret;
>  }
>  
>  /*

