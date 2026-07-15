Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62D142049E;
	Wed, 15 Jul 2026 13:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784122784; cv=none; b=Qgw5HM8I1JhPGgajfFP56pi0HggD9bqlqHEQkGVh8SbUPc0meJIp81SIlfPCli3BPHnnfNqleyZtUWmHcEsz9s/T6LpOPZ5y8mw3mAWh3kVgCs5uo5gbVhrAPFPJg493nqngZbNPIm99HZDmhrumEeUT+oivdAT9PUQf7qSA+7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784122784; c=relaxed/simple;
	bh=Wf9M5WQzRLOO4AudW1ZFMCjPLzlhRxKffT+HUe3T+8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kK63d+KJQlAOGle5LjFG85KUZ3Ivji1XH7OKIWg05kJLQFazLDRTL88Nyqa0LSwkPEz+waJdVMbWAIYZOammW8x3d7o+rdICdosJnuA6nOBNxYPak2bkt+cXRQqxRJaiPjajnV125lb5BXJjOqUqD6c9ymlC04dmwN29jJk0z8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Vs/1b9wD; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Vs/1b9wD"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F2DC1477;
	Wed, 15 Jul 2026 06:39:37 -0700 (PDT)
Received: from [10.2.212.8] (e134344.arm.com [10.2.212.8])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0DC5F3F915;
	Wed, 15 Jul 2026 06:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784122781; bh=Wf9M5WQzRLOO4AudW1ZFMCjPLzlhRxKffT+HUe3T+8o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Vs/1b9wDq7B/BM3pUJmgSa2Yweux6p0ygpwWDLYME3Uh0URWG4zmRwnbKJKppI4qq
	 I+k2Bo2IpBdFVqi1V2FA7WfkWXUmknEAdOny+9vBF73bYoYPMxVf3cB9ukAiVR/4Sy
	 cf9PhBGlcILhtf07rRkVJsL/nrEuEgCpJ3piL+uA=
Message-ID: <b5f54fad-b7a0-4949-b78a-fe684eeb4d75@arm.com>
Date: Wed, 15 Jul 2026 14:39:37 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Thunderbird Daily
Subject: Re: [PATCH v3 07/16] arm_mpam: __ris_msmon_read(): get rid of nrdy
 special handling
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
References: <20260710144520.917375-1-andre.przywara@arm.com>
 <20260710144520.917375-8-andre.przywara@arm.com>
Content-Language: en-US
From: Ben Horgan <ben.horgan@arm.com>
In-Reply-To: <20260710144520.917375-8-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andre,

On 7/10/26 15:45, Andre Przywara wrote:
> Although so far MSC accesses couldn't fail, there is one special
> condition that would create an error: when the MBWU counter wouldn't be
> able to read a stable value, we were setting bit 63 to mark this value
> as unstable, and return this as an error later.
> Now since the functions can return a proper error value, we can get rid of
> this kludge and use the return value directly.
> 
> Remove the "nrdy" error flag variable, and assign -EBUSY to "ret" to handle
> this case.

I don't think we want this patch. The h/w can still return (as much as it ever could) and so we
still need to handle it even if we are no longer augmenting its meaning in software to also indicate
an unstable 64 bit value.

Thanks,

Ben

> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  drivers/resctrl/mpam_devices.c | 38 +++++++++++++++-------------------
>  1 file changed, 17 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index 84a8715464be..530ac0fe97b5 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -1306,7 +1306,6 @@ static void __ris_msmon_read(void *arg)
>  	u64 now;
>  	int ret;
>  	u32 now32;
> -	bool nrdy = false;
>  	bool config_mismatch;
>  	bool overflow = false;
>  	struct mon_read *m = arg;
> @@ -1371,14 +1370,18 @@ static void __ris_msmon_read(void *arg)
>  	switch (m->type) {
>  	case mpam_feat_msmon_csu:
>  		ret = mpam_read_monsel_reg(msc, CSU, &now32);
> +		if (!ret) {
> +			if ((now32 & MSMON___NRDY))
> +				ret = -EBUSY;
> +
> +			if (mpam_has_quirk(IGNORE_CSU_NRDY, msc) &&
> +			    m->waited_timeout)
> +				ret = 0;
> +		}
>  		if (ret)
>  			goto out_unlock;
> -		nrdy = now32 & MSMON___NRDY;
> -		now = FIELD_GET(MSMON___VALUE, now32);
> -
> -		if (mpam_has_quirk(IGNORE_CSU_NRDY, msc) && m->waited_timeout)
> -			nrdy = false;
>  
> +		now = FIELD_GET(MSMON___VALUE, now32);
>  		break;
>  	case mpam_feat_msmon_mbwu_31counter:
>  	case mpam_feat_msmon_mbwu_44counter:
> @@ -1394,9 +1397,11 @@ static void __ris_msmon_read(void *arg)
>  				now = FIELD_GET(MSMON___L_VALUE, now);
>  		} else {
>  			ret = mpam_read_monsel_reg(msc, MBWU, &now32);
> +			if (!ret && (now32 & MSMON___NRDY))
> +				ret = -EBUSY;
>  			if (ret)
>  				goto out_unlock;
> -			nrdy = now32 & MSMON___NRDY;
> +
>  			now = FIELD_GET(MSMON___VALUE, now32);
>  		}
>  
> @@ -1404,9 +1409,6 @@ static void __ris_msmon_read(void *arg)
>  		    m->type != mpam_feat_msmon_mbwu_63counter)
>  			now *= 64;
>  
> -		if (nrdy)
> -			break;
> -
>  		mbwu_state = &ris->mbwu_state[ctx->mon];
>  
>  		if (overflow)
> @@ -1419,22 +1421,16 @@ static void __ris_msmon_read(void *arg)
>  		now += mbwu_state->correction;
>  		break;
>  	default:
> -		m->err = -EINVAL;
> +		ret = -EINVAL;
>  	}
> -	mpam_mon_sel_unlock(msc);
> -
> -	if (nrdy)
> -		m->err = -EBUSY;
> -
> -	if (!m->err)
> -		*m->val += now;
> -
> -	return;
>  
>  out_unlock:
>  	mpam_mon_sel_unlock(msc);
>  
> -	m->err = ret;
> +	if (ret)
> +		m->err = ret;
> +	else
> +		*m->val += now;
>  }
>  
>  static int _msmon_read(struct mpam_component *comp, struct mon_read *arg)

