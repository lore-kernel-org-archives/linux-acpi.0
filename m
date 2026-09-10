Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F351F507
	for <linux-acpi@vger.kernel.org>; Thu, 10 Sep 2026 01:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789005018; cv=none; b=JeC2R8EuL1EiOMnxZ2dfrUhMuvoASeHc3OXH2h3JPj3EVi7QOPmRpDEOiWYyH/KGZesf4hQW2uaMs82o230vncLW4wJ1Pa7+nzgerdICehqtkn19Yr4QQDJvSdGJCfL9h4LaDlps4QCMhuyEoLr2bsMozohhXRHKG7/FJmMWnmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789005018; c=relaxed/simple;
	bh=BOYWpn9J3VKyh8fNbYj3QGVD86VTduHrn8XhgrzNhbM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=UstpTA6fxbSRqoMTKYBErmaNLkJD89S9jEFVlh1aqHrGfP9xDMI/UbEWyBJnXDcLP1vRW+uqE9+etwkegcT23aZt+smfMRAKzX09pflo9s/KCX69xytPZNKeSi3E89qjeuiefNPRMG82oLiPuLjIr13zzgIV82o7Q+It/52wHFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f31b15a0acb911f19a56ed5b684f684d-20260910
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:41d013c3-648d-4a6d-8964-be5f38e9dd3d,IP:0,U
	RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:57c6d4679a2ee0a1b0292a5a10c4baec,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50|99,EDM:5,IP
	:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f31b15a0acb911f19a56ed5b684f684d-20260910
X-User: lijun01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lijun01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 994017250; Thu, 10 Sep 2026 09:50:07 +0800
From: Li Jun <lijun01@kylinos.cn>
To: lijun01@kylinos.cn,
	rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH v2] ACPI: button: replace SIMPLE_DEV_PM_OPS with DEFINE_SIMPLE_DEV_PM_OPS
Date: Thu, 10 Sep 2026 09:49:53 +0800
Message-Id: <20260910014953.187180-1-lijun01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace `SIMPLE_DEV_PM_OPS` and `#ifdef CONFIG_PM_SLEEP`
boilerplate with the modern `DEFINE_SIMPLE_DEV_PM_OPS()`
macro in the acpi_button driver.

Signed-off-by: Li Jun <lijun01@kylinos.cn>
---
Changes:
-Add pm_sleep_ptr for acpi_button_pm in acpi_button_driver.
-Fix the warning:
>> drivers/acpi/button.c:164:12: warning: function 'acpi_button_suspend' has internal linkage but is not defined [-Wundefined-internal]
     164 | static int acpi_button_suspend(struct device *dev);
         |            ^
   drivers/acpi/button.c:167:49: note: used here
     167 | static DEFINE_SIMPLE_DEV_PM_OPS(acpi_button_pm, acpi_button_suspend, acpi_button_resume);
         |                                                 ^
>> drivers/acpi/button.c:165:12: warning: function 'acpi_button_resume' has internal linkage but is not defined [-Wundefined-internal]
     165 | static int acpi_button_resume(struct device *dev);
         |            ^
   drivers/acpi/button.c:167:70: note: used here
     167 | static DEFINE_SIMPLE_DEV_PM_OPS(acpi_button_pm, acpi_button_suspend, acpi_button_resume);
         |                                                                      ^
   2 warnings generated.
---
 drivers/acpi/button.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index cdbb1023a8ee..1df7e268c4dd 100644
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
@@ -176,7 +172,7 @@ static struct platform_driver acpi_button_driver = {
 	.driver = {
 		.name = "acpi-button",
 		.acpi_match_table = button_device_ids,
-		.pm = &acpi_button_pm,
+		.pm = pm_sleep_ptr(&acpi_button_pm),
 	},
 };
 
@@ -502,7 +498,6 @@ static u32 acpi_button_event(void *data)
 	return ACPI_INTERRUPT_HANDLED;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int acpi_button_suspend(struct device *dev)
 {
 	struct acpi_button *button = dev_get_drvdata(dev);
@@ -532,7 +527,6 @@ static int acpi_button_resume(struct device *dev)
 	}
 	return 0;
 }
-#endif
 
 static int acpi_lid_input_open(struct input_dev *input)
 {
-- 
2.25.1

