Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CE646D0A3;
	Tue,  4 Aug 2026 10:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785838054; cv=none; b=m9KQo7fjpTRALjG77h2qrCkezkueYl5h27Tox7WgTtWOwN1d+RRk1ChJ01EN6C7d/LUPPH74UrYHi9X0EpCj8lyrA3dTejtR0zenyOgsn7avJHMTvXvDtlaM6mo8aHRMxYmDQZJeU6aPoFIqV6uJW/UtgUKBgDjUbyzDDrUhRW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785838054; c=relaxed/simple;
	bh=z/2nvAEWuZhh73Lz+r6EvPA5dn1wAT9S+fnQyCP7Z4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HHS9seUD4sxdF3OvEceo8nuJNt39OKV9+wJskSR/m5qGqm9YzVmhuufCyqvVyC+CvxvdabwnUoFAvAo/09wy3Eb5tivC6qRBZl3eeiIyqb3IJPwL8RujJF5v42aaxgB3QVc0W9KAA3Lz8yFfMkzzamWhTFa7k2Lu+qcTojqxx9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=m9eM46hT; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="m9eM46hT"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B52A6165C;
	Tue,  4 Aug 2026 03:07:27 -0700 (PDT)
Received: from e142021.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 47B6E3F86F;
	Tue,  4 Aug 2026 03:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785838051; bh=z/2nvAEWuZhh73Lz+r6EvPA5dn1wAT9S+fnQyCP7Z4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m9eM46hTKzrE/Q8StkWbL3YeINUM48RHANh4poIRdsjY4ohKue3cyLc+ebfKF3Qq6
	 H6CENZ1TghhexI48RpPxGWDgmreKnKE+8DyfGwmPXf9wqLuhAgNwAq89QCO50EQoYk
	 X5TRr3jA2dqwnsARDGvBsIaxE7MuMdJl22fMNALU=
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
	Gavin Shan <gshan@redhat.com>,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 10/11] arm_mpam: change MPAM-Fb error IRQ to use a threaded IRQ handler
Date: Tue,  4 Aug 2026 12:06:26 +0200
Message-ID: <20260804100627.3217149-11-andre.przywara@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804100627.3217149-1-andre.przywara@arm.com>
References: <20260804100627.3217149-1-andre.przywara@arm.com>
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
 drivers/resctrl/mpam_devices.c | 56 ++++++++++++++++++++++++++++------
 1 file changed, 47 insertions(+), 9 deletions(-)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index e9818c75443d..3c686903def3 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -2714,24 +2714,42 @@ static int mpam_disable_msc_ecr(void *_msc)
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
+	/*
+	 * Clear the level triggered IRQ. If that fails, we cannot do anything
+	 * about it, so ignore any errors. We will disable the IRQ either on
+	 * the device side or on the irqchip level next anyway.
+	 */
 	mpam_msc_clear_esr(msc);
 
 	partid = FIELD_GET(MPAMF_ESR_PARTID_MON, reg);
@@ -2742,16 +2760,24 @@ static irqreturn_t __mpam_irq_handler(int irq, struct mpam_msc *msc)
 			   msc->id, mpam_errcode_names[errcode], partid, pmg,
 			   ris);
 
-	/* Disable this interrupt. */
-	mpam_disable_msc_ecr(msc);
+out_disable:
+	/*
+	 * Disable this interrupt on the device side. If that fails, disable
+	 * the IRQ on the irqchip level, as we must prevent further handler
+	 * invocations. We only take the interrupt once anyway, as we
+	 * are going to free the IRQ next, in mpam_disable().
+	 */
+	ret = mpam_disable_msc_ecr(msc);
+	if (ret)
+		disable_irq_nosync(irq);
 
-	/* Are we racing with the thread disabling MPAM? */
+	/* Check whether we are racing with the thread disabling MPAM. */
 	if (!mpam_is_enabled())
 		return IRQ_HANDLED;
 
 	/*
-	 * Schedule the teardown work. Don't use a threaded IRQ as we can't
-	 * unregister the interrupt from the threaded part of the handler.
+	 * Schedule the teardown work. We have to defer it as we can't
+	 * unregister the interrupt from the threaded part of a handler.
 	 */
 	mpam_disable_reason = "hardware error interrupt";
 	schedule_work(&mpam_broken_work);
@@ -2790,6 +2816,11 @@ static int mpam_register_irqs(void)
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
@@ -2800,12 +2831,19 @@ static int mpam_register_irqs(void)
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

