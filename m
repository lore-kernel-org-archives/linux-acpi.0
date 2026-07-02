Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126AF3368BF;
	Thu,  2 Jul 2026 16:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783009406; cv=none; b=upP+y3/SQY/8upd6fhFa+6sGDUU6zKixeE4PL/ot2pj3GRn/5A1xliasAY0t8fqqrGHj0mL1pcac8P30xgSDY5NCENNeTOalJz9N/9P3dwv9JqthpfiMrDlIWAFtkg4fJ9gmyDEKi0eO6fWEjRr9im01J887vrMURbb9/4u5cXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783009406; c=relaxed/simple;
	bh=9Q8M4dh01UPtpyHvFv79Im34gbIlo71L2ciEJRwb+I4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nq95Y/ik/mzyK+clUP55zDzQGT5XGi+b3Jcrp2XFKoI7LwyMLHL81gmmsOLUgQACPorFepmuXcMveJO2+loqsRAA6uNv5dKBqoL3h67mqbj7+rCts//A+JGP/J/PEahrRVuOXk+Q7sDbk+OYgKwlG/mi/VxUCRNVuyR2Vo1fAv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=HtMNRiG/; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="HtMNRiG/"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD8EF35C7;
	Thu,  2 Jul 2026 09:23:16 -0700 (PDT)
Received: from e142021.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 37CCA3F673;
	Thu,  2 Jul 2026 09:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783009401; bh=9Q8M4dh01UPtpyHvFv79Im34gbIlo71L2ciEJRwb+I4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HtMNRiG/AN7/8Mqdtj3jorULBOaRDB0FhpTr4gIP6seVYOpExsUSX1DQHOP8RM2ya
	 2U9ZMMG6i65E9yPrlwiZS0cZqkMCEkPzkTOecdmzLpRWmLMF0C1Hn5K0NowsvZTBzi
	 w2ktbj3JSxI/CbWFMkubr13GyIXUhv2qXCzB4Vcg=
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
Subject: [PATCH v2 10/15] arm_mpam: propagate MSC write errors for hardware probe functions
Date: Thu,  2 Jul 2026 18:22:24 +0200
Message-ID: <20260702162229.4008659-11-andre.przywara@arm.com>
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

Allow the MSC write accesses in the hardware probe functions to return an
error, and propagate write errors from the lower level up.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/resctrl/mpam_devices.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index 23a5deb290b3..f3558d248c38 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -792,24 +792,30 @@ static bool mpam_ris_hw_probe_csu_nrdy(struct mpam_msc_ris *ris)
 
 	mon_sel = FIELD_PREP(MSMON_CFG_MON_SEL_MON_SEL, 0) |
 		  FIELD_PREP(MSMON_CFG_MON_SEL_RIS, ris->ris_idx);
-	mpam_write_monsel_reg(msc, CFG_MON_SEL, mon_sel);
+	if (mpam_write_monsel_reg(msc, CFG_MON_SEL, mon_sel))
+		return false;
 
 	/* Hardware might ignore nrdy if it's not enabled */
 	ctl_val = MSMON_CFG_CSU_CTL_TYPE_CSU;
 	ctl_val |= MSMON_CFG_x_CTL_MATCH_PARTID;
 	ctl_val |= MSMON_CFG_x_CTL_MATCH_PMG;
 	ctl_val |= MSMON_CFG_x_CTL_EN;
-	mpam_write_monsel_reg(msc, CFG_CSU_FLT, 0);
-	mpam_write_monsel_reg(msc, CFG_CSU_CTL, ctl_val);
+	if (mpam_write_monsel_reg(msc, CFG_CSU_FLT, 0))
+		return false;
+	if (mpam_write_monsel_reg(msc, CFG_CSU_CTL, ctl_val))
+		return false;
 
-	_mpam_write_monsel_reg(msc, MSMON_CSU, MSMON___NRDY);
+	if (_mpam_write_monsel_reg(msc, MSMON_CSU, MSMON___NRDY))
+		return false;
 	if (_mpam_read_monsel_reg(msc, MSMON_CSU, &now))
 		return false;
 	can_set = now & MSMON___NRDY;
 
-	_mpam_write_monsel_reg(msc, MSMON_CSU, 0);
+	if (_mpam_write_monsel_reg(msc, MSMON_CSU, 0))
+		return false;
 	/* Configuration change to try and coax hardware into setting nrdy */
-	mpam_write_monsel_reg(msc, CFG_CSU_FLT, 0x1);
+	if (mpam_write_monsel_reg(msc, CFG_CSU_FLT, 0x1))
+		return false;
 	if (_mpam_read_monsel_reg(msc, MSMON_CSU, &now))
 		return false;
 	can_clear = !(now & MSMON___NRDY);
@@ -1052,8 +1058,9 @@ static int mpam_msc_hw_probe(struct mpam_msc *msc)
 
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
@@ -1072,9 +1079,11 @@ static int mpam_msc_hw_probe(struct mpam_msc *msc)
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

