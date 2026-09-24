Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167A84A263D;
	Thu, 24 Sep 2026 15:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790263728; cv=none; b=k3FnPsVjWGgFwaVWKEDMcS76e2MYpagbhLjk1WqXqnltwfORcyLm2zQ+KhWpIt8dVFoev9lbs5eX7eF00C7FL4ykuXNYhVkOVy0qs/Y1sDxD9OfOPr+S5WmnV1ZNVO63OE6LmD0IcwvO3Lw0qSKEiI03opmNjpZ1hPMMPugg4hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790263728; c=relaxed/simple;
	bh=SNngnAs6y+FNlv7mQoigcO7WVhTh+FzOVYZkavw0miQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WZIdPO5+EcVgwHVrkhKPmKOXDvnf35kawSnCSVh71aE3Ei72QCXOztrZnUOgDkoJov6PA1ndH27TK2hJFhDhqEmPPop0jKr32yJcC8hW0PiPDWm4qp50dGpTyyZjwy+CgeQFtjqVzs3/XUPwc7//e7Xpzg8stcQGB9DnY9PjjwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=JR71d9+4; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="JR71d9+4"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7F691CE2;
	Thu, 24 Sep 2026 08:28:42 -0700 (PDT)
Received: from e142021.arm.com (unknown [10.57.8.50])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C36583F86F;
	Thu, 24 Sep 2026 08:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790263726; bh=SNngnAs6y+FNlv7mQoigcO7WVhTh+FzOVYZkavw0miQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JR71d9+4/sWEf32WC1n3lalKXwLGRDLYZnVavwXgECW2DSe4TuZFCiWtEdBoQ3QWI
	 8qqIfuXX7lDt2GgG9MyzaYMMyJzRoDtz5syy0dCwNLAwBJONrvH5R5lWitabeW9J8u
	 jwM3Sq700Q054k3N9oTCir2i5v5R1nvcgR80A7aI=
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
Subject: [PATCH v11 07/13] arm_mpam: propagate MSC access errors for mpam_reprogram_ris_partid()
Date: Thu, 24 Sep 2026 17:27:33 +0200
Message-ID: <20260924152739.2865510-8-andre.przywara@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260924152739.2865510-1-andre.przywara@arm.com>
References: <20260924152739.2865510-1-andre.przywara@arm.com>
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
Reviewed-by: Ben Horgan <ben.horgan@arm.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Tested-by: Gavin Shan <gshan@redhat.com> # on NVIDIA Grace Hopper
Reviewed-by: Srivathsa L Rao <srivathsa.rao@oss.qualcomm.com>
---
 drivers/resctrl/mpam_devices.c | 137 ++++++++++++++++++++++-----------
 1 file changed, 94 insertions(+), 43 deletions(-)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index f1af249744d2e..558efab75f911 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -1599,7 +1599,7 @@ void mpam_msmon_reset_mbwu(struct mpam_component *comp, struct mon_cfg *ctx)
 	}
 }
 
-static void mpam_reset_msc_bitmap(struct mpam_msc *msc, u16 reg, u16 wd)
+static int mpam_reset_msc_bitmap(struct mpam_msc *msc, u16 reg, u16 wd)
 {
 	u32 num_words, msb;
 	u32 bm = ~0;
@@ -1608,15 +1608,20 @@ static void mpam_reset_msc_bitmap(struct mpam_msc *msc, u16 reg, u16 wd)
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
@@ -1624,7 +1629,7 @@ static void mpam_reset_msc_bitmap(struct mpam_msc *msc, u16 reg, u16 wd)
 	 */
 	msb = (wd - 1) % 32;
 	bm = GENMASK(msb, 0);
-	__mpam_write_reg(msc, reg, bm);
+	return __mpam_write_reg(msc, reg, bm);
 }
 
 static void mpam_apply_t241_erratum(struct mpam_msc_ris *ris, u16 partid)
@@ -1697,40 +1702,59 @@ static u16 mpam_wa_t241_calc_min_from_max(struct mpam_props *props,
 }
 
 /* Called via IPI. Call while holding an SRCU reference */
-static void mpam_reprogram_ris_partid(struct mpam_msc_ris *ris, u16 partid,
-				      struct mpam_config *cfg)
+static int mpam_reprogram_ris_partid(struct mpam_msc_ris *ris, u16 partid,
+				     struct mpam_config *cfg)
 {
 	u16 cmax = MPAMCFG_CMAX_CMAX;
 	struct mpam_msc *msc = ris->vmsc->msc;
 	struct mpam_props *rprops = &ris->props;
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
-			mpam_write_partsel_reg(msc, MBW_PBM, cfg->mbw_pbm);
-		else
-			mpam_reset_msc_bitmap(msc, MPAMCFG_MBW_PBM, rprops->mbw_pbm_bits);
+		if (mpam_has_feature(mpam_feat_mbw_part, cfg)) {
+			ret = mpam_write_partsel_reg(msc, MBW_PBM, cfg->mbw_pbm);
+			if (ret)
+				return ret;
+		} else {
+			ret = mpam_reset_msc_bitmap(msc, MPAMCFG_MBW_PBM,
+						    rprops->mbw_pbm_bits);
+			if (ret)
+				return ret;
+		}
 	}
 
 	if (mpam_has_feature(mpam_feat_mbw_min, rprops)) {
@@ -1743,27 +1767,47 @@ static void mpam_reprogram_ris_partid(struct mpam_msc_ris *ris, u16 partid,
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
@@ -1787,12 +1831,14 @@ static void mpam_reprogram_ris_partid(struct mpam_msc_ris *ris, u16 partid,
 			pri_val |= FIELD_PREP(MPAMCFG_PRI_DSPRI, dspri);
 		}
 
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
@@ -1895,6 +1941,7 @@ static int mpam_reset_ris(void *arg)
 	u16 partid, partid_max;
 	struct mpam_config reset_cfg = {};
 	struct mpam_msc_ris *ris = arg;
+	int ret;
 
 	if (ris->in_reset_state)
 		return 0;
@@ -1902,8 +1949,11 @@ static int mpam_reset_ris(void *arg)
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
@@ -1942,9 +1992,8 @@ static int __write_config(void *arg)
 {
 	struct mpam_write_config_arg *c = arg;
 
-	mpam_reprogram_ris_partid(c->ris, c->partid, &c->comp->cfg[c->partid]);
-
-	return 0;
+	return mpam_reprogram_ris_partid(c->ris, c->partid,
+					 &c->comp->cfg[c->partid]);
 }
 
 static void mpam_reprogram_msc(struct mpam_msc *msc)
@@ -3098,6 +3147,7 @@ int mpam_apply_config(struct mpam_component *comp, u16 partid,
 	struct mpam_msc_ris *ris;
 	struct mpam_vmsc *vmsc;
 	struct mpam_msc *msc;
+	int ret;
 
 	lockdep_assert_cpus_held();
 
@@ -3115,14 +3165,15 @@ int mpam_apply_config(struct mpam_component *comp, u16 partid,
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

