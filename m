Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5DB42B310;
	Fri, 10 Jul 2026 14:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783694757; cv=none; b=eu48ySKSeFTGFU8Pyi07nOZupVPUvc51PA9dK0gRehsRr/PoYQYwqje8qXYTbS2qm8sKJU1KnoGnohC7TKVZNrBV+iYQt29F213K2fMeSBqtKy412bWtGb0P5hkNg9MxFdfxmGvOzBhG3O8o6RwHyBSRHrTFkzD3DK1Ep/f0d5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783694757; c=relaxed/simple;
	bh=BPxv+t0VViUKFXPtmOsQP33qwPps3qePapUb2dPAJr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I68BdHxw+rZHpgpcL7QpmyiT2lEhAGxBjanIxu8aera86NPB/oQYoAFrf8UtQFO0AfRAiQvVTZSMCwBP6m8vDouYUMo7pOAyo1zl8Pt8z2xg7YxdMXLd+IDn8Ka7HHdP7TAzdJugHkCmvP1Bmr2xRUHqCUAfRmC6pAd4LG3yEiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=S7qa2+Og; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="S7qa2+Og"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A1DAB1BC0;
	Fri, 10 Jul 2026 07:45:47 -0700 (PDT)
Received: from e142021.munich.arm.com (e142021.arm.com [10.41.150.148])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0761F3F7B4;
	Fri, 10 Jul 2026 07:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783694751; bh=BPxv+t0VViUKFXPtmOsQP33qwPps3qePapUb2dPAJr0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S7qa2+Ogvysj8BsMs9OFRbo9CovDtBvEitSK2ZR+SR6T3p8miSzjCZB1j/IGnTjMv
	 aH0SjpzcY3Hpk6ZMP7tk8n3/UL4MCgKYgleoNX+WUio34SLyl8Q7UUPBiAo5vBy4qL
	 QdQyeAh+NUGVGvd1V68PQ30MDZw4LMYnUTJIeT08=
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
Subject: [PATCH v3 05/16] arm_mpam: propagate MSC read errors for msmon helpers
Date: Fri, 10 Jul 2026 16:45:09 +0200
Message-ID: <20260710144520.917375-6-andre.przywara@arm.com>
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

Allow the helper functions for msmon accesses to return an error, and
propagate read errors from the lower level up.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/resctrl/mpam_devices.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index 3b6f9e552a9f..041fca018e68 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -1201,25 +1201,31 @@ static void gen_msmon_ctl_flt_vals(struct mon_read *m, u32 *ctl_val,
 	}
 }
 
-static void read_msmon_ctl_flt_vals(struct mon_read *m, u32 *ctl_val,
-				    u32 *flt_val)
+static int read_msmon_ctl_flt_vals(struct mon_read *m, u32 *ctl_val,
+				   u32 *flt_val)
 {
 	struct mpam_msc *msc = m->ris->vmsc->msc;
+	int ret;
 
 	switch (m->type) {
 	case mpam_feat_msmon_csu:
-		mpam_read_monsel_reg(msc, CFG_CSU_CTL, ctl_val);
-		mpam_read_monsel_reg(msc, CFG_CSU_FLT, flt_val);
+		ret = mpam_read_monsel_reg(msc, CFG_CSU_CTL, ctl_val);
+		if (!ret)
+			ret = mpam_read_monsel_reg(msc, CFG_CSU_FLT, flt_val);
 		break;
 	case mpam_feat_msmon_mbwu_31counter:
 	case mpam_feat_msmon_mbwu_44counter:
 	case mpam_feat_msmon_mbwu_63counter:
-		mpam_read_monsel_reg(msc, CFG_MBWU_CTL, ctl_val);
-		mpam_read_monsel_reg(msc, CFG_MBWU_FLT, flt_val);
+		ret = mpam_read_monsel_reg(msc, CFG_MBWU_CTL, ctl_val);
+		if (!ret)
+			ret = mpam_read_monsel_reg(msc, CFG_MBWU_FLT, flt_val);
 		break;
 	default:
 		pr_warn("Unexpected monitor type %d\n", m->type);
+		return -EINVAL;
 	}
+
+	return ret;
 }
 
 /* Remove values set by the hardware to prevent apparent mismatches. */
-- 
2.43.0

