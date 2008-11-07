From: Len Brown <lenb@kernel.org>
Subject: [PATCH 04/10] ACPI: 80 column adherence and spelling fix (no
 functional change)
Date: Thu, 06 Nov 2008 23:45:26 -0500
Message-ID: <5b53ed69158eeff115004f246193d07a083445f6.1226032943.git.len.brown@intel.com>
References: <1226033132-16034-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:42489 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751112AbYKGEpe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Nov 2008 23:45:34 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173007.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K9Y00KR656E62Z1@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 06 Nov 2008 22:44:39 -0600 (CST)
In-reply-to: <1226033132-16034-1-git-send-email-lenb@kernel.org>
In-reply-to: <007e7d616a5d1c2e16ad627d03f8b97799445e71.1226032943.git.len.brown@intel.com>
References: <007e7d616a5d1c2e16ad627d03f8b97799445e71.1226032943.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Myron Stowe <myron.stowe@hp.com>, Len Brown <len.brown@intel.com>

From: Myron Stowe <myron.stowe@hp.com>

Signed-off-by: Myron Stowe <myron.stowe@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_core.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index bc332fc..b57b1f0 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -595,9 +595,10 @@ static int acpi_processor_get_info(struct acpi_device *device)
 		}
 
 		/*
-		* TBD: Synch processor ID (via LAPIC/LSAPIC structures) on SMP.
-		*      >>> 'acpi_get_processor_id(acpi_id, &id)' in arch/xxx/acpi.c
-		*/
+		 * TBD: Synch processor ID (via LAPIC/LSAPIC structures) on SMP.
+		 *      >>> 'acpi_get_processor_id(acpi_id, &id)' in
+		 *      arch/xxx/acpi.c
+		 */
 		pr->acpi_id = object.processor.proc_id;
 	}
 	cpu_index = get_cpu_id(pr->handle, device_declaration, pr->acpi_id);
-- 
1.5.6.5

