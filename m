Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34F6434418;
	Fri, 10 Jul 2026 14:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783694780; cv=none; b=bf8oDa+VvSR2u1N+VHZTZsu9TAFw+gEb3N+Cdbd+et/ytNfFUcFFxuWib5wABigyuqLE/U0UQzO5DbT4libiATuqdXNHnK2/5cvs+T2V4u+BMpF+q6bt6vStnINro8qRjv+gNPXtLKkb859Hnrpf8IcVl3xaCfgDoVQyFvL2oWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783694780; c=relaxed/simple;
	bh=2pHrFU7Umm9rnuCJmAgPuvEEJfJwWU858g8qZRQOwOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rwbCGYT+uqj4pDQkHmnetXkxqD6b3ziLm58stJr4cYeFs8ac6zqDEv/31XYX1Ou/3Cui53Ae16LIf873yLa9JuQ8OtwA4WAAuUWNU4SMu1xxvtoG2EFFQBbYXua+MmDO5lMOUhvUkVasz1ZMzuU8uabTwc7RuPzgWql5sEfa7O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=aCjfS0rw; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="aCjfS0rw"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AEFAE1E7D;
	Fri, 10 Jul 2026 07:46:13 -0700 (PDT)
Received: from e142021.munich.arm.com (e142021.arm.com [10.41.150.148])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 11FF53F7B4;
	Fri, 10 Jul 2026 07:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783694778; bh=2pHrFU7Umm9rnuCJmAgPuvEEJfJwWU858g8qZRQOwOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aCjfS0rwh6IRGf8I0ZliHfcrLOJz066V3ot8I1UprKJXeEy4t3F4KnXlUnEBLw0QJ
	 kdmy2Yj0ea5pJNOnD7Dnp3ReAaY6Pf9jaP52jeSzdHFJY+OpJ21rj6Ic2WaVlpsHsU
	 KA7RL1gOjIhkwOyBpvcYug5a8QtAfTVtJeQbGiRs=
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
Subject: [PATCH v3 11/16] arm_mpam: propagate MSC write errors for hardware probe functions
Date: Fri, 10 Jul 2026 16:45:15 +0200
Message-ID: <20260710144520.917375-12-andre.przywara@arm.com>
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

Allow the MSC write accesses in the hardware probe functions to return an
error, and propagate write errors from the lower level up.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/resctrl/mpam_devices.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index 5a9760372666..222515a01b35 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -796,24 +796,30 @@ static bool mpam_ris_hw_probe_csu_nrdy(struct mpam_msc_ris *ris)
 
 	mon_sel = FIELD_PREP(MSMON_CFG_MON_SEL_MON_SEL, 0) |
 		  FIELD_PREP(MSMON_CFG_MON_SEL_RIS, ris->ris_idx);
-	mpam_write_monsel_reg(msc, CFG_MON_SEL, mon_sel);
+	if (mpam_write_monsel_reg(msc, CFG_MON_SEL, mon_sel))
+		goto out_unlock;
 
 	/* Hardware might ignore nrdy if it's not enabled */
 	ctl_val = MSMON_CFG_CSU_CTL_TYPE_CSU;
 	ctl_val |= MSMON_CFG_x_CTL_MATCH_PARTID;
 	ctl_val |= MSMON_CFG_x_CTL_MATCH_PMG;
 	ctl_val |= MSMON_CFG_x_CTL_EN;
-	mpam_write_monsel_reg(msc, CFG_CSU_FLT, 0);
-	mpam_write_monsel_reg(msc, CFG_CSU_CTL, ctl_val);
+	if (mpam_write_monsel_reg(msc, CFG_CSU_FLT, 0))
+		goto out_unlock;
+	if (mpam_write_monsel_reg(msc, CFG_CSU_CTL, ctl_val))
+		goto out_unlock;
 
-	_mpam_write_monsel_reg(msc, MSMON_CSU, MSMON___NRDY);
+	if (_mpam_write_monsel_reg(msc, MSMON_CSU, MSMON___NRDY))
+		goto out_unlock;
 	if (_mpam_read_monsel_reg(msc, MSMON_CSU, &now))
 		goto out_unlock;
 	can_set = now & MSMON___NRDY;
 
-	_mpam_write_monsel_reg(msc, MSMON_CSU, 0);
+	if (_mpam_write_monsel_reg(msc, MSMON_CSU, 0))
+		goto out_unlock;
 	/* Configuration change to try and coax hardware into setting nrdy */
-	mpam_write_monsel_reg(msc, CFG_CSU_FLT, 0x1);
+	if (mpam_write_monsel_reg(msc, CFG_CSU_FLT, 0x1))
+		goto out_unlock;
 	if (_mpam_read_monsel_reg(msc, MSMON_CSU, &now))
 		goto out_unlock;
 	can_clear = !(now & MSMON___NRDY);
@@ -1060,8 +1066,9 @@ static int mpam_msc_hw_probe(struct mpam_msc *msc)
 
 	for (ris_idx = 0; ris_idx <= msc->ris_max; ris_idx++) {
 		mutex_lock(&msc->part_sel_lock);
-		__mpam_part_sel(ris_idx, 0, msc);
-		ret = mpam_msc_read_idr(msc, &idr);
+		ret = __mpam_part_sel(ris_idx, 0, msc);
+		if (!ret)
+			ret = mpam_msc_read_idr(msc, &idr);
 		mutex_unlock(&msc->part_sel_lock);
 		if (ret)
 			return ret;
@@ -1080,9 +1087,11 @@ static int mpam_msc_hw_probe(struct mpam_msc *msc)
 		ris->idr = idr;
 
 		mutex_lock(&msc->part_sel_lock);
-		__mpam_part_sel(ris_idx, 0, msc);
-		ret = mpam_ris_hw_probe(ris);
+		ret = __mpam_part_sel(ris_idx, 0, msc);
+		if (!ret)
+			ret = mpam_ris_hw_probe(ris);
 		mutex_unlock(&msc->part_sel_lock);
+
 		if (ret)
 			return ret;
 	}
-- 
2.43.0

