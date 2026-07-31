Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339B04503E9;
	Fri, 31 Jul 2026 17:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785517435; cv=none; b=F9vcXn1udUb0i3KaWTfya7GximI+O9mSSR5wjyavXt1DsxWYXTv+V8eL9m7JN9ZjndZIOTp9PF42IcIyTyCUcTEjm9M5y3pUH8InGz8niZOYgMv9+t0PF6aSKxcXjwPA9mOL4xM9ESUa3rQf3cODHF2Oobw4uTKF26h5p2PkVn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785517435; c=relaxed/simple;
	bh=4Gx3eVU4XVRGZ7DxM8D41E91DRn/u6Ujmi3+ShC04T4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FIhaBsZd+41Q7GsasXdXMTSNsONSQ3UKrdH/fLQV5QtjiZCBCd5N2BvkM9rq6aWzoXnQQSrzHTHvZD/fN9gWqeBQK13m69A89nZvmYvogdxD7GGZf3SZU5NEyJUBIeSRhSFOSK0ka8ifAeKdU53jgTo3IJiL7AxQ46DnQag0XbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=fRqCoaio; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="fRqCoaio"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 95B5E20E3;
	Fri, 31 Jul 2026 10:03:48 -0700 (PDT)
Received: from e142021.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2354B3F66F;
	Fri, 31 Jul 2026 10:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785517432; bh=4Gx3eVU4XVRGZ7DxM8D41E91DRn/u6Ujmi3+ShC04T4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fRqCoaioFZKjMt8jfN18GFEiqV4dnfD8gF+c5vxG/IemaVjrxPnXpXdNgGd6yHe3s
	 ozrs507D5i7zLs96Q0mQC/0u3gaiyZgwB1ING16KTRNbIFkLTR4Fvw96ONRRlZT6w/
	 r/7dVZVGgfwFZjLeuKznAZess3Qk6Frp0gtqicrA=
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
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 04/11] arm_mpam: propagate MSC access errors for msmon helpers
Date: Fri, 31 Jul 2026 19:03:17 +0200
Message-ID: <20260731170324.2927758-5-andre.przywara@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731170324.2927758-1-andre.przywara@arm.com>
References: <20260731170324.2927758-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow the helper functions for msmon accesses to return an error, and
propagate read and write errors from the lower level up.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Reviewed-by: Ben Horgan <ben.horgan@arm.com>
---
 drivers/resctrl/mpam_devices.c | 72 ++++++++++++++++++++++------------
 1 file changed, 47 insertions(+), 25 deletions(-)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index 32ad1864f70f..9d9f0c635527 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -1170,15 +1170,20 @@ static int mpam_msc_read_mbwu_l(struct mpam_msc *msc, u64 *res)
 	return 0;
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
+	if (ret)
+		return ret;
+
+	return __mpam_write_reg(msc, MSMON_MBWU_L + 4, 0);
 }
 
 static void gen_msmon_ctl_flt_vals(struct mon_read *m, u32 *ctl_val,
@@ -1221,24 +1226,28 @@ static void gen_msmon_ctl_flt_vals(struct mon_read *m, u32 *ctl_val,
 	}
 }
 
-static void read_msmon_ctl_flt_vals(struct mon_read *m, u32 *ctl_val,
-				    u32 *flt_val)
+static int read_msmon_ctl_flt_vals(struct mon_read *m, u32 *ctl_val,
+				   u32 *flt_val)
 {
 	struct mpam_msc *msc = m->ris->vmsc->msc;
+	int ret;
 
 	switch (m->type) {
 	case mpam_feat_msmon_csu:
-		mpam_read_monsel_reg(msc, CFG_CSU_CTL, ctl_val);
-		mpam_read_monsel_reg(msc, CFG_CSU_FLT, flt_val);
-		break;
+		ret = mpam_read_monsel_reg(msc, CFG_CSU_CTL, ctl_val);
+		if (ret)
+			return ret;
+		return mpam_read_monsel_reg(msc, CFG_CSU_FLT, flt_val);
 	case mpam_feat_msmon_mbwu_31counter:
 	case mpam_feat_msmon_mbwu_44counter:
 	case mpam_feat_msmon_mbwu_63counter:
-		mpam_read_monsel_reg(msc, CFG_MBWU_CTL, ctl_val);
-		mpam_read_monsel_reg(msc, CFG_MBWU_FLT, flt_val);
-		break;
+		ret = mpam_read_monsel_reg(msc, CFG_MBWU_CTL, ctl_val);
+		if (ret)
+			return ret;
+		return mpam_read_monsel_reg(msc, CFG_MBWU_FLT, flt_val);
 	default:
 		pr_warn("Unexpected monitor type %d\n", m->type);
+		return -EINVAL;
 	}
 }
 
@@ -1251,10 +1260,11 @@ static inline void clean_msmon_ctl_val(u32 *cur_ctl)
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
@@ -1262,25 +1272,37 @@ static void write_msmon_ctl_flt_vals(struct mon_read *m, u32 ctl_val,
 	 */
 	switch (m->type) {
 	case mpam_feat_msmon_csu:
-		mpam_write_monsel_reg(msc, CFG_CSU_FLT, flt_val);
-		mpam_write_monsel_reg(msc, CFG_CSU_CTL, ctl_val);
-		mpam_write_monsel_reg(msc, CSU, 0);
-		mpam_write_monsel_reg(msc, CFG_CSU_CTL, ctl_val | MSMON_CFG_x_CTL_EN);
-		break;
+		ret = mpam_write_monsel_reg(msc, CFG_CSU_FLT, flt_val);
+		if (ret)
+			return ret;
+		ret = mpam_write_monsel_reg(msc, CFG_CSU_CTL, ctl_val);
+		if (ret)
+			return ret;
+		ret = mpam_write_monsel_reg(msc, CSU, 0);
+		if (ret)
+			return ret;
+		return mpam_write_monsel_reg(msc, CFG_CSU_CTL, ctl_val | MSMON_CFG_x_CTL_EN);
 	case mpam_feat_msmon_mbwu_31counter:
 	case mpam_feat_msmon_mbwu_44counter:
 	case mpam_feat_msmon_mbwu_63counter:
-		mpam_write_monsel_reg(msc, CFG_MBWU_FLT, flt_val);
-		mpam_write_monsel_reg(msc, CFG_MBWU_CTL, ctl_val);
-		mpam_write_monsel_reg(msc, CFG_MBWU_CTL, ctl_val | MSMON_CFG_x_CTL_EN);
+		ret = mpam_write_monsel_reg(msc, CFG_MBWU_FLT, flt_val);
+		if (ret)
+			return ret;
+		ret = mpam_write_monsel_reg(msc, CFG_MBWU_CTL, ctl_val);
+		if (ret)
+			return ret;
+		ret = mpam_write_monsel_reg(msc, CFG_MBWU_CTL,
+					    ctl_val | MSMON_CFG_x_CTL_EN);
+		if (ret)
+			return ret;
 		/* Counting monitors require NRDY to be reset by software */
 		if (m->type == mpam_feat_msmon_mbwu_31counter)
-			mpam_write_monsel_reg(msc, MBWU, 0);
-		else
-			mpam_msc_zero_mbwu_l(m->ris->vmsc->msc);
-		break;
+			return mpam_write_monsel_reg(msc, MBWU, 0);
+
+		return mpam_msc_zero_mbwu_l(m->ris->vmsc->msc);
 	default:
 		pr_warn("Unexpected monitor type %d\n", m->type);
+		return -EINVAL;
 	}
 }
 
-- 
2.43.0

