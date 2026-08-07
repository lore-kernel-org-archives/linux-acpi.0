Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08D042F71F;
	Fri,  7 Aug 2026 10:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786100136; cv=none; b=GBoiET1qpQWFtX7HY0eca0zWWlMuhYFIrOnvL5PMd2ohfMFRadCqFX5U3w00NefcEiVnaJ9DUhdsOsIlK49C/7iz22VGCBMkrLek9xAnu9yC0HE0u7ct+ZHFdo4hRvK6waVbco9xIzKBWMGorwMycSnAiCyZ6Js4zVkqCRTuinI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786100136; c=relaxed/simple;
	bh=a4kvPYu6NfhPZCK4KczaHgSPDUdc2yO4eL+9oqjQzbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TxFfYoQ64eqd5WXA66TOTQKK9yrbpD0iEWbO0H7GbTe1WpnuiXf8bvZeaTnl7zpqmY6hlHY88Q33RGF9UB2jojM6VvsNpeRA7woRHAdK5Y9XgXt3KuZjATjHmAjBoLrfEz6cUD+Q5YeGC7kFdxLPr/LKFcNIUF6mVP+JsdWLb9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=bKxxTjfg; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="bKxxTjfg"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 606091516;
	Fri,  7 Aug 2026 03:55:29 -0700 (PDT)
Received: from e142021.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B35FE3F9A2;
	Fri,  7 Aug 2026 03:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786100133; bh=a4kvPYu6NfhPZCK4KczaHgSPDUdc2yO4eL+9oqjQzbg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bKxxTjfg70qyrqabZusZwEjehcf3CDiS0X9NVkZUzdK3GFIKtoivl6H+fHlFakA/o
	 7w2SCcD5EMWRBJYL2zuEj4BEffv3fy54zpSQ8BmfL4JcC7XZLXQqF/p81JUPdDELpX
	 fQMr6tmQmQ2v7WxuOI7QyM9mR3XLzB8cZX7evI0E=
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
	Srivathsa L Rao <srivathsa.rao@oss.qualcomm.com>,
	Ganapatrao Kulkarni <ganapatrao.kulkarni@oss.qualcomm.com>,
	Trilok Soni <tsoni@quicinc.com>,
	Srinivas Ramana <sramana@qti.qualcomm.com>,
	Niyas Sait <niyas.sait@arm.com>,
	Lee Trager <lee@trager.us>,
	Ritwick Sharma <ritwick.sharma@arm.com>,
	Gavin Shan <gshan@redhat.com>,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v9 07/12] arm_mpam: propagate MSC access errors for mpam_reprogram_ris_partid()
Date: Fri,  7 Aug 2026 12:54:46 +0200
Message-ID: <20260807105451.3728284-8-andre.przywara@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260807105451.3728284-1-andre.przywara@arm.com>
References: <20260807105451.3728284-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow the mpam_reprogram_ris_partid() function to check for and return
errors, and propagate MSC read and write errors from the lower level up.
This also covers the callers of this function: mpam_reset_ris() and
apply_config().

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Review-by: Ben Horgan <ben.horgan@arm.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Tested-by: Gavin Shan <gshan@redhat.com> # on NVIDIA Grace Hopper
---
 drivers/resctrl/mpam_devices.c | 137 ++++++++++++++++++++++-----------
 1 file changed, 94 insertions(+), 43 deletions(-)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index 96579178f0c3..49239b15a27f 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -1601,7 +1601,7 @@ void mpam_msmon_reset_mbwu(struct mpam_component *comp, struct mon_cfg *ctx)
 	}
 }
 
-static void mpam_reset_msc_bitmap(struct mpam_msc *msc, u16 reg, u16 wd)
+static int mpam_reset_msc_bitmap(struct mpam_msc *msc, u16 reg, u16 wd)
 {
 	u32 num_words, msb;
 	u32 bm = ~0;
@@ -1610,15 +1610,20 @@ static void mpam_reset_msc_bitmap(struct mpam_msc *msc, u16 reg, u16 wd)
 	lockdep_assert_held(&msc->part_sel_lock);
 
 	if (wd == 0)
-		return;
+		return 0;
 
 	/*
 	 * Write all ~0 to all but the last 32bit-word, which may
 	 * have fewer bits...
 	 */
 	num_words = DIV_ROUND_UP(wd, 32);
-	for (i = 0; i < num_words - 1; i++, reg += sizeof(bm))
-		__mpam_write_reg(msc, reg, bm);
+	for (i = 0; i < num_words - 1; i++, reg += sizeof(bm)) {
+		int ret;
+
+		ret = __mpam_write_reg(msc, reg, bm);
+		if (ret)
+			return ret;
+	}
 
 	/*
 	 * ....and then the last (maybe) partial 32bit word. When wd is a
@@ -1626,7 +1631,7 @@ static void mpam_reset_msc_bitmap(struct mpam_msc *msc, u16 reg, u16 wd)
 	 */
 	msb = (wd - 1) % 32;
 	bm = GENMASK(msb, 0);
-	__mpam_write_reg(msc, reg, bm);
+	return __mpam_write_reg(msc, reg, bm);
 }
 
 static void mpam_apply_t241_erratum(struct mpam_msc_ris *ris, u16 partid)
