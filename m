Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142113FF8B9;
	Wed, 29 Apr 2026 14:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777472087; cv=none; b=K6eTNHNMnDodVfyOmB3BE6Og8x3X6Y9qaiAsHMmv2ouCeFhGdTvsMmdblwejJTwJRAA8xkGj3fRDSBDfyaAHWi28RC/ylCkUa6oJ6u9ErgEJa2otlMOY+ri4pVnUn3ZDRwBinGnCOdqX2ILSVz/Cx81GrZF4kv6JZY9b9+MosEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777472087; c=relaxed/simple;
	bh=i6j5/teBNx4Ww4Ye71yQcpkZOtC+dRDyvTI4P6VFbEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LgI5JTpeuR5x5IShuwu7ErbF7VLKFpL7egogfRrzzwM2orKgeJXeYdy0t3iLMsDNBOquZQupRH3we79uNo1SZfa4zVKURGZGUROIX/1d8OVsK4F5yhuAsF/yrJmZXRFDgG+v8I8ioP92aaPXo4piqq2IqriKoOcn7oGG350INBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Xmcs0CMw; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Xmcs0CMw"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 14201337B;
	Wed, 29 Apr 2026 07:14:39 -0700 (PDT)
Received: from e142021.munich.arm.com (e142021.arm.com [10.41.150.154])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2BEBE3F62B;
	Wed, 29 Apr 2026 07:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1777472084; bh=i6j5/teBNx4Ww4Ye71yQcpkZOtC+dRDyvTI4P6VFbEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xmcs0CMwiOCd7JaVaOYy8LRxlpnHXhNTaOdC+Q41Tj+iTl6dY7qQBajZLZpOM+eR7
	 ZtjzeG9ILtNEkEi8jdHH8/zyh6xQJ32K/+aaX98bxLEBmzhrbdyc+Xu24W4JrUnkX4
	 MLw3xozHy4MRe/OLtzH2ZyC4Cc04nUyTIjQlXGTM=
From: Andre Przywara <andre.przywara@arm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	James Morse <james.morse@arm.com>,
	Ben Horgan <ben.horgan@arm.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Fenghua Yu <fenghuay@nvidia.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] arm_mpam: Split the locking around the mon_sel registers
Date: Wed, 29 Apr 2026 16:13:36 +0200
Message-ID: <20260429141339.3171205-3-andre.przywara@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429141339.3171205-1-andre.przywara@arm.com>
References: <20260429141339.3171205-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: James Morse <james.morse@arm.com>

The MSC MON_SEL register needs to be accessed from hardirq for the overflow
interrupt, and when taking an IPI to access these registers on platforms
where MSC are not accesible from every CPU. This makes an irqsave
spinlock the obvious lock to protect these registers. On systems with SCMI
mailboxes it must be able to sleep, meaning a mutex must be used. The
SCMI platforms can't support an overflow interrupt.

Clearly these two can't exist for one MSC at the same time.

Split the existing helper into a raw spinlock and a mutex, named inner
and outer. The outer lock must be taken in an a pre-emptible context
befroe the inner lock can be taken. On systems with SCMI mailboxes
where the MON_SEL accesses must sleep - the inner lock will fail tobe
taken if the caller is unable to sleep.
This will allow callers to fail withuot having to explicitly check
the interface type of each MSC.

Signed-off-by: James Morse <james.morse@arm.com>
---
 drivers/resctrl/mpam_devices.c  | 56 ++++++++++++++++++++-------
 drivers/resctrl/mpam_internal.h | 67 ++++++++++++++++++++++++---------
 2 files changed, 91 insertions(+), 32 deletions(-)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index 41b14344b16f..3be09b0c46ae 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -735,7 +735,7 @@ static bool _mpam_ris_hw_probe_hw_nrdy(struct mpam_msc_ris *ris, u32 mon_reg)
 	bool can_set, can_clear;
 	struct mpam_msc *msc = ris->vmsc->msc;
 
