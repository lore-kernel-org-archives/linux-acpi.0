Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506F7234994
	for <linux-acpi@vger.kernel.org>; Fri, 21 Aug 2026 13:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787318163; cv=none; b=KtU+5cXeP+SUeZiuK9DrOnK8iA69+gXp27LwX5sQjfjFJi1YIEjpMXTFqI+lPz2oSny3O1HcShZyuQqN3v+bYTRjOgrHvAEYeZ/8zodw+FR68mRARpF+YXo82gQNTzsIMe2Z8/WbAdompF1SVieyCgZR4UFNKavAjvftU0DgvPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787318163; c=relaxed/simple;
	bh=+KhYVMydrYgPR98BqSpPLeIxb4g/f7Dk4jYk5D7+Q5M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JtJ0OC9w1GqNcFc1Wj07t/N0PlK4HQPu9IRZc5nP29xZLVR/hWHGUW2Opp1FfyPEM5YZe/weoQLIKsWTtWTJ8q4xh8bRmrsC+UXMMentFNChl0U8vlQgv7yu1waNRVY4Xdg0AtL7XHYVXKvwgsec1P/1ISZQibozL0CNT13qFeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y5AsC11C; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5AsC11C"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-ca88130e09aso575528a12.3
        for <linux-acpi@vger.kernel.org>; Fri, 21 Aug 2026 06:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787318141; x=1787922941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EVys3VQrF2tlzq5qd2aSNH95yGzaLYuAMcH2wHjS3yQ=;
        b=Y5AsC11Ca6bTDu/jf05N3PdXRE/Wsj69/v2vqQYx2505aHR+PFE6sobOb8NtXpTMcl
         /GCkFBg93OCBr2y4JVa94M1T8ZAGj0KsHJ877t8GLTFsxckSmvbWrjQ0xORgSgv4sUjT
         O2kr/Z/St2wD+fH+eZT/YVlrWKim80OsiA9ikrYeQlbvMDqEyhy09WzcJ/YCLMItmmqU
         er6J4AOfhkkvjDzDdYvKQo/E5RjAT0CF9j1x8sNZ+NBnKoDf5ZN+FAxY9TXMEGtkl9T5
         6ZbkubgeW4J6/1nX3UMT/N2ean4jyyMZP2YL77csr8uZImf02K5I2HUouMXwyjW0PSVy
         IDOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787318141; x=1787922941;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EVys3VQrF2tlzq5qd2aSNH95yGzaLYuAMcH2wHjS3yQ=;
        b=Fv/lJxCGL28PXBFRz0hdfQPlUnbJzCy29u7Eai4Q3t1bSKre4UY89qndx2UVIE5pw7
         mzzcjkI9TJtVdShDKoEhAuPsuRZqlvT8e6A2i9SoMAkJptLp3HySbbRdus99aBQK+Clh
         BZALtPS2w63EDQ4fwTp1XLS9xuAEHKaTeEfyWUG0+400/hndgRCpWMdSgVc4+ByafV2k
         VA4mMu0/gZ/BcyPNSTseQ4DhGW+OUvlLOpDFozYohXCz0eMmvGfq8zkof7DksDDxCDIU
         IchYseRScsqH1fXP7xCJs/KW5bk47o7Q/PuAyC3CwyPeL+R3tW+3leYLobPYGzUh52fw
         cMCg==
X-Forwarded-Encrypted: i=1; AHgh+Rp11di+xqYc4R3xGwyd56AxD0DnnuCmJzddxffXkSS3USWrWEDgv6vY2TtCenVc2w99Z0wqm+dYHsoS@vger.kernel.org
X-Gm-Message-State: AFuF++mjAlDLUdPwIoq5yl1JrTq8aZyyKvSgJ8vtEWE3IBeDmhxdBnK/
	n1PqxDNpJLrshZQMzn0rtyij9seKuTS0EhQPr+c92zavClVL/Qn08Fq4
X-Gm-Gg: AR+sD123FXBgh4IFY2nclEIRBGG2g2N8REmJht7uPHwSYa+cnWGMRQaxmS8Q/q+b6Gd
	mF4wC5Mo1qXM8jff8j3m6t0WAKAG/kl8WKdYOzw4zqbAO54Z7e/PTuM9BONDVt5svJ46TUPRPT5
	qPrRpChKgxdmOycrlXClnNiu1u0SA46uFPBXw2UPvAnMy0ElvWIKPpQmyxhyrw4dRlMF4lGlRwg
	TxmOmNpeR/9WYHHAuP1nBzQffPhyEWxUefrvsea+Dzh82xDQXu/Ccn0M1grVZmP7zt3hRsXUFl1
	7h8tVlnnBLb1XO/jklbRyh+Hf4x0eNf+C+MJ9NyEX/NpK/RlXybFG+JZ351cfw6733pkpyeThPk
	GVCZukkpFYaoDiGygDvKw21C+kYgVgcDNX3eLHODYuP44qUjVpOJs92/eNgK0FDH5g2buVgyfNi
	wwONLJtTDYWH/+YATNLzGbVzAGreYn7ug8wjzqEgWynKm8ScYVEWeBzVw=
X-Received: by 2002:a17:90b:4986:b0:38e:e9b:ffa4 with SMTP id 98e67ed59e1d1-395c33cf295mr12175088a91.6.1787318140787;
        Fri, 21 Aug 2026 06:15:40 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395c4697358sm3221515a91.8.2026.08.21.06.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 06:15:40 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org
Subject: [PATCH] ACPI: MRRM: Use for_each_populated_zone() in get_node_num()
Date: Fri, 21 Aug 2026 22:15:08 +0900
Message-ID: <20260821131530.3375820-1-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

get_node_num() iterates over the populated zones of every online node
with a nested loop. for_each_populated_zone() iterates over the same
zones in the same order.

So use for_each_populated_zone() instead and remove the unused
variable.

No functional change.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 drivers/acpi/acpi_mrrm.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/acpi_mrrm.c b/drivers/acpi/acpi_mrrm.c
index e99cbda83452..83934e2aa0d4 100644
--- a/drivers/acpi/acpi_mrrm.c
+++ b/drivers/acpi/acpi_mrrm.c
@@ -36,17 +36,11 @@ static u32 mrrm_mem_entry_num;
 
 static int get_node_num(struct mrrm_mem_range_entry *e)
 {
-	unsigned int nid;
+	struct zone *zone;
 
-	for_each_online_node(nid) {
-		for (int z = 0; z < MAX_NR_ZONES; z++) {
-			struct zone *zone = NODE_DATA(nid)->node_zones + z;
-
-			if (!populated_zone(zone))
-				continue;
-			if (zone_intersects(zone, PHYS_PFN(e->base), PHYS_PFN(e->length)))
-				return zone_to_nid(zone);
-		}
+	for_each_populated_zone(zone) {
+		if (zone_intersects(zone, PHYS_PFN(e->base), PHYS_PFN(e->length)))
+			return zone_to_nid(zone);
 	}
 
 	return -ENOENT;
-- 
2.43.0

