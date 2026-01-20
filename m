Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920573A7850;
	Tue, 20 Jan 2026 11:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768908186; cv=none; b=t82Xjzlhw4ZctuDO9JJ6iPq1p645ASJBtu5gmEmST6YvyHQykVJ1Kq7LcR3/q5nAyeGlKNc2U/UCHyPAafBKwb3fJrKlG6FgeJbZO+iuWYFOyQz1/oEHDnd96FUCFuEThKkCGv3h8P32yfJTpYKLZOPrJpM8xMRGUmdWxME1lvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768908186; c=relaxed/simple;
	bh=uFpJF2e9yjLwu+BdDFVLUGhR+AQCDfrGZKwCV0XIiuc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zbyg5kRdO1kHFFhdnRXmZTSaB7siP7hqtkXAlvBuHWC+LM0/0ZdwTgYsMTWj8H1b1rtOr+gaq3ghnbVGClnO28Tf2jFOMzFkX+gbfrhg9mcLeHc1P9RE4Vz8T0Y+VOCXMmJmXngCs7v6rlkvgcMICoNJELvS8lYen05m3c5lvFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=Lw1qdojJ; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="Lw1qdojJ"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=27Q0C8llXgqQJwH6z58sSTWRnnaitCFQdfCCIsBHjt4=;
	b=Lw1qdojJHm3cYt8sMAobRpoCq3Rg9ah38SCojlk8pyFJjNMVYuGztzTLM3g+B7iGSO5fjwI+3
	jIKMsYxtiScwGKkoS3PHp1AMbTUUX+OZ0RXOX+G5T1FDgE/BLG11/1Jlqi28h+hEJ7D4BAi3aYJ
	kY6dQ2jmM2AKxLMR/RtxxW4=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dwPwP4FfJznTWK;
	Tue, 20 Jan 2026 19:19:01 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 25B7240563;
	Tue, 20 Jan 2026 19:23:00 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 20 Jan 2026 19:23:00 +0800
Received: from localhost.localdomain (10.50.163.32) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 20 Jan 2026 19:22:59 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>,
	<wangzhi12@huawei.com>, <zhangpengjie2@huawei.com>, <lihuisong@huawei.com>
Subject: [PATCH v2 1/3] ACPI: processor: idle: Redefine acpi_processor_setup_cpuidle_states to void
Date: Tue, 20 Jan 2026 19:22:56 +0800
Message-ID: <20260120112258.1595164-2-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260120112258.1595164-1-lihuisong@huawei.com>
References: <20260120112258.1595164-1-lihuisong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemn100009.china.huawei.com (7.202.194.112)

The acpi_processor_setup_lpi_states() wouldn't fail. All callers ignore the
return value of acpi_processor_setup_cpuidle_states().
So redefine setup idle functions to void.

No intentional functional impact.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/acpi/processor_idle.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index f3a73c99f450..d055dbae36c8 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1180,7 +1180,7 @@ static int acpi_idle_lpi_enter(struct cpuidle_device *dev,
 	return -EINVAL;
 }
 
-static int acpi_processor_setup_lpi_states(struct acpi_processor *pr)
+static void acpi_processor_setup_lpi_states(struct acpi_processor *pr)
 {
 	int i;
 	struct acpi_lpi_state *lpi;
@@ -1188,7 +1188,7 @@ static int acpi_processor_setup_lpi_states(struct acpi_processor *pr)
 	struct cpuidle_driver *drv = &acpi_idle_driver;
 
 	if (!pr->flags.has_lpi)
-		return -EOPNOTSUPP;
+		return;
 
 	for (i = 0; i < pr->power.count && i < CPUIDLE_STATE_MAX; i++) {
 		lpi = &pr->power.lpi_states[i];
@@ -1206,8 +1206,6 @@ static int acpi_processor_setup_lpi_states(struct acpi_processor *pr)
 	}
 
 	drv->state_count = i;
-
-	return 0;
 }
 
 /**
@@ -1216,13 +1214,13 @@ static int acpi_processor_setup_lpi_states(struct acpi_processor *pr)
  *
  * @pr: the ACPI processor
  */
-static int acpi_processor_setup_cpuidle_states(struct acpi_processor *pr)
+static void acpi_processor_setup_cpuidle_states(struct acpi_processor *pr)
 {
 	int i;
 	struct cpuidle_driver *drv = &acpi_idle_driver;
 
 	if (!pr->flags.power_setup_done || !pr->flags.power)
-		return -EINVAL;
+		return;
 
 	drv->safe_state_index = -1;
 	for (i = ACPI_IDLE_STATE_START; i < CPUIDLE_STATE_MAX; i++) {
@@ -1230,11 +1228,12 @@ static int acpi_processor_setup_cpuidle_states(struct acpi_processor *pr)
 		drv->states[i].desc[0] = '\0';
 	}
 
-	if (pr->flags.has_lpi)
-		return acpi_processor_setup_lpi_states(pr);
+	if (pr->flags.has_lpi) {
+		acpi_processor_setup_lpi_states(pr);
+		return;
+	}
 
 	acpi_processor_setup_cstates(pr);
-	return 0;
 }
 
 /**
-- 
2.33.0

