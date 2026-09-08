Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012008.outbound.protection.outlook.com [40.107.200.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05CB3911C1;
	Tue,  8 Sep 2026 19:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788896118; cv=fail; b=jk7BHe2d7atQPTHkWb+bmpBzRqtn2AQrhl4F+gLkW1BuFH4pT/dKd+aLxWNxTgK8AlGvhDzyKoLECddvhq12sn9DR7ZOsYOrk/jf+BdCUsQ/mUtVHMlKD1PAKhiXtNgTCNjyHshkRQ6R1OBBrMQRYjsr7KMjOkbzGO3c/ENhYv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788896118; c=relaxed/simple;
	bh=KylsEbYr0hTXnDcgL9HQUo8gs2sJfqr3B6WQ5cTwVX4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TMKL6dEoA2o5zdlmv0pGONRuRLXw8Vb94LHDGL94qmpxCO0/64UdMTceYZ9eiccxsXaV2YpJ3bdR6zUtIgD0JR9os1/HypO6pGv5o07KCMbX6zfrNo5ClfsrhYT7Nua01KqXG59qgIORAo1NDOCkAfQbnjUl7pSXkeaoGM4yzpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZomJAQiP; arc=fail smtp.client-ip=40.107.200.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZomJAQiP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xKp/wsFai86KQ3Jf7IZ1RoTn2wDbKKRv4vXGJnJMQTGtGbVg4C4oJsZMdvCMYf7D7Bie8f95eF++43mRqqcR5Rg7xSWyJsBiwJpnunPF0RHRdgcIFK6hvsp+9r+ihfGdQ7V/WhT74lfSXuQi5Y+XETUtoObiJCrT3tdWN2jWVoyLRVl4UTT+xrkPswhuW/bfq102mMD7ERoJpW63gywHC5MSblSiX2vRVS+6Bfxa2HbmUDqdMOM8ep0gm5IFk2gmZHbKSDR6GjfBl3lwcfAd7d0IEaJC3AlQwZFCFMOXEjxI4eziBORQ2RHk1LoHQJoW64R2UnS+PC+TwB/Ez9ks4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/BiTfecksTtxsldtZ5A7WVz6XqXBaGqOb+8+eqX1dE=;
 b=RsUhmB5cztP+v5Nn6v7yMtcLyAdSNWDk2MLhrjPtCtfdFBQxYz0DsOMDwTq6UT5H+HRInBR7WA4DxBgF4H5C6tN4uSJ7YhN/FhQ2jzelN5GT7d/KC2RCVzeFNLd2nwRziE622uUjgJ6seOxPBSuxZ5Abz64hDn1rlJjVhWHtUuJvZBjc3zapYee3WD7n4kFshIJ+Cr7uxIrHYjGv/zGqEibVjE6MfXLRfVEA5g9+JfbOJTi2aHY9S6cc51eQKwkjS0QAiVSqnvsWvE6yiD4qjpmf/RHijd8jBxX2HjmvRtZTz4IEN0WSIJ/hag3/IvOinwLDRr5ZkBmJs/HyrFXuaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/BiTfecksTtxsldtZ5A7WVz6XqXBaGqOb+8+eqX1dE=;
 b=ZomJAQiP6LD0NoaDz4fZ46zqC/Ved+ndTDgQN+tyagjygRNgDnNIsgzPEgdhHR+U6hk6EQyHW7ABuokGKfjos67B28LNN2cb92hlnwqBIuAhka8CwtoYywFRbpj99D16OlBk7Pg+QRmJFE7akNN/XIIlMuDBNgFd7gQJ+P4M3kA=
Received: from MW4PR03CA0324.namprd03.prod.outlook.com (2603:10b6:303:dd::29)
 by SA5PPF530AE3851.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8c9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 19:35:10 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:303:dd:cafe::5) by MW4PR03CA0324.outlook.office365.com
 (2603:10b6:303:dd::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Tue, 8
 Sep 2026 19:35:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 19:35:10 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 14:35:09 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
CC: Len Brown <lenb@kernel.org>, "open list:ACPI COMPONENT ARCHITECTURE
 (ACPICA)" <linux-acpi@vger.kernel.org>, "open list:ACPI COMPONENT
 ARCHITECTURE (ACPICA)" <acpica-devel@lists.linux.dev>, open list
	<linux-kernel@vger.kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3] ACPI: utils: Ignore leading root scope prefix in string _UID match
