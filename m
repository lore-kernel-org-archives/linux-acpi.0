Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B576C3EBF22
	for <linux-acpi@vger.kernel.org>; Sun, 22 Feb 2026 06:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771741849; cv=none; b=XmlxaB1TCKE6giLLC1twIhAEJXnNOQ7BEKdKQsuU+zsZJ/PKCgdn6fxToEy2CSqERxQY3uWsiANG51d1wFLxZOxZyXwpypAIT/cS4FWrDm0uDnGKARCZsnZBi8RvKDerKWFP4OnwqbRvAraVBVfjJsLv44brpn4r6D2YMHlDlfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771741849; c=relaxed/simple;
	bh=7EAZ/6AX5Q/e8XSxQSHjpoktu+QBbOOXLyxfh4od2JE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A2sdYK9gitjhpHdz2xS5LzG6KYAiV4W2MV5SlIlALTAx+4ERFbPZG5oXZT1PffPjCiwk0j9pErjBQZN+PeISJMRjUR6xETT6dXZAXtQqu549/ha64sRsCwSo91lvMbASes1EP+9bLa80Qn9ybUKreimh9usDfYn9cAh24/jAZSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OXI3uBnr; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OXI3uBnr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771741846; x=1803277846;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7EAZ/6AX5Q/e8XSxQSHjpoktu+QBbOOXLyxfh4od2JE=;
  b=OXI3uBnrPte6KJxtp7sfNLysgVoJt5LC2ONK21RK/9lmNx33mm3UuXVn
   FeRqakR11AEZ1IaSmzDx+Xfl7+Rljnls4CcjrlwArO8IVhyBu8m+dU4tz
   yv2RQMy/SCOH+VwDfAP3Hw0Lu2nIPclQSS1hS2op1GUuknK7LsqYFAQ0F
   0nxBNM3MXP/M75oGuMG7+A8Duu4+9BXEl9rM1h7ydZkgitRroeQpIjsop
   3NEOaX1rizxiYyDEWPZNTfDzQ3zPd6auEOoP1D9dbMe2xhZsC1ELHPD5Z
   qozQrfkbruuUo6t7C3hTLo06WCCf5QbGW+JLl/J0op6PEJWb9oxZFF19v
   g==;
X-CSE-ConnectionGUID: wPEooR9KTImDzSc6RJw/qA==
X-CSE-MsgGUID: jz2ZKDhUSs6B+Wi9ThS4dQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11708"; a="83400618"
X-IronPort-AV: E=Sophos;i="6.21,304,1763452800"; 
   d="scan'208";a="83400618"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2026 22:30:45 -0800
X-CSE-ConnectionGUID: 28n0ZdDaTUSbjK2vkmkR7g==
X-CSE-MsgGUID: zVD9jg6RRD2L0K+3eeFXfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,304,1763452800"; 
   d="scan'208";a="245833133"
Received: from nldesimo-desk.amr.corp.intel.com ([10.53.80.57])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2026 22:30:45 -0800
From: Nate DeSimone <nathaniel.l.desimone@intel.com>
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	tony.luck@intel.com
Subject: [PATCH v1] ACPI: FPDT: expose FBPT and S3PT subtables via sysfs
Date: Sat, 21 Feb 2026 22:30:27 -0800
Message-ID: <20260222063028.2840-1-nathaniel.l.desimone@intel.com>
X-Mailer: git-send-email 2.51.2.windows.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add sysfs attributes at /sys/firmware/acpi/fpdt/tables/FBPT and
/sys/firmware/acpi/fpdt/tables/S3PT that expose the raw contents of the
FPDT subtables. Note that /sys/firmware/acpi/tables/FPDT only provides
the top level table, not the subtables. Adding access to the subtables
enables a usage model similar to /sys/firmware/dmi/tables/DMI, allowing
userspace tools to interpret newer record types (e.g. String Event
Records, Microcontroller Boot Performance Data Records, etc.) defined
in recent ACPI specifications[1] without requiring kernel changes.

[1]
https://uefi.org/specs/ACPI/6.6/05_ACPI_Software_Programming_Model.html#performance-event-record-types

Signed-off-by: Nate DeSimone <nathaniel.l.desimone@intel.com>
---
 drivers/acpi/acpi_fpdt.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/acpi/acpi_fpdt.c b/drivers/acpi/acpi_fpdt.c
index 271092f2700a..aa79b28f3c20 100644
--- a/drivers/acpi/acpi_fpdt.c
+++ b/drivers/acpi/acpi_fpdt.c
@@ -141,7 +141,11 @@ static const struct attribute_group boot_attr_group = {
 	.name = "boot",
 };
 
+static BIN_ATTR(FBPT, 0444, sysfs_bin_attr_simple_read, NULL, 0);
+static BIN_ATTR(S3PT, 0444, sysfs_bin_attr_simple_read, NULL, 0);
+
 static struct kobject *fpdt_kobj;
+static struct kobject *tables_kobj;
 
 #if defined CONFIG_X86 && defined CONFIG_PHYS_ADDR_T_64BIT
 #include <linux/processor.h>
@@ -254,9 +258,34 @@ static int fpdt_process_subtable(u64 address, u32 subtable_type)
 			break;
 		}
 	}
+
+	if (subtable_type == SUBTABLE_FBPT) {
+		bin_attr_FBPT.private = subtable_header;
+		bin_attr_FBPT.size = length;
+		result = sysfs_create_bin_file(tables_kobj, &bin_attr_FBPT);
+		if (result)
+			goto err;
+	} else if (subtable_type == SUBTABLE_S3PT) {
+		bin_attr_S3PT.private = subtable_header;
+		bin_attr_S3PT.size = length;
+		result = sysfs_create_bin_file(tables_kobj, &bin_attr_S3PT);
+		if (result)
+			goto err;
+	}
+
 	return 0;
 
 err:
+	if (bin_attr_FBPT.private) {
+		sysfs_remove_bin_file(tables_kobj, &bin_attr_FBPT);
+		bin_attr_FBPT.private = NULL;
+	}
+
+	if (bin_attr_S3PT.private) {
+		sysfs_remove_bin_file(tables_kobj, &bin_attr_S3PT);
+		bin_attr_S3PT.private = NULL;
+	}
+
 	if (record_boot)
 		sysfs_remove_group(fpdt_kobj, &boot_attr_group);
 
@@ -288,6 +317,12 @@ static int __init acpi_init_fpdt(void)
 		goto err_nomem;
 	}
 
+	tables_kobj = kobject_create_and_add("tables", fpdt_kobj);
+	if (!tables_kobj) {
+		result = -ENOMEM;
+		goto err_tables;
+	}
+
 	while (offset < header->length) {
 		subtable = (void *)header + offset;
 		switch (subtable->type) {
@@ -306,6 +341,9 @@ static int __init acpi_init_fpdt(void)
 	}
 	return 0;
 err_subtable:
+	kobject_put(tables_kobj);
+
+err_tables:
 	kobject_put(fpdt_kobj);
 
 err_nomem:

base-commit: 8bf22c33e7a172fbc72464f4cc484d23a6b412ba
-- 
2.34.1

