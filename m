Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012027.outbound.protection.outlook.com [52.101.43.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E14C38425A
	for <linux-acpi@vger.kernel.org>; Mon, 31 Aug 2026 18:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788199354; cv=fail; b=ZkYkLA/iO0VCT3xUvrpp1CeXZXUxWxgv+nnzf21HbYHoWkl3YexoegQmBkJQx9xGeoR8oRUC2JH/fIAsYgT4VBdN0f6I4+xwrbchM8kofDlkYWAREOlLQnOt2jRmDcioMKY8RUiKgW5SLVoKzWJZzOymMvm9mK1xSyfFn4aElFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788199354; c=relaxed/simple;
	bh=JQoZddRna1lCvCCULtqHmthEpMykWHkGiH9VMNPXmro=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iyc90E3Q59FLGxqIUc6+XrTTMEymZOvnPfZ8WtPnE22yZ/aHaiUbjLJLC7/qIqny7xMmkZWB/3rJlRzTBhzFxdf8c1XL1ZaXbn1p3p/4qoyHWYxgv31pWsF62hs6zeyDxG4rgvKQ7i0jeanupFNM5xWYbr74vse9aE5+dRz2gVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rp6QnnSs; arc=fail smtp.client-ip=52.101.43.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rp6QnnSs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mHh7VKT07OO+prDnP/7yGsrNeJ5QfPf04STPIQNvvxwhnCyw4muSRXGqaaZU9q0C02YdER02Ig6coigFD6ipNh29vpGuehoSFA+aXOql8zTmiZFGVB4kIMMOWIE6t452/SqtENLYi0jmSHBTNpB4v/ZMepja9xn08dD4ICbjVqa2cETWtNs/q7qiBVwWUmB7cOIg7z0L21EmjUT044ZwPNq/wDVU1JxYqbCeFYLcc8q83rPCNkI122q7RK8Sgtz7abD9EwWcDeYeqK7RykTEi2epZjBt/7MbRm9xfjDWVRUA8VXhBVpcjpUhZZbz51urzat3XaQAdhdxZ3nLoQHD4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vep0fNm5+1q1VJ4xqbtaGqhsizShlFu+a4g2DxWUVjE=;
 b=LDi2rdBlSVRUDhVl3pz+FCytykIyZG0xZAA+538XffEaEj3OHzypF51ZnxW1CABfOWTu/EGFoHcUjDHv5NZAznZvS4N9R2G3NFFVaUkx5M2RbX9JoQXCrPHB9WpseX//sa1GgsPJsCGFvpX0FyKaB4iBsy0C9+iyK4mqlJZ76X6Jw/vc+ey+YgDwJNOXW1WN/OGzwK8aWwgD/iBg+tBDcpOiJoBBLhjtKjqt5W/PpiPPP8OZcMDxZMsbv93nSQAGyJv+rMnyugxEVoYF88yYXN2/GV7dNt3MwQEYTFtKR4jxuywhQhPR/mAOl9dv43goODU6nZR1Rl0pkSgUenwC/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vep0fNm5+1q1VJ4xqbtaGqhsizShlFu+a4g2DxWUVjE=;
 b=rp6QnnSsmhIpkLY/DWTk9hM8crjzLiC/9L6wVew3IOfsicSIzfY/VCYrzr0y1sYH2dkJPCnU4x3o3wrM9HgMZVjXYU4WJZaUKJvpSX/TN9tH/yXTTwVo+jnpGIXGfLwCh+zZJh9IefxO7NayHu38RXJArMc5zu7Fi9P9DUbc4Xc=
Received: from BN1PR14CA0013.namprd14.prod.outlook.com (2603:10b6:408:e3::18)
 by MN0PR12MB5833.namprd12.prod.outlook.com (2603:10b6:208:378::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:02:30 +0000
Received: from BN2PEPF0000A802.namprd02.prod.outlook.com
 (2603:10b6:408:e3:cafe::6a) by BN1PR14CA0013.outlook.office365.com
 (2603:10b6:408:e3::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:02:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A802.mail.protection.outlook.com (10.167.245.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:02:30 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 13:02:29 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <rafael@kernel.org>, <maciej.wieczor-retman@intel.com>,
	<pawel.chmielewski@intel.com>, <lenb@kernel.org>
CC: Mario Limonciello <mario.limonciello@amd.com>,
	<linux-acpi@vger.kernel.org>, <acpica-devel@lists.linux.dev>
Subject: [PATCH] ACPI: utils: Ignore leading root scope prefix in string _UID match
Date: Mon, 31 Aug 2026 13:01:59 -0500
Message-ID: <20260831180214.2231161-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A802:EE_|MN0PR12MB5833:EE_
X-MS-Office365-Filtering-Correlation-Id: ba0ee50f-1afb-438a-14ec-08df078a0637
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|18002099003|3023799007|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	suEf/lZTB2yZfCN4hh2JdFCUDsWP30k6xb0wDC11kLY5HylNeuDQS4UMXvCoy4551HBKq4e19aE8KX2ba2qfOKiQbf61UDK6LkayhGOLdwgLARPkhQE5/SZAKCu3E6FZ7gXCJtaLkqgl8FMuFs+KLR+i75BsAUVL3wjjnWI/7PcZhttYuFN0AV1pzBCsDZ95EHbjyOsdiffFUk+am1bJVHM89QiyO955X2cBQFqA5IGj200hinhu6ZWYOySFGU72X6VXeP+wI8Dg2B1IlQYTzAX9yaQetSii8de9gzWMbMEiUXpjsyAxwZE6NpLZ0pueHj5WFWv4f0UK5T3nT7SIC/GEGiS05wMpH61itdhMGrlt4ABmRUF664VC2srk/Q9NsXExNdt1HhN6mWuYHEszs3Hx74iD13+QXuAI00Pm2puQhroWebCRG+UWVI13OwmU5U/+pjgTYAgw1I2LMjldrO+qrFge0QJcNLkjIM8cPvXKpW4ff1vdnY5oRQJhmD6YypL1HXIbQ8K8ccPmoFhUPLAPK+7YmGQGjNhinTv+a74iw1I5vydRgm6lp7AnDeN2fZCAfbamN6a8fjrwBg5kFjR4Pfd2TkvoxYZ4CP9XGKKjezjBYwtsEJpx01+G5+q/v3g3B1pIvp7gPgkb2TM+KQUVHJvNdelak0MzNpc5EHUkRqznXDkjovCfINDL3lBU1WZu9SW8gW2f+ybGzQjbeA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(18002099003)(3023799007)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	u7vAvUCnJLqqTegaTAwU/UHnkuuDqA6ap8eEfixWkobrtuG1rOuuNM2/qu5dKrLLJOMJ++bLfV98UbEu2AkkMl5XZqPOS2wxXejuLRtI9bJZH+jaXpcX6OehkNIUpgPpw/NW/RmlDq1XRF2QYsR3n8bsQsl+hVP+RXk82pJDpZdxxc61CPe8Wur6flPz9t8E5MMbwbE4wzCOem3MEctBF/E5Pcj6+djVvCZ+GgqOEAik3kwsII23Bf763MYHYrgMY0uVz0TwTKvpuCcRfXczSETUFS4C/IYmSe43o5/U3KLh2ZCnW1HkYqxEFcu6fUbUw50s1MxWw9Jq/it0CpbvtHoWEN7s+/FJ/Pzze+aM1MnvAFPK06TrIOMMVETi2ytMBrnhzhZ5e33N5mEEWvjRVaR/m5jjj3upwGqua3Ig/rRZ4fOEeoZ9IJjSKovnUnx3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:02:30.0660
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba0ee50f-1afb-438a-14ec-08df078a0637
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A802.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5833

Firmware may express an ACPI namespace path used as a _UID with or
without the leading root scope character ('\'). For example, an AMD
IVRS IVHD ACPI HID device entry may carry a character UID of
"\_SB.MHSP" while the corresponding device's _UID evaluates to
"_SB.MHSP" (or vice versa).  This semantic difference is due to how
Windows PnP enumerates and uses devices.

acpi_str_uid_match() compared the two strings verbatim, so such
entries failed to match on the UID even though they refer to the same
object. In the AMD IOMMU case (get_acpihid_device_id()) this caused
the exact HID+UID match to be missed and the code to fall through to
the HID-only path, spuriously raising a FW_BUG.

Skip a single leading '\' on either string before comparing so that
paths that differ only by the root scope prefix are treated as a
match. The integer _UID path is unaffected.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 include/acpi/acpi_bus.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 1a45e0d521d8e..e0bec35953ef1 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -835,7 +835,15 @@ static inline bool acpi_str_uid_match(struct acpi_device *adev, const char *uid2
 {
 	const char *uid1 = acpi_device_uid(adev);
 
-	return uid1 && uid2 && !strcmp(uid1, uid2);
+	if (!uid1 || !uid2)
+		return false;
+
+	if (*uid1 == '\\')
+		uid1++;
+	if (*uid2 == '\\')
+		uid2++;
+
+	return !strcmp(uid1, uid2);
 }
 
 static inline bool acpi_int_uid_match(struct acpi_device *adev, u64 uid2)
-- 
2.43.0

