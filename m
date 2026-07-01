Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3597F3B0AD6;
	Fri,  3 Jul 2026 09:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783071751; cv=none; b=oUuTko1moCLqqOLrZJjhsfLFkjeoLWrfob8HBwf2gp7r+weh8NXByz4xfUeIDIjTQoh4k62mOervYBy4MvyIU7qzIUrisjykoqmTgi6bi5uSxz5FJQL+Aor4lY7OaRWzJur7YvxGvtRFHgS8TcmQpeSIRiSt5fvZF0VMTjEEAOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783071751; c=relaxed/simple;
	bh=vvatOBT7myBEG+xNvmANZcPXCJUDUvQLZg05xOdk+2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T3RivqwFSuiVxpwXqAqVvjQG3Isoe7163JgVdr7DqYIluZO9L9QnM9zTx0WTrAAp2faK8GkMALqFm0nVWcke4HXVi4pAHjcDQqRXr+PmVkOrjGILUo0amKGgOT+f+4h+8NNVD3/+18Kq4OdDmCxPco3C1aA1KiX9RgHn8A+rlQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=WIpctibS; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="WIpctibS"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2EB5C1F91;
	Fri,  3 Jul 2026 02:42:24 -0700 (PDT)
Received: from [10.211.55.3] (unknown [10.57.73.238])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 46DAB3F673;
	Fri,  3 Jul 2026 02:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783071748; bh=vvatOBT7myBEG+xNvmANZcPXCJUDUvQLZg05xOdk+2w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WIpctibSie0DN34Xc7lKXiyBeIUpbMhIqYs0jFIEoDun/d0r6fpzO9T3/jRV/4I0I
	 ADKDK1T7MbvQ6hYyYHtRk9hA5p057LEAuKbU4QknMy7F5yJeXyTL3cMPVHmRvUCmqD
	 sfHpAgwWraxDgOpVAfuYF9h0ZdRJqo1fTCNK5dh0=
Message-ID: <3bf11efe-74ca-4026-864f-12bcb4537983@arm.com>
Date: Wed, 1 Jul 2026 22:01:00 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Thunderbird Daily
Subject: Re: [PATCH v2 12/15] arm_mpam: Split the locking around the mon_sel
 registers
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
 <20260702162229.4008659-13-andre.przywara@arm.com>
Content-Language: en-US
From: Ben Horgan <ben.horgan@arm.com>
In-Reply-To: <20260702162229.4008659-13-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andre,

On 7/2/26 17:22, Andre Przywara wrote:
> From: James Morse <james.morse@arm.com>
> 
> The MSC MON_SEL register needs to be accessed from hardirq for the overflow
> interrupt, 

There is no current support for overflow interrupts.

and when taking an IPI to access these registers on platforms
> where MSC are not accesible from every CPU. 

This is the case for the registers requiring the part_sel mutex.

This makes an irqsave
> spinlock the obvious lock to protect these registers. On systems with SCMI
> mailboxes it must be able to sleep, meaning a mutex must be used.

What problems do we hit if we convert the mon_sel lock to a mutex?

Thanks,

Ben

 The
