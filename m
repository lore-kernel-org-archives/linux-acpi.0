Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012012.outbound.protection.outlook.com [52.101.53.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057814D0A12
	for <linux-acpi@vger.kernel.org>; Fri, 25 Sep 2026 16:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790353603; cv=fail; b=etvCzboAAGd7EM3DblqzxKiSfP2dSeXOgbUvf03Edz27U8OXMCyeqz1IH0Gp78W81x9Ftrnvh1gS/182Te/cD0OpImm228mOxymU1XMagSDI/FJDBFGDYnkKidzeJim3rVnMrZUTUnmdRGaUOIzYEhdmhhVZYJQ2m6BCwyWgqww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790353603; c=relaxed/simple;
	bh=SXv79MnhM+3Ow0jLsRSWqyujhN0uSrojjCMpsRDP5+E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pXEssR3rggy7A+KW2QPlsqfbdpTEH08TY9Zy6xh4Ij12T4v0GnMUvGc5UCOEgi1CSfM9f2a+7JtGbkQ3+H/79gSE0QwHNpdx7Ejo26Q7+sECIwKmX3QCX4bg+WjmInRxVURCRbYeTTX9xbicjoJhEIsAYwfcZjtYOzhGL3ndeG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=szoMHcDn; arc=fail smtp.client-ip=52.101.53.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="szoMHcDn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YQ2Q37Bae4IBup/N11TVp1AgPIM1D1qwEJX/0q1Qnai12MvMU+KtMhKEqYdP+hruo8J51bs6yGgiQiax0jeatGaGSKeXQUW3ThZd2WuPP5ltWlmDr3utF+XoJ4bGCkyB11j6d8Nc1JSptPw6vvknlf50ISGuArpmP/vgHYHcF2SgNO2aB9L9/qxoO0g0tgpey9JFosrWDFoO2bdntXMlNMITOoc0AEikazdbZmQFplnclyLos6GFRpBaMGnVyuw1nWkEOIw/TXwoP/oa9nY+m9AgXMHvcra+lmwBGF0rlIZyd+tX/B7Vpdvl+D93QDIhVcI6VyxYB9ah4ljb1sUv8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pASDKoFD6G2zJnmP/1N9nL4y1NTrPwhDqRA+PQsujws=;
 b=EIT5oxugXB2x8yxkktT3InLJBgavlqZM1k1CtdEpGhrzsBl3saiDMKdP7W338szoHqL/6PeiOhVnz4bYNZNc0FGuFaLilQQO/GAKm4Kf5gSrQgwus/nevKftelPR8ul4pQwHo18ayclzL88ti/hUonKPt4HdfwLjmypaVtBuqFl/FsbUC1qN1QL3aLzRDytecOKJf5yNexDUri13ObbZYpVArFoa8kz/zy8MjEDdmzDGwcNwksVAPn286h6e2zLBvhZY44BaxeSlb9y73GKvzo1z1x8TCebfqUld2UTrtablIAf2iCmV1gIfWaAiG4MJpcDI6N3jA8ioLq/J3Bbmcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pASDKoFD6G2zJnmP/1N9nL4y1NTrPwhDqRA+PQsujws=;
 b=szoMHcDnmn/cEYaL3aHMDqzTmCJzMWXMTIgKsFFvTYjyBxkReR+Za/+Fw6nQKDycz4jjCPAL/W/SsOdtqSRL+M7vLtXnvnXMOGor1uS0EgmqV417Gy3Sf2ZRBPtThCECxi0SyixyXqnGXhYsudjSPyILTBnwZeZPiPVYqRG+7vc=
Received: from MW4PR03CA0273.namprd03.prod.outlook.com (2603:10b6:303:b5::8)
 by LV2PR12MB5848.namprd12.prod.outlook.com (2603:10b6:408:173::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 16:26:37 +0000
Received: from CO1PEPF00012E5F.namprd05.prod.outlook.com
 (2603:10b6:303:b5:cafe::7d) by MW4PR03CA0273.outlook.office365.com
 (2603:10b6:303:b5::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Fri,
 25 Sep 2026 16:26:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E5F.mail.protection.outlook.com (10.167.249.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 25 Sep 2026 16:26:37 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 25 Sep 2026 11:26:35 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <maciej.wieczor-retman@intel.com>,
	<pawel.chmielewski@intel.com>
CC: Mario Limonciello <mario.limonciello@amd.com>, Arnd Bergmann
	<arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi
	<peter.ujfalusi@linux.intel.com>, Bard Liao
	<yung-chuan.liao@linux.intel.com>, Daniel Baluta <daniel.baluta@nxp.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, "Takashi
 Iwai" <tiwai@suse.com>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>, "Kai
 Vehmanen" <kai.vehmanen@linux.intel.com>, Pierre-Louis Bossart
	<pierre-louis.bossart@linux.dev>, <sound-open-firmware@alsa-project.org>,
	<linux-acpi@vger.kernel.org>, <acpica-devel@lists.linux.dev>
Subject: [PATCH v3] ACPI: Add stub for acpi_find_child_device()
Date: Fri, 25 Sep 2026 11:26:24 -0500
Message-ID: <20260925162628.4142365-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E5F:EE_|LV2PR12MB5848:EE_
X-MS-Office365-Filtering-Correlation-Id: e5e881a4-fd52-45f1-d0ba-08df1b21c5a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|82310400026|23010399003|36860700016|13003099007|56012099006|10067099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	DIgcYzMd8r6aNpEa8e63+/odlZKnsQp50v/pFgifrrBvqwSu4XQIw4VHzzYOBRZHWhZ4qz/Yvn0Gq0NfMgGjSORgcfHw+LFiD0VRqFIg3uKxQhiLbddNVxAROds+5PVq1LxhXP2CohPo0HryZpthdtpBSVxj9N4+SHnv+XjK4NAg0QGWTUgS3EblDE2T6XtPHuj7briU4rmfke43q+XtaAa4zRyG/SK5sCDAzXFnxJyMGyjxXB1Aba74iQYXPIsayzoZ5e7NcPsV00/fOtW15S1SuHzocRY9KgIlo34wbckgwuqrPF5QF9AhtWyYYkanpddiZkMs4HYk6vivy202j80WYxuANgXkErKd88E5w6IDwKuGJ76ZrEZ1CDmxHEXYe9TYd+UCm9PM3AAmgAZYO16clg6f/On3zpS3zPBGTzrX14c0KjxMvS4d78VsmW0P8smKsmUjlgiEg7Y9S0HrK7lfyA2Kl/badpjN/TBbBXI23X2myAHn82vilCIuiMEsHxTz/TJhefw2LheIKdpZIcmNgntCHsLH5/dQbHQO6N42Wk85iSiNZNqS5956RMAzXLwf/OovVITtcXzQtew/2jbvt6aKmFfebvgtc4odex2QaramQQrDTAAtupBQN6Ges6rdkrh33nyLQ+dq6lvIBHgIxSDTfMw9jATunuLc3HI=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(82310400026)(23010399003)(36860700016)(13003099007)(56012099006)(10067099003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	HK7jFxWomvs0S0SJ45rG27Uu7o6odXo5vwujcDCJxv3NwaPfDcsPf65JTZuDbFteFeVMLKD0ZHckYLdXAyXzSElMoLomA5cf2FsK2lLcyUwWQpCGobpX+TdSK1O+4HkDQ9wypIF/k+Yb0GlYqD+wKVfnqx0RZCfFF8VtIlax8S593x3eI4bkxu3Te9S4Qo7ANo9WSvTOfuuzjH0olXolqXlMwX32ZE771Z2k2fSUxO8F9qcZOc9SDRZJ5wdsM8lrCO6AXNrk+TgZYl39TTYvMlLlEBc2Uo7o+2B1axlTOb+8KlISq+R2Xjj9G1u7iMR20WE6sL9sFnKnKNTNn+iQODMkLsf3kLOR49lbVDO3XzQM8JDjFIQO6PrZeMKkn9N2LWgZ9YvgX7+kkzE/5KWbK4G4ImfaYjCBSKOoNssUNj0NXyxfAtbtG/HRQYUUZJSu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 16:26:37.2460
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5e881a4-fd52-45f1-d0ba-08df1b21c5a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E5F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5848

Provide a NULL-returning stub when CONFIG_ACPI is disabled so callers can
be compiled without ACPI support.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Closes: https://lore.kernel.org/linux-sound/20260925131104.118993-1-arnd@kernel.org/
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v3:
 * Use static inline instead
   Note: this relies upon
   commit e7280ab196ba4 ("ACPI: bus: Use acpi/acpi_bus.h without CONFIG_ACPI")
   when cherry-picking to sound/for-next
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Cc: sound-open-firmware@alsa-project.org
---
 include/acpi/acpi_bus.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 7dbe5d42c67e8..a755b15af9db9 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -954,6 +954,13 @@ u32 arch_acpi_add_auto_dep(acpi_handle handle);
 
 #else	/* CONFIG_ACPI */
 
+static inline struct acpi_device *
+acpi_find_child_device(struct acpi_device *parent, u64 address,
+		       bool check_children)
+{
+	return NULL;
+}
+
 static inline bool acpi_has_method(acpi_handle handle, char *name)
 {
 	return false;
-- 
2.43.0