Date: Tue, 8 Sep 2026 14:34:58 -0500
Message-ID: <20260908193458.246040-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|SA5PPF530AE3851:EE_
X-MS-Office365-Filtering-Correlation-Id: fa029d23-9e66-4577-264c-08df0de04be4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|3023799007|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	aecyfIZf7iqadIJvFfokI43GoefqL8kXx437Q/OISg7cuheu5FX6OasYD7iYbcssGX8wT/KUppMCNAIgxZgyEjJBnStgj2lCamRLxF+J8csMY7laQS01L6rxJGWwlBXn2CPMQYEOdoYxt8dIMCNiWPjrOt4uUGtllNGFFBaT+0xGvd3KxSvu8875uGId197DWU2yJI2oGpf+s9zbUGkuY+mlwWHdAlWbM1gfHo7Gpy23aMelbEjHvHvfRyT8fd+hkwf+ZijvOwGCtsnS8onNjXSk0weZI2Eh4VEly2cHq+GtoK1ZLI76pYiRMN6DlLdMYUCbqhYJ58mblRbEu8mWzbbpQfVmvFlb/kb3+wQuiy29YMC2TdLZur5GQV9x3/oe69/WxAwhnaml4BbUZzYziTh54juGsllQFTdj4k3BD7eiRypBiU5fURG2ae7PmS6UkN0Lh4xxWiSdfdsCyfDJAkzW2QFWwy6qyjhAtrwdiSKcEfDr2e3XkrQ5d2veEe+z8Uo5TQJTEUiTBQk3ROnYvtEYi0h8ty3EMfDXOAUqSpI4o3J4+qfGVZzsqgg5iHthYHSeTPnqrnmvFMuLsBW+NCNaTo7zEmL8CTC2EDgbdvxKpxfzgx4yVc7jqUaIa0xB3HPr5eCv8/u5h49vsOuR7oC6f5vRjZtgMqO3+OKn/Hx3suF07nlNM6yZlEq1EaplYZBUIP2b330AI0Nttw2GTg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(3023799007)(10067099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OkI3iqeCMzpr+31cAwl+NaZQdE6Pt5qq+P/dX8zZZIby7c+4OPmcw6Qyvmh7dGiqwbZ+S4QoL/2IAGBFmW635s/aggGlWodiSjFH1D5HsJObf40PX4ol1Vlp4rlyXRLnLcpaT/5flc6c+RD4EYr7+1fbVfZ6cCcNFvXnR8Gy+blhMd+RZe6kDJzzJxHK1HKJ9K0HWBo3tFMFbg5OZowiyGarbFruj2Wbr5ZtdDnHaulwYk6JMyykj+MjDIAk3/WlIKMfNG5dv/jJox2ZcWgyIqvPqLft4TKXhfG0oza8kCXNuBk+uklaKVla+SAblExUvkvLT9eve6GB2BQcWSRxn54T9vP5gwOIKQNceN0Fex9pl7MYuuRg/eieo8O48sByWK5xpDFJ6k/6SHWHuXLahgM5ri+Us8+rKoDZhaEa6r0pW/IQCN4lHdH5T6RCbE5Z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 19:35:10.6175
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa029d23-9e66-4577-264c-08df0de04be4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF530AE3851

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
v3:
 * Update kdoc in acpi_dev_uid_match() instead (Rafael)
v2:
 * Add kdoc
 * Make sure the string is at least two characters long to normalize
---
 include/acpi/acpi_bus.h | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index a10a591c18b23..f506a73169d6e 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -830,7 +830,15 @@ static inline bool acpi_str_uid_match(struct acpi_device *adev, const char *uid2
 {
 	const char *uid1 = acpi_device_uid(adev);
 
-	return uid1 && uid2 && !strcmp(uid1, uid2);
+	if (!uid1 || !uid2)
+		return false;
+
+	if (*uid1 == '\\' && uid1[1])
+		uid1++;
+	if (*uid2 == '\\' && uid2[1])
+		uid2++;
+
+	return !strcmp(uid1, uid2);
 }
 
 static inline bool acpi_int_uid_match(struct acpi_device *adev, u64 uid2)
@@ -856,6 +864,9 @@ static inline bool acpi_int_uid_match(struct acpi_device *adev, u64 uid2)
  * @uid2: Unique ID of the device.
  *
  * Matches UID in @adev with given @uid2.
+ * If both the UID in @adev and @uid2 are strings, they are compared
+ * after optionally skipping a leading backslash ('\') if the given
+ * string contains additional characters.
  *
  * Returns: %true if matches, %false otherwise.
  */
-- 
2.43.0