-	if (WARN_ON_ONCE(!mpam_mon_sel_lock(msc)))
+	if (WARN_ON_ONCE(!mpam_mon_sel_inner_lock(msc)))
 		return false;
 
 	mon_sel = FIELD_PREP(MSMON_CFG_MON_SEL_MON_SEL, 0) |
@@ -749,7 +749,7 @@ static bool _mpam_ris_hw_probe_hw_nrdy(struct mpam_msc_ris *ris, u32 mon_reg)
 	_mpam_write_monsel_reg(msc, mon_reg, 0);
 	now = _mpam_read_monsel_reg(msc, mon_reg);
 	can_clear = !(now & MSMON___NRDY);
-	mpam_mon_sel_unlock(msc);
+	mpam_mon_sel_inner_unlock(msc);
 
 	return (!can_set || !can_clear);
 }
@@ -873,7 +873,9 @@ static void mpam_ris_hw_probe(struct mpam_msc_ris *ris)
 					mpam_set_feature(mpam_feat_msmon_csu_xcl, props);
 
 				/* Is NRDY hardware managed? */
+				mpam_mon_sel_outer_lock(msc);
 				hw_managed = mpam_ris_hw_probe_hw_nrdy(ris, CSU);
+				mpam_mon_sel_outer_unlock(msc);
 				if (hw_managed)
 					mpam_set_feature(mpam_feat_msmon_csu_hw_nrdy, props);
 			}
@@ -907,7 +909,9 @@ static void mpam_ris_hw_probe(struct mpam_msc_ris *ris)
 				}
 
 				/* Is NRDY hardware managed? */
+				mpam_mon_sel_outer_lock(msc);
 				hw_managed = mpam_ris_hw_probe_hw_nrdy(ris, MBWU);
+				mpam_mon_sel_outer_unlock(msc);
 				if (hw_managed)
 					mpam_set_feature(mpam_feat_msmon_mbwu_hw_nrdy, props);
 
@@ -1201,7 +1205,7 @@ static void __ris_msmon_read(void *arg)
 	struct mpam_msc *msc = m->ris->vmsc->msc;
 	u32 mon_sel, ctl_val, flt_val, cur_ctl, cur_flt;
 
-	if (!mpam_mon_sel_lock(msc)) {
+	if (!mpam_mon_sel_inner_lock(msc)) {
 		m->err = -EIO;
 		return;
 	}
@@ -1301,7 +1305,7 @@ static void __ris_msmon_read(void *arg)
 	default:
 		m->err = -EINVAL;
 	}
-	mpam_mon_sel_unlock(msc);
+	mpam_mon_sel_inner_unlock(msc);
 
 	if (nrdy)
 		m->err = -EBUSY;
@@ -1323,6 +1327,7 @@ static int _msmon_read(struct mpam_component *comp, struct mon_read *arg)
 		struct mpam_msc *msc = vmsc->msc;
 		struct mpam_msc_ris *ris;
 
+		mpam_mon_sel_outer_lock(msc);
 		list_for_each_entry_srcu(ris, &vmsc->ris, vmsc_list,
 					 srcu_read_lock_held(&mpam_srcu)) {
 			arg->ris = ris;
@@ -1341,6 +1346,7 @@ static int _msmon_read(struct mpam_component *comp, struct mon_read *arg)
 			if (err)
 				any_err = err;
 		}
+		mpam_mon_sel_outer_unlock(msc);
 	}
 
 	return any_err;
@@ -1423,18 +1429,20 @@ void mpam_msmon_reset_mbwu(struct mpam_component *comp, struct mon_cfg *ctx)
 			continue;
 
 		msc = vmsc->msc;
+		mpam_mon_sel_outer_lock(msc);
 		list_for_each_entry_srcu(ris, &vmsc->ris, vmsc_list,
 					 srcu_read_lock_held(&mpam_srcu)) {
 			if (!mpam_has_feature(mpam_feat_msmon_mbwu, &ris->props))
 				continue;
 
-			if (WARN_ON_ONCE(!mpam_mon_sel_lock(msc)))
+			if (WARN_ON_ONCE(!mpam_mon_sel_inner_lock(msc)))
 				continue;
 
 			ris->mbwu_state[ctx->mon].correction = 0;
 			ris->mbwu_state[ctx->mon].reset_on_next_read = true;
-			mpam_mon_sel_unlock(msc);
+			mpam_mon_sel_inner_unlock(msc);
 		}
