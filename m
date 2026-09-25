Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011055.outbound.protection.outlook.com [52.101.62.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA784A3841
	for <linux-acpi@vger.kernel.org>; Fri, 25 Sep 2026 15:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790351645; cv=fail; b=pYyHko7FkLZQcr76rkQaym9eQoikEChLm/g5A+emmE8CycHuLG+Db13+rM+s4itLLMiwHSgFXO2tst2qlGAQO09F2qecwWcHr5aQcJDLguS2Be1lEtOD5eArcZcfI3Fcj84MG8o/mCQ1qU4/ZWqMkYk6Wh49GYCqgeUYB5/DSXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790351645; c=relaxed/simple;
	bh=4c5cldHibbKVxtp/zVrHIliVQxOUPtnl0IvZ9QoOkVA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rO7XIW8vMbIOS9PLju7NfswcvB535qSMVcy10xvFtzuArAUTKAM8wjTOE2tmEbV65tjeoFGbckvMbX/boOxhi3h4WJC0BEc/qbJhotoLzTTJDqzCG6QAAQMCGwrsPdRnbQkc+Pmax5qOrh6JnNSpxkWFd1zJZQhb0xhHGSGoK3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MWjOgrMY; arc=fail smtp.client-ip=52.101.62.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MWjOgrMY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f23Q4Z8cafFEPB7kKb7Mn3SGQ7dT+ac58UYxJYhpavCwoNBsxZgGg7y3qZiGh2vnJW3fTL7ptDnowJg5bw2cx6fMmYn/45FO1Kk/fj2cjcd6qS9InOlThF53e0dTjQ/s3yjPxprlBtAlK9XRcorNFcvLHKWjWx+S1sxytyoFh5FtgsYnKwuhpw3Xx4+rK2RVfsxZCvi3BMYa4xWUmdCIAiG5AsBnRgzjAgaXZ5Y8qkaYrtdHHMR/pbr0OMQJSiRGC/VWHf+WlnyEcHjyyKHh1ZyLHU0MPER4UCYYEvAuP4davhgyxvvTGe1iFxbFOVO/diVb3IKPiEMuOg7ybV7LLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OxV6yz82rs/foryzcvwiHA+mcaBhIBlJD97+pkk5An8=;
 b=AaVQ5YZswSIScs80zV82fDrnu7n+a64ltTnopbo7/S2Rx5DwEpd3t2wX1SY28ueuY5brH50eRN50ZRKd+EvtmrA5gq6oP6VxltuhSoL1CpbbLPCDdNN1EsrK7K9DHubceneWv8PbSxtt4cRxhXCYqvbhH0gF18xgvUQHQenOojFGRU3gFGz1WtS6SA+izShk+ycuEfo5sdvByBQV3dHWGAMC4/Jbf6cSr2dn6hfQy0k7yoGLo00jcmUGSLAxWsiJvJDSYULKljGA1ymqTxnw27pJ8whnglxgj8yCi3G7hiYHKOp+MuC0ffeycGEDatfWOXErPhhQBv8FTgxsmxokfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxV6yz82rs/foryzcvwiHA+mcaBhIBlJD97+pkk5An8=;
 b=MWjOgrMYb384njEjAnY1hdWEbgwN+gHA4InzD+0QcNlsMaPD7pfbX+cQpAAugbiCSvhuDtQEkB3N5kodNPO5trD6Ys+NroxhcnJuFLFrflmK/AYhqm2Q/8bTC+St3DV1biRskOp0FWUNCpLyt7QYmyyhU3GCerpSn3oNKonHMr8=
Received: from BN0PR07CA0002.namprd07.prod.outlook.com (2603:10b6:408:141::17)
 by SN7PR12MB6885.namprd12.prod.outlook.com (2603:10b6:806:263::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 15:53:37 +0000
Received: from BN5PEPF00046989.namprd02.prod.outlook.com
 (2603:10b6:408:141:cafe::5) by BN0PR07CA0002.outlook.office365.com
 (2603:10b6:408:141::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Fri,
 25 Sep 2026 15:53:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN5PEPF00046989.mail.protection.outlook.com (10.167.245.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 25 Sep 2026 15:53:36 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 25 Sep 2026 10:53:34 -0500
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
Subject: [PATCH v2] ACPI: Add stub for acpi_find_child_device()
Date: Fri, 25 Sep 2026 10:52:12 -0500
Message-ID: <20260925155220.4110300-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN5PEPF00046989:EE_|SN7PR12MB6885:EE_
X-MS-Office365-Filtering-Correlation-Id: 8156d1eb-b52f-44f3-9134-08df1b1d2938
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|376014|7416014|1800799024|10067099003|56012099006|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	8Nnll/zJdzNHiuH9XZNvnl8a0HWdhWMQbAFur2kjuMR0ShGtjzhSK3ZTeZDX8RdatZ14yqnSdPQn2xHqAJrysM89C+ox+GYnhwg/fcjPQ3J4HUt5Qv4agGAjPXt8B6L6xjkwyw5l1KjGyprD+bKxTO9dVW6CxPUjfy62Nqyn83CMgmqeEdMC8EnZW/Pbv5DK1JTSdp9VwQUhdmfTnnS3LaTCivvN/Bsiw9K0NsSHdioetGKqI/eh1ciSPjpdEx5Vz35VCIGupUOHJPmB35wBpCoYJz/Vad/aOBMxdxjAKSQ1z0LijKTW9cCQXhFr2DTIY0doRz1j7Ij6Fzf/jexy3HpcIF5C3sFsv4QMM7waekzmfGvPXVFFXEyt9BdLafLQ8hfVc9TWoEdCZAmED77oZDeWHG5MP71dowSQPanau1ZpKpK2cMn8PhAA6Pa19DJMmz3ATUX/jeAsUDNR+nGlfrWL8DfMRandBWxAs+qVl6TivoFGGLjqacWrCawj5POYm6Q1cQWb69xmJOOR3JWZ0vZFp7pfnpKt3rlNRjIIpNM61x5ntW+TtPqlnYLbaU4LWMCC2wvCwrPOA/Q4CE5M2fY5TcLwKpbNPobV9Ef3ZBMhVLbz4CkeeNNr0Wlq0qL1SKVqOGLPLVjc8aDZwxN1KlqkJg0VLMDIX+OtM+lm7+k=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(7416014)(1800799024)(10067099003)(56012099006)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mafRg8Hw4S2wbVAtNTG2VBZImjRCqiba5CZ+YUYitTsV37JbOkUfkFOPOwUoGColaGqaUyax+tQ+Cvp0vjrYcAasPapKMqwv3DlRLnnuHXfDj1bFAxR6Pt8kOAZQ3enhhsRJfabKIb0ZSDUx9QKVUpRZV14D6DhlUQmPW6yqTkd+VlulljHRLbgDNnHGfrK02cUKnB9zlbwelDb8SIxtvTFnB6nh5d2MWzRpNZfN4lgr+L2DFiKL6IOEn5AqtJMQF2OVxBlfXks4YmB46NXVFuiq8Ri1K/NpbhFuNteJe9LI3olTUbSGLoJQWd4w1uYCO7SRNtzqof5VCN8DRNV8T0pSMMFLQ2aslaIeellMfKPnHFqnRL4Ttl1DT9/NwmKmYP5QTog1bI9PaW5eUEYqRXcXed+N5Yq3mUySVgVEPvl5aSDkHch4D1N/NHdpXaus
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 15:53:36.8889
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8156d1eb-b52f-44f3-9134-08df1b1d2938
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN5PEPF00046989.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6885

Provide a NULL-returning stub when CONFIG_ACPI is disabled so callers can
be compiled without ACPI support.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Closes: https://lore.kernel.org/linux-sound/20260925131104.118993-1-arnd@kernel.org/
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2:
 * Move to acpi_bus.h
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
 include/acpi/acpi_bus.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 7dbe5d42c67e8..b7771b4f36c80 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -954,6 +954,8 @@ u32 arch_acpi_add_auto_dep(acpi_handle handle);
 
 #else	/* CONFIG_ACPI */
 
+#define acpi_find_child_device(...)	(NULL)
+
 static inline bool acpi_has_method(acpi_handle handle, char *name)
 {
 	return false;
-- 
2.43.0

