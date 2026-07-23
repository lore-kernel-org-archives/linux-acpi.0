Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB2344E679;
	Thu, 23 Jul 2026 15:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784822115; cv=none; b=Lp/WhNzYZcoHsEAhQPMnUd3KuoURbgfzgjG84gU6+KqofPVjYlQPx3k6o44Kke9Ut3EcATE5XSZKFOvyaj/5VEPUQg5Li68AVH63jTVBzie7kr9B0IPI8Q7/lyUlY0FhOlc8gD/DeSmnWOGHf45DyIRcIlN2pq/JhRxXpkF7uVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784822115; c=relaxed/simple;
	bh=gRBsK2XXpdqJk9qjuat4AR6gYBmA1l94CmOgVQCns2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U5K1gwG2TIRjXjPdNuIHb52wPkHqWPJq8F58ReyfwEBjc7gmxBndCibfmLADP5QB103bvbNyb3tAz8H3sWyn9ZE81F0S3fd/UOo8YLjUVtGs1BLsI2eHR0c+Z6qzapO5xhWOXYcyHf20Y/I0NxZn75xvphnaT0zuLxwY5U8qqb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=AU90jM55; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="AU90jM55"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 774FE1477;
	Thu, 23 Jul 2026 08:55:07 -0700 (PDT)
Received: from e142021.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3ED9D3F66F;
	Thu, 23 Jul 2026 08:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784822111; bh=gRBsK2XXpdqJk9qjuat4AR6gYBmA1l94CmOgVQCns2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AU90jM55LVKYweB0a4JY116y7y/hpadHywkYyTXWvTxL7EhqKY42AezSJszkbX995
	 BxNMXITwtulwzyuyAdJ6TzouvJG71xz0LdBDY29C7W7HA9mSxmiocB3sLPZVHAeYub
	 zvW68GuV/FOHi7BgdC0h5KiI5Zl8mDHVXVdEqvck=
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
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 03/10] arm_mpam: propagate MSC access errors for MBWU counters
Date: Thu, 23 Jul 2026 17:54:47 +0200
Message-ID: <20260723155454.1760823-4-andre.przywara@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723155454.1760823-1-andre.przywara@arm.com>
References: <20260723155454.1760823-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow the mpam_msc_read_mbwu_l() function to return an error, and
propagate errors from the lower level up. This also changes the users
of this function.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/resctrl/mpam_devices.c | 45 +++++++++++++++++++++++-----------
 1 file changed, 31 insertions(+), 14 deletions(-)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index ecd45a585942..fce29fa9ef78 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -1127,8 +1127,9 @@ static bool mpam_ris_has_mbwu_long_counter(struct mpam_msc_ris *ris)
 		mpam_has_feature(mpam_feat_msmon_mbwu_44counter, &ris->props));
 }
 
-static u64 mpam_msc_read_mbwu_l(struct mpam_msc *msc)
+static int mpam_msc_read_mbwu_l(struct mpam_msc *msc, u64 *res)
 {
+	int ret;
 	int retry = 3;
 	u32 mbwu_l_low;
 	u32 mbwu_l_high1, mbwu_l_high2;
@@ -1138,20 +1139,30 @@ static u64 mpam_msc_read_mbwu_l(struct mpam_msc *msc)
 	WARN_ON_ONCE((MSMON_MBWU_L + sizeof(u64)) > msc->mapped_hwpage_sz);
 	WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(), &msc->accessibility));
 
-	__mpam_read_reg(msc, MSMON_MBWU_L + 4, &mbwu_l_high2);
+	ret = __mpam_read_reg(msc, MSMON_MBWU_L + 4, &mbwu_l_high2);
+	if (ret)
+		return ret;
+
 	do {
 		mbwu_l_high1 = mbwu_l_high2;
-		__mpam_read_reg(msc, MSMON_MBWU_L, &mbwu_l_low);
-		__mpam_read_reg(msc, MSMON_MBWU_L + 4, &mbwu_l_high2);
+		ret = __mpam_read_reg(msc, MSMON_MBWU_L, &mbwu_l_low);
+		if (ret)
+			return ret;
+		ret = __mpam_read_reg(msc, MSMON_MBWU_L + 4, &mbwu_l_high2);
+		if (ret)
+			return ret;
 
 		retry--;
 	} while (mbwu_l_high1 != mbwu_l_high2 && retry > 0);
 
