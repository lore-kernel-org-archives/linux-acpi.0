Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794249520;
	b=WH1ERt4Gjyhoa1eT6UQmvy7vqzNHN0sninSwsvzErkkXmdjA671zsEDDFQBWdu5Mv7cN
	 XvsDYnNKXZFNjfOoNYGSM+iy3V6kqfqDQIhqe7YaqjeWWP1ibFzg43/+eZXfEHByTeDuk
	 FRTgluowuEXQsoNX4WpZ479FAviMdwKqfmgSXFBZGtWkmrwFpAw0ENAgeSZF9ESkDiJYU
	 jSYNztAhBV543EOGrGvKo3uVRRDbs+4SgzRxsZAVNQ994NhIdfSRcagZ7WMXOQdXXQg0n
	 f6zVuN4XLXy8vaPC/Rb+XunoqNzJugemZ67PBrF9Bl85bZEY6VIzjVO4u5yhS3g2Jbg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794249520;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-NV-OnPremToCloud:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=OG5cgyTcboInVl4FFh4bO/dtSV50dy9Bqe3m2+yAFdM=;
	b=aiqgDyTott3vhzKQyCvSK8XGbmragBqrd+nbJgAD/xYCynH2EWB3dPvjS3IQ8fMp3t1J
	 AsIgcR5nxKd1Kc78+7F5iS3eg1NHRuCtoQrEM8E5S0+DpSvnA8RakfMZ1syLS17QYH67m
	 +aAuk9Pm5oqU98ywcFeeSSFSp4+r2iF/bL5G8hBUZdh6lCvB22TKgDO9lCxURILIS6gXc
	 XmijAVm2cRw/O4p2+3aR3+bGeFjGxGgL2ER2btbvVv2iIMu+z2wGPzv3+DJd1XFwS+6BX
	 6uHPaK/caoUNsF5qpI3/409udy64tjzuhbyUBcVSYtq/tD2HK7CfKG7iunUIGm8ZuGA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=UwJDpH9e;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.28
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010028.outbound.protection.outlook.com [52.101.85.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4D0606A321;
	Mon,  9 Nov 2026 18:38:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A4D0606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=UwJDpH9e
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sl28JkXWmPjrj0dk1q0uP70kZ7ENPh5qGoaQs/6GTqoTqjAiUKkSMRIqK5Rf7W3EDDcKekqPhGavSpQ9SG8F+9bxBYVytf/yoGVdS5/8pj9WGYksPk1tGwNCKJVLylxc0OMnMGp3n1aY6ysTNhqrL31EVVGPnN+m0LkiSxKocNLzkANe5cdwujAo8xliqaH73qNwpY5Y6bToVcsbpVmTvY+89C9E39WTo1tBTOXIwcHk/01z7s2fECcF4pLRh6LcXrcaPwjUE6KuXsXyVPNh3klP2DeoxddpB57fE1jD7eSEf+JOp5a1Qgz17dgC5aa5aMJshITbSv8J/MvzFTkCbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OG5cgyTcboInVl4FFh4bO/dtSV50dy9Bqe3m2+yAFdM=;
 b=J3AGTTJ2KFdUXq9xgiLjaD9OrsdsSJA4SMzjfbEaZjaFVgrq4as36BYADXMcXV43g4G+0TaGr2zTIkANOPXymZUruDYAGzEFgE0qyYDWu3WV5H+H5tGn468j8CpWvNiGGOK8vtNRf+UpehOdH/nltQu+TyGcUeDg8m4QYFQbO3V/ObKd8Uiqqit9u3MCj3UnKMP/nIKQ1uiDCie+st83k9GRshUmwYYnRLCfYPPHsjyq8ayy468NoRA/G+LDQp3yUpXJwHCQupTCPUqcoYw4Uw9h2+fW1B6LD+F5SGljf+mcJ0Xpc4cV67YO3UMA4BAmdt0dremLvR1u2drmUL0CUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OG5cgyTcboInVl4FFh4bO/dtSV50dy9Bqe3m2+yAFdM=;
 b=UwJDpH9eWSWVe2CGHJfSceME8hjgHfTxrCZdQOE3EIqETmIelVXR0h8CoHBSPcHwVm537O1ZF3Tqjo57ChoJAYfucfQpXRr/P1NwXQdoEoht9CPP4bjxMnjFrYQIoFPW1dNQH0253CNhCyjACOVStfeFS6g4z+NSfTtSi+bCqKBE+eNjmF++32VVgv4zl+H7B6B19xPw/Phr//FQURvhHe7iYVZwx2uUj1ClmFhppDur76ogdnJHM63ZIxlhtJMQJNmMIqe+uY4j5AGoy9h0T3d/JKVEDHzJCFaaBlstAck6qz3xvZAd1z8xVehNo2aOjIwN3SMr123rhu+2y4Uy+Q==
Received: from DS3P221CA0005.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:45e::15) by
 SJ5PPF09E5F035B.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::988) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 18:38:28 +0000
