Return-Path: <SRS0=rJye=WQ=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B10C3A5A2
	for <linux-acpi@archiver.kernel.org>; Tue, 20 Aug 2019 00:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0686E22CF4
	for <linux-acpi@archiver.kernel.org>; Tue, 20 Aug 2019 00:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JXk7YvHu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbfHTAUE (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 19 Aug 2019 20:20:04 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:50792 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729072AbfHTASw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 19 Aug 2019 20:18:52 -0400
Received: by mail-pf1-f201.google.com with SMTP id b21so3519479pfb.17
        for <linux-acpi@vger.kernel.org>; Mon, 19 Aug 2019 17:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=r2xGnC0FtOlmxcR7U4lP7p0O5/wEeWW3Rzosx6HPL/8=;
        b=JXk7YvHu8uy9Vx2jXXzyKER+S/SWTrnD/83LRDR4ElsTuqbjh18fiB1AgcrqZ1ZtIF
         dMLq3zzoXUE6dXGuKvPut+6ATWyGRbKYpJQIWJjwFu6Tktlm4+khhBMdXLh/0OqWlkJD
         h3VT2eyE0HfHclqvuDTTYe++NSkz3ZXZS/oEfZAVPh9H+VGFEqFJWQTLj/AGb6qRW153
         dVTBXGCk+4jZcyzl7B6lYmE2JFLT24V4zbxfcymtMySEfGel9M+ifHbgb0XkoBrbcMve
         Smv1XxFiTFUE/g7rS3PzrYA0UBMXXLGMKnG7YB3ziODgQiU6yzj6lIxTEPV4wJpLoQRH
         +Brg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=r2xGnC0FtOlmxcR7U4lP7p0O5/wEeWW3Rzosx6HPL/8=;
        b=e2Wm047QLRAnemHE3lYs5xJ3rFTk3FaR9J2jrFl4pQ7hkAPg6oSmzOVtT70dJglrrF
         j8FyKOaSvAGJW404CkuWUNZpMA4emxENXUlcYw7BR9Nx2RW/PRZe91tOvmL8nPiwIvOd
         uMGBddsBCZ8HT0Dy0vJ5Emnypi9eE1fM2r7Gw/xxTqLSzDs0RolEyXG4WEFm7E68e7gf
         RFY29AKrKFN9hUusP0FoncHZiBQlL7TyDeSH3H+PbztnAI0s1fz9ScbqUHUQuk9P0Xla
         Gfv8rOClT8guu3aEDVT3WSnL+989hJVyIBrv1e4/jRbN1t4NW+quIYmUjAAoJQ8eg+86
         VShQ==
X-Gm-Message-State: APjAAAVOQ7bn0gtUlLYX/J9dpjbXU2ULypkpsGW8e7N46BjBrJUxmZjr
        i944qiHHJSNU1T03DOhXQeiewbGHE5d8MOwdF4Y7Kg==
X-Google-Smtp-Source: APXvYqxrGakYRkc/UBdl5S+Lz4mZIkCuit30tjXFo94slFXGF6j556kZ0jwzI6cM9tqT+OLJIW/WjG8X9KIlf81TlA81yg==
X-Received: by 2002:a65:56c1:: with SMTP id w1mr21932176pgs.395.1566260331657;
 Mon, 19 Aug 2019 17:18:51 -0700 (PDT)
Date:   Mon, 19 Aug 2019 17:17:52 -0700
In-Reply-To: <20190820001805.241928-1-matthewgarrett@google.com>
Message-Id: <20190820001805.241928-17-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190820001805.241928-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH V40 16/29] acpi: Disable ACPI table override if the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Linn Crosetto <lcrosetto@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Linn Crosetto <lcrosetto@gmail.com>

>From the kernel documentation (initrd_table_override.txt):

  If the ACPI_INITRD_TABLE_OVERRIDE compile option is true, it is possible
  to override nearly any ACPI table provided by the BIOS with an
  instrumented, modified one.

When lockdown is enabled, the kernel should disallow any unauthenticated
changes to kernel space.  ACPI tables contain code invoked by the kernel,
so do not allow ACPI tables to be overridden if the kernel is locked down.

Signed-off-by: Linn Crosetto <lcrosetto@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
cc: linux-acpi@vger.kernel.org
Signed-off-by: James Morris <jmorris@namei.org>
---
 drivers/acpi/tables.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index de974322a197..b7c29a11c0c1 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -20,6 +20,7 @@
 #include <linux/memblock.h>
 #include <linux/earlycpio.h>
 #include <linux/initrd.h>
+#include <linux/security.h>
 #include "internal.h"
 
 #ifdef CONFIG_ACPI_CUSTOM_DSDT
@@ -577,6 +578,11 @@ void __init acpi_table_upgrade(void)
 	if (table_nr == 0)
 		return;
 
+	if (security_locked_down(LOCKDOWN_ACPI_TABLES)) {
+		pr_notice("kernel is locked down, ignoring table override\n");
+		return;
+	}
+
 	acpi_tables_addr =
 		memblock_find_in_range(0, ACPI_TABLE_UPGRADE_MAX_PHYS,
 				       all_tables_size, PAGE_SIZE);
-- 
2.23.0.rc1.153.gdeed80330f-goog

