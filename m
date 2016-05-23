From: Borislav Petkov <bp@alien8.de>
Subject: [PATCH 2/2] acpi/einj: Make error paths more talkative
Date: Mon, 23 May 2016 10:28:04 +0200
Message-ID: <1463992084-10012-2-git-send-email-bp@alien8.de>
References: <1463992084-10012-1-git-send-email-bp@alien8.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:35816 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753126AbcEWI2K (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 May 2016 04:28:10 -0400
In-Reply-To: <1463992084-10012-1-git-send-email-bp@alien8.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Tony Luck <tony.luck@intel.com>

From: Borislav Petkov <bp@suse.de>

It is absolutely unfriendly when one sees this:

  # modprobe einj
  modprobe: ERROR: could not insert 'einj': No such device

without anything in dmesg to tell one why the load failed.

Beef up the error handling of the init function to be more user-friendly
when the load fails.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 drivers/acpi/apei/einj.c | 36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index 4ba41855799f..eebb7e39c49c 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -692,34 +692,42 @@ static int __init einj_init(void)
 	struct dentry *fentry;
 	struct apei_exec_context ctx;
 
-	if (acpi_disabled)
+	if (acpi_disabled) {
+		pr_warn("ACPI disabled.\n");
 		return -ENODEV;
+	}
 
 	status = acpi_get_table(ACPI_SIG_EINJ, 0,
 				(struct acpi_table_header **)&einj_tab);
-	if (status == AE_NOT_FOUND)
+	if (status == AE_NOT_FOUND) {
+		pr_warn("EINJ table not found.\n");
 		return -ENODEV;
+	}
 	else if (ACPI_FAILURE(status)) {
-		const char *msg = acpi_format_exception(status);
-		pr_err("Failed to get table, %s\n", msg);
+		pr_err("Failed to get EINJ table: %s\n",
+				acpi_format_exception(status));
 		return -EINVAL;
 	}
 
 	rc = einj_check_table(einj_tab);
 	if (rc) {
-		pr_warning(FW_BUG "EINJ table is invalid\n");
+		pr_warn(FW_BUG "Invalid EINJ table.n");
 		return -EINVAL;
 	}
 
 	rc = -ENOMEM;
 	einj_debug_dir = debugfs_create_dir("einj", apei_get_debugfs_dir());
-	if (!einj_debug_dir)
+	if (!einj_debug_dir) {
+		pr_err("Error creating debugfs node.\n");
 		goto err_cleanup;
+	}
+
 	fentry = debugfs_create_file("available_error_type", S_IRUSR,
 				     einj_debug_dir, NULL,
 				     &available_error_type_fops);
 	if (!fentry)
 		goto err_cleanup;
+
 	fentry = debugfs_create_file("error_type", S_IRUSR | S_IWUSR,
 				     einj_debug_dir, NULL, &error_type_fops);
 	if (!fentry)
@@ -732,14 +740,22 @@ static int __init einj_init(void)
 	apei_resources_init(&einj_resources);
 	einj_exec_ctx_init(&ctx);
 	rc = apei_exec_collect_resources(&ctx, &einj_resources);
-	if (rc)
+	if (rc) {
+		pr_err("Error collecting EINJ resources.\n");
 		goto err_fini;
+	}
+
 	rc = apei_resources_request(&einj_resources, "APEI EINJ");
-	if (rc)
+	if (rc) {
+		pr_err("Error requesting memory/port resources.\n");
 		goto err_fini;
+	}
+
 	rc = apei_exec_pre_map_gars(&ctx);
-	if (rc)
+	if (rc) {
+		pr_err("Error pre-mapping GARs.\n");
 		goto err_release;
+	}
 
 	rc = -ENOMEM;
 	einj_param = einj_get_parameter_address();
@@ -795,6 +811,7 @@ err_unmap:
 			sizeof(struct einj_parameter);
 
 		acpi_os_unmap_iomem(einj_param, size);
+		pr_err("Error creating param extension debugfs nodes.\n");
 	}
 	apei_exec_post_unmap_gars(&ctx);
 err_release:
@@ -802,6 +819,7 @@ err_release:
 err_fini:
 	apei_resources_fini(&einj_resources);
 err_cleanup:
+	pr_err("Error creating primary debugfs nodes.\n");
 	debugfs_remove_recursive(einj_debug_dir);
 
 	return rc;
-- 
2.7.3

