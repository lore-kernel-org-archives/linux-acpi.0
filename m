From: Len Brown <lenb@kernel.org>
Subject: [PATCH 05/94] Hibernate: Call platform_begin before
 swsusp_shrink_memory
Date: Fri, 09 Jan 2009 04:26:07 -0500
Message-ID: <3fe0313e6ec572e6bb3f9d247316a834336db4be.1231492607.git.len.brown@intel.com>
References: <1231493256-11678-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:51401 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752496AbZAIJ1p (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 04:27:45 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0KD700AWC6A8WCL9@vms044.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 03:27:45 -0600 (CST)
In-reply-to: <1231493256-11678-1-git-send-email-lenb@kernel.org>
In-reply-to: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
References: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

Call platform_begin() before swsusp_shrink_memory() so that we can
always allocate enough memory to save the ACPI NVS region from
platform_begin().

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Acked-by: Nigel Cunningham <nigel@tuxonice.net>
Acked-by: Pavel Machek <pavel@suse.cz>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 kernel/power/disk.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/power/disk.c b/kernel/power/disk.c
index c9d7408..096fe48 100644
--- a/kernel/power/disk.c
+++ b/kernel/power/disk.c
@@ -259,12 +259,12 @@ int hibernation_snapshot(int platform_mode)
 {
 	int error, ftrace_save;
 
-	/* Free memory before shutting down devices. */
-	error = swsusp_shrink_memory();
+	error = platform_begin(platform_mode);
 	if (error)
 		return error;
 
-	error = platform_begin(platform_mode);
+	/* Free memory before shutting down devices. */
+	error = swsusp_shrink_memory();
 	if (error)
 		goto Close;
 
-- 
1.5.6.6

