Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.26
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794351338;
	b=Z71K3y1VLyi+YGievXyYkoS6mQuwvt4A445uTNSDiDrFMxZoD80Yz1USSceJ/igUxFuP
	 l39WTvoYr9ovUJnsdH1Oocxm6QgW9IiX8ZBPIbbCj7+8I1p6fNdggY1NGYq18ro++73EV
	 CFJgDUcYq3Z8pF1ohKC8nGMRciVcWLFlA66GjWbY2wA4BP6gn95s01vag910aYfY8ywgY
	 IHVYvAEYNzNfULnnAPk3t2tBUXsRoCqkkeyhsWdmOTtsgtjU9Tf3XualqCsslntViNDuW
	 bhM7CMR3r/vsMzwP3bEnD5gIZPGXrmZ3DQolo6xEIOeyeYJCU7TJZ+5MOXfi7P2bWog==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794351338;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-NV-OnPremToCloud:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=qVHCt95sGAjJreX4wtYWVJwc30g15ECFxTjPMMz9SSI=;
	b=M3lPKt31nNUPQLVCHaox2j2mLKM7gFcGhd/K07+ztsWgsmmspc+sltby1hydi26DqvwF
	 yQpLQbuW92rEr/eJoNqr3MHqtWza40lNWPOqVUu4kbbZ/RtuDHU0WVFHbbo7MHMwVV5UZ
	 nhO5tjWmMnxYPGAElCTaYK5FO82VI7Wu6TiTA3clf+0T4FDUZLqs5RUsrn7/vxrmDS/pQ
	 n3nMAnkOW4q/PTjeu+ucZmqTM4/9Hr3d4XyI6O8TT5CXq/qiKtoYKNb0ZMhbJT0WPLt/x
	 jAjYWV6lXlu9b+M7kkFDblfWTqlAZ4piC6sHRbbmixk1iQ2cHpZGLf61X/9xnPEKeMA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=SDkrBtlS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.26
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010026.outbound.protection.outlook.com [52.101.61.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52660606A31C;
	Tue, 10 Nov 2026 22:55:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52660606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=SDkrBtlS
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hHOIIP3+y6Ly9W9QO0iQg23Z8AF5BTdczbUQ8UnpVLv8U9mKBxCLwEa8aTDsllzzFgi0n2Jguyasa9PqywIPxKqtWforQAsLDAPTDwmNRml0LrPtB6d1dyDFWlcjrFd+VO8J/9sLUL8+q3ts1odevPf8/0Q3zD2l34Pfniq5x73DLGNkxMmPPlVVqjnhklWSgmVoSmXwSxwUVzAo7Vs77YkgVjlA/RdCnJuPdtL8K0roqtKbf8smrq94hptMdcitB+sZKYASWb7pu/IaDsPsXFVZWQN66oAwZlzqLSA5h2/8knR/NJhQ0tt0ReYh6d9yCtuGeN4cVLmEl6QkfmdKGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qVHCt95sGAjJreX4wtYWVJwc30g15ECFxTjPMMz9SSI=;
 b=B1Pf06JgBKtiJYqJg6ITIQntC8joUcuVx2zGefpi4VbIECuUNcOQ3R5AI0F6FG3OreII+DhBH9aLsMY3gLn/JIxl1SBHnniVObPwOIfhJf2v/0GY9QTP3d6OOKrezfhqRZEQpeggZrcTeY8hBk1qfR1YE7gzbdU2TISsEBq40pWi54BrHFAXL6gObdYxRezIRDsY/pmuRkNd9FLNcWcAxAauZKF9TgQF/uWgCBmxeR49Wsx43nb0kwkpXXuertPv2Rr6wpfIWXHDYf3FN2lwByAifutNfyZnbgJ6R4+2aitcYZSWfAnS4JZ5sHQjeme5jqDHZbHQmWfoKG41OXqxGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qVHCt95sGAjJreX4wtYWVJwc30g15ECFxTjPMMz9SSI=;
 b=SDkrBtlSaWwbbdvUHmPYXcBZqftuzpSrrT8dU+VGRH8HwH6TT6mUDGSrgUZkw6Zd++6PLJl4js862mkx3fQPKnbxW2BQwOIkSDElYyS/TPe70xp7HZnPOSDHkrZvdGIWKKRSHNi7dg+T8Et4wXT0Jlg6mu6g6SfWfggjtYQ5hQNTodFBKm0VwzgVZahu4E7FkPWLvtdYc0d7mJmH/bS1MrkDJAUY87e2OKWn6D4MufC8RYg9opeyJu+N0k1+eArPTQjpVwmjgWV0WKFeadp8RKan0QqwR2qSn4eQb9gxAPJxD0fVDjV/GfRwuqKnA5S5BmiWJzvB/zzcpI5ObBFjxQ==
Received: from CH0P223CA0010.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::20)
 by MN0PR12MB6272.namprd12.prod.outlook.com (2603:10b6:208:3c0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Tue, 10 Nov
 2026 22:55:15 +0000
Received: from CH01EPF000BE947.namprd02.prod.outlook.com
 (2603:10b6:610:116:cafe::8f) by CH0P223CA0010.outlook.office365.com
 (2603:10b6:610:116::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 22:55:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH01EPF000BE947.mail.protection.outlook.com (10.167.244.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 10 Nov 2026 22:55:15 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 10 Nov
 2026 14:54:52 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 10 Nov 2026 14:54:52 -0800
Received: from dgx-1v-42.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56 via Frontend
 Transport; Tue, 10 Nov 2026 14:54:52 -0800
From: Jamie Nguyen <jamien@nvidia.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Len Brown <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] ACPI: sysfs: Release the table references taken during init
Date: Tue, 10 Nov 2026 14:54:52 -0800
Message-ID: <20261110225452.2349540-1-jamien@nvidia.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE947:EE_|MN0PR12MB6272:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b1dcf6e-fdd5-45a2-aa56-08df3f7daf6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|18002099003|6133799003|13003099007|10067099003|11063799006|5023799004|56012099006|261102123227099003|261021121427099003|261022105027099003|261021123027099003|261009223027099003|261026140227099003|261028144727099003;
X-Microsoft-Antispam-Message-Info:
	a1pydUEeLpT8lceLKB8p/QIFvGzskAoA5n4ZUUY4t87lZ2Oa1cUI2b7XCbnv/Fyu+TACr7wUEkWnmNZi68YAHF/JAy4GJ+9GRvQVc/2h7hlTxCacsr5s+p7w6emDLUDdG50Y/F279fLc216dQ49502GupeR9adkgafUJNEU/nG1KlNXtlswXEwC+ZEr9zmcmAGFqRgfrumIrmRnjdyye9/mR4dG1t29YrC1OPMlOPi0uNh1QQDAzREUVpcl8PgW9pqaGBfanv0fXexC9RnFuyhYW5e1oOyqNP2ImL0MDtyJy3u48nQkAIELxpdIMM6LWRqkYDfRznVitnghopPL3mP7Xuv7x2NsYW0KQBzLvRKnjq39nSYY7hfkjPEGQKpe6uxELPtsGCYTAB345Lp+kBVprdhTD2XR+xzLwGk9affQoWFkLPoMBXX3OzEgJ+ouKiagrWZNT6/zz6Qh+Qd/r0FNxXvKLDFp2Uet99kZRDq2ZZN3LdakXtXerkttZd6CBkmAOgmd0j8+66qshGgKLEkOEmvcPHysCPUTV7XpfInDIymLiADmaHCKXcOi8wE1kypj0LTxCGwK1he/g4Uql1goYnFkUvRpmeWJjKXQKVIaq0yebBI85/qE0mLlZ050WkZYsFlTocvsd3y2bxmFWLQ0ftUIJhLbSOUN1dNO3+vdHc2L5jtT5dOo1XRU1POVkN/1XYsD7jGVZAU0wBGD2/g==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(18002099003)(6133799003)(13003099007)(10067099003)(11063799006)(5023799004)(56012099006)(261102123227099003)(261021121427099003)(261022105027099003)(261021123027099003)(261009223027099003)(261026140227099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TpqaUhI5QvagOQQMvNfkTf4pHPP5XL4hzPptw5I9l8QC/78JbIn1HNQm18xsApvVGaAmbx0jwsrThFj1n0JHdN0YbEP0UfoLhdAjCiSs8IK0dcDpYLQsQRJXwEcSLhyF+98gDzMZAj/v6MKBrCDNHj/lN009vcTcoSjPgomZ1+jb1g8HxqpivtTEnTSUbeInGo5WKS+lc2P0Ej7UOkMXCuIWOG7+ZCG7PxKYD4iHj9JjbL/NlHh4rzqH1Zg6TkcXpfA81+GBmBE/HIgcGeqhqmr73Wwa9gyigxyWOF9bJoN9zI974JGavaJ07oyLU7eAUNcjv72sBTcPHkgl1MmIiXzqhhHBmZBCF+fJpkAetlw8Uod65vQhioWRtwS1saATmBri4xeWu81HbQG2czzzD1MmvVL3MDZatOvKem6fML8kTSnQxdhk7iw3YYT8s2zX
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 22:55:15.5206
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b1dcf6e-fdd5-45a2-aa56-08df3f7daf6f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH01EPF000BE947.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6272

acpi_tables_sysfs_init() gets each table with acpi_get_table_by_index()
to create its file, and acpi_table_attr_init() gets the second instance
of the table's signature with acpi_get_table() to decide whether the
file name needs an instance number. Neither reference is ever released,
so every table stays mapped. The file's read handler already gets and
puts the table on each read.

Release both references once the table is no longer used.

Fixes: 174cc7187e6f ("ACPICA: Tables: Back port acpi_get_table_with_size() and early_acpi_os_unmap_memory() from Linux kernel")
Signed-off-by: Jamie Nguyen <jamien@nvidia.com>
---
Sashiko flagged this, as a pre-existing issue, in its review of a
previous patch that I sent:
https://sashiko.dev/#/patchset/20261013193900.1258808-1-jamien%40nvidia.com

With the references released, a table that nothing else holds is
unmapped after init, and each read of its file maps it again
(acpi_table_show() already gets and puts the table).

Tested on an arm64 server and in QEMU (x86_64), with a test-only change
that prints each table's validation count after boot:
- Every table's count is one lower, and the second SSDT's is two lower,
  since the instance check in acpi_table_attr_init() also held it.
- All table files read back the same as without the patch, and
  repeated and parallel reads leave the counts unchanged.
- The BERT and BDAT data files still match /dev/mem.
- Loading and unloading SSDTs through ACPI configfs still works (QEMU).

 drivers/acpi/sysfs.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index 49a820b39c2917a..d1b57d1246aafb1 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -372,6 +372,7 @@ static int acpi_table_attr_init(struct kobject *tables_obj,
 			 table_attr->instance);
 		strcat(table_attr->filename, instance_str);
 	}
+	acpi_put_table(header);
 
 	table_attr->attr.size = table_header->length;
 	table_attr->attr.read = acpi_table_show;
@@ -593,15 +594,19 @@ static int acpi_tables_sysfs_init(void)
 			continue;
 
 		table_attr = kzalloc_obj(*table_attr);
-		if (!table_attr)
+		if (!table_attr) {
+			acpi_put_table(table_header);
 			break;
+		}
 
 		if (acpi_table_attr_init(tables_kobj, table_attr, table_header)) {
 			kfree(table_attr);
+			acpi_put_table(table_header);
 			break;
 		}
 		list_add_tail(&table_attr->node, &acpi_table_attr_list);
 		acpi_table_data_init(table_header, table_attr);
+		acpi_put_table(table_header);
 	}
 
 	kobject_uevent(tables_kobj, KOBJ_ADD);

base-commit: 39e3c82b333ee534b6c41cc0e07364d78bea0ba9
-- 
2.43.0