+		mpam_mon_sel_outer_unlock(msc);
 	}
 }
 
@@ -1635,8 +1643,11 @@ static int mpam_restore_mbwu_state(void *_ris)
 	u64 val;
 	struct mon_read mwbu_arg;
 	struct mpam_msc_ris *ris = _ris;
+	struct mpam_msc *msc = ris->vmsc->msc;
 	struct mpam_class *class = ris->vmsc->comp->class;
 
+	mpam_mon_sel_outer_lock(msc);
+
 	for (i = 0; i < ris->props.num_mbwu_mon; i++) {
 		if (ris->mbwu_state[i].enabled) {
 			mwbu_arg.ris = ris;
@@ -1648,10 +1659,12 @@ static int mpam_restore_mbwu_state(void *_ris)
 		}
 	}
 
+	mpam_mon_sel_outer_unlock(msc);
+
 	return 0;
 }
 
-/* Call with MSC cfg_lock held */
+/* Call with MSC cfg_lock and outer mon_sel lock held */
 static int mpam_save_mbwu_state(void *arg)
 {
 	int i;
@@ -1666,7 +1679,7 @@ static int mpam_save_mbwu_state(void *arg)
 		mbwu_state = &ris->mbwu_state[i];
 		cfg = &mbwu_state->cfg;
 
-		if (WARN_ON_ONCE(!mpam_mon_sel_lock(msc)))
+		if (WARN_ON_ONCE(!mpam_mon_sel_inner_lock(msc)))
 			return -EIO;
 
 		mon_sel = FIELD_PREP(MSMON_CFG_MON_SEL_MON_SEL, i) |
@@ -1691,7 +1704,7 @@ static int mpam_save_mbwu_state(void *arg)
 		cfg->partid = FIELD_GET(MSMON_CFG_x_FLT_PARTID, cur_flt);
 		mbwu_state->correction += val;
 		mbwu_state->enabled = FIELD_GET(MSMON_CFG_x_CTL_EN, cur_ctl);
-		mpam_mon_sel_unlock(msc);
+		mpam_mon_sel_inner_unlock(msc);
 	}
 
 	return 0;
@@ -1773,6 +1786,7 @@ static void mpam_reprogram_msc(struct mpam_msc *msc)
 	mpam_assert_partid_sizes_fixed();
 
 	mutex_lock(&msc->cfg_lock);
+	mpam_mon_sel_outer_lock(msc);
 	list_for_each_entry_srcu(ris, &msc->ris, msc_list,
 				 srcu_read_lock_held(&mpam_srcu)) {
 		if (!mpam_is_enabled() && !ris->in_reset_state) {
@@ -1797,6 +1811,7 @@ static void mpam_reprogram_msc(struct mpam_msc *msc)
 		if (mpam_has_feature(mpam_feat_msmon_mbwu, &ris->props))
 			mpam_touch_msc(msc, &mpam_restore_mbwu_state, ris);
 	}
+	mpam_mon_sel_outer_unlock(msc);
 	mutex_unlock(&msc->cfg_lock);
 }
 
@@ -1886,6 +1901,7 @@ static int mpam_cpu_offline(unsigned int cpu)
 			struct mpam_msc_ris *ris;
 
 			mutex_lock(&msc->cfg_lock);
+			mpam_mon_sel_outer_lock(msc);
 			list_for_each_entry_srcu(ris, &msc->ris, msc_list,
 						 srcu_read_lock_held(&mpam_srcu)) {
 				mpam_touch_msc(msc, &mpam_reset_ris, ris);
@@ -1899,6 +1915,7 @@ static int mpam_cpu_offline(unsigned int cpu)
 				if (mpam_is_enabled())
 					mpam_touch_msc(msc, &mpam_save_mbwu_state, ris);
 			}
