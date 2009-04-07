From: Len Brown <lenb@kernel.org>
Subject: [PATCH 06/17] ACPI battery: fix async boot oops
Date: Tue, 07 Apr 2009 19:04:14 -0400
Message-ID: <5d38258ec026921a7b266f4047ebeaa75db358e5.1239145401.git.len.brown@intel.com>
References: <1239145465-5486-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:55494 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753491AbZDGXEt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Apr 2009 19:04:49 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KHR001PC6RLLS17@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 07 Apr 2009 18:04:36 -0500 (CDT)
In-reply-to: <1239145465-5486-1-git-send-email-lenb@kernel.org>
In-reply-to: <9090589d87506c578ea1523ffd7ae7fd9424fb28.1239145401.git.len.brown@intel.com>
References: <9090589d87506c578ea1523ffd7ae7fd9424fb28.1239145401.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Vegard Nossum <vegard.nossum@gmail.com>, Len Brown <len.brown@intel.com>

From: Vegard Nossum <vegard.nossum@gmail.com>

> BUG: unable to handle kernel NULL pointer dereference at (null)

What happens is that the battery module's init sections are being freed
before the async callback (which was marked __init) has run. This theory
is supported by the fact that the bad RIP value is a vmalloc address.

The immediate fix is to make this a non-init call.

(A better long-term fix is of course to wait with init-section unloading
until a module's async initcalls have been run, which would allow us to
discard this function which is still only run once, after all. Perhaps a
new async_initcall() function for the async/module API, if this is needed
for other modules in the future?)

Reported-by: Arkadiusz Miskiewicz <a.miskiewicz@gmail.com>
Signed-off-by: Vegard Nossum <vegard.nossum@gmail.com>
Tested-by: Alessandro Suardi <alessandro.suardi@gmail.com>
Tested-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/battery.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index b0de631..3c7d894 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -903,7 +903,7 @@ static struct acpi_driver acpi_battery_driver = {
 		},
 };
 
-static void __init acpi_battery_init_async(void *unused, async_cookie_t cookie)
+static void acpi_battery_init_async(void *unused, async_cookie_t cookie)
 {
 	if (acpi_disabled)
 		return;
-- 
1.6.0.6