-	if (mbwu_l_high1 == mbwu_l_high2)
-		return ((u64)mbwu_l_high1 << 32) | mbwu_l_low;
+	if (mbwu_l_high1 == mbwu_l_high2) {
+		*res = ((u64)mbwu_l_high1 << 32) | mbwu_l_low;
+	} else {
+		pr_warn("Failed to read a stable value\n");
+		*res = MSMON___L_NRDY;
+	}
 
-	pr_warn("Failed to read a stable value\n");
-	return MSMON___L_NRDY;
+	return 0;
 }
 
 static void mpam_msc_zero_mbwu_l(struct mpam_msc *msc)
@@ -1310,10 +1321,12 @@ static void __ris_msmon_read(void *arg)
 	struct mpam_msc *msc = m->ris->vmsc->msc;
 	u32 mon_sel, ctl_val, flt_val, cur_ctl, cur_flt;
 
-	if (!mpam_mon_sel_lock(msc)) {
+	ACQUIRE(mon_sel_lock, guard)(msc);
+	if (ACQUIRE_ERR(mon_sel_lock, &guard)) {
 		m->err = -EIO;
 		return;
 	}
+
 	mon_sel = FIELD_PREP(MSMON_CFG_MON_SEL_MON_SEL, ctx->mon) |
 		  FIELD_PREP(MSMON_CFG_MON_SEL_RIS, ris->ris_idx);
 	mpam_write_monsel_reg(msc, CFG_MON_SEL, mon_sel);
@@ -1373,7 +1386,9 @@ static void __ris_msmon_read(void *arg)
 	case mpam_feat_msmon_mbwu_44counter:
 	case mpam_feat_msmon_mbwu_63counter:
 		if (m->type != mpam_feat_msmon_mbwu_31counter) {
-			now = mpam_msc_read_mbwu_l(msc);
+			m->err = mpam_msc_read_mbwu_l(msc, &now);
+			if (m->err)
+				return;
 			nrdy = now & MSMON___L_NRDY;
 
 			if (m->type == mpam_feat_msmon_mbwu_63counter)
@@ -1407,7 +1422,6 @@ static void __ris_msmon_read(void *arg)
 	default:
 		m->err = -EINVAL;
 	}
-	mpam_mon_sel_unlock(msc);
 
 	if (nrdy)
 		m->err = -EBUSY;
@@ -1762,6 +1776,7 @@ static int mpam_save_mbwu_state(void *arg)
 {
 	int i;
 	u64 val;
+	int ret;
 	struct mon_cfg *cfg;
 	u32 cur_flt, cur_ctl, mon_sel;
 	struct mpam_msc_ris *ris = arg;
@@ -1772,7 +1787,8 @@ static int mpam_save_mbwu_state(void *arg)
 		mbwu_state = &ris->mbwu_state[i];
 		cfg = &mbwu_state->cfg;
 
-		if (WARN_ON_ONCE(!mpam_mon_sel_lock(msc)))
+		ACQUIRE(mon_sel_lock, guard)(msc);
+		if (ACQUIRE_ERR(mon_sel_lock, &guard))
 			return -EIO;
 
 		mon_sel = FIELD_PREP(MSMON_CFG_MON_SEL_MON_SEL, i) |
@@ -1783,7 +1799,9 @@ static int mpam_save_mbwu_state(void *arg)
 		mpam_write_monsel_reg(msc, CFG_MBWU_CTL, 0);
 
 		if (mpam_ris_has_mbwu_long_counter(ris)) {
-			val = mpam_msc_read_mbwu_l(msc);
+			ret = mpam_msc_read_mbwu_l(msc, &val);
+			if (ret)
+				return ret;
 			mpam_msc_zero_mbwu_l(msc);
 		} else {
 			u32 val32;
@@ -1799,7 +1817,6 @@ static int mpam_save_mbwu_state(void *arg)
 		cfg->partid = FIELD_GET(MSMON_CFG_x_FLT_PARTID, cur_flt);
 		mbwu_state->correction += val;
 		mbwu_state->enabled = FIELD_GET(MSMON_CFG_x_CTL_EN, cur_ctl);
-		mpam_mon_sel_unlock(msc);
 	}
 
 	return 0;
-- 
2.43.0

