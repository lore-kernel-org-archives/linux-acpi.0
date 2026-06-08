Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [61.152.208.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B9E314D26
	for <linux-acpi@vger.kernel.org>; Mon,  8 Jun 2026 06:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.152.208.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780901869; cv=none; b=V687t9s7Um5M6TPI07vUqzA1bZDS72lesZfjspgNysTHBO/ShKE0iQ4yEjWpL+mQgyhsbdXF0qdFgQGf/8Pm+oDXCgLB+7TIZDrOFKQkDhxSfPToCsAuI0ZvRHBNGmNS9ca2DysGDGUmQdGwhKJ4a0kdiRc6Zu6BxfTc4eG6+zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780901869; c=relaxed/simple;
	bh=nuqwfnAi7m9ElUia3NkeHdJPWTp9ksbRJM1+Ijzw9yU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V6RLATalelu5GlUJ4M5n+a0AbFfHv3JG6exEGozZ+kFjZ5dquBA2456BHuXgVIzz1t+uzk03H1Ib3806KFKOfjXY+P+kroYw5OndejV6UTvFstR181MVnP1DKeD3m6gTIzBi2eGC17tWFnoha+uuVMIU6v5ojXquQtWDaBIMlu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=61.152.208.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1780900682-1eb14e680bb3840001-I98ny2
Received: from zhaoxin.com (zxmail.zhaoxin.com [10.28.208.166]) by mx2.zhaoxin.com with ESMTP id 03JPishJRrtBF13J; Mon, 08 Jun 2026 14:38:02 +0800 (CST)
X-Barracuda-Envelope-From: TonyWWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.208.166
Received: from tony.zhaoxin.com (tony.zhaoxin.com [10.32.68.20])
	by zhaoxin.com (8.30) with ESMTPd70c6cf01bac5789aea9bebb83775084
	Mon, 08 Jun 2026 14:38:01 +0800
X-Eyou-Smtpauth: tonywwangoc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.32.68.20
X-Eyou-EnvelopeSender: TonyWWang-oc@zhaoxin.com
X-Eyou-From: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
From: "=?UTF-8?B?VG9ueSBXIFdhbmctb2M=?=" <TonyWWang-oc@zhaoxin.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lihuisong@huawei.com
Cc: CobeChen@zhaoxin.com,
	LindaChai@zhaoxin.com
Subject: [PATCH] ACPI: processor: Add cpuidle driver check in acpi_processor_register_idle_driver
Date: Mon,  8 Jun 2026 14:38:12 +0800
X-ASG-Orig-Subj: [PATCH] ACPI: processor: Add cpuidle driver check in acpi_processor_register_idle_driver
Message-Id: <20260608063812.2533-1-TonyWWang-oc@zhaoxin.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Eyou-Sender: <tonywwang-oc@zhaoxin.com>
X-Barracuda-Connect: zxmail.zhaoxin.com[10.28.208.166]
X-Barracuda-Start-Time: 1780900682
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1390
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -0.96
X-Barracuda-Spam-Status: No, SCORE=-0.96 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=FROM_EXCESS_BASE64, FROM_EXCESS_BASE64_2
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.159744
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.01 FROM_EXCESS_BASE64     From: base64 encoded unnecessarily
	1.05 FROM_EXCESS_BASE64_2   From: base64 encoded unnecessarily

Commit 7a8c994cbb2d ("ACPI: processor: idle: Optimize ACPI idle
driver registration") moved the ACPI idle driver registration to
acpi_processor_driver_init(), but it didn't check whether a cpuidle
driver was already registered.

For example, on Intel platforms, if the intel_idle driver is already
loaded, the code would still evaluate the _CST object in the ACPI
table and attempt to register the acpi_idle driver. This registration
would fail with -EBUSY due to the existing check in cpuidle_register_driver.

Add a check at the beginning of acpi_processor_register_idle_driver()
to avoid unnecessary _CST evaluate and potential registration failures.

Fixes: 7a8c994cbb2d ("ACPI: processor: idle: Optimize ACPI idle driver registration") 
Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
---
 drivers/acpi/processor_idle.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index ee5facccbe10..0409411abb83 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1355,6 +1355,11 @@ void acpi_processor_register_idle_driver(void)
 	int ret = -ENODEV;
 	int cpu;
 
+	if (cpuidle_get_driver()) {
+		pr_debug("cpuidle driver %pS already registered.\n", cpuidle_get_driver());
+		return;
+	}
+
 	acpi_processor_update_max_cstate();
 
 	/*
-- 
2.25.1

