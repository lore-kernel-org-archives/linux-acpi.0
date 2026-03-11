Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBF72C235E;
	Wed, 11 Mar 2026 06:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773211850; cv=none; b=Q7KWPxyNLD5PNCMu8ONkTGWhhjhy4y2UcEJhc6T7xEA750T/kyJwusG21hLE8WSvUy5O69sU0lh5xDUUpOTMsIdCusN+s62ZCnq56pc4HI4GmmOse6rPEJw+hpU4ioeohw0A1wA+kXduYLjK7DPYSQ2YGhHTJB+e8r0iv+S3k/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773211850; c=relaxed/simple;
	bh=1KLFaRNdifrFt2REn8Gf0+FguIGiI1X4L5yFZEQ5bbY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QqLjXpfgfq1FOd0dbF6pFYoDMyDoibhe9AC1MSTi5VaUCMNCrzH60PvHzAZRCawVgnE+XDHI3r2dzYYLbdIpGUK+MOgu51JFHgdzL3xNpJat8pjcRg989Vs4IXIRg+R0bCQbe/ezZTD1pJ2Z0HMq/+thl3U7rfxjNkytESRfATk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=A0P3si5j; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="A0P3si5j"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=YMi4MWkc5xlN/NzAg8N+xdQl22rR1BQhNIgOuCYdYss=;
	b=A0P3si5j4YEGXT6bODyZxBpLZA2KYkeedDDzGJc7F/2I3r64ylhSSulyUgR/s1Fu7A7CKkT/5
	8I7QMRnDi95pu0qLS3MIk0zdLdKZ3Zl9sb4XG5iHNDch0sRyKh+BW4x8Dh8Tn7iJDbEyG6yqLc6
	cOJR9G1NIr6EmXUz5WltMOw=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4fW1V11JPnz1cyPy;
	Wed, 11 Mar 2026 14:45:45 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 3DD3340565;
	Wed, 11 Mar 2026 14:50:40 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
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
Subject: [PATCH v2 0/3] ACPI: processor: idle: Clean up max_cstate update logic
Date: Wed, 11 Mar 2026 14:50:35 +0800
Message-ID: <20260311065038.4151558-1-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
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

The acpi_processor_cstate_first_run_checks() just need to call once
in acpi_processor_register_idle_driver().  This series cleans up the
redundant calls and internal guards.

---
Changes in v2:
- Add a new patch which move max_cstate update out of the loop in
  acpi_processor_register_idle_driver.

---
Huisong Li (3):
  ACPI: processor: idle: Remove redundant cstate check in acpi_processor_power_init
  ACPI: processor: idle: Move max_cstate update out of the loop
  ACPI: processor: idle: Remove redundant static variable and rename cstate check function

 drivers/acpi/processor_idle.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

-- 
2.33.0

