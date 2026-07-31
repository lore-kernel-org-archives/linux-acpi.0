Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B75453A22;
	Fri, 31 Jul 2026 17:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785517458; cv=none; b=JUvV07r4Mt+FbM0an9w/1KivHD67dy94mfYocJBTc72vPv5HInHl3QFJiffhvh//tj3r4Y2RbL4f6sNKyFIGNBw2hezWqtZdF7S7RA6uxqzAD+OtaAGRj+tTvuwvHQEyr+HLPZH1j4W42MkkOarN3SBPzawsnZxZ7iyZ9T0EbVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785517458; c=relaxed/simple;
	bh=qvhy2WvJTUYVKI0V0VcCFLEp8vwHsLREoGqENrrUzWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pRgDnDyKsAS9FiDwFx6eo0v7bcS63zhfzKin7J039d/bDucvn7fQIbUSxvvG8KisZRQ+nMObTsjEhkHBphkIHHLv3OAOdGJ6seg1fjQodF0excj/1zIHysR4MVGWbWb3dwxrldtm/qEwLbIvAFpoL+H6VeZDdsc+y1Dm6RVhZvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=KtPuEjFt; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="KtPuEjFt"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4052320E3;
	Fri, 31 Jul 2026 10:04:12 -0700 (PDT)
Received: from e142021.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD54F3F66F;
	Fri, 31 Jul 2026 10:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785517456; bh=qvhy2WvJTUYVKI0V0VcCFLEp8vwHsLREoGqENrrUzWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KtPuEjFtBZsXHxLtKzhw0bTD/Q9q9/Zg19+MM3BZSlpnqU+nsnPEWedGU0fBOWTDJ
	 DX26x3FFPomA//uhJoR7Ra3R5VkISSUUW3kdFbiUehfS0MNx8g2YIeSeUBJOteVrBQ
	 Zhbz1DxUqooim7DYZfy4Z6Q07WeJuVgDiujbLhxY=
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
	Ritwick Sharma <ritwick.sharma@arm.com>,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 10/11] arm_mpam: change MPAM-Fb error IRQ to use a threaded IRQ handler
Date: Fri, 31 Jul 2026 19:03:23 +0200
Message-ID: <20260731170324.2927758-11-andre.przywara@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731170324.2927758-1-andre.przywara@arm.com>
References: <20260731170324.2927758-1-andre.przywara@arm.com>
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
(ESR) in the current hard-IRQ handler, which is not possible for MPAM-Fb
based MSC accesses, since they involve mailbox routines that might sleep.
The same is true for clearing the interrupt at the source, which requires
an MSC access as well.

When an MSC is using MPAM-Fb, change the error IRQ to use a threaded IRQ
handler, with an empty hard IRQ routine, and doing all the MSC accesses
(to access the status and disable the IRQ line) in the threaded part.
Also forbid per-CPU interrupts (PPIs) for MPAM-Fb, as we cannot use a
threaded IRQ here.

The change in the actual IRQ handler is minimal, we just check for the
first MSC access error and bail out early. MMIO based MSCs keep using a
hard-IRQ handler, since they must be at least non-migrate-able when doing
MSC accesses, for the CPU affinity check to work.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/resctrl/mpam_devices.c | 52 +++++++++++++++++++++++++---------
 1 file changed, 39 insertions(+), 13 deletions(-)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index ea08c12f717a..b238feb559d4 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -2713,24 +2713,38 @@ static int mpam_disable_msc_ecr(void *_msc)
 	return 0;
 }
 
+/*
+ * This will run as the threaded IRQ handler part when using MPAM-Fb, but
+ * as the sole hard-IRQ handler for MMIO based accesses.
+ */
 static irqreturn_t __mpam_irq_handler(int irq, struct mpam_msc *msc)
 {
 	u64 reg;
+	int ret;
 	u16 partid;
 	u8 errcode, pmg, ris;
 
-	if (WARN_ON_ONCE(!msc) ||
+	if (WARN_ON_ONCE(!msc))
+		return IRQ_NONE;
+
+	if (msc->iface == MPAM_IFACE_MMIO &&
 	    WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(),
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
@@ -2741,19 +2755,19 @@ static irqreturn_t __mpam_irq_handler(int irq, struct mpam_msc *msc)
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
@@ -2789,6 +2803,11 @@ static int mpam_register_irqs(void)
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
@@ -2799,12 +2818,19 @@ static int mpam_register_irqs(void)
 			smp_call_function_many(&msc->accessibility,
 					       &_enable_percpu_irq, &irq,
 					       true);
-		} else {
+		} else if (msc->iface == MPAM_IFACE_MMIO) {
 			err = devm_request_irq(&msc->pdev->dev, irq,
 					       &mpam_spi_handler, IRQF_SHARED,
 					       "mpam:msc:error", msc);
 			if (err)
 				return err;
+		} else {
+			err = devm_request_threaded_irq(&msc->pdev->dev, irq,
+							NULL, &mpam_spi_handler,
+							IRQF_SHARED | IRQF_ONESHOT,
+							"mpam:msc:error", msc);
+			if (err)
+				return err;
 		}
 
 		mutex_lock(&msc->error_irq_lock);
-- 
2.43.0

