Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18574403156;
	Fri, 10 Jul 2026 14:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783694750; cv=none; b=DeG+m+n62PN/k+9SqsabP0/IyvlJ7isY4TBE9urvLLIWyAWrqbQYNgMuIsgJx9TQ1VnI2Vg//30XHBqM4M9KkEkWRW6tTZ8pmHkSxLnIDA9wYE/RGDc/mxPnCEMJRwCAtELSwiI+fyuKblSXPkRG64irXBePAyZSDK18R4jiTtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783694750; c=relaxed/simple;
	bh=6OlvW+eQ2GaznRaP8rXR5TDcvHWDz1dS7H74bnFx2nQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pjOwC0eOOE3dFOIFGEIpwFvaxWsH/k4z+ygbbEQbwBXfKzTVMMNrOcfC5d+ISt/5Rpx07yutToVRsI7PMU98964MWvjqEivk0uNeqMromVpm+GXXdjLyNDpGdCbwTMfioP/f1+llPEwwaJGqEkOJ7owVmMw8O9VIJORmCJPaPug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=p1EdBmwK; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="p1EdBmwK"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F41E41BC0;
	Fri, 10 Jul 2026 07:45:38 -0700 (PDT)
Received: from e142021.munich.arm.com (e142021.arm.com [10.41.150.148])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 54FCE3F7B4;
	Fri, 10 Jul 2026 07:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783694743; bh=6OlvW+eQ2GaznRaP8rXR5TDcvHWDz1dS7H74bnFx2nQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p1EdBmwKIzR9Aqe49t7set5L0KE+U/nIc2FBlEzULKQLlFoAbWQcOCDALqhJtfZZY
	 FtO/b8sGj45lK2kRifdhFifBwLG85Lc+d4BbVRz2eYAhHpapCKZ58Ij92laZxOzrfw
	 5sAsSqWEjHiyLUbYA2A5owhrUyIxSvcM8eByQn0k=
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
Subject: [PATCH v3 03/16] arm_mpam: propagate MSC read errors for hw_probe functions
Date: Fri, 10 Jul 2026 16:45:07 +0200
Message-ID: <20260710144520.917375-4-andre.przywara@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710144520.917375-1-andre.przywara@arm.com>
References: <20260710144520.917375-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow the functions probing for MSC hardware and features to return an
error, and propagate read errors from the lower level up.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/resctrl/mpam_devices.c | 70 ++++++++++++++++++++++++----------
 1 file changed, 50 insertions(+), 20 deletions(-)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index 8fd2c38c821c..b1bd047da203 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -785,7 +785,7 @@ static void mpam_enable_quirks(struct mpam_msc *msc)
 static bool mpam_ris_hw_probe_csu_nrdy(struct mpam_msc_ris *ris)
 {
 	u32 now, mon_sel, ctl_val;
-	bool can_set, can_clear;
+	bool can_set, can_clear, ret = false;
 	struct mpam_msc *msc = ris->vmsc->msc;
 
 	if (WARN_ON_ONCE(!mpam_mon_sel_lock(msc)))
@@ -804,20 +804,26 @@ static bool mpam_ris_hw_probe_csu_nrdy(struct mpam_msc_ris *ris)
 	mpam_write_monsel_reg(msc, CFG_CSU_CTL, ctl_val);
 
 	_mpam_write_monsel_reg(msc, MSMON_CSU, MSMON___NRDY);
-	_mpam_read_monsel_reg(msc, MSMON_CSU, &now);
+	if (_mpam_read_monsel_reg(msc, MSMON_CSU, &now))
+		goto out_unlock;
 	can_set = now & MSMON___NRDY;
 
 	_mpam_write_monsel_reg(msc, MSMON_CSU, 0);
 	/* Configuration change to try and coax hardware into setting nrdy */
 	mpam_write_monsel_reg(msc, CFG_CSU_FLT, 0x1);
-	_mpam_read_monsel_reg(msc, MSMON_CSU, &now);
+	if (_mpam_read_monsel_reg(msc, MSMON_CSU, &now))
+		goto out_unlock;
 	can_clear = !(now & MSMON___NRDY);
+
+	ret = !can_set || !can_clear;
+
+out_unlock:
 	mpam_mon_sel_unlock(msc);
 
-	return (!can_set || !can_clear);
+	return ret;
 }
 
