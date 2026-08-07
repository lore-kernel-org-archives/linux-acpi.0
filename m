Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F22742CB0D;
	Fri,  7 Aug 2026 10:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786100139; cv=none; b=OrUmXXaCaHUofnjKUGQqaxCVLKnFxGe2PZNldoYEIDLmZ2MaoV5AeBeM445ePZFULhgSQ4dbbMkJcYkveUBgEzOK9u9vlKDPqUK8OJFH7Pd0mpLhRgejkcgod6ibziHXGCcq0s7Rc7L44lN/yD6otmqzNRIQO6h48VFDS1gBA40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786100139; c=relaxed/simple;
	bh=vfefnqkd2ibXnBQ39xPLFHlObQHT5faJOCUx8RwI9Uw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZzNZPGWUC5o1Vf+k+FbeZ5CGveAa/3htLZhn7x5Os+rO2g/SHdLgxF6xrKD6RwTluIxh7zXNPed08iZL1PcqbxEcjnqzqO9ha0kUJLyeY4eLI+YKSsa9dJwo5FKUV/Me88ZWBnY7Cl08tD3Vt0VCpzDvRfgmxPqyCLlCmWcCXFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=NJLcpWZd; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="NJLcpWZd"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A4B91A9A;
	Fri,  7 Aug 2026 03:55:33 -0700 (PDT)
Received: from e142021.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B5A9F3F9A2;
	Fri,  7 Aug 2026 03:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786100137; bh=vfefnqkd2ibXnBQ39xPLFHlObQHT5faJOCUx8RwI9Uw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NJLcpWZd0yyCWt+0YwWUhwMkIFiskDK7vlgo+lTmRFAkph4IVDOw0Htc4/caIzYVp
	 jV0Qyg466N+9mexIHtzaSoJZLDzKDyiDzDVcIHRwaV94Zh+z2SIvkmVQ2kKG/B9cGB
	 B0/8psmLEI4Q0sHuEgEdhwlUOmlMbNQ8RHM38Ze4=
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
Subject: [PATCH v9 08/12] arm_mpam: propagate MSC access errors for interrupt control
Date: Fri,  7 Aug 2026 12:54:47 +0200
Message-ID: <20260807105451.3728284-9-andre.przywara@arm.com>
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

Allow the functions dealing with interrupt registration and enablement
to check for and return errors, and propagate MSC read and write errors
from the lower level up.
This does not cover the IRQ handler yet, as this needs some more
attention.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/resctrl/mpam_devices.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index 49239b15a27f..1b07f7765f96 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -1105,7 +1105,9 @@ static int mpam_msc_hw_probe(struct mpam_msc *msc)
 	}
 
 	/* Clear any stale errors */
-	mpam_msc_clear_esr(msc);
+	ret = mpam_msc_clear_esr(msc);
+	if (ret)
+		return ret;
 
 	spin_lock(&partid_max_lock);
 	mpam_partid_max = min(mpam_partid_max, msc->partid_max);
@@ -2660,9 +2662,7 @@ static int mpam_enable_msc_ecr(void *_msc)
 {
 	struct mpam_msc *msc = _msc;
 
-	__mpam_write_reg(msc, MPAMF_ECR, MPAMF_ECR_INTEN);
-
-	return 0;
+	return __mpam_write_reg(msc, MPAMF_ECR, MPAMF_ECR_INTEN);
 }
 
 /* This can run in mpam_disable(), and the interrupt handler on the same CPU */
@@ -2670,9 +2670,7 @@ static int mpam_disable_msc_ecr(void *_msc)
 {
 	struct mpam_msc *msc = _msc;
 
-	__mpam_write_reg(msc, MPAMF_ECR, 0);
-
-	return 0;
+	return __mpam_write_reg(msc, MPAMF_ECR, 0);
 }
 
 static irqreturn_t __mpam_irq_handler(int irq, struct mpam_msc *msc)
@@ -2769,11 +2767,13 @@ static int mpam_register_irqs(void)
 				return err;
 		}
 
-		mutex_lock(&msc->error_irq_lock);
-		msc->error_irq_req = true;
-		mpam_touch_msc(msc, mpam_enable_msc_ecr, msc);
-		msc->error_irq_hw_enabled = true;
-		mutex_unlock(&msc->error_irq_lock);
+		scoped_guard(mutex, &msc->error_irq_lock) {
+			msc->error_irq_req = true;
+			err = mpam_touch_msc(msc, mpam_enable_msc_ecr, msc);
+			if (err)
+				return err;
+			msc->error_irq_hw_enabled = true;
+		}
 	}
 
 	return 0;
@@ -2792,10 +2792,10 @@ static void mpam_unregister_irqs(void)
 		if (irq <= 0)
 			continue;
 
-		mutex_lock(&msc->error_irq_lock);
+		guard(mutex)(&msc->error_irq_lock);
 		if (msc->error_irq_hw_enabled) {
-			mpam_touch_msc(msc, mpam_disable_msc_ecr, msc);
-			msc->error_irq_hw_enabled = false;
+			if (!mpam_touch_msc(msc, mpam_disable_msc_ecr, msc))
+				msc->error_irq_hw_enabled = false;
 		}
 
 		if (msc->error_irq_req) {
@@ -2807,7 +2807,6 @@ static void mpam_unregister_irqs(void)
 			}
 			msc->error_irq_req = false;
 		}
-		mutex_unlock(&msc->error_irq_lock);
 	}
 }
 
-- 
2.43.0

