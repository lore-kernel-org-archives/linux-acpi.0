Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CA534EF0D;
	Wed,  8 Jul 2026 08:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783499308; cv=none; b=blIOENxXuMB2LXzURFmYU2OO40p4oEYe/ieeQRJ65zIFWrF+yISRgSORkH3amimVMjEVOqVZdTqjLCEJMGd4Amim6zflQgqxlDNG78xrAU7Tjji9hlsbVO/P46lx9Vc52xWIKkZelyCtOugkPrHqqTBzLOLDzCsbLGH4JsGFv/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783499308; c=relaxed/simple;
	bh=gzcVvyl8S+tGvkADMvO5Ady3NbDYJELnWnkK2MVZinI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iuTIWsclS3zaAN4o9Kd4Gvg2aSuNNXHlLz7XZe+h9ZXbeP9NSf43KAJUlKKgu7as/7ZOyAB7vaQkAjvVRiaF6pm8VrM30U8ByIUHDG8hU9FjrbCZCEbdqM3mwF2Zhm3W6fK7y1QA2+KDxkIqixph8xbbOSmJyyei2f/xyr9faGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=wKRfrlZW; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="wKRfrlZW"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ul4b8Pq/VjqK5NFTryIUnlt4I+du1BUPd+UreT1DGIs=;
	b=wKRfrlZWzmTTpRtIAND+CNN/IjUGVAbmNpsaTww+/K6ySA92pe4KB8MAsTMrYF17ct2iuOtry
	0zX44XLF/2tv+lAXzzZBgd4Z4W2meTC+ezW6vsoWDsHnRO8Z4RrO4+X31nzTwu6QLaiKogbrJIr
	OhBBMHXhLiJsdG7a9e2kVWo=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4gw9wn4fVCzLlVk;
	Wed,  8 Jul 2026 16:19:05 +0800 (CST)
Received: from kwepemr200004.china.huawei.com (unknown [7.202.195.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 9BDB840578;
	Wed,  8 Jul 2026 16:28:19 +0800 (CST)
Received: from huawei.com (10.50.163.32) by kwepemr200004.china.huawei.com
 (7.202.195.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 8 Jul
 2026 16:28:18 +0800
From: Pengjie Zhang <zhangpengjie2@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <rafael@kernel.org>,
	<lenb@kernel.org>, <saket.dumbre@intel.com>, <beata.michalska@arm.com>,
	<zhenglifeng1@huawei.com>, <sumitg@nvidia.com>, <zhanjie9@hisilicon.com>,
	<geert+renesas@glider.be>, <cuiyunhui@bytedance.com>,
	<vanshikonda@os.amperecomputing.com>, <ionela.voinescu@arm.com>,
	<jeremy.linton@arm.com>, <viresh.kumar@linaro.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linuxarm@huawei.com>
CC: <prime.zeng@hisilicon.com>, <wanghuiqiang@huawei.com>,
	<xuwei5@huawei.com>, <lihuisong@huawei.com>, <yubowen8@huawei.com>,
	<zhangpengjie2@huawei.com>, <wangzhi12@huawei.com>
Subject: [PATCH v2 0/2] CPPC: reduce FFH feedback-counter sampling skew on arm64
Date: Wed, 8 Jul 2026 16:28:16 +0800
Message-ID: <20260708082818.808041-1-zhangpengjie2@huawei.com>
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

For detailed test results and data demonstrating the observable skew and
the improvements brought by this series, please refer to [3] and [4].

[1] https://lore.kernel.org/all/20231025093847.3740104-4-zengheng4@huawei.com/
[2] https://lore.kernel.org/all/20231212072617.14756-1-lihuisong@huawei.com/
[3] https://lore.kernel.org/all/443104e2-ba6e-454e-8469-909f35817a99@huawei.com/
[4] https://lore.kernel.org/all/317d33d5-8279-4aa8-84b7-6ae1976636ac@huawei.com/

Tested-by: Sumit Gupta <sumitg@nvidia.com>
Reviewed-by: Sumit Gupta <sumitg@nvidia.com>
Tested-by: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
Reviewed-by: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>
---
Changes in v2:
- Simplified the CPPC generic layer fallback logic to prevent pointless single-read retries.
- Added upfront register validation in the arm64 hook to avoid unnecessary IPI overhead.
- Explicitly flipped the -EOPNOTSUPP error to -ENODEV in the arm64 hook when AMU is unsupported, cleanly bypassing redundant CPPC generic fallbacks.
- Addressed other kernel-doc and naming feedbacks from Beata.
- Added Reviewed-by and Tested-by tags from Vanshidhar and Sumit
- Link to v1: https://lore.kernel.org/all/20260410094145.4132082-1-zhangpengjie2@huawei.com/

Pengjie Zhang (2):
  ACPI: CPPC: add paired FFH feedback-counter read hook
  arm64: topology: read CPPC FFH feedback counters in one operation

 arch/arm64/kernel/topology.c | 92 ++++++++++++++++++++++++++++++++----
 drivers/acpi/cppc_acpi.c     | 50 ++++++++++++++++++--
 include/acpi/cppc_acpi.h     |  7 +++
 3 files changed, 136 insertions(+), 13 deletions(-)

-- 
2.33.0

