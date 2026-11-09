Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794247847;
	b=S1xsF1cfXMaBsiEqGPyXndYhB5Zs1s2DaP18u2aef/APhE5FPApNY1eLitJhPLuOCSeB
	 LSzBez6wqK7aaXMP5hLYCS37R48W29xNTAA6ASlUxJfYof04SIKZdvb6zIc8OYCiyjI37
	 09L2xsLAY7x1TtHUnLIhdrpD2d0iA7eKxsEggNM9D3b+DXIklxSYZEWLoWee8qXGN9n14
	 yqIXoJ34Pb6wLGr3sgp3QOI8e6bjULOL52MAq3y8A2ThSWrZCaunvYz1oK4ev+iOc9QdA
	 bPMhNce2eF/i0F9XthYRL6fuiXTgtTPXLu+THaVmTM80X5DKPVAcWGDjQgYsfVkuLtA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794247847;
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
	bh=Fgkn9AHlN6gwFIIGU374NMd/dlA034vmi8G2DiX/V1o=;
	b=nrEXBSLD34Krxh0m1HB95SXHhG6/QVlsiVOv18Udc0Z3GMyoqY3cQFuSFFtxGBU7NASz
	 rfALhgXDKr84sYNTkVwfotD+LWCUBnDMRRV8d9W0VgNwMr+uZ+EOJYWaC/T/e+Vi3T8oz
	 1QXN+w3XywA/blTmYPmsOr3HS1GCotp3I1A6rYgrhcfziiQsUa8QmDHBI2T28ANz9MMES
	 e1dUhTBxwXvXRTTvDOfSu4E4+Onix86PM0QsL2ZEPCR+obGBmaIXyuEOLEqTdZCjeh2dE
	 Bac5osZ7j67ZVfKfq9nqf3B3U2Ka6cczo1Ke+OKo3tB07sLkOW3BsKlDJ1iFCOhcmZQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=AnO8W+J3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.46
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010046.outbound.protection.outlook.com [52.101.61.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D10606A330;
	Mon,  9 Nov 2026 18:10:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90D10606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=AnO8W+J3
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AwulYk5Txb6072EgiJielBe/FpOHOnkUUk9GwN+ZZyoAOfZubkCBTVnHSyiIjEAIRwxUSTSDqQ2shqeedtkaS4yHLNSk7xiICEF4x7EAbRxgO3svhDw1EDQmK+5py8N9t9v5b0KH+OY3lRoEWNf8N6d3oe7BWu9hZt0tA/w9Jl/6z3Nln007xDWhzEcMaFA4GVTCaJgemJXJKUYhsxC+5lGE7yYva3KMmr+WVv6FQF9Yq+VGVdgypbwT6ovXea2MXxUnYAHzNG6WTUwn8IECvW/jlUWVOhFiWDPqOjQON4j4IAOQoQispxAzwW5bxAGy5ujn4AvCkuUz4ZqFEOZwvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fgkn9AHlN6gwFIIGU374NMd/dlA034vmi8G2DiX/V1o=;
 b=ZCTVF8SGxOAexvhggtCJnygopzCYixAz75eGtvo8pMLrnSvowpgTTnCIGub8p/TByld1iwH7912/aPkFfZyoEMai5/KEPelx4ndkB+DcRag/89+FEko3rrYxc6ddkxiVjuvOMV2LTxi0rTyPoYq+xfXeKIxSjiQKWPah5focyRHOrQKm+kOg4neKdB2M1HIe8RxjMP/t13bfmjFIqzVWnbaqu0chKx+r9tl3My/ZMn//P7EZBTGgPNHtZD1fhjrmaofTJPNtgENF/+M1UZtcntIm+hWYlt30B1IhZttk/+fqWyVxd5VCkk+lDjTrsAw/yUbiz+BvUaJsOtrU4iPVDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fgkn9AHlN6gwFIIGU374NMd/dlA034vmi8G2DiX/V1o=;
 b=AnO8W+J3aC2OAk89lY6K8s/XI2LPD63ljzRc+7Qzo8I6iPXnqsYFy7msudeY9j5UEkQ9G73dwklLbKMhefR2EDY/o8l46+Zd5h4OUoyNJzCgxxNcZm2cslObEiornCTLhHge6uw7VIUFNRA2032aCWl/bSoWSg25BStLQuLG8+gB3pA+CSdK9lwue6+RKzsQuDGxf2QCiCWISswxXN1OA/XZTsE1+EjmQjfU5UKu0XwuJK+OQ4ZeM5B3nt/4pTVgd8VVSwZ2rtn+eL988NpwhBmic65voyd/XAhGrZbXBnsUfrBpREiLQw8EqZYROGN3HfxUHzZD7w4YQNkIX5HWjQ==
Received: from PH7P223CA0027.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:338::18)
 by CY8PR12MB7659.namprd12.prod.outlook.com (2603:10b6:930:9f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 9 Nov
 2026 18:10:11 +0000
Received: from SJ1PEPF000037A7.namprd04.prod.outlook.com
 (2603:10b6:510:338:cafe::87) by PH7P223CA0027.outlook.office365.com
 (2603:10b6:510:338::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Mon, 9
 Nov 2026 18:10:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000037A7.mail.protection.outlook.com (10.167.244.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 18:10:11 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 9 Nov
 2026 10:09:48 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 9 Nov
 2026 10:09:47 -0800
Received: from dgx-1v-42.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56 via Frontend
 Transport; Mon, 9 Nov 2026 10:09:47 -0800
From: Jamie Nguyen <jamien@nvidia.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, "Punit
 Agrawal" <punitagrawal@gmail.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/2] ACPI: sysfs: Expose BDAT data region
Date: Mon, 9 Nov 2026 10:09:45 -0800
Message-ID: <20261109180945.2438349-3-jamien@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109180945.2438349-1-jamien@nvidia.com>
References: <20261109180945.2438349-1-jamien@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A7:EE_|CY8PR12MB7659:EE_
X-MS-Office365-Filtering-Correlation-Id: 16ddff53-5e1f-49d9-06b7-08df3e8cb1fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|82310400026|36860700016|261009223027099003|261021130227099003|261021123027099003|261022115727099003|261021133027099003|261021121427099003|261021135927099003|261022075727099003|56012099006|261028144727099003|261022105027099003|261022113327099003|11063799006|261026130827099003|261026121527099003|261026140227099003|261026135527099003|18002099003|261102123227099003|10067099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	tGhFIRKuumIijOnonUGEeRKihjjn9ZRavLZINA6SnFzIyy60AZ/g0Y4TOtI/AS4JS4Q2wq9JdL6M44EML0ZKdHutOesXptRYSDqK1gfHT5HXPePQjCuWM3+36Dl7JVtQwgIPkbu5OrdETBfPs3R5G3PTFoEvpusILouSTwqOGc6WHJrv0g7w/3+l2B6Gz50cU+TKoXa+f/tPCCZ2eJCIdvaEeyc9YZpAv+kDNi4AEW5SZzxWup1JSpbl4I5TZieYbYI7eQ4Lrwp4kUTIFrBJQQQp0q52UYyUC0oZ7j+WR9ufqAEMmvf93mOcKeZEjMcP0TbLfS2MnpLr5O7AlcquhTUTscRvRiadZn/8JY4hcqm399kH8mv4z3IzFBNZeT37+S9oofXnp4q1o6K/MtUo23iCfdKI82tkhMpO3g6WFGtvbD+c4DD3N/kI0UYGLtgEHBR+gQv1xiUXnPGF+QuD4NkXZqzAFw6MAIX7wWjvEl6TorZnt1O3uqVXijFBN8JmuT8YTlGCg0jqoq5cjDYD2ev04avqA8dSupaLS9VF6QO/6nP7Ah8eCgqtKQASfdyqbK6KZQ0PxC0uvqrqUdqwF1texdWoQ1luEPVFYGkhrjVEJA7hhZwUWwJ+V9n97WxgMzj76n1CIeI4dhcwP99TUZifkZNyRfXF/vrnHY4EuUBETuHJJHC2IA+usTD3CxG2vEYLRGTbaE529dl5X5VPMw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(36860700016)(261009223027099003)(261021130227099003)(261021123027099003)(261022115727099003)(261021133027099003)(261021121427099003)(261021135927099003)(261022075727099003)(56012099006)(261028144727099003)(261022105027099003)(261022113327099003)(11063799006)(261026130827099003)(261026121527099003)(261026140227099003)(261026135527099003)(18002099003)(261102123227099003)(10067099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mX/XSsF641i4RI7SHDDkbV0SUXuxX+MC7L+8VQrkvYn9ee/9J3mGR4FiF5m3/oWUNZq2tVV6v3VHWN8id4cB9y31WHvultkg0RQY3Otvof4UDEDuE0bnthmmzRVDEEpqldmaheuQvSmYzcgmocscuil2smcyHsai0Yjih5tA7YGm4H5KYwOvJmiiDZZsIwtvRptea1FQozr/xH4Z4tmcJUkcDUxpNPqtKi+Vl/J45pU6xpc3dUFI9lXLy6kcWWD6+WGJL6fRy/dJD8nds2/DJiTCHcl3It0Vy7s/R9X+SEfBBt8r47LaSnxCLuFsIDAoAWVodjF46DKmHPPX8vLIhkXng3FWvUix/KQR/wBvz+hgk3PDBR4uSBEWhXNPmO8KY7dzB9Q3KZBC7WJusCme8nzz/JB1iwszAh2nkIguWsKGDauRRZESiMXvtk5nMOTh
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 18:10:11.1644
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16ddff53-5e1f-49d9-06b7-08df3e8cb1fa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7659

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
index 4182627eeafd2f8..0748a1d4fd515d3 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -477,12 +477,57 @@ static int acpi_ccel_data_init(void *th, struct acpi_data_attr *data_attr)
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

