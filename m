From: malattia@linux.it
Subject: [patch 2/5] Small tweak to define uintptr_t and successfully build on debian/kfreebsd
Date: Sun, 04 Jul 2010 13:43:34 +0900
Message-ID: <20100704044450.778114511@linux.it>
References: <20100704044332.573836359@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:49572
	"EHLO smtp.kamineko.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752607Ab0GDEvA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 4 Jul 2010 00:51:00 -0400
Content-Disposition: inline; filename=fix_ftbfs_debian-kfreebsd.patch
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Robert Moore <Robert.Moore@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Mattia Dongili <malattia@linux.it>

Signed-off-by: Mattia Dongili <malattia@linux.it>
---
 include/platform/acenv.h |    3 +++
 1 file changed, 3 insertions(+)

Index: b/include/platform/acenv.h
===================================================================
--- a/include/platform/acenv.h	2010-07-02 21:42:26.785349387 +0900
+++ b/include/platform/acenv.h	2010-07-04 11:18:37.250028892 +0900
@@ -182,6 +182,9 @@
 
 
 /*! [Begin] no source code translation */
+#if defined(__GLIBC__)
+#include <stdint.h>
+#endif
 
 /******************************************************************************
  *

