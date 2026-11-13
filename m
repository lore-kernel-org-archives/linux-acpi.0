Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794610988;
	b=IyVnswNzKdZd0iNKSnCSAm92iQaqjPLD7GKek68mnvGSw+u93GphFUcAA9X/fN2DUwm9
	 nm9+mO4UqWdghqjD5wpFYPRfp8mOqy7vWOxQJnW0JcFXDcf3VGpe9JQRES+DO3BiDuDIG
	 g9iGy5YEqVrPoMDjEP26LhNHZ5W5A9uq1pbARguPuPCcjWsQEeN3pZTbY7lBHII6ZLM/e
	 oRdeBFv8R2t5nKQO/YfIPvdRL4EkQ54y2ZnyOOh9ZAZqKYSK55LPCzJi29uaKPDDS1vX9
	 tVQgCrYPtehm6bVTN2KmiXaspgoPyCv7muPGUS+kPo8532f+HIMo1ntj8j0Wg7clP/g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794610988;
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
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=PS21OXnonJXkBNygVdBmLKpdRtC9qm6E/wqVssXr2Ko=;
	b=XTjgVzeh66C9xY1aX6/bLwwKKNllSXef3yiUxFGgZRZ2bXHGTd+aUdB7dRKGkMfkL4k8
	 RhgDqV4iZbUU/7FkYNGTv3yCGFSAmvsG9k0xipjo5oAOQ+6rqkY9+8EEjTPwgMt+4o2i1
	 fK5iFsCVQvlmuvJMWyLLrKelnZnagmOiSsqU6r8lbcDdAsn5oqFa8dAW7oaj2A6c6bGJv
	 XwGVfeBNJRQw79sftmhlFbvLfm1W5syEnd/wW3xiGwxxUBn0Dn9yMvTdKIPSgB6tsNWp4
	 TsorrdgPxdPo+/YWRqLPMRtsGa0yggP4pzNAKS8G08e0FAMVItmMee6uNFpAFW5iIkQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=sKFNvCfn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.48
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013048.outbound.protection.outlook.com [40.93.196.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3085160A2602;
	Fri, 13 Nov 2026 23:03:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3085160A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=sKFNvCfn
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p+D7fcxf6prD8g5Bfa24ILiSXk+GNThQMpNFDwiLBy/u4qAzXtLRsL2gw2OTwIQCXBdS6YwLttyUzqp04xPNw02nav2H0utUMn56Uh1ZDkpx1570P8Fkwn5vHPDnCwS94x40p+Sd8yGE0Tz7em02HVZoaHZa3AW8B1wKqLZo1rq9qRvMbDHnZmzsKRuBfO25uRlYk/vy98rjSaY7q7b3dClzOinr753sWsqZc/zkL0M7u6xaTLW2TOs5sQDNuQ1mhhRvvDou6lqAssK/1f/JPzAou1k6SBX35u9CNNGqDrIOqqTGumTcY4NsESwu5smCMhuvTfO2+/9F5dk6EIMFDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PS21OXnonJXkBNygVdBmLKpdRtC9qm6E/wqVssXr2Ko=;
 b=NgegDhSF/fwULUDcRkYUNFa6oFBXneIlwL9sfl0WHnJwMDCTQuE1lvPErzlY8CunBYealOTHnelAGZOhPSnXlq864uaRAUzZ0lf4ybbma0lo5idhX8iaHioDBmksFTfSrA7F15N9P+KS9nrGAgvk5/AtuWDN5Jn+hGTYtRLgkxH5Az8F1PcYLUovEoKd0HCX3z2xG+s1Ds0OQQ32JlW2l4IgYqpXpTDKxYCTIgdhnDq4jZJ0vO0oSGDVilOd3xx8WszSSP+8T/JOAgES7gCvGSqG21sPBa/lGeHPczhmzMOzh8YEH2DngLbkWl5mkVyqaQwquQoiXlGAqq7BSPYk+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PS21OXnonJXkBNygVdBmLKpdRtC9qm6E/wqVssXr2Ko=;
 b=sKFNvCfnIPGTPARy/h+kaUZ/RVlLiB7lQJnbZ1XYQuvI1FUZZ+qe4hn6e58N2Ow841k4qb5OSxGn4L6CGnk+Fg0nfVjvhY5gC2K0Fo2fz7eqqUk7qB+JtYMstrLoPV+qqUN4mZGz2g4ZpOp+T9EfHPuvdhJIUSSS3pXiZOsx21o3bLVOtf/pVY7Ha9CMh/rAdQzOmuBMpN0cFl0JfDLmSed265q1YPXPoUQHBOx416ze+n+gegM7tBqeVDcyMsKp3bNCl+iXzgnDB4uiTyNFZHuOdcnG8aX8s9pKnVXJoXnpCv2s79G5fhDppgMq6EKqiCidUw7l7ZbetD0w6JLMGg==
Received: from DS1PR04CA0023.namprd04.prod.outlook.com (2603:10b6:8:243::17)
 by CH3PR12MB8725.namprd12.prod.outlook.com (2603:10b6:610:170::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 13 Nov
 2026 23:03:02 +0000
Received: from DS2PEPF00006E24.namprd05.prod.outlook.com
 (2603:10b6:8:243:cafe::4c) by DS1PR04CA0023.outlook.office365.com
 (2603:10b6:8:243::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Fri, 13
 Nov 2026 23:03:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS2PEPF00006E24.mail.protection.outlook.com (10.167.23.217) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 13 Nov 2026 23:03:02 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 13 Nov
 2026 15:02:49 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 13 Nov 2026 15:02:48 -0800
Received: from dgx-1v-42.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56 via Frontend
 Transport; Fri, 13 Nov 2026 15:02:48 -0800
From: Jamie Nguyen <jamien@nvidia.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Len Brown <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] ACPI: sysfs: Serialize access to the table attribute list
Date: Fri, 13 Nov 2026 15:02:48 -0800
Message-ID: <20261113230248.3569097-1-jamien@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00006E24:EE_|CH3PR12MB8725:EE_
X-MS-Office365-Filtering-Correlation-Id: 76e1e424-a2f6-4e96-4534-08df41da44e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|36860700016|1800799024|82310400026|23010399003|376014|10067099003|18002099003|11063799006|5023799004|261022075727099003|261026121527099003|261009223027099003|56012099006|261021123027099003|261028144727099003|261022105027099003|261102123227099003|261021121427099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
 ODvb5UdY7/OeOK21Y+Xy6mId1/P1wYRlCj8tWPJa4YAs3ziR7GLYEci7NQ6p+TCoHWwsnKUrn0r/3pIF9YUhemGfvzsP+ObOpgyEC8aDVBW99MxEESDe6/xFiXF+FpIB9PLCnL2BplzDUujLUccC3jVpEswlakok0Jv7ECaNu827GNBAWYvN9XCcg15kzKOc9eltD7VDD7YjGf8E5ZiMNnbTU7xKi9qU1xqyFYPSf2YrFfKCLXU7Yp/yorqtADQ9s2TOzAeUSpgQ3tB3g1ObAEicMWGLX0PRYW1pZB83HQEOMlA0oiIAGRzU1LbdszAUbGCWQxZJs+G1i1srp0VjLYncRTYUunACfIIBTV3yRO/c67m3HEYijuKjjk7qo06ILXmnDvfxIpFsCcdEYYY3yfOiID7m0rx2UtqLV0ivgcVxArwj93KjZ7luLiZUFyOavPRNBUAlMkFxQz9ByT1OyDfIhx5QJKOoTL6wLLy1hpfXalni2eIhoWT8kR8CUkw8DK9KqG1RlS0vqSfAos4d8JcgbtdlBTLfx/ZjhXdeMeKTf9xZfzC1OL8dJ0NFUZWc9L9XKoeJOBk7oPAd5XFj4GluNipes45+v+hY1+bnS/UMoWRSDBEUYmc9zyQnXMs36iiuJFYJGWmtrCwDL2wDnG1bgT1+NN2MDO+e1OJCd5WJKmAge1lUGsS7luuxrGQN
X-Forefront-Antispam-Report:
 CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(376014)(10067099003)(18002099003)(11063799006)(5023799004)(261022075727099003)(261026121527099003)(261009223027099003)(56012099006)(261021123027099003)(261028144727099003)(261022105027099003)(261102123227099003)(261021121427099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 2BtWV/X8gmjYmvIdeMatKIu8HyANdLwsr78AR8MkB54NC3I8HfLLR8A7o+G0Aye13GabsfUdUQMV6lbVKL0pNsnEk2xJ8l1+Qm8gTDtpQHE787/uF9JV9wVn8Zv223hNfCYhkYrtGJueVAKUpLyuL9Y/n6v8qcxtkwFnYQHaX4+LywtStm5iVOWpanKE0LgVfJcmaLV5PBTHYfhkBjHQ/WbXTsCUPQemDrRzULY8gMn6iTtN/2PljJjrHzTfyfMkFR53gDjuVm9afbtLMueVDxL7dHUVgOumQfqDNTUBCJxErb0bHRkU5V5PrmbL6+4fkfLkkZkJxYxhPCn4lGZWiaeaVv/i5tmsKdxMYogCBk/tVulHJy/Syit+nQLfm2B2SGlFAa8kaLfc4vWSaMUjAnFavvATYrd8rIricmsOn5KJ4t+8nc0ViPEP478SFrmz
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 23:03:02.3466
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76e1e424-a2f6-4e96-4534-08df41da44e9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
 DS2PEPF00006E24.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8725
X-OriginatorOrg: Nvidia.com

acpi_table_attr_init() walks acpi_table_attr_list to pick the instance
number for a table's sysfs file, and its callers then add the new entry
to the list, but nothing serializes this. ACPICA drops its table lock
before calling the table install handler, so tables installed at the
same time can pick the same instance number:

  sysfs: cannot create duplicate filename '/firmware/acpi/tables/dynamic/SSDT1'

When this happens, the table is installed, but has no file under
dynamic/. Concurrent list_add_tail() calls can also corrupt the list.

Add a mutex around the instance lookup, the file creation and the list
addition, and move the list addition into acpi_table_attr_init() so it
is done under the mutex.

Fixes: 7a37052adb5e ("ACPICA: Tables: Fix hidden logic related to acpi_tb_install_standard_table()")
Signed-off-by: Jamie Nguyen <jamien@nvidia.com>
---
Sashiko flagged this, as a pre-existing issue, in its review of my
previous patch:
https://sashiko.dev/#/patchset/20261110225452.2349540-1-jamien%40nvidia.com

Tested on an arm64 server (288 CPUs) and in QEMU (x86_64, 8 CPUs) by
loading SSDTs through ACPI configfs from 8 to 64 processes at once:
- Without this patch, 3 to 7 tables per run got a duplicate file name
  and had no file under dynamic/.
- With it, every table got its own file, with no lockdep or list
  debugging warnings.
- The boot table files are unchanged.

 drivers/acpi/sysfs.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index d1b57d1246aafb1..47b816c588feedd 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/kstrtox.h>
 #include <linux/moduleparam.h>
+#include <linux/mutex.h>
 #include <linux/string.h>
 
 #include "internal.h"
@@ -298,6 +299,7 @@ module_param_call(acpica_version, NULL, param_get_acpica_version, NULL, 0444);
  */
 
 static LIST_HEAD(acpi_table_attr_list);
+static DEFINE_MUTEX(acpi_table_attr_lock);
 static struct kobject *tables_kobj;
 static struct kobject *tables_data_kobj;
 static struct kobject *dynamic_tables_kobj;
@@ -348,6 +350,9 @@ static int acpi_table_attr_init(struct kobject *tables_obj,
 	struct acpi_table_header *header = NULL;
 	struct acpi_table_attr *attr = NULL;
 	char instance_str[ACPI_INST_SIZE];
+	int ret;
+
+	guard(mutex)(&acpi_table_attr_lock);
 
 	sysfs_attr_init(&table_attr->attr.attr);
 	ACPI_COPY_NAMESEG(table_attr->name, table_header->signature);
@@ -379,7 +384,12 @@ static int acpi_table_attr_init(struct kobject *tables_obj,
 	table_attr->attr.attr.name = table_attr->filename;
 	table_attr->attr.attr.mode = 0400;
 
-	return sysfs_create_bin_file(tables_obj, &table_attr->attr);
+	ret = sysfs_create_bin_file(tables_obj, &table_attr->attr);
+	if (ret)
+		return ret;
+
+	list_add_tail(&table_attr->node, &acpi_table_attr_list);
+	return 0;
 }
 
 acpi_status acpi_sysfs_table_handler(u32 event, void *table, void *context)
@@ -397,7 +407,6 @@ acpi_status acpi_sysfs_table_handler(u32 event, void *table, void *context)
 			kfree(table_attr);
 			return AE_ERROR;
 		}
-		list_add_tail(&table_attr->node, &acpi_table_attr_list);
 		break;
 	case ACPI_TABLE_EVENT_LOAD:
 	case ACPI_TABLE_EVENT_UNLOAD:
@@ -604,7 +613,6 @@ static int acpi_tables_sysfs_init(void)
 			acpi_put_table(table_header);
 			break;
 		}
-		list_add_tail(&table_attr->node, &acpi_table_attr_list);
 		acpi_table_data_init(table_header, table_attr);
 		acpi_put_table(table_header);
 	}

base-commit: 03176329b3f11ca2298f310a47486a5bd2f13d1d
-- 
2.43.0

