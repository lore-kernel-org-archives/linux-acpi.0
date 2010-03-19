From: Dan Carpenter <error27@gmail.com>
Subject: [patch] sbshc: acpi_device_class "smbus_host_controller" too long
Date: Fri, 19 Mar 2010 14:44:11 +0300
Message-ID: <20100319114411.GM5331@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f209.google.com ([209.85.218.209]:41794 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751313Ab0CSLoX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Mar 2010 07:44:23 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

acpi_device_class can only be 19 characters and a NULL terminator.

With the current name we get a buffer overflow in acpi_smbus_hc_add()
when we do: 
	strcpy(acpi_device_class(device), ACPI_SMB_HC_CLASS);

Signed-off-by: Dan Carpenter <error27@gmail.com>

diff --git a/drivers/acpi/sbshc.c b/drivers/acpi/sbshc.c
index fd09229..1fbf073 100644
--- a/drivers/acpi/sbshc.c
+++ b/drivers/acpi/sbshc.c
@@ -17,7 +17,7 @@
 
 #define PREFIX "ACPI: "
 
-#define ACPI_SMB_HC_CLASS	"smbus_host_controller"
+#define ACPI_SMB_HC_CLASS	"smbus_host_ctl"
 #define ACPI_SMB_HC_DEVICE_NAME	"ACPI SMBus HC"
 
 struct acpi_smb_hc {
