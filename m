Return-Path: <SRS0=Rtwj=6E=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699F6C3815B
	for <linux-acpi@archiver.kernel.org>; Mon, 20 Apr 2020 08:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37851218AC
	for <linux-acpi@archiver.kernel.org>; Mon, 20 Apr 2020 08:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587370298;
	bh=z7HimAurwDR3lrdQ6oem6FxF/SwH+vDNz6rygcWxpxQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=bD0PWR8Af4E5HJopMJCu854hO9wwuUVoe5NoSq3M1+alSHHXmZ84j8myXfGn/emoj
	 XcR6MeL1GGfulHLM+Uc4eOnCByribxWcFB5FtqF5rbXnxfTzDep5O7iH6B1lFHYsd/
	 YOLpOr8RSolgbazZy8o1uRvM8/4Gz3K1jAzvwY0Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbgDTILh (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 20 Apr 2020 04:11:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:47174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbgDTILh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 20 Apr 2020 04:11:37 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D3E320A8B;
        Mon, 20 Apr 2020 08:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587370297;
        bh=z7HimAurwDR3lrdQ6oem6FxF/SwH+vDNz6rygcWxpxQ=;
        h=From:To:Cc:Subject:Date:From;
        b=fqeCK0wgi2aU5Kupe7LuDEmWEQPXPlbM26SWTyXAt61zJnlCOF7Q6QvovjM95cVYa
         CllOGZycz/aXP3lwbWBwQ/yCTnl1PtSFfZlIKLhmiGoKgHUgGNiDh5Ya+UprL1JM8N
         3DRgCuWkDnCvcu+M76vMzB0Mg0Bil/nxRq2UtVz8=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-acpi@vger.kernel.org, sudeep.holla@arm.com,
        guohanjun@huawei.com, lorenzo.pieralisi@arm.com,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH] acpi: arm64/iort: Ensure DMA mask does not exceed device limit
Date:   Mon, 20 Apr 2020 10:11:31 +0200
Message-Id: <20200420081131.16822-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

When calculating the DMA mask from the address limit provided by the
firmware, we add one to the ilog2() of the end address, and pass the
result to DMA_BIT_MASK().

For an end address that is not a power-of-2 minus 1, this will result
in the mask to be wider than the limit, and cover memory that is not
addressable by the device. Instead, we should add 1 to 'end' before
taking the log, so that a limit of, say, 0x3fffffff gets translated
to a mask of 30, but any value below it gets translated to 29.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/acpi/arm64/iort.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 7d04424189df..aab2f51eff14 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -1162,7 +1162,7 @@ void iort_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size)
 		 * firmware.
 		 */
 		end = dmaaddr + size - 1;
-		mask = DMA_BIT_MASK(ilog2(end) + 1);
+		mask = DMA_BIT_MASK(ilog2(end + 1));
 		dev->bus_dma_limit = end;
 		dev->coherent_dma_mask = mask;
 		*dev->dma_mask = mask;
-- 
2.17.1

