Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC67414DDB;
	Thu,  2 Jul 2026 16:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783009411; cv=none; b=TZ8eYA868P0riUzbsf+D7SZ9DQonm919rtuMG73Fpz65Z8zL5odpPpNjAagV9xkKkcutxSHMkvsoGSWjVIlEPoRryB2zEdCRbGdquUFdQa+mLxClS1DVGYnRe42yKeJuN4dum//DgLW8Ii65MW/Rcp/qAQmh6St3eRjoa05AhPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783009411; c=relaxed/simple;
	bh=uBY3r0i1U+Smsm1FpuV7cA66Sr4eMf43tDr9fZh5SeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KA8vYtgdX5uMRP4QLCef2nrDDtkprsBs69S3DY9rMJtP0d1iDJ735V+/po7YGj7SDrxo4oon2Z85SgvZQrbakAkNB8gzM3MlIKsTowqQkObEL4Xt5qWneJsYMY9V3NXEBNZFYJbOXIItb0m9A3dbIqeltkvunQCHm5vBoel8PIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=RJWIPDVZ; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="RJWIPDVZ"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DCB0C1570;
	Thu,  2 Jul 2026 09:23:20 -0700 (PDT)
Received: from e142021.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 84B753F673;
	Thu,  2 Jul 2026 09:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783009405; bh=uBY3r0i1U+Smsm1FpuV7cA66Sr4eMf43tDr9fZh5SeU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RJWIPDVZE7SLqExZhG3+62Rxq4z0WzQnJ6K45kOTSUopZsAMf/2p5Cl5nCHDroXtg
	 u7kcNprznCipLpDMElQxh6I8+lS+ssyxw/WuDOho04m/6kpHgSFuHs8ytKYG4CeJ/H
	 1odh9Fk7EJILCAvJwixvfRmoRSXBF3DV41kn2u7Y=
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
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/15] arm_mpam: propagate MSC write errors for remaining MSC write users
Date: Thu,  2 Jul 2026 18:22:25 +0200
Message-ID: <20260702162229.4008659-12-andre.przywara@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702162229.4008659-1-andre.przywara@arm.com>
References: <20260702162229.4008659-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow the remaining MSC device functions to return an error, and
propagate write errors from the lower level up.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>

propagate write errors up for mpam_save_mbwu_state()
---
 drivers/resctrl/mpam_devices.c | 76 ++++++++++++++++++++++------------
 1 file changed, 49 insertions(+), 27 deletions(-)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index f3558d248c38..addc25e78345 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -1150,15 +1150,20 @@ static u64 mpam_msc_read_mbwu_l(struct mpam_msc *msc)
 	return MSMON___L_NRDY;
 }
 
-static void mpam_msc_zero_mbwu_l(struct mpam_msc *msc)
+static int mpam_msc_zero_mbwu_l(struct mpam_msc *msc)
 {
+	int ret;
+
 	mpam_mon_sel_lock_held(msc);
 
 	WARN_ON_ONCE((MSMON_MBWU_L + sizeof(u64)) > msc->mapped_hwpage_sz);
 	WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(), &msc->accessibility));
 
-	__mpam_write_reg(msc, MSMON_MBWU_L, 0);
-	__mpam_write_reg(msc, MSMON_MBWU_L + 4, 0);
+	ret = __mpam_write_reg(msc, MSMON_MBWU_L, 0);
+	if (!ret)
+		ret = __mpam_write_reg(msc, MSMON_MBWU_L + 4, 0);
+
+	return ret;
 }
 
 static void gen_msmon_ctl_flt_vals(struct mon_read *m, u32 *ctl_val,
@@ -1237,10 +1242,11 @@ static inline void clean_msmon_ctl_val(u32 *cur_ctl)
 		*cur_ctl &= ~MSMON_CFG_MBWU_CTL_OFLOW_STATUS_L;
 }
 
