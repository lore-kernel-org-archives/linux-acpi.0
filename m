Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31E7343D8A;
	Thu,  2 Jul 2026 16:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783009372; cv=none; b=iu4AbFAww8BAmuqC6JhAZj2ZcTwWu0B4/DW9tJoKTP7cUqNu7DKme1KXfxD+63TJ+8aO34Jv1b3pQbmVt7n4ZO8KXG1zUJoYrHlf67GEve8i6hruuWwASTmrtkbBLsNMbr/eDOtDR5g6PWnd+HcCEBr/yzTK8cKeC4FiihwfQwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783009372; c=relaxed/simple;
	bh=7qjci2iIVbAXAhbMTcthtv0y9ebcxOyVKtQNj6luUuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gWbjPqdkhnZ5xrkRUf5cmjqEJ3AzNg54GAYfmuiLv9l0IU0zthOMIGVN8nUV5kfhQEvdtLZZha1aShZElToHleH1qZnCedVruNy+ihH9SFQ0NAudAeX7oSheWxApyUsB1hfZ1W3pmoLGfvzjoTKhXWhlhJ1wGXdu+APTo6iNBU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lBbL6rMj; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lBbL6rMj"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8135235B7;
	Thu,  2 Jul 2026 09:22:43 -0700 (PDT)
Received: from e142021.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 290333F673;
	Thu,  2 Jul 2026 09:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783009367; bh=7qjci2iIVbAXAhbMTcthtv0y9ebcxOyVKtQNj6luUuE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lBbL6rMjFQEQyG9xrzuTJ4n8pNDUKlJt42cPO2CfJNQFnjcaXjTlNmBuB5gciAgm0
	 tcf5wU4i0WZr3N0/ADWNTjRdYXztg1zPeflU2dloah37I1OFDiR3ZDgkD1G4/cDoSi
	 ma8jEoue1pVybtN1IQqoK0hCqEeupcApDcuwxJJw=
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
Subject: [PATCH v2 02/15] arm_mpam: propagate MSC read errors for wrapper functions
Date: Thu,  2 Jul 2026 18:22:16 +0200
Message-ID: <20260702162229.4008659-3-andre.przywara@arm.com>
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

Allow the wrapper functions for IDR and ESR accesses to return an
error, and propagate read errors from the lower level up.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/resctrl/mpam_devices.c | 51 +++++++++++++++++++++++-----------
 1 file changed, 35 insertions(+), 16 deletions(-)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index df14b4513382..ce8738adb6ff 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -247,27 +247,34 @@ static bool mpam_msc_check_aidr(struct mpam_msc *msc)
 	return true;
 }
 
-static u64 mpam_msc_read_idr(struct mpam_msc *msc)
+static int mpam_msc_read_idr(struct mpam_msc *msc, u64 *res)
 {
 	u32 idr_high = 0, idr_low;
+	int ret;
 
 	lockdep_assert_held(&msc->part_sel_lock);
 
-	mpam_read_partsel_reg(msc, IDR, &idr_low);
-	if (FIELD_GET(MPAMF_IDR_EXT, idr_low))
-		mpam_read_partsel_reg(msc, IDR + 4, &idr_high);
+	ret = mpam_read_partsel_reg(msc, IDR, &idr_low);
+	if (!ret && FIELD_GET(MPAMF_IDR_EXT, idr_low))
+		ret = mpam_read_partsel_reg(msc, IDR + 4, &idr_high);
 
-	return ((u64)idr_high << 32) | idr_low;
+	if (!ret)
+		*res = ((u64)idr_high << 32) | idr_low;
+
+	return ret;
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
@@ -277,18 +284,30 @@ static void mpam_msc_clear_esr(struct mpam_msc *msc)
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
 
-	return ((u64)esr_high << 32) | esr_low;
+	*res = ((u64)esr_high << 32) | esr_low;
+
+	return 0;
 }
 
 static void __mpam_part_sel_raw(u32 partsel, struct mpam_msc *msc)
@@ -993,7 +1012,7 @@ static int mpam_msc_hw_probe(struct mpam_msc *msc)
 
 	/* Grab an IDR value to find out how many RIS there are */
 	mutex_lock(&msc->part_sel_lock);
-	idr = mpam_msc_read_idr(msc);
+	mpam_msc_read_idr(msc, &idr);
 	mpam_read_partsel_reg(msc, IIDR, &msc->iidr);
 
 	mutex_unlock(&msc->part_sel_lock);
@@ -1009,7 +1028,7 @@ static int mpam_msc_hw_probe(struct mpam_msc *msc)
 	for (ris_idx = 0; ris_idx <= msc->ris_max; ris_idx++) {
 		mutex_lock(&msc->part_sel_lock);
 		__mpam_part_sel(ris_idx, 0, msc);
-		idr = mpam_msc_read_idr(msc);
+		mpam_msc_read_idr(msc, &idr);
 		mutex_unlock(&msc->part_sel_lock);
 
 		partid_max = FIELD_GET(MPAMF_IDR_PARTID_MAX, idr);
@@ -2492,7 +2511,7 @@ static irqreturn_t __mpam_irq_handler(int irq, struct mpam_msc *msc)
 					   &msc->accessibility)))
 		return IRQ_NONE;
 
-	reg = mpam_msc_read_esr(msc);
+	mpam_msc_read_esr(msc, &reg);
 
 	errcode = FIELD_GET(MPAMF_ESR_ERRCODE, reg);
 	if (!errcode)
-- 
2.43.0

