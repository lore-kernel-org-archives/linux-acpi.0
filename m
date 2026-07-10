Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D172D592D;
	Fri, 10 Jul 2026 14:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783694741; cv=none; b=qRwrGvK0YVa5fbCiFSIPSShsbd/fIn8xxK53U4pZwq750Mt8ZIqnlMwISwL5JBVQLc4c/NwQ3s4zPtTED6iHmhyA4SoA9vApEqB+/0Y+SS/RTU/UnB3onqxNMvEgGO/zuWLXqTKtRrCmDe8SL7BypHuLatFmv4m+46uamY+c8e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783694741; c=relaxed/simple;
	bh=463AiPpg8bN0YaCAhKvsVnF4tFZr9fK0cCTAjKjeLXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kmTogrZcRXh2tbVxr3HJnqZOwIMx2CBXY3iP/CqJX9T2EYIRSoUYXseLzXquEfFSAE48i8emn05ifYxOOkGNjoxSW9Q/3w8uAGjkLmtjOmvOcuVu4sh8ELeA5sUPXuh4Gr0tq38qeSrSL+DGRZL4It1Q2l+hBbJL7yKq3ybiXGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=oGq0BOzj; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="oGq0BOzj"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 498AB1BC0;
	Fri, 10 Jul 2026 07:45:30 -0700 (PDT)
Received: from e142021.munich.arm.com (e142021.arm.com [10.41.150.148])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 794993F7B4;
	Fri, 10 Jul 2026 07:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783694734; bh=463AiPpg8bN0YaCAhKvsVnF4tFZr9fK0cCTAjKjeLXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oGq0BOzjQXJ/DdpqtP0spb7M3ShpR5x8YCDvOznrw5fDfzP4eq2Vln0aolx3YIyY0
	 +gySuRUq7BhZuN5JNLQffxqr1XsFprxweEKLG8VGvtSO9GxGUQwOrnoJKasjL7i3XP
	 w4TkcCgret214mFvzHJpTXd/0IvF627mI3V7iZmg=
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
Subject: [PATCH v3 01/16] arm_mpam: let low level MSC read accessors return an error
Date: Fri, 10 Jul 2026 16:45:05 +0200
Message-ID: <20260710144520.917375-2-andre.przywara@arm.com>
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

The upcoming MPAM-Fb support does not use MMIO primitives to access an
MSC, but employs a shared-memory/doorbell based firmware protocol.
Its complexity means that is must be able to handle errors, whereas we
always assume an MSC access succeeds today.

Change the __mpam_read_reg() low level accessor function to return the
requested data through a pointer, and return an error code instead.
At the moment this is always 0, but this will change with alternative
MSC access methods.
Change all users of those MSC read wrappers to comply with the new
prototype, though at the moment without propagating any errors.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/resctrl/mpam_devices.c | 129 ++++++++++++++++++++-------------
 1 file changed, 78 insertions(+), 51 deletions(-)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index b69f99488111..df14b4513382 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -177,20 +177,23 @@ static void mpam_assert_partid_sizes_fixed(void)
 		WARN_ON_ONCE(!partid_max_published);
 }
 
-static u32 __mpam_read_reg(struct mpam_msc *msc, u16 reg)
+static int __mpam_read_reg(struct mpam_msc *msc, u16 reg, u32 *res)
 {
 	WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(), &msc->accessibility));
 
-	return readl_relaxed(msc->mapped_hwpage + reg);
+	*res = readl_relaxed(msc->mapped_hwpage + reg);
+
+	return 0;
 }
 
-static inline u32 _mpam_read_partsel_reg(struct mpam_msc *msc, u16 reg)
+static inline int _mpam_read_partsel_reg(struct mpam_msc *msc, u16 reg,
+					 u32 *res)
 {
 	lockdep_assert_held_once(&msc->part_sel_lock);
-	return __mpam_read_reg(msc, reg);
+	return __mpam_read_reg(msc, reg, res);
 }
 
