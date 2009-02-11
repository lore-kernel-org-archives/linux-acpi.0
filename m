From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] ACPI: get_throttling_state() cannot be larger state_count
Date: Wed, 11 Feb 2009 20:50:12 +0100
Message-ID: <49932BF4.2010005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f20.google.com ([209.85.220.20]:48976 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755942AbZBKTuJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Feb 2009 14:50:09 -0500
Received: by fxm13 with SMTP id 13so1097102fxm.13
        for <linux-acpi@vger.kernel.org>; Wed, 11 Feb 2009 11:50:07 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

With for(i = 0; i < n; i++) { ... } i reaches n.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_throttling.c
index d278381..6feb9ab 100644
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -785,7 +785,7 @@ static int acpi_get_throttling_state(struct acpi_processor *pr,
 		if (tx->control == value)
 			break;
 	}
-	if (i > pr->throttling.state_count)
+	if (i >= pr->throttling.state_count)
 		i = -1;
 	return i;
 }
