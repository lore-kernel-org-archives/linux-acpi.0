Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6272EA48F;
	Fri, 17 Apr 2026 03:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776395690; cv=none; b=pOqKBPn/dY/ckuGhno60N4wnjgF7cWdG29ywFzt+mJvm/El/AT6msi3Eq7prol5g7EIrDLYtFNd4tdzVWqDpmGZmpiIRfki3FEIQ7IWWfVdGUYhW6200kyFL4jgU0XwvXwWWzhTZ2fKm/456BBqQHH1jucNxnil6rvq/PHy7j1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776395690; c=relaxed/simple;
	bh=iJQo6AVcBuj3hs/+twuG+w4S0XnjXarFobO2mXGBHtk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZTi+90SkVp8TBb9oWHE2uXPl5zMqqh934TZ+C+LPZbXkueD7QVFq+1iZF108k4LN6Ih9XNu04sWmcgF7DhH61kA4B3fE9vXXpdOqGaEUojnh2drMU5U0rsPBlN4kXeviWra+419FjfBPSEm1vc/hj4y4DdFW5cZEGD1IJ3HI8Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=mhEVdab4; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="mhEVdab4"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ivcyzP+BYAlV8ChOD0JIRVrG6V1ItumCkZ9RzsXRc0E=;
	b=mhEVdab4eO7kAk+tonNPLfx2r1dloaP7Jt1yvTZ1Fx8s+pNX+9CzAPVg6ty6q1ujlwmDlG3ZY
	z9H3PYViPqgrR1xTEa2mgc857GwXpD39cQxZrbaRWtazYnDLo57jXbTShJMt/MrpNcKs7qdH9kn
	6UIdrmE25lmxf4bL5vStoEg=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fxfw60j2QznTVs;
	Fri, 17 Apr 2026 11:08:22 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 1109B4056C;
	Fri, 17 Apr 2026 11:14:39 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 17 Apr 2026 11:14:30 +0800
Received: from localhost.localdomain (10.50.163.32) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 17 Apr 2026 11:14:29 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <sudeep.holla@kernel.org>, <jassisinghbrar@gmail.com>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>
CC: <linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>
Subject: [PATCH] mailbox: pcc: Fix probabilistic command execution timeout
Date: Fri, 17 Apr 2026 11:14:29 +0800
Message-ID: <20260417031429.2509443-1-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemn100009.china.huawei.com (7.202.194.112)

In some scenarios, PCC command may experience probabilistic timeout.
This is primarily caused by the chan_in_use flag being updated after
ringing the doorbell, coupled with a lack of proper memory barriers
across CPU cores.

On fast platforms, a race condition occurs: the platform processing
completes and triggers an interrupt before the local CPU sets
chan_in_use to true. When the interrupt handler pcc_mbox_irq() runs,
it reads chan_in_use as false and incorrectly ignores the interrupt.

This patch fixes the race by:
1. Moving the chan_in_use update before ringing the doorbell.
2. Using smp_store_release() to ensure the flag update is visible
   to other cores before subsequent hardware or software actions
   are triggered.
3. Using smp_load_acquire() in the interrupt handler to ensure the
   latest flag value is read before deciding to skip the interrupt.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/mailbox/pcc.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 636879ae1db7..f45fccd635b6 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -320,8 +320,13 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 	if (pcc_chan_reg_read_modify_write(&pchan->plat_irq_ack))
 		return IRQ_NONE;
 
+	/*
+	 * For Master Subspaces, we must ensure we see the latest chan_in_use
+	 * value updated by pcc_send_data() on another core. smp_load_acquire
+	 * provides the necessary barrier to avoid probabilistic IRQ misses.
+	 */
 	if (pchan->type == ACPI_PCCT_TYPE_EXT_PCC_MASTER_SUBSPACE &&
-	    !pchan->chan_in_use)
+	    !smp_load_acquire(&pchan->chan_in_use))
 		return IRQ_NONE;
 
 	if (!pcc_mbox_cmd_complete_check(pchan))
@@ -336,7 +341,7 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 	 * where the flag is set again to start new transfer. This is
 	 * required to avoid any possible race in updatation of this flag.
 	 */
-	pchan->chan_in_use = false;
+	smp_store_release(&pchan->chan_in_use, false);
 	mbox_chan_received_data(chan, NULL);
 	mbox_chan_txdone(chan, 0);
 
@@ -438,9 +443,16 @@ static int pcc_send_data(struct mbox_chan *chan, void *data)
 	if (ret)
 		return ret;
 
+	/*
+	 * Set chan_in_use before ringing the doorbell. Using smp_store_release
+	 * ensures the flag is visible to the interrupt handler before the
+	 * hardware is actually notified.
+	 */
+	if (pchan->plat_irq > 0)
+		smp_store_release(&pchan->chan_in_use, true);
 	ret = pcc_chan_reg_read_modify_write(&pchan->db);
-	if (!ret && pchan->plat_irq > 0)
-		pchan->chan_in_use = true;
+	if (ret && pchan->plat_irq > 0)
+		smp_store_release(&pchan->chan_in_use, false);
 
 	return ret;
 }
-- 
2.33.0

