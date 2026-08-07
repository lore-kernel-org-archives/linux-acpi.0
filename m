Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248B8433BB9;
	Fri,  7 Aug 2026 10:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786100152; cv=none; b=ujKLUW7SL8kwF+Py1lb7/ksxE/OaefCVee8RPE6RA5YW5o4zn2/64Kj6ijUYZx32d2fKAjh3AeV+gmbrSpnSlqteMSQhqygX/Bn3V9PQEJ+BAHZ04uwYqwt2QGbBzzinjJkCbUnoXdp2M2dofdGSyuLN/3JCQUEjqJix881eEQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786100152; c=relaxed/simple;
	bh=ZK64NNA2/HT2s+p39s9waqNDwrCKyo+v69BhvHEbP3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kBL/7ikmFQzHmNZ7A6M7AD+iAXFukE+cQ0aCUcRpvw0/oGZGOGqgSoRZPOOGNsrRW4dxHZAMtri8M7Pdf96pa86bFhNpzkgFcNm9tlWlD9JSBLskDYA5OmVFJy5OIbtZUc3WeZO/m1Q2NuJNsBTOkMkdLFhqlvXbEjWFJ+eKxUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=rjyvu5j2; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="rjyvu5j2"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4BB231516;
	Fri,  7 Aug 2026 03:55:45 -0700 (PDT)
Received: from e142021.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A5C873F9A2;
	Fri,  7 Aug 2026 03:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786100149; bh=ZK64NNA2/HT2s+p39s9waqNDwrCKyo+v69BhvHEbP3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rjyvu5j2hWc9Pz9M0USjom+PFuP9LjZcZAmcoXzFLV5eGTzWcVSypP4s6Q72dVuPd
	 /tmMgR4HMwmVQiVyMeJw0FeayMsxo8BZtpzLGR0H3sSjlntsEduVx9GVjAKDx54eMY
	 DWDNhxS4soIYaitzyJN4kh/x0aW29OfozclX4I+Q=
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
Subject: [PATCH v9 11/12] arm_mpam: change MPAM-Fb error IRQ to use a threaded IRQ handler
Date: Fri,  7 Aug 2026 12:54:50 +0200
Message-ID: <20260807105451.3728284-12-andre.przywara@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260807105451.3728284-1-andre.przywara@arm.com>
References: <20260807105451.3728284-1-andre.przywara@arm.com>
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
a (potentially sleeping) MSC access as well.

Change the error IRQ handler to be a threaded interrupt, but keep the
handling in the hard-IRQ part for MMIO MSCs. This is needed since the
CPU affinity check in the MSC accessors requires a non-preemptible
context.
When the MSC is using an MPAM-Fb based access, we push the work into the
threaded part of the handler, where the accessors are allowed to sleep.
Also forbid per-CPU interrupts (PPIs) for MPAM-Fb, as we cannot use a
threaded IRQ here.

The actual IRQ handler learns how to deal with errors. We cannot really
handle them, but we can try our best to disable the IRQ anyway.
Should the level IRQ line deactivation fail on the device side, we mask
the IRQ on the irqchip level, to prevent an interrupt storm.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/resctrl/mpam_devices.c | 77 ++++++++++++++++++++++++++++------
 1 file changed, 65 insertions(+), 12 deletions(-)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index fb2fba5ba96d..4b1382fce2be 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -2713,24 +2713,42 @@ static int mpam_disable_msc_ecr(void *_msc)
 	return __mpam_write_reg(msc, MPAMF_ECR, 0);
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
@@ -2741,16 +2759,24 @@ static irqreturn_t __mpam_irq_handler(int irq, struct mpam_msc *msc)
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
@@ -2765,10 +2791,30 @@ static irqreturn_t mpam_ppi_handler(int irq, void *dev_id)
 	return __mpam_irq_handler(irq, msc);
 }
 
-static irqreturn_t mpam_spi_handler(int irq, void *dev_id)
+/*
+ * MMIO based MSC accesses must run in non-preemptible context, as they
+ * might have affinity requirements to check.
+ * MPAM-Fb based MSC accesses must NOT run in hard-IRQ context, as they
+ * can sleep.
+ * So split the IRQ handling up, depending on the MSC access type.
+ */
+static irqreturn_t mpam_shared_hard_irq(int irq, void *dev_id)
 {
 	struct mpam_msc *msc = dev_id;
 
+	if (msc->iface == MPAM_IFACE_MMIO)
+		return __mpam_irq_handler(irq, msc);
+
+	return IRQ_WAKE_THREAD;
+}
+
+static irqreturn_t mpam_shared_thread_irq(int irq, void *dev_id)
+{
+	struct mpam_msc *msc = dev_id;
+
+	if (msc->iface == MPAM_IFACE_MMIO)
+		return IRQ_HANDLED;
+
 	return __mpam_irq_handler(irq, msc);
 }
 
@@ -2789,6 +2835,11 @@ static int mpam_register_irqs(void)
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
@@ -2800,9 +2851,11 @@ static int mpam_register_irqs(void)
 					       &_enable_percpu_irq, &irq,
 					       true);
 		} else {
-			err = devm_request_irq(&msc->pdev->dev, irq,
-					       &mpam_spi_handler, IRQF_SHARED,
-					       "mpam:msc:error", msc);
+			err = devm_request_threaded_irq(&msc->pdev->dev, irq,
+							&mpam_shared_hard_irq,
+							&mpam_shared_thread_irq,
+							IRQF_SHARED | IRQF_ONESHOT,
+							"mpam:msc:error", msc);
 			if (err)
 				return err;
 		}
-- 
2.43.0

