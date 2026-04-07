Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8683A4F28;
	Tue,  7 Apr 2026 08:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775549514; cv=none; b=tcBglPp06DpKzIAPJ369TYCWDMSlfm0LL5cjGG1xk0fcEHlsdja5/C5DVBxRwV/5+08sD12AH8kvidlXXoVCFSj6RVdQM1SSrmv72WXZVNI5L4NOuhsJZL0OSb16GZF40+N9Sh3P4x0+i/UozDtcw5g+LEfVd670zixXCsXkLHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775549514; c=relaxed/simple;
	bh=g1Wh0R9jijtfXOcgDELEFsrp+Q8V53OEkIe99gncOgE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ot+0WoLZVFLwoLk5nmYUBmDT8fEx4C83nSL+AchmqQY3U7LTbfIO777ScvyK2O4dA8qz4ZehHeXUCLpqacTCmEq9/VkB+EQ1YPBEZ3qiPZS6C40yWN4bnPOQUBZ6GZy8YM78ObYgEDQU7ZRH9trosFSRewQC3MOGl/Q8i99K8Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=hLRBkrti; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="hLRBkrti"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=6l3P5boeGFq+EiXiXHGw4BqYbEDycr3R/Ebl/pvtd7o=;
	b=hLRBkrtiIBBKMHOP0P4Xr0a0WO9US9rjMXRUuW4Rjetjv09LdSd0l9bjXgZA4fpeZkLV4Gz8c
	cHCPp6/XBqkDgyQWV3/wHv6aGKmMkCvFBa095HkoMxO6G07MoS9KInX7Yt/JTkCBmx/Pm8rw1vz
	kPE0vYRl6qrgNSz7WjInI8A=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4fqdzP08CBz12LF5;
	Tue,  7 Apr 2026 16:05:21 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 9F5ED40571;
	Tue,  7 Apr 2026 16:11:43 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 7 Apr 2026 16:11:43 +0800
Received: from localhost.localdomain (10.50.163.32) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 7 Apr 2026 16:11:42 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>,
	<wangzhi12@huawei.com>, <zhangpengjie2@huawei.com>,
	<wanghuiqiang@huawei.com>, <lihuisong@huawei.com>
Subject: [PATCH v2 1/2] cpuidle: Extract and export no-lock variants of cpuidle_unregister_device
Date: Tue, 7 Apr 2026 16:11:40 +0800
Message-ID: <20260407081141.2493581-2-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260407081141.2493581-1-lihuisong@huawei.com>
References: <20260407081141.2493581-1-lihuisong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemn100009.china.huawei.com (7.202.194.112)

The cpuidle_unregister_device() function always acquire the internal
cpuidle_lock (or pause/resume idle) during their execution.
However, in some power notification scenarios (e.g., when old idle
states may become unavailable), it is necessary to efficiently disable
cpuidle first, then remove and re-create all cpuidle devices for all
CPUs. To avoid frequent lock overhead and ensure atomicity across the
entire batch operation, the caller needs to hold the cpuidle_lock once
outside the loop.

To address this, extract the core logic into the new function
cpuidle_unregister_device_no_lock() and export it.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/cpuidle/cpuidle.c | 22 +++++++++++++++-------
 include/linux/cpuidle.h   |  2 ++
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index c7876e9e024f..1a55542efead 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -714,16 +714,12 @@ int cpuidle_register_device(struct cpuidle_device *dev)
 
 EXPORT_SYMBOL_GPL(cpuidle_register_device);
 
-/**
- * cpuidle_unregister_device - unregisters a CPU's idle PM feature
- * @dev: the cpu
- */
-void cpuidle_unregister_device(struct cpuidle_device *dev)
+void cpuidle_unregister_device_no_lock(struct cpuidle_device *dev)
 {
 	if (!dev || dev->registered == 0)
 		return;
 
-	cpuidle_pause_and_lock();
+	lockdep_assert_held(&cpuidle_lock);
 
 	cpuidle_disable_device(dev);
 
@@ -732,10 +728,22 @@ void cpuidle_unregister_device(struct cpuidle_device *dev)
 	__cpuidle_unregister_device(dev);
 
 	cpuidle_coupled_unregister_device(dev);
+}
+EXPORT_SYMBOL_GPL(cpuidle_unregister_device_no_lock);
+
+/**
+ * cpuidle_unregister_device - unregisters a CPU's idle PM feature
+ * @dev: the cpu
+ */
+void cpuidle_unregister_device(struct cpuidle_device *dev)
+{
+	if (!dev || dev->registered == 0)
+		return;
 
+	cpuidle_pause_and_lock();
+	cpuidle_unregister_device_no_lock(dev);
 	cpuidle_resume_and_unlock();
 }
-
 EXPORT_SYMBOL_GPL(cpuidle_unregister_device);
 
 /**
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 4073690504a7..2ead2d8c57e6 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -188,6 +188,7 @@ extern void cpuidle_driver_state_disabled(struct cpuidle_driver *drv, int idx,
 extern void cpuidle_unregister_driver(struct cpuidle_driver *drv);
 extern int cpuidle_register_device(struct cpuidle_device *dev);
 extern void cpuidle_unregister_device(struct cpuidle_device *dev);
+extern void cpuidle_unregister_device_no_lock(struct cpuidle_device *dev);
 extern int cpuidle_register(struct cpuidle_driver *drv,
 			    const struct cpumask *const coupled_cpus);
 extern void cpuidle_unregister(struct cpuidle_driver *drv);
@@ -226,6 +227,7 @@ static inline void cpuidle_unregister_driver(struct cpuidle_driver *drv) { }
 static inline int cpuidle_register_device(struct cpuidle_device *dev)
 {return -ENODEV; }
 static inline void cpuidle_unregister_device(struct cpuidle_device *dev) { }
+static void cpuidle_unregister_device_no_lock(struct cpuidle_device *dev) {}
 static inline int cpuidle_register(struct cpuidle_driver *drv,
 				   const struct cpumask *const coupled_cpus)
 {return -ENODEV; }
-- 
2.33.0

