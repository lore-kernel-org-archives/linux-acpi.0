Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010067.outbound.protection.outlook.com [52.101.201.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D4713635E;
	Wed, 18 Mar 2026 03:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773805842; cv=fail; b=D8Xk5zz1fC23r9sBOzHangx7P4oX5EImWDuvJy9oHbMgkzyzmpc6oIbz4pJ4OSEo/3s2NmzEkaTRTTb2NKsE76cE3dRyuTH5b3igBy6AMuQ2Ai8MgnRHFCCG/pT9nc28wljxsWxZZuXBldZZZ3/pM5kByEUnXeemG+d5dd9NkTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773805842; c=relaxed/simple;
	bh=rX91nvyUMkJwOpsFCOawPaaTZh43vqJ/aarCje9DRYY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oAWKS6dgTDAdbMeKRh8q29VrL6+9daOT+tgl6zF26xB5VqZdcJeZFgAbaUupgSWiYfykyoH0DOz2ac5zPGg9ujsfS2gAeHFZQ3lePSRsmXyHDgSvamP8AjaDvji2M5mVFFiQygbVXzBzJfO+Qe80o5zL6ikGKFGigCPSUG0V6Bc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NDlHD0+p; arc=fail smtp.client-ip=52.101.201.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NDlHD0+p"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ItAlywAm6cNIOMOnLf/wseNO24KL71UhXC7XgRf6FTdSpPl51GCIPxjJH9OqYlHuLo7udISBKE/wAdQ7/hJmEHWC1UlyecIpkQTTl6NUzXWV/cwCzSjo/4/HSczypPNsQ1g70uD79BqWVjPBnxT069q34tSCvqW11wlrK5JkLoXb8oOWCbmpaQoVPwYs2I0+CIzaeS9FH9GnbKphuCGz1R6lzS6TXnVK3ZbcZXfP83efA5RPAtLKTfBfssylWbwZbmf1U6+HtpVImNx07CG4ou4QLEKUQHbtduDZDZXfEe71vzyVV9xBLwb1QYvW292xhMKFOuOL6o1e4yyHZSS7rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KM+9HkXYfrzszsIPbQQVxa6QbrTOxovP35UqfCQzXv8=;
 b=ivgsdTvUOT+4rviWf3ZEDRO57mYzBocoRMh9uptR0axHrY8EGzUZ+LplcriURP7nn1pt4dGHwcSOeJwlaMy8qF5Oi28UN2V4c4jpszu9yECzOzNDl5z6LVwTuDGGHNul5jKCVGCegaxNUBAN80aUPZDVNAdKZOZnFvL8UWEiLEatgi4KJsuNlruSiQeNSAa8V3LFZ4w3zPV3e8MTGIolKnG20gCPn/fltY/uKPkeXm/rhneh42Lw2RxjoPCozLdJrV3tQBZWdIPNAcyPBNSo8AZLmqyjpGrrrQhTGZml/Cc0ABqnZo3Wrtb/6iSRW5SSBMjJ9y822YOalAnxKBPcvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KM+9HkXYfrzszsIPbQQVxa6QbrTOxovP35UqfCQzXv8=;
 b=NDlHD0+pjvyCpoeDHpb7HvTI94wwLpzrqA08V9If3Y0eBalpGvt5CPiiVUcP0MCf2UB63caahGLEaZK2a+Pr9T84v6ouSd7JNizIk7+FC1q7iwoy2cNRlX/HDTR8AvNJiw480z6rPBaqu/GiGOh2UphyUMxgCH+yedM9gUONvqk=
Received: from MN2PR17CA0018.namprd17.prod.outlook.com (2603:10b6:208:15e::31)
 by SA5PPF9D25F0C6D.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 03:49:16 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:208:15e:cafe::22) by MN2PR17CA0018.outlook.office365.com
 (2603:10b6:208:15e::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 03:49:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Wed, 18 Mar 2026 03:49:16 +0000
Received: from STXH3-MAPLE-10.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 22:49:15 -0500
From: Pratap Nirujogi <pratap.nirujogi@amd.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <mlimonci@amd.com>,
	<bin.du@amd.com>, <alexander.deucher@amd.com>
CC: <benjamin.chan@amd.com>, <king.li@amd.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Pratap Nirujogi <pratap.nirujogi@amd.com>
Subject: [PATCH v1] ACPI: bus: Fix MFD child automatic modprobe issue
Date: Tue, 17 Mar 2026 23:47:57 -0400
Message-ID: <20260318034842.1216536-1-pratap.nirujogi@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|SA5PPF9D25F0C6D:EE_
X-MS-Office365-Filtering-Correlation-Id: 4961767b-cb7e-4a86-5fef-08de84a153af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	FmYUtlxCR653uoRCHnd08Sztp5bxndcncqUAHXOe12syYJtRX/XduQX8qR/0LBb+3PH1ud6O0J1q/gbHnK0SViZWLtqJXMl8GRXeR/TIHjvCCTq2QTCsxycij6a8dpHJMGgG87ojL4rArn3LZURiTQOJR9USCpd1PHipdHzFVPvexzVH7nUCxnsOl7SMaYph7KTXXBlNDDgNiG+CpNUWtQhr1lGcp5rGhn7mGkTgKbCbzqTw1PqXHLNGoJhEDhjM2DJaQA0zYRg9MawpG2zbukalNs2xyaVcgGzBeOQod9OhRbyXM+0ZyRiByqY8uAkyTY7twi8toUffdOE9obmJY0R1myXvTLOVXKOiFyTUcf4T4rYOHlOiVay3hJZ1tNfN5ZKfPet8lFvsOpgxNvhTAP91F/Eso9ABvS8JLpjFTdPQ50fMb9q5B8g+uU5t/HxeoNx4GdIZXPN3PdFJK/wusHO2nVaktPeYC9MTia6UskkVR1Wbswdbk0Tw6aInAeEQL/a9wyDowKt2RECs/L3La+LcqE0BDILy1q3B0IRVcFki3pQmZ8f7K57tKMap72NAK+lAuRL62dl/S355S2gPvsBH0OLsheYvKTsEa3e81mjPrvZDzChayl5o5Wpc3SxUzM7zSr/KjCc3C1fkTmObSnpGAYqUEWQlG2To6hM3oReY04e4HIrA4qbjvKQeFOKqxBO/XTlJM8i8hCRursDT3cUlhlIp6VbVCLKba9Sic/sKGwMQFv21qhotulrDsqB8fxp+hi383zPa1h7wcZcwHg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CzmfEwZZzYu2WmH5MR8MLPkbs+CdqRAX7TwvAvHe03/HFZdgEeQ0LxGACN15zJ/5sZYCdeletaRu7iNF5WfanX1rQ5c2cXIriUTW/8+lBnULFC2o410c0gS5DPXvxsL0GMnHkAwPeEN5LSOCkUM0vATAP8bP2SoWi+dl17dUH33Yma8Vf8sAxOOhVQq6Ig1hvIF+pmqSKTjYZ1uGD2EqADNUq/Y+bXJ+e8hcUMuTuM9JndjU04S1YpLb+otYCjY0q9ufvxb8hHuRCZG4kKO2mAwX31OI7T+vbWeMBqxzmYQUIk1sbJ/6fo6wpERsDAAwahsRTRdJi1h7DAN1sr+rU3Yaj3NIu3cC+91Y5+8TVaQF+tBSFKs3p9ZJ+OoXGCwRPHmU8tzg78peQ9S5VBqrzylhzWF+4WLtupk/PzhWzajURzk1x1T2i85iGOxfsquJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 03:49:16.1352
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4961767b-cb7e-4a86-5fef-08de84a153af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF9D25F0C6D

MFD child devices sharing parent's ACPI Companion fails to probe as
acpi_companion_match() returns incompatible ACPI Companion handle for
binding with the check for pnp.type.backlight added recently. Remove this
pnp.type.backlight check in acpi_companion_match() to fix the automatic
modprobe issue.

Fixes: 7a7a7ed5f8bdb ("ACPI: scan: Register platform devices for backlight device objects")
Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
---
 drivers/acpi/bus.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index f6707325f5821..2ec095e2009e4 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -818,9 +818,6 @@ const struct acpi_device *acpi_companion_match(const struct device *dev)
 	if (list_empty(&adev->pnp.ids))
 		return NULL;
 
-	if (adev->pnp.type.backlight)
-		return adev;
-
 	return acpi_primary_dev_companion(adev, dev);
 }
 
-- 
2.43.0

