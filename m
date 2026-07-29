Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12455496906;
	Wed, 29 Jul 2026 13:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785332524; cv=none; b=FvGLKSnuREEUNDv1N2XJ/MFUnogkZ5oSiZpWzAX3fkT0rz9jagqWYy8MwSynocoMLfP+0akwfTi8a+sHGwBS/V75knggVohWusvfV6ucu2Hejggm5zm2b/P2BmhJhM/TsmBrTjyJtRAF7taATqY0xtT4RA6cOfQQgWka5grWxXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785332524; c=relaxed/simple;
	bh=9z9NU4rclo/l5DJELjzybhVW3IFJ+hEU2wBrmc8WBMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y2bAXpG43qkASdFovVdh/zi52f8E9SLcNZz3ARKbSwfSc1Sd71fymk9M2yim45Jbu3WhjBK+rA5PlNwsFL43BBSRIBXzzzCtqxynjzXnDMdHJG+97Lprhe/Sbtu45qB7KtNVsK6yV7nPG+cRlfyfYmHM29VOw7w9Z7rBNph6HnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=HTZZISDF; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="HTZZISDF"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 23DF01688;
	Wed, 29 Jul 2026 06:41:58 -0700 (PDT)
Received: from e142021.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4DBD83F86F;
	Wed, 29 Jul 2026 06:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785332522; bh=9z9NU4rclo/l5DJELjzybhVW3IFJ+hEU2wBrmc8WBMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HTZZISDF/YdbiYrpf+au47eIaoXgWWS9Yo63IKEclbJJgw3lxAMdveefkq2C9KNGe
	 BwdDq1ijiJFjmFA4a0MdpqjbzO+IyOmSLH1maeI43BEj0VC0DSM2JdIkIR0lpD+Aop
	 561kWEYWDAtDlHg+m75zyT2iRcBVakr0rpDuWYtM=
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
Subject: [PATCH v5 06/10] arm_mpam: propagate MSC access errors for state saving function
Date: Wed, 29 Jul 2026 15:41:20 +0200
Message-ID: <20260729134124.2506269-7-andre.przywara@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729134124.2506269-1-andre.przywara@arm.com>
References: <20260729134124.2506269-1-andre.przywara@arm.com>
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
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/resctrl/mpam_devices.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index 44eafef1e7ab..9b6d266b4fa6 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -1838,22 +1838,37 @@ static int mpam_save_mbwu_state(void *arg)
 
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

