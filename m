Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30DD20F08C;
	Tue,  3 Feb 2026 02:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770084872; cv=none; b=H1NvstTGqoUu5WXJb7D4LJidKydUaoWZrISCPe5BZYsmPk2Wi/Oyp4jEhiTJzU+xuLu8Sa4+UeFQmaVksGeZCCbzY1zzw0KOc7FQZ6PyHtkJ+R6khsWjw6LabPGENoocForxxE5L7un5CDadBgCxy4Iy2IUtNKE+J1K0FVe7bhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770084872; c=relaxed/simple;
	bh=GsqC/OLYO0Vq8hhc34tDvplzoFJYZ9/b7z664030fdw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AS2f7qWgt1RJpVahYzXPqs6eWypgLYwr0imMcn9I5relabyVSDGPvWh4dVGxaZ4YdLiLBObjiHWQ2f83AW0fHlz95o5HrBPUtRryEZt+9vshXshYOfE+jNAXju6kCoh/Cv6/C6Bj67/oT7Kkhnb1vunCNHdrNKLvPfiPKkCqT7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpgz1t1770084764t67d4a226
X-QQ-Originating-IP: h3lwND9XSq7GCKfGiDyjBhu/OGyIPMK3Yi20Z0q0IZM=
Received: from w-MS-7E16.trustnetic.com ( [36.20.47.234])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 03 Feb 2026 10:12:38 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18102445369030274771
EX-QQ-RecipientCnt: 12
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Len Brown <lenb@kernel.org>,
	Shiju Jose <shiju.jose@huawei.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH] ACPI: APEI: Avoid NULL pointer dereference in ghes_estatus_pool_region_free
Date: Tue,  3 Feb 2026 10:12:32 +0800
Message-ID: <23A877C77DF26B7C+20260203021233.8178-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OMBoazyWwdF0z5tp8x8LNaq4NZnioSIRMXDz9eA43xc7/odCMnT31YgY
	eKMs7sEnmtawLoZAvVMmEo7ncD5iv0t72JjpW2h6S2DTLnSRiv5ZdtARdG1U2uOXT/SMa6b
	3j8hbS29rtEnixsjK0avhHs29XKHdpVOo3VTSdfMBE+gObw6e5rnfdZuVNM3QtXa1uaqb2s
	2uSWSm/LmwFmJk/hh2ywuMiw90u76+bRK3lC8WTOeu7nG+r3Lty52bfjrNyhmsb9TcrA4jp
	9yqTfsg8VhBnOpi61HEd9HhxG2F8EhBgnTOKElXxQ42BkALnM5vo2lVVHM2dNpdOvmVOGiD
	7+s5eTEblQ0L/H21o2tl5Ddka8bkV2FWTbiuH2YVqC/qdV/2rG0Ht9X9jilzF1g9VCP/oT4
	uVTbCz6zwcWJsKFVriiOpOQ/D7N2C6HEnzlwg36zObuSpr/ywkrGTQ/w9UMJH44FvqEETZY
	lJdiyVAOBSduHQWMuboNMKl2IvSejtZbyURWQ1yzN3JHnLZt+P33eXL/hHnKCeZ5sO7EzUa
	ApIvd2PpFfNVBpszTDQaY1cQ/QoFhRVF1WEucMJs9e0ompzu/1YIKjqkbiZ2SET+Z3Kbgic
	oz3X0ki4SbXR2fhiYSTRx9wE070lwnznRNZ4kgJnw0vto2jLdP9eYArvBfY2KoVgcsEZn5M
	oSkl/wUtQhVGIABYmFd+yR1uNk1NKUI5xnfYV6YcpamgA3h5sGFBWEA4H47MLct78Xmrk+C
	MyctsJbJK6LxuNGHkHMQt2AIyiMXAQKR80gTYUIjhH2TWJGtDQeuOGTecvKorOnPj8LMjSE
	dnvQQ8RccAvEoSYlRcfFdb4qS3A9VKIV1WjPaITl3BCeAeKkPgELWv53DyYEE7UUX/6fyCh
	JWe92nbREsOGlUQP3xWAWG8eRjleuAFIHbpDcw0xPA+YeZgK+OQfzfTlozZfEUy+eezHYsS
	Jro0lq2QyQ76asCTE1RjekyiLieZCnl+0rN7l19K8FXiq2eJnaKV9+x1yf+T9lCDwAGdof5
	Ucg80MjYZwyG5sKuECKpLD3dPi4JA=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

The function ghes_estatus_pool_region_free() is exported and be called
by the PCIe AER recovery path, which unconditionally invokes it to free
aer_capability_regs memory.

Although current AER usage assumes memory comes from the GHES pool,
robustness requires guarding against pool unavailability. Add a NULL check
before calling gen_pool_free() to prevent crashes when the pool is not
initialized. This also makes the API safer for potential future use by
non-GHES callers.

Fixes: e2abc47a5a1a ("ACPI: APEI: Fix AER info corruption when error status data has multiple sections")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/acpi/apei/ghes.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 0dc767392a6c..e81c007464a9 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -236,7 +236,8 @@ int ghes_estatus_pool_init(unsigned int num_ghes)
  */
 void ghes_estatus_pool_region_free(unsigned long addr, u32 size)
 {
-	gen_pool_free(ghes_estatus_pool, addr, size);
+	if (ghes_estatus_pool)
+		gen_pool_free(ghes_estatus_pool, addr, size);
 }
 EXPORT_SYMBOL_GPL(ghes_estatus_pool_region_free);
 
-- 
2.48.1

