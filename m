Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75533AF66F;
	Thu,  2 Jul 2026 16:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783009423; cv=none; b=XyBK6a28u49OOZsHf3C+SWMInIwdlpBF75z1dTmZQP33o/bA9p239AO7h3x6EHrf5qWe10cucPHrUR9JR0Dpov+7HG0liw8SFpacc+nGPlOqJ7yPcqqeH4bcWRMAWFtZ7e/mJ5cwntqVf8ZgzTi02p16URR8AVj+ezdecBytalE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783009423; c=relaxed/simple;
	bh=ZOi+S59YJ0B3TKXiKIEFBZs1J/FXmsi//zO+8bJPX7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FptsE3RFiDsM3kUuprq4019psyMb/0lMEgbuXNaTdwIGhpL3mGO6uxuTXJsvHj6tXSU5lZzS42YrGvEnI/do/LCa+ISUh9zavqPNCK5Rx6s9q7LQJdqW9GSot08GzycYu73uotZkMjtt8zjqsobZV+DEBIemYok+xy3H0fAx3v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=bG4sXIzr; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="bG4sXIzr"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 492B135C7;
	Thu,  2 Jul 2026 09:23:33 -0700 (PDT)
Received: from e142021.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E37353F673;
	Thu,  2 Jul 2026 09:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783009417; bh=ZOi+S59YJ0B3TKXiKIEFBZs1J/FXmsi//zO+8bJPX7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bG4sXIzrIOoKahUcxII7Dou310sac30oJl7cq96iXQIqGuc7HpZLDmN4Zqm3kOrMj
	 G5b5mxAp5W7k7NvDPYR7rz5AooC3pxXiTTzPXluf5cpFGzaL9s+xOLs/2AIkb3nLTt
	 Q0J0/tCI82jX9N2aneHZSBZt6NwBaOEMSk6T2tOM=
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
Subject: [PATCH v2 14/15] arm_mpam: prevent MPAM-Fb accesses inside IRQ handler
Date: Thu,  2 Jul 2026 18:22:28 +0200
Message-ID: <20260702162229.4008659-15-andre.przywara@arm.com>
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
 drivers/resctrl/mpam_devices.c | 35 +++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index b858ff389bff..4a088e6cd235 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -2639,7 +2639,7 @@ static int mpam_disable_msc_ecr(void *_msc)
 
 static irqreturn_t __mpam_irq_handler(int irq, struct mpam_msc *msc)
 {
-	u64 reg;
+	u64 reg = 0;
 	u16 partid;
 	u8 errcode, pmg, ris;
 
@@ -2648,25 +2648,30 @@ static irqreturn_t __mpam_irq_handler(int irq, struct mpam_msc *msc)
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
+		pr_err_ratelimited("unknown error irq from msc:%u\n", msc->id);
+	}
 
 	/* Are we racing with the thread disabling MPAM? */
 	if (!mpam_is_enabled())
-- 
2.43.0

