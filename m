Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E20C7618E
	for <linux-acpi@archiver.kernel.org>; Fri, 21 Apr 2023 16:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbjDUQ1e (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Fri, 21 Apr 2023 12:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjDUQ1c (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Apr 2023 12:27:32 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050:0:465::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E59103;
        Fri, 21 Apr 2023 09:27:31 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Q30L45Rh8z9sfJ;
        Fri, 21 Apr 2023 18:27:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mariushoch.de;
        s=MBO0001; t=1682094444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/z/hD/lZG0E5LL9ESda6eRaKouQzamHTzP6dwJiUkUU=;
        b=ZjYUzhUCxBM5wsKWgOf0OVazmTGyo4COxvMjZOu1z1tvm3RL3I1BJO3nRCF7IOUOdROkS9
        majML+MHqTNxrrE7kIfEcT2ZEK8AYKv5WOWrxrPHw0fqM0bP4h//YGgqcHKj8Qxgt0dYNk
        WkkWq5F8GjeDAtxgFUBzMFJc0bLlJKNdGvAL3YY7HtO7V30Bt6vF2Ybc2h2oIt2ouNQWsR
        PUcmATR2Rv5bTrmUXW0qabsuoYr6PrKkfX4dyPVysGHaJOotIAd3CPJAIJddELH13EJmnt
        j2AprOq0cuBCVQ1khgkasr/6lChaELxOuQSBwWYZsCWVwm4SGsQPjLGBbbygbw==
From:   Marius Hoch <mail@mariushoch.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Marius Hoch <mail@mariushoch.de>
Subject: [PATCH] ACPI: scan: Ignore MAGN0001
Date:   Fri, 21 Apr 2023 18:27:02 +0200
Message-Id: <20230421162702.3558-1-mail@mariushoch.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The LSM303D on the Lenovo Yoga Tablet 2 series is present
as both ACCL0001 and MAGN0001. As we can only ever register an
i2c client for one of them, ignore MAGN0001.

Currently this errors:
i2c i2c-4: Failed to register i2c client MAGN0001:00 at 0x1d (-16)

Tested on a Lenovo Yoga Tablet 2 1051-F.

Signed-off-by: Marius Hoch <mail@mariushoch.de>
---
 drivers/acpi/scan.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 0c6f06abe3f4..d21c411e9719 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1730,6 +1730,12 @@ static bool acpi_device_enumeration_by_parent(struct acpi_device *device)
 	 */
 		{"BCM4752", },
 		{"LNV4752", },
+	/*
+	 * The LSM303D on the Lenovo Yoga Tablet 2 series is present
+	 * as both ACCL0001 and MAGN0001. As we can only ever register an
+	 * i2c client for one of them, ignore MAGN0001.
+	 */
+		{"MAGN0001", },
 		{}
 	};
 

base-commit: cb0856346a60fe3eb837ba5e73588a41f81ac05f
-- 
2.40.0

