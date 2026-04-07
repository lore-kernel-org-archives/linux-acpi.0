Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338D13A3E6C;
	Tue,  7 Apr 2026 08:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775549510; cv=none; b=rhRkLnRClT7xNb/4l0oX666zoyEMv7lb4JyfXQDSzvS09ZgPhpiTP97ENGwhyYhZQrSHb/HIi83IaR+xmBYGIL4s5+UjyWEk2d0kOq0YpHlYcMs10xr0kXN9K6MwDlf2vrjRR0+lq8T5p3BB3UqQRFjt/xYcSPaxjlkSsvyfae0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775549510; c=relaxed/simple;
	bh=oqx0mRd+G1bJcko2+j6ho0mrFTk+bmPcN3zuDIv58D8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kW7qF/8yvM1dv9ZvPQNxfu97YZZdrZ+iOv1KPFwsTXOktvbwyldKwV/XOz8/Cc7Uen1/drKf3q2e0lhPlkBItAOeAl8Dz51alkZOhal/S6WFPMOBB7GSOWfrHtfZ3GmVdQBAZn6fTFmdRC1xFdGxc+6COELfU0IpUq7OqGoLCyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=VuG7V0UT; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="VuG7V0UT"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=l2kbwSfZf9Q/mjHICaj2YLekrSa0aF1y58vNIFtGeoY=;
	b=VuG7V0UTVmA5ajFrfZUkEotKSIJ9x5iu+JpyDfsvQNJUaNmG5jkPs9blZqpG5XheUjY0+QgzC
	PBTApyaFN1T7PLqnyKTaJdsqlrCw5Q+HVb0x3+qHLAYs389awDicFGuN/aJrychSqR2tBUOnvj2
	KxMXpt7r5B7O2FEgSAvpDj4=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4fqf0309c5z1T4G8;
	Tue,  7 Apr 2026 16:05:55 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 5192C40572;
	Tue,  7 Apr 2026 16:11:44 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 7 Apr 2026 16:11:44 +0800
Received: from localhost.localdomain (10.50.163.32) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 7 Apr 2026 16:11:43 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>,
	<wangzhi12@huawei.com>, <zhangpengjie2@huawei.com>,
	<wanghuiqiang@huawei.com>, <lihuisong@huawei.com>
Subject: [PATCH v2 2/2] ACPI: processor: idle: Fix incorrect power management decisions after power notify
Date: Tue, 7 Apr 2026 16:11:41 +0800
Message-ID: <20260407081141.2493581-3-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260407081141.2493581-1-lihuisong@huawei.com>
References: <20260407081141.2493581-1-lihuisong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemn100009.china.huawei.com (7.202.194.112)

When a power notification event occurs, existing ACPI idle states may
become obsolete. The current implementation only performs a partial
update, leaving critical cpuidle parameters—such as target_residency_ns
and exit_latency_ns—stale. Furthermore, per-CPU cpuidle_device data,
including last_residency_ns, states_usage, and the disable flag, are not
properly synchronized. Using these stale values leads to incorrect power
management decisions.

To ensure all parameters are correctly synchronized, modify the
notification handling logic:
1. Unregister all cpuidle_device instances to ensure a clean slate.
2. Unregister and re-register the ACPI idle driver. This forces the
   framework to re-evaluate global state parameters and ensures the
   driver state matches the new hardware power profile.
3. Re-initialize power information and re-register cpuidle_device for
   all possible CPUs to restore functional idle management.

This complete reset ensures that the cpuidle framework and the underlying
ACPI states are perfectly synchronized after a power state change.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/acpi/processor_idle.c | 45 +++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 479995a4c48a..f0054b2b20c1 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1308,37 +1308,42 @@ int acpi_processor_power_state_has_changed(struct acpi_processor *pr)
 	 */
 
 	if (pr->id == 0 && cpuidle_get_driver() == &acpi_idle_driver) {
-
 		/* Protect against cpu-hotplug */
 		cpus_read_lock();
-		cpuidle_pause_and_lock();
 
-		/* Disable all cpuidle devices */
-		for_each_online_cpu(cpu) {
+		/* Unregister cpuidle device of all CPUs */
+		cpuidle_pause_and_lock();
+		for_each_possible_cpu(cpu) {
+			dev = per_cpu(acpi_cpuidle_device, cpu);
 			_pr = per_cpu(processors, cpu);
-			if (!_pr || !_pr->flags.power_setup_done)
+			if (!_pr || !_pr->flags.power || !dev)
 				continue;
-			dev = per_cpu(acpi_cpuidle_device, cpu);
-			cpuidle_disable_device(dev);
+
+			cpuidle_unregister_device_no_lock(dev);
+			kfree(dev);
+			_pr->flags.power = 0;
 		}
+		cpuidle_resume_and_unlock();
 
-		/* Populate Updated C-state information */
-		acpi_processor_get_power_info(pr);
-		acpi_processor_setup_cpuidle_states(pr);
+		/*
+		 * Unregister ACPI idle driver, reinitialize ACPI idle states
+		 * and register ACPI idle driver again.
+		 */
+		acpi_processor_unregister_idle_driver();
+		acpi_processor_register_idle_driver();
 
-		/* Enable all cpuidle devices */
-		for_each_online_cpu(cpu) {
+		/*
+		 * Reinitialize power information of all CPUs and re-register
+		 * all cpuidle devices. Now idle states is ok to use, can enable
+		 * cpuidle of each CPU safely one by one.
+		 */
+		for_each_possible_cpu(cpu) {
 			_pr = per_cpu(processors, cpu);
-			if (!_pr || !_pr->flags.power_setup_done)
+			if (!_pr)
 				continue;
-			acpi_processor_get_power_info(_pr);
-			if (_pr->flags.power) {
-				dev = per_cpu(acpi_cpuidle_device, cpu);
-				acpi_processor_setup_cpuidle_dev(_pr, dev);
-				cpuidle_enable_device(dev);
-			}
+			acpi_processor_power_init(_pr);
 		}
-		cpuidle_resume_and_unlock();
+
 		cpus_read_unlock();
 	}
 
-- 
2.33.0

