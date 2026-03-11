Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBF338AC7C;
	Wed, 11 Mar 2026 07:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773213221; cv=none; b=fc/a144YaJMr/KeRAn8kk+3XNv5ONPlcNtHAEV1sAXqgc0j+0JMaJRbD31sSIDomCdhjqKzyH7R+gNFte4EMbHwiFjGzclYQKXjH0VXlyKxVvnYSCm1YHIcaJQHFi6qiUvdjThqIKJGcU4s/lzIXqVgi+9YFsh9iFsFy4x+8lP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773213221; c=relaxed/simple;
	bh=a4ybPmdVzaVpBDDFJ7974Zun4/rvyZQGf43GAnva3i8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Wwk7ys/qCTxkir3MWv7YUC7CmltqqKCOhgIcI3HgnFx4gFD8yyjpSgKXv6cwKUBUxKsF8qV47ZM80Ama/wVD0gjDj0+73c0I2v4zTIEv1JSaQuiGEj1Mrchk/R+0LPpZKGCA0HZ5BxakB+aL2IwC9lLSP+LptobmtHrC6KyspZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=aZBLjPnI; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="aZBLjPnI"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=QW7rs2a/ATDbtxK8++0Qt3ghcZKgmsKiPcmMrCy33f4=;
	b=aZBLjPnI6Dk0IZILH3PYByd4URKGOAToUags55HqJS9BgdLhJEDUPjkE5hDe7IJ3lbVGNOd4W
	ZTFppn5Wq4DAB8z3k8HEqi+uuZou755mTSX4RAcDosMItJnXGH+9uZemCxXy9l2speD+ezMaFYb
	kx8m4CHoJklNIWcqf0kdHgA=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4fW20V2Mpzz1K96v;
	Wed, 11 Mar 2026 15:08:42 +0800 (CST)
Received: from kwepemr200004.china.huawei.com (unknown [7.202.195.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 4DEDC4048B;
	Wed, 11 Mar 2026 15:13:35 +0800 (CST)
Received: from huawei.com (10.50.163.32) by kwepemr200004.china.huawei.com
 (7.202.195.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 11 Mar
 2026 15:13:34 +0800
From: Pengjie Zhang <zhangpengjie2@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nathan@kernel.org>, <zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>,
	<lihuisong@huawei.com>, <yubowen8@huawei.com>, <linhongye@h-partners.com>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhangpengjie2@huawei.com>, <wangzhi12@huawei.com>
Subject: [PATCH] ACPI: CPPC: Fix uninitialized ref variable in cppc_get_perf_caps
Date: Wed, 11 Mar 2026 15:13:34 +0800
Message-ID: <20260311071334.1494960-1-zhangpengjie2@huawei.com>
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

Commit 8505bfb4e4ec ("ACPI: CPPC: Move reference performance
to capabilities") introduced a logical error when retrieving
the reference performance.

On platforms lacking the reference performance register, the fallback
logic leaves the local 'ref' variable uninitialized (0). This causes
the subsequent sanity check to incorrectly return -EFAULT, breaking
amd_pstate initialization.

Fix this by assigning 'ref = nom' in the fallback path.

Fixes: 8505bfb4e4ec ("ACPI: CPPC: Move reference performance to capabilities")
Reported-by: Nathan Chancellor <nathan@kernel.org>
Closes: https://lore.kernel.org/all/20260310003026.GA2639793@ax162/
Tested-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>
---
This is on top of linux-next.
---
 drivers/acpi/cppc_acpi.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 07bbf5b366a4..5ad922eb937a 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1407,12 +1407,11 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
 	 * If reference perf register is not supported then we should
 	 * use the nominal perf value
 	 */
-	if (CPC_SUPPORTED(reference_reg)) {
+	if (CPC_SUPPORTED(reference_reg))
 		cpc_read(cpunum, reference_reg, &ref);
-		perf_caps->reference_perf = ref;
-	} else {
-		perf_caps->reference_perf = nom;
-	}
+	else
+		ref = nom;
+	perf_caps->reference_perf = ref;
 
 	if (guaranteed_reg->type != ACPI_TYPE_BUFFER  ||
 	    IS_NULL_REG(&guaranteed_reg->cpc_entry.reg)) {
-- 
2.33.0

