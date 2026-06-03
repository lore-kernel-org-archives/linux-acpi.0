Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010035.outbound.protection.outlook.com [52.101.85.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9EC30EF86;
	Wed,  3 Jun 2026 06:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780468458; cv=fail; b=OdxbvV3lauwp2F4pJEWmt/1kGpWiS7cAjIcjMJvxT0WasYV05PauLNd2I7Oq3Huj90bEyadUrCtCDap48IJaqbFx3X5MoXaRPko74l66c+rGyfKmCngzDVroh+loVDrdrsee3ZLhgfGbdAPZU0OuvLYR3hiB451W3hrWTEVziXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780468458; c=relaxed/simple;
	bh=jmh0wgsF16SIqJ9KqYbKwLi1z6CU4hj+SNnnPx4JN94=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XXVlQAIsfKbZE99NArT8VpIZ8L0jm2tBU9G+mxcxxNzewFzHk8qxI+5U3lDxk/MEvyfysfI0HzXGy/ykgcwUFWqyrOeTwLBv0gnE+kCsEZqSXgm/prIJoXyep0Y+0zfVRkTQyCytHqX86BmLYnIxZlbK0pCDmG7z+1a+IAmNjSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pREW8Juu; arc=fail smtp.client-ip=52.101.85.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pREW8Juu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z11JEri/R1VZWthlShOLjMHqcBFHVJBj/EckBuG7FqgUfg8HXDeKPAqxUH6v23evCywbbrZr3gVcAFMz1jQqXnWhqDCAhlk0V5zYQag+T9pCB8CuqyBt/i6X/H7TmT03ckb4hibfw/mhlUKn/F7BwbVbPUAUUm3BnuZX+93foOwB+mtlqdC/dRlJDQIPKHSgpvXbzHH1oUKzNkly3ii4rRd3gcaqrqnMJDa/Xt45L2v26uxJ4rPNvJ2qX7kHMtyw7qPynureSOeVCCQaBGioU4Log0COeKyRg6k8m0MYpfiIpWIq5LATm1C+8D4ST4Smw5wnQ+3YGgRu7PpytG6FHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1AYHYu3nMeINUmUW1Vkd4kd1kLSfAt0l5wYlEs/eSUM=;
 b=pWCvga4KtVmKF2WOqmBIQBuaeDT8+mZfGuz0mHSJeLN+n85dAkuAt8pIKUFLcL1p8k7nJ9FWANYlLAMAoWpUJko4q/IaKqFWOYvDWq1OvaH1nqGkG49jkVsJRRLq8aZdhYQtAqM3te7MLhtd+I9s4/UD0lsZt0kYFmz5RBRh0Au8nk9C2noHvrAjG36ruaj4YGnK+i2DbWocws1JnrbfRjQHF9VamyQ8eeiaH9pPO9+TT/GHnHmGbCN6H0PHv7LggW1LswdygHowfiZiY2ANRJ0kmJRSicbmABZupK7wUDZhvjU+jcf3m1yIQHjIddca4l2YIfQR5MqZAzOZB4mlhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1AYHYu3nMeINUmUW1Vkd4kd1kLSfAt0l5wYlEs/eSUM=;
 b=pREW8Juu5DeuiTagzsuVQOZWM0VDr3tG4sjlbuDZf1QZtMJWd9BBiHjpkVDtAof1mjKwVkuC+vfIaUSPsBvETvFvqXB6KxC5W74DukTgWZ65ipC0LnycF3+fSVyeDJ0URQiFdvsn1Z3lt74PVnT2Q8frCrueuSSletvZK4E3WWI=
Received: from BLAPR03CA0108.namprd03.prod.outlook.com (2603:10b6:208:32a::23)
 by DS4PR12MB9564.namprd12.prod.outlook.com (2603:10b6:8:27e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 06:34:11 +0000
Received: from MN1PEPF0000ECDB.namprd02.prod.outlook.com
 (2603:10b6:208:32a:cafe::70) by BLAPR03CA0108.outlook.office365.com
 (2603:10b6:208:32a::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 06:34:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECDB.mail.protection.outlook.com (10.167.242.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 06:34:11 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 3 Jun
 2026 01:34:07 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Borislav Petkov <bp@alien8.de>, Mario Limonciello
	<mario.limonciello@amd.com>, Yazen Ghannam <yazen.ghannam@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>
CC: Vilas Sridharan <Vilas.Sridharan@amd.com>, K Prateek Nayak
	<kprateek.nayak@amd.com>
Subject: [RFC PATCH 2/3] ACPI: PHAT: Add generic helper to parse PHAT records
Date: Wed, 3 Jun 2026 06:33:15 +0000
Message-ID: <20260603063317.13665-3-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603063317.13665-1-kprateek.nayak@amd.com>
References: <20260603063317.13665-1-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDB:EE_|DS4PR12MB9564:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b69965a-12f3-4ecc-aa33-08dec13a1f67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016|6133799003|56012099006|11063799006|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	gTjo7qVSEx43PLC2HgwW3lwkeXFu90nuJmXyfBCeF04s5G8VyovwIapYDH8iX3jz2LvDuVdE0toEK1TVA/duUiwijNji40My+ucy6QGmVmLNyfwqrEhx2Tzh7YHb3lwRzA4VRFC6g8f7v94mkdXjiA9nkODDLYMp2/44Y586lIukf+lEp0f7lAqFxXYMtTrHA66IXbKlYoQGjR1b8mHWDPBJhwRMxs74Lx+HA7JZZg4Wq7DP4PKa3n0s4miphmDmiCJYmelQTLjzrNOVz7mvK6K3L8yesXpnG+ZpBO2DLkCuGyneWD5udKrGGzt3W4Agkw4yq4ZqK6u4/I5/8rP1FI3JLtLnut2sZzrIocFv0ZOWa42wZ/Nxc5VwGno58bTJvQ2KdkISUufT5ILje16kVOtvdRlnr4KvJ2VgdaUrw2sneto8N915iOVWaLvA/SUCJqaHVyffhlq+59mw89LzhBGXktEmomBM4LdlgFptf/75htFoopS6b/YBwdp+J9wk9oOykLROw4NZhe0/SslL5naGPp3Jm+8PEUW3HfrBipMU8KSLzLpwPdJIbEnFd9NZ6UVYRVsfS1JB1+AJs18AKBPZ7FfiDkJME/EhFBHgTMXyLdw6+snRKihu5G/qC52pedCPhrgEHnQ0ZxiK9ydlxvpjiDkUfT2GgatcHw8QgScqR4HJKQYYyQPJMF/m4pKF
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(6133799003)(56012099006)(11063799006)(22082099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	HogE8WAUwnSQ9Tc3T89bKgIRd2ZdHpcE8rUOuCJkS0QJghWKWIMWJimeUHt1c7fMVBCQTHYy8ZDGZMRQiTUbPtonBavActAhIvMhZ4sBttscA6kiQkHvD6fgCn8F56RmYE8HSHBCUOlfoF8fBPKRF2o/jRrN1PC2z0zrjFAdfOxfvEzUQddz5qR7OuYQMPDHOXknHu8rAxALUgFi4gXJFOd37OAZgp8rI1NWTc712Ppf+uEhTIOVol+mIwetM2iWad29hpo+93KxE1sQ7F5Vmx2xEa7l12kU6JdZoAe+Xer9IxwiFwolUZeCDnfy2+BykA+nRRd4L7j232pLsULR1erpz/+y7IXjIxTRb/Sj1XdJJT9lEgWHmJcMbmjJFQ/A6eCw8hi87Ue+/klHWbH95GnvSLhY3viMuN68apN5N0BNw0oE9PCKghw7cvCqxFD0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 06:34:11.1799
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b69965a-12f3-4ecc-aa33-08dec13a1f67
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECDB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9564

The ACPI Specification v6.5 [1] under Sec. 5.2.31 "Platform Health
Assessment Table (PHAT)" provides a well defined data format for reset
reason records, including the ones that are vendor specific.

Provide a generic helper to locate the vendor specific records and parse
them into a buffer that can be consumed by the users.

The first user for the interface is added in the subsequent commit with
AMD processors using it to parse the s5_RESET_STATUS from PHAT records.

Make the Kconfig depend on ACPI && CPU_SUP_AMD to prevent the need for
unnecessarily compiling in ACPI PHAT support when not needed.

Link: https://uefi.org/sites/default/files/resources/ACPI_Spec_6_5_Aug29.pdf [1]
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 drivers/acpi/Kconfig     |  11 ++++
 drivers/acpi/Makefile    |   1 +
 drivers/acpi/acpi_phat.c | 133 +++++++++++++++++++++++++++++++++++++++
 include/linux/acpi.h     |  14 +++++
 4 files changed, 159 insertions(+)
 create mode 100644 drivers/acpi/acpi_phat.c

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index f165d14cf61a..494c757a62d7 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -607,6 +607,17 @@ config ACPI_PRMT
 	  substantially increase computational overhead related to the
 	  initialization of some server systems.
 
+config ACPI_PHAT
+	bool "ACPI PHAT Record parsing support"
+	depends on X86 && ACPI && CPU_SUP_AMD
+	default y
+	help
+	  The Platform Health Assessment Table (PHAT) allows platforms to
+	  expose read-only data for diagnostics and health assessments.
+
+	  Enable this feature to access generic helpers for parsing PHAT
+	  data records.
+
 endif	# ACPI
 
 config X86_PM_TIMER
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index d1b0affb844f..d6cf252ca4ea 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -108,6 +108,7 @@ obj-$(CONFIG_ACPI_SPCR_TABLE)	+= spcr.o
 obj-$(CONFIG_ACPI_DEBUGGER_USER) += acpi_dbg.o
 obj-$(CONFIG_ACPI_PPTT) 	+= pptt.o
 obj-$(CONFIG_ACPI_PFRUT)	+= pfr_update.o pfr_telemetry.o
+obj-$(CONFIG_ACPI_PHAT) 	+= acpi_phat.o
 
 # processor has its own "processor." module_param namespace
 processor-y			:= processor_driver.o processor_thermal.o
diff --git a/drivers/acpi/acpi_phat.c b/drivers/acpi/acpi_phat.c
new file mode 100644
index 000000000000..de612ae018e0
--- /dev/null
+++ b/drivers/acpi/acpi_phat.c
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Helpers for parsing Platform Health Assessment Table (PHAT) records.
+ */
+#include <linux/kernel.h>
+#include <linux/acpi.h>
+
+#include <acpi/actbl2.h>
+
+/*
+ * __phat_get_firmware_health_data() - Internal helper to locate the
+ * "Reset Reason Health Record" within the Platform Health Assessment
+ * Table (PHAT).
+ *
+ * @table: Pointer to the beginning of PHAT.
+ *
+ * Return: A pointer within the @table if "Reset Reason Health Record"
+ * is found; NULL otherwise.
+ */
+static struct acpi_phat_health_data *
+__phat_get_firmware_health_data(struct acpi_table_phat *table)
+{
+	unsigned int length = table->header.length;
+	void *header = table;
+
+	/* No records. */
+	if (length <= sizeof(struct acpi_table_header))
+		return NULL;
+
+	/*
+	 * Advance to the end of the table header
+	 * where the first record starts.
+	 */
+	header += sizeof(struct acpi_table_header);
+	length -= sizeof(struct acpi_table_header);
+
+	/*
+	 * Search for PHAT firmware health data record header
+	 * with type == ACPI_PHAT_TYPE_FW_HEALTH_DATA.
+	 */
+	while (length) {
+		struct acpi_phat_health_data *data = header;
+
+		if (data->header.type == ACPI_PHAT_TYPE_FW_HEALTH_DATA)
+			return header;
+
+		/* Move to the next header */
+		header += data->header.length;
+		length -= data->header.length;
+	}
+
+	return NULL;
+}
+
+/**
+ * acpi_phat_get_vendor_reset_reason - Find a "Vendor Specific Reset Reason
+ * Entry" with the matching @guid from the "Firmware Health Data Record". If
+ * successfully located, the function will allocate an object of the size
+ * "acpi_phat_vendor_element.length" and return a pointer populated with the
+ * content of the record.
+ *
+ * @guid: The "Vendor Data ID" of the reset reason record.
+ *
+ * Return: A valid pointer to an allocated "acpi_phat_vendor_element" populated
+ * with the data from the record with matching @guid; an ERR_PTR() otherwise if
+ * no matching records were found, or if the element could not be allocated.
+ * If a valid pointer was returned, the user must call
+ * acpi_phat_put_vendor_reset_reason() for the object once done to reclaim the
+ * allocated memory.
+ */
+struct acpi_phat_vendor_element *acpi_phat_get_vendor_reset_reason(guid_t *guid)
+{
+	struct acpi_table_header *phat_tbl __free(acpi_put_table) = NULL;
+	struct acpi_phat_health_data *fw_health_data;
+	struct acpi_phat_device_data *dev_data;
+	acpi_status status;
+	void *data;
+	int i;
+
+	status = acpi_get_table(ACPI_SIG_PHAT, 0, &phat_tbl);
+	if (ACPI_FAILURE(status))
+		return ERR_PTR(-ENODEV);
+
+	fw_health_data =
+		__phat_get_firmware_health_data((struct acpi_table_phat *)phat_tbl);
+	if (!fw_health_data)
+		return ERR_PTR(-ENODEV);
+
+	/* Check if Device-specific data record is present. */
+	if (!fw_health_data->device_specific_offset)
+		return ERR_PTR(-ENODEV);
+
+	dev_data = (void *)fw_health_data + fw_health_data->device_specific_offset;
+	if (!dev_data->vendor_count)
+		return ERR_PTR(-ENODEV);
+
+	/* Vendor data starts after Device-specific data */
+	data = (void *)dev_data + sizeof(*dev_data);
+
+	for (i = 0; i <= dev_data->vendor_count; ++i) {
+		struct acpi_phat_vendor_element *vendor_data = data;
+		int length = vendor_data->length;
+
+		/*
+		 * Move to the next Vendor specific entry if
+		 * the GUID of entry doesn't match.
+		 */
+		if (!guid_equal(guid, (guid_t *)vendor_data->vendor_guid)) {
+			data += vendor_data->length;
+			continue;
+		}
+
+		vendor_data = kmalloc(length, GFP_KERNEL);
+		if (!vendor_data)
+			return ERR_PTR(-ENOMEM);
+
+		memcpy(vendor_data, data, length);
+		return vendor_data;
+	}
+
+	return ERR_PTR(-ENODEV);
+}
+
+/**
+ * acpi_phat_put_vendor_reset_reason - Reclaim the object allocated by
+ * acpi_phat_get_vendor_reset_reason().
+ *
+ * @reason: A valid pointer returned by acpi_phat_get_vendor_reset_reason()
+ */
+void acpi_phat_put_vendor_reset_reason(struct acpi_phat_vendor_element *reason)
+{
+	kfree(reason);
+}
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 67effb91fa98..daed1d66ca43 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1627,6 +1627,20 @@ extern int acpi_ffh_address_space_arch_handler(acpi_integer *value,
 static inline void acpi_init_ffh(void) { }
 #endif
 
+#ifdef CONFIG_ACPI_PHAT
+struct acpi_phat_vendor_element *acpi_phat_get_vendor_reset_reason(guid_t *guid);
+void acpi_phat_put_vendor_reset_reason(struct acpi_phat_vendor_element *reason);
+#else
+static inline struct acpi_phat_vendor_element *
+acpi_phat_get_vendor_reset_reason(guid_t *guid)
+{
+	return ERR_PTR(-ENODEV);
+}
+
+static inline void
+acpi_phat_put_vendor_reset_reason(struct acpi_phat_vendor_element *reason) { }
+#endif
+
 #ifdef CONFIG_ACPI
 extern void acpi_device_notify(struct device *dev);
 extern void acpi_device_notify_remove(struct device *dev);
-- 
2.34.1

