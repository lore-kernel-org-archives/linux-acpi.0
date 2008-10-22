From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 1/4] Hibernate: Call platform_begin before swsusp_shrink_memory
Date: Wed, 22 Oct 2008 22:50:35 +0200
Message-ID: <200810222250.36537.rjw@sisk.pl>
References: <200810222249.20629.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:33972 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754278AbYJVUus (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 22 Oct 2008 16:50:48 -0400
In-Reply-To: <200810222249.20629.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Zhang Rui <rui.zhang@intel.com>, Ingo Molnar <mingo@elte.hu>

From: Zhang Rui <rui.zhang@intel.com>

Hibernate: Call platform_begin before swsusp_shrink_memory

Call platform_begin() before swsusp_shrink_memory() so that we can
always allocate enough memory to save the ACPI NVS region from
platform_begin().

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/disk.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6/kernel/power/disk.c
===================================================================
--- linux-2.6.orig/kernel/power/disk.c
+++ linux-2.6/kernel/power/disk.c
@@ -267,12 +267,12 @@ int hibernation_snapshot(int platform_mo
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
 

