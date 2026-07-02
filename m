Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCBD33F5BC;
	Thu,  2 Jul 2026 16:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783009387; cv=none; b=Fs9k5bc6oaaFBj6Yi+YgA9LiU1K/86ha9bmJ92nMhr3QAQdvUPXvX5AqBTrf+RYppOvtoTwasENfAoJFRdq0qFc+MKjjYa0qbQCwKcwAGig0z2Ksyk5B0hB/mOZuiBw6jv3NLAORme3Ta7N23P9Tp65nRz9OZiI3EPnopqu6zb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783009387; c=relaxed/simple;
	bh=Yj/qiqCuDrztdPO9H7QAPgd9Fj2LM4WqBGpJ969IKzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NWkuinpYdHZoc+TNEfbQDisSzZGT9HVleMIi5sQGhWzZCG1SGNsTc+5NKQJoebwRYW0fhOEYymVViHLDJ1MoCPPSm/K5jQQDs9rg31rHXr9wVgA9C1OEsBX8yn7Bz0pwi3Sw3NQQlFNvldLC7iOcgfnJ/BqzljgBIKPxHTAxayQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=FGbnlpNz; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="FGbnlpNz"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2EE935CB;
	Thu,  2 Jul 2026 09:22:55 -0700 (PDT)
Received: from e142021.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B11A3F673;
	Thu,  2 Jul 2026 09:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783009380; bh=Yj/qiqCuDrztdPO9H7QAPgd9Fj2LM4WqBGpJ969IKzY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FGbnlpNzENa9BMHtOpMyNULrmIZ6/StiiucbAhWkYoaUkANrLX5r+Lk0I7KU/ZVwH
	 luJIAILEZ/klpOWZeecoLvF1AMfp2QsMSE/lPgGOeeJAU3DDzLt12HXH/+er8Vcyv+
	 6zT0mxGDegfetS2jJmpodxWEYucSD6/PEnE+Exgw=
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
Subject: [PATCH v2 05/15] arm_mpam: propagate MSC read errors for msmon helpers
Date: Thu,  2 Jul 2026 18:22:19 +0200
Message-ID: <20260702162229.4008659-6-andre.przywara@arm.com>
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

Allow the helper functions for msmon accesses to return an error, and
propagate read errors from the lower level up.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/resctrl/mpam_devices.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index 1d06902fb970..b259fe20a614 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -1189,25 +1189,31 @@ static void gen_msmon_ctl_flt_vals(struct mon_read *m, u32 *ctl_val,
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