+			mpam_mon_sel_outer_unlock(msc);
 			mutex_unlock(&msc->cfg_lock);
 		}
 	}
@@ -2589,11 +2606,13 @@ static void __destroy_component_cfg(struct mpam_component *comp)
 	list_for_each_entry(vmsc, &comp->vmsc, comp_list) {
 		msc = vmsc->msc;
 
-		if (mpam_mon_sel_lock(msc)) {
+		mpam_mon_sel_outer_lock(msc);
+		if (mpam_mon_sel_inner_lock(msc)) {
 			list_for_each_entry(ris, &vmsc->ris, vmsc_list)
 				add_to_garbage(ris->mbwu_state);
-			mpam_mon_sel_unlock(msc);
+			mpam_mon_sel_inner_unlock(msc);
 		}
+		mpam_mon_sel_outer_unlock(msc);
 	}
 }
 
@@ -2640,6 +2659,7 @@ static int __allocate_component_cfg(struct mpam_component *comp)
 	mpam_reset_component_cfg(comp);
 
 	list_for_each_entry(vmsc, &comp->vmsc, comp_list) {
+		int err = 0;
 		struct mpam_msc *msc;
 		struct mpam_msc_ris *ris;
 		struct msmon_mbwu_state *mbwu_state;
@@ -2648,6 +2668,7 @@ static int __allocate_component_cfg(struct mpam_component *comp)
 			continue;
 
 		msc = vmsc->msc;
+		mpam_mon_sel_outer_lock(msc);
 		list_for_each_entry(ris, &vmsc->ris, vmsc_list) {
 			if (!ris->props.num_mbwu_mon)
 				continue;
@@ -2656,16 +2677,21 @@ static int __allocate_component_cfg(struct mpam_component *comp)
 						  ris->props.num_mbwu_mon);
 			if (!mbwu_state) {
 				__destroy_component_cfg(comp);
-				return -ENOMEM;
+				err = -ENOMEM;
+				break;
 			}
 
 			init_garbage(&mbwu_state[0].garbage);
 
-			if (mpam_mon_sel_lock(msc)) {
+			if (mpam_mon_sel_inner_lock(msc)) {
 				ris->mbwu_state = mbwu_state;
-				mpam_mon_sel_unlock(msc);
+				mpam_mon_sel_inner_unlock(msc);
 			}
 		}
+		mpam_mon_sel_outer_unlock(msc);
+
+		if (err)
+			return err;
 	}
 
 	return 0;
@@ -2918,12 +2944,14 @@ int mpam_apply_config(struct mpam_component *comp, u16 partid,
 		msc = vmsc->msc;
 
 		mutex_lock(&msc->cfg_lock);
+		mpam_mon_sel_outer_lock(msc);
 		list_for_each_entry_srcu(ris, &vmsc->ris, vmsc_list,
 					 srcu_read_lock_held(&mpam_srcu)) {
 			arg.ris = ris;
 			mpam_touch_msc(msc, __write_config, &arg);
 			ris->in_reset_state = false;
 		}
+		mpam_mon_sel_outer_unlock(msc);
 		mutex_unlock(&msc->cfg_lock);
 	}
 
diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
index 1914aefdcba9..80213af10a64 100644
--- a/drivers/resctrl/mpam_internal.h
+++ b/drivers/resctrl/mpam_internal.h
@@ -116,16 +116,20 @@ struct mpam_msc {
 	/*
 	 * mon_sel_lock protects access to the MSC hardware registers that are
 	 * affected by MPAMCFG_MON_SEL, and the mbwu_state.
-	 * Access to mon_sel is needed from both process and interrupt contexts,
-	 * but is complicated by firmware-backed platforms that can't make any
-	 * access unless they can sleep.
-	 * Always use the mpam_mon_sel_lock() helpers.
-	 * Accesses to mon_sel need to be able to fail if they occur in the wrong
-	 * context.
+	 * Both the 'inner' and 'outer' must be taken.
+	 * For real MMIO MSC, the outer lock is unnecessary - but keeps the
+	 * code common with:
+	 * Firmware backed MSC need to sleep when accessing the MSC, which
+	 * means some code-paths will always fail. For these MSC the outer
+	 * lock is providing the protection, and the inner lock fails to
+	 * be taken if the task is unable to sleep.
+	 *
 	 * If needed, take msc->probe_lock first.
 	 */
-	raw_spinlock_t		_mon_sel_lock;
-	unsigned long		_mon_sel_flags;
+	struct mutex		outer_mon_sel_lock;
+	bool			outer_lock_held;
+	raw_spinlock_t		inner_mon_sel_lock;
+	unsigned long		inner_mon_sel_flags;
 
 	void __iomem		*mapped_hwpage;
 	size_t			mapped_hwpage_sz;
@@ -137,29 +141,56 @@ struct mpam_msc {
 };
 
 /* Returning false here means accesses to mon_sel must fail and report an error. */
-static inline bool __must_check mpam_mon_sel_lock(struct mpam_msc *msc)
+static inline bool __must_check mpam_mon_sel_inner_lock(struct mpam_msc *msc)
 {
-	/* Locking will require updating to support a firmware backed interface */
-	if (WARN_ON_ONCE(msc->iface != MPAM_IFACE_MMIO))
-		return false;
+	/*
+	 * The outer lock may be taken by a CPU that then issues an IPI to run
+	 * a helper that takes the inner lock. lockdep can't help us here.
+	 */
+	WARN_ON_ONCE(!READ_ONCE(msc->outer_lock_held));
+
+	if (msc->iface == MPAM_IFACE_MMIO) {
+		raw_spin_lock_irqsave(&msc->inner_mon_sel_lock, msc->inner_mon_sel_flags);
+		return true;
+	}
+
+	/* Accesses must fail if we are not pre-emptible */
+	return !!preemptible();
+}
 
-	raw_spin_lock_irqsave(&msc->_mon_sel_lock, msc->_mon_sel_flags);
-	return true;
+static inline void mpam_mon_sel_inner_unlock(struct mpam_msc *msc)
+{
+	WARN_ON_ONCE(!READ_ONCE(msc->outer_lock_held));
+
+	if (msc->iface == MPAM_IFACE_MMIO)
+		raw_spin_unlock_irqrestore(&msc->inner_mon_sel_lock, msc->inner_mon_sel_flags);
+}
+
+static inline void mpam_mon_sel_outer_lock(struct mpam_msc *msc)
+{
+	mutex_lock(&msc->outer_mon_sel_lock);
+	msc->outer_lock_held = true;
 }
 
-static inline void mpam_mon_sel_unlock(struct mpam_msc *msc)
+static inline void mpam_mon_sel_outer_unlock(struct mpam_msc *msc)
 {
-	raw_spin_unlock_irqrestore(&msc->_mon_sel_lock, msc->_mon_sel_flags);
+	msc->outer_lock_held = false;
+	mutex_unlock(&msc->outer_mon_sel_lock);
 }
 
 static inline void mpam_mon_sel_lock_held(struct mpam_msc *msc)
 {
-	lockdep_assert_held_once(&msc->_mon_sel_lock);
+	WARN_ON_ONCE(!READ_ONCE(msc->outer_lock_held));
+	if (msc->iface == MPAM_IFACE_MMIO)
+		lockdep_assert_held_once(&msc->inner_mon_sel_lock);
+	else
+		lockdep_assert_preemption_enabled();
 }
 
 static inline void mpam_mon_sel_lock_init(struct mpam_msc *msc)
 {
-	raw_spin_lock_init(&msc->_mon_sel_lock);
+	raw_spin_lock_init(&msc->inner_mon_sel_lock);
+	mutex_init(&msc->outer_mon_sel_lock);
 }
 
 /* Bits for mpam features bitmaps */
-- 
2.43.0

