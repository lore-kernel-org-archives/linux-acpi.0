Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26DAEC43334
	for <linux-acpi@archiver.kernel.org>; Wed,  6 Jul 2022 01:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbiGFBo0 (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 5 Jul 2022 21:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiGFBo0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Jul 2022 21:44:26 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 71AE9A471;
        Tue,  5 Jul 2022 18:44:25 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 878A61E80D92;
        Wed,  6 Jul 2022 09:42:14 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4SKAl-4QP284; Wed,  6 Jul 2022 09:42:12 +0800 (CST)
Received: from node1.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zeming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id D01CE1E80D40;
        Wed,  6 Jul 2022 09:42:11 +0800 (CST)
From:   Li zeming <zeming@nfschina.com>
To:     rafael@kernel.org, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@nfschina.com, Li zeming <zeming@nfschina.com>
Subject: [PATCH] acpi/sleep: Add header file macro definition
Date:   Wed,  6 Jul 2022 09:44:04 +0800
Message-Id: <20220706014404.3191-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add header file macro definition.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 drivers/acpi/sleep.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/sleep.h b/drivers/acpi/sleep.h
index 7fe41ee489d6..adb3b5c13f90 100644
--- a/drivers/acpi/sleep.h
+++ b/drivers/acpi/sleep.h
@@ -1,4 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _SLEEP_H
+#define _SLEEP_H
 
 extern void acpi_enable_wakeup_devices(u8 sleep_state);
 extern void acpi_disable_wakeup_devices(u8 sleep_state);
@@ -30,3 +32,5 @@ extern bool acpi_sleep_default_s3;
 #else
 #define acpi_sleep_default_s3	(1)
 #endif
+
+#endif
-- 
2.18.2

