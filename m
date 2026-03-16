Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013032.outbound.protection.outlook.com [40.107.201.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D0738F63E;
	Mon, 16 Mar 2026 10:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773658284; cv=fail; b=qou9aeUfB2H5BrKK6kyxFK9cIc8mEKFQV4S6bh9pvsgrAb7ZKJsvS8fVwWZqO6LCZP7Fs2paqIVZ2xWdio6zQf3L/ZKioRHYF57/RZh5mgIZjIjc3gN9gMxEo4qLeTicksIWOwtll6pg7j+hcxZNiihbmTnBKcbVfvRZxFP5IHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773658284; c=relaxed/simple;
	bh=wYlRSfL9aaJv4DpSCKi423+MOXQl7VQd9KOiwZrvdAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=oV9Qcwi8egh3sOy5qWGLGn9007Oak+sNRp+SU+ielQaLCNwfVRAd7P7Nbnrc0L8dhnaxtEHiXAnKGubZDXxg8yvRvfaZQU2L8tqHihuOSJLljltV9XmDQ9DE1+c42kh0yY7ehcga3/UKSTXPwfO5u51SU1rWwRA1vVh+/krceNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GcO0iQiy; arc=fail smtp.client-ip=40.107.201.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GcO0iQiy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l9eocyMzpq8U2f0MxnEZwM+8+IHiDY6C0R9mezM5fbyg0CdkCXm8oGm4WsTKPnkWfyTKn4rAhtly4jN0GET9bjF8HeAGd9ZxANDjC/8IzQuE9IwBl0beiBRyb7xpSusrKOoadJE1mT5c9zrd+HLd2u4a5bK/eBoGAw5JVvr3yIcss+Q4sXcABSG2S1nx1ZEi5tzSLrWaFSp//P0ImdroMKgie8SfckZxAjsAc05ET0YdgVRicEWfDeUCwr874Gb+lvg0KtcaHdOP4LZSkwWInpvWDk8i2ieYiogB7yjOMtSMKULXWA3kVTWpnVjvwwJ/A6VkfABcgN5FM90RtZTiCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SAxpaJV6vCb2S+rS00OtRhK9lrmYJQ/26slU6xilcys=;
 b=XDt/T60MOLbkmqUtnXNLw4cjigNvYMPStceBg3i4nLjA09QD2usTJ1c8bFZwBf9M+PQ3kphQTYOhQkIgjG1cS0EBbED9+etWhJNVr9dgkTTHw8jWXuEFdAcJtr/pBY4YSzMaTGHaiQxU792pPa7aRkEEBhzF8LATkLRCcYOY9DeC/ULIJ6fUEp09s6Mse0YVjZhZw9FyH8uKsSQoROMyvpboiTPM8qiybL1v9XkSlq49TbElm+Y3qo+8jqw9ELoHZlJz4f+KaSKUdXSe0XT3/tsC18AUFSOyw0x9TF/cPmTBOLrfV/R6jzUKWaDdG4vupvqgGAMr043XQDvMXcJUcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SAxpaJV6vCb2S+rS00OtRhK9lrmYJQ/26slU6xilcys=;
 b=GcO0iQiy8ISxtK9j3f4T3z4Gzv5sOsSsnU9Guiv9en5L5t+0OUeVB0imRCVec6hAJBCzzK1tmfYOsuyxUI7aLuq6Ii1ykIrHyrMsfE9ZfKycQBm3q7c+ECKeDJQINEhcX6SDDlTlHOh3TveCu/ayQis5pDUBJ4OFUGxD6XC53SEXCWEkTfRdOB+zNlSsxH3RkxVdke2gnBsqPwUwF2U28EEGCzrAiQwtIIfRB/84B7Q+k2oFP+rPT6fLaHwGKWhA312VxKCMLGZT4l97oxD2F1bt8KzAKQdGYdsv7W3fTCNO3oYHbWuIYiuEF509ISW/77NZKUHeSSRcy9EeVGEv5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB7914.namprd12.prod.outlook.com (2603:10b6:510:27d::13)
 by PH7PR12MB5808.namprd12.prod.outlook.com (2603:10b6:510:1d4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.13; Mon, 16 Mar
 2026 10:51:17 +0000
Received: from PH7PR12MB7914.namprd12.prod.outlook.com
 ([fe80::d390:582:5536:40ad]) by PH7PR12MB7914.namprd12.prod.outlook.com
 ([fe80::d390:582:5536:40ad%5]) with mapi id 15.20.9678.017; Mon, 16 Mar 2026
 10:51:17 +0000
From: Kai-Heng Feng <kaihengf@nvidia.com>
To: rafael@kernel.org
Cc: Kai-Heng Feng <kaihengf@nvidia.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Len Brown <lenb@kernel.org>,
	Huang Yiwei <quic_hyiwei@quicinc.com>,
	Will Deacon <will@kernel.org>,
	Gavin Shan <gshan@redhat.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH] acpi/apei: Add NVIDIA GHES vendor CPER record handler
Date: Mon, 16 Mar 2026 18:50:50 +0800
Message-ID: <20260316105056.28146-1-kaihengf@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:4:194::18) To PH7PR12MB7914.namprd12.prod.outlook.com
 (2603:10b6:510:27d::13)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7914:EE_|PH7PR12MB5808:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a1b47de-dd9a-4235-195b-08de8349f329
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	+MLMJaJ188NU2Zmz4CorUuONpCtdTSY2X1Ib4GzxZ5ubbnljx7o0ivoV5w1lP5k990gW033rvMTLgweAn/sqaxNBiCTVrm4RSi9yIrglUZZlH74YpC/n8WjQSaeNcodmvb/IHV4ZiT40/kYdLOfj7A9RyTKL4S4Av6PEP1N1SjDJNoO+sYym6lflbl5brqVnyO//+zxf3a0i5BcbciwMGEVT60LaWUCPFpWrZ/ZSp03D5bcoiinlM4pUm2qgqRw4vGNaPlVBIe8bNuhXYxfYlQ9pauaSjFaGS6jWq3w5GZ37F8VqejFvDqTvPY+xBcGdnh30IhlFDL3r3GvLdA0v01Rg5QqE6QNIHJr0tTMYIPU8rmwurpsU0zyJigBpCkDKMnf1qPmoe/4DlYSMCD1oq6MU+FVBs8D7MesLTij8eTuNvVja+f/MSOWB8tMRvv/ZRWS5Ski7VsYgIxD5bZngAe2BElXMmErkBAJdc21YVuOGTfwIE9/b3LmDXHODPdQqaITgUvXP2uRx3PmoIxhQr1aTZ31rKIobumafa2t86n92scwHnyQN1DMSsRl0rlUkRRrpm/a6jwhm6AVKLZWhsaUdGzd3UA1Oa8T6F6HnblitX2OkTcC9CtF1ao0QoUKG6FCDXkJXawz9TWJAdbIeeTDg/KxdYomJxRv0EQRnmbBZCtQruv6qGJEVYY2LK+96ujPsUiIOJ6A6nW/l0jFBXlp7On9sHoah7NcZPfbWmsI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB7914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Bx/2WIIG+Dg4GQrQDMZWwtZz60X6B5oiPHPBmCrJgXFkiwaJd3cXcYQ+/5Vq?=
 =?us-ascii?Q?gcJ735rvHCXj4l8nc5cddCOUrAksuQnNWTiuvJvU0rZzyw3zpdrSFozd6i2n?=
 =?us-ascii?Q?ldiAZ8SGJhl0ggQeXfCZ2vg+3mXJgbSQtyZ8dzvjt23ED5FkLRwb3ROFuxKx?=
 =?us-ascii?Q?18k0H6J+7FQEx6u2JZgne6iRtz2QsH2fwy6+fO+q+Vqgtgc9PzWbJqtUAQHa?=
 =?us-ascii?Q?q0gA5uMJiBq2y9FxvDZAycHwgxDmo8tQy/AKlpoK3PVKclxR2mGGoRZXyBIp?=
 =?us-ascii?Q?kFENzAm8po+rrL0pEZ/6W9yL4EDPGcDkRXRS9mL/UdtvAPlSsbKKzA0bQD03?=
 =?us-ascii?Q?LIqW3JeD2EL+tWgEu0yxS+Z2uRwFHpP59cbbBOPKYKDX8n7Wl+DtxmP9Njop?=
 =?us-ascii?Q?g42Sk1voZz6Itau5s2xYD5snxa9uSNSjAPq+RtBo6WszDqbC/XtpK9qYXno4?=
 =?us-ascii?Q?WV1Y2SIGcWxqQi944F0BZHNvSicwab6WcmQsDIrWhEtb+Q/gQNjN4tiGgKU9?=
 =?us-ascii?Q?oXDtm8HYQ9JDYmYT32eGZSvBO8D6d8XkuHM+zbreCGAQfZe6F5wa6b4q1Djb?=
 =?us-ascii?Q?5ofnphVC65rWZXyqOSgYoqGH6qRl/Px2h8s3uKx9gf2gT0UVJTtDMj+A8eKY?=
 =?us-ascii?Q?J5/cWuTcNKn34B2gJbUlbe1SzMB9ptI3pzqa83Lv8aA+P+WUAnrRYb+KVVgu?=
 =?us-ascii?Q?ZTuFKbtXxvxOSeov+jhKF5ynXFnc8qEhn1rvAaC1GC3nDf6Y2R3s2eO08O4q?=
 =?us-ascii?Q?M0GUvsNoWmLURtH4WiogfYYVTy2t7FnTo6uAXwy60l73w2Kt0mcd/gy9+Dyc?=
 =?us-ascii?Q?xEXhKJUAX7iU8AoJY3ol4BVnNQO5c3+77dFdOL1p0tjewXV8JmP96mbBhAcO?=
 =?us-ascii?Q?YkvkbrvZ+cKEEWtmaC2m642vO5L2OX7mS6ybz7MnBIBzL2rgASosXkpMXwoQ?=
 =?us-ascii?Q?rkmVmkKEbIcYeLDnR/ozthY914T0c/jc//1Eq2p5+/uh0OOiGq+GnpxqfJhY?=
 =?us-ascii?Q?tfwAGlMraqfTZ4bYaiTUC+jHQxka0rEgIsPDs8hVLyPi0i6vZBLsWq8XteFz?=
 =?us-ascii?Q?zJ+VwgE1CrFzYxgGi78c8scOO8uvioYukkUFarzKXWm2oS6jqUaoC5b+Nsdf?=
 =?us-ascii?Q?snbeTCc0N9y0j/MoShT1AZJyfOX28IaQfm6JeczEMRtrxw9rLJyK/QbLo25a?=
 =?us-ascii?Q?mENAWVmavsb0w2AT0e6CBq9tRaYZsuspM8KdJ/ka8F+mzITSukta1ouWZRIc?=
 =?us-ascii?Q?0ieR4q31QpRu16QKqOcYOXMPudFSGmVfesZwtfAtrTW7+Nd9ffUjp/4IRnza?=
 =?us-ascii?Q?yj9l/i/g1qiDjKNpt1Tx0VibMJV/EYWhvYmFljTmk4JDkXu8UN8QEiQWgNAg?=
 =?us-ascii?Q?g+L7ngoCe7dEuxfZ7MkzSzj/bT1kYPY14488bCywhMDbcEClkqvsGS2Dq5zO?=
 =?us-ascii?Q?qzhgExJd3bouLmFQWPJNosZXXbSRjUDqMWOfd1Qv8R4ZKTKVY5OqKgWOvS9X?=
 =?us-ascii?Q?RPSGTq8lIzTNDHHByJk3QMOyKl76chJClvNCNrJjY29gMkMzKwesp54o0Gzc?=
 =?us-ascii?Q?IZXjUBwdVQNwJZfB3NECgAK/fyOzKqY2baBmUWDDIkQmetkhMd63I6JtrDid?=
 =?us-ascii?Q?Mt9HpNC2+7wg/dK+BiB/TJ/PwyNniwn7jWrAaVegYtIF+zl8Y2og8/zwZJKd?=
 =?us-ascii?Q?6qq3omp2tNTfsTbDRb3wtGbBrKjG7alp3z0/DFN/G2StfC3Fd3SllHODB+wC?=
 =?us-ascii?Q?eFCVrtvJGg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a1b47de-dd9a-4235-195b-08de8349f329
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 10:51:17.1531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GWRTMBGA9mFEcxATAD74eOKDmNLpRWN2LQts6LhUs5DuRlzVVTcDk2404BkWRJ2NP7xs2zqeYYKl13GtF7aQQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5808

