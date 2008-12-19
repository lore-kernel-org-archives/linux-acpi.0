From: Len Brown <lenb@kernel.org>
Subject: [PATCH/RFC] ACPICA: disable ACPI 2.0 _GTS/_BFS support
Date: Fri, 19 Dec 2008 04:23:49 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0812190421140.1988@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:49279 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752684AbYLSJYC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Dec 2008 04:24:02 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173007.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KC400CZTA1NBCL1@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 19 Dec 2008 03:22:40 -0600 (CST)
Received: from localhost.localdomain (d975xbx2 [127.0.0.1])
	by localhost.localdomain (8.14.2/8.14.2) with ESMTP id mBJ9NngJ002007	for
 <linux-acpi@vger.kernel.org>; Fri, 19 Dec 2008 04:23:50 -0500
Received: from localhost (lenb@localhost)
	by localhost.localdomain (8.14.2/8.14.2/Submit) with ESMTP id mBJ9NnLX002003
	for <linux-acpi@vger.kernel.org>; Fri, 19 Dec 2008 04:23:49 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

From: Len Brown <len.brown@intel.com>
Organization: Intel Open Source Technology Center

ACPI 2.0 defined two new methods in the suspend/resume sequence,
_GTS (Going to Sleep) and _BFS (Back from Sleep)

They are optional methods, but if the BIOS supplies them,
the OS is supposed to evaluate them immediately before
writing the register to sleep, and immediately after waking up --
a time when interrupts are disabled.

The spec says that they must be self-contained
methods, not calling any other methods, perhaps
because that they are run under unique conditions?

These methodds are evaluated in Linux by
acpi_evaluate_object(), which always kmalloc's
a return structure to conserve stack space.
But kmalloc with interrupts off is problematic --
do we really want to insist on GFP_ATOMIC here?

Now, several years after ACPI 2.0 was released,
we have yet to observe a single implementation of
_GTS/_BFS in the field -- suggesting that they will
never actually be deployed.

So lets keep Linux simple by removing this
theoretical support for _GTS/_BFS, the only
AML methods that mandated being evaluated
with interrupts disabled.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/hardware/hwsleep.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/hardware/hwsleep.c b/drivers/acpi/hardware/hwsleep.c
index 25dccdf..c209434 100644
--- a/drivers/acpi/hardware/hwsleep.c
+++ b/drivers/acpi/hardware/hwsleep.c
@@ -289,6 +289,7 @@ acpi_status asmlinkage acpi_enter_sleep_state(u8 sleep_state)
 		return_ACPI_STATUS(status);
 	}
 
+#ifdef	ACPI_20_GTS_BFS
 	/* Execute the _GTS method */
 
 	arg_list.count = 1;
@@ -300,6 +301,7 @@ acpi_status asmlinkage acpi_enter_sleep_state(u8 sleep_state)
 	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
 		return_ACPI_STATUS(status);
 	}
+#endif
 
 	/* Get current value of PM1A control */
 
@@ -535,6 +537,7 @@ acpi_status acpi_leave_sleep_state_prep(u8 sleep_state)
 		}
 	}
 
+#ifdef	ACPI_20_GTS_BFS
 	/* Execute the _BFS method */
 
 	arg_list.count = 1;
@@ -546,6 +549,7 @@ acpi_status acpi_leave_sleep_state_prep(u8 sleep_state)
 	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
 		ACPI_EXCEPTION((AE_INFO, status, "During Method _BFS"));
 	}
+#endif
 
 	return_ACPI_STATUS(status);
 }
-- 
1.6.1.rc3.35.gc0ceb

