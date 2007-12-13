From: akpm@linux-foundation.org
Subject: [patch 2/8] git-acpi build fix
Date: Thu, 13 Dec 2007 15:53:33 -0800
Message-ID: <200712132353.lBDNrXRG024821@imap1.linux-foundation.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:58376 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760409AbXLMXyE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 13 Dec 2007 18:54:04 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, rjw@sisk.pl

From: Andrew Morton <akpm@linux-foundation.org>

ia64 allmodconfig:

kernel/power/main.c:493: error: `pm_test_attr' undeclared here (not in a function)

Cc: Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 kernel/power/main.c |    3 ---
 1 file changed, 3 deletions(-)

diff -puN kernel/power/main.c~git-acpi-build-fix kernel/power/main.c
--- a/kernel/power/main.c~git-acpi-build-fix
+++ a/kernel/power/main.c
@@ -489,9 +489,6 @@ static struct attribute * g[] = {
 #ifdef CONFIG_PM_TRACE
 	&pm_trace_attr.attr,
 #endif
-#ifdef CONFIG_PM_DEBUG
-	&pm_test_attr.attr,
-#endif
 	NULL,
 };
 
_
