From: Len Brown <lenb@kernel.org>
Subject: [PATCH 14/23] ACPI: EC: Limit workaround for ASUS notebooks even more
Date: Fri, 16 Jan 2009 15:25:03 -0500
Message-ID: <235c4a59278eb07e61d909f1f0c233733034a8b3.1232137452.git.len.brown@intel.com>
References: <1232137512-17327-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:62939 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758656AbZAPUZV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Jan 2009 15:25:21 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KDK00JKCZE7MJY4@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 16 Jan 2009 14:25:20 -0600 (CST)
In-reply-to: <1232137512-17327-1-git-send-email-lenb@kernel.org>
In-reply-to: <9abf0eea877d6107d3a8a5c6913450e961fb7050.1232137452.git.len.brown@intel.com>
References: <9abf0eea877d6107d3a8a5c6913450e961fb7050.1232137452.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <astarikovskiy@suse.de>

References: http://bugzilla.kernel.org/show_bug.cgi?id=11884

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/ec.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 8dfcbb8..e079426 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1027,7 +1027,8 @@ int __init acpi_ec_ecdt_probe(void)
 	 * which needs it, has fake EC._INI method, so use it as flag.
 	 * Keep boot_ec struct as it will be needed soon.
 	 */
-	if (ACPI_FAILURE(acpi_get_handle(boot_ec->handle, "_INI", &dummy)))
+	if (!dmi_name_in_vendors("ASUS") ||
+	    ACPI_FAILURE(acpi_get_handle(boot_ec->handle, "_INI", &dummy)))
 		return -ENODEV;
 install:
 	if (!ec_install_handlers(boot_ec)) {
-- 
1.5.6.6

