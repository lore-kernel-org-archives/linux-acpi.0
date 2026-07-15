Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D12A47F2F2;
	Wed, 15 Jul 2026 15:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784128618; cv=none; b=SUjuUpf894IbNdydg0kFtApOxYwNRm/X5onDI9Q5xRsmCYU+mOtCDCU27HPcFa+9pLqe4Mui4HKKp68MrH3eTcrb2jMmff5w+R2ggdG872OY7++YRS+q2bkJQTZGWsi3n3v4C85PRzJbETBkyiu3u9chcq3uX5fDmU8gd/j5L5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784128618; c=relaxed/simple;
	bh=Elyu2hBbLCzVOZv+VKUbmy1slaLvbqNRvF6FD7GR/d8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dSy40BAbUO3U4t8MKhvXqV+qgpSwKaSNOzNlcplAbbgoTpONtQ4nZZL1Xwv1qNmaFwdwnN1EoRMe4wVpsdRhiQq0RrBpEVqnbbjskg2546YVwD66CpTKbvkKX26X1PNOrNYTwX6teQFnpJVAqyM0/6SmNuNY5KYrYP6dpXr0yAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=VU2ekDC/; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="VU2ekDC/"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53C141477;
	Wed, 15 Jul 2026 08:16:52 -0700 (PDT)
Received: from [10.2.212.8] (e134344.arm.com [10.2.212.8])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E28683F905;
	Wed, 15 Jul 2026 08:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784128616; bh=Elyu2hBbLCzVOZv+VKUbmy1slaLvbqNRvF6FD7GR/d8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VU2ekDC/Y1ZZJYP6uA7vaTByi5nq5SBTz7aEz0edcZG04Pj6nSi/pa52RUTM4FHZy
	 4aUseb9LXATvNNOm0yFrXdUOSxsMmbaC0HMjkElsGB9jd6H3Pk+0lS0RUL6lAJ90Eb
	 NeTyNiUv4dyw614l8r+3X19xrAMkFsS+1j4b/zyk=
Message-ID: <42eff7e7-695c-4e2a-aae2-8abd1b92f615@arm.com>
Date: Wed, 15 Jul 2026 16:16:52 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Thunderbird Daily
Subject: Re: [PATCH v3 13/16] arm_mpam: prepare mon_sel locking for MPAM-Fb
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
 <20260710144520.917375-14-andre.przywara@arm.com>
Content-Language: en-US
From: Ben Horgan <ben.horgan@arm.com>
In-Reply-To: <20260710144520.917375-14-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andre,

On 7/10/26 15:45, Andre Przywara wrote:
> The MSC MON_SEL register needs to be accessed from hardirq for the overflow
> interrupt, and when taking an IPI to access these registers on platforms
> where MSC are not accesible from every CPU. This makes an irqsave
> spinlock the obvious lock to protect these registers. On systems with SCMI
> mailboxes it must be able to sleep, meaning a mutex must be used. The
> SCMI platforms can't support an overflow interrupt.
> Clearly these two can't exist for one MSC at the same time.

Is an MPAM-Fb platform using overflow interrupts definitely not possible? I would have thought that
as long as things were fast enough that threaded interrupts could be used. I do agree that it would
make things harder and the increased latency may make it unworkable.
> 
> Change the mon_sel locking wrapper function to only use a spinlock when
> the MSC is accessed directly via MMIO. In case of MPAM-Fb, we use a
> mutex, but only if we are in a sleepable context. If that's not the
> case, we return an error. This should not happen, as MPAM-Fb by design
> does not require an MSC access to happen from a specific CPU, so there
> is no need for any IPIs or preemption disabling to satisfy CPU
> constraints. 

It'd be good to mention that on the rare occasion that all cpus are no_hz_full and resctrl does the
monitor read via IPI that we already bail out early.

Thanks,

Ben

And since overflow interrupts are not supported at the moment
> anyway, we also wouldn't meet the other case.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  drivers/resctrl/mpam_internal.h | 28 +++++++++++++++++++++++-----
>  1 file changed, 23 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
> index 04d1a59f02af..7b6e0df904f8 100644
> --- a/drivers/resctrl/mpam_internal.h
> +++ b/drivers/resctrl/mpam_internal.h
> @@ -126,6 +126,7 @@ struct mpam_msc {
>  	 */
>  	raw_spinlock_t		_mon_sel_lock;
>  	unsigned long		_mon_sel_flags;
> +	struct mutex		mon_sel_mutex;
>  
>  	void __iomem		*mapped_hwpage;
>  	size_t			mapped_hwpage_sz;
> @@ -139,27 +140,44 @@ struct mpam_msc {
>  /* Returning false here means accesses to mon_sel must fail and report an error. */
>  static inline bool __must_check mpam_mon_sel_lock(struct mpam_msc *msc)
>  {
> -	/* Locking will require updating to support a firmware backed interface */
> -	if (WARN_ON_ONCE(msc->iface != MPAM_IFACE_MMIO))
> +	if (msc->iface == MPAM_IFACE_MMIO) {
> +		raw_spin_lock_irqsave(&msc->_mon_sel_lock, msc->_mon_sel_flags);
> +
> +		return true;
> +	}
> +
> +	if (!preemptible())
>  		return false;
>  
> -	raw_spin_lock_irqsave(&msc->_mon_sel_lock, msc->_mon_sel_flags);
> +	mutex_lock(&msc->mon_sel_mutex);
> +
>  	return true;
>  }
>  
>  static inline void mpam_mon_sel_unlock(struct mpam_msc *msc)
>  {
> -	raw_spin_unlock_irqrestore(&msc->_mon_sel_lock, msc->_mon_sel_flags);
> +	if (msc->iface == MPAM_IFACE_MMIO) {
> +		raw_spin_unlock_irqrestore(&msc->_mon_sel_lock,
> +					   msc->_mon_sel_flags);
> +
> +		return;
> +	}
> +
> +	mutex_unlock(&msc->mon_sel_mutex);
>  }
>  
>  static inline void mpam_mon_sel_lock_held(struct mpam_msc *msc)
>  {
> -	lockdep_assert_held_once(&msc->_mon_sel_lock);
> +	if (msc->iface == MPAM_IFACE_MMIO)
> +		lockdep_assert_held_once(&msc->_mon_sel_lock);
> +	else
> +		lockdep_assert_held_once(&msc->mon_sel_mutex);
>  }
>  
>  static inline void mpam_mon_sel_lock_init(struct mpam_msc *msc)
>  {
>  	raw_spin_lock_init(&msc->_mon_sel_lock);
> +	mutex_init(&msc->mon_sel_mutex);
>  }
>  
>  /* Bits for mpam features bitmaps */

