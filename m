Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC4527BF7D
	for <linux-acpi@vger.kernel.org>; Tue, 10 Mar 2026 04:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773117340; cv=none; b=RKICrDsKM3TQ+HT+MeER1UqFpfCFT2D1+9snvlL+LP2iWglsgzEipR9oN8JIZ+VUhyEz02yJ/CRCQFxP0GbzabpzA1/LvORaJUg4joo2I9d0FKbYzvunFor46t9S/9E9pfulKvD5H7KMXIeW8nx8RqgfSQWXoVPM7o1OZQQ1iEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773117340; c=relaxed/simple;
	bh=m3bhdYFaAWwaeoS0tli3EK/om2mPNXoD00sSwS9tdNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kA0cIvZOmrdbRczt2inyXfSmTUGnhuk+JTL44ZBtlvIFm9r2RR9OIZurIE+KG6/vMAqBelT6UoO0BtiF+WWPdRMEQvLqiSX8Xw6ic28GpXIYrA/V9yzgunGdIyh/flSAwQQpNQ5itpQ3TLNOlVaXA2Pltj2udBYTSW4YLPC+P+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=biFVcYQh; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="biFVcYQh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773117339; x=1804653339;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m3bhdYFaAWwaeoS0tli3EK/om2mPNXoD00sSwS9tdNg=;
  b=biFVcYQhs+A2ffalrxSAnJUBd26mH+gS6KoMUdIxKQFbvbY2Iw26xqRJ
   t3STJf9u2IkonnjdtIyBkijKRSkprYYK6I/Cv6I0iBmLxVl2o9x1Tkiqw
   o+u90qUnd6WSa4q2CqQ+4vW3N/ZeEFbaw30mPc+TzasAM0oyD+X/VLj+m
   GSy6NAR+8AZkcUkPcHr1/hBLuNC1TIayF+qnwPF5Q5e2IZhcAQg1F2W5H
   1bk+uXEEfXAtta8nfzq3k+LA0hJjVChySyQExtOfYOk5IuNb/QPXigwRn
   aWrSneD7MQpLJS1l8WfqU61n9bAfqCwiKz2GPkH1ysjmOiA1tRHSy6JwA
   Q==;
X-CSE-ConnectionGUID: sFqFOG1dQz+0PrPRupwMjw==
X-CSE-MsgGUID: EbrLdcS5RiGH5I6ABz1D+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11724"; a="74074078"
X-IronPort-AV: E=Sophos;i="6.23,111,1770624000"; 
   d="scan'208";a="74074078"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 21:35:36 -0700
X-CSE-ConnectionGUID: diM69k7HSv+TrHTbaIryxw==
X-CSE-MsgGUID: lgeNQLZcS6G33mJzlhSOxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,111,1770624000"; 
   d="scan'208";a="250437402"
Received: from nldesimo-desk.amr.corp.intel.com ([10.53.80.57])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 21:35:36 -0700
From: Nate DeSimone <nathaniel.l.desimone@intel.com>
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	tony.luck@intel.com
Subject: [PATCH v2 1/2] ACPI: FPDT: expose FBPT and S3PT subtables via sysfs
Date: Mon,  9 Mar 2026 21:34:40 -0700
Message-ID: <20260310043449.1295-2-nathaniel.l.desimone@intel.com>
X-Mailer: git-send-email 2.51.2.windows.1
In-Reply-To: <20260310043449.1295-1-nathaniel.l.desimone@intel.com>
References: <20260222063028.2840-1-nathaniel.l.desimone@intel.com>
 <20260310043449.1295-1-nathaniel.l.desimone@intel.com>
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
index 271092f2700a..35fe95acccab 100644
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
+			goto err;
+	} else if (subtable_type == SUBTABLE_S3PT) {
+		bin_attr_S3PT.private = subtable_header;
+		bin_attr_S3PT.size = length;
+		result = sysfs_create_bin_file(fpdt_kobj, &bin_attr_S3PT);
+		if (result)
+			goto err;
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
 

base-commit: 8bf22c33e7a172fbc72464f4cc484d23a6b412ba
-- 
2.34.1

