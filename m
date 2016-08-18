From: "=?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=" <jprvita@gmail.com>
Subject: [PATCH 1/1] acpi: Check walk_state->scope_info before dereferencing
Date: Thu, 18 Aug 2016 16:36:37 -0400
Message-ID: <1471552597-27909-2-git-send-email-jprvita@endlessm.com>
References: <1471552597-27909-1-git-send-email-jprvita@endlessm.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:35509 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753571AbcHSJNK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Aug 2016 05:13:10 -0400
Received: by mail-qk0-f195.google.com with SMTP id o1so4072017qkd.2
        for <linux-acpi@vger.kernel.org>; Fri, 19 Aug 2016 02:13:09 -0700 (PDT)
In-Reply-To: <1471552597-27909-1-git-send-email-jprvita@endlessm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux@endlessm.com, =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@endlessm.com>

This fixes a NULL pointer derefence on an Acer Aspire E14 ES1-432-P06A.
The IP in the kernel panic trace points to
acpi_ds_load1_begin_op+0xde/0x283, which translates to the dereference
of walk_state->scope_info in that function.
---
 drivers/acpi/acpica/dswload.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/dswload.c b/drivers/acpi/acpica/dswload.c
index fd34040..17406ab 100644
--- a/drivers/acpi/acpica/dswload.c
+++ b/drivers/acpi/acpica/dswload.c
@@ -246,7 +246,8 @@ acpi_ds_load1_begin_op(struct acpi_walk_state *walk_state,
 					  acpi_ut_get_type_name(node->type)));
 
 			node->type = ACPI_TYPE_ANY;
-			walk_state->scope_info->common.value = ACPI_TYPE_ANY;
+			if (walk_state->scope_info)
+				walk_state->scope_info->common.value = ACPI_TYPE_ANY;
 			break;
 
 		case ACPI_TYPE_METHOD:
-- 
2.8.1