Received: from DM3PEPF000265BF.namprd03.prod.outlook.com
 (2603:10b6:8:45e:cafe::1e) by DS3P221CA0005.outlook.office365.com
 (2603:10b6:8:45e::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon, 9
 Nov 2026 18:38:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DM3PEPF000265BF.mail.protection.outlook.com (10.167.23.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 18:38:26 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
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
Subject: [PATCH v4 2/2] ACPI: sysfs: Expose BDAT data region
Date: Mon, 9 Nov 2026 10:38:03 -0800
Message-ID: <20261109183803.2724859-3-jamien@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109183803.2724859-1-jamien@nvidia.com>
References: <20261109183803.2724859-1-jamien@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DM3PEPF000265BF:EE_|SJ5PPF09E5F035B:EE_
X-MS-Office365-Filtering-Correlation-Id: fdd5897f-bc34-4ec5-b53e-08df3e90a495
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|22082099003|18002099003|6133799003|10067099003|13003099007|11063799006|56012099006|261026121527099003|261102123227099003|261021130227099003|261022113327099003|261022075727099003|261022105027099003|261021123027099003|261021133027099003|261021121427099003|261022115727099003|261026135527099003|261026130827099003|261026140227099003|261021135927099003|261009223027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info:
	70Et/Se+YVRWa24C14gJ0ld3CewvhA7ITVxLRtjHxbWAjrqCR6+bwuEKx5Th4xgpG6gD2fDFFZjMHfSZ1Bz1Bdzz+nQbeASAUIu6wZzwqVMfBvHVGpUD2ijdL5mVQCUpko/Mi2uZVRa//J8XFLFAtczeBh3OnVZPtIGxHD3rJxp8bo56wI3BZIR6O5XPeuSIOjAlAM5YQ+YFZsKDEdz/7oYF3W+1TmMJMb+Gt+gTDfJpgE2tVhI0wNgcnbaFlGwFfsjUkJ9D5Ro053Xmrys73hDNeu6TopZxLLLLmcHWmqe+6eVUnLzI2hSzn9VqfwHW527GdVV/IOFNwL9NYt+GcP61hkk86qvu6FfOcMWywOtXlnLYwjABK1zrbztQlUTKCI56IDfXHvEEg38hWa88iAggeOOz7u4gJ0XVcCgLiC5WbZHYPfkC0gLJhBv/iFaU0BuA9Scf2S4upjJyPEJpc6nlJXeRhYFOS3yJeS656ubmlY9le3e2Grdg+6SKOdXiKsOIKbOh6CQjlHDagb29kegOCUT+hgDmUFR4hx/heYTuXg5+HYXTmnsgkohy81ZOyWMHFQeR3BxNqJ91c264QfD/xfVH+Ly91f6NLMhr0+RsciWuZTDtefRVXhSFSG2N/VN/i7Txi2mk1Vp6y7xc4+8QqXlCJQEYj9jthlPT8XGQCPtr+JSYXLJOFXy5LysORhI7ubs6XgT/CkSzteVUBQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(22082099003)(18002099003)(6133799003)(10067099003)(13003099007)(11063799006)(56012099006)(261026121527099003)(261102123227099003)(261021130227099003)(261022113327099003)(261022075727099003)(261022105027099003)(261021123027099003)(261021133027099003)(261021121427099003)(261022115727099003)(261026135527099003)(261026130827099003)(261026140227099003)(261021135927099003)(261009223027099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9026NySC36cqzUScM+v1iMNH+4wyt9e9G4DQyr1QHpDCl29Xv5s7xlghANQEw9/k4KDmGlRg3NS+ykqGPCgw1EUw8oF+y5XqURkDmiqbluGaZhcWlNFUlW8DCOWMLNcFFNOLIwnXKlYgStH8AVQUC7Z3WUal+8gs7HnoWy2IzAwN9db4Cmpp6JMMZZ+eWd/Gikye0cpwsOehBswNJXS+U4CuL0Mvr5lfmZOrBap6NrnGhTlTaiI9xqZjv+Vf731RTA9IYAAl6kSGpUPDk2elZFes5sniPafJdhO7nuOUHT1wWlq8d2TDkdAsszSkU+5PpmVh7u9YJyxsEEkwxreAYDHuYDWUB7xtHO3hBov/FlBIchHz52VC08+emJdDiLEyQMJO96bCbItk8QojZ9PA7zrNiO38y+eKJjFqqftxjhvfXlujcwNLXPGOe6X5qBBu
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 18:38:26.6049
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdd5897f-bc34-4ec5-b53e-08df3e90a495
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM3PEPF000265BF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF09E5F035B

The BIOS Data ACPI Table (BDAT) points to a firmware data structure that
carries memory training results and other boot-time data. The table is
only a pointer: /sys/firmware/acpi/tables/BDAT holds the ACPI header and
a Generic Address Structure, and the data itself lives in reserved
memory.

Expose the data as /sys/firmware/acpi/tables/data/BDAT, as is already
done for BERT and CCEL. Unlike those tables, BDAT carries no length, so
check the "BDATHEAD" signature at the start of the data structure and
take the size from its BiosDataStructSize field. Reject sizes smaller
than that header, and addresses where the header would wrap around the
end of the address space, which acpi_os_map_iomem() can't handle.
Document the new file in Documentation/ABI.

The BDAT specification is published by the UEFI Forum [1].

Link: https://uefi.org/sites/default/files/resources/BDAT_Spec_v4_0_9%20%282%29.pdf # [1]
Signed-off-by: Jamie Nguyen <jamien@nvidia.com>
---
 Documentation/ABI/testing/sysfs-firmware-acpi | 12 +++++
 drivers/acpi/sysfs.c                          | 50 +++++++++++++++++++
 2 files changed, 62 insertions(+)

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
index 4182627eeafd2f8..49a820b39c2917a 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -477,12 +477,62 @@ static int acpi_ccel_data_init(void *th, struct acpi_data_attr *data_attr)
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
+	u64 end;
+
+	if (bdat->header.length < sizeof(struct acpi_table_bdat) ||
+	    bdat->gas.space_id != ACPI_ADR_SPACE_SYSTEM_MEMORY ||
+	    !bdat->gas.address)
+		return -EINVAL;
+
+	/* acpi_os_map_iomem() can't handle a range that wraps around */
+	if (check_add_overflow(bdat->gas.address, sizeof(hdr), &end))
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

