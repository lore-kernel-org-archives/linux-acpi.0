Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012058.outbound.protection.outlook.com [40.107.200.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CD839934C;
	Fri,  9 Oct 2026 23:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791588623; cv=fail; b=Tiq9hUr/Nm5mx61ViMRGEYqxjfOfntfubuKjJXfi9qmBF+yq448vqeAuO6kORjIiBA4rZRyZhs6qy+LT5ef0w5UuYaa7/5gm47NUtd6TUE1YXzpkF3rV3uDWLRVBMKrFQKoT3yAC2v53VvKbQFQ8v6VS+XnNWSyZopXpm/DlO+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791588623; c=relaxed/simple;
	bh=GQ9l//ATkngfewmWYXCFWBnVSW4bDyNK3BDAQgOiCbo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XTyqrD6R5QW2I+lYpo7qEJzZH0bTpZZ1hn16BOJLx6fATQSJaVCtSwP72gUfnju7TbcE500D2MLXtcByB2ceyZbnSOhmPUkAKv2Jmvb1F7RZf5bJmJTfCfH3MAI7F8HlSbMCPUhnP+kfyoGFL7nSt3onBzy0nx6JGgzszejTNYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dVPbQdN2; arc=fail smtp.client-ip=40.107.200.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dVPbQdN2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Et9ooWSKAWjIxWCIWy9O5+ndh9f/UoUC2vSWkSbVy48EFUBYLCXenf8S77BM/2Vd4cZFZwsyoBShcufMIcVgNy1H7yQz0nMhb85oAk+uXXze3vt/YRBkkgZiQ0RHELOyu4ea5woXPd5BVyUoCkEcAdp0Q6d3az4QEHlU3fAkGsEoYeS9LyrqGPWXZm6bRITS/W4hMGoM6cQQvCxrz7xEEiJFCDJQisjJ4AecTUFStANrJ8PSWQKdQ8HAkkSnaRQdSRTTFPXhrNQI9KAxvR0lsuNbegOr9MTDMMoOH3iZyZrDQ7f2hE1R9lbdfGz7hevi2bZ6LtbpuOATLU8eg9LN5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=22DsjoN+ZO3vVdHXjOMDUZmrAzuXkxhiNN9HqvQq/E0=;
 b=bAfrAFgTK018Zt8rb1LdA4xZFDbTZiR4xdL/i+yE4vSjn+yvMFQe3d5FsyE7uJH+27FaZFRSoMKdX/jgvOIwOGdk1qnktDUIsTZ6hWOe7nanq3bdzS+zLfA28cKaeNvvypziDlClDXfQHzNAT7f095dG/rpa4NmN0T5wpFuzQ/hBqR69UvaOdKcPJGwFR0874MJHUvD7bYdSSZL5BypLDM98WsMqCoxoelFMFywXuxKev7LK3Q988ncOzqFz/UmUoFgB9DMqRh+GjYsbgYvSPL45RKoYM6Ncaqyt0RgR5LiamzcA7vS+RBbkPmOMzoY3sPjD7ZA89rACDkYIVoHwbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=22DsjoN+ZO3vVdHXjOMDUZmrAzuXkxhiNN9HqvQq/E0=;
 b=dVPbQdN27PMvUdXysa6yWGPQtaaIIcpuQGCZJDuV7C5s5Z/x2h3/tpprilBD8FoaqQ5JSb1clMPCsBRhXpVDLn5YxIBRDz5d44P/c2A7vpWtC2dxP1N1hKT7TgkltmysobCwyshpTphbqJL0J/g8+Vz+JgnWCZEk9JlzG1nBgsW52yViBnAiRSuSjO29egEkgnXX/OAsqHH/lIA7wRv8FMn8cxlVPHARS3wbHB2xjsCMursLzHoUbEOi6pkGdPobmnceb2nfNVacTYyBFljdI23D4ZKuByQYqTxgOHwbjERWhnOeXUDmte+n92wrq0rWwFyWJID9Z7s+rSxteLotbg==
Received: from SJ0PR03CA0096.namprd03.prod.outlook.com (2603:10b6:a03:333::11)
 by BY5PR12MB4113.namprd12.prod.outlook.com (2603:10b6:a03:207::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 23:30:16 +0000
Received: from SJ1PEPF000037BA.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::92) by SJ0PR03CA0096.outlook.office365.com
 (2603:10b6:a03:333::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Fri, 9
 Oct 2026 23:30:16 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000037BA.mail.protection.outlook.com (10.167.244.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 9 Oct 2026 23:30:16 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 9 Oct
 2026 16:29:56 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 9 Oct
 2026 16:29:56 -0700
Received: from dgx-1v-42.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Fri, 9 Oct 2026 16:29:56 -0700
From: Jamie Nguyen <jamien@nvidia.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Len Brown <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] ACPI: sysfs: Expose BDAT data region
Date: Fri, 9 Oct 2026 16:29:55 -0700
Message-ID: <20261009232955.866131-1-jamien@nvidia.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037BA:EE_|BY5PR12MB4113:EE_
X-MS-Office365-Filtering-Correlation-Id: a3189ad7-aa55-43b0-18b1-08df265d463e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|376014|1800799024|36860700016|6133799003|18002099003|10067099003|13003099007|261009223027099002|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	J+fU/55fdZKtIw+0lHdhjppwyFIZMJsB8tLVidsVmPyYKhsiat5suXAkdbdh1tHRzfLIWZcBvdNacwIBt4GDhubu+TPR4w/vhzuT8KL+r+KbzQNXnmY5pv/1cPNuF+lnmUVQoKIEsiOyuZUfbMVI8fRl7XxG6Vg5GQg0BYoK62VuxieLI0TxFOJ+vI2GrKW2/xz8hzZYd4nwW5GW+PRoP5M6ev34MiTELi8YUCKRhimDMzYVpU485Gk4SZ5lXVEjctqdhbayuN5XBjmME7BUF2MP5gB9kH97pmOY0jLpAOReV30BGGa7VSlI906YKDkS42WpVQmzzn+XTVjZ5/BnJxDDPMTh3CM6bGJO75lmPtmjiG/OQ5A+cwaOqbsg/I86flIU3j2bVF9MUtVLWFeZaNG06aoFTswRjaK3q6W5ZR0XMnFsr8j7O24TqHbE5qE7nu+fu6ikZglGHs5iArqO8AKxQcW7YH3+5CJ5riqYb+/gH9U6gYrkyjnqRZ9gpem7QOeSoLEYgdBsvPNdKlSlUuqjQ+RWNy6emzt0ykr5IM+t7iAChpAiaxcTOHO6Hq2513Gv1FsUkzR9jYoIKhH1t8OT4X3jPMC9cvx6l5ovl056ptFG4G0MtXKc3AeS7m2gZeN5j69a/D4G2+wm0ECSDkdDzudGFZI8FVpXyiqz6sgqEu2bNvLsP2+MuSkBWJogk2BK/zi5c2x6PVF2JgzGLg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(376014)(1800799024)(36860700016)(6133799003)(18002099003)(10067099003)(13003099007)(261009223027099002)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9WsJ5K30AvWy/rqfzMXxZffVBQ0BVNZpykOAA6Fl68g98d3Rmrr22uwUkkd117VNRl5ot2zwKnTt6SaAhPDZj3pYTG+Axi4IMIWNdQBtKjtvqhpPnN1aHJtjzYWIAopMd/Ac1TSKjZ8F7AimSWUdv6icKLIpIJ9awH7ITUDwXJ2E89eGSf1ueXS1TiE9AxaWD9XMHQEWNDPV4u8BIzGN1BAqWZVdez/OOS12nMXWMWSBASuAMxWDKQazRFc4BEMBAM1QSbXysKllHXCS0JPPS0T8tMkCLUxNrEFMokcRCoVa8ndhBNz/HLqGy8EASPa9nFAn3RRj2Q8BLjdjo9njGkX+4taMxNchwutgFcej2Jss3R+H5+vH9dsdu7Qg3hspQ1/6Fs+2wHr9oMuorMb6ZN02cIxaqECt76FxXVchBTGb6z3PdTPIwBgCB6B0KKJ9
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 23:30:16.0558
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3189ad7-aa55-43b0-18b1-08df265d463e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037BA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4113

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
Tested on an arm64 server (64K pages):

- The file matches a /dev/mem dump of the data region taken in the same
  boot, byte for byte, and decodes with valid CRCs.
- With lockdown=integrity, /dev/mem is refused and the file still reads.
- Malformed BDAT tables loaded via initrd table upgrade (test-only change
  adding BDAT to table_sigs[]) are rejected without creating a file: no
  "BDATHEAD" signature, size below the header, non-memory address space,
  zero address, and a table shorter than struct acpi_table_bdat.

 Documentation/ABI/testing/sysfs-firmware-acpi | 12 +++++
 drivers/acpi/sysfs.c                          | 49 +++++++++++++++++++
 2 files changed, 61 insertions(+)

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
index dd4a99f09efea65..9d02733013996be 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -473,12 +473,61 @@ static int acpi_ccel_data_init(void *th, struct acpi_data_attr *data_attr)
 	return sysfs_create_bin_file(tables_data_kobj, &data_attr->attr);
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
+		goto err;
+
+	base = acpi_os_map_iomem(bdat->gas.address, sizeof(hdr));
+	if (!base)
+		goto err;
+	memcpy_fromio(&hdr, base, sizeof(hdr));
+	acpi_os_unmap_iomem(base, sizeof(hdr));
+
+	if (memcmp(hdr.signature, "BDATHEAD", sizeof(hdr.signature)) ||
+	    hdr.size < sizeof(hdr))
+		goto err;
+
+	data_attr->addr = bdat->gas.address;
+	data_attr->attr.size = hdr.size;
+
+	return sysfs_create_bin_file(tables_data_kobj, &data_attr->attr);
+
+err:
+	kfree(data_attr);
+	return -EINVAL;
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

base-commit: af32da41b0327b9c6a37856ba82b6760d6c8d10e
-- 
2.43.0

