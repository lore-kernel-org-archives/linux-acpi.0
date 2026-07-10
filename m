Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A544430CCA;
	Fri, 10 Jul 2026 14:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783694776; cv=none; b=R1n0dWpFXPxORpRx+z9K4CtRfeTiR7GSgHyCoHWQKWzCZDHj3wt/XZdB6MfBjwUq4/Ncw+9mwza1gWrkTsA2HCpFxZY2pJhPPf72GWhVnuXiiKjKlSc6irgfCF6Z4PVv6AsTtNxKnVVAm+oN6T0e+rGW2CNNUwAxFjKixOVQR2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783694776; c=relaxed/simple;
	bh=ogl0fMh5WU6VJSws2gIeOWaSXLclkidHw1Ey9bZ1MlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A+dg/AjMeg1WtgWXQ4XokH23oBI/0KNNK+Y/gpm0u5hNHEg8fgZNYcJ7yd7ovcYlNszKI1wTvOTB3kUGNkKItvHxQzAwdoBkxeVSfog8P8OypkLpBg6qEwkIMbw4LMluotlZOssrbZeRpbSrhAzsXEq8ZyW2NiAVUbE2cvv7N04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=m78dra9N; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="m78dra9N"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5AF671E7D;
	Fri, 10 Jul 2026 07:46:09 -0700 (PDT)
Received: from e142021.munich.arm.com (e142021.arm.com [10.41.150.148])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B238D3F7B4;
	Fri, 10 Jul 2026 07:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783694773; bh=ogl0fMh5WU6VJSws2gIeOWaSXLclkidHw1Ey9bZ1MlI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m78dra9NtYDCz3Pc8dqfPXL1nq02ONMHAzrEYB0LhGwj7ofWsi8YUfWMj2nLyTFtL
	 9GSYUo4qzJ3c/W/sqafPp7mgLoiRRqwIsicmbUl25fNZsttlHQlLoRI+IZtCGuWNyE
	 AydYSQH+X3fD0iderBLIt/0ubxLkl1PV30X8EsLs=
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
Subject: [PATCH v3 10/16] arm_mpam: propagate MSC write errors for ESR and part_sel wrappers
Date: Fri, 10 Jul 2026 16:45:14 +0200
Message-ID: <20260710144520.917375-11-andre.przywara@arm.com>
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

Allow the wrapper functions for part_sel and ESR accesses to return an
error, and propagate write errors from the lower level up.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/resctrl/mpam_devices.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index f1e40ce24f5a..5a9760372666 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -288,12 +288,13 @@ static int mpam_msc_clear_esr(struct mpam_msc *msc)
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
@@ -316,28 +317,28 @@ static int mpam_msc_read_esr(struct mpam_msc *msc, u64 *res)
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

