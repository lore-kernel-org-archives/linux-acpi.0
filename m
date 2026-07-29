Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62057281369;
	Wed, 29 Jul 2026 02:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785292602; cv=none; b=qc2EWFsUuvQS9H7au5ub0gEuHSvMFIOVwGMIHbbI32KmqDz/jaJkKf4y7xRAynMDOG1P2Pxo9GVExoCLWoAJUzYSvI4MrWJuU00cCwrQiASbS3UX5d4iGXxkunisYAnEYWVD0wqxGutN3CTbgmpfDAyUFByoazc2a3gf1rxSqXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785292602; c=relaxed/simple;
	bh=FL6E0hcqJ1aqTYgp+5GIB9KY9shn8xkdVKYzsskMAhM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cBs0PApDV1lY1Y7bRn947zBt4CaFvmfkBI8ZIsFktOCdEvAWXaPKveG14CktB9ur2DY47LaRYGZdLf9npLy5xW3N7WYBpWOMlZ85CxCLUhTLE4M8n1le6pr/Op7FxNeOz5jGgof5VcXdftsAQvuOE21QpT3x0L3/RWhhi8DUGq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 4fba5cb68af611f1aa26b74ffac11d73-20260729
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:fd3e1716-c182-406f-a48c-89859c52114b,IP:15,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:10
X-CID-INFO: VERSION:1.3.12,REQID:fd3e1716-c182-406f-a48c-89859c52114b,IP:15,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:10
X-CID-META: VersionHash:e7bac3a,CLOUDID:eac4660e84c7a918c6ddadb1f8e5a3aa,BulkI
	D:260729103635M338QICH,BulkQuantity:0,Recheck:0,SF:10|66|78|102|127|136|86
	5|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,Q
	S:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,
	ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 4fba5cb68af611f1aa26b74ffac11d73-20260729
X-User: pengcan@kylinos.cn
Received: from lenovo [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <pengcan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1816382487; Wed, 29 Jul 2026 10:36:32 +0800
From: Can Peng <pengcan@kylinos.cn>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Can Peng <pengcan@kylinos.cn>
Subject: [PATCH] ACPI: processor: Unregister cpufreq notifier on init failure
Date: Wed, 29 Jul 2026 10:36:05 +0800
Message-ID: <20260729023605.197367-1-pengcan@kylinos.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

acpi_processor_driver_init() registers the cpufreq policy notifier before
registering the ACPI processor driver and setting up CPU hotplug state.

If driver_register() or cpuhp_setup_state() fails, the error path only
unregisters the ACPI processor driver and the idle driver. The cpufreq
notifier remains registered even though initialization failed.

Mirror the module exit path on the init failure path and unregister the
cpufreq notifier when it has been registered.

Fixes: c0e0421a60bf ("ACPI: processor: Reorder acpi_processor_driver_init()")
Signed-off-by: Can Peng <pengcan@kylinos.cn>
---
 drivers/acpi/processor_driver.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index cda8fd720000..cdc2ae1632b2 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -285,6 +285,12 @@ static int __init acpi_processor_driver_init(void)
 unregister_idle_drv:
 	acpi_processor_unregister_idle_driver();
 
+	if (acpi_processor_cpufreq_init) {
+		cpufreq_unregister_notifier(&acpi_processor_notifier_block,
+					    CPUFREQ_POLICY_NOTIFIER);
+		acpi_processor_cpufreq_init = false;
+	}
+
 	return result;
 }
 
-- 
2.53.0

