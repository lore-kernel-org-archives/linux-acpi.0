From: Toshi Kani <toshi.kani@hpe.com>
Subject: [PATCH v3 1/5] ACPI / blacklist: add acpi_match_platform_list()
Date: Fri, 18 Aug 2017 13:46:40 -0600
Message-ID: <20170818194644.14538-2-toshi.kani@hpe.com>
References: <20170818194644.14538-1-toshi.kani@hpe.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170818194644.14538-1-toshi.kani@hpe.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, bp@alien8.de
Cc: mchehab@kernel.org, tony.luck@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org, Toshi Kani <toshi.kani@hpe.com>
List-Id: linux-acpi@vger.kernel.org

ACPI OEM ID / OEM Table ID / Revision can be used to identify
a platform based on ACPI firmware info.  acpi_blacklisted(),
intel_pstate_platform_pwr_mgmt_exists(), and some other funcs,
have been using similar check to detect a list of platforms
that require special handlings.

Move the platform check in acpi_blacklisted() to a new common
utility function, acpi_match_platform_list(), so that other
drivers do not have to implement their own version.

There is no change in functionality.

Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Borislav Petkov <bp@alien8.de>
---
 drivers/acpi/blacklist.c |   83 ++++++++--------------------------------------
 drivers/acpi/utils.c     |   40 ++++++++++++++++++++++
 include/linux/acpi.h     |   19 +++++++++++
 3 files changed, 73 insertions(+), 69 deletions(-)

diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
index bb542ac..037fd53 100644
--- a/drivers/acpi/blacklist.c
+++ b/drivers/acpi/blacklist.c
@@ -30,30 +30,13 @@
 
 #include "internal.h"
 
-enum acpi_blacklist_predicates {
-	all_versions,
-	less_than_or_equal,
-	equal,
-	greater_than_or_equal,
-};
-
-struct acpi_blacklist_item {
-	char oem_id[7];
-	char oem_table_id[9];
-	u32 oem_revision;
-	char *table;
-	enum acpi_blacklist_predicates oem_revision_predicate;
-	char *reason;
-	u32 is_critical_error;
-};
-
 static struct dmi_system_id acpi_rev_dmi_table[] __initdata;
 
 /*
  * POLICY: If *anything* doesn't work, put it on the blacklist.
  *	   If they are critical errors, mark it critical, and abort driver load.
  */
