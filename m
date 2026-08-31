Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012004.outbound.protection.outlook.com [52.101.48.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076132264D9
	for <linux-acpi@vger.kernel.org>; Mon, 31 Aug 2026 05:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788154868; cv=fail; b=Z1YMe29ci6Lv7AUl2rDFPIU/Uwts2erFa2own1s+44L+Iodq5sXxpbtltYprvB8WjYollu2KmTKQVH6DECwCG8UBcSGGBQzDNUmXr+nn8/XkebYsGtBD9FznnkE59dPUyo0H6vaLK8vSW2qUvzbng9T7Ww6bbmFqZUIeW2SOd7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788154868; c=relaxed/simple;
	bh=KYHKddbtaY8JkFFqSnTMPmBorTYlS3trdyFWA1aRkPo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oYuRE12vIUT4DCqIpY0F5rncuspm1dnwNnp4Xz5ErF2Wp0qZu8P4eYUU9aPyKKrtUZ7RO0yJ7fIT3Y/0DFWOcaeagBDCe0QOXvhLjyJc+PXYNzcX2juyk3woXuAN4CQVzGXa13WAw28ODrieqjo6Qb/7S9fUN+bEBw7le8fanfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fSC2f/O3; arc=fail smtp.client-ip=52.101.48.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fSC2f/O3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j/YTZdHO02Ov5CFH9mUy+ZMs+TyQS0mbf89sSC8R/1FfJCApT5+9nbnkBysdu8kqhyDIkwSVJvIEocX0JmMvwdWadMDYeXtCMIoi5ZDKFXymgqguHcuhyZAxAi6ESiZF+fJY1M7rR/Mn4Bvy9gLRvTMJvU2uUQovEWz2s0tapNOO/b3BmW9JjDu0P4f37IuE7R9WCKNqKn/oH0vWH8bwwAjTRPtR4oyDedwkBYpCvqYOPmkuU8X7ZWwjz8PHf6WpW2sgFclzKu4poE8XoSLMZYPjNzZJuTy7egNt+Lh5HW+Jm1Ctmq2WSkfdZKUwGvlJNJBT7zyPS+K2q/wwX41VHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JYXsvL0jGzhww+3An+zD6Jcu74WHpCIklDPskT7bBRs=;
 b=xh8qbOMD4a2BfvmrOluuE47cmDn3eA8S/C7FfPZDA6xCbEoZkBCHyqIy1wJ6dleAGV10LgJawLHDaG8ZOoa5iY5bpE2SbJaxw+FU/VCYkUNUT6fYjRpt4f4ih2yHrP1Mr67HkhcFcjSxsHIxBL/ylQnn7jMjBimToZ/jJIP2mgPGZX2Nu0KzNj6Svly9pCrPRXN8VGDfWWcRkN3fqjDy0hhufvhXzd+geE+grHsq1bYzML0dcsnSSOkSc99Rmwhodpl0i9EJVZGYrC7YHUaX8hUd1mlm99yUZGGJ1lQBMtKww//d4xi+0yRjrnHIQJTCJW2YvNpaAU34Z+hEGuU98w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JYXsvL0jGzhww+3An+zD6Jcu74WHpCIklDPskT7bBRs=;
 b=fSC2f/O33jMZsFoG3kQPZbIaPHZBuKq5URt+gcTD0DQgChmT4K/Ad7AYMfQuGNjDDbiCZShNopiNv00MtPDYquq6QW+J83waHRyF2vKYlnKqMrFMrPyXxbbAdR0XnznhD5wLR/b3ls5oIOQL0fLKrBxFk+zNIx1Db7uxauhE+A4=
Received: from MW4PR03CA0227.namprd03.prod.outlook.com (2603:10b6:303:b9::22)
 by PH7PR12MB6468.namprd12.prod.outlook.com (2603:10b6:510:1f4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 05:41:02 +0000
Received: from MWH0EPF000C6194.namprd02.prod.outlook.com
 (2603:10b6:303:b9:cafe::29) by MW4PR03CA0227.outlook.office365.com
 (2603:10b6:303:b9::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 05:41:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6194.mail.protection.outlook.com (10.167.249.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 05:41:02 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 00:41:00 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <mario.limonciello@amd.com>
CC: Giusy <kurmikon@yahoo.com>, <rafael.j.wysocki@intel.com>,
	<linux-acpi@vger.kernel.org>
Subject: [PATCH] ACPI: CPPC: Don't gate FFH EPP writes on flexible address space _OSC
Date: Mon, 31 Aug 2026 00:40:37 -0500
Message-ID: <20260831054043.1884105-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6194:EE_|PH7PR12MB6468:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c2b5a28-5da3-458a-2a89-08df0722715e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|18002099003|56012099006|13003099007|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	H29w/bYYpl1W5SIyOB8akWpso4hwqg8HWa9mY+ADfJjE5hztfPEZMifxDp3Y+Ne00W05e7MlGqr8BBroqGWEXeWOwMvUgpShbKZ+LMXsfmKbHky2WE96uGqoOcDnnBV29g6LW9igOKupP6WjSDWJiHBp4RkaAwoNh4AFfWihqoKYBmn34UmxUph1Da8UJSq3/EIexa94HTXA8U62wdMHsYAz5UNTpS+rZ9qL+uPTjo2C72x3JX99fHWdO7o8R4p1OYYrUbzHBmqdgr2Hkk6yrvXR8SF2KtCZRPPCRiBKDKkjBRsjlVxaZFofQkHsn5fD8X5m/GkJDR72EE+Du6EEwe5BfTzgm0K3RSrr3baKIgtFIAJvOy5fUJYYw4leJjssnEiv1006H5ZsPHd1ZmgJrv0PK1Xh1Qm77TbgZuF3sqhUn/0Z3KSd4hHWVOG3xFZCabDGN2sFPucchcnim0DZO8Gi08gamaKCUpRbsO3u9WBOhd3vRZW79ZUqFcjTi0Q3NxABK/45HYnxpjFYle4/XNlNSrVW+BIRSxdgyKKdGS8YJkgSB80HpplYtVIfDheIHmX50XzD3YRIvum9oknA4bnq0N44v9PmiAMbYyTnVdkVlGnX0Y6+UvaKZ+NyunPzeN19/30I+W6qiD29ypgirJNJLFTJFIFLwYVItfpGaRxgZY4bmSjNG4Nliaw/xyDrq3zOZXU1jOHA8giuzb1iMg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(18002099003)(56012099006)(13003099007)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bbdchRQGepklu5xG8E+yPwT991eF/GxjGAG/4KnmKUMyJbhKyz0I8K+2tdLNqBP3OmOSLyCGHDIqVs1xQsaxHOSDKOVPGlni5qUpfojCoam15oeRJj16NOeO2gpik9ufgKKXYpixQXCX3a8+uo77jm7WS5B9RT0dSIAyERinV3kattfGgcfCKUT227FB+tGyaDEPTdehBjebrxoEP/89GCHC6h0e5sBqFOQtDAaL3uuAO7HwED7HvUmYeUO3AFg6XSCBTD0NxHla/pE1MN4k6peUjGx/SZ7wsF/IEg+sNKtrDTIlf9ZTIFLtclcmTF9a8ssZFTvjbHUeSsle9npooutNehlJsK6NoUOxYMSkP6CKeSU9DtRJQLAiJiQUIYE+ACKQ0Q7bgmbpR903sek/39KXeJIB5gBhgEVnAiGhJKE9zGgzz8CjUvrG1poWelm3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 05:41:02.0814
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c2b5a28-5da3-458a-2a89-08df0722715e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6194.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6468

cppc_set_epp_perf() requires osc_cpc_flexible_adr_space_confirmed before
writing the EPP and autonomous-selection registers, even when they live
in FFH.  FFH access is a direct rdmsr/wrmsr and does not depend on that
_OSC bit, which only governs CPPC controls in SystemMemory/SystemIO.

As a result amd-pstate active mode fails to initialize on platforms whose
firmware does not ack CPPC in _OSC but whose EPP register is a working FFH
MSR.  On an HP 255 G8 (Ryzen 5 5500U) reads succeed via the _CPC parse
path's cpc_supported_by_cpu() fallback, but the EPP write is rejected:

    amd_pstate: failed to set energy perf value (-524)
    amd_pstate: failed to register with return -19

Gate only SystemMemory on osc_cpc_flexible_adr_space_confirmed and allow
FFH unconditionally, matching the _CPC parse path and cpc_ffh_supported().

Fixes: aaf21ac93909 ("ACPI: CPPC: Add support for setting EPP register in FFH")
Reported-by: Giusy <kurmikon@yahoo.com>
Closes: https://lore.kernel.org/linux-pm/e4259474-fa4f-4ed8-8a7f-1a3a2521acd3@yahoo.com/
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/cppc_acpi.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index fef54fcd00b78..6b590842b5668 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1766,10 +1766,18 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
 	auto_sel_reg = &cpc_desc->cpc_regs[AUTO_SEL_ENABLE];
 	epp_set_reg = &cpc_desc->cpc_regs[ENERGY_PERF];
 
+	/*
+	 * The flexible address space _OSC ack is only needed for
+	 * SystemMemory/SystemIO; FFH is accessed directly and always available.
+	 */
 	epp_ffh_sysmem = CPC_SUPPORTED(epp_set_reg) &&
-		(CPC_IN_FFH(epp_set_reg) || CPC_IN_SYSTEM_MEMORY(epp_set_reg));
+		(CPC_IN_FFH(epp_set_reg) ||
+		 (CPC_IN_SYSTEM_MEMORY(epp_set_reg) &&
+		  osc_cpc_flexible_adr_space_confirmed));
 	autosel_ffh_sysmem = CPC_SUPPORTED(auto_sel_reg) &&
-		(CPC_IN_FFH(auto_sel_reg) || CPC_IN_SYSTEM_MEMORY(auto_sel_reg));
+		(CPC_IN_FFH(auto_sel_reg) ||
+		 (CPC_IN_SYSTEM_MEMORY(auto_sel_reg) &&
+		  osc_cpc_flexible_adr_space_confirmed));
 
 	if (CPC_IN_PCC(epp_set_reg) || CPC_IN_PCC(auto_sel_reg)) {
 		if (pcc_ss_id < 0) {
@@ -1795,8 +1803,7 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
 		/* after writing CPC, transfer the ownership of PCC to platform */
 		ret = send_pcc_cmd(pcc_ss_id, CMD_WRITE);
 		up_write(&pcc_ss_data->pcc_lock);
-	} else if (osc_cpc_flexible_adr_space_confirmed &&
-		   (epp_ffh_sysmem || autosel_ffh_sysmem)) {
+	} else if (epp_ffh_sysmem || autosel_ffh_sysmem) {
 		if (autosel_ffh_sysmem) {
 			ret = cpc_write(cpu, auto_sel_reg, enable);
 			if (ret)
-- 
2.43.0

