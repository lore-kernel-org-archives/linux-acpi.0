Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAE641B357;
	Fri, 10 Jul 2026 14:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783694767; cv=none; b=sZOKZjr8gnwRQyZ4mbqG1YUY2i4ZMn8J4v2cuqsiMwSgNsIfF2ZVVrq0hDul1GTaY0PUseIA+yGrmthZsxy9VcEXrF7wTPH4pA1lBzYku7/MlQPZvenjcoZpHsGVKdnprIxWC+WSJDYmtMU1MKKXdOYmHRhwoap9xfrcfto+9KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783694767; c=relaxed/simple;
	bh=/+6R3eFkL7zhJ6QLHEoIuYVLxaDoPmOxKrviB6wcBEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uQdhzirXZ0uM0X9bxG/F72UNI86w5YbyWX9KhsjLMhBJ/1LbZQMPRMj4u42zwzTFUOjkyl8aZsNNwA+cUYxh/3alpUJDYKlrqPUGI+s30TwEFMU7y9VdIgHDhE9xDGH5qWRjiHnl39P0ZVyph7iNL/iBl34Cfk+Q/6dKEMLquNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=cwWAIFNn; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="cwWAIFNn"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A78FE1E7D;
	Fri, 10 Jul 2026 07:46:00 -0700 (PDT)
Received: from e142021.munich.arm.com (e142021.arm.com [10.41.150.148])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B18A3F7B4;
	Fri, 10 Jul 2026 07:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783694764; bh=/+6R3eFkL7zhJ6QLHEoIuYVLxaDoPmOxKrviB6wcBEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cwWAIFNn0Az1oWoOcksfvvZSTncWJV5eYZVyx1tZ1mkVDbYrk7hoHk3mDYdnCaZ/x
	 FKiRdFYq5Sc8qQriVhimJ7A6bX/PwMXZqYfgmTxAQut4j+RVX8876yJiYlJXmizabv
	 x2+bJ27u3V4vH1iXU+5eg1xF8jcaBpF+83pAe2+s=
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
Subject: [PATCH v3 08/16] arm_mpam: propagate MSC read errors for state saving functions
Date: Fri, 10 Jul 2026 16:45:12 +0200
Message-ID: <20260710144520.917375-9-andre.przywara@arm.com>
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

Allow the mpam_save_mbwu_state() function to return an error, and
propagate read errors from the lower level up.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/resctrl/mpam_devices.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index 530ac0fe97b5..b2ecaba29fcc 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -1782,7 +1782,7 @@ static int mpam_save_mbwu_state(void *arg)
 {
 	int i;
 	u64 val;
-	int ret = 0;
+	int ret;
 	struct mon_cfg *cfg;
 	u32 cur_flt, cur_ctl, mon_sel;
 	struct mpam_msc_ris *ris = arg;
@@ -1799,8 +1799,12 @@ static int mpam_save_mbwu_state(void *arg)
 		mon_sel = FIELD_PREP(MSMON_CFG_MON_SEL_MON_SEL, i) |
 			  FIELD_PREP(MSMON_CFG_MON_SEL_RIS, ris->ris_idx);
 		mpam_write_monsel_reg(msc, CFG_MON_SEL, mon_sel);
-		mpam_read_monsel_reg(msc, CFG_MBWU_FLT, &cur_flt);
-		mpam_read_monsel_reg(msc, CFG_MBWU_CTL, &cur_ctl);
+		ret = mpam_read_monsel_reg(msc, CFG_MBWU_FLT, &cur_flt);
+		if (ret)
+			goto out_unlock;
+		ret = mpam_read_monsel_reg(msc, CFG_MBWU_CTL, &cur_ctl);
+		if (ret)
+			goto out_unlock;
 		mpam_write_monsel_reg(msc, CFG_MBWU_CTL, 0);
 
 		if (mpam_ris_has_mbwu_long_counter(ris)) {
@@ -1811,20 +1815,24 @@ static int mpam_save_mbwu_state(void *arg)
 		} else {
 			u32 val32;
 
-			mpam_read_monsel_reg(msc, MBWU, &val32);
+			ret = mpam_read_monsel_reg(msc, MBWU, &val32);
+			if (ret)
+				goto out_unlock;
+
 			val = val32;
 			mpam_write_monsel_reg(msc, MBWU, 0);
 		}
 
-		cfg->mon = i;
-		cfg->pmg = FIELD_GET(MSMON_CFG_x_FLT_PMG, cur_flt);
-		cfg->match_pmg = FIELD_GET(MSMON_CFG_x_CTL_MATCH_PMG, cur_ctl);
-		cfg->partid = FIELD_GET(MSMON_CFG_x_FLT_PARTID, cur_flt);
-		mbwu_state->correction += val;
-		mbwu_state->enabled = FIELD_GET(MSMON_CFG_x_CTL_EN, cur_ctl);
+		if (val != MSMON___L_NRDY) {
+			cfg->mon = i;
+			cfg->pmg = FIELD_GET(MSMON_CFG_x_FLT_PMG, cur_flt);
+			cfg->match_pmg = FIELD_GET(MSMON_CFG_x_CTL_MATCH_PMG, cur_ctl);
+			cfg->partid = FIELD_GET(MSMON_CFG_x_FLT_PARTID, cur_flt);
+			mbwu_state->correction += val;
+			mbwu_state->enabled = FIELD_GET(MSMON_CFG_x_CTL_EN, cur_ctl);
+		}
 		mpam_mon_sel_unlock(msc);
 	}
-
 	return 0;
 
 out_unlock:
-- 
2.43.0

