From: liguang <lig.fnst@cn.fujitsu.com>
Subject: [PATCH RFC 2/3] ec: add ec space notifier
Date: Thu, 6 Jun 2013 09:32:15 +0800
Message-ID: <1370482336-636-3-git-send-email-lig.fnst@cn.fujitsu.com>
References: <1370482336-636-1-git-send-email-lig.fnst@cn.fujitsu.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1370482336-636-1-git-send-email-lig.fnst@cn.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Matthew Garrett <matthew.garrett@nebula.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, liguang <lig.fnst@cn.fujitsu.com>
List-Id: linux-acpi@vger.kernel.org

add a notifier for anyone who are instresting in
ec space changing.

Signed-off-by: liguang <lig.fnst@cn.fujitsu.com>
---
 drivers/acpi/ec.c    |   32 ++++++++++++++++++++++++++++++++
 include/linux/acpi.h |    2 ++
 2 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index edc0081..dee3417 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -124,6 +124,35 @@ static int EC_FLAGS_MSI; /* Out-of-spec MSI controller */
 static int EC_FLAGS_VALIDATE_ECDT; /* ASUStec ECDTs need to be validated */
 static int EC_FLAGS_SKIP_DSDT_SCAN; /* Not all BIOS survive early DSDT scan */
 
+/* notifier chain for who are intresting in ec space changing */
+static RAW_NOTIFIER_HEAD(ec_space_chain);
+
+int __ref register_ec_space_notifier(struct notifier_block *nb)
+{
+        int ret;
+
+        ret = raw_notifier_chain_register(&ec_space_chain, nb);
+
+        return ret;
+}
+EXPORT_SYMBOL(register_ec_space_notifier);
+
+void __ref unregister_ec_space_notifier(struct notifier_block *nb)
+{
+
+        raw_notifier_chain_unregister(&ec_space_chain, nb);
+}
+EXPORT_SYMBOL(unregister_ec_space_notifier);
+
+static int ec_space_notify(void *data)
+{
+    int ret;
+
+    ret = __raw_notifier_call_chain(&ec_space_chain, 0, data, -1, NULL);
+
+     return notifier_to_errno(ret);
+}
+
 /* --------------------------------------------------------------------------
                              Transaction Management
    -------------------------------------------------------------------------- */
@@ -638,6 +667,9 @@ static u32 acpi_ec_gpe_handler(acpi_handle gpe_device,
 		wake_up(&ec->wait);
 		ec_check_sci(ec, acpi_ec_read_status(ec));
 	}
+
+	ec_space_notify(data);
+
 	return ACPI_INTERRUPT_HANDLED | ACPI_REENABLE_GPE;
 }
 
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 17b5b59..4fe2247 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -158,6 +158,8 @@ extern int ec_transaction(u8 command,
                           const u8 *wdata, unsigned wdata_len,
                           u8 *rdata, unsigned rdata_len);
 extern acpi_handle ec_get_handle(void);
+extern int register_ec_space_notifier(struct notifier_block *nb);
+extern void unregister_ec_space_notifier(struct notifier_block *nb);
 
 #if defined(CONFIG_ACPI_WMI) || defined(CONFIG_ACPI_WMI_MODULE)
 
-- 
1.7.2.5