Add support for decoding NVIDIA-specific CPER sections delivered via
the APEI GHES vendor record notifier chain. NVIDIA hardware generates
vendor-specific CPER sections containing error signatures and diagnostic
register dumps. This implementation registers a notifier_block with the
GHES vendor record notifier and decodes these sections, printing error
details via dev_info().

The driver binds to ACPI device NVDA2012, present on NVIDIA server
platforms. The NVIDIA CPER section contains a fixed header with error
metadata (signature, error type, severity, socket) followed by
variable-length register address-value pairs for hardware diagnostics.

This work is based on libcper [0].

Example output:
nvidia-ghes NVDA2012:00: NVIDIA CPER section, error_data_length: 544
nvidia-ghes NVDA2012:00: signature: CMET-INFO
nvidia-ghes NVDA2012:00: error_type: 0
nvidia-ghes NVDA2012:00: error_instance: 0
nvidia-ghes NVDA2012:00: severity: 3
nvidia-ghes NVDA2012:00: socket: 0
nvidia-ghes NVDA2012:00: number_regs: 32
nvidia-ghes NVDA2012:00: instance_base: 0x0000000000000000
nvidia-ghes NVDA2012:00: register[0]: address=0x8000000100000000 value=0x0000000100000000

[0] https://github.com/openbmc/libcper/commit/683e055061ce
Cc: Shiju Jose <shiju.jose@huawei.com>
Signed-off-by: Kai-Heng Feng <kaihengf@nvidia.com>
---
 MAINTAINERS                     |   6 ++
 drivers/acpi/apei/Kconfig       |  14 +++
 drivers/acpi/apei/Makefile      |   1 +
 drivers/acpi/apei/nvidia-ghes.c | 168 ++++++++++++++++++++++++++++++++
 4 files changed, 189 insertions(+)
 create mode 100644 drivers/acpi/apei/nvidia-ghes.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 837db4f7bcca..db12d7ffb1f9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18910,6 +18910,12 @@ S:	Maintained
 F:	drivers/video/fbdev/nvidia/
 F:	drivers/video/fbdev/riva/
 
