Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4488D37B025;
	Fri,  3 Apr 2026 08:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775206430; cv=none; b=AquOcA1jGTojZMdDCKx89F4x9Ozo2LOYQPblQxs6QmuXlOtbKrj3NGkTZMCCRGi32Iig2ntW2Ny/VoIcqw4MgU4xt9sMViN2zvGkDZOFB/S46/MjeJH9fXe6BJ1At1pa4Ms7JlZp+80+vFge8wwtPwblvw+CHI7wW+gBxTNcpRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775206430; c=relaxed/simple;
	bh=7hljSfbCMoe7aotArStlInJGZBHF3UccXe+EzzmK7cw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZNmiB6n/yYzNk4eY8pP2wGtrAbyhrrKxjyikdDgK7eG104jpWuC/gNFV0HUfQXm/4oCNnH2jqP4NNYrdofTP62OQ0yxMum12NyTSprF8S1ZpfUyDdOMe0W7tLV+csIG0xTzlRZt4lLVPu8URMUd20juxWH5r79DkD3sTWG+LhvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=FtXXLtRi; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="FtXXLtRi"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=pl97eqEMyiskpjfdPoPG1e9P8KOX2jBc3sUg0vI9cns=;
	b=FtXXLtRiIWaGA6TLuC9cuCjD1SOc3ewmpHPj0B56OzkshH4KozGpv3cAk6KhzrXC1cfP/SjX/
	+xB/piM0mublGGwSdSeVJLgYQ2JSkKIl+WDeAq82RmnvBbQDTakmasD/yAQMsCjXu1Fq8V6QoV2
	bTdHFaQZyvAKh2qkbvAw6M8=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4fnC5y0kSdzRhTp;
	Fri,  3 Apr 2026 16:47:34 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 2395340561;
	Fri,  3 Apr 2026 16:53:45 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 3 Apr 2026 16:53:44 +0800
Received: from localhost.localdomain (10.50.163.32) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 3 Apr 2026 16:53:44 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>,
	<wangzhi12@huawei.com>, <zhangpengjie2@huawei.com>,
	<wanghuiqiang@huawei.com>, <lihuisong@huawei.com>
Subject: [PATCH] ACPI: processor: idle: Reset power_setup_done flag on initialization failure
Date: Fri, 3 Apr 2026 16:53:43 +0800
Message-ID: <20260403085343.866440-1-lihuisong@huawei.com>
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

The 'power_setup_done' flag is a key indicator used across the ACPI
processor driver to determine if cpuidle are properly configured and
available for a given CPU.

Currently, this flag is set during the early stages of initialization.
However, if the subsequent registration of the cpuidle driver in
acpi_processor_register_idle_driver() or the per-CPU device registration
in acpi_processor_power_init() fails, this flag remains set. This may
lead to some issues where other functions in ACPI idle driver use these
flags.

Fix this by explicitly resetting this flag to 0 in these error paths.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/acpi/processor_idle.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 2adaee0f32ed..c1cddb4a5887 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1378,6 +1378,7 @@ void acpi_processor_register_idle_driver(void)
 
 	ret = cpuidle_register_driver(&acpi_idle_driver);
 	if (ret) {
+		pr->flags.power_setup_done = 0;
 		pr_debug("register %s failed.\n", acpi_idle_driver.name);
 		return;
 	}
@@ -1386,7 +1387,16 @@ void acpi_processor_register_idle_driver(void)
 
 void acpi_processor_unregister_idle_driver(void)
 {
+	struct acpi_processor *pr;
+	int cpu;
+
 	cpuidle_unregister_driver(&acpi_idle_driver);
+	for_each_possible_cpu(cpu) {
+		pr = per_cpu(processors, cpu);
+		if (!pr)
+			continue;
+		pr->flags.power_setup_done = 0;
+	}
 }
 
 void acpi_processor_power_init(struct acpi_processor *pr)
@@ -1423,6 +1433,7 @@ void acpi_processor_power_init(struct acpi_processor *pr)
 	 */
 	if (cpuidle_register_device(dev)) {
 		per_cpu(acpi_cpuidle_device, pr->id) = NULL;
+		pr->flags.power_setup_done = 0;
 		kfree(dev);
 	}
 }
-- 
2.33.0

