Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013030.outbound.protection.outlook.com [40.93.201.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C2827FB1C;
	Mon, 12 Oct 2026 23:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791846423; cv=fail; b=hHZ1hnQ1nRxr8uJbqSzI1Bis6nUVxheINRKlL/w80X4E4+DhPKpMVCVW6O9pR1ExSsdmFGhw/lj7NsgBLXaMymsPBeeNcwheoTV1RfDZfzuH2AqBckpyzMWVznXa4YCyyN+qJJedQmkyieDCkcxUtCVGT9Dr5Qjj8R483uZmtuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791846423; c=relaxed/simple;
	bh=IoXc3NedH4kcnUW/k+BRwilhHK2Ss67vcDqJHV0wzPI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NGocgd2LkL8zgt8kO9iZs2ezKULBNGQNZCFZWVu4XOgDXPj07ErOH99CUnQhpez1ABs50Z+TL6prYNLjjjJNuDMVxqgtyJHvEjM3VdJtpCrpPJbDwCOUFMkJxWYB184TgTnzZMqnu4uuIpzjfXiEOoAMBIzKj2U6pUjwiiSaJVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=npbiKNKF; arc=fail smtp.client-ip=40.93.201.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="npbiKNKF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bacbkbBkLXMyslNQ+p7OLt4znT0aJHjOpH2VUgbdqg9LTcXF13I2b6imIG5bdBZW75mg7wuIzOgKG8mBDMMHPyqBhDSM50UCteqJEZwGB/BBQxJxLKRzI+KNzam2VmIcTRqmbF3D71JOjcHR+eOyi43YGyLAwgkqUBgvBsOusdUCpoIlgPTAidaChO3jFTJW3BlHPB4cQIqbYXv3DxrvUPE40olj0cEU1FjYNY5QtgqzwNjJZyontNgkQtY3T0wAvBD1MsoF5bKhKFps7hKiNIYqdZuLcADXksMPFu1/wuIauuR3faXv/Oa4bxl2eky4uNFxeE1yP33V81346B17aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3iNBY7tBa2e7Bn3ouuIwSKAew2WG8UC9yYFK156GiqY=;
 b=q3X9uOSslXmtVE5WbCZrMEnOrZajpNWDsf3VxLRsqPS4NrPzQYYV8MeY9Ff08QN+ZqA6n3znapNJg4kb1+8lIep8VcBEakxdkdsSNz+ZE6uDiMNWvNUkG3LTAmneJ3JdSkuC0iUKH+Q1E9InHZy3tuvuVVi1cLWfN1/lVg4tLZZvE3lDk3ERkIRg7WgPj6AB6WizPQMJwceISs5O5NuL2Ydjz1TR6fAfQiqWjygCI+cWkYxAIR+nqqbAxKtb7qhWL+dJFvU0ctmZGFzhNyUqKOEx22qv/9XWWKQbjghX9WlBM4hh3nSby7rsAmYY6Ay7f1dUooD+YVC/WKUXEaM5Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3iNBY7tBa2e7Bn3ouuIwSKAew2WG8UC9yYFK156GiqY=;
 b=npbiKNKFO0Ho1XMBdERRjMMZi26ZHp2vuwuu3DhqvDz/Gr3Mqo9VrPNO2k1496P14gg2f4Qz60UQsgStaEc6rh6IMbKatigt/IQfrya7ucCT4YAPPa9kOTKxUI7pO8WbDiN7wpPD7BLK4GI1rbLX1wng0eox3BE47J2eP4kpVACzTvOcP4EcJIPWB0lvoOn+FUx/ArVwIpRW0uX/d/lFOPYUbTk4dtnn/6OvMPqOk9hKuebO3rUSczo+WnWaIf/XhOnlflk+SGHDzaE/QluQ/UApOApDlB8Bivfh1UD4BJqn+Rf9AKTLNCDiu+RoXLfqVjhHZww5krRAJwMFUn14mg==
Received: from MN2PR14CA0017.namprd14.prod.outlook.com (2603:10b6:208:23e::22)
 by MN2PR12MB4128.namprd12.prod.outlook.com (2603:10b6:208:1dd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Mon, 12 Oct
 2026 23:06:56 +0000
Received: from IA0PEPF00000046.namprd04.prod.outlook.com
 (2603:10b6:208:23e:cafe::a3) by MN2PR14CA0017.outlook.office365.com
 (2603:10b6:208:23e::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Mon, 12
 Oct 2026 23:06:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 IA0PEPF00000046.mail.protection.outlook.com (10.167.249.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 12 Oct 2026 23:06:56 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 12 Oct
 2026 16:06:33 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 12 Oct
 2026 16:06:32 -0700
Received: from dgx-1v-42.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Mon, 12 Oct 2026 16:06:32 -0700
From: Jamie Nguyen <jamien@nvidia.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, "Punit
 Agrawal" <punitagrawal@gmail.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] ACPI: sysfs: Fix data_attr leak when creating a data file fails
Date: Mon, 12 Oct 2026 16:06:31 -0700
Message-ID: <20261012230632.3574987-2-jamien@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: IA0PEPF00000046:EE_|MN2PR12MB4128:EE_
X-MS-Office365-Filtering-Correlation-Id: d0239569-e079-46ac-273f-08df28b58362
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|1800799024|376014|36860700016|10067099003|18002099003|22082099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	1kMKC1OZwUD6gFF7baa1B9UsqbWXCK0+gcVGwHmZjeb1xehE4BrPCNsGojYG4C0pdt3xuTR2PgYjMfs7zcFjgTuXQueZuBxVWp2bBU9869zyYcEIyg2fPMh7fkaTL+hPUFeLk1ff5gNzuKMT922scyr3zFCD6Kz5pnrFtolPLZJ7chR80Lz4rc7jUVjILYPD64RNjDM5jf0bLDMX/miOgWiBgcOHOTqxJRThF0orfZI+mcJ5zB1u8kWHzTEQGRS9pWBl8ycbiFmxPFfIR7UXFUV0kuqaZsBG3JFAfVI4+AlVQUuXcwXC/8Gk7r49pSqx9rroIQmC7YjCWE1h76OXkCzQ9ueehzN7eTmbpGzhxE+SfdWb2nwbd2zI+qLi87yCSNn3eCuOEVFBr0F/6+xvSFuzfiTSoqUzANdg/QJo06hCerAcVYu2/3r0JRixhDh3+9Su28KP0DQuU8agYxgtl7M+NRYk/IQ9FrzeaiJPzytC/Ed8Re/uRWEkiGedAyPHlM7SOWRA/TQCPcUT8vC7MmCzft2cVxRPLqnmzEbAkwp5nL/sNNQiZ/jUAUNgzK5okPOaQkmt02+HSa/MZosaz3xvynIa/Cxbh4Dydhk1EjHRNt5WmhxnKKRFUUHaZEVFt1uadxGny7MknluKNhUZAYK86qSCMGgYXQA7Edo1sxUX08KCQ43J4P9YynzWV5ldcHAKRBsAMSpoqCNkhbaYiw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(1800799024)(376014)(36860700016)(10067099003)(18002099003)(22082099003)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Tv0eBNadVgvtCsODrvGQZ+t8DTpkvLeTvNoN9yNx5bWKLgbyj1GUJkPmyRUlAuhVx+vczweRP+QypzS86eBJNKswWKznhMVq2hiNBkqzv7SdJdbQ8TYsLg8Jfvp1ffVXsziHgP6iTu6HfAUHvdogy2qSbvXGAzShHk8YQB81jlePdH42m7xuqjXPP0iPXvTF6Shoh69K+FANUWd/Ob7cWbeCv8qDTDJWM6mIiy1u4efrmECE1ZricoDW+LYaif+mcOJlbjzCVGP9RwfQZMB8ZvZKPdU/y0GhR5iXTBOsQF6O3zTgqIzy8xO8zmg5ls5B+xIwTyncxhWEN/gDOytzAj1Flrs+X2H5CpeSTOe/1a3tpGNPz3IN94PQgOELyg1zJm9C41yYigIjqOOieVn8/BEjN2g5NjE0oq/WHbSosefycN5852lhkzpuzQXWde+O
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 23:06:56.6439
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0239569-e079-46ac-273f-08df28b58362
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	IA0PEPF00000046.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4128

acpi_table_data_init() allocates the data_attr for a table's data file
and passes it to the table's init callback. The BERT and CCEL callbacks
free data_attr when the table is invalid, but return the result of
sysfs_create_bin_file() directly, so data_attr is leaked if creating the
file fails.

Create the file and free data_attr on failure in acpi_table_data_init()
instead, so that the callbacks only check the table and set the address
and size of the data.

Fixes: 7dae6326ed76 ("ACPI / sysfs: Extend ACPI sysfs to provide access to boot error region")
Assisted-by: LLM
Signed-off-by: Jamie Nguyen <jamien@nvidia.com>
---
 drivers/acpi/sysfs.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index dd4a99f09efea65..ae3b3ee0552d198 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -448,14 +448,13 @@ static int acpi_bert_data_init(void *th, struct acpi_data_attr *data_attr)
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
@@ -463,14 +462,13 @@ static int acpi_ccel_data_init(void *th, struct acpi_data_attr *data_attr)
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
@@ -486,7 +484,7 @@ static struct acpi_data_obj {
 static int acpi_table_data_init(struct acpi_table_header *th, struct acpi_table_attr *table_attr)
 {
 	struct acpi_data_attr *data_attr;
-	int i;
+	int i, ret;
 
 	for (i = 0; i < NUM_ACPI_DATA_OBJS; i++) {
 		if (ACPI_COMPARE_NAMESEG(th->signature, acpi_data_objs[i].name)) {
@@ -498,7 +496,13 @@ static int acpi_table_data_init(struct acpi_table_header *th, struct acpi_table_
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

