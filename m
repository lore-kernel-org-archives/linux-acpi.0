From: akpm@osdl.org
Subject: [patch 13/16] ia64: acpi_memhotplug() fix
Date: Thu, 27 Apr 2006 02:25:13 -0700
Message-ID: <200604270926.k3R9QfZK025108@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:48845 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965010AbWD0J0o (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 27 Apr 2006 05:26:44 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, kamezawa.hiroyu@jp.fujitsu.com


From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

This export was necessary to compile acpi_memhotplug.c as module.

Signed-off-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: "Brown, Len" <len.brown@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/ia64/mm/init.c |    2 ++
 1 files changed, 2 insertions(+)

diff -puN arch/ia64/mm/init.c~ia64-acpi_memhotplug-fix arch/ia64/mm/init.c
--- devel/arch/ia64/mm/init.c~ia64-acpi_memhotplug-fix	2006-04-10 23:16:26.000000000 -0700
+++ devel-akpm/arch/ia64/mm/init.c	2006-04-10 23:16:26.000000000 -0700
@@ -671,9 +671,11 @@ int add_memory(u64 start, u64 size)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(add_memory);
 
 int remove_memory(u64 start, u64 size)
 {
 	return -EINVAL;
 }
+EXPORT_SYMBOL_GPL(remove_memory);
 #endif
_
