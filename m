Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F293FFAC0;
	Wed, 29 Apr 2026 14:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777472093; cv=none; b=hr918e58uy1ZGhL5739YD5w/XWH3rmekNn2iKYN4Xy9gpAaqdb73t/B7ALhx5JrSbMsyRHUpCvMhHDNd2f8ZQtLlCg/gO3kanb8sZrdDrKvVLsnl1U5F2MH6cdX3DuFz9R59WUW1Ma3PHvpEQ1KwjVk05hMppC2DHBLraPkwmQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777472093; c=relaxed/simple;
	bh=wnINJ4qqC5jjasrgT/cw8BNQc6KV8jan1/3jpxXMVaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GoL3YwUXLV/afi9d1lAdOVqJeiI3xLqjrU5OS3RbO/w5x1SffRRSeojdx7BzwTs0X1e3sgTfbXX7bZfBKB8U+f8upDpeLFXqpL43wWNg94FMr52TKOXr/l+0CKE6VzNNSovAmpoZDigKdp0gibcU4Z7xXgJS8GALobUNe5PLs9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=OQoPfOC4; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="OQoPfOC4"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 370391C01;
	Wed, 29 Apr 2026 07:14:46 -0700 (PDT)
Received: from e142021.munich.arm.com (e142021.arm.com [10.41.150.154])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 81DF53F62B;
	Wed, 29 Apr 2026 07:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1777472091; bh=wnINJ4qqC5jjasrgT/cw8BNQc6KV8jan1/3jpxXMVaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OQoPfOC4B1H8Q4FAfavj/0IISrRjLH/8CILEmmydD3VI6qY+g8aKkk9RvnVzCR4HW
	 QR3XejycOJ+zazznJcIGoEY88hym/1oeAAm5tHm5PB576kPegqVyVbEfqLZ1mwn5Y0
	 BLmH/MDR0g/1yBrMzRs4k65WelLIujcqfPwDzBJA=
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
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] arm_mpam: prevent MPAM-Fb accesses inside IRQ handler
Date: Wed, 29 Apr 2026 16:13:38 +0200
Message-ID: <20260429141339.3171205-5-andre.przywara@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429141339.3171205-1-andre.przywara@arm.com>
References: <20260429141339.3171205-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an MPAM MSC gets into an error condition, it can trigger an error
IRQ. We cannot really do much about those errors, but we at least query
and log the error, then disable MPAM functionality.

This error report relies on reading the MSC's error status register
(ESR) in the IRQ handler, which is not possible for MPAM-Fb based
MSC accesses, since they involve mailbox routines that might sleep.

For simplicity just skip the ESR read when the MSC is not using direct
MMIO accesses. We will wrap up MPAM functionality regardless, knowing
the exact error value will not change that.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/resctrl/mpam_devices.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index 90b49bfd5caa..62aa04cb6905 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -2472,7 +2472,7 @@ static int mpam_disable_msc_ecr(void *_msc)
 
 static irqreturn_t __mpam_irq_handler(int irq, struct mpam_msc *msc)
 {
-	u64 reg;
+	u64 reg = 0;
 	u16 partid;
 	u8 errcode, pmg, ris;
 
@@ -2481,22 +2481,30 @@ static irqreturn_t __mpam_irq_handler(int irq, struct mpam_msc *msc)
 					   &msc->accessibility)))
 		return IRQ_NONE;
 
-	reg = mpam_msc_read_esr(msc);
+	/* MPAM-Fb MSC accesses cannot be done in atomic context. */
+	if (msc->iface == MPAM_IFACE_MMIO) {
+		reg = mpam_msc_read_esr(msc);
 
-	errcode = FIELD_GET(MPAMF_ESR_ERRCODE, reg);
-	if (!errcode)
-		return IRQ_NONE;
+		errcode = FIELD_GET(MPAMF_ESR_ERRCODE, reg);
+		if (!errcode)
+			return IRQ_NONE;
+	}
 
 	/* Clear level triggered irq */
 	mpam_msc_clear_esr(msc);
 
-	partid = FIELD_GET(MPAMF_ESR_PARTID_MON, reg);
-	pmg = FIELD_GET(MPAMF_ESR_PMG, reg);
-	ris = FIELD_GET(MPAMF_ESR_RIS, reg);
+	if (reg) {
+		partid = FIELD_GET(MPAMF_ESR_PARTID_MON, reg);
+		pmg = FIELD_GET(MPAMF_ESR_PMG, reg);
+		ris = FIELD_GET(MPAMF_ESR_RIS, reg);
+
+		pr_err_ratelimited("error irq from msc:%u '%s', partid:%u, pmg: %u, ris: %u\n",
+				   msc->id, mpam_errcode_names[errcode], partid,
+				   pmg, ris);
+	} else {
+		pr_err_ratelimited("unknown error irq from msc:%u\n", msc->id);
+	}
 
-	pr_err_ratelimited("error irq from msc:%u '%s', partid:%u, pmg: %u, ris: %u\n",
-			   msc->id, mpam_errcode_names[errcode], partid, pmg,
-			   ris);
 
 	/* Disable this interrupt. */
 	mpam_disable_msc_ecr(msc);
-- 
2.43.0