+NVIDIA GHES VENDOR CPER RECORD HANDLER
+M:	Kai-Heng Feng <kaihengf@nvidia.com>
+L:	linux-acpi@vger.kernel.org
+S:	Maintained
+F:	drivers/acpi/apei/nvidia-ghes.c
+
 NVIDIA VRS RTC DRIVER
 M:	Shubhi Garg <shgarg@nvidia.com>
 L:	linux-tegra@vger.kernel.org
diff --git a/drivers/acpi/apei/Kconfig b/drivers/acpi/apei/Kconfig
index 070c07d68dfb..7dc49f14f223 100644
--- a/drivers/acpi/apei/Kconfig
+++ b/drivers/acpi/apei/Kconfig
@@ -74,6 +74,20 @@ config ACPI_APEI_EINJ_CXL
 
 	  If unsure say 'n'
 
+config ACPI_APEI_NVIDIA_GHES
+	tristate "NVIDIA GHES vendor record handler"
+	depends on ACPI_APEI_GHES
+	help
+	  Support for decoding NVIDIA-specific CPER sections delivered via
+	  the APEI GHES vendor record notifier chain. Registers a handler
+	  for the NVIDIA section GUID and logs error signatures, severity,
+	  socket, and diagnostic register address-value pairs.
+
+	  Enable on NVIDIA server platforms (e.g. DGX, HGX) that expose
+	  ACPI device NVDA2012 in their firmware tables.
+
+	  If unsure, say N.
+
 config ACPI_APEI_ERST_DEBUG
 	tristate "APEI Error Record Serialization Table (ERST) Debug Support"
 	depends on ACPI_APEI
