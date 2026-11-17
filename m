Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794906973;
	b=valEvrufAUDb+nfoDfsmmwDz7Qm/kPRBtsB0Gb6/06UhcSGpY0ugiByS8bubjLQQ2UOW
	 yl/VZhQoDS8jWwnFtJKmRE02JIBBqmV8DmO9undSUuoKaY4sfdqb+R5q5rZBi8s9lz2nz
	 VsOAX16q/Nl+4/nHopBHBWLPby7NY2sM5HnK0cnWY9DHbiYGdkd2L8fHZ27GBCasn9fdB
	 a4Y/hH5vaGOUPNqBRYUiBS03j76dXlC2YB9Hry7y8DoVZVzJFfx36g9tgfLe0nZtjeHea
	 SSSgwgEsTTuRZhg+26SQdZiAiXns+/hyy3mlrHGfa+kOHPokmm0YaiU8HT4bDZRrBOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794906973;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dUOIOTGTRj5QVAzQVT7z/KD+Q1yNb53oTQ47fppAW04=;
	b=1lCgHnf5jEFt+FbkU69ZuQByn3XNmflV+uv/uJ49fa9DNuGR2iOtriPc0wcc7mQE9LUO
	 56rtf8MOnMMbfbMJkB2e7BaXjGQDL7UWY7n0cMBZdjjXu6fh0dMZwHYoSX9bHTBhrIPMa
	 5y/rWDI6um+xof+VlyoNQZTV12l0XcClqzmr0SsF27gbZp0OmolNXt2iLYWixl6R/PVvY
	 /kCAraD9+KzZ6OTcHf85mHeWa+buQ5GCvkQAlykJvIolbffuDksyNOghwktZV3gZxvET1
	 2x0eh27MQfCoMfgHXSpZ0mPhcqFxuKgSauaY9qqA4M5phhFyUwMR9GX+dlrfs9TfRng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=NwBPMFS9;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CA3606A335;
	Tue, 17 Nov 2026 09:16:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5CA3606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=NwBPMFS9
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C14614BF;
	Tue, 17 Nov 2026 01:16:09 -0800 (PST)
Received: from e127648.cambridge.arm.com (e127648.arm.com [10.0.130.226])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A32F03F673;
	Tue, 17 Nov 2026 01:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794906972; bh=M19sbnjzCS98Rn3h7gUo4OfcrpXOdHEc9DrjCL6uD8I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NwBPMFS9pvoBg4f5zSV/EezrbFrDgVmBXDLgVm3zkdqhUC349XiTm0flWq027aTx/
	 RlxMqO3cdxK625x4Vdwe1G6WGzLrnFl4VNv5JEY1FtHT/5FAqxXVF7M4qdTTyYXg/r
	 V+0h3Mr1FarOkt011KNeUgNGw7twJvim7FWiu+Ns=
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
	Sashiko <sashiko-bot@kernel.org>,
	Hanxiang Xu <xuhx@hust.edu.cn>
Subject: [PATCH 1/2] ACPI: processor: Disable unsafe manual bind/unbind
Date: Tue, 17 Nov 2026 09:15:33 +0000
Message-Id: <20261117091534.895868-2-christian.loehle@arm.com>
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

Manual unbind calls acpi_processor_stop() while the CPU is still online.
That breaks several users of processor state:

- acpi_idle frees its idle device but retains the per-CPU pointer and
  power flag. Bind cannot restore it because the driver has no probe
  callback; a second unbind accesses the freed device.
- processor_thermal unregisters its cooling device without resetting an
  active cpufreq QoS limit. The limit survives the no-op bind.
- CPPC descriptors are released while cppc_cpufreq, amd_pstate's shared
  memory backend or intel_pstate's base_frequency reader may use them.

Suppress manual bind/unbind. This also disables the driver core's
CONFIG_DEBUG_TEST_DRIVER_REMOVE remove/reprobe test, which exercises the
same unsafe teardown. CPU hotplug and physical CPU removal retain their
existing paths.

Fixes: 4f2f757351df ("CPPC: Probe for CPPC tables for each ACPI Processor object")
Fixes: c1385c1f0ba3 ("ACPI: processor: Simplify initial onlining to use same path for cold and hotplug")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260807111303.1062391-1-christian.loehle%40arm.com
Reported-by: Hanxiang Xu <xuhx@hust.edu.cn>
Link: https://lore.kernel.org/all/610cc333.22ad9.1a1c5903a6b.Coremail.xuhx@hust.edu.cn/
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 drivers/acpi/processor_driver.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index bdd1529d79f0..59418b2e09b6 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -45,6 +45,7 @@ MODULE_DEVICE_TABLE(acpi, processor_device_ids);
 static struct device_driver acpi_processor_driver = {
 	.name = "processor",
 	.bus = &cpu_subsys,
+	.suppress_bind_attrs = true,
 	.acpi_match_table = processor_device_ids,
 	.remove = acpi_processor_stop,
 };
-- 
2.34.1

