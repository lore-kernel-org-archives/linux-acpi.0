Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA4A5C433FE
	for <linux-acpi@archiver.kernel.org>; Tue,  4 Oct 2022 10:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiJDKeD (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 4 Oct 2022 06:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbiJDKdv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 4 Oct 2022 06:33:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B18531EDC;
        Tue,  4 Oct 2022 03:33:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1BAB4B819B0;
        Tue,  4 Oct 2022 10:33:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D12CAC4347C;
        Tue,  4 Oct 2022 10:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664879627;
        bh=z316zTp9PCAkwnzApXdg+7WzQw2yLNucnQgZR9dXar0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s4muEv07nW60xo5kEVHSSp+/WMZY3c6V2SgXq6gWzYnZ7cmpI7mfyCcIrRwjwUX4f
         XjDdOyAgyqD61gpkOQjR4ar9ijbfnJjPH8b8wS9XdSoB9p0REH8STYd3VQ9WcOvqzF
         6kyL9V03CnKQ+s9Pis4XcrJ8TFmDUvpqGgiAOx4sd2mS256vbsqc2ODITmuW2b8QIL
         bSEZb+oDDaRbhgdyRngaSR/i5EVQJBBHhBduvoHK5PYhpIuOXCcHIL3TdP1GiGm2dm
         aF+YjU6wp1Htrc8Sr0WF0/EKOs00BTlhY73F0pn5luLGkblz82Ek4a3sbroaGVcQ/6
         PadgFMBOrFeSw==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     rafael.j.wysocki@intel.com
Cc:     linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Chuanhong Guo <gch981213@gmail.com>,
        Tighe Donnelly <tighe.donnelly@protonmail.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 2/2] ACPI: resource: note more about IRQ override
Date:   Tue,  4 Oct 2022 12:33:41 +0200
Message-Id: <20221004103341.12646-2-jirislaby@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221004103341.12646-1-jirislaby@kernel.org>
References: <20221004103341.12646-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Use an exclamation mark to note which of the properties was overridden.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org
Cc: Chuanhong Guo <gch981213@gmail.com>
Cc: Tighe Donnelly <tighe.donnelly@protonmail.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/acpi/resource.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 8d13e94bb921..497d626185e4 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -508,8 +508,11 @@ static void acpi_dev_get_irqresource(struct resource *res, u32 gsi,
 		u8 pol = p ? ACPI_ACTIVE_LOW : ACPI_ACTIVE_HIGH;
 
 		if (triggering != trig || polarity != pol) {
-			pr_warn("ACPI: IRQ %d override to %s, %s\n", gsi,
-				t ? "level" : "edge", p ? "low" : "high");
+			pr_warn("ACPI: IRQ %d override to %s%s, %s%s\n", gsi,
+				t ? "level" : "edge",
+				trig == triggering ? "" : "(!)",
+				p ? "low" : "high",
+				pol == polarity ? "" : "(!)");
 			triggering = trig;
 			polarity = pol;
 		}
-- 
2.37.3

