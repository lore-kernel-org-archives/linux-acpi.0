From: Seth Forshee <seth.forshee@canonical.com>
Subject: [PATCH 1/4] ACPI: EC: Add ec_get_handle()
Date: Thu, 15 Dec 2011 12:06:08 -0600
Message-ID: <1323972371-13189-2-git-send-email-seth.forshee@canonical.com>
References: <1323972371-13189-1-git-send-email-seth.forshee@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1323972371-13189-1-git-send-email-seth.forshee@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>, Len Brown <lenb@kernel.org>
Cc: Azael Avalos <coproscefalo@gmail.com>, platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Seth Forshee <seth.forshee@canonical.com>
List-Id: linux-acpi@vger.kernel.org

toshiba_acpi needs to execute an AML method within the EC namespace
to make hotkeys work on some platforms. Provide an interface to
allow it to easily get a handle to the EC namespace for this purpose.

Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
---
 drivers/acpi/ec.c    |   10 ++++++++++
 include/linux/acpi.h |    1 +
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index b19a18d..e37615f 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -445,6 +445,16 @@ int ec_transaction(u8 command,
 
 EXPORT_SYMBOL(ec_transaction);
 
+/* Get the handle to the EC device */
+acpi_handle ec_get_handle(void)
+{
+	if (!first_ec)
+		return NULL;
+	return first_ec->handle;
+}
+
+EXPORT_SYMBOL(ec_get_handle);
+
 void acpi_ec_block_transactions(void)
 {
 	struct acpi_ec *ec = first_ec;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 6001b4da..ecccbb7 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -151,6 +151,7 @@ extern int ec_write(u8 addr, u8 val);
 extern int ec_transaction(u8 command,
                           const u8 *wdata, unsigned wdata_len,
                           u8 *rdata, unsigned rdata_len);
+extern acpi_handle ec_get_handle(void);
 
 #if defined(CONFIG_ACPI_WMI) || defined(CONFIG_ACPI_WMI_MODULE)
 
-- 
1.7.5.4
