Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A375AC433F5
	for <linux-acpi@archiver.kernel.org>; Thu, 24 Feb 2022 11:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234089AbiBXLjI (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Thu, 24 Feb 2022 06:39:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234055AbiBXLjE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Feb 2022 06:39:04 -0500
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9576E1B0C59;
        Thu, 24 Feb 2022 03:38:34 -0800 (PST)
Received: from localhost.localdomain (ip5f5aee05.dynamic.kabel-deutschland.de [95.90.238.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 1990A61EA193F;
        Thu, 24 Feb 2022 12:38:33 +0100 (CET)
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     Robert Moore <robert.moore@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>, linux-acpi@vger.kernel.org,
        devel@acpica.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] acpi: exsystem: Warn about sleeps greater than 50 ms
Date:   Thu, 24 Feb 2022 12:38:05 +0100
Message-Id: <20220224113807.91771-3-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220224113807.91771-1-pmenzel@molgen.mpg.de>
References: <20220224113807.91771-1-pmenzel@molgen.mpg.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Quick boottime is important, so warn about sleeps greater than 50 ms in
ACPI.

50 ms is still long compared to distribution Linux kernels reaching initrd
in 350 ms, so should probably changed to 10 ms, so people are aware
about this.

Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
 drivers/acpi/acpica/exsystem.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/acpi/acpica/exsystem.c b/drivers/acpi/acpica/exsystem.c
index 00f66af31ffa..bdffb8aac05c 100644
--- a/drivers/acpi/acpica/exsystem.c
+++ b/drivers/acpi/acpica/exsystem.c
@@ -167,6 +167,11 @@ acpi_status acpi_ex_system_do_sleep(u64 how_long_ms)
 
 	acpi_ex_exit_interpreter();
 
+	if (how_long_ms > 50) {
+		ACPI_WARNING((AE_INFO,
+		    "Time parameter %llu > 50 ms. Please contact firmware vendor for more responsive system.", how_long_ms));
+	}
+
 	/*
 	 * For compatibility with other ACPI implementations and to prevent
 	 * accidental deep sleeps, limit the sleep time to something reasonable.
-- 
2.35.1

