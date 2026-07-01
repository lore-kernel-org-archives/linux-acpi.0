Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B48D342523;
	Fri,  3 Jul 2026 08:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783068960; cv=none; b=VJo62MZpQJoeLQxjDYY2zU6HGowkH1u2vUG9O6QnzQZ7GuZ3VSZ9s1xvaMaBipomlbz9CioQHB4KsdTj5CUTsPsCsWjxR+KOteIgHBQNox5waJXqnBRa5BtZzdEmDjgAEwXpRBSglkaLArSv1VsK0hoYtynpX8vbyAg7S1Bk8dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783068960; c=relaxed/simple;
	bh=+KB54fHhiLJ7QJHqj8KD4+z0cUvnDc9dzs+QfuUqKrU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D/Eyy0Pz/CcdE1/MgT4nZc0a2RuKjZUsCu5Vbh94w6dG/HjRG7xWE5IGCdzbfa/1es8wyQOI28wbIkpUbcCIB8Z2NRbndOO/GHvF+RfOlcaLWJBS1QjpW9XjV0hvDByK7pSm/2y0SteC/9fdW+rIY+6HE2V30b4EmgI7vSm6Hhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=UPDgItcV; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="UPDgItcV"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C72251F60;
	Fri,  3 Jul 2026 01:55:51 -0700 (PDT)
Received: from [10.211.55.3] (unknown [10.57.73.238])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF5D23F905;
	Fri,  3 Jul 2026 01:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783068956; bh=+KB54fHhiLJ7QJHqj8KD4+z0cUvnDc9dzs+QfuUqKrU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UPDgItcVp7b5gJHl98aXaC78cmuWm17hyGjnqb1XIfXOjEEtOk493dvXvCa8NvSKZ
	 ugPsi9QDZ8z/fuWuTv9vkJ1ddjd89GR55lfYDPKRAcQBm4TZdE8f8LEO0Qiw3P20sR
	 a7Bm+t5A/z1KmjnpJ26F3w/ZYDGrhZyqFFR5ndrg=
Message-ID: <332b1348-285f-4b4a-9d3d-97f040739703@arm.com>
Date: Wed, 1 Jul 2026 21:14:27 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Thunderbird Daily
Subject: Re: [PATCH v2 06/15] arm_mpam: propagate MSC read errors for
 __ris_msmon_read()
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
 <20260702162229.4008659-7-andre.przywara@arm.com>
Content-Language: en-US
From: Ben Horgan <ben.horgan@arm.com>
In-Reply-To: <20260702162229.4008659-7-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andre,

On 7/2/26 17:22, Andre Przywara wrote:
> Allow the function for RIS accesses to return an error, and propagate
> read errors from the lower level up.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  drivers/resctrl/mpam_devices.c | 35 +++++++++++++++++++++++++++-------
>  1 file changed, 28 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index b259fe20a614..d18c7be86aaa 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -1285,9 +1285,14 @@ static u64 mpam_msmon_overflow_val(enum mpam_device_features type,
>  	return overflow_val;
>  }
>  
> +/*
> + * This function might be called via smp_call_function_any(), so propagate
> + * errors inside the arg struct.
> + */
>  static void __ris_msmon_read(void *arg)
>  {
>  	u64 now;
> +	int ret;
>  	u32 now32;
>  	bool nrdy = false;
>  	bool config_mismatch;
> @@ -1326,7 +1331,9 @@ static void __ris_msmon_read(void *arg)
>  	 * Read the existing configuration to avoid re-writing the same values.
>  	 * This saves waiting for 'nrdy' on subsequent reads.
>  	 */
> -	read_msmon_ctl_flt_vals(m, &cur_ctl, &cur_flt);
> +	ret = read_msmon_ctl_flt_vals(m, &cur_ctl, &cur_flt);
> +	if (ret)
> +		goto out_unlock;
>  
>  	if (mpam_feat_msmon_mbwu_31counter == m->type)
>  		overflow = cur_ctl & MSMON_CFG_x_CTL_OFLOW_STATUS;
> @@ -1351,7 +1358,9 @@ static void __ris_msmon_read(void *arg)
>  
>  	switch (m->type) {
>  	case mpam_feat_msmon_csu:
> -		mpam_read_monsel_reg(msc, CSU, &now32);
> +		ret = mpam_read_monsel_reg(msc, CSU, &now32);
> +		if (ret)
> +			goto out_unlock;
>  		nrdy = now32 & MSMON___NRDY;
>  		now = FIELD_GET(MSMON___VALUE, now32);
>  
> @@ -1371,7 +1380,9 @@ static void __ris_msmon_read(void *arg)
>  			else
>  				now = FIELD_GET(MSMON___L_VALUE, now);
>  		} else {
> -			mpam_read_monsel_reg(msc, MBWU, &now32);
> +			ret = mpam_read_monsel_reg(msc, MBWU, &now32);
> +			if (ret)
> +				goto out_unlock;
>  			nrdy = now32 & MSMON___NRDY;
>  			now = FIELD_GET(MSMON___VALUE, now32);
>  		}
> @@ -1402,10 +1413,15 @@ static void __ris_msmon_read(void *arg)
>  	if (nrdy)
>  		m->err = -EBUSY;
>  
> -	if (m->err)
> -		return;
> +	if (!m->err)
> +		*m->val += now;

Why does this change? Can't you keep this the 'if' statement as before
and more the 'return' after the '*m->val += now;'?

Thanks,

Ben

> +
> +	return;
>  
> -	*m->val += now;
> +out_unlock:
> +	mpam_mon_sel_unlock(msc);
> +
> +	m->err = ret;
>  }
>  
>  static int _msmon_read(struct mpam_component *comp, struct mon_read *arg)
> @@ -1729,6 +1745,7 @@ static int mpam_restore_mbwu_state(void *_ris)
>  {
>  	int i;
>  	u64 val;
> +	int ret = 0;
>  	struct mon_read mwbu_arg;
>  	struct mpam_msc_ris *ris = _ris;
>  	struct mpam_class *class = ris->vmsc->comp->class;
> @@ -1741,10 +1758,14 @@ static int mpam_restore_mbwu_state(void *_ris)
>  			mwbu_arg.val = &val;
>  
>  			__ris_msmon_read(&mwbu_arg);
> +			if (mwbu_arg.err) {
> +				ret = mwbu_arg.err;
> +				break;
> +			}
>  		}
>  	}
>  
> -	return 0;
> +	return ret;
>  }
>  
>  /* Call with MSC cfg_lock held */

