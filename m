Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012033.outbound.protection.outlook.com [52.101.48.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB6646AF00;
	Thu, 15 Oct 2026 19:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792093186; cv=fail; b=lQ/YPym37mBjxu5MgWbEQkgZccqwMZ1Nmtc27eumI+XjuLDjsuu6PCTz8nRTFmHeCwrcvERwmgTEj/J1G4yWzUMHPn/pynI5CSoPmjxBfP5cBRQQ/ij08BtuhY4Onvv6jCYNhU2DCiyVEqpLATiSoeqTr4/y1zd+nNZJ0l99yO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792093186; c=relaxed/simple;
	bh=LKM0zP8QaoW0PGwXZT/+N3lLfM+sxaQqR6lFTefHVX8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FPifDcHNr3sGtvnvQpU3DkZmvdISJUixbYpJqmMIY0rm8d4Nt1loGekz9IOGBYSoeC8UEryYJRm9YkeA2kDgFMQn0ciwiEbO4vY/ztQgC6Jb7pSc+3D9NBJ6KfIxZlFuNwzgQWClivK/HF0YXEwuKEi9vsHuahEibCVfH5pax9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wmx22Vfq; arc=fail smtp.client-ip=52.101.48.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wmx22Vfq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NkHLp8wgCSUzXPHgvBWPV1FsoSIfttrjPc2CbzAFskxhGRubRwI4++lMunpG4eXYZUfTSBZEgowI+crRfZm2erXyLbZZX+oTTkB9P1M4bNfqwA6hZKzJ/U4SGdfFvAA9kSooZOyZhgekiLQ34/wR3qmpvfT9cYoCpPNCNtNGVzlWlafUUvBZLMZHDlVS7aSVPB+nbzFKWshBPlkd9vRB8tVQQyV53KYh960Jx/cSJIj6d9YrX7Awx11pKZextzeKPWEGRlhgogp8IWBhIeorImvTkfGhFVPOXvhJ0I+ItM9LcgGIBZ9dr64H2oEv5Qp4SJPD77VG2Hkak4sLV5RobQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AQ77f4NcwDdSiz4APi/h+TkpvktalQMSor72Huy+KHs=;
 b=b1zy1qWVSq/x+7HzkEnaL0lZdPnoaff12NLxG6L15XMzCOWihhAWmOnBiUStM5ixKlIhuWv6B1c4FCFZeJNycVqcPyXS7s79SDeo9Q/IMV9iASfU7zvNtmAIdCQIwDZOtmhv/R/BvBNVDlkQFNujJp34jLmfp7CKvSxP7RKekynPDDKxn4KwSPGhkmIzu6cP124eFFjAasqc4q7ZcO+tDbRL+HR9mde8EP6In2sCvsIOVbWQLcCwEyH8M+VqNi4lRlTgGr5rGiRi4Udv9OrCy9s2mTNs3g7XQqEOVqEi9WmM+Q75qfacZnb/53mLgjTGJWB3MFOHnWInNtZRpXTo0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQ77f4NcwDdSiz4APi/h+TkpvktalQMSor72Huy+KHs=;
 b=wmx22Vfq6jO8NX/ty2eUOQlS+2OIgMvrkS9F6lsZTPk9btui1F/PBWdRaM2yvaB72wAfdoM/bavfEUWOqyFU3hzfZyM8zH1tnupcuuKj3QYVwATMiRQitM5flmqERmJt1Rdou8BisMXyvBgjSH2wPF4kRBrzEWXQmLmNZRvCIdg=
Received: from DS7PR03CA0133.namprd03.prod.outlook.com (2603:10b6:5:3b4::18)
 by DS2PR12MB9685.namprd12.prod.outlook.com (2603:10b6:8:27a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 19:39:36 +0000
Received: from DS1PEPF00053453.namprd04.prod.outlook.com
 (2603:10b6:5:3b4:cafe::53) by DS7PR03CA0133.outlook.office365.com
 (2603:10b6:5:3b4::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Thu, 15
 Oct 2026 19:39:35 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00053453.mail.protection.outlook.com (10.167.23.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 15 Oct 2026 19:39:35 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Thu, 15 Oct 2026 14:39:28 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <westeri@kernel.org>, <andriy.shevchenko@linux.intel.com>,
	<linusw@kernel.org>, <brgl@kernel.org>
CC: Mario Limonciello <mario.limonciello@amd.com>, Mark Pearson
	<mpearson-lenovo@squebb.ca>, Nikodem Sanecki <nikodemsanecki@gmail.com>,
	<linux-gpio@vger.kernel.org>, <linux-acpi@vger.kernel.org>
Subject: [PATCH] gpiolib: acpi: Ignore GPIO 11 interrupt on ThinkPad L13 Gen 2a
Date: Thu, 15 Oct 2026 14:39:21 -0500
Message-ID: <20261015193924.4081906-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00053453:EE_|DS2PR12MB9685:EE_
X-MS-Office365-Filtering-Correlation-Id: 16fa62a1-aebf-4420-1ab4-08df2af40b22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|6133799003|18002099003|10067099003|13003099007|3023799007|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	8b1L2KNsicdBPoP889e15ImrUu+H2i9s/2pfQvzeJ/Tp8UMolMj6+NjHkHS5WFPlYSAG2oKlipCLWXxFP0kmS1K6kJ7tP8lYcqRY0HjTqH7fcVrAkVSoILSQ0nz8eX2c9VEh0K0I4ttW00aei5zi+9LdU0v9YQV/DkwAUENXICMltfTYrEEEHRL3X+nMyemkeNig23ameE9P77TplLERkQ2I6ibhHldRhtaufQa5rrJpJLVKIDjOC7d5LVvsdCKl5/4wpwUsZpp1DN5iJyQCHsE7D2hFcVic8GSdpc6GnYiJ/0TdvHzU+K0fVfvBNzITxCPh2pG04AS7+EAfsYZgr6BGRv5cd+wsag4ydR1ZWHi6flu7W9RKktmJqDXLJfUCDhBO3ChJXYXW/OHp5Pl6wGdoCqycCHlRnxHRufcJWR6Dw4gVtpTaCJ/0dHYQEHT/fJyuuvoPqpo2X/4SkVuskgiT+Oqq+lf0nHHJyKqX0975NLqkinbC4J6UlfVgmB05Nt3hJsWL/gF/JuqA+SHZdYJ4zXgcGGknzvWydBOpu24EyMCfs165dBeU34QRb00/ztiUHwHKo9Paor7FgQ8cr6l+/OYFMazngspXJqWCHXp3282eTrv/RbOtWPGH63N4EPt7+tUeDu7yjEcaWLFB/w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(6133799003)(18002099003)(10067099003)(13003099007)(3023799007)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RxOMCMV4z5d6ivPG2ORsCudE4HXPcz7eFk5mcUXqPuxN+n2pWw9Mib4+0n72F6UIwg3XVNf/Y+AuhuDC+XQX4JlIZwtbVD4dC3vtLyxv+/X54cBvoIlKkxAamNe6GA+oX/MAC7MDAYjjm+iJe8LHtfQVsZWUWlr8UrRGwPcKwkI71901vitbqU/Oc1FjIZZJelk3chtgU/ULvwmm9y5bYDwCJIaePEiwcePACTy7d4LsPSgoCRlkNyJQfclNqGWk9owQv0N5lEXl53K6bAcmb0qQbvepDFJqOs2M0pjZW+hK5Mv6Gr9o5od3ZzZDhjLpFm+frMKuX8XYb4YlXjYuydVNEmYbiuE3the9GwUkJiRDBydXwb1JkJzxNUwJELc/HAoptjVWQIXIfGm0wGgxJnbv7awDR8sd2ka59/02bxZEHKiyP9bopGzE1XNT7sIw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 19:39:35.6237
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16fa62a1-aebf-4420-1ab4-08df2af40b22
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00053453.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9685

The ThinkPad L13 Gen 2a firmware declares GPIO 11 as an edge-triggered
interrupt in _AEI, but the EC uses the same GPIO as an output to drive the
Caps Lock LED.

When gpiolib registers the ACPI event, the pin is configured as an input and
firmware writes can no longer control the LED.

Add a DMI quirk to ignore the erroneous interrupt declaration automatically.

Cc: Mark Pearson <mpearson-lenovo@squebb.ca>
Reported-by: Nikodem Sanecki <nikodemsanecki@gmail.com>
Closes: https://lore.kernel.org/linux-gpio/CAAUQFRPW-rbcZV-=qV1NMjF_358sdJTiGvQuRxRqAsehY+J9Qg@mail.gmail.com/
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpio/gpiolib-acpi-quirks.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpio/gpiolib-acpi-quirks.c b/drivers/gpio/gpiolib-acpi-quirks.c
index a0116f004975a..44ac0fb6f6adc 100644
--- a/drivers/gpio/gpiolib-acpi-quirks.c
+++ b/drivers/gpio/gpiolib-acpi-quirks.c
@@ -356,6 +356,23 @@ static const struct dmi_system_id gpiolib_acpi_quirks[] __initconst = {
 			.ignore_interrupt = "AMDI0030:00@8",
 		},
 	},
+	{
+		/*
+		 * ACPI incorrectly declares GPIO 11 as an interrupt in _AEI,
+		 * although the EC uses the pin to control the Caps Lock LED.
+		 * Requesting the interrupt configures the pin as an input and
+		 * prevents the LED from working.
+		 * Found in BIOS R1QET54W (1.40).
+		 * https://lore.kernel.org/linux-gpio/CAAUQFRPW-rbcZV-=qV1NMjF_358sdJTiGvQuRxRqAsehY+J9Qg@mail.gmail.com/
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21AB"),
+		},
+		.driver_data = &(struct acpi_gpiolib_dmi_quirk) {
+			.ignore_interrupt = "AMDI0030:00@11",
+		},
+	},
 	{
 		/*
 		 * Spurious wakeups from TP_ATTN# pin
-- 
2.43.0

