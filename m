From: Len Brown <lenb@kernel.org>
Subject: [PATCH 8/9] sbshc: acpi_device_class "smbus_host_controller" too long
Date: Thu, 06 May 2010 03:03:20 -0400
Message-ID: <97c227cb51ddcf52c66f7a7fba69237026418b56.1273129319.git.len.brown@intel.com>
References: <1273129401-12704-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:38866 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752246Ab0EFHDj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 May 2010 03:03:39 -0400
Received: from localhost.localdomain ([unknown] [98.118.125.200])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L1Z00HDMKXROW33@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 06 May 2010 02:03:33 -0500 (CDT)
In-reply-to: <1273129401-12704-1-git-send-email-lenb@kernel.org>
In-reply-to: <5cc4a0f6b72878ea4e96fdb392d5d24c892a988e.1273129319.git.len.brown@intel.com>
References: <5cc4a0f6b72878ea4e96fdb392d5d24c892a988e.1273129319.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Dan Carpenter <error27@gmail.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

From: Dan Carpenter <error27@gmail.com>

acpi_device_class can only be 19 characters and a NULL terminator.

With the current name we get a buffer overflow in acpi_smbus_hc_add()
when we do:
	strcpy(acpi_device_class(device), ACPI_SMB_HC_CLASS);

Signed-off-by: Dan Carpenter <error27@gmail.com>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/sbshc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/sbshc.c b/drivers/acpi/sbshc.c
index 36704b8..f8be23b 100644
--- a/drivers/acpi/sbshc.c
+++ b/drivers/acpi/sbshc.c
@@ -18,7 +18,7 @@
 
 #define PREFIX "ACPI: "
 
-#define ACPI_SMB_HC_CLASS	"smbus_host_controller"
+#define ACPI_SMB_HC_CLASS	"smbus_host_ctl"
 #define ACPI_SMB_HC_DEVICE_NAME	"ACPI SMBus HC"
 
 struct acpi_smb_hc {
-- 
1.6.0.6

