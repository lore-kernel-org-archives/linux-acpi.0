Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010006.outbound.protection.outlook.com [52.101.193.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB18252F28E;
	Tue, 13 Oct 2026 18:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791914917; cv=fail; b=n4Mi4BgHGZrdXnCEY3dmcKio8eLLNTN1wV83+hTEnRB2PlNpqkZDbChjeMjU3FoFvvU1nS/daNPd+Tri8Imh78ZLHNowpIfXWLuWep7qwLqzmZHFsOrrG/ggujSonbtBrvZqaoUS08ul7CgJ1rcPjsWvY4Bl88WZMu2hBlyr34g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791914917; c=relaxed/simple;
	bh=JnFrKGG7pHERl8QfIKLhemrAJB6HEjM50WSfitq6E2o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WU8Yt8ZWkj3xYV8u/o6cMptBVjQQvjEK3D0lRTFuH6hhReCk6FZ8DbD3goWsXB3U1RlFVWiBtZgQRrZJijw51EQtuURXujPpMCQBomuawJ0gk0ICsladwNe8zhByHO3wxHWyG436011yB9g5D+MmilNiXHzYpF7LUYNJFUG9MlM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UMFD54uN; arc=fail smtp.client-ip=52.101.193.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UMFD54uN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hW54JZZ2PKy5w3jprk6/5l6N4iwEWYUty7SdbIbAidiyGQjLT28IJP7wc9OeG0pYUHsQwR2FNQJikO0cm8SAmnIkeeDQo/iB+RMA4wCQCuksQOmzWvu42oi2uYi9nelZkIV4kvn6Y++nXg/fZ2V28rRx8OTiPQxNCLt5hDTwgBAD92fL9ieelT5Wi/3Z6JOAQFp5dcY7eqd2y1vlIiuMM/kVlr+ltLog1VbDk/YSSHldD4IGaN6uRBZdXqKbdnTnLGpt/I3jffGWIpvFtAbreWbCMzOvYejhL48dBITMx58cuBwyzW9+x6XGrfGII0Ytyy9bPckIr03BClRWtu7viA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=daUDSWrRVMo8Xfby+UjdjuNPKchpgW22ixsXC0ATRDc=;
 b=JaL/9cOFpAJvSxlhxjlH/L/XFv3V0yLDugzZG4wCg3Bo5P+VmHPHvuQEYB6JgiElgZMraZ+9YdXSweiP7b8UGbav5OduFeqB9kMfvkFYyf4KK8ViTZXX8aORO/ZAXdTIi6pVXDFHL9sQ2wMGDgVQj2ycaldFay/9c0cG8SPyqCI98Z4QSmOAab5s26lZmwO+DiiVONF35NtTCx5+ZQx0ZRBSeIfsgYl1XdQBaBHpPBWhkcERVWwIn91ZbDoQ0WvWAH8BabQV91KlSZwUOjR66TOr/gzpX+p3h4R59seaFzZdVAtm/ABBctLfQ7cmzdaxqR8Y2lw1kWAzIGhzv37c9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=daUDSWrRVMo8Xfby+UjdjuNPKchpgW22ixsXC0ATRDc=;
 b=UMFD54uNzoUsidpR4xsJo91bHiPGegnkst6245bCxvoL36l6Ieph+FW2Y+CQE0GgxK+RKlPzOi3qDOASj4XlqqiS6z19Rke//rJRbe180PyCz3mMGYPXuhdDHnPtzlUe31FNSUURiJ6TMMz2u86mkI0oqQzG3YLpem/UdwoZ+1siRf+QBvdi38E4IJ/dE4d2OUXTIjRPIL1jQz9hV1WkYlVln1/5xalab/egO7VXBpHA4yscP644hXclxUjFCuWJlgTxQAlL00MQmClWAivPMWvoix4gYCjdhmRKGc53P22OkOLAgW2/ykb2E+BmN0zcSjIbn0lkChMytmNmLLf8eA==
Received: from CY5P221CA0130.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:1f::16)
 by LV8PR12MB9642.namprd12.prod.outlook.com (2603:10b6:408:295::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 18:07:57 +0000
Received: from CY8PEPF00000053.namprd05.prod.outlook.com
 (2603:10b6:930:1f:cafe::1c) by CY5P221CA0130.outlook.office365.com
 (2603:10b6:930:1f::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 13
 Oct 2026 18:07:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.233) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY8PEPF00000053.mail.protection.outlook.com (10.167.247.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 18:07:53 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 13 Oct
 2026 11:07:29 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 11:07:29 -0700
Received: from dgx-1v-42.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Tue, 13 Oct 2026 11:07:29 -0700
From: Jamie Nguyen <jamien@nvidia.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, "Punit
 Agrawal" <punitagrawal@gmail.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] ACPI: sysfs: Map only the requested range in acpi_data_show()
Date: Tue, 13 Oct 2026 11:07:28 -0700
Message-ID: <20261013180728.957618-1-jamien@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY8PEPF00000053:EE_|LV8PR12MB9642:EE_
X-MS-Office365-Filtering-Correlation-Id: b7341465-f674-4ab1-a39b-08df2954e698
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|56012099006|11063799006|261009223027099003|10067099003|18002099003|4133799003;
X-Microsoft-Antispam-Message-Info:
	p9ywvpJOU1FXt9f16TSO0JXl0FaF6XaCVxDcPDBbWPXOqzIbyS8/FZZsaE6CDXG9lFSXMlJ1dWXTfWZdqX9HG5WCR3eCmeDoAaAyoLlgk+xVtd+IvaYagm6cqMMENJ4wXLVH3yHCjTI2RofmXdvFs8dPZHTh9Z85EsdwAWSlQkjEn1PsbyxymqP2MJJPhLcDha+FQwBIQIH5BuMXKVlB5sa/dNFJd+rg4FNS3wfGAJH+oQjxOEkg26TW03cf43r3USH34Y1vjyx6zx2FBddeaR/1rq9Ov/A9g1dDeBkdpoPqOmsfS6iE0S0i4AO6WeECXh5BoXYpFeokYEuptvPrH6VeP0Rm7qevc0qFQhulzLu3rnQsfLEENpi2ChTJrnFFWbif6QWQTKEvHr2I9lcfj3cuI/SMmuDjpCUyklR/r2UtR+CSdLtn8mcPHRebDwZSkkpyEPWm7HrDgiNEfY5IsLiEy3Pa8PbZqCMC4HKRbSvy4wiwduW59XyKG7LQCxieG0RUp+v8nJ8D1l20GIYJ7OBJ8pkQPsptH/23d+9wiHY2YtshN5UdAR/AtqfQN+ij2JQZCL4apCw5BPKHyxQTsh9gzgoz58Nx7vkBS8/0ACE/Y/ihT5N5kmBnp/WJXHv3Rh9rO1I147OhW6zTF4GskEnJ+GWQclraEmyEIkXxOD02tqOy7k58GJJoPPQxpieIzP+S79Cks9UKd5/ADTHTzg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(4133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TufFLlwmhaycK83VpEA+iix6Qy9Zzxli78Z3dhaXLCk43g2Qab7N9q+vqP/KWSXLOmTEuCy0Krf53Td8XxzNQ9aohTS6raLBkR0Xmar26yzPvSsDhrZAwZgqAPG2gWoQ+ylLCsXDXKB+JxfKqUGyNaUeowf0h9gmjJ9Ea0YBPtufHNIi1xiPFpM9ScIeFlWF0lN4NuEhYzOywCwG/pAJosFHl9KFavuUxuwhLZq3f83SxKXE3/78dlBsXUTTTgFsBF7rTPHNPBFbDXwul9Zrug4kPFLXaaH6n21njRGzasZ4XvV9LGO8FNFusVWPnJ3/iuWicRpajQ2b16D+GGgrYClgFOh7xAK9JiHQ+dApBEEvGj1mFGgeZmONEoPBXbuupGE+l6h5QI5txADyJf492ZeUgXO5izrCZ1q8RRhiNB4L8NL7Ye1p9ND5+pUWuijY
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 18:07:53.0810
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7341465-f674-4ab1-a39b-08df2954e698
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY8PEPF00000053.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9642

acpi_data_show() maps the whole data region on every read(), although
it copies at most count bytes and sysfs passes at most PAGE_SIZE bytes
per call. acpi_os_unmap_iomem() defers the iounmap until after an RCU
grace period, so a process reading one of these files in a loop keeps
many full-size mappings in flight.

Map only the range being read. acpi_os_map_iomem() rounds the mapping
to page boundaries, so each mapping is now at most two pages, whatever
the size of the region.

A malformed table can describe a region that wraps around the end of
the physical address space. acpi_os_map_iomem() doesn't check for that,
and its lookup of existing mappings then matches an unrelated mapping,
with or without this change. Fail reads of such a region before mapping
anything.

Assisted-by: LLM
Signed-off-by: Jamie Nguyen <jamien@nvidia.com>
---
As discussed on the BDAT v2 thread:
https://lore.kernel.org/r/CAJZ5v0ixQ_5jmrfm4mz50tZtCEq6nJt1b2eMoBdhr0f3AY+k7w@mail.gmail.com

This doesn't depend on that series and applies on its own.

Tested on an arm64 server with 4K and 64K pages, with the BDAT v2
series applied:

- The BERT and BDAT data files match /dev/mem when read whole, byte by
  byte, page by page, and across page boundaries.
- Each read maps at most two pages. With 4K pages, looping full reads
  of the 90754-byte BDAT file kept at most 167 MiB of vmalloc space
  mapped (1740 MiB before), and looping 1-byte reads at most 355 MiB
  (3090 MiB before).
- Malformed BERT tables loaded via initrd table upgrade, with regions
  that wrap around the end of the physical address space, fail every
  read with -EINVAL.

 drivers/acpi/sysfs.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index dd4a99f09efea65..138009659a7b55f 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -419,6 +419,7 @@ static ssize_t acpi_data_show(struct file *filp, struct kobject *kobj,
 	struct acpi_data_attr *data_attr;
 	void __iomem *base;
 	ssize_t size;
+	u64 end;
 
 	data_attr = container_of(bin_attr, struct acpi_data_attr, attr);
 	size = data_attr->attr.size;
@@ -432,13 +433,17 @@ static ssize_t acpi_data_show(struct file *filp, struct kobject *kobj,
 	if (count > size - offset)
 		count = size - offset;
 
-	base = acpi_os_map_iomem(data_attr->addr, size);
+	/* acpi_os_map_iomem() can't handle a range that wraps around */
+	if (check_add_overflow(data_attr->addr, size, &end))
+		return -EINVAL;
+
+	base = acpi_os_map_iomem(data_attr->addr + offset, count);
 	if (!base)
 		return -ENOMEM;
 
-	memcpy_fromio(buf, base + offset, count);
+	memcpy_fromio(buf, base, count);
 
-	acpi_os_unmap_iomem(base, size);
+	acpi_os_unmap_iomem(base, count);
 
 	return count;
 }
-- 
2.43.0

