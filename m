From: akpm@linux-foundation.org
Subject: [patch 3/6] git-acpi: export acpi_set_cstate_limit
Date: Wed, 23 May 2007 14:12:27 -0700
Message-ID: <200705232112.l4NLCR85032151@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([207.189.120.13]:59283 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754268AbXEWV2b (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 23 May 2007 17:28:31 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org

From: Andrew Morton <akpm@linux-foundation.org>

ipw2100 uses this.

Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/acpi/osl.c |    1 +
 1 files changed, 1 insertion(+)

diff -puN drivers/acpi/osl.c~git-acpi-export-acpi_set_cstate_limit drivers/acpi/osl.c
--- a/drivers/acpi/osl.c~git-acpi-export-acpi_set_cstate_limit
+++ a/drivers/acpi/osl.c
@@ -1033,6 +1033,7 @@ acpi_cpu_flags acpi_os_acquire_lock(acpi
 	spin_lock_irqsave(lockp, flags);
 	return flags;
 }
+EXPORT_SYMBOL(acpi_set_cstate_limit);
 
 /*
  * Release a spinlock. See above.
_
