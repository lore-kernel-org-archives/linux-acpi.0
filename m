Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010054.outbound.protection.outlook.com [52.101.193.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4215349D7;
	Tue, 13 Oct 2026 19:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791920371; cv=fail; b=Js8YGryLCQOkqucESRtDCbnag3m+uViaUjMcwEvu5qOupUvANRTPEj/rdxpPBKNC/1IpyfzbAkK+SyZJYkVQDUbd9GF7WOt3WG0jeqe+7cfLikdQDvvtwKK3DAcRgLSKlmBe6kM/2TnOxZu86BOcp0L17wWO+oETxrsOwaoKJus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791920371; c=relaxed/simple;
	bh=0dU+LBfYqb/PPkclZR2Q8sAhoLFCH8FUedRwakFPL8c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IEC8v9BTDgc/rVjuwpRUVkMceiHEbZ4BDdam+0xIPzbyBfYcffv9gLCxR/WCzl4fv2kCYNaZYWuecsedwxrQ6NG/jPe4S6F/RARTWsKUa7m//U5TbFB2BOK1emRPlGCrvXHexqCaHyX21vspAF+RVFypUB9DzRXtCTqKi+QGM0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ILscq1us; arc=fail smtp.client-ip=52.101.193.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ILscq1us"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=baVWWM9nRiktOU7NtWj8U9QjtrlUFndTsBegwJODG6DTyWnJbY70LSe/7w4XyfEIyR5Pm/tS0DEPYiKYunmLbpzM9rUHLC3Bw9tARw2xEINtF6qOK1gYRT+dBFlB1sbitTHYO8yfgA6KUXu9+XDHWdWme+A5n1Uz7ZiypY8C8bUZFQEjBY2KQwg3HlhpmUVJHMovYCirDknjW+ziqFfDR5B0Z/levJDLV4l0aiqHBugcqjE/MJurUPFlzPS/bEveBT4voIGPpYoWRFY80/ok3N+8zUoBGxX6VZTfJ1on+XrRmn/NaZbKmiJeyriYfehkgAuiOP3pyjD0256caKudWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VCeeRiFbqLdryLlECQzWXsnw59u/YdfIYQenjZ9ha0s=;
 b=QfS5v1TdEMjwEMQ+8+iLlF5aSfG4TYRFk9gLOV07v8G2VSjPN+F2V1Zidb+VsoeWcZ+Oe7uE3w3B2N248x04Z3l1kjV+QhYabWpfZJV1pBxVGG6FhsWcC83oOtiRjv7GlQ8SYuVg4CH/R0rYI3OBWkUZUPoGWFO2opeLj4mvBVQh4KlfG8/XPRQr5QKJKjN6aVCtB+taf+/FjRUEJ7vFPMt1GBA8KwaWInIPIXYG45dCo+lh6sYaZhNdBrKm4lMuIkyCyeaHbjEQP1QlSRkZ6/indFNHe+Lr5J6fP+tCf2yac5W0Tgqj8Ki/VD3TtFUOjsCiVvglpdaimocdHr/KrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VCeeRiFbqLdryLlECQzWXsnw59u/YdfIYQenjZ9ha0s=;
 b=ILscq1us65TCti9wCL8yO2qTQxJy/PO8AFpHCtg/f18Md1HXpCBD9IeI6M1BAUQAAnO6L8xUIoKQyKtCxQ+m0M4B4ZAhtyJzzMKOKWWVGXL/t5i8AHC+srzOrEE4p3KSy8INRdESkcoMVNDWS4JtY5wPZXID/by/z0WqbX7QfJ4HbJy2yjhsP9lxHVEisxxP/ZgXYAUBOTOjSMV/wyye+HYHwYT8h0/ECzYgKBMK05aoHP+4pw/YV80ikYBIA0urL649y3eYwf9oKrlhomq8n5eWtu/bW2gjjEoYzCCFo7tLt2wmTKMqacp2AXayIOoAIfj2uV9x2dm/Ed/7/BiWhg==
Received: from SJ0PR03CA0174.namprd03.prod.outlook.com (2603:10b6:a03:338::29)
 by DSVPR12MB999307.namprd12.prod.outlook.com (2603:10b6:8:41a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 19:39:24 +0000
Received: from SJ1PEPF000037B9.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::7b) by SJ0PR03CA0174.outlook.office365.com
 (2603:10b6:a03:338::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 13
 Oct 2026 19:39:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000037B9.mail.protection.outlook.com (10.167.244.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 19:39:24 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 13 Oct
 2026 12:39:00 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 13 Oct
 2026 12:39:00 -0700
Received: from dgx-1v-42.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Tue, 13 Oct 2026 12:39:00 -0700
From: Jamie Nguyen <jamien@nvidia.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, "Punit
 Agrawal" <punitagrawal@gmail.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] ACPI: sysfs: Finish sysfs init when creating a table file fails
Date: Tue, 13 Oct 2026 12:39:00 -0700
Message-ID: <20261013193900.1258808-1-jamien@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037B9:EE_|DSVPR12MB999307:EE_
X-MS-Office365-Filtering-Correlation-Id: 93055dcd-21b8-44d8-b430-08df2961af98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|56012099006|11063799006|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	e0B9ajy1WbRVeeWuvBnuM77F9EXh2daPzoYp9sjEM0OKRKY/+rxonnSL6JluIE7D8Lnhyjh57AGKmxHXp/Qcw4ytepiXp12hU7PvrZU5CpUqUQYTwjDngH8koHmn7gEBrivjNJ/mypV4QEG1cd6YppNIAzWMTIN9KN7qd5rVuUpJwJMaTUiijam4YZOkPwkSoiFlRUs1er1fnI2JtQnjU/RlyF7eimDDowb5sVnq49O84kK0jg7+bkmIJkh0k56ZZMYai/fSQjjV8F025sNn4XzRUp5Sk4a9RVtlbRHA2pj7hti4FcjZXwntWp2jZbHx8sGSCPoNAwq4UY4850FL/DrhIyavHruJwX+OsZ6fEt+yyI/KpT7zKQ2UmzDGtJ3KYSCoDWx5rC61qSaHlmPXhkvHjpQvpqc++ZA5fPr3LP2KD/DCCjQ+tM+qsDhC9p7YUDO+5Dq3P+1MbBgwECguNquQv4T3g82kPN+D2ervJgKlSlkQWdjS4QUamq3NfMK3kDR4F6TL/qKwU2Va0HqXIBoaOaYISlEtnsXyvt/m0UuD5jgaK/kaEhrukU9oyM2+oiGjKhINM6nBwSDugUxxbIE16BanQQgoS4S49Ix0jAvonGwV3+LF+jWyGj+pGAicMKp6w5FNeccRJqKQyxj4KGhUZkkd329riCfHpIKqexZxCSpvYrmJo/Rp0pbM4bipT6RtgXRXE5EjDS0GN7lsCg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(56012099006)(11063799006)(10067099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	cbXiLn3mIUTE1XZlnVVTp7NJGXcuNb3FLHlCFHDj7/UBN4uMAsYZ8lu2yoQuCnJccmDrTfDEY5j/AFfWee6FQAXwoR/k2Fm5GjugcETvRMApiOdzQT6qanq3kSKaoT1ql4uTs2t4zu1sUuByRlpSCdiSxMRkUi8hYgyB2R61wVIKdgrWisDPrb8cDJvyM5Cz1PW09UjPnsG4nHLKQDRhnCd4HLmmHIRfjCSZJ+WRNGdZPN183HkKvvh8nwX9cFXFYKUvycGVm68yWht+KsrVFQ3jOSIlR8G2K6Q5dsV+I/v79Cmk0GuNpHWVXMySjayYiD//r/C19EHr99Rh0LaUAxIEphyl2eduM8yPlVoi29Wv35hgGeexOpSQARlzRrNobnymLaQsBz6NZHrXlsn8VZgZP46SF5QcRLLa1rE1zh4rNpcLJX7aREUmwStKnjxX
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 19:39:24.3806
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93055dcd-21b8-44d8-b430-08df2961af98
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037B9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999307

If creating the file for a table fails, acpi_tables_sysfs_init()
returns without sending the uevents for the tables directories, and
acpi_sysfs_init() returns before creating the hotplug and pm_profile
files.

Stop creating table files at that point, but finish the rest of the
initialization. Skipping only the failed table would give its file
name to the next table with the same signature, so reading that file
would return the failed table.

Assisted-by: LLM
Signed-off-by: Jamie Nguyen <jamien@nvidia.com>
---
This was noted in the review of the BDAT v1 patch:
https://lore.kernel.org/r/CAJZ5v0hM+6RvyXwG89Jyyu48jxSejNwsDt-H=2Y2dkt--af2QA@mail.gmail.com.
Handling it as a standalone patch here.

Tested on an arm64 server with test-only changes that make creating
one table's file fail at boot (FPDT, or the second SSDT). Without this
patch, pm_profile and hotplug are missing. With it, they are created,
and every table file created before the failure matches a normal boot.

 drivers/acpi/sysfs.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index dd4a99f09efea65..7dfbb19238ad906 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -510,7 +510,6 @@ static int acpi_tables_sysfs_init(void)
 	struct acpi_table_header *table_header = NULL;
 	int table_index;
 	acpi_status status;
-	int ret;
 
 	tables_kobj = kobject_create_and_add("tables", acpi_kobj);
 	if (!tables_kobj)
@@ -535,13 +534,11 @@ static int acpi_tables_sysfs_init(void)
 
 		table_attr = kzalloc_obj(*table_attr);
 		if (!table_attr)
-			return -ENOMEM;
+			break;
 
-		ret = acpi_table_attr_init(tables_kobj,
-					   table_attr, table_header);
-		if (ret) {
+		if (acpi_table_attr_init(tables_kobj, table_attr, table_header)) {
 			kfree(table_attr);
-			return ret;
+			break;
 		}
 		list_add_tail(&table_attr->node, &acpi_table_attr_list);
 		acpi_table_data_init(table_header, table_attr);
-- 
2.43.0

