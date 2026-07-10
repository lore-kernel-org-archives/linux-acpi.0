Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC8342E8F6;
	Fri, 10 Jul 2026 14:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783694797; cv=none; b=PLAfNcm0+QW8lgWFsUenoVcd8Ki6BQBJLpGbIotHS0QKEyo/WUuY3xR1qUNlQN9YseCajZXV2ebrOfLhmB79om4yABaXNXaXjTDE5J7WBIXm5qDSPmTorKTqWLVQDYPy3MSDJxrArYnSSoUfvcgblY9XRiJcm8OikuanaTqESQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783694797; c=relaxed/simple;
	bh=A8TmNSPeqpJAzvmZdC54I6h8zsSYk3uyCmo9kr9ZQkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YJR96S+yW3fgKkBy2cbsUXJIO36OZMsJH0vAEyBAUDwODvZPdAlhGSvuK49BgL1QqIcXVyYmJWrefCYlS7Xv/2YIJ8IimnL1UdGDxmQFtcLYR/aBOYfy8zIsvGVr0EKZV2RVSM2Lc+TFaVqGEPRCtj7WCKLw61maS7+9yAg9BJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=a82dhB/a; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="a82dhB/a"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 174A51F60;
	Fri, 10 Jul 2026 07:46:31 -0700 (PDT)
Received: from e142021.munich.arm.com (e142021.arm.com [10.41.150.148])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6FB3E3F7B4;
	Fri, 10 Jul 2026 07:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783694795; bh=A8TmNSPeqpJAzvmZdC54I6h8zsSYk3uyCmo9kr9ZQkM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a82dhB/a/qeziQ3agCtQsrAjwozE/bKvHdrRP3o8l8BUZwSSZ5534I/CpC/Bsgd/C
	 BEtADS/zsvovWgKfPy62BrMb1W6fydvZClYVaAx/VBKy0ZnbBttukUnbLQKe75oA1D
	 n7NU8akewFjaDleFHT2aDwJZpR38BWBgdJkPai8U=
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
Subject: [PATCH v3 15/16] arm_mpam: prevent MPAM-Fb accesses inside IRQ handler
Date: Fri, 10 Jul 2026 16:45:19 +0200
Message-ID: <20260710144520.917375-16-andre.przywara@arm.com>
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

When an MPAM MSC gets into an error condition, it can trigger an error
IRQ. We cannot really do much about those errors, but we at least query
and log the error, then disable MPAM functionality.

This error report relies on reading the MSC's error status register
(ESR) in the IRQ handler, which is not possible for MPAM-Fb based
MSC accesses, since they involve mailbox routines that might sleep.
The same is true for clearing the interrupt at the source, which
requires MSC access.

For simplicity just skip the ESR read when the MSC is not using direct
MMIO accesses, and just ignore the pending interrupts. We will wrap up
MPAM functionality regardless, knowing the exact error value will not
change that.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/resctrl/mpam_devices.c | 38 ++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index 4d3e642486d4..220b4a06e739 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -2645,7 +2645,7 @@ static int mpam_disable_msc_ecr(void *_msc)
 
 static irqreturn_t __mpam_irq_handler(int irq, struct mpam_msc *msc)
 {
-	u64 reg;
+	u64 reg = 0;
 	u16 partid;
 	u8 errcode, pmg, ris;
 
@@ -2654,25 +2654,33 @@ static irqreturn_t __mpam_irq_handler(int irq, struct mpam_msc *msc)
 					   &msc->accessibility)))
 		return IRQ_NONE;
 
-	mpam_msc_read_esr(msc, &reg);
+	/* MPAM-Fb MSC accesses cannot be done in atomic context. */
+	if (msc->iface == MPAM_IFACE_MMIO) {
+		mpam_msc_read_esr(msc, &reg);
 
-	errcode = FIELD_GET(MPAMF_ESR_ERRCODE, reg);
-	if (!errcode)
-		return IRQ_NONE;
+		errcode = FIELD_GET(MPAMF_ESR_ERRCODE, reg);
+		if (!errcode)
+			return IRQ_NONE;
 
-	/* Clear level triggered irq */
-	mpam_msc_clear_esr(msc);
+		/* Clear level triggered irq */
+		mpam_msc_clear_esr(msc);
 
-	partid = FIELD_GET(MPAMF_ESR_PARTID_MON, reg);
-	pmg = FIELD_GET(MPAMF_ESR_PMG, reg);
-	ris = FIELD_GET(MPAMF_ESR_RIS, reg);
+		partid = FIELD_GET(MPAMF_ESR_PARTID_MON, reg);
+		pmg = FIELD_GET(MPAMF_ESR_PMG, reg);
+		ris = FIELD_GET(MPAMF_ESR_RIS, reg);
 
-	pr_err_ratelimited("error irq from msc:%u '%s', partid:%u, pmg: %u, ris: %u\n",
-			   msc->id, mpam_errcode_names[errcode], partid, pmg,
-			   ris);
+		pr_err_ratelimited("error irq from msc:%u '%s', partid:%u, pmg: %u, ris: %u\n",
+				   msc->id, mpam_errcode_names[errcode], partid,
+				   pmg, ris);
 
-	/* Disable this interrupt. */
-	mpam_disable_msc_ecr(msc);
+		/* Disable this interrupt. */
+		mpam_disable_msc_ecr(msc);
+	} else {
+		struct irq_data *d = irq_get_irq_data(irq);
+
+		pr_err_ratelimited("unknown error irq %d/%ld from msc:%u\n",
+				   irq, d ? irqd_to_hwirq(d) : -1, msc->id);
+	}
 
 	/* Are we racing with the thread disabling MPAM? */
 	if (!mpam_is_enabled())
-- 
2.43.0

