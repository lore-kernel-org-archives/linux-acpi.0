Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971234C77CA;
	Thu, 23 Jul 2026 15:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784822125; cv=none; b=upFY1TBmPIWjmgXgIHET+b/gpQQ/sQ4XFHVIgCkOe/LHmiZJBa99ifUrjki1LX2bVJb8S+A04sDr2hH3QlSQDOGoIRI/ZSgvgk8mDKQhXTixLq8AaqPunnwMtfV4aZtfj79lojjJODz9eaxjBNUqNCPo7Rmby2R240ngVwMauyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784822125; c=relaxed/simple;
	bh=zuii4y3ZJEsm4812TF2ly2vpc/bQP8awGaQF3cHeW2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ys0m5GNi8+LpPI0iHm2ktqKZXXYItOkUYrv7lVwHBx3cgF4xq0y/RZ6+vMlvGl7aR1COiKrIs5TqwTlND1bE6CJJMCjlO/AkCweRT3E/4eTuB6EV/TSDm2J3/xjA0Y77WdtL2LSOhYL/bEf8GUo/K31mBx/eSZs5Ax5eIlwD2hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=B1p47kdn; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="B1p47kdn"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD91D176A;
	Thu, 23 Jul 2026 08:55:18 -0700 (PDT)
Received: from e142021.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 78E4C3F66F;
	Thu, 23 Jul 2026 08:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784822122; bh=zuii4y3ZJEsm4812TF2ly2vpc/bQP8awGaQF3cHeW2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B1p47kdnYLlMlEOvDF7EeUClQq+qwW1K8JHUITjYfSp2J5KEGVUdJyCaYpmJi2RnO
	 uv6VYIUFQv/venwh0oXEZnUDhsItAt9WNczRsVwS11WhxcGHojakSThvpPMbf9vdCM
	 RsV40R2bPaHKQZE2VavexMvvKxyPAFYH0hsswoQk=
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
Subject: [PATCH v4 06/10] arm_mpam: propagate MSC access errors for state saving function
Date: Thu, 23 Jul 2026 17:54:50 +0200
Message-ID: <20260723155454.1760823-7-andre.przywara@arm.com>
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

Allow the mpam_save_mbwu_state() function to return an error, and
propagate read and write errors from the lower level up.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/resctrl/mpam_devices.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index bcff53477133..6329443c451f 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -1833,22 +1833,37 @@ static int mpam_save_mbwu_state(void *arg)
 
 		mon_sel = FIELD_PREP(MSMON_CFG_MON_SEL_MON_SEL, i) |
 			  FIELD_PREP(MSMON_CFG_MON_SEL_RIS, ris->ris_idx);
-		mpam_write_monsel_reg(msc, CFG_MON_SEL, mon_sel);
-		mpam_read_monsel_reg(msc, CFG_MBWU_FLT, &cur_flt);
-		mpam_read_monsel_reg(msc, CFG_MBWU_CTL, &cur_ctl);
-		mpam_write_monsel_reg(msc, CFG_MBWU_CTL, 0);
+		ret = mpam_write_monsel_reg(msc, CFG_MON_SEL, mon_sel);
+		if (ret)
+			return ret;
+		ret = mpam_read_monsel_reg(msc, CFG_MBWU_FLT, &cur_flt);
+		if (ret)
+			return ret;
+		ret = mpam_read_monsel_reg(msc, CFG_MBWU_CTL, &cur_ctl);
+		if (ret)
+			return ret;
+		ret = mpam_write_monsel_reg(msc, CFG_MBWU_CTL, 0);
+		if (ret)
+			return ret;
 
 		if (mpam_ris_has_mbwu_long_counter(ris)) {
 			ret = mpam_msc_read_mbwu_l(msc, &val);
 			if (ret)
 				return ret;
-			mpam_msc_zero_mbwu_l(msc);
+			ret = mpam_msc_zero_mbwu_l(msc);
+			if (ret)
+				return ret;
 		} else {
 			u32 val32;
 
-			mpam_read_monsel_reg(msc, MBWU, &val32);
+			ret = mpam_read_monsel_reg(msc, MBWU, &val32);
+			if (ret)
+				return ret;
+
 			val = val32;
-			mpam_write_monsel_reg(msc, MBWU, 0);
+			ret = mpam_write_monsel_reg(msc, MBWU, 0);
+			if (ret)
+				return ret;
 		}
 
 		cfg->mon = i;
-- 
2.43.0

