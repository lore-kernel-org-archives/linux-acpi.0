Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794247817;
	b=Y7R3Iuaj07JomhtIHEfbOPd9HBYsgIGRtNbOQf/x+4hkNiWj6HQkSPHXKaflemux9ItI
	 thJFZ8ZYgOEf4N4bemLpCXOmwA6qzBoGfglekbRF1Sv7t2qNaAHiHxOQuFYiTaEMM8ywO
	 u31PNtk2KwLd4GzP0aL1RGn3e7UvuUVgkh1odbTYx1ynnNAbY/xf8uIIVlNRiadouqDzo
	 mqKJ4hpQe8jnGMg0s25+/Dq4li+ZHsgSl6PBzVfPn3LUomBYKXXbvdk+uY/RRRLIo+Bc9
	 eaUGih1ibnvHtkDaub8Wt19lu5mGCDev4t++POvCxzsnIDFgQrKswgM3PvX/5hBqJZQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794247817;
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
	bh=UKOh2Uznc1iGsjFkITMDagQ0QqpMlCbkil0csi72BLg=;
	b=GuZYu6MpJ4PZrv3BAph/R7pyLh/lVsg8go5U3/EM3D4sgUemsn6qePpsmS2r4jZEJ3MJ
	 OCj1PVF1bRwduSZVoi3GtxVCJOMxUmRmmNlbjNkyWliITVKtgZjjCSfeJLSTNDJ0BYyqf
	 WwYbnjRhwHx5zLmNvEZn/Jx8PCNJC3T1xxUx2+wKJKY1NuNPzNyI+FNywrd6N0jTF7OTe
	 K4UOQdV8cCo85qqQFSPJSq31udKyszWUL78ncxIHroYoD+Y58MX1Vd0OyVKc2DD3PZRKU
	 lY2jykiIx/PHW7vLamZr8tmUHw0Ywqq1dYvdIjbQsa9b+07Qsws4uy4+UCzS2AdZO4A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=eHd4zohF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.46
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011046.outbound.protection.outlook.com [40.93.194.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010B0606A31C;
	Mon,  9 Nov 2026 18:10:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 010B0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=eHd4zohF
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h+JjmekrsLe8PlKt4YRW9nieM5xxzAmz5jvKp5bDLsexKGsiCGhwhwmOhTjLYtL9LrIlmysn6lGDe+RsSm2sfoqXhqr7SCpM4d48kvWmNIQu/woM0ofWCq9Gj1P7jWfQIMPDIr0WrnN5lxy+axTnjFuqmzlEy2/Oa4D+X2K98rU3b+WgkHbi6zKK25LlT4jZ+WQ3dCbn/qKMFmLs1o+tMyeiWJLXVM3h2T5WRqtlAUhc36bnf20eu0fvuD66Yv6VvnmCC6tJF6J+jqvl/kp/4ZX95M0WpUwMaDB8JZ73WCZ4cNhRO/J9cSBDIaLqD4x4soGbt3idlYpV7KHY4HEFwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UKOh2Uznc1iGsjFkITMDagQ0QqpMlCbkil0csi72BLg=;
 b=MkMCfzsGIX7CtBaoYzGOQAtwUziCLDptPGFGrLR/uj0e6FY966w2vUFVnpGAdwfS6FjUHokK2Y05pH8nSVNNyn+DcoElR7DAoo856kV9yOL2YJUHe8QnsIQx1hUR44cUPzK67gSDG4V5WOmwzhWyb5s5C0b76PihL6sGsvW0K2OfVnVe+gUl81yYULmMJk7tqV8GuzKMEgfx8J/jLbOvwmKgEqhXMWh71STlSsC7JswnAKVc/9lYgpAEr493pLk1wDeeasylIIo4x0nmzKA3S6AC20MQdz9B/pkbZaqCNhXEb39rS3/hISr0Z3BYrFg+NeMHckiRSyc5IrN/n8Qb8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UKOh2Uznc1iGsjFkITMDagQ0QqpMlCbkil0csi72BLg=;
 b=eHd4zohFHUaCkx8VRfay+A8BkwWXOm3wqh0vJ8AWQheIzFYbfb580lUQis/Mqnckp9Ekru9AskoRLZE2ymhN4wyWKtUP2jv4PpbhAZawEyuACD39rQ0XnoZR3CogHdppTdyxyckU6+FpeDz2dZZa1HEyv/TFPNrjOX1x4TnEPNMOjT/+ay/keMlOANvIm1SvnAHV78UCtfh8gMr4J+xcwwt+1E/n5sKbq9nQK1eJ0g52pauYYkVwh6pQU7fDUGTNt0vxnw2c/uk/tDGGi1D4IDxvOPbWVluHrmUp49vj6iIsxInXDCqytsBx51IyYGuCjAj+vO1iUsQj8jvKEg3L/g==
Received: from MW4PR04CA0296.namprd04.prod.outlook.com (2603:10b6:303:89::31)
 by SJ2PR12MB8720.namprd12.prod.outlook.com (2603:10b6:a03:539::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 9 Nov
 2026 18:10:09 +0000
Received: from SJ1PEPF000037A5.namprd04.prod.outlook.com
 (2603:10b6:303:89:cafe::8b) by MW4PR04CA0296.outlook.office365.com
 (2603:10b6:303:89::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Mon, 9
 Nov 2026 18:10:09 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000037A5.mail.protection.outlook.com (10.167.244.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 18:10:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 9 Nov
 2026 10:09:47 -0800
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
Subject: [PATCH v3 1/2] ACPI: sysfs: Fix data_attr leak when creating a data file fails
Date: Mon, 9 Nov 2026 10:09:44 -0800
Message-ID: <20261109180945.2438349-2-jamien@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A5:EE_|SJ2PR12MB8720:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e42691f-358a-448b-caeb-08df3e8cb0b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|82310400026|23010399003|1800799024|22082099003|10067099003|18002099003|261021121427099003|56012099006|11063799006|261022105027099003|261102123227099003|261021123027099003|261028144727099003|261026140227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	U7wrucYujlO/h8+sOVCKTYAmhkoZQh2K0ivrZTAcywtFiVac1CSRXWAx3lxuuQuhqe25SWXYDkw5fjaHlw5lAP4mWvBb/bP6mCk8iHSVPe1ajdpInaD6FUGbuN2IZmeAT9bwbM0KMfHvJedbGJzq0//vEjsXM1EgiIMMwhr8xTEBNbccpJh0Z+5w8RIUam4fe3AXJxoLiPmJUy/jFq8PO3tm4VclENRjaZOWn3Hv7lJQe+cOSfBVrVKSIs7oGSBb72+WMNtGXr+hSIBfk2PSy8X0gQPZWnjQPIvfv5UTYw/RGKsKaDFaVjWS3liv5oy+RQFma/1P4nLqt7Uyd6NaFVbjuc/4Bu8s8VZMVHIdGZDvpMs0K8UaoIzisWvYcZt48e6yvv6lof6QdrM5UaUs1T/dT6/MAj3ixi6iLrHYKHmNcBOIw3fKCCd2LDtL0Ef7r4vrh7h9ZnbgnSGkLFklTyBqUkZc0JeJhXfkqTsx/hFVIo3QdXegk9A9aJSG/Y9U1sLYFimhaJgiA4QFGUj/WzkjO9LXLjlOpFwidtB04pMD1TGw9cWiw+/ArpI9szhQI1KS7QWiLfZBW4xPkLn1NZwA/n7O3/OOXZm/Va++3a4lBROVfEwLwZsERtZjiVs9VbyduWZX2nUCRBa1mLCEXQz+KpbSGt5KqFn+3j+YtYpIRB8fDGRyb0wNfyXr51UTLPFkl0T+zW4NzQA/qQmkzQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(23010399003)(1800799024)(22082099003)(10067099003)(18002099003)(261021121427099003)(56012099006)(11063799006)(261022105027099003)(261102123227099003)(261021123027099003)(261028144727099003)(261026140227099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	n61TfcOa0Yji+gZ6QOy1jHaTl3cohLHGI6RZhbkETdX+s3ROf4h6AQpxevQzfDZzamQapTVGAbduXwEHnGGmP4PJO+VYcJxfmQQSaK973Gbg4kEsEpxoVqRNeyqFx+ki0P7xX5yklq4tQUbrLCgtQoMwGPTv13yrhbSPLGXS24Z6jBhCCTzD/TixhNikS5He+ljQ3z6xDtGPr/WXgauLXvmdy8Crs9KIUE4GlU7HJxdNSZn5BNbLJlY3UopQqLNn2Nv3p2H6xv8tOBYriPVF56AkpmE/q1wOkXFnjrMosdpX29K2HtX7uBT6vjYu+9nSm+U5CEJ4QrDymR9zD3YFx4ZQE+Cme+E+qby0NzBUwPyRmRlLX3BUqhPtZfmjN6NRXLTWw59Gx7mdzg/e3ZHiVuqCgbpTQ4SvEZmlsds9MmHmGreOotEAMzWrGJNFxnBB
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 18:10:09.0790
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e42691f-358a-448b-caeb-08df3e8cb0b8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037A5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8720

acpi_table_data_init() allocates the data_attr for a table's data file
and passes it to the table's init callback. The BERT and CCEL callbacks
free data_attr when the table is invalid, but return the result of
sysfs_create_bin_file() directly, so data_attr is leaked if creating the
file fails.

Create the file and free data_attr on failure in acpi_table_data_init()
instead, so that the callbacks only check the table and set the address
and size of the data.

Fixes: 7dae6326ed76 ("ACPI / sysfs: Extend ACPI sysfs to provide access to boot error region")
Signed-off-by: Jamie Nguyen <jamien@nvidia.com>
---
 drivers/acpi/sysfs.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index a4534b3e3cfbb5b..4182627eeafd2f8 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -454,14 +454,13 @@ static int acpi_bert_data_init(void *th, struct acpi_data_attr *data_attr)
 	struct acpi_table_bert *bert = th;
 
 	if (bert->header.length < sizeof(struct acpi_table_bert) ||
-	    bert->region_length < sizeof(struct acpi_bert_region)) {
-		kfree(data_attr);
+	    bert->region_length < sizeof(struct acpi_bert_region))
 		return -EINVAL;
-	}
+
 	data_attr->addr = bert->address;
 	data_attr->attr.size = bert->region_length;
 
-	return sysfs_create_bin_file(tables_data_kobj, &data_attr->attr);
+	return 0;
 }
 
 static int acpi_ccel_data_init(void *th, struct acpi_data_attr *data_attr)
@@ -469,14 +468,13 @@ static int acpi_ccel_data_init(void *th, struct acpi_data_attr *data_attr)
 	struct acpi_table_ccel *ccel = th;
 
 	if (ccel->header.length < sizeof(struct acpi_table_ccel) ||
-	    !ccel->log_area_start_address || !ccel->log_area_minimum_length) {
-		kfree(data_attr);
+	    !ccel->log_area_start_address || !ccel->log_area_minimum_length)
 		return -EINVAL;
-	}
+
 	data_attr->addr = ccel->log_area_start_address;
 	data_attr->attr.size = ccel->log_area_minimum_length;
 
-	return sysfs_create_bin_file(tables_data_kobj, &data_attr->attr);
+	return 0;
 }
 
 static struct acpi_data_obj {
@@ -492,7 +490,7 @@ static struct acpi_data_obj {
 static int acpi_table_data_init(struct acpi_table_header *th, struct acpi_table_attr *table_attr)
 {
 	struct acpi_data_attr *data_attr;
-	int i;
+	int i, ret;
 
 	for (i = 0; i < NUM_ACPI_DATA_OBJS; i++) {
 		if (ACPI_COMPARE_NAMESEG(th->signature, acpi_data_objs[i].name)) {
@@ -504,7 +502,13 @@ static int acpi_table_data_init(struct acpi_table_header *th, struct acpi_table_
 			data_attr->attr.attr.mode = 0400;
 			strscpy(data_attr->filename, table_attr->filename);
 			data_attr->attr.attr.name = data_attr->filename;
-			return acpi_data_objs[i].fn(th, data_attr);
+			ret = acpi_data_objs[i].fn(th, data_attr);
+			if (!ret)
+				ret = sysfs_create_bin_file(tables_data_kobj,
+							    &data_attr->attr);
+			if (ret)
+				kfree(data_attr);
+			return ret;
 		}
 	}
 	return 0;
-- 
2.43.0