-static void write_msmon_ctl_flt_vals(struct mon_read *m, u32 ctl_val,
-				     u32 flt_val)
+static int write_msmon_ctl_flt_vals(struct mon_read *m, u32 ctl_val,
+				    u32 flt_val)
 {
 	struct mpam_msc *msc = m->ris->vmsc->msc;
+	int ret;
 
 	/*
 	 * Write the ctl_val with the enable bit cleared, reset the counter,
@@ -1248,26 +1254,37 @@ static void write_msmon_ctl_flt_vals(struct mon_read *m, u32 ctl_val,
 	 */
 	switch (m->type) {
 	case mpam_feat_msmon_csu:
-		mpam_write_monsel_reg(msc, CFG_CSU_FLT, flt_val);
-		mpam_write_monsel_reg(msc, CFG_CSU_CTL, ctl_val);
-		mpam_write_monsel_reg(msc, CSU, 0);
-		mpam_write_monsel_reg(msc, CFG_CSU_CTL, ctl_val | MSMON_CFG_x_CTL_EN);
+		ret = mpam_write_monsel_reg(msc, CFG_CSU_FLT, flt_val);
+		if (!ret)
+			ret = mpam_write_monsel_reg(msc, CFG_CSU_CTL, ctl_val);
+		if (!ret)
+			ret = mpam_write_monsel_reg(msc, CSU, 0);
+		if (!ret)
+			ret = mpam_write_monsel_reg(msc, CFG_CSU_CTL, ctl_val | MSMON_CFG_x_CTL_EN);
 		break;
 	case mpam_feat_msmon_mbwu_31counter:
 	case mpam_feat_msmon_mbwu_44counter:
 	case mpam_feat_msmon_mbwu_63counter:
-		mpam_write_monsel_reg(msc, CFG_MBWU_FLT, flt_val);
-		mpam_write_monsel_reg(msc, CFG_MBWU_CTL, ctl_val);
-		mpam_write_monsel_reg(msc, CFG_MBWU_CTL, ctl_val | MSMON_CFG_x_CTL_EN);
+		ret = mpam_write_monsel_reg(msc, CFG_MBWU_FLT, flt_val);
+		if (!ret)
+			ret = mpam_write_monsel_reg(msc, CFG_MBWU_CTL, ctl_val);
+		if (!ret)
+			ret = mpam_write_monsel_reg(msc, CFG_MBWU_CTL,
+						    ctl_val | MSMON_CFG_x_CTL_EN);
 		/* Counting monitors require NRDY to be reset by software */
-		if (m->type == mpam_feat_msmon_mbwu_31counter)
-			mpam_write_monsel_reg(msc, MBWU, 0);
-		else
-			mpam_msc_zero_mbwu_l(m->ris->vmsc->msc);
+		if (!ret) {
+			if (m->type == mpam_feat_msmon_mbwu_31counter)
+				ret = mpam_write_monsel_reg(msc, MBWU, 0);
+			else
+				ret = mpam_msc_zero_mbwu_l(m->ris->vmsc->msc);
+		}
 		break;
 	default:
 		pr_warn("Unexpected monitor type %d\n", m->type);
+		return -EINVAL;
 	}
+
+	return ret;
 }
 
 static u64 __mpam_msmon_overflow_val(enum mpam_device_features type)
@@ -1323,7 +1340,9 @@ static void __ris_msmon_read(void *arg)
 	}
 	mon_sel = FIELD_PREP(MSMON_CFG_MON_SEL_MON_SEL, ctx->mon) |
 		  FIELD_PREP(MSMON_CFG_MON_SEL_RIS, ris->ris_idx);
-	mpam_write_monsel_reg(msc, CFG_MON_SEL, mon_sel);
+	ret = mpam_write_monsel_reg(msc, CFG_MON_SEL, mon_sel);
+	if (ret)
+		goto out_unlock;
 
 	switch (m->type) {
 	case mpam_feat_msmon_mbwu_31counter:
@@ -1359,14 +1378,16 @@ static void __ris_msmon_read(void *arg)
 			  cur_ctl != (ctl_val | MSMON_CFG_x_CTL_EN);
 
 	if (config_mismatch || reset_on_next_read) {
-		write_msmon_ctl_flt_vals(m, ctl_val, flt_val);
+		ret = write_msmon_ctl_flt_vals(m, ctl_val, flt_val);
 		overflow = false;
 	} else if (overflow) {
-		mpam_write_monsel_reg(msc, CFG_MBWU_CTL,
-				      cur_ctl &
-				      ~(MSMON_CFG_x_CTL_OFLOW_STATUS |
-					MSMON_CFG_MBWU_CTL_OFLOW_STATUS_L));
+		ret = mpam_write_monsel_reg(msc, CFG_MBWU_CTL,
+					    cur_ctl &
+					    ~(MSMON_CFG_x_CTL_OFLOW_STATUS |
+					    MSMON_CFG_MBWU_CTL_OFLOW_STATUS_L));
 	}
+	if (ret)
+		goto out_unlock;
 
 	switch (m->type) {
 	case mpam_feat_msmon_csu:
@@ -1801,24 +1822,25 @@ static int mpam_save_mbwu_state(void *arg)
 
 		mon_sel = FIELD_PREP(MSMON_CFG_MON_SEL_MON_SEL, i) |
 			  FIELD_PREP(MSMON_CFG_MON_SEL_RIS, ris->ris_idx);
-		mpam_write_monsel_reg(msc, CFG_MON_SEL, mon_sel);
-		ret = mpam_read_monsel_reg(msc, CFG_MBWU_FLT, &cur_flt);
+		ret = mpam_write_monsel_reg(msc, CFG_MON_SEL, mon_sel);
+		if (!ret)
+			ret = mpam_read_monsel_reg(msc, CFG_MBWU_FLT, &cur_flt);
 		if (!ret)
 			ret = mpam_read_monsel_reg(msc, CFG_MBWU_CTL, &cur_ctl);
 		if (!ret)
-			mpam_write_monsel_reg(msc, CFG_MBWU_CTL, 0);
+			ret = mpam_write_monsel_reg(msc, CFG_MBWU_CTL, 0);
 
 		if (!ret) {
 			if (mpam_ris_has_mbwu_long_counter(ris)) {
 				val = mpam_msc_read_mbwu_l(msc);
-				mpam_msc_zero_mbwu_l(msc);
+				ret = mpam_msc_zero_mbwu_l(msc);
 			} else {
 				u32 val32;
 
 				ret = mpam_read_monsel_reg(msc, MBWU, &val32);
 				if (!ret) {
 					val = val32;
-					mpam_write_monsel_reg(msc, MBWU, 0);
+					ret = mpam_write_monsel_reg(msc, MBWU, 0);
 				}
 			}
 		}
-- 
2.43.0

