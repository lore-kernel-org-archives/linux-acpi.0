Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8A53CA4B2
	for <linux-acpi@vger.kernel.org>; Tue, 24 Mar 2026 23:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774394226; cv=none; b=dlEViR2OkaCBpmLRhMqrFG3BUv4Xt1vE+UpVTIwJFwO3bJ3OClAU7OiXliHg2rR0cQfLuy05PyNQSpB6nFISpcSJAFEx4DiVeDZtSsUKd59ekjCJr9AkQ2EC6Rc6DKbDR2DADz7sRAsBzrqJJ+KfWd2MQ2cZU2SgJMO59hV81pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774394226; c=relaxed/simple;
	bh=yX0bl2t7bqPi7Ph/4n5121++GZMsZNbOC9DMcJSpq0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n+bwoWeGqyW8O7D8HSsr5WcHijlcTUqSogokBvFZho2wa9cbWENUwosdyxO9umJRBKiQsTblpEaT3KitivOe6V5uxlzpLeXC5/qpJw6QBDcpmjG/pTLsGGlD8mjMXXiNsbVbT32zkfWZQXZNdLyZBgl7x0rFIKfwejE48irjpaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZBwQnxiN; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZBwQnxiN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774394223; x=1805930223;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yX0bl2t7bqPi7Ph/4n5121++GZMsZNbOC9DMcJSpq0A=;
  b=ZBwQnxiNrgXe5JrGHcH7rDrG1PO9gfZUV8AeM3YZyTKz5LJEoGavWCwa
   Qk5KsqQHXFlhuXq9yUW1wGTvyB34PbZvQVkpt3Uz/nfmahsJQQ2defjEZ
   ArqlnlSiEQuLC8HK4v3G56Gftj/vtTZ5WPw5RcOnIjP+tqzuxkeed1wzS
   5CKU4bav867B8ApDbuBxsSxOOJCHVXZMteB0VvH89Z5rR84sMy4U9YM2y
   rWTiPGJ+1vpNsyUBgcL6k2HUxWYdWjRGIZYaooXJ0Au+RDUdsFCpjeF2F
   9gdIV1Riwi4vZYQSin/hZxDyxZaVaCQfgQPG+WZYxb0fMD6Iv90u9RJFE
   g==;
X-CSE-ConnectionGUID: jYgV9+5jTxmXLCK7sNlRnQ==
X-CSE-MsgGUID: 1iS3wCbcSIi8/RK1+6Snmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="79021653"
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="79021653"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 16:16:59 -0700
X-CSE-ConnectionGUID: o4B9HearRG+CRM70+SNRbQ==
X-CSE-MsgGUID: 5VBJFIFgQm+D/jlcNPTWQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="228548640"
Received: from nldesimo-desk.amr.corp.intel.com ([10.53.80.57])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 16:17:00 -0700
From: Nate DeSimone <nathaniel.l.desimone@intel.com>
To: rafael@kernel.org
Cc: lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	tony.luck@intel.com
Subject: [PATCH v3 1/2] ACPI: FPDT: expose FBPT and S3PT subtables via sysfs
Date: Tue, 24 Mar 2026 16:14:54 -0700
Message-ID: <20260324231456.701-2-nathaniel.l.desimone@intel.com>
X-Mailer: git-send-email 2.51.2.windows.1
In-Reply-To: <20260324231456.701-1-nathaniel.l.desimone@intel.com>
References: <20260324231456.701-1-nathaniel.l.desimone@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add sysfs files at /sys/firmware/acpi/fpdt/FBPT and
/sys/firmware/acpi/fpdt/S3PT that expose the raw contents of the
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
 drivers/acpi/acpi_fpdt.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/acpi/acpi_fpdt.c b/drivers/acpi/acpi_fpdt.c
index 271092f2700a..e75dd28d31a9 100644
--- a/drivers/acpi/acpi_fpdt.c
+++ b/drivers/acpi/acpi_fpdt.c
@@ -141,6 +141,9 @@ static const struct attribute_group boot_attr_group = {
 	.name = "boot",
 };
 
+static BIN_ATTR(FBPT, 0400, sysfs_bin_attr_simple_read, NULL, 0);
+static BIN_ATTR(S3PT, 0400, sysfs_bin_attr_simple_read, NULL, 0);
+
 static struct kobject *fpdt_kobj;
 
 #if defined CONFIG_X86 && defined CONFIG_PHYS_ADDR_T_64BIT
@@ -254,9 +257,34 @@ static int fpdt_process_subtable(u64 address, u32 subtable_type)
 			break;
 		}
 	}
+
+	if (subtable_type == SUBTABLE_FBPT) {
+		bin_attr_FBPT.private = subtable_header;
+		bin_attr_FBPT.size = length;
+		result = sysfs_create_bin_file(fpdt_kobj, &bin_attr_FBPT);
+		if (result)
+			pr_warn("Failed to create FBPT sysfs attribute.\n");
+	} else if (subtable_type == SUBTABLE_S3PT) {
+		bin_attr_S3PT.private = subtable_header;
+		bin_attr_S3PT.size = length;
+		result = sysfs_create_bin_file(fpdt_kobj, &bin_attr_S3PT);
+		if (result)
+			pr_warn("Failed to create S3PT sysfs attribute.\n");
+	}
+
 	return 0;
 
 err:
+	if (bin_attr_FBPT.private) {
+		sysfs_remove_bin_file(fpdt_kobj, &bin_attr_FBPT);
+		bin_attr_FBPT.private = NULL;
+	}
+
+	if (bin_attr_S3PT.private) {
+		sysfs_remove_bin_file(fpdt_kobj, &bin_attr_S3PT);
+		bin_attr_S3PT.private = NULL;
+	}
+
 	if (record_boot)
 		sysfs_remove_group(fpdt_kobj, &boot_attr_group);
 
-- 
2.34.1

