From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: [PATCH -mm] acpi: fix memory_hotplug externs
Date: Tue, 28 Mar 2006 11:46:55 -0800
Message-ID: <20060328114655.05e1933f.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:16276 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751307AbWC1Too (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 28 Mar 2006 14:44:44 -0500
Received: from midway.site ([71.111.157.99]) by xenotime.net for <linux-acpi@vger.kernel.org>; Tue, 28 Mar 2006 11:44:40 -0800
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, linux-acpi@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Spell CONFIG option correctly so that externs work.
Fixes these warnings:
drivers/acpi/acpi_memhotplug.c:248: warning: implicit declaration of function 'add_memory'
drivers/acpi/acpi_memhotplug.c:312: warning: implicit declaration of function 'remove_memory'

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 linsrc/linux-2616-mm2/include/linux/memory_hotplug.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- rddunlap.orig/linsrc/linux-2616-mm2/include/linux/memory_hotplug.h
+++ rddunlap/linsrc/linux-2616-mm2/include/linux/memory_hotplug.h
@@ -105,7 +105,7 @@ static inline int __remove_pages(struct 
 }
 
 #if defined(CONFIG_MEMORY_HOTPLUG) || defined(CONFIG_ACPI_HOTPLUG_MEMORY) \
-	|| defined(CONFIG_ACPI_MEMORY_HOTPLUG_MODULE)
+	|| defined(CONFIG_ACPI_HOTPLUG_MEMORY_MODULE)
 extern int add_memory(u64 start, u64 size);
 extern int remove_memory(u64 start, u64 size);
 #endif


---
