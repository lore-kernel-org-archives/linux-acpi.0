Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013019.outbound.protection.outlook.com [40.93.196.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CC8321457;
	Mon, 12 Oct 2026 23:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791846434; cv=fail; b=ucCuRVB1BNOnSWTO08njOtwilps+l/FdpmLAWe9UtkqeM8bYsTVI0TabdChApTIzGyg2ntcrOn0vjSqu/DPdGDwccJXJEM0NAJW75jnwtKjj9tN4lTb5raj+UzLzQbkLLLApQaJX002NzSX5goCRV/8v0tP00GCrUiZw1EaHYS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791846434; c=relaxed/simple;
	bh=f/KT6q9loiRl5MaqAOpa1nYnemO4SsLNHYM7PjsMWdo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MANn4F3r/wYEEj8x4ybAauwBOvRRHfZiWocnYPn5OlM10gH2vUmNLqGiifn3E+2lEZfspCcdGZciNYwnD9PiYyH6bhLbFgLgKFn6C7mCQnAQNn+aBQcnNceAMJ2/gYvNHk4a4qRKMWH35yZbiKuput01wXd03JZVGL00BQ2mUhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PYn0IQCw; arc=fail smtp.client-ip=40.93.196.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PYn0IQCw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E3/3hO1QpU7DfEn77+8bfEEcK8MDa+bOuR5Bu0oPejCfDBPCs1RrCmi24VKmjNlzR6gj2oAaHHoHY7kEuUf3zqdGqZtsbDXXwC1DcdUaIoEY8TbII0u4QU2igC/OE0OpBQ7a2kwymLw4U5DMwel1CpzCWYeTAjEbUKGnuqfKMkTw6XaiD+fI9uJBjMgrco96QVD9al7Pr/xhx1AQlHRq64OEr8yX14aln1n0GqGrHm+dTvBtS3PzmK9p2gsAHCt7IbuV02HYo1MuaMKbS8oDDb1L+zj+EvnAMajUXRohqwj1SnYW35t3rrUc8rwAH1wGL8P7A+BOW8T6deIVW+835g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N/B0jHZio30ajg3hAC9KS/WmvRF0TRKojwnXOimfXlk=;
 b=U77Dkh75QOdAb5B381qEO/wGoWzsd37AU4tp1dG6/Qyi3ZAFsAk0r0XQngzLXSiRFShvLl2M2ba/6Bg4dWY6lqwirQGGC99/uCrJyH1Xxicj6IpX6DKu0AA1+vsiOVRZiBl68PGru3p9CKn+0MJ6Dz0nWx2flREolIcKQ4gsw7Q5A6xgai56gOCpEU1J32B/epaMFilUPl1tNxt+J5D5Vh/5K0JTdT/brgj4J3KkrDTkkWAQsEIZFKITnCB+uMeDgT4RJc89FPTMNa2DOrpauBQsB/b9zAVMiBPRI4KfUiSKkiLLXOH/yN15HLR3e5D8JvS9nMpG96FZ6OjO1uFr/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N/B0jHZio30ajg3hAC9KS/WmvRF0TRKojwnXOimfXlk=;
 b=PYn0IQCw2A6ycX7kO5lkmxNU9se0z46/Eq0GryqG2vB8VntvAsMUcJT7utXr5NKsjAk2zeZU9IyusUyujvGF0AjOn8uMFaeXC8CrkFEcDMhF2DS8GSzKzGMyJcSAxv5+BSpdhqj8kFYM3XHmI2kwplaA/2tufST1HTJRpnSuRj8ejL8ecvbmrtwb+qKJdSgX0DOQ0dn5qezaRpbVC1NaTxryZTaY/ZSdf/e1awUPaFuTjKa0gBuaVPBBxZDx+jCLi+A/EvzskFf58MOL3GNiqJ4JH9OZo/5JleowxNNd3TIvT0Cj7QI6LOULWOXkpA5KqImKdlntIU7rN6KqblMYAQ==
Received: from MW4PR03CA0004.namprd03.prod.outlook.com (2603:10b6:303:8f::9)
 by CH3PR12MB512574.namprd12.prod.outlook.com (2603:10b6:610:34d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Mon, 12 Oct
 2026 23:07:07 +0000
Received: from MW2PEPF00014679.namprd04.prod.outlook.com
 (2603:10b6:303:8f:cafe::4b) by MW4PR03CA0004.outlook.office365.com
 (2603:10b6:303:8f::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Mon, 12
 Oct 2026 23:07:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MW2PEPF00014679.mail.protection.outlook.com (10.167.249.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 12 Oct 2026 23:07:07 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 12 Oct
 2026 16:06:33 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 12 Oct
 2026 16:06:33 -0700
Received: from dgx-1v-42.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Mon, 12 Oct 2026 16:06:33 -0700
From: Jamie Nguyen <jamien@nvidia.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, "Punit
 Agrawal" <punitagrawal@gmail.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/2] ACPI: sysfs: Expose BDAT data region
Date: Mon, 12 Oct 2026 16:06:32 -0700
Message-ID: <20261012230632.3574987-3-jamien@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012230632.3574987-1-jamien@nvidia.com>
References: <20261012230632.3574987-1-jamien@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PEPF00014679:EE_|CH3PR12MB512574:EE_
X-MS-Office365-Filtering-Correlation-Id: 673e1810-5cbe-4e1f-00ed-08df28b589b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|6133799003|10067099003|18002099003|22082099003|13003099007|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	xNjTAFuxgwdaDiz47/YH7YdQLGwoEeKkO+QAnRbQnnNuyPpjjNMxgSHKg24VXouRsk2HjbWXkrRgQGZOsq5qwSpkXGlVaxMPW80ffdO9nNoaDBfqciYkMzmYfb3ab+L8PFun3EMRbK1m3LJ79TGwUnl1Qe89ADjjfZ7+hR1OtbpJogYWpFl1PpwRZfUQF83+Hr4/hprnpOyeE64sS3Czhq4Nq+e9AHbkFndJabPSx6YC/+jzdCpj5UaBMfNGKfc3YyEgImQkyx2GLYeCsJ7Z7fyFB/7gTwe8i1eNKYLkv4Of8D1MTMO+AIKuHkSTiKXYfCkNw18uweHSIDhTV5ZBwPJDE6P4ROfgz/yXF7+cshrn6mv2DeV8i+4OGnQN8/khHEU7d8nePMSDAyKxPLqgkBpde1KmeXs6KnFw/C7VdUzSrv850myIzmj0ss6nCv8HOerX32xhfmc6f6NQfW2sXVl0Hv98+XaMTDFvYXw7IKzVLDfOxOwBsUpa3Y1YpyNgEqQ/UcKmZE49og50G2VTt4ZUjbCXQBaHrtLf4amSnYCxs/7UTrkOxhtszpNijEooRec+K13rIYFRxoL2iflbIm7ofjV8tNvwy/P38UmU6JOLHBrFivMt837AGwxVTPd2dKMaNsA4HhtuCvsXd/IU7M73aKCBYaDFQSkAjWdazWdsL/JGE+WArO5aCvKQ47ExYxohOQ3WEO57MZITM3TJ8Q==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(6133799003)(10067099003)(18002099003)(22082099003)(13003099007)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XdLDSxTKjfk+HZ+s0WUEZQ1v2jtNyREQmu2jXHkZVykgrJgnpNq4BSx/Ea4kifRlb5Czs4lPAoNZ2YRqkCERlYaMSyIx0rcMC/lTMrSnBPSyUgcPUGRLQMXybR+PfeDWT9hb2Io2xGSEmEQULQVx9j51NJxP8xTgwfdXBSklVxoebq6ferBFjNo19wx0Ag5ZQPrt2hBOLffv2UfSmTa+4efQNYlwQ+HKWy4QAwvfucktiv0MwUCjMy+2+2qvKsTfSR+i2/7Yp3gIDl9M6LtKOQq1tTcW/eofex13aeTIio2urJZ62Ib9c4+Y4uvUwIYeBCTGTGgLdk4/OrwKjQYya+pJLbmTeAAo/zFowI4kl0hBaXd2H/iCraBxEPbpZiPF3g2GJzZS76LReyfOlOsR/n48FQKM80Z6VqRlr8vybtLFei2zZmiGxl/ptErbquu4
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 23:07:07.2951
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 673e1810-5cbe-4e1f-00ed-08df28b589b7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW2PEPF00014679.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB512574

The BIOS Data ACPI Table (BDAT) points to a firmware data structure that
carries memory training results and other boot-time data. The table is
only a pointer: /sys/firmware/acpi/tables/BDAT holds the ACPI header and
a Generic Address Structure, and the data itself lives in reserved
memory.

Expose the data as /sys/firmware/acpi/tables/data/BDAT, as is already
done for BERT and CCEL. Unlike those tables, BDAT carries no length, so
check the "BDATHEAD" signature at the start of the data structure and
take the size from its BiosDataStructSize field. Reject sizes smaller
than that header, and document the new file in Documentation/ABI.

The BDAT specification is published by the UEFI Forum [1].

Link: https://uefi.org/sites/default/files/resources/BDAT_Spec_v4_0_9%20%282%29.pdf # [1]
Assisted-by: LLM
Signed-off-by: Jamie Nguyen <jamien@nvidia.com>
---
 Documentation/ABI/testing/sysfs-firmware-acpi | 12 +++++
 drivers/acpi/sysfs.c                          | 45 +++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-firmware-acpi b/Documentation/ABI/testing/sysfs-firmware-acpi
index fa33dda331f2440..5fb50a72d468f5c 100644
--- a/Documentation/ABI/testing/sysfs-firmware-acpi
+++ b/Documentation/ABI/testing/sysfs-firmware-acpi
@@ -275,3 +275,15 @@ Description:
 
 		remote_region_id: ID associated with access by agents
 		non-local to this range of addresses.
+
+What:		/sys/firmware/acpi/tables/data/BDAT
+Date:		October 2026
+Contact:	Jamie Nguyen <jamien@nvidia.com>
+Description:
+		The BIOS data structure referenced by the ACPI BDAT (BIOS Data
+		ACPI Table). It starts with a "BDATHEAD" header and holds data
+		published by firmware, such as memory training results. The
+		file size is the structure size given in that header.
+
+		The format is defined by the BDAT Interface Specification,
+		published by the UEFI Forum. The file is readable by root only.
diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index ae3b3ee0552d198..7581bb73df8222d 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -471,12 +471,57 @@ static int acpi_ccel_data_init(void *th, struct acpi_data_attr *data_attr)
 	return 0;
 }
 
+/*
+ * The BDAT table only holds the address of the BIOS data structure. Its
+ * size is in the structure's own header ("BDAT Interface Specification"
+ * v4.0, section 4).
+ */
+struct acpi_bdat_data_header {
+	char signature[8];	/* "BDATHEAD" */
+	u32 size;		/* whole structure, including this header */
+	u16 crc16;
+	u16 reserved;
+	u16 primary_version;
+	u16 secondary_version;
+	u32 oem_offset;
+	u32 reserved1;
+	u32 reserved2;
+} __packed;
+
+static int acpi_bdat_data_init(void *th, struct acpi_data_attr *data_attr)
+{
+	struct acpi_table_bdat *bdat = th;
+	struct acpi_bdat_data_header hdr;
+	void __iomem *base;
+
+	if (bdat->header.length < sizeof(struct acpi_table_bdat) ||
+	    bdat->gas.space_id != ACPI_ADR_SPACE_SYSTEM_MEMORY ||
+	    !bdat->gas.address)
+		return -EINVAL;
+
+	base = acpi_os_map_iomem(bdat->gas.address, sizeof(hdr));
+	if (!base)
+		return -ENOMEM;
+	memcpy_fromio(&hdr, base, sizeof(hdr));
+	acpi_os_unmap_iomem(base, sizeof(hdr));
+
+	if (memcmp(hdr.signature, "BDATHEAD", sizeof(hdr.signature)) ||
+	    hdr.size < sizeof(hdr))
+		return -EINVAL;
+
+	data_attr->addr = bdat->gas.address;
+	data_attr->attr.size = hdr.size;
+
+	return 0;
+}
+
 static struct acpi_data_obj {
 	char *name;
 	int (*fn)(void *, struct acpi_data_attr *);
 } acpi_data_objs[] = {
 	{ ACPI_SIG_BERT, acpi_bert_data_init },
 	{ ACPI_SIG_CCEL, acpi_ccel_data_init },
+	{ ACPI_SIG_BDAT, acpi_bdat_data_init },
 };
 
 #define NUM_ACPI_DATA_OBJS ARRAY_SIZE(acpi_data_objs)
-- 
2.43.0

