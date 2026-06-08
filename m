Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [61.152.208.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA943148A8
	for <linux-acpi@vger.kernel.org>; Mon,  8 Jun 2026 11:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.152.208.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780916649; cv=none; b=UXsFYudLZ/tyH/MDdc/XHxIdI3rsMpIfKUsFlUNNYhB9z9ferh1ml5Z48BIMTWF2B6FnnwvOcXvia7SRx6VLGwH13oZv1YtZubhGEO7PfqOdpDtGUPKz+PsQQg2o3P2bf4PpING/LK2qXh4063EaOmnFGHcYoaGOlcS1RKLhCRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780916649; c=relaxed/simple;
	bh=pEJbJ1whJG/2yLCkd6qb9pQOoKdQSBP+GfGiWAC36Vk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=upXkhhqsJmjMazaRH8TnnU1UgCq/88/b8Rwz7RuSa6E2FUKV2Yf7l7kXmWsnTSVpJx8fWe+h6ATIN+Kdz/8dE5j8YYzjlMr5GGZrhuDOi7rLCey8EMXdRtBXuPdNMbzc+FCpcavprdRh2tjaz2LpXs7tAp6up9+L/0mjH8+wIBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=61.152.208.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1780916641-1eb14e680bb4b50001-I98ny2
Received: from zhaoxin.com (zxmail.zhaoxin.com [10.28.208.166]) by mx2.zhaoxin.com with ESMTP id tVFxHT96xHqPFHWN; Mon, 08 Jun 2026 19:04:01 +0800 (CST)
X-Barracuda-Envelope-From: TonyWWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.208.166
Received: from tony.zhaoxin.com (tony.zhaoxin.com [10.32.68.20])
	by zhaoxin.com (8.30) with ESMTPcbfc5570f0c2464d0c233a07982d5084
	Mon, 08 Jun 2026 19:04:00 +0800
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
Subject: [PATCH v2] ACPI: processor: Add cpuidle driver check in acpi_processor_register_idle_driver
Date: Tue,  9 Jun 2026 03:03:59 +0800
X-ASG-Orig-Subj: [PATCH v2] ACPI: processor: Add cpuidle driver check in acpi_processor_register_idle_driver
Message-Id: <20260608190359.3254-1-TonyWWang-oc@zhaoxin.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <15af5635-e3a3-4ffc-9f02-82e35a95154f@huawei.com>
References: <15af5635-e3a3-4ffc-9f02-82e35a95154f@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Eyou-Sender: <tonywwang-oc@zhaoxin.com>
X-Barracuda-Connect: zxmail.zhaoxin.com[10.28.208.166]
X-Barracuda-Start-Time: 1780916641
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1648
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: 2.15
X-Barracuda-Spam-Status: No, SCORE=2.15 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=DATE_IN_FUTURE_06_12, DATE_IN_FUTURE_06_12_2, FROM_EXCESS_BASE64, FROM_EXCESS_BASE64_2
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.159753
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.01 DATE_IN_FUTURE_06_12   Date: is 6 to 12 hours after Received: date
	0.01 FROM_EXCESS_BASE64     From: base64 encoded unnecessarily
	3.10 DATE_IN_FUTURE_06_12_2 DATE_IN_FUTURE_06_12_2
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
Changes in v2:
- Added comment to explain why we skip registration when a driver is
  already present.

 drivers/acpi/processor_idle.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index ee5facccbe10..390ab5f1d313 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1355,6 +1355,15 @@ void acpi_processor_register_idle_driver(void)
 	int ret = -ENODEV;
 	int cpu;
 
+	/*
+	 * If a cpuidle driver is already registered, there is no need to
+	 * evaluate _CST or attempt to register the ACPI idle driver.
+	 */
+	if (cpuidle_get_driver()) {
+		pr_debug("cpuidle driver %pS already registered.\n", cpuidle_get_driver());
+		return;
+	}
+
 	acpi_processor_update_max_cstate();
 
 	/*
-- 
2.25.1

