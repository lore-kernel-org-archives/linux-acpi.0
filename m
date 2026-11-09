Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.4
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794247818;
	b=ouzs7UmvzWbDYo1EIk9iNyz03CT5pEm1frF60Mhgvv02ntqMUNDZsdhkc5v1W9DEIvsG
	 ZYB6wcbm+V3+qsr4J3+Gn1TstxJfT7gZpENY2u8OKph+9Dtv6Y3R2phvwgj7OFw0ntPeC
	 i9eKE1Phv1MGitw+Uc7yuf3rXlubihflnSWRgRpS0xHoNfgw1CRZUKekeu+UFVfN40tnt
	 3h3UiLs7ML93QeInfTNw+J+R5sBLemSdSdt2WCimSS1iYNY+ps8WEdc3TJodXkdE5Vmo3
	 F16ddtHgL8J7GMVRC5p6pcFgymI1ul+MUUZ5fhzKW5fm6woMwPKZ8wj6gpdR51R3Lsg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794247818;
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
	bh=qmUQVJ1/H4AFL5P+0d+cBU6nIOY0WzZuSEBR6lgSQ4w=;
	b=MSbn54GnP+JGr5ytWlwxl6e01Fv46Jxd/4hx8OffhMurEcCW0W+7iaoI1n7bcC1q9/RU
	 XGpz4ynMw2cGQrbceG3yXOagoz4ihigMpz/dHaKy8by/0WO7BH5ua6BRkr1f0QqIq9rWX
	 1fYtaapNya4s9oDs11QV9GNTaeAk8vWhdIlDa4SUJFNp0nWq2j/F1ItDcTzXN6aiQGMYW
	 3cdmcYdeUL1G+frlg2khCICgEM7ZOBCHCaZDSqXIpfvgbdFHbVTDVaqpoLNCFyMbhylva
	 rEWQcMfBIU+O9WtB1M+56ubuyBv5epx7x3KRVx4Ux7mepRDCGX66b2STPdMFJp7xLlw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Tw4BfbtF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.4
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010004.outbound.protection.outlook.com [52.101.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F72606A321;
	Mon,  9 Nov 2026 18:10:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79F72606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Tw4BfbtF
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CZp1Xdoni+bdckqej+ZV0pOug/6AmoQkPMoB2xbd1yf5sLUTiCPmgTlKHEw/7BGalRngSFF8pkFAp4StcOpQp2aq+q8kvH7iRHVvreaBbpGZC0h4QmelxdMrd5Obgv24IrkRMI1V0mtXuj1dBNtD1okmVevyE6mwhH+KVlpTMFmlsAyJXnPA9iOQZpmaSbAaJLC1ta7RG5lZlkhJIa4IQMh/7KT1jXnQ/BZ62k9wPr99e7nAGY/TbaKg4rmZvZ/gf20AbTBW8kxk6rhCkMs5Y5WYJFg/rtOWfSejSxCdXNP4SwaXL1mTO8nYwYM1ytnOQQcBGiTnZ2Hvvq3ObcsncA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qmUQVJ1/H4AFL5P+0d+cBU6nIOY0WzZuSEBR6lgSQ4w=;
 b=p1YTHO96rdRRuaRn0n1jWDsCDXxiJfXLvutyA0iS5clDI4WwTIOM2JtIz4UqOcOihN+dwZ6aFRyKg3gO+sFcgLqk6O/Vgm1DFw2dNbD7JrArGueQbczLfQ+b622uQY0E36xpPy2bGX61tkLHvYfsvbYnxejYRUMIBRpTcmMrDN6QyVvZ2ZorQF9uXBb0m0ymLCfFMsD9rdxswuH4tEUhGx80lxAwJ9cjlsuDa3yPsu+WZKu4ArcGjkhHotjY4kUia7H1/EwnfGtP43/IPL6Mm1yJ/ms1VRW+dn5wiAKJcnfowbE06Ai9MjYiz+n3ewl1Bcc+yAAvxxVifeHRT/VLOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qmUQVJ1/H4AFL5P+0d+cBU6nIOY0WzZuSEBR6lgSQ4w=;
 b=Tw4BfbtFUbVlzMO1F+ZhXuP2kM13IvUr4zngWIPWLR269ucRy6srWle0dHfE0ANxk8OQax3zU8a0wyF3XynF6n3ZUtDm3dCicAYn3BY0fNmI0bEHJ6a/3USkb7kH+FK/o1Homvnl+jcASnIGtH8ieLHUkiqTblCY5jB13iE7P6xE6rC+Tx2+Eiy0okmBzf1TMQdOpA9vuEDyqZGUTXx1+uw0ybhyZCr00zX6dFUZ8nfQCJn2w7ohIFw7gsKfBtlK20/pmpn6Mhd8pFLCPeVVyUZg849TbUCoNY2zUSTjLUlFOR5qakyBmNzKTWJ52YqGNUNOqG4E8EiCJG8IK9QZlA==
Received: from PH8P221CA0038.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:346::9)
 by SN7PR12MB7810.namprd12.prod.outlook.com (2603:10b6:806:34c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 18:10:08 +0000
Received: from SJ1PEPF000037A1.namprd04.prod.outlook.com
 (2603:10b6:510:346:cafe::8f) by PH8P221CA0038.outlook.office365.com
 (2603:10b6:510:346::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Mon, 9
 Nov 2026 18:10:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000037A1.mail.protection.outlook.com (10.167.244.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 18:10:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 9 Nov
 2026 10:09:46 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 9 Nov
 2026 10:09:46 -0800
Received: from dgx-1v-42.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56 via Frontend
 Transport; Mon, 9 Nov 2026 10:09:46 -0800
From: Jamie Nguyen <jamien@nvidia.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, "Punit
 Agrawal" <punitagrawal@gmail.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/2] ACPI: sysfs: Expose BDAT data region
Date: Mon, 9 Nov 2026 10:09:43 -0800
Message-ID: <20261109180945.2438349-1-jamien@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A1:EE_|SN7PR12MB7810:EE_
X-MS-Office365-Filtering-Correlation-Id: 7818b11c-f3f3-4073-6ff3-08df3e8caff0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|261009223027099003|5023799004|11063799006|56012099006|261021121427099003|261021123027099003|261022105027099003|261022075727099003|261026140227099003|261026121527099003|261028144727099003|261102123227099003|10067099003|18002099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	Dl7jB9MkehcvWLFYZ2BW6HvNLaHd4rEmtpfbi6tPrlNtTFclvxf1uHA5z8NBqC7dThXtHLWVm5J8NYtLEs+7LQE22Qdx8Q6L4rEu1H0O+cUG7DZGKthyu/1L18F1KaEK/9CpTtfvxtHGe/21sszVLgx1edYau50V2pLJxA5m03Akofq1ZgRWzkXbtcV6G3pAZPpp3qECq9g3EJVduVIuX9Y2Ujwc04iRIRCIA7xbFj6mRR1gspC76TTgIj+nLXI4eefsAcUxmvrEeOdt+k/0cqFGPy85PskEufL/vmiMNMhP3kczYUxiySwKBBLaIl9dHYkxbvv8pEyTmtd4t4cHF5Z8E6ojNH34oa55llFwmyhFrVAxs4YvZ5ibszsORphkRVgW9Zdt0ZL36Nn0fZwyZfj1mjKoNpYcSSN5h8aXtnuhxVyNUsRdb9zpRpbOcfNUpgO9SoYJcu1tNAaJUbwNxSIwwqJvemYB4FTaR8psWaqRe5JNXGst08Zw/rMOcy5ORZRFJ/djpOEuC2H7zxoT2UfEwuRivgAuuBrSXtBVbxin1Zkq9WB23hNMvU2F3WnOEZzx+ga06ey5xZuesOiO0KR+VukCwoNNX85c5n0odH0m/G85jNZ8nVniwjARNRm9OdKpk4+a+L9p3aD35TGhLNDGF8pxh2Ui9G/JYRJpEpbS1QhHRlEV1O0lvyldY+f7SnCpx0ZYbQiIYeAWmuSjcA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(261009223027099003)(5023799004)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003)(261026140227099003)(261026121527099003)(261028144727099003)(261102123227099003)(10067099003)(18002099003)(6133799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	oDjiaQHeapXyHZhAxtKpEIcOXqcBF6IIlaov+1z7VU1Uz9SnOCs6l0E5MC9CeRUP3iqdwQnINpBmKEiMmEaPcPCo4UGbXVz7sOIQkNPfcApMW2x5Nf9z37q5sSziDJkBg2nREvvzZwrigSXlhqRrSCgJK7petR/89QR123royynKcYrwHOzDjhK3LHoPk+6l/HHskqnlfc1R1VM6TfHHg/10rk5H0g/vF4RwO3ExmhxEfiERVYrrHw63vi0yxh02Dq7mAW6s66Sc9G3bzvbaK0oi9KjwZXJzG0O7B8Uii76cMhZVRibPXU+eDg4uqMucLIetH6De0u8z1Sn3zS3W1/XtJMrp83mg0w3wAvqf/NdFTIzoSTqNmQwenAej8l6YubiIaTulRCYwTnmzvxrA6KoJgYzZSzEipsiJBxDmxVyseFUrjgE7z4WIkTLQTLdC
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 18:10:07.7448
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7818b11c-f3f3-4073-6ff3-08df3e8caff0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037A1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7810

The BIOS Data ACPI Table (BDAT) points to a firmware data structure that
carries memory training results and other boot-time data. Patch 2 exposes
that data as /sys/firmware/acpi/tables/data/BDAT, like the existing BERT
and CCEL data files.

Patch 1 fixes a leak in the existing data file code, where data_attr is
not freed if sysfs_create_bin_file() fails. It moves the file creation and
the cleanup into acpi_table_data_init(), and patch 2 builds on that.

Changes in v3:
- Rebased onto v7.4-rc1, which includes the two fixes posted during the
  v2 review [1][2]. No code changes.
- Dropped the "Assisted-by:" tag as per latest guidelines, though an
  LLM was used to write, review, and test this series.

Changes in v2:
- New patch 1, fixing the data_attr leak for BERT and CCEL as well.
- Patch 2: the BDAT callback only checks the table and sets the address
  and size of the data, and returns -ENOMEM if mapping the header fails.

v2: https://lore.kernel.org/r/20261012230632.3574987-1-jamien@nvidia.com
v1: https://lore.kernel.org/r/20261009232955.866131-1-jamien@nvidia.com

[1]: https://lore.kernel.org/r/20261013180728.957618-1-jamien@nvidia.com
[2]: https://lore.kernel.org/r/20261013193900.1258808-1-jamien@nvidia.com

Tested on an arm64 server (64K pages):

- The file matches a /dev/mem dump of the data region taken in the same
  boot, byte for byte, and decodes with valid CRCs.
- With lockdown=integrity, /dev/mem is refused and the file still reads.
- Malformed BDAT tables loaded via initrd table upgrade (test-only change
  adding BDAT to table_sigs[]) are rejected without creating a file: no
  "BDATHEAD" signature, size below the header, non-memory address space,
  zero address, and a table shorter than struct acpi_table_bdat.
- With a test-only change that makes sysfs_create_bin_file() fail with
  -EEXIST for one BDAT table, kmemleak reports its data_attr as leaked
  without patch 1, and the data_attr is freed with patch 1 applied.

Jamie Nguyen (2):
  ACPI: sysfs: Fix data_attr leak when creating a data file fails
  ACPI: sysfs: Expose BDAT data region

 Documentation/ABI/testing/sysfs-firmware-acpi | 12 ++++
 drivers/acpi/sysfs.c                          | 69 ++++++++++++++++---
 2 files changed, 71 insertions(+), 10 deletions(-)


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.43.0