diff --git a/drivers/acpi/apei/Makefile b/drivers/acpi/apei/Makefile
index 1a0b85923cd4..4a883f67d698 100644
--- a/drivers/acpi/apei/Makefile
+++ b/drivers/acpi/apei/Makefile
@@ -10,5 +10,6 @@ obj-$(CONFIG_ACPI_APEI_EINJ)	+= einj.o
 einj-y				:= einj-core.o
 einj-$(CONFIG_ACPI_APEI_EINJ_CXL) += einj-cxl.o
 obj-$(CONFIG_ACPI_APEI_ERST_DEBUG) += erst-dbg.o
+obj-$(CONFIG_ACPI_APEI_NVIDIA_GHES) += nvidia-ghes.o
 
 apei-y := apei-base.o hest.o erst.o bert.o
diff --git a/drivers/acpi/apei/nvidia-ghes.c b/drivers/acpi/apei/nvidia-ghes.c
new file mode 100644
index 000000000000..0e866f536a7a
--- /dev/null
+++ b/drivers/acpi/apei/nvidia-ghes.c
@@ -0,0 +1,168 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NVIDIA GHES vendor record handler
+ *
+ * Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+ */
+
+#include <linux/acpi.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/unaligned.h>
+#include <acpi/ghes.h>
+
+static const guid_t nvidia_sec_guid =
+	GUID_INIT(0x6d5244f2, 0x2712, 0x11ec,
+		  0xbe, 0xa7, 0xcb, 0x3f, 0xdb, 0x95, 0xc7, 0x86);
+
+#define NVIDIA_CPER_REG_PAIR_SIZE	16	/* address + value, each u64 */
+
+struct cper_sec_nvidia {
+	char	signature[16];
+	__le16	error_type;
+	__le16	error_instance;
+	u8	severity;
+	u8	socket;
+	u8	number_regs;
+	u8	reserved;
+	__le64	instance_base;
+} __packed;
+
+struct nvidia_ghes_private {
+	struct notifier_block	nb;
+	struct device		*dev;
+};
+
+static void nvidia_ghes_print_error(struct device *dev,
+				    const struct cper_sec_nvidia *nvidia_err,
+				    size_t error_data_length, bool fatal)
+{
+	const char *level = fatal ? KERN_ERR : KERN_INFO;
+	const u8 *reg_data;
+	size_t min_size;
+	int i;
+
+	dev_printk(level, dev, "signature: %.16s\n", nvidia_err->signature);
+	dev_printk(level, dev, "error_type: %u\n", le16_to_cpu(nvidia_err->error_type));
+	dev_printk(level, dev, "error_instance: %u\n", le16_to_cpu(nvidia_err->error_instance));
+	dev_printk(level, dev, "severity: %u\n", nvidia_err->severity);
+	dev_printk(level, dev, "socket: %u\n", nvidia_err->socket);
+	dev_printk(level, dev, "number_regs: %u\n", nvidia_err->number_regs);
+	dev_printk(level, dev, "instance_base: 0x%016llx\n",
+		   (unsigned long long)le64_to_cpu(nvidia_err->instance_base));
+
+	if (nvidia_err->number_regs == 0)
+		return;
+
+	/*
+	 * Validate that all registers fit within error_data_length.
+	 * Each register pair is NVIDIA_CPER_REG_PAIR_SIZE bytes (two u64s).
+	 */
+	min_size = sizeof(struct cper_sec_nvidia) +
+		   (size_t)nvidia_err->number_regs * NVIDIA_CPER_REG_PAIR_SIZE;
+	if (error_data_length < min_size) {
+		dev_err(dev, "Invalid number_regs %u (section size %zu, need %zu)\n",
+			nvidia_err->number_regs, error_data_length, min_size);
+		return;
+	}
+
+	/*
+	 * Registers are stored as address-value pairs immediately
+	 * following the fixed header.  Each pair is two little-endian u64s.
+	 */
+	reg_data = (const u8 *)(nvidia_err + 1);
+	for (i = 0; i < nvidia_err->number_regs; i++) {
+		u64 addr = get_unaligned_le64(reg_data + i * NVIDIA_CPER_REG_PAIR_SIZE);
+		u64 val = get_unaligned_le64(reg_data + i * NVIDIA_CPER_REG_PAIR_SIZE + 8);
+
+		dev_printk(level, dev, "register[%d]: address=0x%016llx value=0x%016llx\n",
+			   i, (unsigned long long)addr, (unsigned long long)val);
+	}
+}
+
+static int nvidia_ghes_notify(struct notifier_block *nb,
+			      unsigned long event, void *data)
+{
+	struct acpi_hest_generic_data *gdata = data;
+	struct nvidia_ghes_private *priv;
+	const struct cper_sec_nvidia *nvidia_err;
+	guid_t sec_guid;
+
+	import_guid(&sec_guid, gdata->section_type);
+	if (!guid_equal(&sec_guid, &nvidia_sec_guid))
+		return NOTIFY_DONE;
+
+	priv = container_of(nb, struct nvidia_ghes_private, nb);
+
+	if (acpi_hest_get_error_length(gdata) < sizeof(struct cper_sec_nvidia)) {
+		dev_err(priv->dev, "Section too small (%u < %zu)\n",
+			acpi_hest_get_error_length(gdata), sizeof(struct cper_sec_nvidia));
+		return NOTIFY_OK;
+	}
+
+	nvidia_err = acpi_hest_get_payload(gdata);
+
+	if (event >= GHES_SEV_RECOVERABLE)
+		dev_err(priv->dev, "NVIDIA CPER section, error_data_length: %u\n",
+			acpi_hest_get_error_length(gdata));
+	else
+		dev_info(priv->dev, "NVIDIA CPER section, error_data_length: %u\n",
+			 acpi_hest_get_error_length(gdata));
+
+	nvidia_ghes_print_error(priv->dev, nvidia_err, acpi_hest_get_error_length(gdata),
+				event >= GHES_SEV_RECOVERABLE);
+
+	return NOTIFY_OK;
+}
+
+static int nvidia_ghes_probe(struct platform_device *pdev)
+{
+	struct nvidia_ghes_private *priv;
+	int ret;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->nb.notifier_call = nvidia_ghes_notify;
+	priv->dev = &pdev->dev;
+
+	ret = ghes_register_vendor_record_notifier(&priv->nb);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"Failed to register NVIDIA GHES vendor record notifier: %d\n", ret);
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, priv);
+
+	return 0;
+}
+
+static void nvidia_ghes_remove(struct platform_device *pdev)
+{
+	struct nvidia_ghes_private *priv = platform_get_drvdata(pdev);
+
+	ghes_unregister_vendor_record_notifier(&priv->nb);
+}
+
+static const struct acpi_device_id nvidia_ghes_acpi_match[] = {
+	{ "NVDA2012", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, nvidia_ghes_acpi_match);
+
+static struct platform_driver nvidia_ghes_driver = {
+	.driver = {
+		.name		= "nvidia-ghes",
+		.acpi_match_table = nvidia_ghes_acpi_match,
+	},
+	.probe	= nvidia_ghes_probe,
+	.remove	= nvidia_ghes_remove,
+};
+module_platform_driver(nvidia_ghes_driver);
+
+MODULE_AUTHOR("Kai-Heng Feng <kaihengf@nvidia.com>");
+MODULE_DESCRIPTION("NVIDIA GHES vendor CPER record handler");
+MODULE_LICENSE("GPL");
-- 
2.50.1 (Apple Git-155)

