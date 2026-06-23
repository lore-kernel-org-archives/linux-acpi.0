Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9648C3A9DB6;
	Tue, 23 Jun 2026 05:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782194236; cv=none; b=oL7sCDRkS22bCX95gdEy5ySD4zS0MCX3hD32YHHL0fv3qDYpBL3B8Oh0llwG8xWYrp5E0dr/JsY0PqnaNH35gX52E3QLw8VEadvJswN1QIwcmFIn3KwD1ByXdsrkdqw9hPPeron7q2LYcgtGh332g4kmQUXg5qNLGbZ7zwBnJOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782194236; c=relaxed/simple;
	bh=6HttreO5qXTswLSCdB2KkIIpWSf0Eam0+pwg0hs23OE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O8OQTMpwVtjjqNPuvjAkMgPJ1z9wKZQbrJr6eHwgLN9rSk9BTiSyTmQENVfv3xu4rweSmvK9OnhZN69SoXgKDxWp9HSgV//K5X57OWlQ3KDAx2jzJ7/fScw+JvetZjJOzJ3co7BIg67qKAZ/3hFCVn0P0wVG9mMwwbJ6xXWKWxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=RZi649Tn; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RZi649Tn"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782194231; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=yd7g7tmJbdOl7BHlxR/cTf5P6v5Kbi0TSh38I3m2D3w=;
	b=RZi649TnjBEGi7hoxhTw3k9BpI3XV4lTGBLK3diJYwquDD33/AXnAO1ss1APzR0wNbpWeZjBIunGcpjUxhK/KOP8Jie+REdsbFil5H9P8EGj9rV6UtjgQN1gYOSLRkp2Gl3BGv40UtBvvz8ngqT64K8KNdfu0zdmDxWSp8v5X4w=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R461e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0X5T-vRv_1782194224;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0X5T-vRv_1782194224 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 23 Jun 2026 13:57:11 +0800
From: Guanghui Feng <guanghuifeng@linux.alibaba.com>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alikernel-developer@linux.alibaba.com
Subject: [PATCH] ACPI: PRM: Fix off-by-one in efi_pa_va_lookup() address range check
Date: Tue, 23 Jun 2026 13:57:03 +0800
Message-ID: <20260623055703.3793586-1-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The boundary check in efi_pa_va_lookup() uses a strict less-than
comparison (md->phys_addr < pa), which incorrectly excludes the case
where the lookup address equals the start of an EFI memory descriptor's
physical address range.

This causes a lookup failure when a PRM handler address happens to be
at the exact start of a runtime memory region, as the descriptor that
should match gets skipped.

Fix this by using a non-strict comparison (md->phys_addr <= pa) to
include the region start address, consistent with the standard
__efi_mem_desc_lookup() implementation in drivers/firmware/efi/efi.c.

Fixes: cefc7ca46235 ("ACPI: PRM: implement OperationRegion handler for the PlatformRtMechanism subtype")
Signed-off-by: Guanghui Feng <guanghui.fgh@linux.alibaba.com>
---
 drivers/acpi/prmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
index 7f5851371e5f..fcc17ce0a88e 100644
--- a/drivers/acpi/prmt.c
+++ b/drivers/acpi/prmt.c
@@ -80,7 +80,7 @@ static u64 efi_pa_va_lookup(efi_guid_t *guid, u64 pa)
 
 	for_each_efi_memory_desc(md) {
 		if ((md->attribute & EFI_MEMORY_RUNTIME) &&
-		    (md->phys_addr < pa && pa < md->phys_addr + PAGE_SIZE * md->num_pages)) {
+		    (md->phys_addr <= pa && pa < md->phys_addr + PAGE_SIZE * md->num_pages)) {
 			return pa_offset + md->virt_addr + page - md->phys_addr;
 		}
 	}
-- 
2.43.7

