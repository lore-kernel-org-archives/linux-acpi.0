Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012050.outbound.protection.outlook.com [52.101.53.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AE93FA5FE;
	Mon, 29 Jun 2026 09:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782726317; cv=fail; b=N7wOFvRya1e9hGxhOU+esuQIpyCuWUHjDPx/XGi/NlUWUDuVRLn0oHG04Yfnv/ByGnNzhf0/E8qJmw3q6WqHoiso2/JdMRjGNPCtarAkR0WevYDQpm7aAM/bwnk0B3DX0Rwk/1HRJgUHC2hEY7MwjzTRq9dOaCncpENY90XyY4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782726317; c=relaxed/simple;
	bh=sBmRG/58G0VmLDprGotsfwqcHXfKEgzkqlGd1VVoxTs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZuWIhlGjpbuIJBWMwbUav7Du0TKnsK1ygQxGF9mgNh36dK9pLoXjI8x9CVbue5lODU7A2sic85DnZ1320yt+AlKVKGahrTSShbPcT25TSiunx5Fry25nvHZE1K2OLtpAd3i/+kdydKL3y0cuxuHGICTbwTHNJXvEXgGd7E2F7y0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=18LiSOWs; arc=fail smtp.client-ip=52.101.53.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="18LiSOWs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w46pTIXzlq6YDC5RWH9xxfTgrX/+Y5I94HTeu2AasLRq0MzIe8Q2jpukvFEebvdVjHlFpeZw8h3z/Yd00AzWeCLKJTVmk1NzCTQajDDnHG/bQo0QkHsGbi/b0UOknxwVKhadAXH/GzlTvmX7GykF1Sk818XCAXRXMMUxX8VqQk2YWUFWpPGLp4qfvBXjR40KaaO7Hf8HigoIbuPkvzdVs7O7wlLU6ia03NIIrvrGyMH/22YdGhSP8KGBEk5lhjEUyc4Dziifaz2iejcnHC5qaE9H3UiaqoZvQOTpCd3xrFHMhQOoZ8avh45qBsG35rka5gcszHmCLdzbzotacVvKQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3oToNQKSx2XfWyN3KKF7deg0OUmggSE8RkPbXnMs6Ro=;
 b=t2u6hBeCp1fKUqsudOrQEudUKtpYO3MEjdURpc1ReqBjpNKvpPEqcM52a4VFCKSMl7NqFWqpzTsXw32mfL1ALt8UOmJizmSTJYhx+8oh+9i4jtxaXZ8jZc1n5XUxePb38IWjmSUGgFNIn0SyJ3qDhfZS5qv1M2rtCqWT6obEhtrKOY0XrcGhw638zxB5u85GQkh1Ld0fNDHoqTMCNzLduOrVzkTJbnGbFRHFzh5k0s66hzVVVaLRPfcgkbqazf27HguEy5gWABddI2rM4YWoeO/j65rNFCm9rYsdVEiAnm2iLzRula7XxpXKrnEKOcOh7bKQCF949Y0+TuKSaG9eGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3oToNQKSx2XfWyN3KKF7deg0OUmggSE8RkPbXnMs6Ro=;
 b=18LiSOWsDance0WGydCw5KWF/qZIU5EBY2tNOst2JZafXk67xnA2MwoH00FCi/5I9fY13qKzCZ7CVR5qP6DGrNqzmVL7ERrtbiTcEIYY3sEO68qNgIZ6KxET8KfeEHf78f/L34c8xo9Q9TxyZ8CA9NHG7/J9DeyOXmJIxUj5I5Q=
Received: from CH2PR14CA0003.namprd14.prod.outlook.com (2603:10b6:610:60::13)
 by DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 09:45:10 +0000
Received: from CH2PEPF0000009D.namprd02.prod.outlook.com
 (2603:10b6:610:60:cafe::38) by CH2PR14CA0003.outlook.office365.com
 (2603:10b6:610:60::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 09:45:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009D.mail.protection.outlook.com (10.167.244.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 09:45:10 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 04:45:04 -0500
From: Vishal Badole <Vishal.Badole@amd.com>
To: <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<rafael@kernel.org>, <lenb@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<peterz@infradead.org>, <tony.luck@intel.com>, <chang.seok.bae@intel.com>,
	<wei.w.wang@hotmail.com>, Vishal Badole <Vishal.Badole@amd.com>
Subject: [PATCH 1/2] x86/topology: Name the AMD core-type values
Date: Mon, 29 Jun 2026 15:13:48 +0530
Message-ID: <20260629094349.533301-2-Vishal.Badole@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629094349.533301-1-Vishal.Badole@amd.com>
References: <20260629094349.533301-1-Vishal.Badole@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009D:EE_|DS7PR12MB6309:EE_
X-MS-Office365-Filtering-Correlation-Id: 17b164ea-0249-4089-854e-08ded5c31c76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|32650700020|36860700016|7416014|376014|23010399003|1800799024|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	EmQjZqHBlYa7jx5ZTmSxa81yvClKBERuO/KATUBFndnCwb+SJbSkZli3e3EBC+eA/NcQstV/+6FqJ1VsdrkhsjFD119cScYg1nSwQ3ERh6LzGB4dvhYDp2n5Ghp4xwBJjNxn1P1cCzL2aKdhezBRYe0zwdL4Z/+NVX5C7IFCppw3Gd/KRoqNHpqnqjr8IYN4y1yVCw0k5B/eXSG68Sj6TFUmWtkG76yAK6tWbsOZnI32+uVaz3HPgzAYqntGZeRiMAenP6nm1H6LNUkvoDS2omzW05HpPqY0kbZ9mCXI+W+U5W/RYOuIBtlg+p01Hvhoe4iIfmrpwDfYgyBoLh/z/ceiWb5VS15RbG8XkJem82IVAqT+dH6j7lhbOpNe3/XsdJ0H7BIlr4BkNF5HdK1NR2Ua3qszmN+dZfnLV/kqe3nM6XjDXD6RkSyQSJDJdcxK/qklSLlO7gqzYlZ8i7miGWiJS5C+NoeuEsK2Dn5xE2FdMmUSEMoXIk7w96jWVuRzixedMru873/YsgL7xyogXuzuy5yD96VpDqaIuxcSA116WpAIsaZjm2tLtVNRPekugyq/g0oaxo8uMgy1jBkVlnEwSdKTihXnV+tAJWC3CUil8vkG4yeOmj338U2q01ZG8KdiaijUeRtBmX04/Z7yI9ziq53cdKbdj1QLn5U2NThSQ4cdh63WY4AoJAL9bxgLm7O7kYDK0fRdBOcOd2irkQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(32650700020)(36860700016)(7416014)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xq0X8/W/3CyoB8Y8yc7qqjT6L0keV1Df911zvISdthgV6LnD+i7R9XtZ5TEhDZJBtyGP0tZvx8Pn3JzXNC+/6gHDw2v4jtymE52WxR9QI64aDJQe2X5c0bF8dtvKlARiGyYhv8RKb0lsaTL4iZxjn3EQvv3kqD2LcU4SSQJt160Rh535tK6aZ7oKF6wN/DJSHQ2EnNoiPNipWdcHfSLUOC+miLbGIC0l5bf+g0ReFkFADPVXDKHPecEwkzcEjNvSqQWoai+3gdChnQRV3hCNxd33+esFTKBAOXrdQUNQfB29uCjroh3lHMFZ8le+5Y7MWmn34n50Kd1I15Me8jvM5ACgDb8kZYpxaFOElgEZRaydZ2ZvsThqbr87TupfP7b1dNAI4C0vGRp2SYXRrhW1AhH9rEITK/WJ5dztbVK0OjijTrYAremmLqEs/vIWZ5kb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 09:45:10.5671
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17b164ea-0249-4089-854e-08ded5c31c76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6309

Replace the bare 0/1 in get_topology_cpu_type() with named constants
that mirror what the AMD APM publishes for CPUID Fn0x80000026
EBX[31:28] (Extended CPU Topology, Core Type):

  0 - Performance core
  1 - Efficient core
  2 - Low-power core (used by a follow-up)

No functional change.

Suggested-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Vishal Badole <Vishal.Badole@amd.com>
---
 arch/x86/include/asm/topology.h       | 6 ++++++
 arch/x86/kernel/cpu/topology_common.c | 4 ++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 0ba9bdb99871..9658b5676ce6 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -120,6 +120,12 @@ enum x86_topology_cpu_type {
 	TOPO_CPU_TYPE_UNKNOWN,
 };
 
+enum amd_cpu_type {
+	AMD_CPU_TYPE_PERFORMANCE	= 0,
+	AMD_CPU_TYPE_EFFICIENCY		= 1,
+	AMD_CPU_TYPE_LOW_POWER		= 2,
+};
+
 struct x86_topology_system {
 	unsigned int	dom_shifts[TOPO_MAX_DOMAIN];
 	unsigned int	dom_size[TOPO_MAX_DOMAIN];
diff --git a/arch/x86/kernel/cpu/topology_common.c b/arch/x86/kernel/cpu/topology_common.c
index cf7513416b70..e1cc25a115ca 100644
--- a/arch/x86/kernel/cpu/topology_common.c
+++ b/arch/x86/kernel/cpu/topology_common.c
@@ -42,8 +42,8 @@ enum x86_topology_cpu_type get_topology_cpu_type(struct cpuinfo_x86 *c)
 	}
 	if (c->x86_vendor == X86_VENDOR_AMD) {
 		switch (c->topo.amd_type) {
-		case 0:	return TOPO_CPU_TYPE_PERFORMANCE;
-		case 1:	return TOPO_CPU_TYPE_EFFICIENCY;
+		case AMD_CPU_TYPE_PERFORMANCE:	return TOPO_CPU_TYPE_PERFORMANCE;
+		case AMD_CPU_TYPE_EFFICIENCY:	return TOPO_CPU_TYPE_EFFICIENCY;
 		}
 	}
 
-- 
2.34.1

