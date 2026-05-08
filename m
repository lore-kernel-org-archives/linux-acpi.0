Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56C1199D8;
	Fri,  8 May 2026 08:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778228435; cv=none; b=alcNLqupCwf1T1t12dLCQUDnaNgq5ObOjRyDDI1AkVsx/bMNWrifJJScBreVgGomkzArx2KaBqtF9tAJ/Xhe6DpUyDp9QbD1IMBJK5wrg1XTutWIuY6ETX1CQ+PkTYlgPe4h7a+nKwiPfGq9Qb5Rl1TLe/73THH/2RHoClwDv9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778228435; c=relaxed/simple;
	bh=IgNldgSNJuH2+rIIQUxUrYE1LC7TJ2fKuJV1Gfi7Ce0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qpMHgPUl1HkV+1+1qw0hJIS6vLXEoA978bYg5FqeOWchnREwQMgwqA1/CXh42X5k+vZvf7I7C+f0+TkeX/Nv//ScSCgQVDoj54WGlUVJlb66ThBbabMDEDwj4M9RIcBQE4U3Q1qUUUsCwSK11wSllsNNgPoJlW6uTEZBiA5/yes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=g56H8FY0; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="g56H8FY0"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1778228429; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=JFOE0oOtrup94m1Ct2dbwxOhyCe8CzDhIKZx+1CT/OA=;
	b=g56H8FY0VmPgebe/uFhqE+NQ9DKZ+CDCtNJ1WYybL3EA9mkL/Wc9YcIpnlKlSX5iGfGCZgtra9EdRs8j0dR3MESUdL/i9B36UxLTDsuAdzAMsOe1821DVvpiZblSPfGOf6gObWscyTf5SQ8e7SIgKn2bxN2L74Q3TGzMQ+TnBUo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=tianruidong@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0X2Wljwh_1778228426;
Received: from localhost(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0X2Wljwh_1778228426 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 08 May 2026 16:20:28 +0800
From: Ruidong Tian <tianruidong@linux.alibaba.com>
To: pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	rafael@kernel.org,
	tony.luck@intel.com,
	bp@alien8.de,
	guohanjun@huawei.com,
	mchehab@kernel.org,
	xueshuai@linux.alibaba.com,
	lenb@kernel.org,
	saket.dumbre@intel.com
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	Ruidong Tian <tianruidong@linux.alibaba.com>
Subject: [PATCH 1/3] acpi: Introduce HEE in HEST notification types
Date: Fri,  8 May 2026 16:20:18 +0800
Message-ID: <20260508082020.3368109-2-tianruidong@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260508082020.3368109-1-tianruidong@linux.alibaba.com>
References: <20260508082020.3368109-1-tianruidong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new HEST notification type for RISC-V Hardware
Error Exception. The GHES entry's notification structure
contains the notification to be used for a given error source.

Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
---
 include/acpi/actbl1.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 14924383e2d0..2c1ad1d8587b 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -1793,7 +1793,8 @@ enum acpi_hest_notify_types {
 	ACPI_HEST_NOTIFY_GSIV = 10,	/* ACPI 6.1 */
 	ACPI_HEST_NOTIFY_SOFTWARE_DELEGATED = 11,	/* ACPI 6.2 */
 	ACPI_HEST_NOTIFY_SSE = 12, /* RISCV SSE */
-	ACPI_HEST_NOTIFY_RESERVED = 13	/* 13 and greater are reserved */
+	ACPI_HEST_NOTIFY_HEE = 13, /* RISCV Hardware Error Exception */
+	ACPI_HEST_NOTIFY_RESERVED = 14	/* 14 and greater are reserved */
 };
 
 /* Values for config_write_enable bitfield above */
-- 
2.51.2.612.gdc70283dfc

