Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CB3367F5E;
	Wed, 11 Mar 2026 06:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773211852; cv=none; b=GFD7FOX2k3HR+F9TlSCfsrCVkdQ+GYoORgoaIS3lCxIMqyROiYYni3iM2kAQ7BRh4Ir4/ilWc5l+SlPrc377aVP1WuTIcOjMZwy0n6PzBCxJTUhabXRFfsQb7IqhKvaBQ3ECPwt/7rRJdDHpXPZVBPyYpl0+k4qT+BIBFXYO7ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773211852; c=relaxed/simple;
	bh=lAnPD2Pf8pKM0S8dX6Jy7HPgOEQFGRIz8NWOF+uuxi8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VTfz5trdUIshkME+A+xb5GnFAhLhZScEmhQZHaduVlVN7Bnx2lbaJT56RAJiUihUlpCe/7iHMOFF8L5csq2f7HiVE3/8XVHXOfAUBpUOurbD+TH0xwEKGL8W8yViZ4O2eb2VTZ68uuDeGvuGb+Mq23Khtq98k74T+XP3BjoaIms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=lXZRHCQp; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="lXZRHCQp"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=YieaDh5dmfo2YQisWC3c1tq3cHHE7rO8nEG0Wp8iFbo=;
	b=lXZRHCQpylbRSWd39qulSwCC8Mn9ZiirTk09w+EZvGLofD0u2QnLtKej6A/7XftRfShuDTEP4
	MHNJ9iSVTD7xVYGwyY5Ht/vGpU3q/3P2TWFGgMUKW7lzNXesBXC1e+fUvpHoMAqRqfCiCaC/Ok+
	yWvVp1LA7XY9EvH3sDwSOBo=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4fW1V42w3nz1K9Bb;
	Wed, 11 Mar 2026 14:45:48 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 5DB4F40570;
	Wed, 11 Mar 2026 14:50:41 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 11 Mar 2026 14:50:40 +0800
Received: from localhost.localdomain (10.50.163.32) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 11 Mar 2026 14:50:40 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <bp@alien8.de>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>,
	<zhangpengjie2@huawei.com>, <wangzhi12@huawei.com>, <lihuisong@huawei.com>
Subject: [PATCH v2 2/3] ACPI: processor: idle: Move max_cstate update out of the loop
Date: Wed, 11 Mar 2026 14:50:37 +0800
Message-ID: <20260311065038.4151558-3-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260311065038.4151558-1-lihuisong@huawei.com>
References: <20260311065038.4151558-1-lihuisong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemn100009.china.huawei.com (7.202.194.112)

The acpi_processor_cstate_first_run_checks() function, which updates
max_cstate on certain platforms, only needs to be executed once.
Move this call outside of the loop to avoid redundant executions.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/acpi/processor_idle.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index abcdc8f858e1..62277daf874e 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1357,6 +1357,8 @@ void acpi_processor_register_idle_driver(void)
 	int ret = -ENODEV;
 	int cpu;
 
+	acpi_processor_cstate_first_run_checks();
+
 	/*
 	 * ACPI idle driver is used by all possible CPUs.
 	 * Use the processor power info of one in them to set up idle states.
@@ -1368,7 +1370,6 @@ void acpi_processor_register_idle_driver(void)
 		if (!pr)
 			continue;
 
-		acpi_processor_cstate_first_run_checks();
 		ret = acpi_processor_get_power_info(pr);
 		if (!ret) {
 			pr->flags.power_setup_done = 1;
-- 
2.33.0

