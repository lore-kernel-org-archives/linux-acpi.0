From: akpm@linux-foundation.org
Subject: [patch 3/4] sbshc: acpi_device_class "smbus_host_controller" too long
Date: Tue, 27 Apr 2010 14:06:05 -0700
Message-ID: <201004272106.o3RL65Iq019661@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:34911 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751614Ab0D0VGK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 27 Apr 2010 17:06:10 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, error27@gmail.com, astarikovskiy@suse.de

From: Dan Carpenter <error27@gmail.com>

acpi_device_class can only be 19 characters and a NULL terminator.

With the current name we get a buffer overflow in acpi_smbus_hc_add()
when we do:
	strcpy(acpi_device_class(device), ACPI_SMB_HC_CLASS);

Signed-off-by: Dan Carpenter <error27@gmail.com>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/acpi/sbshc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/acpi/sbshc.c~sbshc-acpi_device_class-smbus_host_controller-too-long drivers/acpi/sbshc.c
--- a/drivers/acpi/sbshc.c~sbshc-acpi_device_class-smbus_host_controller-too-long
+++ a/drivers/acpi/sbshc.c
@@ -18,7 +18,7 @@
 
 #define PREFIX "ACPI: "
 
-#define ACPI_SMB_HC_CLASS	"smbus_host_controller"
+#define ACPI_SMB_HC_CLASS	"smbus_host_ctl"
 #define ACPI_SMB_HC_DEVICE_NAME	"ACPI SMBus HC"
 
 struct acpi_smb_hc {
_
