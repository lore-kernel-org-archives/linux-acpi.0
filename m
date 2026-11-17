Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794906976;
	b=SQmOfcrO1dRm01OS0YCpFs2jSj/lz2RfEJTcEy6Q2kG4IZl7v1nZtaZxyG/hdgFbkVlI
	 nnP1/aExGqPdQmJ9sAv1kvtKdRA5aIWgXvoUqkmNCE1vMD+vLvUe5buTYisnQpcy/qLrE
	 UxbMrEXS4z8WCiWyE14WdZdiNEr7kXIVxLHuAI0smAHxyYry0NcByu2AIeUuBhpjApbjK
	 uWk1w9csm9bzq2qHfnplAd7uDfdZr6Ye5/uAh2Lfzulw81IGTh3cj2Bbom0Bkz8egDv0w
	 z2KAgoxPrTqt1BWr47kwuu/65cOGzdtYhBd+KnoiFr8Ga4LSjg+HJx5uAOvb0OQ3fFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794906976;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ZmSPDMWm7EGKlp5jjfVoyVP81u0WZlpGLRb6db7fA3w=;
	b=FmYEDgsRTyWQt9SLi2d8nfefnbZ9cGJ+NgH+Op1SiE5C2PTxddn+hlGKxwHByPtLtC6T
	 lDwWXcFhESeKuU2UEOx+oiTL9G4a97x61wyMATvAFEJjvDBsMRRgXvFIDxkPOVpm7wmRW
	 xHvdMoOYW/efk1pGaO6qj05y2YgiGJvw3REIsOMAvhgRqAt0biZVRiHVxWA/BocGF1MVf
	 q1mEp+/696o2rIi7Xf0u/kWFXpFrSkLYw45HJl1GZ3bnMrKRLXFeBvFP5XUXR2xFDb8lt
	 E6vHPAY+XpAAVB9Wa4H811VSp9MDFDNg6AIum7YYAt+dSQY3Oa7IsFtpb4ou0Ur3/HQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b="BoHCAHF/";
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDD0606A31C;
	Tue, 17 Nov 2026 09:16:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BDD0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=BoHCAHF/
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A6CE1682;
	Tue, 17 Nov 2026 01:16:12 -0800 (PST)
Received: from e127648.cambridge.arm.com (e127648.arm.com [10.0.130.226])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CD9E83F673;
	Tue, 17 Nov 2026 01:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794906975; bh=qhhkNaaqsoCbAT3tlJ8OFoWJOLhxKvrUFRqo2DM7EEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BoHCAHF/AV37DGR5Uv2tW+ru+gk9ltoGIlNvM4EEJ37LDF08h3V8cHr+kF3PgUKI+
	 A7NoTHOM8WfQb3E5NaPo9XB+X9g8VPp1y9JWMEA4nmybxGD5tEPEtYUUzXu1XdsVGS
	 O5IcRByrPncyPkAabkPj6eeAPyiO+dFwbVq/PUFs=
From: Christian Loehle <christian.loehle@arm.com>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: ashwin.chaugule@linaro.org,
	al.stone@linaro.org,
	miguel.luis@oracle.com,
	catalin.marinas@arm.com,
	Jonathan.Cameron@huawei.com,
	gshan@redhat.com,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christian Loehle <christian.loehle@arm.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH 2/2] ACPI: processor: Prevent unsafe module unloading
Date: Tue, 17 Nov 2026 09:15:34 +0000
Message-Id: <20261117091534.895868-3-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261117091534.895868-1-christian.loehle@arm.com>
References: <20261117091534.895868-1-christian.loehle@arm.com>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unloading processor.ko unregisters its cpufreq notifier without removing
the performance and thermal QoS requests from existing policies. Active
limits remain applied. If a policy is destroyed while the notifier is
absent, its freed constraints remain referenced by those requests.
After processor is reloaded, removing a replacement policy accesses
freed
memory.

Module unload can also free CPPC descriptors while cppc_cpufreq still
uses them: CPPC accessor symbols are built in and do not themselves pin
processor.ko.

Remove module_exit() and the CPU-hotplug state used only by it. Keep
ACPI_PROCESSOR tristate so processor.ko and its load-time parameters
remain available.

Fixes: 4f2f757351df ("CPPC: Probe for CPPC tables for each ACPI Processor object")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260807111303.1062391-1-christian.loehle%40arm.com
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 drivers/acpi/processor_driver.c | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index 59418b2e09b6..38783689a319 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -234,12 +234,6 @@ static struct notifier_block acpi_processor_notifier_block = {
 void __weak acpi_processor_init_invariance_cppc(void)
 { }
 
-/*
- * We keep the driver loaded even when ACPI is not running.
- * This is needed for the powernow-k8 driver, that works even without
- * ACPI, but needs symbols from this driver
- */
-static enum cpuhp_state hp_online;
 static int __init acpi_processor_driver_init(void)
 {
 	int result = 0;
@@ -264,7 +258,6 @@ static int __init acpi_processor_driver_init(void)
 				   acpi_soft_cpu_online, NULL);
 	if (result < 0)
 		goto err;
-	hp_online = result;
 	cpuhp_setup_state_nocalls(CPUHP_ACPI_CPUDRV_DEAD, "acpi/cpu-drv:dead",
 				  NULL, acpi_soft_cpu_dead);
 
@@ -295,24 +288,6 @@ static int __init acpi_processor_driver_init(void)
 	return result;
 }
 
-static void __exit acpi_processor_driver_exit(void)
-{
-	if (acpi_disabled)
-		return;
-
-	if (acpi_processor_cpufreq_init) {
-		cpufreq_unregister_notifier(&acpi_processor_notifier_block,
-					    CPUFREQ_POLICY_NOTIFIER);
-		acpi_processor_cpufreq_init = false;
-	}
-
-	cpuhp_remove_state_nocalls(hp_online);
-	cpuhp_remove_state_nocalls(CPUHP_ACPI_CPUDRV_DEAD);
-	driver_unregister(&acpi_processor_driver);
-	acpi_processor_unregister_idle_driver();
-}
-
 module_init(acpi_processor_driver_init);
-module_exit(acpi_processor_driver_exit);
 
 MODULE_ALIAS("processor");
-- 
2.34.1

