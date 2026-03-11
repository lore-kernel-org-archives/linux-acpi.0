Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A767D2DA74C;
	Wed, 11 Mar 2026 06:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773211853; cv=none; b=fdjEBawJ/yRCKUgUv8ebx7cp9FfbRpozdYjQRiCgMlOJSlQQntF/XTm33cYYzGQ/bXJFCNd5GWcCoqlp2lCMivKuwXLRKd1VPFUnPETgOHRk8KerfTUD5e2q6nzjAJFGhtVJJJmV7URkIbe0TrARo9ShnfKuF4nADtvgXHEDJc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773211853; c=relaxed/simple;
	bh=Q6CKFPfaXJz12EdiAH3MJV99GCxNQ6/Q7oV43BU3u48=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EYvA4MK9pfzuGdg4j38dfEwNgO4s9Y+lubiY2nhURoO2qxjQX2tnLHN8bRnS6rLZwFOUrnRqV/WMzPAE/44WDsqK98R5U7NLfW2r135M5pSgslyg5t0Ax0dpcKFooPArmKlB29iUSmbiHofiXYw13c7oXD5cIPy565VxUm2tKxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=mG0pHGTb; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="mG0pHGTb"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=AiNsR4vA4BYYNyWCsTWxpkWmyNNQxSWFyNkGX29NIQY=;
	b=mG0pHGTbN6sBCCGoecKOF02nxr2r4NnU1i5zrYCL/zp6hxVixbYk/h0eY/1qz3rE3KCLgNx0l
	6oLM2ElKPUkEYYtMff3SBvQSTz5KeeesdIQ3beR6reh6QCjH+uqPQ748Xlhn5ZjgF+OBMuDmKWk
	Qi5ii3dQoNeAmfWb8VDKx2c=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fW1TD5rtmznTVP;
	Wed, 11 Mar 2026 14:45:04 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id A396C40563;
	Wed, 11 Mar 2026 14:50:40 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 11 Mar 2026 14:50:40 +0800
Received: from localhost.localdomain (10.50.163.32) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 11 Mar 2026 14:50:39 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <bp@alien8.de>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>,
	<zhangpengjie2@huawei.com>, <wangzhi12@huawei.com>, <lihuisong@huawei.com>
Subject: [PATCH v2 1/3] ACPI: processor: idle: Remove redundant cstate check in acpi_processor_power_init
Date: Wed, 11 Mar 2026 14:50:36 +0800
Message-ID: <20260311065038.4151558-2-lihuisong@huawei.com>
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

The function acpi_processor_cstate_first_run_checks() is responsible
for updating max_cstate and performing initial hardware validation.
Currently, this function is invoked within acpi_processor_power_init().
However, the initialization flow already ensures this is called during
acpi_processor_register_idle_driver().  Therefore, the call in
acpi_processor_power_init() is redundant and effectively performs no work.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/acpi/processor_idle.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index f6c72e3a2be1..abcdc8f858e1 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1409,8 +1409,6 @@ void acpi_processor_power_init(struct acpi_processor *pr)
 	if (disabled_by_idle_boot_param())
 		return;
 
-	acpi_processor_cstate_first_run_checks();
-
 	if (!acpi_processor_get_power_info(pr))
 		pr->flags.power_setup_done = 1;
 
-- 
2.33.0