-#define mpam_read_partsel_reg(msc, reg) _mpam_read_partsel_reg(msc, MPAMF_##reg)
+#define mpam_read_partsel_reg(msc, reg, res) _mpam_read_partsel_reg(msc, MPAMF_##reg, res)
 
 static void __mpam_write_reg(struct mpam_msc *msc, u16 reg, u32 val)
 {
@@ -208,13 +211,14 @@ static inline void _mpam_write_partsel_reg(struct mpam_msc *msc, u16 reg, u32 va
 
 #define mpam_write_partsel_reg(msc, reg, val)  _mpam_write_partsel_reg(msc, MPAMCFG_##reg, val)
 
-static inline u32 _mpam_read_monsel_reg(struct mpam_msc *msc, u16 reg)
+static inline int _mpam_read_monsel_reg(struct mpam_msc *msc, u16 reg,
+					u32 *res)
 {
 	mpam_mon_sel_lock_held(msc);
-	return __mpam_read_reg(msc, reg);
+	return __mpam_read_reg(msc, reg, res);
 }
 
-#define mpam_read_monsel_reg(msc, reg) _mpam_read_monsel_reg(msc, MSMON_##reg)
+#define mpam_read_monsel_reg(msc, reg, res) _mpam_read_monsel_reg(msc, MSMON_##reg, res)
 
 static inline void _mpam_write_monsel_reg(struct mpam_msc *msc, u16 reg, u32 val)
 {
@@ -226,10 +230,11 @@ static inline void _mpam_write_monsel_reg(struct mpam_msc *msc, u16 reg, u32 val
 
 static bool mpam_msc_check_aidr(struct mpam_msc *msc)
 {
-	u32 aidr = __mpam_read_reg(msc, MPAMF_AIDR);
-	u32 major = FIELD_GET(MPAMF_AIDR_ARCH_MAJOR_REV, aidr);
-	u32 minor = FIELD_GET(MPAMF_AIDR_ARCH_MINOR_REV, aidr);
+	u32 aidr, major, minor;
 
+	__mpam_read_reg(msc, MPAMF_AIDR, &aidr);
+	major = FIELD_GET(MPAMF_AIDR_ARCH_MAJOR_REV, aidr);
+	minor = FIELD_GET(MPAMF_AIDR_ARCH_MINOR_REV, aidr);
 	/*
 	 * v0.0 and >v2.x aren't supported, but anything else should be backward
 	 * compatible to v0.1 or v1.0.
@@ -244,20 +249,22 @@ static bool mpam_msc_check_aidr(struct mpam_msc *msc)
 
 static u64 mpam_msc_read_idr(struct mpam_msc *msc)
 {
-	u64 idr_high = 0, idr_low;
+	u32 idr_high = 0, idr_low;
 
 	lockdep_assert_held(&msc->part_sel_lock);
 
-	idr_low = mpam_read_partsel_reg(msc, IDR);
+	mpam_read_partsel_reg(msc, IDR, &idr_low);
 	if (FIELD_GET(MPAMF_IDR_EXT, idr_low))
-		idr_high = mpam_read_partsel_reg(msc, IDR + 4);
+		mpam_read_partsel_reg(msc, IDR + 4, &idr_high);
 
-	return (idr_high << 32) | idr_low;
+	return ((u64)idr_high << 32) | idr_low;
 }
 
 static void mpam_msc_clear_esr(struct mpam_msc *msc)
 {
-	u64 esr_low = __mpam_read_reg(msc, MPAMF_ESR);
+	u32 esr_low;
+
+	__mpam_read_reg(msc, MPAMF_ESR, &esr_low);
 
 	if (!esr_low)
 		return;
@@ -275,13 +282,13 @@ static void mpam_msc_clear_esr(struct mpam_msc *msc)
 
 static u64 mpam_msc_read_esr(struct mpam_msc *msc)
 {
-	u64 esr_high = 0, esr_low;
+	u32 esr_high = 0, esr_low;
 
-	esr_low = __mpam_read_reg(msc, MPAMF_ESR);
+	__mpam_read_reg(msc, MPAMF_ESR, &esr_low);
 	if (msc->has_extd_esr)
-		esr_high = __mpam_read_reg(msc, MPAMF_ESR + 4);
+		__mpam_read_reg(msc, MPAMF_ESR + 4, &esr_high);
 
-	return (esr_high << 32) | esr_low;
+	return ((u64)esr_high << 32) | esr_low;
 }
 
 static void __mpam_part_sel_raw(u32 partsel, struct mpam_msc *msc)
@@ -774,13 +781,13 @@ static bool mpam_ris_hw_probe_csu_nrdy(struct mpam_msc_ris *ris)
 	mpam_write_monsel_reg(msc, CFG_CSU_CTL, ctl_val);
 
 	_mpam_write_monsel_reg(msc, MSMON_CSU, MSMON___NRDY);
-	now = _mpam_read_monsel_reg(msc, MSMON_CSU);
+	_mpam_read_monsel_reg(msc, MSMON_CSU, &now);
 	can_set = now & MSMON___NRDY;
 
 	_mpam_write_monsel_reg(msc, MSMON_CSU, 0);
 	/* Configuration change to try and coax hardware into setting nrdy */
 	mpam_write_monsel_reg(msc, CFG_CSU_FLT, 0x1);
-	now = _mpam_read_monsel_reg(msc, MSMON_CSU);
+	_mpam_read_monsel_reg(msc, MSMON_CSU, &now);
 	can_clear = !(now & MSMON___NRDY);
 	mpam_mon_sel_unlock(msc);
 
@@ -800,7 +807,9 @@ static void mpam_ris_hw_probe(struct mpam_msc_ris *ris)
 
 	/* Cache Capacity Partitioning */
 	if (FIELD_GET(MPAMF_IDR_HAS_CCAP_PART, ris->idr)) {
-		u32 ccap_features = mpam_read_partsel_reg(msc, CCAP_IDR);
+		u32 ccap_features;
+
+		mpam_read_partsel_reg(msc, CCAP_IDR, &ccap_features);
 
 		props->cmax_wd = FIELD_GET(MPAMF_CCAP_IDR_CMAX_WD, ccap_features);
 		if (props->cmax_wd &&
@@ -823,7 +832,9 @@ static void mpam_ris_hw_probe(struct mpam_msc_ris *ris)
 
 	/* Cache Portion partitioning */
 	if (FIELD_GET(MPAMF_IDR_HAS_CPOR_PART, ris->idr)) {
-		u32 cpor_features = mpam_read_partsel_reg(msc, CPOR_IDR);
+		u32 cpor_features;
+
+		mpam_read_partsel_reg(msc, CPOR_IDR, &cpor_features);
 
 		props->cpbm_wd = FIELD_GET(MPAMF_CPOR_IDR_CPBM_WD, cpor_features);
 		if (props->cpbm_wd)
@@ -832,7 +843,9 @@ static void mpam_ris_hw_probe(struct mpam_msc_ris *ris)
 
 	/* Memory bandwidth partitioning */
 	if (FIELD_GET(MPAMF_IDR_HAS_MBW_PART, ris->idr)) {
-		u32 mbw_features = mpam_read_partsel_reg(msc, MBW_IDR);
+		u32 mbw_features;
+
+		mpam_read_partsel_reg(msc, MBW_IDR, &mbw_features);
 
 		/* portion bitmap resolution */
 		props->mbw_pbm_bits = FIELD_GET(MPAMF_MBW_IDR_BWPBM_WD, mbw_features);
@@ -860,7 +873,9 @@ static void mpam_ris_hw_probe(struct mpam_msc_ris *ris)
 
 	/* Priority partitioning */
 	if (FIELD_GET(MPAMF_IDR_HAS_PRI_PART, ris->idr)) {
-		u32 pri_features = mpam_read_partsel_reg(msc, PRI_IDR);
+		u32 pri_features;
+
+		mpam_read_partsel_reg(msc, PRI_IDR, &pri_features);
 
 		props->intpri_wd = FIELD_GET(MPAMF_PRI_IDR_INTPRI_WD, pri_features);
 		if (props->intpri_wd && FIELD_GET(MPAMF_PRI_IDR_HAS_INTPRI, pri_features)) {
@@ -879,7 +894,9 @@ static void mpam_ris_hw_probe(struct mpam_msc_ris *ris)
 
 	/* Performance Monitoring */
 	if (FIELD_GET(MPAMF_IDR_HAS_MSMON, ris->idr)) {
-		u32 msmon_features = mpam_read_partsel_reg(msc, MSMON_IDR);
+		u32 msmon_features;
+
+		mpam_read_partsel_reg(msc, MSMON_IDR, &msmon_features);
 
 		/*
 		 * If the firmware max-nrdy-us property is missing, the
@@ -892,7 +909,8 @@ static void mpam_ris_hw_probe(struct mpam_msc_ris *ris)
 		if (FIELD_GET(MPAMF_MSMON_IDR_MSMON_CSU, msmon_features)) {
 			u32 csumonidr;
 
-			csumonidr = mpam_read_partsel_reg(msc, CSUMON_IDR);
+			mpam_read_partsel_reg(msc, CSUMON_IDR, &csumonidr);
+
 			props->num_csu_mon = FIELD_GET(MPAMF_CSUMON_IDR_NUM_MON, csumonidr);
 			if (props->num_csu_mon) {
 				bool hw_managed;
@@ -915,7 +933,9 @@ static void mpam_ris_hw_probe(struct mpam_msc_ris *ris)
 		}
 		if (FIELD_GET(MPAMF_MSMON_IDR_MSMON_MBWU, msmon_features)) {
 			bool has_long;
-			u32 mbwumon_idr = mpam_read_partsel_reg(msc, MBWUMON_IDR);
+			u32 mbwumon_idr;
+
+			mpam_read_partsel_reg(msc, MBWUMON_IDR, &mbwumon_idr);
 
 			props->num_mbwu_mon = FIELD_GET(MPAMF_MBWUMON_IDR_NUM_MON, mbwumon_idr);
 			if (props->num_mbwu_mon) {
@@ -945,8 +965,11 @@ static void mpam_ris_hw_probe(struct mpam_msc_ris *ris)
 	 */
 	if (FIELD_GET(MPAMF_IDR_HAS_PARTID_NRW, ris->idr) &&
 	    class->type != MPAM_CLASS_UNKNOWN) {
-		u32 nrwidr = mpam_read_partsel_reg(msc, PARTID_NRW_IDR);
-		u16 partid_max = FIELD_GET(MPAMF_PARTID_NRW_IDR_INTPARTID_MAX, nrwidr);
+		u16 partid_max;
+		u32 nrwidr;
+
+		mpam_read_partsel_reg(msc, PARTID_NRW_IDR, &nrwidr);
+		partid_max = FIELD_GET(MPAMF_PARTID_NRW_IDR_INTPARTID_MAX, nrwidr);
 
 		mpam_set_feature(mpam_feat_partid_nrw, props);
 		msc->partid_max = min(msc->partid_max, partid_max);
@@ -971,7 +994,8 @@ static int mpam_msc_hw_probe(struct mpam_msc *msc)
 	/* Grab an IDR value to find out how many RIS there are */
 	mutex_lock(&msc->part_sel_lock);
 	idr = mpam_msc_read_idr(msc);
-	msc->iidr = mpam_read_partsel_reg(msc, IIDR);
+	mpam_read_partsel_reg(msc, IIDR, &msc->iidr);
+
 	mutex_unlock(&msc->part_sel_lock);
 
 	mpam_enable_quirks(msc);
@@ -1039,24 +1063,24 @@ static u64 mpam_msc_read_mbwu_l(struct mpam_msc *msc)
 {
 	int retry = 3;
 	u32 mbwu_l_low;
-	u64 mbwu_l_high1, mbwu_l_high2;
+	u32 mbwu_l_high1, mbwu_l_high2;
 
 	mpam_mon_sel_lock_held(msc);
 
 	WARN_ON_ONCE((MSMON_MBWU_L + sizeof(u64)) > msc->mapped_hwpage_sz);
 	WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(), &msc->accessibility));
 
-	mbwu_l_high2 = __mpam_read_reg(msc, MSMON_MBWU_L + 4);
+	__mpam_read_reg(msc, MSMON_MBWU_L + 4, &mbwu_l_high2);
 	do {
 		mbwu_l_high1 = mbwu_l_high2;
-		mbwu_l_low = __mpam_read_reg(msc, MSMON_MBWU_L);
-		mbwu_l_high2 = __mpam_read_reg(msc, MSMON_MBWU_L + 4);
+		__mpam_read_reg(msc, MSMON_MBWU_L, &mbwu_l_low);
+		__mpam_read_reg(msc, MSMON_MBWU_L + 4, &mbwu_l_high2);
 
 		retry--;
 	} while (mbwu_l_high1 != mbwu_l_high2 && retry > 0);
 
 	if (mbwu_l_high1 == mbwu_l_high2)
-		return (mbwu_l_high1 << 32) | mbwu_l_low;
+		return ((u64)mbwu_l_high1 << 32) | mbwu_l_low;
 
 	pr_warn("Failed to read a stable value\n");
 	return MSMON___L_NRDY;
@@ -1120,14 +1144,14 @@ static void read_msmon_ctl_flt_vals(struct mon_read *m, u32 *ctl_val,
 
 	switch (m->type) {
 	case mpam_feat_msmon_csu:
-		*ctl_val = mpam_read_monsel_reg(msc, CFG_CSU_CTL);
-		*flt_val = mpam_read_monsel_reg(msc, CFG_CSU_FLT);
+		mpam_read_monsel_reg(msc, CFG_CSU_CTL, ctl_val);
+		mpam_read_monsel_reg(msc, CFG_CSU_FLT, flt_val);
 		break;
 	case mpam_feat_msmon_mbwu_31counter:
 	case mpam_feat_msmon_mbwu_44counter:
 	case mpam_feat_msmon_mbwu_63counter:
-		*ctl_val = mpam_read_monsel_reg(msc, CFG_MBWU_CTL);
-		*flt_val = mpam_read_monsel_reg(msc, CFG_MBWU_FLT);
+		mpam_read_monsel_reg(msc, CFG_MBWU_CTL, ctl_val);
+		mpam_read_monsel_reg(msc, CFG_MBWU_FLT, flt_val);
 		break;
 	default:
 		pr_warn("Unexpected monitor type %d\n", m->type);
@@ -1206,6 +1230,7 @@ static u64 mpam_msmon_overflow_val(enum mpam_device_features type,
 static void __ris_msmon_read(void *arg)
 {
 	u64 now;
+	u32 now32;
 	bool nrdy = false;
 	bool config_mismatch;
 	bool overflow = false;
@@ -1268,9 +1293,9 @@ static void __ris_msmon_read(void *arg)
 
 	switch (m->type) {
 	case mpam_feat_msmon_csu:
-		now = mpam_read_monsel_reg(msc, CSU);
-		nrdy = now & MSMON___NRDY;
-		now = FIELD_GET(MSMON___VALUE, now);
+		mpam_read_monsel_reg(msc, CSU, &now32);
+		nrdy = now32 & MSMON___NRDY;
+		now = FIELD_GET(MSMON___VALUE, now32);
 
 		if (mpam_has_quirk(IGNORE_CSU_NRDY, msc) && m->waited_timeout)
 			nrdy = false;
@@ -1288,9 +1313,9 @@ static void __ris_msmon_read(void *arg)
 			else
 				now = FIELD_GET(MSMON___L_VALUE, now);
 		} else {
-			now = mpam_read_monsel_reg(msc, MBWU);
-			nrdy = now & MSMON___NRDY;
-			now = FIELD_GET(MSMON___VALUE, now);
+			mpam_read_monsel_reg(msc, MBWU, &now32);
+			nrdy = now32 & MSMON___NRDY;
+			now = FIELD_GET(MSMON___VALUE, now32);
 		}
 
 		if (mpam_has_quirk(T241_MBW_COUNTER_SCALE_64, msc) &&
@@ -1685,16 +1710,18 @@ static int mpam_save_mbwu_state(void *arg)
 		mon_sel = FIELD_PREP(MSMON_CFG_MON_SEL_MON_SEL, i) |
 			  FIELD_PREP(MSMON_CFG_MON_SEL_RIS, ris->ris_idx);
 		mpam_write_monsel_reg(msc, CFG_MON_SEL, mon_sel);
-
-		cur_flt = mpam_read_monsel_reg(msc, CFG_MBWU_FLT);
-		cur_ctl = mpam_read_monsel_reg(msc, CFG_MBWU_CTL);
+		mpam_read_monsel_reg(msc, CFG_MBWU_FLT, &cur_flt);
+		mpam_read_monsel_reg(msc, CFG_MBWU_CTL, &cur_ctl);
 		mpam_write_monsel_reg(msc, CFG_MBWU_CTL, 0);
 
 		if (mpam_ris_has_mbwu_long_counter(ris)) {
 			val = mpam_msc_read_mbwu_l(msc);
 			mpam_msc_zero_mbwu_l(msc);
 		} else {
-			val = mpam_read_monsel_reg(msc, MBWU);
+			u32 val32;
+
+			mpam_read_monsel_reg(msc, MBWU, &val32);
+			val = val32;
 			mpam_write_monsel_reg(msc, MBWU, 0);
 		}
 
-- 
2.43.0

