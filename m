Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788CC3F076F;
	Fri, 10 Jul 2026 14:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783694747; cv=none; b=VboQcfPcWd6TfefKNDWYWVkDXQwqajKagpJDWXb9yTUXD/BhLepB0+poiSJiFdidA+o/8G1I3sj7Ekp0w1YE80o9rIlivC0JR7ZSbDgW/qdZta6KCmBbudt4RhDCLwCzm/i4frj7B8MumBGsQ4Ld/3q3BjLSjKgA9PhzRCpZI3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783694747; c=relaxed/simple;
	bh=Glz8LzX3zk2vWrmjd7S5X4lLU9dPz4aZD0bvZAMR3Q0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rh2+VA+qthNN6nliE4dhra7Huaf5RzM8/WJgr/zlkBoS+yRLVBEO924Wz+F4b9AOGUMmO8MTa9XGcp10vtlY8xQlWK+wcL3xCOJQCpCjGowRTbQ2zFJZr7EmVvKybdbi3KR8juODTSHcD6rGS+4d4OtO46cPcGRWr0zOUH0/OuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=APLYNibS; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="APLYNibS"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D04E176A;
	Fri, 10 Jul 2026 07:45:34 -0700 (PDT)
Received: from e142021.munich.arm.com (e142021.arm.com [10.41.150.148])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 011403F7B4;
	Fri, 10 Jul 2026 07:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783694738; bh=Glz8LzX3zk2vWrmjd7S5X4lLU9dPz4aZD0bvZAMR3Q0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=APLYNibS8Zs4tA8iXFqrZ3XUJQBnJXuG4Fkgyy3FbLQbzL0YwEzf6xEL6tI8VggFd
	 fVK1rdwiTG+TX86kdFFtpk8kRWSvEaXal8kes89YaTRKOuSFpyK6wCx0f2mg+ZS5Y6
	 qaLNPDBh0+5dABPt2heuS0j9kO/xOS3KMNRusE3M=
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
Subject: [PATCH v3 02/16] arm_mpam: propagate MSC read errors for wrapper functions
Date: Fri, 10 Jul 2026 16:45:06 +0200
Message-ID: <20260710144520.917375-3-andre.przywara@arm.com>
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

Allow the wrapper functions for IDR and ESR accesses to return an
error, and propagate read errors from the lower level up.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/resctrl/mpam_devices.c | 53 ++++++++++++++++++++++++----------
 1 file changed, 38 insertions(+), 15 deletions(-)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index df14b4513382..8fd2c38c821c 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -247,27 +247,38 @@ static bool mpam_msc_check_aidr(struct mpam_msc *msc)
 	return true;
 }
 
-static u64 mpam_msc_read_idr(struct mpam_msc *msc)
+static int mpam_msc_read_idr(struct mpam_msc *msc, u64 *res)
 {
 	u32 idr_high = 0, idr_low;
+	int ret;
 
 	lockdep_assert_held(&msc->part_sel_lock);
 
-	mpam_read_partsel_reg(msc, IDR, &idr_low);
+	ret = mpam_read_partsel_reg(msc, IDR, &idr_low);
+	if (ret)
+		return ret;
+
 	if (FIELD_GET(MPAMF_IDR_EXT, idr_low))
-		mpam_read_partsel_reg(msc, IDR + 4, &idr_high);
+		ret = mpam_read_partsel_reg(msc, IDR + 4, &idr_high);
+	if (ret)
+		return ret;
+
+	*res = ((u64)idr_high << 32) | idr_low;
 
-	return ((u64)idr_high << 32) | idr_low;
+	return 0;
 }
 
-static void mpam_msc_clear_esr(struct mpam_msc *msc)
+static int mpam_msc_clear_esr(struct mpam_msc *msc)
 {
 	u32 esr_low;
+	int ret;
 
-	__mpam_read_reg(msc, MPAMF_ESR, &esr_low);
+	ret = __mpam_read_reg(msc, MPAMF_ESR, &esr_low);
+	if (ret)
+		return ret;
 
 	if (!esr_low)
-		return;
+		return 0;
 
 	/*
 	 * Clearing the high/low bits of MPAMF_ESR can not be atomic.
@@ -277,18 +288,30 @@ static void mpam_msc_clear_esr(struct mpam_msc *msc)
 	 */
 	if (msc->has_extd_esr)
 		__mpam_write_reg(msc, MPAMF_ESR + 4, 0);
+
 	__mpam_write_reg(msc, MPAMF_ESR, 0);
+
+	return 0;
 }
 
-static u64 mpam_msc_read_esr(struct mpam_msc *msc)
+static int mpam_msc_read_esr(struct mpam_msc *msc, u64 *res)
 {
 	u32 esr_high = 0, esr_low;
+	int ret;
 
-	__mpam_read_reg(msc, MPAMF_ESR, &esr_low);
-	if (msc->has_extd_esr)
-		__mpam_read_reg(msc, MPAMF_ESR + 4, &esr_high);
+	ret = __mpam_read_reg(msc, MPAMF_ESR, &esr_low);
+	if (ret)
+		return ret;
+
+	if (msc->has_extd_esr) {
+		ret = __mpam_read_reg(msc, MPAMF_ESR + 4, &esr_high);
+		if (ret)
+			return ret;
+	}
+
+	*res = ((u64)esr_high << 32) | esr_low;
 
-	return ((u64)esr_high << 32) | esr_low;
+	return 0;
 }
 
 static void __mpam_part_sel_raw(u32 partsel, struct mpam_msc *msc)
@@ -993,7 +1016,7 @@ static int mpam_msc_hw_probe(struct mpam_msc *msc)
 
 	/* Grab an IDR value to find out how many RIS there are */
 	mutex_lock(&msc->part_sel_lock);
-	idr = mpam_msc_read_idr(msc);
+	mpam_msc_read_idr(msc, &idr);
 	mpam_read_partsel_reg(msc, IIDR, &msc->iidr);
 
 	mutex_unlock(&msc->part_sel_lock);
@@ -1009,7 +1032,7 @@ static int mpam_msc_hw_probe(struct mpam_msc *msc)
 	for (ris_idx = 0; ris_idx <= msc->ris_max; ris_idx++) {
 		mutex_lock(&msc->part_sel_lock);
 		__mpam_part_sel(ris_idx, 0, msc);
-		idr = mpam_msc_read_idr(msc);
+		mpam_msc_read_idr(msc, &idr);
 		mutex_unlock(&msc->part_sel_lock);
 
 		partid_max = FIELD_GET(MPAMF_IDR_PARTID_MAX, idr);
@@ -2492,7 +2515,7 @@ static irqreturn_t __mpam_irq_handler(int irq, struct mpam_msc *msc)
 					   &msc->accessibility)))
 		return IRQ_NONE;
 
-	reg = mpam_msc_read_esr(msc);
+	mpam_msc_read_esr(msc, &reg);
 
 	errcode = FIELD_GET(MPAMF_ESR_ERRCODE, reg);
 	if (!errcode)
-- 
2.43.0

