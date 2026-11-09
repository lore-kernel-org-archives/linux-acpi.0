Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794249520;
	b=avn5Iv+XlQOc5KKW9f5FwaL6RDuas3uwGxoGoKGxsYFgycD6cMawDk5a0+EwKJN2b15v
	 UD2NjxkumkfXQkzDvBt1l6o+BLDiLQRuQi7phSIw/unkZyZXojVF8N/xCIvLJxCBCiv64
	 cOYyS0pDS2p/f9ky32on9rU6owBHdiLsel6HgIhVZfXJXIP3SYmyhkbfDPiB7PHWIaYen
	 jUsXEADvCp/EtY3Rk9ua8jsdxhyxzy+Uj60Fpmi32NE2wDOUJYJL77ovF0e1/UEI6+R37
	 qLqoRjyC/mhfGttKkL/O9+qpAorGy4FJi0gFON3j9fsVLbrNE5Hl33skgVN55M6CR0g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794249520;
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
	bh=gKaB9R2OKff6LFUuTvA98CBhQt2+BUdY72grWraHZSc=;
	b=rbdI/JN+UV4o2wj5rPpSXn9of9m5sOmtra8ROeXt+W9gkNcIh/FwRa7whLWwaTur3rwi
	 9xyzkjLoUMtJtOuAsrRMI2xsmYsh54o+JX/OczfMaiZUl3w0gNQ7Z7BWpJxZ47ZnQIA2U
	 L2t1wXPZJFbkgiszrNQNQBjiLnqhxYxX6+yoCZ4o37t9/v+EEpOA+bEAZrIGsB6upJW16
	 iAysce7S+varb27N0QfYHDrvQOGoKB2XeOdoXX4POlS9+x8aQqQKwCIbOzUFs0SoXSvqq
	 s0HU77nfo2k8NQWmbYb/HPJ8cWUDcJQvn2H7bBDDrzLlU2ysM3ulGOqUWJAtOgDGfDw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Sv0FWWZT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.19
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012019.outbound.protection.outlook.com [40.93.195.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25DD606A31C;
	Mon,  9 Nov 2026 18:38:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B25DD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Sv0FWWZT
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KQoqp0/XILFcu0LEiYOGEsB2Ay2d86Nit38uCgl4h4PCVAKeEgupEw8qpE+9ilcOq29rjnFg8oiMti824Hzvd6MNsuWGrDGxE+96badGMZbybPtPD5cTQZH0ZTg0SE3J67sGg1L6vwr7i69j1U3DoKHB5mxcy90SdpY/rRBIkaIhqi8TIseaSgwW4lzb/da3GG3ws7ud4rCBfvhbx9yGUya22u3kOatpUpQl5fSRNwSBnah3BMykSZkXXH5rhRLnobZbJYJCOXSXSJ/oDvgtP/suhk/AsBURQwLAvfJQkfhBjTU7wOE3RRFBTse2kFTr7ZV7zRUnNtKXiIZrQ53szQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gKaB9R2OKff6LFUuTvA98CBhQt2+BUdY72grWraHZSc=;
 b=g4ytD7SpBCErMLoLVdfLbabk84Lfauryarcv5roVzDYKX4xoS382b1mETu2iNv7qKxQFsjZdYefwD8Cwv6+bspvR0CGXxouyHPBqEG2aDLdSaUfK9aPKcuR5b5va3+CoZXvQrpYJqAWUKyWWv3OmVH3Bp6sGFkA9ZmjF2tNDiuXrexfYjITysNmjwCMvMj/oq8xxeV+QHsIduB9wD3VmYytWCCiU/4OOLzu+WUtYW3aVvhtIqXgS8qkwWc+0qZAjZX50zWc2Ejq4HX1jisYoWkgiqU2uHwq2Yse4G1MaC1GjyYxLkCr8L052SctDqjd4Zrmg/5hzy7mta0zkRHbKDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gKaB9R2OKff6LFUuTvA98CBhQt2+BUdY72grWraHZSc=;
 b=Sv0FWWZT7Lftsd3OHSmXqC74hF88p+KUFxd09s8QwvLdt/yPt9toVoP2Qi0bhA+z/Ktm/jocqBKBJcqHCAizE62F2CS/Qv4ct7UqW4EYgKM8ePVe9YlWlAHIC3RKE6QtQHqYcsIGXOCWg3+jWUVDgSHV14l4XfnlXBrB1M7f5W3fqNVHtit9XLgz454cxV6evsFhsaIkhuIbBbzql2s4ouHpgtvP3TiM7NBBoZrZEHSKmfVUcb76cCGNsTvuaf2sg92OWX77p1qq64/L5w3Q8DXb2VRVyXqu/Kk/NOa5cc2u4KsxfCiUm0WC2oCaS122fDpBCeknD3n8JyykSrWmnQ==
Received: from DSZP220CA0023.NAMP220.PROD.OUTLOOK.COM (2603:10b6:5:281::12) by
 CYXPR12MB9443.namprd12.prod.outlook.com (2603:10b6:930:db::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.13; Mon, 9 Nov 2026 18:38:34 +0000
Received: from MN1PEPF000793FA.namprd05.prod.outlook.com
 (2603:10b6:5:281:cafe::8a) by DSZP220CA0023.outlook.office365.com
 (2603:10b6:5:281::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.24 via Frontend Transport; Mon, 9
 Nov 2026 18:38:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.233) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MN1PEPF000793FA.mail.protection.outlook.com (10.167.249.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 18:38:29 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 9 Nov
 2026 10:38:03 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 10:38:03 -0800
Received: from dgx-1v-42.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56 via Frontend
 Transport; Mon, 9 Nov 2026 10:38:03 -0800
From: Jamie Nguyen <jamien@nvidia.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, "Punit
 Agrawal" <punitagrawal@gmail.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 0/2] ACPI: sysfs: Expose BDAT data region
Date: Mon, 9 Nov 2026 10:38:01 -0800
Message-ID: <20261109183803.2724859-1-jamien@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF000793FA:EE_|CYXPR12MB9443:EE_
X-MS-Office365-Filtering-Correlation-Id: f8fc5b49-60f4-45d1-be0c-08df3e90a63e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|82310400026|36860700016|5023799004|11063799006|261022105027099003|261021130227099003|56012099006|261021121427099003|261021123027099003|261021135927099003|261026140227099003|261022075727099003|261021133027099003|261022115727099003|261022113327099003|261028144727099003|261026121527099003|261009223027099003|261026130827099003|261026135527099003|261102123227099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	xKica3UyB28OrBT8Pe1yPKUXMEDrSxU/kHLy8WqlDG5zfaMT49pTbVBN7L/majEQPrC9TGuK4inhDqtwNw4xsXAqRM+X/V0G7EAibsk12Te4J1Jz7PkIcFTetuoIunzH/hII6/ayRkXGSukPowkMrejlTWK3sgWKTvawe7ypxPIJ6zTfBWnwE4BUpW98N9Q/vDJrxDg/Dd2lvMyPpXTjRD3HMGRfDBfN7wJ7RIWbnngz9ZqNIzsY7MNjY+xFh+bOHZcA2tPmU3mq0l6JBb2+/j+u7JFO7ITdXJEBGIV5oBNuYK5IwbSrSgrclohaFDbnOMJqieGUyYPBtMaw3qlK+LMYn6omh7p+oxebtSn+kmMhJlmrHOj21OXaYKdQOOYYiIhjI48Dwk6TtcyRNknThcA2lQSFdEypzoaY3Ri4ZxfpCUjJ1fIpZFpGbp69Ue8fRAuvfKzI/Jdo1/indgyumWttSz4eYW90ln/wRufbcZ8KG/EYvTkiKhX15NFsb8LlBlsQYALrg6OH96GFeVssQUDWG8PwIpFM7oJEFplvO5/BlHoTi7Zh4pHJEA04G1SA28wqAezhLFa4BpmAEZRpgY37Z4/V6MJ3++7Pgkp4EwZHfGHdRHdc/xczORshxfoIAUN/WQ8usfY+edV/V+JfoJRfrCiWlecvTfveO58uMWfHq2ayzgsqsoewkjobB704F5fTEm/5wIcDrXm8phpozA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(5023799004)(11063799006)(261022105027099003)(261021130227099003)(56012099006)(261021121427099003)(261021123027099003)(261021135927099003)(261026140227099003)(261022075727099003)(261021133027099003)(261022115727099003)(261022113327099003)(261028144727099003)(261026121527099003)(261009223027099003)(261026130827099003)(261026135527099003)(261102123227099003)(10067099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	eiVb++xmHjVLYfxt/CAxgUDLC9AVZvaMboEFkIQNQSGEy+rGgt15xHFAA0Ra0Myn9ljHAPPFAhWng5VLEOouMUj4ETMgAw652fqDAkq59hpSJhUFvj54fstM1VsoFjVF1bkyZtR8kZ2qPy5ToEariNBJ9xJOiMP6qFfE5gWb5hbAUyPyoS5umZBsDw4ckd90JUt5nRreXphFes9U7l4ESJ7GO0AoOvROvY3shyQt04v8UygKGkw3RyHZlFbRrN1bqKJJqikQVNB8PtsqlNwpdrBCt5l/A+fnBo0XrYsOrGggkMGuXDoyYMZdAUSG0UXqkQg9A7BYrYIZbmv9VtKyViog6FG5EHQn1ivMPFkJYb72r7fAgpJNfuCgQvhwwRrxAb/93FIzPh+a8EN4KUUT8NdPLYywoBJgvQLqHnpZG8J1CptMuRkcG3HirzdX2YP/
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 18:38:29.3414
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8fc5b49-60f4-45d1-be0c-08df3e90a63e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF000793FA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9443

The BIOS Data ACPI Table (BDAT) points to a firmware data structure that
carries memory training results and other boot-time data. Patch 2 exposes
that data as /sys/firmware/acpi/tables/data/BDAT, like the existing BERT
and CCEL data files.

Patch 1 fixes a leak in the existing data file code, where data_attr is
not freed if sysfs_create_bin_file() fails. It moves the file creation and
the cleanup into acpi_table_data_init(), and patch 2 builds on that.

Changes in v4:
- Patch 2: before mapping the BDATHEAD header, reject an address where
  the header would wrap around the end of the address space, as
  acpi_data_show() already does for the data region. Found by Sashiko
  on v3 [3].

Changes in v3:
- Rebased onto v7.4-rc1, which includes the two fixes posted during the
  v2 review [1][2]. No code changes.
- Dropped the "Assisted-by:" tag as per latest guidelines, though an
  LLM was used to write, review, and test this series.

Changes in v2:
- New patch 1, fixing the data_attr leak for BERT and CCEL as well.
- Patch 2: the BDAT callback only checks the table and sets the address
  and size of the data, and returns -ENOMEM if mapping the header fails.

v3: https://lore.kernel.org/r/20261109180945.2438349-1-jamien@nvidia.com
v2: https://lore.kernel.org/r/20261012230632.3574987-1-jamien@nvidia.com
v1: https://lore.kernel.org/r/20261009232955.866131-1-jamien@nvidia.com

[1]: https://lore.kernel.org/r/20261013180728.957618-1-jamien@nvidia.com
[2]: https://lore.kernel.org/r/20261013193900.1258808-1-jamien@nvidia.com
[3]: https://sashiko.dev/#/patchset/20261109180945.2438349-1-jamien%40nvidia.com

Tested on an arm64 server (64K pages), with v2:

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

Tested in QEMU (x86_64), with the same test-only change:

- BDAT tables with address 0xffffffffffffffff or 0xffffffffffffffe0
  are rejected without creating a file. With v3, the first of them
  faults in memcpy_fromio() at boot.
- A BDAT table pointing at a valid BDATHEAD structure still gets a
  data file with the expected contents.

Jamie Nguyen (2):
  ACPI: sysfs: Fix data_attr leak when creating a data file fails
  ACPI: sysfs: Expose BDAT data region

 Documentation/ABI/testing/sysfs-firmware-acpi | 12 +++
 drivers/acpi/sysfs.c                          | 74 ++++++++++++++++---
 2 files changed, 76 insertions(+), 10 deletions(-)


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.43.0

