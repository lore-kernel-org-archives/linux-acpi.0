Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43A820010A;
	Thu,  8 Oct 2026 02:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791427925; cv=none; b=EIWcnpblBNRBqe0ysw7kHwrHZYvyLzc+WejIgXROYRTmI79Zj2KnGoNum0OHHyoHgk3zRRxDvWxI4ffYUtEdQLjPGCx9mRfAocQn5Msv8mu2f4wYzCoATXN2E06Bac1WWyw/bDNY4QWA4pHpkRfTMcoZK0D7lxbJ8JYMHBiAklg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791427925; c=relaxed/simple;
	bh=+xbwlBBvR9CRiHYs+WTpCuPJVQXQl/8Ej0dbvlQqk9I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SHmqK1tEL2nTy+G4qyvcPDS0scxWDeE+rpw15G5JaR4i9R3t8Aqd2ApKhtzJGpDGQwWGC3i+QnSTdnnyw/X+CqJjwsY7e7tn0ibP4iRmc85z6GoiaQ3wXsdL+if/Z755mreBrA6Us5Z91WujzccqTllyXwOvSH5BvJ9F2787UTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 386840b4c2c311f19a56ed5b684f684d-20261008
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:e253ccb0-8e6f-48d8-82de-b7ddf1079c75,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:7db8b62,CLOUDID:3019ea6ce21a8533f5a7e2926d08123e,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50|99,EDM:5,IP
	:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 386840b4c2c311f19a56ed5b684f684d-20261008
X-User: luriwen@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <luriwen@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 718248067; Thu, 08 Oct 2026 10:51:54 +0800
From: Riwen Lu <luriwen@kylinos.cn>
To: rafael@kernel.org
Cc: luriwen@kylinos.cn,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: PM: sleep: Drop unused sleep_no_lps0 define
Date: Thu,  8 Oct 2026 10:51:52 +0800
Message-Id: <20261008025152.153073-1-luriwen@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sleep_no_lps0 stub define in the !CONFIG_ACPI_SLEEP branch of
sleep.c has no users left in that file: the LPS0 code consuming it
was moved to drivers/acpi/x86/s2idle.c by commit fef98671194b ("ACPI:
PM: s2idle: Move x86-specific code to the x86 directory"), which has
its own static module parameter of the same name, so the define is
no longer used.

Drop it.

Signed-off-by: Riwen Lu <luriwen@kylinos.cn>
---
 drivers/acpi/sleep.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 132a9df98471..a94bac4422d4 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -548,7 +548,6 @@ static void acpi_pm_end(void)
 	acpi_sleep_tts_switch(acpi_target_sleep_state);
 }
 #else /* !CONFIG_ACPI_SLEEP */
-#define sleep_no_lps0	(1)
 #define acpi_target_sleep_state	ACPI_STATE_S0
 #define acpi_sleep_default_s3	(1)
 static inline void acpi_sleep_dmi_check(void) {}
-- 
2.25.1

