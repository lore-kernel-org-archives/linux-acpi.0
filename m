Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671BB155A5D;
	Thu, 29 Jan 2026 04:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769660080; cv=none; b=Wc960vEHT5F8oCAwcVEN72oqvGCTT4PMd03itO8uDvGcYt/5aziPwWg5dqbhkRRczpW6ebnfwsZ8V3551l4LjNKMauujaAifw+03t9Hn1J7jDlkymP6n18k/RirTRo1RmeGxB9uOnsuDjceXA8bn8qXSouGoaftPjaL+aDE4Xvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769660080; c=relaxed/simple;
	bh=KBzmsIRegDrvmkFRQD3n0Xb+ffFVOmVz9jX3SM5sQvM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BvIoxSA7IHkrMnIV+zsIevM+c/rOyByTFoAxDCoqrpchdZrQabV8MllWHzGUJcIFtPTrm6ywF6AszmleJLrIoDXkVbtg4yg7Y+6gQRrOxoKwB39NuSSyFKo3QgKM6n/QsfWQj5q/orHh7eENxXA5iiCRcdjidASLs+OxAg59L8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=PuuXxpkd; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="PuuXxpkd"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=JzZjkQ175br2gelTS1Pk4iktoc+t9xMVbEcggRcFjck=;
	b=PuuXxpkdceZVN82zaApUIf0soTilVmDPExdVnXXHTyt0iV2FcL61X2s6nIuXBKR5b3C0FvMrA
	TkBcaQVDFpYp/OQYuclIHrz1OnIHqE9e7HHkgyBES699IJRBogvVQeDmB3RkPT5RuftJ/+IH6RT
	21rnJags+4fluWiueT+Cswk=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4f1m0V65hrzLlSZ;
	Thu, 29 Jan 2026 12:11:06 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id A8B3D40562;
	Thu, 29 Jan 2026 12:14:34 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 29 Jan 2026 12:14:34 +0800
Received: from localhost.localdomain (10.50.163.32) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 29 Jan 2026 12:14:33 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <bp@alien8.de>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>,
	<zhangpengjie2@huawei.com>, <wangzhi12@huawei.com>, <lihuisong@huawei.com>
Subject: [PATCH 0/2] ACPI: processor: Clean up max_cstate update logic
Date: Thu, 29 Jan 2026 12:14:31 +0800
Message-ID: <20260129041433.3458902-1-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
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

The acpi_processor_cstate_first_run_checks() just need to call once
in acpi_processor_register_idle_driver().  This series cleans up the
redundant calls and internal guards.

Huisong Li (2):
  ACPI: processor: Remove redundant cstate check in power init
  ACPI: processor: Remove redundant static variable and rename cstate
    check function

 drivers/acpi/processor_idle.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

-- 
2.33.0