-static void mpam_ris_hw_probe(struct mpam_msc_ris *ris)
+static int mpam_ris_hw_probe(struct mpam_msc_ris *ris)
 {
 	int err;
 	struct mpam_msc *msc = ris->vmsc->msc;
@@ -832,7 +838,9 @@ static void mpam_ris_hw_probe(struct mpam_msc_ris *ris)
 	if (FIELD_GET(MPAMF_IDR_HAS_CCAP_PART, ris->idr)) {
 		u32 ccap_features;
 
-		mpam_read_partsel_reg(msc, CCAP_IDR, &ccap_features);
+		err = mpam_read_partsel_reg(msc, CCAP_IDR, &ccap_features);
+		if (err)
+			return err;
 
 		props->cmax_wd = FIELD_GET(MPAMF_CCAP_IDR_CMAX_WD, ccap_features);
 		if (props->cmax_wd &&
@@ -857,7 +865,9 @@ static void mpam_ris_hw_probe(struct mpam_msc_ris *ris)
 	if (FIELD_GET(MPAMF_IDR_HAS_CPOR_PART, ris->idr)) {
 		u32 cpor_features;
 
-		mpam_read_partsel_reg(msc, CPOR_IDR, &cpor_features);
+		err = mpam_read_partsel_reg(msc, CPOR_IDR, &cpor_features);
+		if (err)
+			return err;
 
 		props->cpbm_wd = FIELD_GET(MPAMF_CPOR_IDR_CPBM_WD, cpor_features);
 		if (props->cpbm_wd)
@@ -867,8 +877,9 @@ static void mpam_ris_hw_probe(struct mpam_msc_ris *ris)
 	/* Memory bandwidth partitioning */
 	if (FIELD_GET(MPAMF_IDR_HAS_MBW_PART, ris->idr)) {
 		u32 mbw_features;
-
-		mpam_read_partsel_reg(msc, MBW_IDR, &mbw_features);
+		err = mpam_read_partsel_reg(msc, MBW_IDR, &mbw_features);
+		if (err)
+			return err;
 
 		/* portion bitmap resolution */
 		props->mbw_pbm_bits = FIELD_GET(MPAMF_MBW_IDR_BWPBM_WD, mbw_features);
@@ -897,8 +908,9 @@ static void mpam_ris_hw_probe(struct mpam_msc_ris *ris)
 	/* Priority partitioning */
 	if (FIELD_GET(MPAMF_IDR_HAS_PRI_PART, ris->idr)) {
 		u32 pri_features;
-
-		mpam_read_partsel_reg(msc, PRI_IDR, &pri_features);
+		err = mpam_read_partsel_reg(msc, PRI_IDR, &pri_features);
+		if (err)
+			return err;
 
 		props->intpri_wd = FIELD_GET(MPAMF_PRI_IDR_INTPRI_WD, pri_features);
 		if (props->intpri_wd && FIELD_GET(MPAMF_PRI_IDR_HAS_INTPRI, pri_features)) {
@@ -919,7 +931,9 @@ static void mpam_ris_hw_probe(struct mpam_msc_ris *ris)
 	if (FIELD_GET(MPAMF_IDR_HAS_MSMON, ris->idr)) {
 		u32 msmon_features;
 
-		mpam_read_partsel_reg(msc, MSMON_IDR, &msmon_features);
+		err = mpam_read_partsel_reg(msc, MSMON_IDR, &msmon_features);
+		if (err)
+			return err;
 
 		/*
 		 * If the firmware max-nrdy-us property is missing, the
@@ -932,7 +946,9 @@ static void mpam_ris_hw_probe(struct mpam_msc_ris *ris)
 		if (FIELD_GET(MPAMF_MSMON_IDR_MSMON_CSU, msmon_features)) {
 			u32 csumonidr;
 
-			mpam_read_partsel_reg(msc, CSUMON_IDR, &csumonidr);
+			err = mpam_read_partsel_reg(msc, CSUMON_IDR, &csumonidr);
+			if (err)
+				return err;
 
 			props->num_csu_mon = FIELD_GET(MPAMF_CSUMON_IDR_NUM_MON, csumonidr);
 			if (props->num_csu_mon) {
@@ -958,7 +974,9 @@ static void mpam_ris_hw_probe(struct mpam_msc_ris *ris)
 			bool has_long;
 			u32 mbwumon_idr;
 
-			mpam_read_partsel_reg(msc, MBWUMON_IDR, &mbwumon_idr);
+			err = mpam_read_partsel_reg(msc, MBWUMON_IDR, &mbwumon_idr);
+			if (err)
+				return err;
 
 			props->num_mbwu_mon = FIELD_GET(MPAMF_MBWUMON_IDR_NUM_MON, mbwumon_idr);
 			if (props->num_mbwu_mon) {
@@ -991,16 +1009,22 @@ static void mpam_ris_hw_probe(struct mpam_msc_ris *ris)
 		u16 partid_max;
 		u32 nrwidr;
 
-		mpam_read_partsel_reg(msc, PARTID_NRW_IDR, &nrwidr);
+		err = mpam_read_partsel_reg(msc, PARTID_NRW_IDR, &nrwidr);
+		if (err)
+			return err;
+
 		partid_max = FIELD_GET(MPAMF_PARTID_NRW_IDR_INTPARTID_MAX, nrwidr);
 
 		mpam_set_feature(mpam_feat_partid_nrw, props);
 		msc->partid_max = min(msc->partid_max, partid_max);
 	}
+
+	return 0;
 }
 
 static int mpam_msc_hw_probe(struct mpam_msc *msc)
 {
+	int ret;
 	u64 idr;
 	u16 partid_max;
 	u8 ris_idx, pmg_max;
@@ -1016,10 +1040,12 @@ static int mpam_msc_hw_probe(struct mpam_msc *msc)
 
 	/* Grab an IDR value to find out how many RIS there are */
 	mutex_lock(&msc->part_sel_lock);
-	mpam_msc_read_idr(msc, &idr);
-	mpam_read_partsel_reg(msc, IIDR, &msc->iidr);
-
+	ret = mpam_msc_read_idr(msc, &idr);
+	if (!ret)
+		ret = mpam_read_partsel_reg(msc, IIDR, &msc->iidr);
 	mutex_unlock(&msc->part_sel_lock);
+	if (ret)
+		return ret;
 
 	mpam_enable_quirks(msc);
 
@@ -1032,8 +1058,10 @@ static int mpam_msc_hw_probe(struct mpam_msc *msc)
 	for (ris_idx = 0; ris_idx <= msc->ris_max; ris_idx++) {
 		mutex_lock(&msc->part_sel_lock);
 		__mpam_part_sel(ris_idx, 0, msc);
-		mpam_msc_read_idr(msc, &idr);
+		ret = mpam_msc_read_idr(msc, &idr);
 		mutex_unlock(&msc->part_sel_lock);
+		if (ret)
+			return ret;
 
 		partid_max = FIELD_GET(MPAMF_IDR_PARTID_MAX, idr);
 		pmg_max = FIELD_GET(MPAMF_IDR_PMG_MAX, idr);
@@ -1050,8 +1078,10 @@ static int mpam_msc_hw_probe(struct mpam_msc *msc)
 
 		mutex_lock(&msc->part_sel_lock);
 		__mpam_part_sel(ris_idx, 0, msc);
-		mpam_ris_hw_probe(ris);
+		ret = mpam_ris_hw_probe(ris);
 		mutex_unlock(&msc->part_sel_lock);
+		if (ret)
+			return ret;
 	}
 
 	/* Clear any stale errors */
-- 
2.43.0

