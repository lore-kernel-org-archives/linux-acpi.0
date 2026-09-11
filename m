Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C0A44F55B;
	Fri, 11 Sep 2026 11:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789126205; cv=none; b=G5QPtHu+S2AaLo0y9n2i4TpCKuFVGgvOXNh86MrysgP1BD/ceM/46tk3zX68wpHG9ks3yT0tPVul2eWEEGCEBAan0YEJgeW1Y3WK7ZVg9HsVEhJ7M98DGw9eZkDB7uaKTRnugfGxYfLzL54Fz5JC4yxpHL4Huids5LeAOcvhMkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789126205; c=relaxed/simple;
	bh=GhTP+1HO252xZ5mndSWqsC8gaYJFIXRcoQZKkzr50+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ttb9NQ2iOm5wdygTgKB2Ksv6nQUklKujC1kMDWevhyzcHaIjO0J5ttfMSWO+8c12hompJHyELbtn2gB2obuG+RL9D4Zxp7nEFKz9P+GLArFhnZ333+L9LRlYfw57P3qaGcUMS4COW5JP8qy+3aK28VwP+lUNJ3Ihc/5UA7TmoWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=MwtUy6tY; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="MwtUy6tY"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B7542910;
	Fri, 11 Sep 2026 04:29:31 -0700 (PDT)
Received: from e142021.arm.com (unknown [10.57.6.75])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC9A83F59E;
	Fri, 11 Sep 2026 04:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789126175; bh=GhTP+1HO252xZ5mndSWqsC8gaYJFIXRcoQZKkzr50+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MwtUy6tYz6FUAUvssbb+apbqkvZGwRzs3KlFVHEqyeFaVKNvYo3/5VK0JJE38l8o7
	 QRwa6EMeMe33w5BxzF3dpXMb+7TyESutMR/z/j+VrwjvcruN0G9c27JpDhSiwUw1e8
	 eT4YAi5Pgo/HJ+JI0tmcx8tA/zgt3RXbVylhg1+M=
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
Subject: [PATCH v10 11/14] arm_mpam: change MPAM-Fb error IRQ to use a threaded IRQ handler
Date: Fri, 11 Sep 2026 13:28:32 +0200
Message-ID: <20260911112835.714162-12-andre.przywara@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911112835.714162-1-andre.przywara@arm.com>
References: <20260911112835.714162-1-andre.przywara@arm.com>
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
Reviewed-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Srivathsa L Rao <srivathsa.rao@oss.qualcomm.com>
---
 drivers/resctrl/mpam_devices.c | 77 ++++++++++++++++++++++++++++------
 1 file changed, 65 insertions(+), 12 deletions(-)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index 745f27845e3af..14dc8461e4b8f 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -2721,24 +2721,42 @@ static int mpam_disable_msc_ecr(void *_msc)
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
@@ -2749,16 +2767,24 @@ static irqreturn_t __mpam_irq_handler(int irq, struct mpam_msc *msc)
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
@@ -2773,10 +2799,30 @@ static irqreturn_t mpam_ppi_handler(int irq, void *dev_id)
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
 
@@ -2797,6 +2843,11 @@ static int mpam_register_irqs(void)
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
@@ -2808,9 +2859,11 @@ static int mpam_register_irqs(void)
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