-static struct acpi_blacklist_item acpi_blacklist[] __initdata = {
+static struct acpi_platform_list acpi_blacklist[] __initdata = {
 	/* Compaq Presario 1700 */
 	{"PTLTD ", "  DSDT  ", 0x06040000, ACPI_SIG_DSDT, less_than_or_equal,
 	 "Multiple problems", 1},
@@ -67,65 +50,27 @@ static struct acpi_blacklist_item acpi_blacklist[] __initdata = {
 	{"IBM   ", "TP600E  ", 0x00000105, ACPI_SIG_DSDT, less_than_or_equal,
 	 "Incorrect _ADR", 1},
 
-	{""}
+	{ }
 };
 
 int __init acpi_blacklisted(void)
 {
-	int i = 0;
+	int i;
 	int blacklisted = 0;
-	struct acpi_table_header table_header;
-
-	while (acpi_blacklist[i].oem_id[0] != '\0') {
-		if (acpi_get_table_header(acpi_blacklist[i].table, 0, &table_header)) {
-			i++;
-			continue;
-		}
-
-		if (strncmp(acpi_blacklist[i].oem_id, table_header.oem_id, 6)) {
-			i++;
-			continue;
-		}
-
-		if (strncmp
-		    (acpi_blacklist[i].oem_table_id, table_header.oem_table_id,
-		     8)) {
-			i++;
-			continue;
-		}
-
-		if ((acpi_blacklist[i].oem_revision_predicate == all_versions)
-		    || (acpi_blacklist[i].oem_revision_predicate ==
-			less_than_or_equal
-			&& table_header.oem_revision <=
-			acpi_blacklist[i].oem_revision)
-		    || (acpi_blacklist[i].oem_revision_predicate ==
-			greater_than_or_equal
-			&& table_header.oem_revision >=
-			acpi_blacklist[i].oem_revision)
-		    || (acpi_blacklist[i].oem_revision_predicate == equal
-			&& table_header.oem_revision ==
-			acpi_blacklist[i].oem_revision)) {
 
-			printk(KERN_ERR PREFIX
-			       "Vendor \"%6.6s\" System \"%8.8s\" "
-			       "Revision 0x%x has a known ACPI BIOS problem.\n",
-			       acpi_blacklist[i].oem_id,
-			       acpi_blacklist[i].oem_table_id,
-			       acpi_blacklist[i].oem_revision);
+	i = acpi_match_platform_list(acpi_blacklist);
+	if (i >= 0) {
+		pr_err(PREFIX "Vendor \"%6.6s\" System \"%8.8s\" Revision 0x%x has a known ACPI BIOS problem.\n",
+		       acpi_blacklist[i].oem_id,
+		       acpi_blacklist[i].oem_table_id,
+		       acpi_blacklist[i].oem_revision);
 
-			printk(KERN_ERR PREFIX
-			       "Reason: %s. This is a %s error\n",
-			       acpi_blacklist[i].reason,
-			       (acpi_blacklist[i].
-				is_critical_error ? "non-recoverable" :
-				"recoverable"));
+		pr_err(PREFIX "Reason: %s. This is a %s error\n",
+		       acpi_blacklist[i].reason,
+		       (acpi_blacklist[i].data ?
+			"non-recoverable" : "recoverable"));
 
-			blacklisted = acpi_blacklist[i].is_critical_error;
-			break;
-		} else {
-			i++;
-		}
+		blacklisted = acpi_blacklist[i].data;
 	}
 
 	(void)early_acpi_osi_init();
diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index b9d956c..998aaf5 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -816,3 +816,43 @@ static int __init acpi_backlight(char *str)
 	return 1;
 }
 __setup("acpi_backlight=", acpi_backlight);
+
+/**
+ * acpi_match_platform_list - Check if the system matches with a given list
+ * @plat: pointer to acpi_platform_list table terminated by a NULL entry
+ *
+ * Return the matched index if the system is found in the platform list.
+ * Otherwise, return a negative error code.
+ */
+int acpi_match_platform_list(const struct acpi_platform_list *plat)
+{
+	struct acpi_table_header hdr;
+	int idx = 0;
+
+	if (acpi_disabled)
+		return -ENODEV;
+
+	for (; plat->oem_id[0]; plat++, idx++) {
+		if (ACPI_FAILURE(acpi_get_table_header(plat->table, 0, &hdr)))
+			continue;
+
+		if (strncmp(plat->oem_id, hdr.oem_id, ACPI_OEM_ID_SIZE))
+			continue;
+
+		if (strncmp(plat->oem_table_id, hdr.oem_table_id,
+			    ACPI_OEM_TABLE_ID_SIZE))
+			continue;
+
+		if ((plat->pred == all_versions) ||
+		    (plat->pred == less_than_or_equal
+			&& hdr.oem_revision <= plat->oem_revision) ||
+		    (plat->pred == greater_than_or_equal
+			&& hdr.oem_revision >= plat->oem_revision) ||
+		    (plat->pred == equal
+			&& hdr.oem_revision == plat->oem_revision))
+			return idx;
+	}
+
+	return -ENODEV;
+}
+EXPORT_SYMBOL(acpi_match_platform_list);
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 27b4b66..a9b6dc2 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -556,6 +556,25 @@ extern acpi_status acpi_pci_osc_control_set(acpi_handle handle,
 #define ACPI_OST_SC_DRIVER_LOAD_FAILURE		0x81
 #define ACPI_OST_SC_INSERT_NOT_SUPPORTED	0x82
 
+enum acpi_predicate {
+	all_versions,
+	less_than_or_equal,
+	equal,
+	greater_than_or_equal,
+};
+
+/* Table must be terminted by a NULL entry */
+struct acpi_platform_list {
+	char	oem_id[ACPI_OEM_ID_SIZE];
+	char	oem_table_id[ACPI_OEM_TABLE_ID_SIZE];
+	u32	oem_revision;
+	char	*table;
+	enum acpi_predicate pred;
+	char	*reason;
+	u32	data;
+};
+int acpi_match_platform_list(const struct acpi_platform_list *plat);
+
 extern void acpi_early_init(void);
 extern void acpi_subsystem_init(void);
 
