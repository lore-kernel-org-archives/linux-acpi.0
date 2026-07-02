Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61B6353A94;
	Thu,  2 Jul 2026 16:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783009392; cv=none; b=Vd4eljaXjAFDH2rfmYL/pmfCDVikF8r1i/b+HktcgI9YqHEDFNlbxvFYhQuCXBd1kLwKUbdS007lSUPbpuxSZr/MkWUtzyrpVYEqdTqaefF2Mu9lPcI7eR+SKC6/r2XyLdGLdgWTvQ73ZlVyRxYMHZm363SZMKJACkA0LKZ8r7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783009392; c=relaxed/simple;
	bh=kEvUNv9TDnlTrcE5k7Pm1MvIytY9hUUE7m5Rs28ExKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eESmxUKnMEno5MEZHfBXo63qryiT9CDt7QPPL/SDc2wiUTdP0VUBX+OKHwXPA/WozFgy1KC2v1B+Yxsl8zjmnN612YLgfPEnXTU4A98t7+kbiNv/txLd2nV51O2AnbWbOJAHSQBj6erJ3MNZBHsfDBADXjzflftBy0SD4Q5FqnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=QdIYOnme; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="QdIYOnme"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2FD3935C8;
	Thu,  2 Jul 2026 09:23:04 -0700 (PDT)
Received: from e142021.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C91DA3F673;
	Thu,  2 Jul 2026 09:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783009388; bh=kEvUNv9TDnlTrcE5k7Pm1MvIytY9hUUE7m5Rs28ExKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QdIYOnme/DnUjEmWzeUNK6ASpHR6SGo/287x9A4/W1uA3GWMH7mEfCDRVseFNcVoU
	 Hvf3RU2VCrLdV//421ADRgtJrKzb95kGpY7tdGLrJwaXqtdp0+/RgFQ+0XJURiIZoU
	 QguGGcyupZWoiOmAImNVrknU0r8yCq/tN+XcpPAw=
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
Subject: [PATCH v2 07/15] arm_mpam: propagate MSC read errors for state saving functions
Date: Thu,  2 Jul 2026 18:22:21 +0200
Message-ID: <20260702162229.4008659-8-andre.przywara@arm.com>
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

Allow the mpam_save_mbwu_state() function to return an error, and
propagate read errors from the lower level up.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/resctrl/mpam_devices.c | 47 +++++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 18 deletions(-)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index d18c7be86aaa..c50ca0e4f426 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -1773,6 +1773,7 @@ static int mpam_save_mbwu_state(void *arg)
 {
 	int i;
 	u64 val;
+	int ret;
 	struct mon_cfg *cfg;
 	u32 cur_flt, cur_ctl, mon_sel;
 	struct mpam_msc_ris *ris = arg;
@@ -1789,31 +1790,41 @@ static int mpam_save_mbwu_state(void *arg)
 		mon_sel = FIELD_PREP(MSMON_CFG_MON_SEL_MON_SEL, i) |
 			  FIELD_PREP(MSMON_CFG_MON_SEL_RIS, ris->ris_idx);
 		mpam_write_monsel_reg(msc, CFG_MON_SEL, mon_sel);
-		mpam_read_monsel_reg(msc, CFG_MBWU_FLT, &cur_flt);
-		mpam_read_monsel_reg(msc, CFG_MBWU_CTL, &cur_ctl);
-		mpam_write_monsel_reg(msc, CFG_MBWU_CTL, 0);
+		ret = mpam_read_monsel_reg(msc, CFG_MBWU_FLT, &cur_flt);
+		if (!ret)
+			ret = mpam_read_monsel_reg(msc, CFG_MBWU_CTL, &cur_ctl);
+		if (!ret)
+			mpam_write_monsel_reg(msc, CFG_MBWU_CTL, 0);
 
-		if (mpam_ris_has_mbwu_long_counter(ris)) {
-			val = mpam_msc_read_mbwu_l(msc);
-			mpam_msc_zero_mbwu_l(msc);
-		} else {
-			u32 val32;
+		if (!ret) {
+			if (mpam_ris_has_mbwu_long_counter(ris)) {
+				val = mpam_msc_read_mbwu_l(msc);
+				mpam_msc_zero_mbwu_l(msc);
+			} else {
+				u32 val32;
 
-			mpam_read_monsel_reg(msc, MBWU, &val32);
-			val = val32;
-			mpam_write_monsel_reg(msc, MBWU, 0);
+				ret = mpam_read_monsel_reg(msc, MBWU, &val32);
+				if (!ret) {
+					val = val32;
+					mpam_write_monsel_reg(msc, MBWU, 0);
+				}
+			}
 		}
 
-		cfg->mon = i;
-		cfg->pmg = FIELD_GET(MSMON_CFG_x_FLT_PMG, cur_flt);
-		cfg->match_pmg = FIELD_GET(MSMON_CFG_x_CTL_MATCH_PMG, cur_ctl);
-		cfg->partid = FIELD_GET(MSMON_CFG_x_FLT_PARTID, cur_flt);
-		mbwu_state->correction += val;
-		mbwu_state->enabled = FIELD_GET(MSMON_CFG_x_CTL_EN, cur_ctl);
+		if (!ret && val != MSMON___L_NRDY) {
+			cfg->mon = i;
+			cfg->pmg = FIELD_GET(MSMON_CFG_x_FLT_PMG, cur_flt);
+			cfg->match_pmg = FIELD_GET(MSMON_CFG_x_CTL_MATCH_PMG, cur_ctl);
+			cfg->partid = FIELD_GET(MSMON_CFG_x_FLT_PARTID, cur_flt);
+			mbwu_state->correction += val;
+			mbwu_state->enabled = FIELD_GET(MSMON_CFG_x_CTL_EN, cur_ctl);
+		}
 		mpam_mon_sel_unlock(msc);
+		if (ret)
+			break;
 	}
 
-	return 0;
+	return ret;
 }
 
 /*
-- 
2.43.0

