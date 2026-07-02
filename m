Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34FF331EB6;
	Thu,  2 Jul 2026 16:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783009402; cv=none; b=Pr0BOiP1UnY9TLafKNlEIteWq3/6BUf9/mrepy9/EZqL2PK4sm9e7eM389GciEgMJcnruh9cVw4uyo/q0x6JYHVXZH4Goqv57SI3mAp5PFldaXPCdaXpGAafDMfnk3NIw+hJE1AfVd4ywp4P0dl+lL1/vUyazsjJAZpwwpBO0Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783009402; c=relaxed/simple;
	bh=dZiEdTB3o3jmleqxpeAia+GhpwalEnJMVJVBkq1ZCrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TCQC6oUq8R1JogLanMtug2lc1az/757xtKb3hVREKQ/3loA8heIKcT6q7sMAytDW8mVeSLaXOguBo3P4l0fQFCjhBk0FrsfShoPiLRNAE8SDPHe4Sn6Fv7tfJjDrDqDuhYcYu4luzv6cVtcfd23CgMDYY6U6NOI4ZF7gZ7fy8eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=CWcqo4cx; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="CWcqo4cx"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71F7B1570;
	Thu,  2 Jul 2026 09:23:12 -0700 (PDT)
Received: from e142021.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 176763F673;
	Thu,  2 Jul 2026 09:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783009396; bh=dZiEdTB3o3jmleqxpeAia+GhpwalEnJMVJVBkq1ZCrg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CWcqo4cxGEbVuGYj7aD8wtSREfr+jF4ESUoTevZGei2zVKlcJk56SQGWqC+XG/qVp
	 fCrBzDe0ArxDGnxLZpZRtSlHBC+oMrShCTWuryS6HH/HF1aRgKU/3cyb25Y45R1M5q
	 DsNO/f/tJ2AvwzOphAio891wbvXS1a3KbUEgoiGg=
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
Subject: [PATCH v2 09/15] arm_mpam: propagate MSC write errors for ESR and part_sel wrappers
Date: Thu,  2 Jul 2026 18:22:23 +0200
Message-ID: <20260702162229.4008659-10-andre.przywara@arm.com>
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

Allow the wrapper functions for part_sel and ESR accesses to return an
error, and propagate write errors from the lower level up.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/resctrl/mpam_devices.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index a7adc75a079c..23a5deb290b3 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -284,12 +284,13 @@ static int mpam_msc_clear_esr(struct mpam_msc *msc)
 	 * lower half prevent hardware from updating either half of the
 	 * register.
 	 */
-	if (msc->has_extd_esr)
-		__mpam_write_reg(msc, MPAMF_ESR + 4, 0);
-
-	__mpam_write_reg(msc, MPAMF_ESR, 0);
+	if (msc->has_extd_esr) {
+		ret = __mpam_write_reg(msc, MPAMF_ESR + 4, 0);
+		if (ret)
+			return ret;
+	}
 
-	return 0;
+	return __mpam_write_reg(msc, MPAMF_ESR, 0);
 }
 
 static int mpam_msc_read_esr(struct mpam_msc *msc, u64 *res)
@@ -312,28 +313,28 @@ static int mpam_msc_read_esr(struct mpam_msc *msc, u64 *res)
 	return 0;
 }
 
-static void __mpam_part_sel_raw(u32 partsel, struct mpam_msc *msc)
+static int __mpam_part_sel_raw(u32 partsel, struct mpam_msc *msc)
 {
 	lockdep_assert_held(&msc->part_sel_lock);
 
-	mpam_write_partsel_reg(msc, PART_SEL, partsel);
+	return mpam_write_partsel_reg(msc, PART_SEL, partsel);
 }
 
-static void __mpam_part_sel(u8 ris_idx, u16 partid, struct mpam_msc *msc)
+static int __mpam_part_sel(u8 ris_idx, u16 partid, struct mpam_msc *msc)
 {
 	u32 partsel = FIELD_PREP(MPAMCFG_PART_SEL_RIS, ris_idx) |
 		      FIELD_PREP(MPAMCFG_PART_SEL_PARTID_SEL, partid);
 
-	__mpam_part_sel_raw(partsel, msc);
+	return __mpam_part_sel_raw(partsel, msc);
 }
 
-static void __mpam_intpart_sel(u8 ris_idx, u16 intpartid, struct mpam_msc *msc)
+static int __mpam_intpart_sel(u8 ris_idx, u16 intpartid, struct mpam_msc *msc)
 {
 	u32 partsel = FIELD_PREP(MPAMCFG_PART_SEL_RIS, ris_idx) |
 		      FIELD_PREP(MPAMCFG_PART_SEL_PARTID_SEL, intpartid) |
 		      MPAMCFG_PART_SEL_INTERNAL;
 
-	__mpam_part_sel_raw(partsel, msc);
+	return __mpam_part_sel_raw(partsel, msc);
 }
 
 int mpam_register_requestor(u16 partid_max, u8 pmg_max)
-- 
2.43.0