@@ -1699,8 +1704,8 @@ static u16 mpam_wa_t241_calc_min_from_max(struct mpam_props *props,
 }
 
 /* Called via IPI. Call while holding an SRCU reference */
-static void mpam_reprogram_ris_partid(struct mpam_msc_ris *ris, u16 partid,
-				      struct mpam_config *cfg)
+static int mpam_reprogram_ris_partid(struct mpam_msc_ris *ris, u16 partid,
+				     struct mpam_config *cfg)
 {
 	u32 pri_val = 0;
 	u16 cmax = MPAMCFG_CMAX_CMAX;
@@ -1708,34 +1713,53 @@ static void mpam_reprogram_ris_partid(struct mpam_msc_ris *ris, u16 partid,
 	struct mpam_props *rprops = &ris->props;
 	u16 dspri = GENMASK(rprops->dspri_wd, 0);
 	u16 intpri = GENMASK(rprops->intpri_wd, 0);
+	int ret;
 
-	mutex_lock(&msc->part_sel_lock);
-	__mpam_part_sel(ris->ris_idx, partid, msc);
+	guard(mutex)(&msc->part_sel_lock);
+	ret = __mpam_part_sel(ris->ris_idx, partid, msc);
+	if (ret)
+		return ret;
 
 	if (mpam_has_feature(mpam_feat_partid_nrw, rprops)) {
 		/* Update the intpartid mapping */
-		mpam_write_partsel_reg(msc, INTPARTID,
-				       MPAMCFG_INTPARTID_INTERNAL | partid);
+		ret = mpam_write_partsel_reg(msc, INTPARTID,
+					     MPAMCFG_INTPARTID_INTERNAL | partid);
+		if (ret)
+			return ret;
 
 		/*
 		 * Then switch to the 'internal' partid to update the
 		 * configuration.
 		 */
-		__mpam_intpart_sel(ris->ris_idx, partid, msc);
+		ret = __mpam_intpart_sel(ris->ris_idx, partid, msc);
+		if (ret)
+			return ret;
 	}
 
 	if (mpam_has_feature(mpam_feat_cpor_part, rprops)) {
-		if (mpam_has_feature(mpam_feat_cpor_part, cfg))
-			mpam_write_partsel_reg(msc, CPBM, cfg->cpbm);
-		else
-			mpam_reset_msc_bitmap(msc, MPAMCFG_CPBM, rprops->cpbm_wd);
+		if (mpam_has_feature(mpam_feat_cpor_part, cfg)) {
+			ret = mpam_write_partsel_reg(msc, CPBM, cfg->cpbm);
+			if (ret)
+				return ret;
+		} else {
+			ret = mpam_reset_msc_bitmap(msc, MPAMCFG_CPBM,
+						    rprops->cpbm_wd);
+			if (ret)
+				return ret;
+		}
 	}
 
 	if (mpam_has_feature(mpam_feat_mbw_part, rprops)) {
-		if (mpam_has_feature(mpam_feat_mbw_part, cfg))
-			mpam_reset_msc_bitmap(msc, MPAMCFG_MBW_PBM, rprops->mbw_pbm_bits);
-		else
-			mpam_write_partsel_reg(msc, MBW_PBM, cfg->mbw_pbm);
+		if (mpam_has_feature(mpam_feat_mbw_part, cfg)) {
+			ret = mpam_reset_msc_bitmap(msc, MPAMCFG_MBW_PBM,
+						    rprops->mbw_pbm_bits);
+			if (ret)
+				return ret;
+		} else {
+			ret = mpam_write_partsel_reg(msc, MBW_PBM, cfg->mbw_pbm);
+			if (ret)
+				return ret;
+		}
 	}
 
 	if (mpam_has_feature(mpam_feat_mbw_min, rprops)) {
@@ -1748,27 +1772,47 @@ static void mpam_reprogram_ris_partid(struct mpam_msc_ris *ris, u16 partid,
 			val = max(val, min);
 		}
 
-		mpam_write_partsel_reg(msc, MBW_MIN, val);
+		ret = mpam_write_partsel_reg(msc, MBW_MIN, val);
+		if (ret)
+			return ret;
 	}
 
 	if (mpam_has_feature(mpam_feat_mbw_max, rprops)) {
-		if (mpam_has_feature(mpam_feat_mbw_max, cfg))
-			mpam_write_partsel_reg(msc, MBW_MAX, cfg->mbw_max);
-		else
-			mpam_write_partsel_reg(msc, MBW_MAX, MPAMCFG_MBW_MAX_MAX);
+		if (mpam_has_feature(mpam_feat_mbw_max, cfg)) {
+			ret = mpam_write_partsel_reg(msc, MBW_MAX, cfg->mbw_max);
+			if (ret)
+				return ret;
+		} else {
+			ret = mpam_write_partsel_reg(msc, MBW_MAX,
+						     MPAMCFG_MBW_MAX_MAX);
+			if (ret)
+				return ret;
+		}
 	}
 
-	if (mpam_has_feature(mpam_feat_mbw_prop, rprops))
-		mpam_write_partsel_reg(msc, MBW_PROP, 0);
+	if (mpam_has_feature(mpam_feat_mbw_prop, rprops)) {
+		ret = mpam_write_partsel_reg(msc, MBW_PROP, 0);
+		if (ret)
+			return ret;
+	}
 
-	if (mpam_has_feature(mpam_feat_cmax_cmax, rprops))
-		mpam_write_partsel_reg(msc, CMAX, cmax);
+	if (mpam_has_feature(mpam_feat_cmax_cmax, rprops)) {
+		ret = mpam_write_partsel_reg(msc, CMAX, cmax);
+		if (ret)
+			return ret;
+	}
 
-	if (mpam_has_feature(mpam_feat_cmax_cmin, rprops))
-		mpam_write_partsel_reg(msc, CMIN, 0);
+	if (mpam_has_feature(mpam_feat_cmax_cmin, rprops)) {
+		ret = mpam_write_partsel_reg(msc, CMIN, 0);
+		if (ret)
+			return ret;
+	}
 
-	if (mpam_has_feature(mpam_feat_cmax_cassoc, rprops))
-		mpam_write_partsel_reg(msc, CASSOC, MPAMCFG_CASSOC_CASSOC);
+	if (mpam_has_feature(mpam_feat_cmax_cassoc, rprops)) {
+		ret = mpam_write_partsel_reg(msc, CASSOC, MPAMCFG_CASSOC_CASSOC);
+		if (ret)
+			return ret;
+	}
 
 	if (mpam_has_feature(mpam_feat_intpri_part, rprops) ||
 	    mpam_has_feature(mpam_feat_dspri_part, rprops)) {
@@ -1783,12 +1827,14 @@ static void mpam_reprogram_ris_partid(struct mpam_msc_ris *ris, u16 partid,
 		if (mpam_has_feature(mpam_feat_dspri_part, rprops))
 			pri_val |= FIELD_PREP(MPAMCFG_PRI_DSPRI, dspri);
 
-		mpam_write_partsel_reg(msc, PRI, pri_val);
+		ret = mpam_write_partsel_reg(msc, PRI, pri_val);
+		if (ret)
+			return ret;
 	}
 
 	mpam_quirk_post_config_change(ris, partid, cfg);
 
-	mutex_unlock(&msc->part_sel_lock);
+	return 0;
 }
 
 /* Call with msc cfg_lock held */
@@ -1891,6 +1937,7 @@ static int mpam_reset_ris(void *arg)
 	u16 partid, partid_max;
 	struct mpam_config reset_cfg = {};
 	struct mpam_msc_ris *ris = arg;
+	int ret;
 
 	if (ris->in_reset_state)
 		return 0;
@@ -1898,8 +1945,11 @@ static int mpam_reset_ris(void *arg)
 	spin_lock(&partid_max_lock);
 	partid_max = mpam_partid_max;
 	spin_unlock(&partid_max_lock);
-	for (partid = 0; partid <= partid_max; partid++)
-		mpam_reprogram_ris_partid(ris, partid, &reset_cfg);
+	for (partid = 0; partid <= partid_max; partid++) {
+		ret = mpam_reprogram_ris_partid(ris, partid, &reset_cfg);
+		if (ret)
+			return ret;
+	}
 
 	return 0;
 }
@@ -1938,9 +1988,8 @@ static int __write_config(void *arg)
 {
 	struct mpam_write_config_arg *c = arg;
 
-	mpam_reprogram_ris_partid(c->ris, c->partid, &c->comp->cfg[c->partid]);
-
-	return 0;
+	return mpam_reprogram_ris_partid(c->ris, c->partid,
+					 &c->comp->cfg[c->partid]);
 }
 
 static void mpam_reprogram_msc(struct mpam_msc *msc)
@@ -3088,6 +3137,7 @@ int mpam_apply_config(struct mpam_component *comp, u16 partid,
 	struct mpam_msc_ris *ris;
 	struct mpam_vmsc *vmsc;
 	struct mpam_msc *msc;
+	int ret;
 
 	lockdep_assert_cpus_held();
 
@@ -3105,14 +3155,15 @@ int mpam_apply_config(struct mpam_component *comp, u16 partid,
 				 srcu_read_lock_held(&mpam_srcu)) {
 		msc = vmsc->msc;
 
-		mutex_lock(&msc->cfg_lock);
+		guard(mutex)(&msc->cfg_lock);
 		list_for_each_entry_srcu(ris, &vmsc->ris, vmsc_list,
 					 srcu_read_lock_held(&mpam_srcu)) {
 			arg.ris = ris;
-			mpam_touch_msc(msc, __write_config, &arg);
+			ret = mpam_touch_msc(msc, __write_config, &arg);
+			if (ret)
+				return ret;
 			ris->in_reset_state = false;
 		}
-		mutex_unlock(&msc->cfg_lock);
 	}
 
 	return 0;
-- 
2.43.0

