Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.39
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794249511;
	b=cMXs5UNF5UdBnk1q2gUBVRkdhmowksahbbXk7QVZab1qnzAqn0UZfBjZQtqTgMqr1ZG1
	 ZG6MDZcgKIoKwIqTpdo88uA3jtrdil45Q7lnYeZhfz2f28ck5nL2A6ggTHFd+Qzztwzxi
	 hqi9pC29XFpPIWi34kEB7REiMyV5u7y7jJmUgkyCaTgHT/mFn+iIybcXDLhlBg7GPFe7X
	 gXZ84rQje6Fs+On+JpQOaVTxxHR63a9Afg2gq0I087nn6aYaczPrA56kgVw2PionoGGYW
	 8xDTku5CtoePVAklMbooA1BAjGs+H5KtU/n37qHdFdIVnYYXIYoozFdxQH02pFTpd/w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794249511;
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
	b=u4RQQXgKpvyhBi8he6PenYPir3tg5kpoQEptFG8HsdjzSoX+HmWR8Gd4AUpkf1RXVCil
	 /T8QpOHTRdGEIJ7+Gb3s8Fsyru/e1gupdDtGuwQc/OacTU55NHZCBDnD63BvNFWT3pQI6
	 kXdvjtxDMVck02VfuPl57DBWlHiAD8wXSnvTzvDZFCQRlaZKq9ShHIRG1A0/1US2R27Qm
	 D/2fYZtlz00ZELQQBbPnsCYuALmBUu93FZAQ3LvD288P/FEYgmi2eqJnm/s+Tm3Ja8PvX
	 771EbAEXdACYroMlizai7l8JXDm2d0M9i4RbK9B2k94jBQXr2tM6LrfyggdxW1LNEhw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=LV4+V+Xc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.39
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010039.outbound.protection.outlook.com [52.101.46.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3D0606A31C;
	Mon,  9 Nov 2026 18:38:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A3D0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=LV4+V+Xc
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c31oW4ZRG5rMzJ4B+hBJk+4+0/9e6GFFLvcTdCzSFIpWxYzhwHWmbBw1L1XlNmYoQ7JvuXEUnSbtph8NTdKgzjUfmUBegHSfCqmTtnYepyAF4leLUzzpi1xXHxiUqh7Hj32Lg2VQ2HsUOBXUqs5EzFaY86e2OhSmajfOMPr0uTnAOwnAte+O0iP7pWNVXI2CX0kMRaqnvWl+50RniQcugna9w03O7hgocXKx/9xQTq4tqLfMdJwyn8Gk7qN3fKvfhwXni1BKDOiUr/0LeLn4E+mieMLGGeEczV/oJml6l3h52+OkvZ/jlusgY6tKHzllfN1RxdAj6aXnOHo8veHUAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UKOh2Uznc1iGsjFkITMDagQ0QqpMlCbkil0csi72BLg=;
 b=et9noU6I1ryB09UyjPHjcubXTewjiWYcIJK2gY779GYZFDFtpxpCHPalun098Cno+7ovaltFi64CpM7UDi68qbDVST/gY13rt3emE9VdVx8eOuXzJfR25Lqxq8kKwHB/AxSRApyaFdzeo38LwpqLHdeV3sTauONA9Ml2aGjB/rGzEheIY3dvChBRQr/802kq3PKK7Yy/Rou0n6VOOoUxyJYjvcnvyRYs5ve8Nbm1f7SNBUNRuvgj/pek5jxM9ezOftXr1tYlwkTlRXaDz9JRKKc06GjNDMjsqHGtif7mUMqt+7r89kWjLdekVnXqWeEU/V0Ylc2VPCDD5APx0lqYlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UKOh2Uznc1iGsjFkITMDagQ0QqpMlCbkil0csi72BLg=;
 b=LV4+V+XccSU33oDAENq2SmV5EwhcR7Z7ynVZ9fgSLf4wdxUgqEFHwMuhvrYtC10gUizdIF6/vxDkgQr9d7azrvD6gm2lNjLhZZf071pfcCzPGUuVWGGnWIIZL8rXvnP9VhdH7GLdNJOUIRb+mB35FHeaf4vP8mqlf9c2iXDxFlIRoCN7hdx9Mb/P9+dAiycrlja0ckFjD5SMZB8+YXYQ27ODt7w/mq+5MDVLjkjN9Hz1zxkAYcHQbJJhNK9nbDMpqsSFarowRFeeVDNbDIYH+XEjlWh8vPi+mJ3THiBwnttchCp8wXLQy+PKKkSoL95ykXnAasVq4D9SP4Bd5X/7Ag==
Received: from CH0PR03CA0057.namprd03.prod.outlook.com (2603:10b6:610:b3::32)
 by DS0PR12MB8564.namprd12.prod.outlook.com (2603:10b6:8:167::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 18:38:26 +0000
Received: from DM3PEPF000265C0.namprd03.prod.outlook.com
 (2603:10b6:610:b3:cafe::98) by CH0PR03CA0057.outlook.office365.com
 (2603:10b6:610:b3::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Mon, 9
 Nov 2026 18:38:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DM3PEPF000265C0.mail.protection.outlook.com (10.167.23.181) with Microsoft
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
Subject: [PATCH v4 1/2] ACPI: sysfs: Fix data_attr leak when creating a data file fails
Date: Mon, 9 Nov 2026 10:38:02 -0800
Message-ID: <20261109183803.2724859-2-jamien@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DM3PEPF000265C0:EE_|DS0PR12MB8564:EE_
X-MS-Office365-Filtering-Correlation-Id: e03fd64a-f167-457d-8ead-08df3e90a49a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|11063799006|261102123227099003|261028144727099003|56012099006|261021123027099003|261021121427099003|261022105027099003|261009223027099003|261026140227099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	iRY94pbK7IiMVfWSBRthoWpeYMniHyudCKJs+B2J84Bw4yqn14m9y+IBdrGMu3SDSYUq1kLDpOeve5eDAIKUsugVe5EZNhXRt7ubpN1ZUEkmXrptIH6qNkMh8oCE2zfm1ZUZONRIdE82R7xwAn1NKRwvS0J6CKJA8DpdteHyZncH/syDSFFvwHJ3PKZ9nbjUMQ2SatWmiDwkXs8FxC4FtAF0o3HyB8GChDmkqVhxxSwVi6F44erSDBL11Fwnj1Bn1qh1wCmL8HiogknlLXgpajkJn8ToQ02C2ik7st3F03IGOajliodAMh/PcgaU53odvW80IF2l3+smD9lG+BtAMduVy8dP5lQXBe8qMfpHcIXiDgJDNR7pJllI29GU+GITSvtw53RG6Yr6NP0oRDhUX15AyMvxJlsJ90zBD4nBCQpLhJHV94YKsfUQOSGwMp5sZLJECzmtTXOx7X7q8CziYqUajlGFNfTW8kRlqwc0/eHEHF78h67AYS9GGj49FgiH1Vk0Bm0+DwhQr4kyhchXbAKazesvOvx08MS9PndjO7tZxfOp2OOX8SOdTd+iIdIobWV1ys9yMEC/hpIJNYOrVVhmsgW8EC8I7MehcskmfCf5HYIdoD5XKBIHghmxnRRLY90EWV+DEIQXcbc8F8XgTtsu0BRV9iZpcbYK8oyhvd+Y+TkIm4JXuZiiHhC5FhFyMYlYyT7wW26BRXNnLYZfNg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(11063799006)(261102123227099003)(261028144727099003)(56012099006)(261021123027099003)(261021121427099003)(261022105027099003)(261009223027099003)(261026140227099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/NtWexTjGjDHdiP1UlarkFR3bZIFDTRMD3+o6OxyTMYf1+opWg3XBa2FvNTZja0fSq/wbUwByI5Cd88lOlIuZlSaxdHRNq9S2oRejFvchJd51zBT+rG0F9VdHUeHEP9rmO1c5+3VpFycUA747tjJrlJs5HaMWQhgQ608LDg2Mw6jaWOBROZucVqIHKzAN1JlD2KIeUC3UJuC3PxmwWxzQ7tRTLjnNEx5FobH/G+F0T4SFRwX3hKxaufmmbM0dowd5ae5ZnfMNldoH3NvvKIcaGLh0ycIDCgxNy+Riu14fn3Xf1E8K5GNHR875vODZRDwu6xSSy84JUEFQqhEIfnIsOeVh326Rdp9EmMWVP/Dwd+dtPYF014b3byfzVRn6W1LACqZ51q+OyqI815f53Z/fz2VwssjjuJIC2Y4YOCltIT7qcC7XOpuraEEcog/+oE0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 18:38:26.6322
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e03fd64a-f167-457d-8ead-08df3e90a49a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM3PEPF000265C0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8564

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

