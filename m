Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012043.outbound.protection.outlook.com [52.101.48.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6625F326D44;
	Tue,  8 Sep 2026 04:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788841934; cv=fail; b=urLv100qaINUgybsmy+fKw35C1ZTVuGItvZ1WwhaTdDYEOYMr3gWRMrvqa8I58wYn/g/KQib2DRoTNjsUw8mCwBLOiFYUGQZOXaYK3BleGuSXsfHv0U3TYAQ8VEQ3B9HeykNhSqXEkRw8c1AvfKHmBsN2rKzprFXqGq5fg/OB/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788841934; c=relaxed/simple;
	bh=iyCfKWNkUE/biSj7HaDHnLoPDXw3Oa3aZBr2gkEua30=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lhPT5tzo6zwPP/fxPRgdSietZ5S5cb2gyXZb3gRM58ep+xKdV2jtVJd2fIthbotdow07l+VKgg4Xfgr2WsAZbT4qAugkvydL6IIjaB1tj5RBYmtjkyAyi2AkovnpwNf6sd8uFSw1iqzTmuI2ubDx3G5PhMFSZ1OSmvmj5pLcBmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Vo02fBYe; arc=fail smtp.client-ip=52.101.48.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Vo02fBYe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d/MQ15OOdICLp0G5NOdjOM7JJpnr4TTeEySv9BR44vH+RNJYkeWMPS5cK0GnGr9/VhgHLmcmRYDJb7UweBgrg/WbzvZ/Oh3MvoUk8baTuPoMkLuhw2d/0Q3ZiGJSeJI/qRDquogVhBgx2njNnV07WsZOiN7MsxKA96Rvqi3kyqZZyB7ZiA8xP4yRTY1sAK2dFCYqD9cDhW/JwO75MJrSbo5/6F45H+FE14sk7t4ytiC3oozd8RyHGgCVTiy7wGxqlaB9573mt/ZBCQVDU+irw5LO/X+PBHhB5GmicyC6eBVoSxFGRss7oTg/FbHq1owLXDGHPI8aEtK3oyh9q7zQ2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m8NXlpvw6BvXaGS4s0zm00jlqvSNMBQId/ARa2gC/08=;
 b=hWlm2jJIqmbQSE2M9k08PLMFESCZRkoBcF5m0Yct5GWtWZr/3Jv+krTFRqCe8WzgvNpVcbSHJj9OfPheGY2YW36fZ+O5O/6mMJb5oj02jYOyKgKE95Z0ArbALQD0s2z8FcpqHgnCrImPNCgGofv+L+h39tg2ypBwql80bfM38o+955vZaCne6lxCwD+H2sF2lMcj9BU30aiq+pbov8LJOVKFg36Wc9uR9wPxSV+UQUlbr8kcSfH5r8CBUbxLscA+2pKurYeSLZPQrBMQDcWJpG+zzF/Mzv2yhmt5gomCQo81Xhn6+i3hy2ZvpWMW/BvtKN2JX5eCkhwcAemrRKH2LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m8NXlpvw6BvXaGS4s0zm00jlqvSNMBQId/ARa2gC/08=;
 b=Vo02fBYegcfs2wCWY8mAv7DWLUFYkP7RFOyA0/6Q7pH2bTaf62iV4XijzQhNoVzpQ8z3M843UD/otbP+1sb3XJkFR2GWx5gzD+wjtQtE5a+dfbfh1WRWJaZfnHL4Lcixisl/RxdxvQSirOX4rOdQ7YEfQzx0snkiX4HIla0UIk8=
Received: from DS7PR03CA0128.namprd03.prod.outlook.com (2603:10b6:5:3b4::13)
 by MW6PR12MB8868.namprd12.prod.outlook.com (2603:10b6:303:242::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 04:32:06 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:5:3b4:cafe::aa) by DS7PR03CA0128.outlook.office365.com
 (2603:10b6:5:3b4::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 04:32:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 04:32:06 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 23:32:05 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
CC: Saket Dumbre <saket.dumbre@intel.com>, Len Brown <lenb@kernel.org>, "open
 list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <linux-acpi@vger.kernel.org>,
	"open list:ACPI COMPONENT ARCHITECTURE (ACPICA)"
	<acpica-devel@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2] ACPI: utils: Ignore leading root scope prefix in string _UID match
Date: Mon, 7 Sep 2026 23:31:24 -0500
Message-ID: <20260908043124.53175-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|MW6PR12MB8868:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ed72bf3-244b-4277-2fd0-08df0d622394
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|10067099003|56012099006|11063799006|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info:
	ldjapXyGT1Kn/AlNkVyViqQQeDeGkJq7GI/96YaWNv5k1pT/CIKv//9TRj+MPAeA2EXzLgdn/N70cR05xwaG4Z2qPukJ57OU3SlzzeV7CrUW8RJXNFzF8UcWIRIymKYOnGQ5sXUxjibvFDAdm7Xyg9ZDLXTkFXte7uXUi8oCgLb5jReSN+aADuQY2hAr379pUyhVXDODt4bu13/4F6OVRqRC2RzO9caWjC3/giiUuMPHS7bVFzlqBVNGNMCJgZ91rZHoCkn0LKVlV6I3XVAbXShn6NefEBKqybhusui0IBxudPe4BuDUGvGCr7Gf2rhKUJ2yTW1JFvv94CjJR9ctAxQzFbr1rMFztfkPwa+ViAw9WARaEG2QWe+73/0DZrUuElTVx+oJi8YdiHy1bWHYl1tvDfFFgZoT2mZGjA1AM7xBZ8Z4M7JHkNmaInht0gldJCgZPOU9Cnod2YtTkX9PTPj4h83gj32gXHbxpnn9U/5OT9wWEly/fWXwmhIu8BQU6rZSaO24kjct4SI8VTpAKaye4st1s96MhyOld0Ojdtmu1TjJQzLe9lgGJaEtA/XB1t2SIEhHZwhO+fVhMjeyMCWCCfBhyhxWvG95X0d/IRhImp4WC8lkJZkm6cWinQ7PzjW245sypXCgLgOn00Bh5clu9at/C/CXbJOZvCsSBFucHJ8FMrU9gkT3I2EW9VKLDhbIEiyrNsi1Z5BlhqA/GQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(10067099003)(56012099006)(11063799006)(3023799007)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hh4WQOgkwqQTC2IpGampmu2Aw4F2oi0CzChN3nTOAwM6LQRIBIQt6n9IQLshdQbYu2DCtUJsvteQvH1KWGyqADJiYptrXW1mJeRcT/C5jQ5qfwAeai9hk7nsMge3O4a0TsZH/NeeEcWzwBd2FbvD89oFWBuRQx/cPpy9+sJmc4B5F8I0neH960i2O7TvU+Ut408WdOkz4+AHOBQz6K250JNxBJGvCcBWxk2GeyPMeL79t6KXMvgt8cDuJFJEHM/nbUp9i375zzr5Bty+KZWBNdB0pX3Cbo06GOYKcZg6b5zFEfsvUHarRY04TBCrVxUknGqm5qZYHcdR7Qf5+VEhw8Hpb0EevlghIIgdp8ehPgGADqSaZ5VfsZ71xlkuhWzG/OXYXgHfNByfj5UUJvTWh63F1buIHafdwtbmplNomRScyk1BPlzxJHkBE7VvLz76
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 04:32:06.3977
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ed72bf3-244b-4277-2fd0-08df0d622394
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8868

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
v2:
 * Add kdoc
 * Make sure the string is at least two characters long to normalize
---
 include/acpi/acpi_bus.h | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index a10a591c18b23..cfc3c8a21cb8e 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -826,11 +826,29 @@ static inline bool acpi_dev_hid_match(struct acpi_device *adev, const char *hid2
 	return hid1 && hid2 && !strcmp(hid1, hid2);
 }
 
+/**
+ * acpi_str_uid_match - Compare ACPI string _UID values
+ * @adev: ACPI device providing the primary _UID
+ * @uid2: Secondary _UID string to check against
+ *
+ * Returns true when both _UID strings match after optionally removing a
+ * leading root scope character ('\') when the string contains additional
+ * characters. Returns false if either _UID is missing or differs after the
+ * normalization.
+ */
 static inline bool acpi_str_uid_match(struct acpi_device *adev, const char *uid2)
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
-- 
2.43.0

