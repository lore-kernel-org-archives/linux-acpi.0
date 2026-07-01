Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F5622CBE6;
	Fri,  3 Jul 2026 08:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783067912; cv=none; b=XjDt5w66hTJjQ3MWFBSBwIY+MFjyH6jjvW/FauyG7Kqc6sGBl3GeGlGljHzkqgV2s94w4sl8ynP1bo5+QeO7OFXopiP211Xt98l+qFxvilVnICnyXwriXd6L51uYD/O+rTs0mcDz1D+YpTeSCde7+BZ99rMJy3hn2WpEd4Vz4Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783067912; c=relaxed/simple;
	bh=KcfAyjvfIggeRPUgM5kQPKdIyZKtYOy5nlDTfsdQLwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SFimwZd26z9/YFbhF6prb2bwYsp3nqX9VVWQHaSZw2t8JGD22wHmrsTNNiF0uWsSZs3t4ouGpf5NM7FL8Q/BQGoro8I+wYQdYAuCr2pWCTEDiE7xVq7QcY7/XzVFX0tnjevvd5HxIXw1/C3ZrmdiwtVx45eErUhEo5qtFYy2ffg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=GVNmKlA2; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="GVNmKlA2"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E09051476;
	Fri,  3 Jul 2026 01:38:24 -0700 (PDT)
Received: from [10.211.55.3] (unknown [10.57.73.238])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 796F73F905;
	Fri,  3 Jul 2026 01:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783067909; bh=KcfAyjvfIggeRPUgM5kQPKdIyZKtYOy5nlDTfsdQLwM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GVNmKlA2lu3JViMT/eyKZ0Fyi70W3QFFyZVhNf0Jiw+O7ybwekm2eWKH7waeumEgv
	 WOvthIC+BYMk3E/wuZ/vqkdx+65WWp7KhMHvYo0nL652grpVgQ9lay7FkmEy3JhZbc
	 FvNwCqN4CcZ4ae2nRYYOH9w3NHp4RfF19M9jqbdw=
Message-ID: <029910c3-e90f-4a35-8b01-4d3ff548deea@arm.com>
Date: Wed, 1 Jul 2026 20:56:53 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Thunderbird Daily
Subject: Re: [PATCH v2 02/15] arm_mpam: propagate MSC read errors for wrapper
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
 <20260702162229.4008659-3-andre.przywara@arm.com>
Content-Language: en-US
From: Ben Horgan <ben.horgan@arm.com>
In-Reply-To: <20260702162229.4008659-3-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andre,

On 7/2/26 17:22, Andre Przywara wrote:
> Allow the wrapper functions for IDR and ESR accesses to return an
> error, and propagate read errors from the lower level up.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  drivers/resctrl/mpam_devices.c | 51 +++++++++++++++++++++++-----------
>  1 file changed, 35 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index df14b4513382..ce8738adb6ff 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -247,27 +247,34 @@ static bool mpam_msc_check_aidr(struct mpam_msc *msc)
>  	return true;
>  }
>  
> -static u64 mpam_msc_read_idr(struct mpam_msc *msc)
> +static int mpam_msc_read_idr(struct mpam_msc *msc, u64 *res)
>  {
>  	u32 idr_high = 0, idr_low;
> +	int ret;
>  
>  	lockdep_assert_held(&msc->part_sel_lock);
>  
> -	mpam_read_partsel_reg(msc, IDR, &idr_low);
> -	if (FIELD_GET(MPAMF_IDR_EXT, idr_low))
> -		mpam_read_partsel_reg(msc, IDR + 4, &idr_high);
> +	ret = mpam_read_partsel_reg(msc, IDR, &idr_low);
> +	if (!ret && FIELD_GET(MPAMF_IDR_EXT, idr_low))
> +		ret = mpam_read_partsel_reg(msc, IDR + 4, &idr_high);
>  
> -	return ((u64)idr_high << 32) | idr_low;
> +	if (!ret)
> +		*res = ((u64)idr_high << 32) | idr_low;
> +
> +	return ret;
>  }

