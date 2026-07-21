Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010057.outbound.protection.outlook.com [52.101.201.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52A446A5FB;
	Tue, 21 Jul 2026 15:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784648762; cv=fail; b=Va3HI23Mag8Tpq1AYOfOuTW3vdS+XyW0/rNFntVQn5dS88NE8HgwAwU+G+AyBP/3pMV9hT6abfrQsf8uUbiCJKpPsubW6rRtfmbtY5cqFyvOxLUlWzqI36rWw7f7faC9YdP2Tp7DW0P+9dW5us1Dcaa6SqrUWaG6hzcRmWE1/Qo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784648762; c=relaxed/simple;
	bh=vsHws8csidWrNpib+d6gedcuqwlPTJkobPTf94DVBkw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XlqGpHdhO2mO84BR+uVc59RxlV0bwLtNAyo7l/RMv6M08NMdg3CMVRoxEiloq38zEt+hBHf0eP/NRhzpCZSCdxsibgVBa1WEWCcObkO+Pq148C4UetzSshj6qKIJsJ73KlPIzs11sBMeD8WSOOEMSl02C+Eiv0hNb4ndy7zSufw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XUcbOZLy; arc=fail smtp.client-ip=52.101.201.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XUcbOZLy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wohYrkiv+fYRR4903HCvgz3gf4Eux5Gvw+ARGF3y9AZWx99rE8V87gqwCLkkWUz9bWJamCVwT5by/LyTs0lVBvQd+InMYYHs3WGxBNMlJOcD5PDGULXuwfPtUpyqlDaBuEARDJe/Jag4EWxr3mTeCJDJu+1XG3Lc+vhrrZyqL89fKP32RS5dHEhsh9aqZ+cB6o5DG9uZTwzbOKJWzumNGejH/1WfKGkP2Y02ZQrVm/nJloi/F6xd41WYGDqMYrQJYoBIXb4w670OiBGzPTMVLdHU5todAl3DtHxhv5uxPqwmxB5wOn2Q6al1CImzE2kQ9CtU5bbRe5pIE128rdu9EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/L07o1ww/inBh7UnCF4XcmyOo4tV7197IvO+EVv/ivQ=;
 b=IuvXMEFWd7KZvRsjmnegwWRF0R2vF+7Eo8pQ9cvpY4LqIhtNJD0aaQ/R/kvDDGtqtlwXXR+0GtGAZcr7ZYR8ZCsvx3F5+utdKC30RAw7zqUuD0Kkh3SvUgkVmqEl7LZr/NfCcy+2sw7VkfcWeVQEZAbLSwXDtdIGeC+UuOZ+yT97Z2PNjQwZNAVjV1sk9T+8nSQnd1J1dpOxuFKQqN6lco3ishcsWCHdfuV2do4CkALIYCr/R3B3ukrjKieszhKzgofF+qiJAPbYYxjQ/rSQoLmh3NH9QscHR/asI+OnVYt8McMMDFXzvcptWkcki8VCmtVHYsrTl9yKhIJ/6L8Uqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/L07o1ww/inBh7UnCF4XcmyOo4tV7197IvO+EVv/ivQ=;
 b=XUcbOZLynVLy1SM4/GaJFBEX72XAbEH1WujZbTsEB5xbAOMPktRIb2p29amOkmICeiLquu0xc7rjwxY+5TGtv67IuIRAo0gDI9VoPbaHfuU3l/jJV+ELUlxWIbOulIc2J66MjlYXKXKqtfUUti955CzhjlUsMjkcMXNpym17GwU=
Received: from SA0PR11CA0076.namprd11.prod.outlook.com (2603:10b6:806:d2::21)
 by CH3PR12MB8660.namprd12.prod.outlook.com (2603:10b6:610:177::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 15:45:54 +0000
Received: from SA2PEPF00003AE5.namprd02.prod.outlook.com
 (2603:10b6:806:d2:cafe::3f) by SA0PR11CA0076.outlook.office365.com
 (2603:10b6:806:d2::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Tue,
 21 Jul 2026 15:45:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE5.mail.protection.outlook.com (10.167.248.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Tue, 21 Jul 2026 15:45:53 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 21 Jul
 2026 10:45:49 -0500
From: Vishal Badole <Vishal.Badole@amd.com>
To: <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<rafael@kernel.org>, <lenb@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<peterz@infradead.org>, <tony.luck@intel.com>, <chang.seok.bae@intel.com>,
	<wei.w.wang@hotmail.com>, Vishal Badole <Vishal.Badole@amd.com>
Subject: [PATCH v2 3/3] x86/topology: Add TOPO_CPU_TYPE_LOW_POWER
Date: Tue, 21 Jul 2026 21:15:14 +0530
Message-ID: <20260721154514.2506972-4-Vishal.Badole@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260721154514.2506972-1-Vishal.Badole@amd.com>
References: <20260721154514.2506972-1-Vishal.Badole@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE5:EE_|CH3PR12MB8660:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f361262-ef2e-4f53-3826-08dee73f2600
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|36860700016|32650700020|82310400026|1800799024|6133799003|10067099003|56012099006|5023799004|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	osFh1vO/ZEiLwIj98V2TOff5aVuve4oCt9jZrY6saqqRekmFKiSkM2Tw71X6s4cQqKCq0b/sBz/sLMRrZ2UgBEUjYjXM+7+pFMeGFA16fzsgaHqXzx6Tc2OxVl5GvxRcjsZ2182KD/pLgB57OV8rXCB8vo1wP96kLQHAjpOKHen0ng+GY2GMMrsnDnlbyZBuKEbxKImrOS2esMa15p/Q5XOAfszaRsWxqhLB2sAYK4JaSkzdUl2KY+ZRlixZUplJq5f238/lm64Ch/fj3b8ho5EIXcHgXnjoPDo5mC7R+jSgXoh1g1Vyj+EJxRjRns88DNg02k2HXNkID2gZlgXqbdyD+YDPGNxxd+es2gz2tjT4TUNIWrwXzsslfKaygP08JV5TF0F9+sKpj0xCjHhRrXcHJpDHhs8dOqIEfYphwqa1AviF1LZmrAC7wtIbVqaTUoEtKMxy2tnEpktNBFx+13PnoJEC0L7zrwJV+bmgej0Vl/06J4gP2fDVjewvZQvZXOnAirvcYbeiwXdiVqhsucEK53yZ9OxlJ1jyhQoYdYU8k68JKu4NzgpYUtY3hbWZAnL5VimZvX1MKUgAZGboCpu7otl1tm47+zXF3UHmiiC4HhZUuxMx+CROw8KmVH4jkeMOghgeJ+UNbUZ/PEH8h17rtpnOzHehY3b04U+4d1nYIe3xpQgtKU81sBFD6y0HS6bBgGl0FSlbECxYfGA76g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(36860700016)(32650700020)(82310400026)(1800799024)(6133799003)(10067099003)(56012099006)(5023799004)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vWHC2gwdxsK9XCa4nSdXjyR1lg3YwfK1T2LpOBfJs0R01XAZEdl3JQzbCU3aXhqTPoinjhyESW45ofazpyzWnRQ7IBxWvk/iGCFZjTNvoAvdW0nYbTNmtb5mBtGMb3a4RrwEgKqg2jYEXgeBwsitjoGCjF7O1+Mc4ZPy92DCMkhwv7Tmb+P88uYWfJJtsylkkoMCwsi8NNC1J9svJ5Ub97oII6nPqJ53Xk50Px++m6h9d8b3njvBfK9F1hhQtuRXz8yODH58w/e+9i9brXEbc9yTSAQv0ahF4g4Yfyt/gRSI/WIwQtgGi2gF3Fv+kNIWZgwhNdJWLhrIFjKSyn8Hokq489z6njKUTwrF5gYGiv7Wao2qptxeNKokZslbmO6PdTHtvKatD1LnG/jfVBXPdq0yWAU1H7REOKm4AyhpdktKZ6qb+Vkl7KlfN3geMWz+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 15:45:53.9059
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f361262-ef2e-4f53-3826-08dee73f2600
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8660

AMD heterogeneous parts report a third core type via CPUID
Fn0x80000026 EBX[31:28] (Extended CPU Topology, Core Type):

  0 - Performance
  1 - Efficiency
  2 - Low Power

get_topology_cpu_type() only translates the first two, so on parts
that ship low-power cores the third type falls through to
TOPO_CPU_TYPE_UNKNOWN. That has two visible effects:

  - /sys/kernel/debug/x86/topo/cpus/* reports cpu_type "unknown" via
    get_topology_cpu_type_name().

  - amd_get_boost_ratio_numerator() hits the default arm of its
    x86_topology_cpu_type switch and uses the
    CPPC_HIGHEST_PERF_PREFCORE fallback instead of scaling by
    amd_get_highest_perf() as efficiency cores do.

Add TOPO_CPU_TYPE_LOW_POWER, translate AMD_CPU_TYPE_LOW_POWER to it
in get_topology_cpu_type(), and expose a "low_power" name via
get_topology_cpu_type_name().

In amd_get_boost_ratio_numerator(), share the efficiency-core arm of
the switch with the new type so low-power cores scale by
amd_get_highest_perf() rather than the performance-core ceiling. The
new case sits under the existing
cpu_feature_enabled(X86_FEATURE_AMD_HTR_CORES) gate and therefore
applies to every HTR_CORES-capable AMD/Hygon part that reports core
type 2.

Signed-off-by: Vishal Badole <Vishal.Badole@amd.com>
---
 arch/x86/include/asm/processor.h      | 1 +
 arch/x86/kernel/acpi/cppc.c           | 3 ++-
 arch/x86/kernel/cpu/topology_common.c | 3 +++
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index fc0350fe8f5e..9e8183441888 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -73,6 +73,7 @@ enum x86_topology_cpu_type {
 	TOPO_CPU_TYPE_ANY = 0,
 	TOPO_CPU_TYPE_PERFORMANCE,
 	TOPO_CPU_TYPE_EFFICIENCY,
+	TOPO_CPU_TYPE_LOW_POWER,
 	TOPO_CPU_TYPE_UNKNOWN,
 };
 
diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
index b8f5dd0a8117..bbade0da5130 100644
--- a/arch/x86/kernel/acpi/cppc.c
+++ b/arch/x86/kernel/acpi/cppc.c
@@ -281,8 +281,9 @@ int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator)
 			/* use the max scale for performance cores */
 			*numerator = CPPC_HIGHEST_PERF_PERFORMANCE;
 			return 0;
+		case TOPO_CPU_TYPE_LOW_POWER:
 		case TOPO_CPU_TYPE_EFFICIENCY:
-			/* use the highest perf value for efficiency cores */
+			/* use the highest perf value for efficiency and low-power cores */
 			ret = amd_get_highest_perf(cpu, &tmp);
 			if (ret)
 				return ret;
diff --git a/arch/x86/kernel/cpu/topology_common.c b/arch/x86/kernel/cpu/topology_common.c
index 71b6c33afe0b..581f2fcd7e42 100644
--- a/arch/x86/kernel/cpu/topology_common.c
+++ b/arch/x86/kernel/cpu/topology_common.c
@@ -44,6 +44,7 @@ enum x86_topology_cpu_type get_topology_cpu_type(struct cpuinfo_x86 *c)
 		switch (c->topo.amd_type) {
 		case AMD_CPU_TYPE_PERFORMANCE:	return TOPO_CPU_TYPE_PERFORMANCE;
 		case AMD_CPU_TYPE_EFFICIENCY:	return TOPO_CPU_TYPE_EFFICIENCY;
+		case AMD_CPU_TYPE_LOW_POWER:	return TOPO_CPU_TYPE_LOW_POWER;
 		}
 	}
 
@@ -57,6 +58,8 @@ const char *get_topology_cpu_type_name(struct cpuinfo_x86 *c)
 		return "performance";
 	case TOPO_CPU_TYPE_EFFICIENCY:
 		return "efficiency";
+	case TOPO_CPU_TYPE_LOW_POWER:
+		return "low_power";
 	default:
 		return "unknown";
 	}
-- 
2.34.1

