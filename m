Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228A01E9906;
	Fri,  3 Apr 2026 09:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775206983; cv=none; b=gLsFjR6O9n1ksH1kPkb4Ra0LRb8+oPuSPJIHIjj6KJGJU9gt8yZQ9nXjpTeGZcYdBT0m+XwRMD0NNpGwe/WiKBWi3oGOv1KCmE3xWbR78LPUm1PqnvZURJtmRazj8HWbN+nmRXQaJRdC3cQzTHKZ25FbU494Xxvc2Q4eMSmpOZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775206983; c=relaxed/simple;
	bh=oHgnLsESaBzRthoqqqnf/65q1igUK2snZTuYNKRSvp8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gu17JeSTmnGhwTw+EAW2ixx7upXsly/PzNEWVUewZ/1TXQTR1eqfwgDdFkSkETqA8uibY1+ZdtE6K29dixZM/16a78yf4Z/hVuIZs6u0zVylKdzCqjD+7DuEe0zi9jaweD19bO2okmXvSeIOsPIV6O/K633BZn67DziLwIJHtA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=kSXOA/yB; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=kSXOA/yB; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="kSXOA/yB";
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="kSXOA/yB"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=anOT8bGurbxJptjoEKZ9kahhNJjJfa6fle0uyAj5Kfg=;
	b=kSXOA/yB8dxuRwSYPfihcWkqqJZtmTpX+9u4odSGiWi1mGq1Dv3FznK5lf4gI0meMd4gU0esJ
	Qedum3ktzSbjOwh83//riv+PyEQ6Qxi1Ti78A+cTdn8/eFYDKLAP4hFBtJPn/DSeMWSbsEIIhuO
	9AaqGU30GpRV9DORnvs61bE=
Received: from canpmsgout03.his.huawei.com (unknown [172.19.92.159])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4fnCRL38rsz1BG6X;
	Fri,  3 Apr 2026 17:02:38 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=anOT8bGurbxJptjoEKZ9kahhNJjJfa6fle0uyAj5Kfg=;
	b=kSXOA/yB8dxuRwSYPfihcWkqqJZtmTpX+9u4odSGiWi1mGq1Dv3FznK5lf4gI0meMd4gU0esJ
	Qedum3ktzSbjOwh83//riv+PyEQ6Qxi1Ti78A+cTdn8/eFYDKLAP4hFBtJPn/DSeMWSbsEIIhuO
	9AaqGU30GpRV9DORnvs61bE=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4fnCJv1XnrzpTJn;
	Fri,  3 Apr 2026 16:57:03 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id A82EA40576;
	Fri,  3 Apr 2026 17:02:54 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 3 Apr 2026 17:02:54 +0800
Received: from localhost.localdomain (10.50.163.32) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 3 Apr 2026 17:02:53 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>,
	<wangzhi12@huawei.com>, <zhangpengjie2@huawei.com>,
	<wanghuiqiang@huawei.com>, <lihuisong@huawei.com>
Subject: [PATCH] ACPI: processor: idle: Fix NULL pointer dereference in hotplug path
Date: Fri, 3 Apr 2026 17:02:53 +0800
Message-ID: <20260403090253.998322-1-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
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

A cpuidle_device might fail to register during boot, but the system can
continue to run. In such cases, acpi_processor_hotplug() can trigger
a NULL pointer dereference when accessing the per-cpu acpi_cpuidle_device.

So add NULL pointer check for the per-cpu acpi_cpuidle_device in
acpi_processor_hotplug.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/acpi/processor_idle.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 479995a4c48a..2adaee0f32ed 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1267,16 +1267,15 @@ static int acpi_processor_get_power_info(struct acpi_processor *pr)
 
 int acpi_processor_hotplug(struct acpi_processor *pr)
 {
+	struct cpuidle_device *dev = per_cpu(acpi_cpuidle_device, pr->id);
 	int ret = 0;
-	struct cpuidle_device *dev;
 
 	if (disabled_by_idle_boot_param())
 		return 0;
 
-	if (!pr->flags.power_setup_done)
+	if (!pr->flags.power_setup_done || !dev)
 		return -ENODEV;
 
-	dev = per_cpu(acpi_cpuidle_device, pr->id);
 	cpuidle_pause_and_lock();
 	cpuidle_disable_device(dev);
 	ret = acpi_processor_get_power_info(pr);
-- 
2.33.0

