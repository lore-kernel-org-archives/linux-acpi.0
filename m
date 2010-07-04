From: malattia@linux.it
Subject: [patch 5/5] Fix FTBFS on hurd-i386.
Date: Sun, 04 Jul 2010 13:43:37 +0900
Message-ID: <20100704044451.546480129@linux.it>
References: <20100704044332.573836359@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:45890
	"EHLO smtp.kamineko.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752603Ab0GDE4B (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 4 Jul 2010 00:56:01 -0400
Content-Disposition: inline; filename=fix_ftbfs_debian-hurd.patch
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Robert Moore <Robert.Moore@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Mattia Dongili <malattia@linux.it>

Signed-off-by: Mattia Dongili <malattia@linux.it>
---
 include/platform/acenv.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/include/platform/acenv.h
===================================================================
--- a/include/platform/acenv.h	2010-07-04 11:18:17.506017933 +0900
+++ b/include/platform/acenv.h	2010-07-04 11:18:24.686018064 +0900
@@ -193,7 +193,7 @@
  *
  *****************************************************************************/
 
-#if defined(_LINUX) || defined(__linux__)
+#if defined(_LINUX) || defined(__linux__) || defined(__GNU__)
 #include "aclinux.h"
 
 #elif defined(__FreeBSD__) || defined(__FreeBSD_kernel__)