Why does the pattern here, use of !ret rather than early return, differ
from the one you've used in mpam_msc_read_esr()?

Thanks,

Ben

>  
> -static void mpam_msc_clear_esr(struct mpam_msc *msc)
> +static int mpam_msc_clear_esr(struct mpam_msc *msc)
>  {
>  	u32 esr_low;
> +	int ret;
>  
> -	__mpam_read_reg(msc, MPAMF_ESR, &esr_low);
> +	ret = __mpam_read_reg(msc, MPAMF_ESR, &esr_low);
> +	if (ret)
> +		return ret;
>  
>  	if (!esr_low)
> -		return;
> +		return 0;
>  
>  	/*
>  	 * Clearing the high/low bits of MPAMF_ESR can not be atomic.
> @@ -277,18 +284,30 @@ static void mpam_msc_clear_esr(struct mpam_msc *msc)
>  	 */
>  	if (msc->has_extd_esr)
>  		__mpam_write_reg(msc, MPAMF_ESR + 4, 0);
> +
>  	__mpam_write_reg(msc, MPAMF_ESR, 0);
> +
> +	return 0;
>  }
>  
> -static u64 mpam_msc_read_esr(struct mpam_msc *msc)
> +static int mpam_msc_read_esr(struct mpam_msc *msc, u64 *res)
>  {
>  	u32 esr_high = 0, esr_low;
> +	int ret;
>  
> -	__mpam_read_reg(msc, MPAMF_ESR, &esr_low);
> -	if (msc->has_extd_esr)
> -		__mpam_read_reg(msc, MPAMF_ESR + 4, &esr_high);
> +	ret = __mpam_read_reg(msc, MPAMF_ESR, &esr_low);
> +	if (ret)
> +		return ret;
> +
> +	if (msc->has_extd_esr) {
> +		ret = __mpam_read_reg(msc, MPAMF_ESR + 4, &esr_high);
> +		if (ret)
> +			return ret;
> +	}
>  
> -	return ((u64)esr_high << 32) | esr_low;
> +	*res = ((u64)esr_high << 32) | esr_low;
> +
> +	return 0;
>  }
>  
>  static void __mpam_part_sel_raw(u32 partsel, struct mpam_msc *msc)
> @@ -993,7 +1012,7 @@ static int mpam_msc_hw_probe(struct mpam_msc *msc)
>  
>  	/* Grab an IDR value to find out how many RIS there are */
>  	mutex_lock(&msc->part_sel_lock);
> -	idr = mpam_msc_read_idr(msc);
> +	mpam_msc_read_idr(msc, &idr);
>  	mpam_read_partsel_reg(msc, IIDR, &msc->iidr);
>  
>  	mutex_unlock(&msc->part_sel_lock);
> @@ -1009,7 +1028,7 @@ static int mpam_msc_hw_probe(struct mpam_msc *msc)
>  	for (ris_idx = 0; ris_idx <= msc->ris_max; ris_idx++) {
>  		mutex_lock(&msc->part_sel_lock);
>  		__mpam_part_sel(ris_idx, 0, msc);
> -		idr = mpam_msc_read_idr(msc);
> +		mpam_msc_read_idr(msc, &idr);
>  		mutex_unlock(&msc->part_sel_lock);
>  
>  		partid_max = FIELD_GET(MPAMF_IDR_PARTID_MAX, idr);
> @@ -2492,7 +2511,7 @@ static irqreturn_t __mpam_irq_handler(int irq, struct mpam_msc *msc)
>  					   &msc->accessibility)))
>  		return IRQ_NONE;
>  
> -	reg = mpam_msc_read_esr(msc);
> +	mpam_msc_read_esr(msc, &reg);
>  
>  	errcode = FIELD_GET(MPAMF_ESR_ERRCODE, reg);
>  	if (!errcode)

