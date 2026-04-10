Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1936B2EAD1B;
	Fri, 10 Apr 2026 09:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775814110; cv=none; b=UoUMis+UL98kO5xJlOm4xVQlE17lezoebdTYPWOURGgQrfmbv4JSkOKQMhT9EB2C2gXe3lM3E6xmQbQ7yqDXO3swvWb1JKpeq4Pjbfk2Kx6MFq7vezpy8qmQ6gB+4MUoa4Oi8eekyAVQtTz5IgL2teLpOBazdSoqu6uozKWCYrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775814110; c=relaxed/simple;
	bh=Dw3PL+VvN/oMldl04vMrBac2HQto0zr3eh47B6kZdNs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QtVUjme8xjhVpZQJpWAewRV9cO5/9yurjO/v3uticF5VyFBeE68fA0HLw1IKMLudx4qHmQuwnMdQ/wy/0lan0VQ8tZB/cBbWBjd5mywkEVN1YDxoR0xAbU2gABxuvO9lL03dIG8WeSAdif0ubk42gZq5puya0KjPFbaQmvaBjyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ftaG4TBW; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ftaG4TBW"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=eaKFcm7WaRcTi7W+2ANoOnjYHJTX3BGhNlM3aaAYpQQ=;
	b=ftaG4TBW6olA0Qt7k6NCms1MUPqX5IHmNzU4ckrQEjB3yB7CRqJx6jWEp/wcfODXMTvxcbP8+
	ZokDm7GQm4fucOGuRkq1K4eN869Df5xg/Cs6Ftgk2c9PUoUqjFu4mw41KFrT6T2HGXMrMOiRGgt
	stR6yDw8SLD8Ca0rR0K2RQA=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4fsWqy08cNzcb29;
	Fri, 10 Apr 2026 17:35:26 +0800 (CST)
Received: from kwepemr200004.china.huawei.com (unknown [7.202.195.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 03889203C0;
	Fri, 10 Apr 2026 17:41:47 +0800 (CST)
Received: from huawei.com (10.50.163.32) by kwepemr200004.china.huawei.com
 (7.202.195.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 10 Apr
 2026 17:41:46 +0800
From: Pengjie Zhang <zhangpengjie2@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <rafael@kernel.org>,
	<lenb@kernel.org>, <robert.moore@intel.com>, <beata.michalska@arm.com>,
	<zhenglifeng1@huawei.com>, <zhanjie9@hisilicon.com>, <sumitg@nvidia.com>,
	<cuiyunhui@bytedance.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<prime.zeng@hisilicon.com>, <wanghuiqiang@huawei.com>, <xuwei5@huawei.com>,
	<lihuisong@huawei.com>, <yubowen8@huawei.com>, <zhangpengjie2@huawei.com>,
	<wangzhi12@huawei.com>
Subject: [PATCH 0/2] CPPC: reduce FFH feedback-counter sampling skew on arm64
Date: Fri, 10 Apr 2026 17:41:43 +0800
Message-ID: <20260410094145.4132082-1-zhangpengjie2@huawei.com>
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
 kwepemr200004.china.huawei.com (7.202.195.241)

The legacy CPPC feedback-counter path reads the delivered and reference
performance counters separately.

On arm64 systems using AMU-backed CPPC FFH counters, each FFH read is
served through a cross-CPU counter read helper. Reading the counters
separately therefore widens the sampling window between them and can
skew the delivered/reference ratio used by cpuinfo_cur_freq. Under heavy
load, the skew is observable as transient values that may exceed the
platform maximum, as discussed in [1] and [2].

This series adds a small generic hook for architectures that can obtain
both FFH feedback counters in one operation, while preserving the
existing per-register read path as the fallback.

Patch 1 adds the generic CPPC hook and uses it from cppc_get_perf_ctrs().
Patch 2 implements the hook on arm64 by sampling both AMU counters in a
single operation on the target CPU.

[1] https://lore.kernel.org/all/20231025093847.3740104-4-zengheng4@huawei.com/
[2] https://lore.kernel.org/all/20231212072617.14756-1-lihuisong@huawei.com/

Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>

Pengjie Zhang (2):
  ACPI: CPPC: add paired FFH feedback-counter read hook
  arm64: topology: read CPPC FFH feedback counters in one operation

 arch/arm64/kernel/topology.c | 75 ++++++++++++++++++++++++++++++++----
 drivers/acpi/cppc_acpi.c     | 58 +++++++++++++++++++++++++---
 include/acpi/cppc_acpi.h     |  7 ++++
 3 files changed, 127 insertions(+), 13 deletions(-)

-- 
2.33.0