> SCMI platforms can't support an overflow interrupt.
> 
> Clearly these two can't exist for one MSC at the same time.
> 
> Split the existing helper into a raw spinlock and a mutex, named inner
> and outer. The outer lock must be taken in an a pre-emptible context
> before the inner lock can be taken. On systems with SCMI mailboxes
> where the MON_SEL accesses must sleep - the inner lock will fail to be
> taken if the caller is unable to sleep.
> This will allow callers to fail without having to explicitly check
> the interface type of each MSC.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> [Andre: remove redundant outer lock in mpam_reprogram_msc()]
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  drivers/resctrl/mpam_devices.c  | 56 +++++++++++++++++++--------
>  drivers/resctrl/mpam_internal.h | 67 ++++++++++++++++++++++++---------
>  2 files changed, 90 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index addc25e78345..824bc6c97851 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -787,7 +787,7 @@ static bool mpam_ris_hw_probe_csu_nrdy(struct mpam_msc_ris *ris)
>  	bool can_set, can_clear;
>  	struct mpam_msc *msc = ris->vmsc->msc;
>  
> -	if (WARN_ON_ONCE(!mpam_mon_sel_lock(msc)))
> +	if (WARN_ON_ONCE(!mpam_mon_sel_inner_lock(msc)))
>  		return false;
>  
>  	mon_sel = FIELD_PREP(MSMON_CFG_MON_SEL_MON_SEL, 0) |
> @@ -819,7 +819,7 @@ static bool mpam_ris_hw_probe_csu_nrdy(struct mpam_msc_ris *ris)
>  	if (_mpam_read_monsel_reg(msc, MSMON_CSU, &now))
>  		return false;
>  	can_clear = !(now & MSMON___NRDY);
> -	mpam_mon_sel_unlock(msc);
> +	mpam_mon_sel_inner_unlock(msc);
>  
>  	return (!can_set || !can_clear);
>  }
> @@ -961,7 +961,9 @@ static int mpam_ris_hw_probe(struct mpam_msc_ris *ris)
>  					mpam_set_feature(mpam_feat_msmon_csu_xcl, props);
>  
>  				/* Is NRDY hardware managed? */
> +				mpam_mon_sel_outer_lock(msc);
>  				hw_managed = mpam_ris_hw_probe_csu_nrdy(ris);
> +				mpam_mon_sel_outer_unlock(msc);
>  
>  				/*
>  				 * Accept the missing firmware property if NRDY appears
> @@ -1334,7 +1336,7 @@ static void __ris_msmon_read(void *arg)
>  	struct mpam_msc *msc = m->ris->vmsc->msc;
>  	u32 mon_sel, ctl_val, flt_val, cur_ctl, cur_flt;
>  
> -	if (!mpam_mon_sel_lock(msc)) {
> +	if (!mpam_mon_sel_inner_lock(msc)) {
>  		m->err = -EIO;
>  		return;
>  	}
> @@ -1441,7 +1443,7 @@ static void __ris_msmon_read(void *arg)
>  	default:
>  		m->err = -EINVAL;
>  	}
> -	mpam_mon_sel_unlock(msc);
> +	mpam_mon_sel_inner_unlock(msc);
>  
>  	if (nrdy)
>  		m->err = -EBUSY;
> @@ -1452,7 +1454,7 @@ static void __ris_msmon_read(void *arg)
>  	return;
>  
>  out_unlock:
> -	mpam_mon_sel_unlock(msc);
> +	mpam_mon_sel_inner_unlock(msc);
>  
>  	m->err = ret;
>  }
> @@ -1468,6 +1470,7 @@ static int _msmon_read(struct mpam_component *comp, struct mon_read *arg)
>  		struct mpam_msc *msc = vmsc->msc;
>  		struct mpam_msc_ris *ris;
>  
> +		mpam_mon_sel_outer_lock(msc);
>  		list_for_each_entry_srcu(ris, &vmsc->ris, vmsc_list,
>  					 srcu_read_lock_held(&mpam_srcu)) {
>  			arg->ris = ris;
> @@ -1486,6 +1489,7 @@ static int _msmon_read(struct mpam_component *comp, struct mon_read *arg)
>  			if (err)
>  				any_err = err;
>  		}
> +		mpam_mon_sel_outer_unlock(msc);
>  	}
>  
>  	return any_err;
> @@ -1568,18 +1572,20 @@ void mpam_msmon_reset_mbwu(struct mpam_component *comp, struct mon_cfg *ctx)
>  			continue;
>  
>  		msc = vmsc->msc;
> +		mpam_mon_sel_outer_lock(msc);
>  		list_for_each_entry_srcu(ris, &vmsc->ris, vmsc_list,
>  					 srcu_read_lock_held(&mpam_srcu)) {
>  			if (!mpam_has_feature(mpam_feat_msmon_mbwu, &ris->props))
>  				continue;
>  
> -			if (WARN_ON_ONCE(!mpam_mon_sel_lock(msc)))
> +			if (WARN_ON_ONCE(!mpam_mon_sel_inner_lock(msc)))
>  				continue;
>  
>  			ris->mbwu_state[ctx->mon].correction = 0;
>  			ris->mbwu_state[ctx->mon].reset_on_next_read = true;
> -			mpam_mon_sel_unlock(msc);
> +			mpam_mon_sel_inner_unlock(msc);
>  		}
> +		mpam_mon_sel_outer_unlock(msc);
>  	}
>  }
>  
> @@ -1781,8 +1787,11 @@ static int mpam_restore_mbwu_state(void *_ris)
>  	int ret = 0;
>  	struct mon_read mwbu_arg;
>  	struct mpam_msc_ris *ris = _ris;
> +	struct mpam_msc *msc = ris->vmsc->msc;
>  	struct mpam_class *class = ris->vmsc->comp->class;
>  
> +	mpam_mon_sel_outer_lock(msc);
> +
>  	for (i = 0; i < ris->props.num_mbwu_mon; i++) {
>  		if (ris->mbwu_state[i].enabled) {
>  			mwbu_arg.ris = ris;
> @@ -1798,10 +1807,12 @@ static int mpam_restore_mbwu_state(void *_ris)
>  		}
>  	}
>  
> +	mpam_mon_sel_outer_unlock(msc);
> +
>  	return ret;
>  }
>  
> -/* Call with MSC cfg_lock held */
> +/* Call with MSC cfg_lock and outer mon_sel lock held */
>  static int mpam_save_mbwu_state(void *arg)
>  {
>  	int i;
> @@ -1817,7 +1828,7 @@ static int mpam_save_mbwu_state(void *arg)
>  		mbwu_state = &ris->mbwu_state[i];
>  		cfg = &mbwu_state->cfg;
>  
> -		if (WARN_ON_ONCE(!mpam_mon_sel_lock(msc)))
> +		if (WARN_ON_ONCE(!mpam_mon_sel_inner_lock(msc)))
>  			return -EIO;
>  
>  		mon_sel = FIELD_PREP(MSMON_CFG_MON_SEL_MON_SEL, i) |
> @@ -1853,7 +1864,9 @@ static int mpam_save_mbwu_state(void *arg)
>  			mbwu_state->correction += val;
>  			mbwu_state->enabled = FIELD_GET(MSMON_CFG_x_CTL_EN, cur_ctl);
>  		}
> -		mpam_mon_sel_unlock(msc);
> +
> +		mpam_mon_sel_inner_unlock(msc);
> +
>  		if (ret)
>  			break;
>  	}
> @@ -2050,6 +2063,7 @@ static int mpam_cpu_offline(unsigned int cpu)
>  			struct mpam_msc_ris *ris;
>  
>  			mutex_lock(&msc->cfg_lock);
> +			mpam_mon_sel_outer_lock(msc);
>  			list_for_each_entry_srcu(ris, &msc->ris, msc_list,
>  						 srcu_read_lock_held(&mpam_srcu)) {
>  				mpam_touch_msc(msc, &mpam_reset_ris, ris);
> @@ -2063,6 +2077,7 @@ static int mpam_cpu_offline(unsigned int cpu)
>  				if (mpam_is_enabled())
>  					mpam_touch_msc(msc, &mpam_save_mbwu_state, ris);
>  			}
> +			mpam_mon_sel_outer_unlock(msc);
>  			mutex_unlock(&msc->cfg_lock);
>  		}
>  	}
> @@ -2756,11 +2771,13 @@ static void __destroy_component_cfg(struct mpam_component *comp)
>  	list_for_each_entry(vmsc, &comp->vmsc, comp_list) {
>  		msc = vmsc->msc;
>  
> -		if (mpam_mon_sel_lock(msc)) {
> +		mpam_mon_sel_outer_lock(msc);
> +		if (mpam_mon_sel_inner_lock(msc)) {
>  			list_for_each_entry(ris, &vmsc->ris, vmsc_list)
>  				add_to_garbage(ris->mbwu_state);
> -			mpam_mon_sel_unlock(msc);
> +			mpam_mon_sel_inner_unlock(msc);
>  		}
> +		mpam_mon_sel_outer_unlock(msc);
>  	}
>  }
>  
> @@ -2807,6 +2824,7 @@ static int __allocate_component_cfg(struct mpam_component *comp)
>  	mpam_reset_component_cfg(comp);
>  
>  	list_for_each_entry(vmsc, &comp->vmsc, comp_list) {
> +		int err = 0;
>  		struct mpam_msc *msc;
>  		struct mpam_msc_ris *ris;
>  		struct msmon_mbwu_state *mbwu_state;
> @@ -2815,6 +2833,7 @@ static int __allocate_component_cfg(struct mpam_component *comp)
>  			continue;
>  
>  		msc = vmsc->msc;
> +		mpam_mon_sel_outer_lock(msc);
>  		list_for_each_entry(ris, &vmsc->ris, vmsc_list) {
>  			if (!ris->props.num_mbwu_mon)
>  				continue;
> @@ -2823,16 +2842,21 @@ static int __allocate_component_cfg(struct mpam_component *comp)
>  						  ris->props.num_mbwu_mon);
>  			if (!mbwu_state) {
>  				__destroy_component_cfg(comp);
> -				return -ENOMEM;
> +				err = -ENOMEM;
> +				break;
>  			}
>  
>  			init_garbage(&mbwu_state[0].garbage);
>  
> -			if (mpam_mon_sel_lock(msc)) {
> +			if (mpam_mon_sel_inner_lock(msc)) {
>  				ris->mbwu_state = mbwu_state;
> -				mpam_mon_sel_unlock(msc);
> +				mpam_mon_sel_inner_unlock(msc);
>  			}
>  		}
> +		mpam_mon_sel_outer_unlock(msc);
> +
> +		if (err)
> +			return err;
>  	}
>  
>  	return 0;
> @@ -3085,12 +3109,14 @@ int mpam_apply_config(struct mpam_component *comp, u16 partid,
>  		msc = vmsc->msc;
>  
>  		mutex_lock(&msc->cfg_lock);
> +		mpam_mon_sel_outer_lock(msc);
>  		list_for_each_entry_srcu(ris, &vmsc->ris, vmsc_list,
>  					 srcu_read_lock_held(&mpam_srcu)) {
>  			arg.ris = ris;
>  			mpam_touch_msc(msc, __write_config, &arg);
>  			ris->in_reset_state = false;
>  		}
> +		mpam_mon_sel_outer_unlock(msc);
>  		mutex_unlock(&msc->cfg_lock);
>  	}
>  
> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
> index 04d1a59f02af..4616f1283f1a 100644
> --- a/drivers/resctrl/mpam_internal.h
> +++ b/drivers/resctrl/mpam_internal.h
> @@ -116,16 +116,20 @@ struct mpam_msc {
>  	/*
>  	 * mon_sel_lock protects access to the MSC hardware registers that are
>  	 * affected by MPAMCFG_MON_SEL, and the mbwu_state.
> -	 * Access to mon_sel is needed from both process and interrupt contexts,
> -	 * but is complicated by firmware-backed platforms that can't make any
> -	 * access unless they can sleep.
> -	 * Always use the mpam_mon_sel_lock() helpers.
> -	 * Accesses to mon_sel need to be able to fail if they occur in the wrong
> -	 * context.
> +	 * Both the 'inner' and 'outer' must be taken.
> +	 * For real MMIO MSC, the outer lock is unnecessary - but keeps the
> +	 * code common with:
> +	 * Firmware backed MSC need to sleep when accessing the MSC, which
> +	 * means some code-paths will always fail. For these MSC the outer
> +	 * lock is providing the protection, and the inner lock fails to
> +	 * be taken if the task is unable to sleep.
> +	 *
>  	 * If needed, take msc->probe_lock first.
>  	 */
> -	raw_spinlock_t		_mon_sel_lock;
> -	unsigned long		_mon_sel_flags;
> +	struct mutex		outer_mon_sel_lock;
> +	bool			outer_lock_held;
> +	raw_spinlock_t		inner_mon_sel_lock;
> +	unsigned long		inner_mon_sel_flags;
>  
>  	void __iomem		*mapped_hwpage;
>  	size_t			mapped_hwpage_sz;
> @@ -137,29 +141,56 @@ struct mpam_msc {
>  };
>  
>  /* Returning false here means accesses to mon_sel must fail and report an error. */
> -static inline bool __must_check mpam_mon_sel_lock(struct mpam_msc *msc)
> +static inline bool __must_check mpam_mon_sel_inner_lock(struct mpam_msc *msc)
>  {
> -	/* Locking will require updating to support a firmware backed interface */
> -	if (WARN_ON_ONCE(msc->iface != MPAM_IFACE_MMIO))
> -		return false;
> +	/*
> +	 * The outer lock may be taken by a CPU that then issues an IPI to run
> +	 * a helper that takes the inner lock. lockdep can't help us here.
> +	 */
> +	WARN_ON_ONCE(!READ_ONCE(msc->outer_lock_held));
> +
> +	if (msc->iface == MPAM_IFACE_MMIO) {
> +		raw_spin_lock_irqsave(&msc->inner_mon_sel_lock, msc->inner_mon_sel_flags);
> +		return true;
> +	}
> +
> +	/* Accesses must fail if we are not pre-emptible */
> +	return !!preemptible();
> +}
>  
> -	raw_spin_lock_irqsave(&msc->_mon_sel_lock, msc->_mon_sel_flags);
> -	return true;
> +static inline void mpam_mon_sel_inner_unlock(struct mpam_msc *msc)
> +{
> +	WARN_ON_ONCE(!READ_ONCE(msc->outer_lock_held));
> +
> +	if (msc->iface == MPAM_IFACE_MMIO)
> +		raw_spin_unlock_irqrestore(&msc->inner_mon_sel_lock, msc->inner_mon_sel_flags);
> +}
> +
> +static inline void mpam_mon_sel_outer_lock(struct mpam_msc *msc)
> +{
> +	mutex_lock(&msc->outer_mon_sel_lock);
> +	msc->outer_lock_held = true;
>  }
>  
> -static inline void mpam_mon_sel_unlock(struct mpam_msc *msc)
> +static inline void mpam_mon_sel_outer_unlock(struct mpam_msc *msc)
>  {
> -	raw_spin_unlock_irqrestore(&msc->_mon_sel_lock, msc->_mon_sel_flags);
> +	msc->outer_lock_held = false;
> +	mutex_unlock(&msc->outer_mon_sel_lock);
>  }
>  
>  static inline void mpam_mon_sel_lock_held(struct mpam_msc *msc)
>  {
> -	lockdep_assert_held_once(&msc->_mon_sel_lock);
> +	WARN_ON_ONCE(!READ_ONCE(msc->outer_lock_held));
> +	if (msc->iface == MPAM_IFACE_MMIO)
> +		lockdep_assert_held_once(&msc->inner_mon_sel_lock);
> +	else
> +		lockdep_assert_preemption_enabled();
>  }
>  
>  static inline void mpam_mon_sel_lock_init(struct mpam_msc *msc)
>  {
> -	raw_spin_lock_init(&msc->_mon_sel_lock);
> +	raw_spin_lock_init(&msc->inner_mon_sel_lock);
> +	mutex_init(&msc->outer_mon_sel_lock);
>  }
>  
>  /* Bits for mpam features bitmaps */

