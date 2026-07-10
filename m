Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683551D9A66;
	Fri, 10 Jul 2026 14:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783694754; cv=none; b=JbLDMKJ2S1fESNduS3zeUeeuWgdKVJ8gthbDGoeiHsJGdPXu1VjPLx/ADE+FIy5GwkE7IfRElUVh39Fywr7dMLaj2eL/GCz7Gg05rwRj8ZbV8b0fysQi6uK34VHc0TbuYTfEOG3kg+aZn8UbTcvGAFTfcwFY6LjKkwJiUbxYnBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783694754; c=relaxed/simple;
	bh=A0Ru/2N7sEwl2kjzGbay+ACwN2GYOjiwicjcdxvroYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=blyOTb6YQ8EPOpjtthnhmN4GRSiuCm73Ww0amtRZgn/gVdKwvzNj8TRg6czCxu66IThzgKWDZfz8IytE1kN6cH2yloNJRZcct+ObGFqGy8L8nMdwcUWRpgarX5DPA8nciyoknplTRscBB3FUWe23WzwnQgIfUUwRxpbHO0zV4ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lYeH8lkC; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lYeH8lkC"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50BD7176A;
	Fri, 10 Jul 2026 07:45:43 -0700 (PDT)
Received: from e142021.munich.arm.com (e142021.arm.com [10.41.150.148])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A916B3F7B4;
	Fri, 10 Jul 2026 07:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783694747; bh=A0Ru/2N7sEwl2kjzGbay+ACwN2GYOjiwicjcdxvroYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lYeH8lkC38rrivzwvgAAyLkAed/DP2usQZyo9E6HMW4gXychIo87JR7nDxG4IVCbJ
	 7ziPBCSbJ+UGlQ0q66nYBRBJrMcjl3hBD6kmvLMwF+D27X18amhnLZNgGAXIkVcQvL
	 CkmUUYpkeJpwwQMSmLMdfc5VJDKbcloWqYA3bGu0=
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
Subject: [PATCH v3 04/16] arm_mpam: propagate MSC read errors for mpam_msc_read_mbwu_l()
Date: Fri, 10 Jul 2026 16:45:08 +0200
Message-ID: <20260710144520.917375-5-andre.przywara@arm.com>
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

Allow the mpam_msc_read_mbwu_l() function to return an error, and
propagate read errors from the lower level up.
So far we were using a special value to indicate the "unstable read"
condition, replace that with the actual Linux error code, since it's now
easy to do.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/resctrl/mpam_devices.c | 54 +++++++++++++++++++++++++---------
 1 file changed, 40 insertions(+), 14 deletions(-)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index b1bd047da203..3b6f9e552a9f 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -1112,8 +1112,9 @@ static bool mpam_ris_has_mbwu_long_counter(struct mpam_msc_ris *ris)
 		mpam_has_feature(mpam_feat_msmon_mbwu_44counter, &ris->props));
 }
 
-static u64 mpam_msc_read_mbwu_l(struct mpam_msc *msc)
+static int mpam_msc_read_mbwu_l(struct mpam_msc *msc, u64 *res)
 {
+	int ret;
 	int retry = 3;
 	u32 mbwu_l_low;
 	u32 mbwu_l_high1, mbwu_l_high2;
@@ -1123,20 +1124,30 @@ static u64 mpam_msc_read_mbwu_l(struct mpam_msc *msc)
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
+		ret = -EBUSY;
+	}
 
-	pr_warn("Failed to read a stable value\n");
-	return MSMON___L_NRDY;
+	return ret;
 }
 
 static void mpam_msc_zero_mbwu_l(struct mpam_msc *msc)
@@ -1283,6 +1294,7 @@ static u64 mpam_msmon_overflow_val(enum mpam_device_features type,
 static void __ris_msmon_read(void *arg)
 {
 	u64 now;
+	int ret;
 	u32 now32;
 	bool nrdy = false;
 	bool config_mismatch;
@@ -1358,8 +1370,9 @@ static void __ris_msmon_read(void *arg)
 	case mpam_feat_msmon_mbwu_44counter:
 	case mpam_feat_msmon_mbwu_63counter:
 		if (m->type != mpam_feat_msmon_mbwu_31counter) {
-			now = mpam_msc_read_mbwu_l(msc);
-			nrdy = now & MSMON___L_NRDY;
+			ret = mpam_msc_read_mbwu_l(msc, &now);
+			if (ret)
+				goto out_unlock;
 
 			if (m->type == mpam_feat_msmon_mbwu_63counter)
 				now = FIELD_GET(MSMON___LWD_VALUE, now);
@@ -1397,10 +1410,15 @@ static void __ris_msmon_read(void *arg)
 	if (nrdy)
 		m->err = -EBUSY;
 
-	if (m->err)
-		return;
+	if (!m->err)
+		*m->val += now;
+
+	return;
+
+out_unlock:
+	mpam_mon_sel_unlock(msc);
 
-	*m->val += now;
+	m->err = ret;
 }
 
 static int _msmon_read(struct mpam_component *comp, struct mon_read *arg)
@@ -1747,6 +1765,7 @@ static int mpam_save_mbwu_state(void *arg)
 {
 	int i;
 	u64 val;
+	int ret = 0;
 	struct mon_cfg *cfg;
 	u32 cur_flt, cur_ctl, mon_sel;
 	struct mpam_msc_ris *ris = arg;
@@ -1768,7 +1787,9 @@ static int mpam_save_mbwu_state(void *arg)
 		mpam_write_monsel_reg(msc, CFG_MBWU_CTL, 0);
 
 		if (mpam_ris_has_mbwu_long_counter(ris)) {
-			val = mpam_msc_read_mbwu_l(msc);
+			ret = mpam_msc_read_mbwu_l(msc, &val);
+			if (ret)
+				goto out_unlock;
 			mpam_msc_zero_mbwu_l(msc);
 		} else {
 			u32 val32;
@@ -1788,6 +1809,11 @@ static int mpam_save_mbwu_state(void *arg)
 	}
 
 	return 0;
+
+out_unlock:
+	mpam_mon_sel_unlock(msc);
+
+	return ret;
 }
 
 /*
-- 
2.43.0

