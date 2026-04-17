Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AD634216C;
	Fri, 17 Apr 2026 07:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776409943; cv=none; b=m8eBDdG0oCibVmvcbaCoJKEPQwXLWXcNUMcCFM2vuMHr0QTshEuvmPKng1dEsgWAqPLODltgiV5DXwZEmzGViwZ0OMuVdXK4AD6jmdwzPAEDEzN5ATaPsaw+2hsDXhy0bw5yygv+ixxJ7+Z5UlNOZjQOcDyObGc0qI63wM1O9l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776409943; c=relaxed/simple;
	bh=5BaV98ZJc5f4Galndi3K1WYZ/fB0gGQelDfWOO28dD4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ide2EXJsU/V3WAvRIKoEAmKWvQV0JilumWgiTeA6CbpZmQE+ik6LN7EiglOOptDjOcEfY1QD3VnZ93PzYCaBx5g89rNwQPPXahSQ5B3biRL2l8QhrfuoqV3Fq92czrNfEf8Iz8X58aRN5NMaH3Fomjs+SNIUZlA1PhL3RW9rsCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=4H8YdR7Z; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="4H8YdR7Z"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=yAol4DHTnu2YXlix/hjil5wjZ2T6Yj1Lkw1BnaDa54c=;
	b=4H8YdR7ZalC4mtVHr9MUU9gbDHyMg/eMpAth78sSMOQnE9hHfZMWoU5NbTLvozu2Ld0mvaZrb
	0B1HM9Sk/00yPvJasXjNThvwOIMs342l8arXwp72NSNOb8xN/oly8QbaKRSgLJyNwDxoYBh/BSK
	utHndG+wQ8uytXCuiBtHVV4=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4fxmBD604DzmVdc;
	Fri, 17 Apr 2026 15:05:56 +0800 (CST)
Received: from kwepemj100016.china.huawei.com (unknown [7.202.194.10])
	by mail.maildlp.com (Postfix) with ESMTPS id C98B04048B;
	Fri, 17 Apr 2026 15:12:17 +0800 (CST)
Received: from huawei.com (10.50.85.135) by kwepemj100016.china.huawei.com
 (7.202.194.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 17 Apr
 2026 15:12:17 +0800
From: Wupeng Ma <mawupeng1@huawei.com>
To: <rafael@kernel.org>, <tony.luck@intel.com>, <bp@alien8.de>,
	<guohanjun@huawei.com>, <mchehab@kernel.org>, <xueshuai@linux.alibaba.com>,
	<lenb@kernel.org>, <jonathan.cameron@huawei.com>, <jane.chu@oracle.com>,
	<jarkko@kernel.org>, <wangkefeng.wang@huawei.com>
CC: <mawupeng1@huawei.com>, <linux-kernel@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>
Subject: [PATCH] ACPI: APEI: check return value of task_work_add to prevent memory leaks
Date: Fri, 17 Apr 2026 14:50:21 +0800
Message-ID: <20260417065021.4067113-1-mawupeng1@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemj100016.china.huawei.com (7.202.194.10)

task_work_add() can fail with -ESRCH if the target task is exiting.
When it fails, the caller must handle the error and free any allocated
resources.

ghes_do_memory_failure() allocates a twcb structure from ghes_estatus_pool
before calling task_work_add(). If task_work_add() fails, twcb is leaked.

This can happen due to a race during task exit:

  do_exit()
    exit_mm()           # current->mm cleared
    exit_task_work()    # task->task_works = &work_exited

ghes_do_memory_failure() checks current->mm before allocating twcb,
but exit_task_work() may run before task_work_add() completes.  At that
point task->task_works == &work_exited, causing task_work_add() to fail.

Fixes the leak by checking the return value and freeing twcb on failure.

Fixes: c1f1fda14137 ("ACPI: APEI: handle synchronous exceptions in task work")
Signed-off-by: Wupeng Ma <mawupeng1@huawei.com>
---
 drivers/acpi/apei/ghes.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 8acd2742bb27d..4ffe65ecf4a87 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -520,8 +520,11 @@ static bool ghes_do_memory_failure(u64 physical_addr, int flags)
 		twcb->pfn = pfn;
 		twcb->flags = flags;
 		init_task_work(&twcb->twork, memory_failure_cb);
-		task_work_add(current, &twcb->twork, TWA_RESUME);
-		return true;
+		if (!task_work_add(current, &twcb->twork, TWA_RESUME))
+			return true;
+
+		gen_pool_free(ghes_estatus_pool, (unsigned long)twcb, sizeof(*twcb));
+		return false;
 	}
 
 	memory_failure_queue(pfn, flags);
-- 
2.43.0

