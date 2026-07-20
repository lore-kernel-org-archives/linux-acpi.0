Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4AC3B7778;
	Mon, 20 Jul 2026 07:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784532294; cv=none; b=he4U3dt/ZLnn1fIqRWoBvbPZc29Yjc2lRGHUjGyWlsSl4b3N5XWKkK1CC6LJFA/LSiWYGKUHKgcMeI7s4JidYPiUW0fA3Y0CJmBZFGdNJYnOUi96Fm1Hx0DACRwEFkD/qU55e2F3+nS+i+lTx2UQb0I2VC+9AIqaXeA8EJb3m1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784532294; c=relaxed/simple;
	bh=9LZiT6IMm4RNKgF3ZjoVi25GPURzQ6jZcCNp1Km8ryE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=eNFmiHV7DVF3UUX9vmiW4NNPewd1zPPoq+vBjf4o1zwAJk38Adb7yQ2xUD3ZDaITjclKo6MoQ9MEXuGhPv9nWfr6aDW0USi4sVdY6sX8hDu/dy/Ebc/T1ahL6nrwwO5zWaaM10ZD7VndRbDPAaW6gk6RxaVG1ZI3mIe0r1fZDAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=VNnts2NW; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="VNnts2NW"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1784532284; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=kKlS/TXgVj15IkrhkJDLUC0ggPp/2bFcKJ/+UmUw7qg=;
	b=VNnts2NWtHkEzyabEqS0Au4JcPqfDLeKKcKIG5pDPdVbQxsjkoWxGFGILaBYM5O4c09iUoYZNEKvspuTTKX8Q/gjW8B2D5ci76EGG4Mh+T8y8MYsQohohQbRC4M75eOOVqpcaf1IhZlgJAeF/67Repec1cD85Ip2SZN/hD+sgRg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=yadong.qi@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0X7QFSy7_1784532282;
Received: from L-G4162440-1116.localdomain(mailfrom:yadong.qi@linux.alibaba.com fp:SMTPD_---0X7QFSy7_1784532282 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 20 Jul 2026 15:24:44 +0800
From: Yadong Qi <yadong.qi@linux.alibaba.com>
To: james.morse@arm.com,
	ben.horgan@arm.com,
	reinette.chatre@intel.com,
	fenghuay@nvidia.com,
	linux-kernel@vger.kernel.org,
	lpieralisi@kernel.org,
	guohanjun@huawei.com,
	sudeep.holla@kernel.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	ying.huang@linux.alibaba.com
Cc: ptg-linux-kernel@linux.alibaba.com,
	yadong.qi@linux.alibaba.com
Subject: [RFC PATCH] arm_mpam: remove sanity check of accessibility when error interrupt is SPI on SMT platforms
Date: Mon, 20 Jul 2026 15:24:09 +0800
Message-Id: <20260720072409.2660-1-yadong.qi@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On SMT platforms, an L2 cache MSC is typically shared between sibling
threads. Per the MPAM ACPI spec (DEN0065B), the MSC's linked device
should be set to the processor container of those siblings, so the
kernel derives msc->accessibility as just the sibling CPUs.

Per the MPAM spec (IHI0099B), when an MSC is not integrated into a PE,
SPI/LPI is the recommended error interrupt. SPIs are not per-CPU, and a
sanity check in mpam_msc_setup_error_irq() requires accessibility ==
cpu_possible_mask — assuming a shared interrupt must be routable to all
CPUs. This creates a conflict on SMT platforms: the MSC has a restricted
accessibility but a shared error interrupt, causing probe to fail with:

  msc:N is a private resource with a shared error interrupt

This RFC patch removes the check to allow MSC probe to succeed on SMT
platforms, but this is mainly intended to start a discussion. We would
appreciate advice on the right way to handle this conflict. Is this a
spec issue, or should the driver handle SPI error interrupts differently
when an MSC has a restricted accessibility mask?

Signed-off-by: Yadong Qi <yadong.qi@linux.alibaba.com>
---
 drivers/resctrl/mpam_devices.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index b69f99488111..e8b2b5e00d7c 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -1964,13 +1964,6 @@ static int mpam_msc_setup_error_irq(struct mpam_msc *msc)
 	if (irq_is_percpu(irq))
 		return __setup_ppi(msc);
 
-	/* sanity check: shared interrupts can be routed anywhere? */
-	if (!cpumask_equal(&msc->accessibility, cpu_possible_mask)) {
-		pr_err_once("msc:%u is a private resource with a shared error interrupt",
-			    msc->id);
-		return -EINVAL;
-	}
-
 	return 0;
 }
 
-- 
2.43.0

