Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010001.outbound.protection.outlook.com [52.101.56.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD2E44607D;
	Tue, 21 Jul 2026 15:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784648751; cv=fail; b=fUpMh2O05bTHNLw+AXTbGGt/TmSKoaZHmt1WTsQ2Km3aHVp5l5GI4aU0YXD+bB4vfl2a7gnhXSyCUjeWdZ3Z0UMdro9BMjusrTZEZ74yi8mFz7k4c4CLZngVuky+GGaOyGCsj5707nQ8ib1KPO5DpE5Pc/vToRwUm0hHa4uLmzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784648751; c=relaxed/simple;
	bh=HiOFkjfB/MBfO1S/TanrOdUBgrv5pF7uc3fPQM6BwtM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=agku/Llv3XYEyUyU6Z/oWWzJ2/AN8P52bSz68VZlsfbZsqT1KTzyx+8jozn4h9iqWJ1GTcGDF59gUZsS65za+eJEYkJZgInJ9lLcs+1FS+uW/ikaK4V9AWh4gLaOkxP1RCJogzk4PyE+Eh7LpLZ1U/UmeAC/tBqd3CYTxDdIP48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eVnM0nuU; arc=fail smtp.client-ip=52.101.56.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eVnM0nuU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vJEWy6zf+Fo8rg3jocX2qLxsAo3uKLsezdC/yRJ+JamTPEYqSjEa4SbamuoKnURwRME+IJyXGee98uCRfJ5wNqhFM+eCF4oLZMAKXeTkAkFSyIimpdJ99+1gEp1mOHvSpY+Qx/Ji/NihbS7oQoJ6fzxQgW0KmP/JoVbJBO6NMPZnP4rhS82rbst9DhhRvHEFk3YXepsEJWs3ftM/vAOssPXfoqSDjKBnOWh/ca8HziXI272ro2HLU348RlCmrMDcY5Af2UI96hGaQKbXju8G+Buit9U7+pirkdwTxgiNOiPdE9R0k6RoqxGLoByoGat+hgP+ayYM3s3CDM8R066YiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iq/zY5T/JuhAvT0KiGtWfatENPOgIKJdhvRs8qkjJts=;
 b=DiCN/S5U6IkrpgbkZJOgWz8/z8ojG/NNPNc+iiAgz4bul3PHT97ohkxYjLghhsf/Bc/6qO+otuPWylG/u+E51EfdQ4Wv/kV5QI7MG/p1Hlog/1YVGetoAs/Aljnwh6/VmMFiS3obyvfbMblXpz207KuRmMMs3gYl7k3tsnNsiZoOUnqfkCEwJlpmz2jqP0duZ13+Q5E4n5ABBwUbYxQZxZazq3KNEEZ29PqoKxgEoTwg1lxEbCJSeWNfHoKvasUW8GQQkE7D0EsL+2jIF0RRtoQPFDshQqxizIiz71X/WUkYiHeSz/nVO4Gpqe4GZ/b58UUKD1QgYbhal6pWDAzhhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iq/zY5T/JuhAvT0KiGtWfatENPOgIKJdhvRs8qkjJts=;
 b=eVnM0nuUvn9G1Q6elJTFPNoRpZMFFtPpmVE30HpMgjbRWvyMpb0paCqtrssWEOlcGCtTnOiKc0mVoWe2XB3Psa++IU+9Hm9Z7sm292HfVOUXqWebhJrT3O8aco0J3ljFUlqWrQozq0Q8K1lJ7l62zlk7gl6b9M1G7JyoWs93QhE=
Received: from SN6PR2101CA0006.namprd21.prod.outlook.com
 (2603:10b6:805:106::16) by PH7PR12MB7017.namprd12.prod.outlook.com
 (2603:10b6:510:1b7::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 15:45:45 +0000
Received: from SA2PEPF00003AEA.namprd02.prod.outlook.com
 (2603:10b6:805:106:cafe::70) by SN6PR2101CA0006.outlook.office365.com
 (2603:10b6:805:106::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.4 via Frontend Transport; Tue, 21
 Jul 2026 15:45:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AEA.mail.protection.outlook.com (10.167.248.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Tue, 21 Jul 2026 15:45:45 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 21 Jul
 2026 10:45:41 -0500
From: Vishal Badole <Vishal.Badole@amd.com>
To: <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<rafael@kernel.org>, <lenb@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<peterz@infradead.org>, <tony.luck@intel.com>, <chang.seok.bae@intel.com>,
	<wei.w.wang@hotmail.com>, Vishal Badole <Vishal.Badole@amd.com>
Subject: [PATCH v2 1/3] x86/topo: Map vendor CPU types to generic Linux such types
Date: Tue, 21 Jul 2026 21:15:12 +0530
Message-ID: <20260721154514.2506972-2-Vishal.Badole@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260721154514.2506972-1-Vishal.Badole@amd.com>
References: <20260721154514.2506972-1-Vishal.Badole@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEA:EE_|PH7PR12MB7017:EE_
X-MS-Office365-Filtering-Correlation-Id: 41a6e7bb-0e26-403b-550a-08dee73f2114
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|32650700020|82310400026|36860700016|7416014|376014|1800799024|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	pAVd6ymwiMbkyyAU3u938piH/4LH2h1ZanlDi8/VlOjiRp9zJcIkKKEO3hV9jTEisHIXOY/EJo78Wxj/CgEYKyNcYXvoTaEHI9snGDYtp1irf4+iY4w/pf/EPbCtrzHKRqWU1EWDEqoyPcmJAUoPbokLIC5G6gx+Nc6UjC9aMk1u40s8ofxxjBzA+rRNfBeRakY3Zehc6E7nCePYIYe9TztI/jfB0FpxR+lxjBk/EwUpH9RG8w3v4/121GUn2Z6CpkSvnzY3i5/ut6PqdmFw195Rc7JWiDZ2F++JszeRqJsNmRi0auC2iGNyOovNzrKHxBkJvF0NxGmi8+PA1xzf/zMPgU3/V9E9AxWsw3t3vIX0RwYDCymg/bbdGRHNddYRKir3ApXIaSNsQU1olRVxW8+shXKpAu/w8xF+/nsuCpaOm7OEvGGXdzQFFFMfQ06N8UEZwp4PQb51RO+U1g7Rx1sXGQsEqIM+ar24BiESwr7eA6NKxheAqgkoVKiBzGmIen3hRcceJNTK8fTpW0BIIZYYx62eWwvGcPKcdPgOvDMH85RKu98BLK6zSIXHr+X9+TpiAgWv9Ub1mcBiRFYJ6xg1gF8MeCh7mOrMuSrOjC4bu+DWFzvxhC5EUxTepGaeNOwwxAk7BRJnJR0KQYY2GA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(32650700020)(82310400026)(36860700016)(7416014)(376014)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nGM+XjXaJj+59DMTrzISBHAtIhq6UjcKD4ke5NSeNqVHVOzbete80Z+IaX82FDU3juVDSzMc7Z7T12BOF6HsbD6AKtxGvex7Q1Ypjb/hLUOn5q8Ta3HD2q+5nz4HfjftKv61f1G4etyRpQKefCJQNP63/h/EbjlR6+a9nen7D7fUdO2fa67c1ABUa1t9Ez9i9ViJtx4tZ5IajnHXp6M1DKtpN79lKUUTQbq3AACyCV2Kfyr1LALpkJUeMnRLqGPmxjgC/22JOsISSQgv7dee9bXw2Wyq7y0kHSSk9RSV53L4npyuekPl94bQTrrEa8IDK1Q+3jUi22A0AKoLBREcShwP7SUFYwkxv6fTrRRWeYfdagM3hban6d5Zsl/Z7iOR9ADRNQpmgRqqBEN0rVqvxbi49Q6nVeABc8GAIcwROEIlgnVoBVOMqwWtroZmor04
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 15:45:45.6450
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41a6e7bb-0e26-403b-550a-08dee73f2114
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AEA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7017

From: "Borislav Petkov (AMD)" <bp@alien8.de>

Sashiko reported¹ that a confusion could ensue if a vendor-specific CPU
type 0 (performance) gets attempted to be used in a x86_cpu_id match
table. The current logic treats 0 as the wildcard X86_CPU_TYPE_ANY and
such a thing would end up matching the wrong CPUs.

This is all backwards because we started using the vendor-specific CPU
type number instead of using a Linux-defined, generic CPU type which
is agnostic.

Convert the current logic to it before users start appearing.

  ¹https://sashiko.dev/#/patchset/20260629094349.533301-1-Vishal.Badole%40amd.com

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Vishal Badole <Vishal.Badole@amd.com>
---
 arch/x86/include/asm/processor.h      | 18 ++++++++++++----
 arch/x86/include/asm/topology.h       |  7 -------
 arch/x86/kernel/acpi/cppc.c           |  4 ++--
 arch/x86/kernel/cpu/match.c           | 30 +--------------------------
 arch/x86/kernel/cpu/topology.h        |  1 +
 arch/x86/kernel/cpu/topology_amd.c    |  6 ++++--
 arch/x86/kernel/cpu/topology_common.c |  8 +++++--
 7 files changed, 28 insertions(+), 46 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 87b1d4c0727e..fc0350fe8f5e 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -68,9 +68,13 @@ extern u16 __read_mostly tlb_lld_2m;
 extern u16 __read_mostly tlb_lld_4m;
 extern u16 __read_mostly tlb_lld_1g;
 
-/*
- * CPU type and hardware bug flags. Kept separately for each CPU.
- */
+enum x86_topology_cpu_type {
+	/* X86_CPU_TYPE_ANY */
+	TOPO_CPU_TYPE_ANY = 0,
+	TOPO_CPU_TYPE_PERFORMANCE,
+	TOPO_CPU_TYPE_EFFICIENCY,
+	TOPO_CPU_TYPE_UNKNOWN,
+};
 
 struct cpuinfo_topology {
 	// Real APIC ID read from the local APIC
@@ -104,7 +108,7 @@ struct cpuinfo_topology {
 
 	// Hardware defined CPU-type
 	union {
-		u32		cpu_type;
+		u32		hw_cpu_type;
 		struct {
 			// CPUID.1A.EAX[23-0]
 			u32	intel_native_model_id	:24;
@@ -119,8 +123,14 @@ struct cpuinfo_topology {
 				amd_type		:4;
 		};
 	};
+
+	// Linux vendor-agnostic CPU type
+	enum x86_topology_cpu_type cpu_type;
 };
 
+/*
+ * CPU type and hardware bug flags. Kept separately for each CPU.
+ */
 struct cpuinfo_x86 {
 	union {
 		/*
diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 8fb61d2465eb..ef76ba674f1b 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -114,12 +114,6 @@ enum x86_topology_domains {
 	TOPO_MAX_DOMAIN,
 };
 
-enum x86_topology_cpu_type {
-	TOPO_CPU_TYPE_PERFORMANCE,
-	TOPO_CPU_TYPE_EFFICIENCY,
-	TOPO_CPU_TYPE_UNKNOWN,
-};
-
 struct x86_topology_system {
 	unsigned int	dom_shifts[TOPO_MAX_DOMAIN];
 	unsigned int	dom_size[TOPO_MAX_DOMAIN];
@@ -160,7 +154,6 @@ extern unsigned int __num_nodes_per_package;
 struct cpuinfo_x86;
 
 const char *get_topology_cpu_type_name(struct cpuinfo_x86 *c);
-enum x86_topology_cpu_type get_topology_cpu_type(struct cpuinfo_x86 *c);
 
 static inline unsigned int topology_max_packages(void)
 {
diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
index be4c5e9e5ff6..b8f5dd0a8117 100644
--- a/arch/x86/kernel/acpi/cppc.c
+++ b/arch/x86/kernel/acpi/cppc.c
@@ -241,7 +241,6 @@ EXPORT_SYMBOL_GPL(amd_detect_prefcore);
  */
 int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator)
 {
-	enum x86_topology_cpu_type core_type = get_topology_cpu_type(&cpu_data(cpu));
 	bool prefcore;
 	int ret;
 	u32 tmp;
@@ -273,8 +272,9 @@ int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator)
 
 	/* detect if running on heterogeneous design */
 	if (cpu_feature_enabled(X86_FEATURE_AMD_HTR_CORES)) {
-		switch (core_type) {
+		switch (cpu_data(cpu).topo.cpu_type) {
 		case TOPO_CPU_TYPE_UNKNOWN:
+		case TOPO_CPU_TYPE_ANY:
 			pr_warn("Undefined core type found for cpu %d\n", cpu);
 			break;
 		case TOPO_CPU_TYPE_PERFORMANCE:
diff --git a/arch/x86/kernel/cpu/match.c b/arch/x86/kernel/cpu/match.c
index 4604802692da..7ab077f0cc66 100644
--- a/arch/x86/kernel/cpu/match.c
+++ b/arch/x86/kernel/cpu/match.c
@@ -5,34 +5,6 @@
 #include <linux/export.h>
 #include <linux/slab.h>
 
-/**
- * x86_match_vendor_cpu_type - helper function to match the hardware defined
- *                             cpu-type for a single entry in the x86_cpu_id
- *                             table. Note, this function does not match the
- *                             generic cpu-types TOPO_CPU_TYPE_EFFICIENCY and
- *                             TOPO_CPU_TYPE_PERFORMANCE.
- * @c: Pointer to the cpuinfo_x86 structure of the CPU to match.
- * @m: Pointer to the x86_cpu_id entry to match against.
- *
- * Return: true if the cpu-type matches, false otherwise.
- */
-static bool x86_match_vendor_cpu_type(struct cpuinfo_x86 *c, const struct x86_cpu_id *m)
-{
-	if (m->type == X86_CPU_TYPE_ANY)
-		return true;
-
-	/* Hybrid CPUs are special, they are assumed to match all cpu-types */
-	if (cpu_feature_enabled(X86_FEATURE_HYBRID_CPU))
-		return true;
-
-	if (c->x86_vendor == X86_VENDOR_INTEL)
-		return m->type == c->topo.intel_type;
-	if (c->x86_vendor == X86_VENDOR_AMD)
-		return m->type == c->topo.amd_type;
-
-	return false;
-}
-
 /**
  * x86_match_cpu - match current CPU against an array of x86_cpu_ids
  * @match: Pointer to array of x86_cpu_ids. Last entry terminated with
@@ -81,7 +53,7 @@ const struct x86_cpu_id *x86_match_cpu(const struct x86_cpu_id *match)
 			continue;
 		if (m->feature != X86_FEATURE_ANY && !cpu_has(c, m->feature))
 			continue;
-		if (!x86_match_vendor_cpu_type(c, m))
+		if (m->type != X86_CPU_TYPE_ANY && c->topo.cpu_type != m->type)
 			continue;
 		return m;
 	}
diff --git a/arch/x86/kernel/cpu/topology.h b/arch/x86/kernel/cpu/topology.h
index 37326297f80c..74e02bacd854 100644
--- a/arch/x86/kernel/cpu/topology.h
+++ b/arch/x86/kernel/cpu/topology.h
@@ -22,6 +22,7 @@ void topology_set_dom(struct topo_scan *tscan, enum x86_topology_domains dom,
 bool cpu_parse_topology_ext(struct topo_scan *tscan);
 void cpu_parse_topology_amd(struct topo_scan *tscan);
 void cpu_topology_fixup_amd(struct topo_scan *tscan);
+enum x86_topology_cpu_type get_topology_cpu_type(struct cpuinfo_x86 *c);
 
 static inline u32 topo_shift_apicid(u32 apicid, enum x86_topology_domains dom)
 {
diff --git a/arch/x86/kernel/cpu/topology_amd.c b/arch/x86/kernel/cpu/topology_amd.c
index da080d732e10..c5a6944df86a 100644
--- a/arch/x86/kernel/cpu/topology_amd.c
+++ b/arch/x86/kernel/cpu/topology_amd.c
@@ -177,8 +177,10 @@ static void topoext_fixup(struct topo_scan *tscan)
 
 static void parse_topology_amd(struct topo_scan *tscan)
 {
-	if (cpu_feature_enabled(X86_FEATURE_AMD_HTR_CORES))
-		tscan->c->topo.cpu_type = cpuid_ebx(0x80000026);
+	if (cpu_feature_enabled(X86_FEATURE_AMD_HTR_CORES)) {
+		tscan->c->topo.hw_cpu_type = cpuid_ebx(0x80000026);
+		tscan->c->topo.cpu_type    = get_topology_cpu_type(tscan->c);
+	}
 
 	/*
 	 * Try to get SMT, CORE, TILE, and DIE shifts from extended
diff --git a/arch/x86/kernel/cpu/topology_common.c b/arch/x86/kernel/cpu/topology_common.c
index cf7513416b70..b9d025f3373a 100644
--- a/arch/x86/kernel/cpu/topology_common.c
+++ b/arch/x86/kernel/cpu/topology_common.c
@@ -168,8 +168,12 @@ static void parse_topology(struct topo_scan *tscan, bool early)
 	case X86_VENDOR_INTEL:
 		if (!IS_ENABLED(CONFIG_CPU_SUP_INTEL) || !cpu_parse_topology_ext(tscan))
 			parse_legacy(tscan);
-		if (c->cpuid_level >= 0x1a)
-			c->topo.cpu_type = cpuid_eax(0x1a);
+
+		if (c->cpuid_level >= 0x1a) {
+			c->topo.hw_cpu_type = cpuid_eax(0x1a);
+			c->topo.cpu_type    = get_topology_cpu_type(c);
+		}
+
 		break;
 	}
 }
-- 
2.34.1

