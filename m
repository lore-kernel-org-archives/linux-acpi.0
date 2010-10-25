From: Len Brown <lenb@kernel.org>
Subject: [PATCH 29/60] ACPICA: Comment update; no functional change
Date: Mon, 25 Oct 2010 02:20:37 -0400
Message-ID: <3989170f8e3c1bd71d8f7ec6e3d52e46815ee096.1287987547.git.len.brown@intel.com>
References: <1287987668-17584-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:38306 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751617Ab0JYJLB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Oct 2010 05:11:01 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LAU004W59ICTPC0@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 25 Oct 2010 04:11:01 -0500 (CDT)
In-reply-to: <1287987668-17584-1-git-send-email-lenb@kernel.org>
In-reply-to: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
References: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Add a usage note to InstallAddressSpaceHandler.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/evxfregn.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/acpica/evxfregn.c b/drivers/acpi/acpica/evxfregn.c
index 541cbc1..ce9314f 100644
--- a/drivers/acpi/acpica/evxfregn.c
+++ b/drivers/acpi/acpica/evxfregn.c
@@ -64,6 +64,12 @@ ACPI_MODULE_NAME("evxfregn")
  *
  * DESCRIPTION: Install a handler for all op_regions of a given space_id.
  *
+ * NOTE: This function should only be called after acpi_enable_subsystem has
+ * been called. This is because any _REG methods associated with the Space ID
+ * are executed here, and these methods can only be safely executed after
+ * the default handlers have been installed and the hardware has been
+ * initialized (via acpi_enable_subsystem.)
+ *
  ******************************************************************************/
 acpi_status
 acpi_install_address_space_handler(acpi_handle device,
-- 
1.7.3.2.90.gd4c43

