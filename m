Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFFAC43217
	for <linux-acpi@archiver.kernel.org>; Sat, 26 Nov 2022 11:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbiKZLbJ (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Sat, 26 Nov 2022 06:31:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKZLbI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 26 Nov 2022 06:31:08 -0500
Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5AFE20F51
        for <linux-acpi@vger.kernel.org>; Sat, 26 Nov 2022 03:31:04 -0800 (PST)
Received: from pop-os.home ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id ytOfoOUED1LdIytOfoAzaK; Sat, 26 Nov 2022 12:31:03 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 26 Nov 2022 12:31:03 +0100
X-ME-IP: 86.243.100.34
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-acpi@vger.kernel.org
Subject: [PATCH] ACPI: APEI: Remove a useless include
Date:   Sat, 26 Nov 2022 12:30:55 +0100
Message-Id: <f619bc0b58a70e1cd1942b3db3716d6f9b261666.1669462247.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This file does not use rcu, so there is no point in including
<linux/rculist.h>.

So just remove it.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/acpi/apei/apei-base.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
index 02196a312dc5..c7c26872f4ce 100644
--- a/drivers/acpi/apei/apei-base.c
+++ b/drivers/acpi/apei/apei-base.c
@@ -25,7 +25,6 @@
 #include <linux/slab.h>
 #include <linux/io.h>
 #include <linux/kref.h>
-#include <linux/rculist.h>
 #include <linux/interrupt.h>
 #include <linux/debugfs.h>
 #include <acpi/apei.h>
-- 
2.34.1

