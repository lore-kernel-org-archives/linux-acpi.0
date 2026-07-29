Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A204ADD99;
	Wed, 29 Jul 2026 13:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785332538; cv=none; b=G5JUoMvfb29bEt2P3jNdzJtApvA+U/YevXPyBvqg6QYDe08erlGcBIzZYBPTH/2CoUP6smuMIyc3UNknUUDiB38Ht128BsiSKtAvI2tS1AU/O03ZkHh1nHC4Qj84wTFWTwpgEoE+RHQMtM6KyHNYvxABP5aI3y3ehu6h1R3dG+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785332538; c=relaxed/simple;
	bh=RqYExXP2DIonUIxmNtWY0w3UKUHFPDqA2PRi+qzWdBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SS0/IH8355Ksxmn8O+5qTjz4y4sMtfPacHCb9rY1iyw7ZfAvUvJaHdBkYCpZjWcEHWcKd/JveFTl7Uz/sBCJCwAG8uTz9iVF2/GvKTHY89M+RI2iW/2GpXuLx6wuhzHAC2vSS2EehOC9VYGO1kU38VncyqT6YmZpyYshR5PGJ/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=aOQSp6l2; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="aOQSp6l2"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11C1A1688;
	Wed, 29 Jul 2026 06:42:11 -0700 (PDT)
Received: from e142021.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 38E3B3F86F;
	Wed, 29 Jul 2026 06:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785332535; bh=RqYExXP2DIonUIxmNtWY0w3UKUHFPDqA2PRi+qzWdBs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aOQSp6l2HD6QUqzCKVmMfx+VBU9njGp2Gwfvla9/Gruw8ErKYwHAt79KHur/FdZ2d
	 ZyI2H81hBOfSBh8fzIB4+ZU+rP+pjXCRPyH3f4Q8XmghJT9l4FZnJW+YVafZEQ3Tw+
	 V0UFFVVXi09a6ZFnlaR3OdFEvK3yxarLBzMdh8KQ=
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
Subject: [PATCH v5 09/10] arm_mpam: change error IRQ to use a threaded IRQ handler
Date: Wed, 29 Jul 2026 15:41:23 +0200
Message-ID: <20260729134124.2506269-10-andre.przywara@arm.com>
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

When an MPAM MSC gets into an error condition, it can trigger an error
IRQ. We cannot really do much about those errors, but we at least query
and log the error, then disable MPAM functionality.

This error report relies on reading the MSC's error status register
(ESR) in the IRQ handler, which is not possible for MPAM-Fb based
MSC accesses, since they involve mailbox routines that might sleep.
The same is true for clearing the interrupt at the source, which
requires an MSC access as well.

Change the error IRQ to use a threaded IRQ handler, with an empty hard
IRQ routine, and doing all the MSC accesses (to access the status and
disable the IRQ line) in the threaded part. The change is minimal, we
just check for the first MSC access error and bail out early.
Also forbid per-CPU interrupts (PPIs) for MPAM-Fb, as we cannot use a
threaded IRQ here.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/resctrl/mpam_devices.c | 42 ++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index abe1e628928f..e535603d2c7d 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -2659,9 +2659,11 @@ static int mpam_disable_msc_ecr(void *_msc)
 	return 0;
 }
 
+/* threaded IRQ handler for shared IRQs, to allow MPAM-Fb accesses to sleep */
 static irqreturn_t __mpam_irq_handler(int irq, struct mpam_msc *msc)
 {
 	u64 reg;
+	int ret;
 	u16 partid;
 	u8 errcode, pmg, ris;
 
@@ -2670,13 +2672,19 @@ static irqreturn_t __mpam_irq_handler(int irq, struct mpam_msc *msc)
 					   &msc->accessibility)))
 		return IRQ_NONE;
 
-	mpam_msc_read_esr(msc, &reg);
+	ret = mpam_msc_read_esr(msc, &reg);
+	if (ret) {
+		pr_err_ratelimited("unknown error irq from msc:%u\n", msc->id);
+
+		/* Try out best here ... */
+		goto out_disable;
+	}
 
 	errcode = FIELD_GET(MPAMF_ESR_ERRCODE, reg);
 	if (!errcode)
 		return IRQ_NONE;
 
-	/* Clear level triggered irq */
+	/* Clear level triggered irq. Ignore errors, we need to proceed. */
 	mpam_msc_clear_esr(msc);
 
 	partid = FIELD_GET(MPAMF_ESR_PARTID_MON, reg);
@@ -2687,19 +2695,19 @@ static irqreturn_t __mpam_irq_handler(int irq, struct mpam_msc *msc)
 			   msc->id, mpam_errcode_names[errcode], partid, pmg,
 			   ris);
 
-	/* Disable this interrupt. */
+out_disable:
+	/* Disable this interrupt. Ignore errors, we need to proceed anyway. */
 	mpam_disable_msc_ecr(msc);
 
-	/* Are we racing with the thread disabling MPAM? */
-	if (!mpam_is_enabled())
-		return IRQ_HANDLED;
-
 	/*
-	 * Schedule the teardown work. Don't use a threaded IRQ as we can't
-	 * unregister the interrupt from the threaded part of the handler.
+	 * Schedule the teardown work. We have to defer it as we can't
+	 * unregister the interrupt from the threaded part of a handler.
+	 * Check whether we are racing with the thread disabling MPAM.
 	 */
-	mpam_disable_reason = "hardware error interrupt";
-	schedule_work(&mpam_broken_work);
+	if (mpam_is_enabled()) {
+		mpam_disable_reason = "hardware error interrupt";
+		schedule_work(&mpam_broken_work);
+	}
 
 	return IRQ_HANDLED;
 }
@@ -2735,6 +2743,11 @@ static int mpam_register_irqs(void)
 		/* The MPAM spec says the interrupt can be SPI, PPI or LPI */
 		/* We anticipate sharing the interrupt with other MSCs */
 		if (irq_is_percpu(irq)) {
+			if (msc->iface != MPAM_IFACE_MMIO) {
+				dev_err(&msc->pdev->dev,
+					"Only MMIO MSCs can use per-CPU interrupts\n");
+				return -EINVAL;
+			}
 			err = request_percpu_irq(irq, &mpam_ppi_handler,
 						 "mpam:msc:error",
 						 msc->error_dev_id);
@@ -2746,9 +2759,10 @@ static int mpam_register_irqs(void)
 					       &_enable_percpu_irq, &irq,
 					       true);
 		} else {
-			err = devm_request_irq(&msc->pdev->dev, irq,
-					       &mpam_spi_handler, IRQF_SHARED,
-					       "mpam:msc:error", msc);
+			err = devm_request_threaded_irq(&msc->pdev->dev, irq,
+							NULL, &mpam_spi_handler,
+							IRQF_SHARED | IRQF_ONESHOT,
+							"mpam:msc:error", msc);
 			if (err)
 				return err;
 		}
-- 
2.43.0

