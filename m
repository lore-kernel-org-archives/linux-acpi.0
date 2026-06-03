Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012018.outbound.protection.outlook.com [52.101.48.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225AC321420;
	Wed,  3 Jun 2026 06:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780468425; cv=fail; b=V/qhtem4iZLwPYfy2E+gkTVqlqk1skmHR9fMXzBxlm1U1lR1hB1/GmYtGHaRUtSxVF3hOVhHxVt6g8/p9tzQmyJhZVbNUWsDQ2iAOmZcB1zwPBVbSpUJ0sFOpZfwfi16oPP0He6hxsOa8GrMekOXUQd2Edrtt2RbZSxQPEKp3/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780468425; c=relaxed/simple;
	bh=pFmzLPpKU4rjBvKAXO6j0U8wHdCoAGGv+wjXdwJPhjE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gYtSZO1dz3YpLlc7hS7/DGWwZZvfai0mr26pFkfIaD4uZSUV+FkKWVGl395SrqJ3ug4ARl6gCWH33+6pdy+NoepQGlzjDE4WS8sp0LN5c2bWej6duEgjTRkQHJPhhxsZ3hv0o8wZlT3dfDYzyUPT0jvgzOgqwe9O7DRaf/bzCRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dAe3Yzq9; arc=fail smtp.client-ip=52.101.48.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dAe3Yzq9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dc30mGBeKCYFEIDFJ3V7bwgleR2J0pgvAW1C8gBrzrnA9rexAOKCyAUST8Ens+o4PvelHOMJSHanRnF8IgYxQwFRs78YRprq0kWiDZqQUnwPtz+YUMwKDYoo5kzxiw2VXOOc3wELfo8mnISI704H895mlINLOUq03Mae5gH5NQR6O699/hUUJwEvasVBGfAFDMwLL3wWkoT9iUCRkl/vesXK0Opmo+dN+Tqi450kLp+1cB6FKQroP+9ja66oNKfm+SHg9Na/iI/pPxSKeZp15xD0IZK/XFMsTW0yjxOuIKjJQDlNUvk0b5P2o53FcJVZOAOIarKhISKa5CNGzN0edQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AXtBSPqs1myubtaJAKV9YJC2yDZ5HDolRWGlzrIb6E0=;
 b=L+kjoIReKrqagd2NN2t17x2AUtbgwIi4qAptRhM1iH8uNzecJGcQ46KW0iBQ/Th9YCZ1bT03iZVYNlIxBbo8mxqOddgbN/HqzBsWYfPGaDe7t8Txn0VKRY/tyMXvxMFhbmRkUkjZ0P8RI0HwaCek+d/mhpq6BjJkIBWzrV5zJSdp2EHpmSTPYjLWob78D4FX2GItQLQySlMl30OeisiMPEwk4hgfqYvKTRpc1XMRSULYH1Ohza1jxxftu3PEKa1qR++1mIyb14LhsHiY5AdE74AeJYiyvpOSXNCNmZWM51lbkdq13AEx09+OnSuP4fG86PupV7DdYCU+sNIAcUx9mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AXtBSPqs1myubtaJAKV9YJC2yDZ5HDolRWGlzrIb6E0=;
 b=dAe3Yzq9KFPwh0wQCrJq8HIsgxQEiIHoUKTLNaoSU/pDEiTZvAPBlTAPpDPa9O68DWEx93AjMco4eLqvZzeYzuSGXwuguD3gRgsENQyZ8l2Abit5IOeQ0vnDa8KZ0rDXUuHTqzHzz0i3Ck1URFG39kuGPP1R1mUJ7UMbE3gQ3Og=
Received: from BLAPR03CA0116.namprd03.prod.outlook.com (2603:10b6:208:32a::31)
 by DS2PR12MB9797.namprd12.prod.outlook.com (2603:10b6:8:2ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 06:33:38 +0000
Received: from MN1PEPF0000ECDB.namprd02.prod.outlook.com
 (2603:10b6:208:32a:cafe::a1) by BLAPR03CA0116.outlook.office365.com
 (2603:10b6:208:32a::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 06:33:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECDB.mail.protection.outlook.com (10.167.242.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 06:33:38 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 3 Jun
 2026 01:33:32 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Borislav Petkov <bp@alien8.de>, Mario Limonciello
	<mario.limonciello@amd.com>, Yazen Ghannam <yazen.ghannam@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>, Thomas Gleixner <tglx@kernel.org>, "Ingo
 Molnar" <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>
CC: Vilas Sridharan <Vilas.Sridharan@amd.com>, K Prateek Nayak
	<kprateek.nayak@amd.com>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Cooper
	<andrew.cooper3@citrix.com>, Mikhail Paulyshka <me@mixaill.net>, Kai Huang
	<kai.huang@intel.com>, Rong Zhang <i@rong.moe>
Subject: [RFC PATCH 0/3] ACPI, x86/cpu/amd: Parse S5_REST_STATUS from ACPI PHAT on supported AMD platforms
Date: Wed, 3 Jun 2026 06:33:13 +0000
Message-ID: <20260603063317.13665-1-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDB:EE_|DS2PR12MB9797:EE_
X-MS-Office365-Filtering-Correlation-Id: ad824a0c-4a6c-40a3-33ef-08dec13a0bba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|82310400026|1800799024|921020|56012099006|11063799006|18002099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	qHBl02VZIL00yZntoZjbnAcfpmUTDKIT3pKijPOGoO7t+ceEI5sCfPE4Oee6EMt/RRzC6aHpKpwmTf/wyiq3W++m+d3dp1CmMzlp4jpmitBQ9VDSHWxq0ftblaa+cjjmWUT0SFTW8/aLTj/JAac+s/8yyl1wWNKGgE54iSyCuNsLNIlbPGMfW9FG8Y5KtZ9aGO/4BhnjcfLQbpZnRf6YNDoVqnARoyDLLtanhRgEs9HY6+ZosBAR/LN+GsS4gLqJFBF0lgRtcVjiQEzrCvUVfeJDAulKTcsV+jBQYgM+Q7b7DzVApq1X8cOe8rDFNpMSw5SwJQ2qj/LWpZlmcJ0vmQMR7NgDPf48GPxWP2BbyEYuAdasspmWrsxSStgTN8LzNGKQfWOvYBVrespqo8YwfVO5T+mSlw7R9ODga61WApHWiIHyMZ7UfsDkl1mJHUZ05VvNfgpzKFTBgbsK+wzPax3D/JdZWtGe2a87jKFzFz3b/tZHomIgSAmKUs8yAZ/ZKWR5EX+VaE3PXZmxvQk2Fi1oQ75vf4Fsw3Yzr7Q00vbbs5e/JhwnaOLS4T+DN2n6rebVWEyLzVw5D5+/M/HLxgnH43P8cV4bOtN+SpBBOYswojogvtwWM4+J69flNZ3ZxoK4Op/dCzaMv8dflmkVaTcfw+kSUeN/nbw9V4db3UphpxAXwqiyKkIIIW5PBmXcIb63HHF5Ch2VBLXVx6li8dXRucua0Bn0sFYzFYR13tw=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(82310400026)(1800799024)(921020)(56012099006)(11063799006)(18002099003)(6133799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ePAcP4eiB+2wzzN94rhGDkxmcchYXHO6E4NkV4RDE14HTkDW1A6GvpCs3RGfMUs/351OneYFjfBHdu2eYRQaxf6jC7zEjjktnpaEDddnGpgJO+C7EISl9tDz6Nr2ipxeIE9cXeZmNeJv24T7QY+JQpXJN1y3yHpktg1wMHJoezkBieLiDQ9x9i7VXpVPuHW370bq7DtqpCzMTW9TGY+Yu+GdIXnmNwkgO4l7TVMQ8Qnp43YB8/UsF/YfLzozmpUCDENRBolTC6sfaDw8Z+q0IhXC3m6Ex5n31ApUI200EWXanFmgvanmu2KJUF3HuX/wlQFJwIAhATjVUbHVRwvgPhwW9Oqrcw9y/tk/i3Xzq5ts9F51wRfRsXK+1JiXFYR3930GNb4DxzwylQ8Wjc2wrgTrkBF5wKWAYehTNvhwK6wYoO7qF3If/+8ZS3XCiY8c
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 06:33:38.1765
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad824a0c-4a6c-40a3-33ef-08dec13a0bba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECDB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9797

x86/cpu/amd bits uses the FCH register to read the S5_RESET_STATUS which
is known to be inaccurate on some configurations where the firmware can
consume the status before the OS boots.

Vilas and Yazen noted that the ACPI PHAT table has a read-only shadow
copy of this state and is the preferred way for OS to consume the S5
Reset Status.

Introduce generic helpers to parse ACPI PHAT records and use the
platform specific helpers to interpret the vendor specific reset reason
records.

Since these records are read-only, the status cannot be cleared once
consumed and the last reset reason will persist across kxec until next
reset which reintroduces the case prevented by commit e6416c2dfe23c
("x86/CPU/AMD: Prevent reset reasons from being retained across reboot")
by clearing the FCH register once consumed.

This can be avoided with a boolean flags passed over as setup data
during kexec but this scheme adds unnecessary complexity in
implementation that has been left out for now.

Patches are based on:

  git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi

at commit 3109f9f38800 ("ACPI: button: Add missing device class clearing
on probe failures") (tag: 'acpi-7.1-rc6')

Series has been tested on both, a Zen4 platform that does not contain
the PHAT record, and a Zen5 platform that contains the PHAT record.
The Zen5 platform was also tested with CONFIG_ACPI_PHAT disabled to
confirm that logic correctly falls back to reading the FCH register.

x86 folks have been Cc'd only on the Cover letter and the x86 bits. ACPI
folks, my fellow AMD colleagues, and the lists should have received the
entire series. If you would like to be Cc'd on the full series for
future posting, please let me know. Sorry in advance for any oversight!
---
K Prateek Nayak (3):
  ACPICA: actbl2.h: ACPI 6.5: PHAT: Add more struct definitions
  ACPI: PHAT: Add generic helper to parse PHAT records
  x86/cpu/amd: Fetch S5_RESET_STATUS from PHAT when supported

 arch/x86/kernel/cpu/amd.c |  34 ++++++++++
 drivers/acpi/Kconfig      |  11 ++++
 drivers/acpi/Makefile     |   1 +
 drivers/acpi/acpi_phat.c  | 133 ++++++++++++++++++++++++++++++++++++++
 include/acpi/actbl2.h     |  14 ++++
 include/linux/acpi.h      |  14 ++++
 6 files changed, 207 insertions(+)
 create mode 100644 drivers/acpi/acpi_phat.c


base-commit: 3109f9f38800841e46769e95e1ba11f1f8c7b230
-- 
2.34.1

