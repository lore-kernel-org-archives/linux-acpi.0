Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6263DA5D4;
	Wed, 27 May 2026 08:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779870438; cv=none; b=jLIyyqhFGkWJeOhCOBGTpnhmbv2MgL4ey3ras9imskr+BHBqCZ1KuIp1vNG+aS3f4ylzguMxbdcj6S2OiRICg+z0XkRu0zAvfJSojeDKWg+jvqsimzDv0G0eYOSR5IF5ecrnbV5+z7/x2vx84AxQ5fhwM8hWHmVg5uShVoDDeQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779870438; c=relaxed/simple;
	bh=/E8CtgLoN5CS457g2jdkzHMee0togENVcuR7UWvEMDA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eZzn7GHS+gQHVi3CzJnZZDDrPkihERn3GXncoFwNAKcJeHbbuLbxZbT2HEKR/tkNWEoXKYtmDUcAcWkTCkN3+jy0UEfnzjnUsfqev4tVTpf7UlfkHA0JQ2zRVybexSt9qc3BunDBufIAbY7cSTJYVXW8oHRZAKZoCPlJXwNsT7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=h-partners.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=NnwdDHuN; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=h-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="NnwdDHuN"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=O8tZjLai5HUG8CN2LbGilq0LXVXTfvjbrMQK65zW/bQ=;
	b=NnwdDHuNjKvcuk7Wp8ycck5mYDQiK5WKvGBd4gyanztU/LbVmJ45tRIo+i+dPSySx7vjRj7ED
	bGNI0yXXKGbNTGH97JDFPuASbAavaqcCnD1hV5Mt8FJ9J70swaxTSO10H5NE+9p8wqMEX71Ge9W
	+pVnyI5mAHHNZZPpKpVyJvE=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4gQMwX2cnzzRhRC;
	Wed, 27 May 2026 16:19:24 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id A376F4056A;
	Wed, 27 May 2026 16:27:09 +0800 (CST)
Received: from kwepemn500004.china.huawei.com (7.202.194.145) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 27 May 2026 16:27:09 +0800
Received: from localhost.localdomain (10.50.163.32) by
 kwepemn500004.china.huawei.com (7.202.194.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 27 May 2026 16:27:08 +0800
From: Junhao He <hejunhao3@h-partners.com>
To: <rafael@kernel.org>, <tony.luck@intel.com>, <guohanjun@huawei.com>,
	<mchehab@kernel.org>, <xueshuai@linux.alibaba.com>, <jarkko@kernel.org>,
	<yazen.ghannam@amd.com>, <jane.chu@oracle.com>, <lenb@kernel.org>,
	<linmiaohe@huawei.com>
CC: <bp@alien8.de>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, <tanxiaofei@huawei.com>, <linuxarm@huawei.com>,
	<liuyonglong@huawei.com>, <mawupeng1@huawei.com>, <hejunhao3@h-partners.com>
Subject: [PATCH v2] ACPI: APEI: Handle repeated SEA error storms
Date: Wed, 27 May 2026 16:27:07 +0800
Message-ID: <20260527082707.2013499-1-hejunhao3@h-partners.com>
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
 kwepemn500004.china.huawei.com (7.202.194.145)

When hardware memory corruption occurs and a user process accesses the
corrupted page, the CPU triggers a Synchronous External Abort (SEA).
The kernel invokes do_sea() to handle the exception, which calls
memory_failure() to handle the faulty page.

Scenario 1: Memory Error Interrupt First, then SEA
The page is already poisoned by the memory error interrupt path. The
subsequent SEA handler sends a SIGBUS to the task, which accesses the
poisoned page. This flow is correct.

Scenario 2: SEA first, then memory error interrupt (problematic scenario)
If a user task directly accesses corrupted memory through a PFNMAP-style
mapping (e.g., devmem), the page may still be in the free-buddy state when
SEA is handled. In this case, memory_failure() will poison the page without
invoking kill_accessing_process(), and then takes the free-buddy recovery
path.

After the CPU returns to the task context, the task re-enters the SEA
handler due to the same access. However, ghes_estatus_cached() suppresses
all subsequent entries during the 10-second window, preventing
ghes_do_proc() from being called. This suppression blocks the
MF_ACTION_REQUIRED-based SIGBUS delivery, causing the kernel to fail to
kill the task immediately. Consequently, the process keeps re-entering
the SEA handler, leading to an SEA storm. Later, the memory error
interrupt path also cannot kill the task, leaving the system stuck in
this repeated loop.

The following error logs are explained using the devmem process:
  NOTICE:  SEA Handle
  [Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 9
  [Hardware Error]: event severity: recoverable
  [Hardware Error]:   section_type: ARM processor error
  [Hardware Error]:    physical fault address: 0x0000001000093c00
  [T54990] Memory failure: 0x1000093: recovery action for free buddy page: Recovered
  [ T9955] EDAC MC0: 1 UE Multi-bit ECC on unknown memory
           (page:0x1000093 offset:0xc00 grain:1 - APEI location: ...)
  NOTICE:  SEA Handle
  NOTICE:  SEA Handle
  ...
  ...        ---> SEA storm
  ...
  NOTICE:  SEA Handle
  [ T9955] Memory failure: 0x1000093: already hardware poisoned
  ghes_print_estatus: 1 callbacks suppressed
  [Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 9
  [Hardware Error]: event severity: recoverable
  [Hardware Error]:   section_type: ARM processor error
  [Hardware Error]:    physical fault address: 0x0000001000093c00
  [T54990] Memory failure: 0x1000093: already hardware poisoned
  [T54990] 0x1000093: Sending SIGBUS to devmem:54990 due to hardware memory corruption

To resolve this, return an error when encountering the same SEA again.
The subsequent SEA handler invocation uses arm64_notify_die() to send a
SIGBUS signal to the task, which terminates the process and prevents it
from re-entering the handler loop.

Signed-off-by: Junhao He <hejunhao3@h-partners.com>
---
 drivers/acpi/apei/ghes.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

Changes in V2:
1. update the commit message per suggestion from Xueshuai
2. Add a check to only return failure on the ghes_notify_sea() path,
   avoiding impact on other NMI-type GHES handlers.
Link to V1 - https://lore.kernel.org/all/20251030071321.2763224-1-hejunhao3@h-partners.com/

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 3236a3ce79d6..787664740150 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -1383,8 +1383,16 @@ static int ghes_in_nmi_queue_one_entry(struct ghes *ghes,
 	ghes_clear_estatus(ghes, &tmp_header, buf_paddr, fixmap_idx);
 
 	/* This error has been reported before, don't process it again. */
-	if (ghes_estatus_cached(estatus))
+	if (ghes_estatus_cached(estatus)) {
+		/*
+		 * Return failure on duplicate SEA entries so that the
+		 * subsequent SEA handler invocation sends a SIGBUS signal to
+		 * the task to prevent it from re-entering the handler loop.
+		 */
+		if (is_hest_sync_notify(ghes))
+			rc = -ECANCELED;
 		goto no_work;
+	}
 
 	llist_add(&estatus_node->llnode, &ghes_estatus_llist);
 
-- 
2.33.0

