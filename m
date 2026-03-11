Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941AC2BD030;
	Wed, 11 Mar 2026 06:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773211850; cv=none; b=LTjd+0Tj07mmWd9wSWAMLyVZOXsw5+rukU05mxdmXDQ+Ls4FqqBixBCUkBkST1rLFc5C/7bV65hxqt30PF6zmOstaUjCsiovpKEicK6SyMqXN1w2mVrihWiGtEljtPlJdaZT4cDMsh7tsFKl5hQ4zgq87eoMFGNA7fIrpvYI/T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773211850; c=relaxed/simple;
	bh=WBG3DdS9aSPwT59t9MPSjkCd+rnbHUrXkAGc4IColQk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gpp7ckF8LZXzCA9ko/WUijDaHK/M0wRYKUZLop1HFxbKKegQEIWxYItLEeg9iffJ8rMRwxC2tv3VX4PEEl71eFhdEJ0Wc+9DAEysMzHiPC9rt9g3nulghKlzyGLC6P694wZGwZ/+hnriGiwVlA/6PF/vxDD02NSt8qljMNR+Plw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=iWIEnsPo; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=iWIEnsPo; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="iWIEnsPo";
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="iWIEnsPo"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=OJNCWKq2Nq8agRkMz+zeQ0G+NaWHhRKP1hrXGss1IbM=;
	b=iWIEnsPoiEG+y7Ch5AjcEYNMjA+2TKGXhTnvJHjr6TkcR4RTyZpVhrNmDCL0eMHJlmuBkaX79
	sjbQvfJCXrLnrjY38/gYsqBtLBI0lUqjc2ssGk3aMew3p4JKWO/kLMdv5pcQeJOMIQV3gfmu0uh
	duBvQ2n+U+jvVlmFS97cPcM=
Received: from canpmsgout04.his.huawei.com (unknown [172.19.92.133])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4fW1Zy2WdDz1BG3p;
	Wed, 11 Mar 2026 14:50:02 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=OJNCWKq2Nq8agRkMz+zeQ0G+NaWHhRKP1hrXGss1IbM=;
	b=iWIEnsPoiEG+y7Ch5AjcEYNMjA+2TKGXhTnvJHjr6TkcR4RTyZpVhrNmDCL0eMHJlmuBkaX79
	sjbQvfJCXrLnrjY38/gYsqBtLBI0lUqjc2ssGk3aMew3p4JKWO/kLMdv5pcQeJOMIQV3gfmu0uh
	duBvQ2n+U+jvVlmFS97cPcM=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4fW1Tz6rFdz1prLY;
	Wed, 11 Mar 2026 14:45:43 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 81A0340561;
	Wed, 11 Mar 2026 14:50:41 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 11 Mar 2026 14:50:41 +0800
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
Subject: [PATCH v2 3/3] ACPI: processor: idle: Remove redundant static variable and rename cstate check function
Date: Wed, 11 Mar 2026 14:50:38 +0800
Message-ID: <20260311065038.4151558-4-lihuisong@huawei.com>
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

The function acpi_processor_cstate_first_run_checks() is currently called
only once during initialization in acpi_processor_register_idle_driver().
Because its execution is already limited by the caller's lifecycle, the
internal static 'first_run' variable is redundant and can be safely
removed.  Additionally, the current function name is no longer descriptive
of its behavior.  Rename the function to acpi_processor_update_max_cstate()
to better reflect its actual purpose.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/acpi/processor_idle.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 62277daf874e..d12da8cb8706 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -819,19 +819,13 @@ static void acpi_processor_setup_cstates(struct acpi_processor *pr)
 	drv->state_count = count;
 }
 
-static inline void acpi_processor_cstate_first_run_checks(void)
+static inline void acpi_processor_update_max_cstate(void)
 {
-	static int first_run;
-
-	if (first_run)
-		return;
 	dmi_check_system(processor_power_dmi_table);
 	max_cstate = acpi_processor_cstate_check(max_cstate);
 	if (max_cstate < ACPI_C_STATES_MAX)
 		pr_notice("processor limited to max C-state %d\n", max_cstate);
 
-	first_run++;
-
 	if (nocst)
 		return;
 
@@ -840,7 +834,7 @@ static inline void acpi_processor_cstate_first_run_checks(void)
 #else
 
 static inline int disabled_by_idle_boot_param(void) { return 0; }
-static inline void acpi_processor_cstate_first_run_checks(void) { }
+static inline void acpi_processor_update_max_cstate(void) { }
 static int acpi_processor_get_cstate_info(struct acpi_processor *pr)
 {
 	return -ENODEV;
@@ -1357,7 +1351,7 @@ void acpi_processor_register_idle_driver(void)
 	int ret = -ENODEV;
 	int cpu;
 
-	acpi_processor_cstate_first_run_checks();
+	acpi_processor_update_max_cstate();
 
 	/*
 	 * ACPI idle driver is used by all possible CPUs.
-- 
2.33.0

