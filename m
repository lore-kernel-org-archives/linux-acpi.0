Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0910F204C31
	for <linux-acpi@vger.kernel.org>; Tue,  8 Sep 2026 01:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788832036; cv=none; b=leX3ojnmAct+3yVIkwCNE+3KfJ5tjyZXlw/gYwhEupiAxBhvzyP62YIdjw/uzZYl69tiqrFy0sCkHXdhmNKZ3VgzVIlr93K00sxqyRjScL7Auoeu2NjQcF6aVn2sR8i/fT/PZFgb1JjVz8nUJ+A6vMFgsZkyLKdZwP/h34Ee3HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788832036; c=relaxed/simple;
	bh=j0J6PB9VjIWfdFd6RLZ46WV4axSngi2ZOWf4Jjw01rs=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=EEye6IJkzftw7cDQwdwp9XRibvIQQDxjcdmfZbdITp8aNVB9nAduzzyJbpGFbmT988uC8Bc/kZ+TSlDaCkLNoRvxlalxiXWJZL3ndRSYkGjVmnoWOdiuc+bXq6U6boDXQN09Z7efl5FEShD7hkzL0L/CFd0YIJA3gbhOa0HiHCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 2ec693a2ab2711f19a56ed5b684f684d-20260908
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:545d2e17-ef9e-4212-b3a1-a1ceb2d6bf31,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:7db8b62,CLOUDID:8c8b29cfa8c89e5635a5442de91e951c,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50|99,EDM:5,IP
	:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2ec693a2ab2711f19a56ed5b684f684d-20260908
X-User: lijun01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lijun01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2136094586; Tue, 08 Sep 2026 09:47:00 +0800
From: Li Jun <lijun01@kylinos.cn>
To: lijun01@kylinos.cn,
	rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH] ACPI: button: replace SIMPLE_DEV_PM_OPS with DEFINE_SIMPLE_DEV_PM_OPS
Date: Tue,  8 Sep 2026 09:46:45 +0800
Message-Id: <20260908014645.4165221-1-lijun01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace `#ifdef CONFIG_PM_SLEEP` boilerplate with the modern
`DEFINE_SIMPLE_DEV_PM_OPS()` macro in the acpi_button driver.

Signed-off-by: Li Jun <lijun01@kylinos.cn>
---
 drivers/acpi/button.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index cdbb1023a8ee..15fc5d2ae467 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -161,14 +161,10 @@ static const struct dmi_system_id dmi_lid_quirks[] = {
 static int acpi_button_probe(struct platform_device *pdev);
 static void acpi_button_remove(struct platform_device *pdev);
 
-#ifdef CONFIG_PM_SLEEP
 static int acpi_button_suspend(struct device *dev);
 static int acpi_button_resume(struct device *dev);
-#else
-#define acpi_button_suspend NULL
-#define acpi_button_resume NULL
-#endif
-static SIMPLE_DEV_PM_OPS(acpi_button_pm, acpi_button_suspend, acpi_button_resume);
+
+static DEFINE_SIMPLE_DEV_PM_OPS(acpi_button_pm, acpi_button_suspend, acpi_button_resume);
 
 static struct platform_driver acpi_button_driver = {
 	.probe = acpi_button_probe,
-- 
2.25.1

