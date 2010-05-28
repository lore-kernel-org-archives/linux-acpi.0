From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: [PATCH 1/4] ACPICA: Fix leak in DeleteSemaphore
Date: Fri, 28 May 2010 17:56:49 +0400
Message-ID: <20100528135648.26498.61828.stgit@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nat.nue.novell.com ([195.135.221.3]:35754 "EHLO
	nat.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757260Ab0E1N4v (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Fri, 28 May 2010 09:56:51 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Robert Moore <robert.moore@intel.com>
Cc: Linux-acpi@vger.kernel.org, devel@acpica.org

Really delete semaphore, so it does not show up as leak in memory debuggers.

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 0 files changed, 0 insertions(+), 0 deletions(-)


diff --git a/source/os_specific/service_layers/osunixxf.c b/source/os_specific/service_layers/osunixxf.c
index b457745..e90e22a 100644
--- a/source/os_specific/service_layers/osunixxf.c
+++ b/source/os_specific/service_layers/osunixxf.c
@@ -575,6 +575,8 @@ AcpiOsDeleteSemaphore (
         return (AE_BAD_PARAMETER);
     }
 
+    AcpiOsFree (Sem);
+
     return (AE_OK);
 }
 

