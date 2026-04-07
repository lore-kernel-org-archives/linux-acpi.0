Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBD93A4523;
	Tue,  7 Apr 2026 08:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775549513; cv=none; b=KcaFxRRfD9Q+wyn/Hwx72SBeC4WzVW0VA/Chiikl7ALKkhlpw+wP19/4VA8PEzJFgb+dgdKmLy7UNeoHR5oMD32qWpXa59yS77K0mEkFUtAJjEExkrm093wHHIbPyXjwXZiK6W0xgW9V+3Kp3YtUA/cwNRwqYRK1mdJbnU8ZEiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775549513; c=relaxed/simple;
	bh=DK/R8pDs1Z7Aj2ZZa0j9LNYWrAIutUcAxGwdQZMdKCY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c5weQdZygpAd3n74ix24nbAuTLAbL1flF2eh0n4U0M2WDVhqnFzS8woJNEeNedUOa9yAOaWqrwn2X0jM7571W+LgQsKpTXDbGc96P1E9w5LNXC8p1cJ1ryAgq5AjkG7vPUL/nEtKtK3WLhfg1duUIM8NXEkE64NX0cvYofLmwIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=NTuF+BqX; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="NTuF+BqX"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=TzMYrToCDWfGIzPlTBe8+z/m3TJygUyCuYDpeebT+iY=;
	b=NTuF+BqXNoPCfO2evstP5y8DigdY08wzA9/OeREff4sL6vgx6eNbXvvKZGcOm8pLqfUEDUes6
	MrdVFoJxGfkMRH+ris3nEqsD7kcZtBoN8DHbHyv9Nc5Fapxbx4X8I4+FpJwnUz/49sbxJmyqShO
	nfD8Lgr1uUVQNwr9jUI1hNc=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4fqdzh0bNtzRhWJ;
	Tue,  7 Apr 2026 16:05:36 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 83B8940572;
	Tue,  7 Apr 2026 16:11:49 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 7 Apr 2026 16:11:42 +0800
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
Subject: [PATCH v2 0/2] ACPI: processor: idle: Fix incorrect power management decisions after power notify
Date: Tue, 7 Apr 2026 16:11:39 +0800
Message-ID: <20260407081141.2493581-1-lihuisong@huawei.com>
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

This series is aimed to handle the potentially incorrect power management
decisions and unclean idle state after power notify because of incomplete
state update in cpuidle driver and cpuidle device.

---
Changes in v2:
- drop the old modification method in v1 which is still incomplete.
- Link to v1:
  https://lore.kernel.org/linux-acpi/20251125072933.3706006-1-lihuisong@huawei.com/

Huisong Li (2):
  cpuidle: Extract and export no-lock variants of cpuidle_unregister_device
  ACPI: processor: idle: Fix incorrect power management decisions after power notify

 drivers/acpi/processor_idle.c | 45 +++++++++++++++++++----------------
 drivers/cpuidle/cpuidle.c     | 22 +++++++++++------
 include/linux/cpuidle.h       |  2 ++
 3 files changed, 42 insertions(+), 27 deletions(-)

-- 
2.33.0

