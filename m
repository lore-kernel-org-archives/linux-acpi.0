Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013000.outbound.protection.outlook.com [40.107.201.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0838E324B20;
	Mon, 29 Jun 2026 09:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782726324; cv=fail; b=G7S9ah+dFvOJb6tBgqeZSOEFe6CtWRy/32yQxyF8Cszlqa5mAUIFLPValKWuqB7w7RIf3lN9V+8wfMrnv3Nr8UdScy7AXWQYMfuv1y0/+YVkIyS19tBWybhM2KWcGsT3lnWn/EbPytEmKwuj67vzI8Yh2ZNYjD5UgiAtzoy8ZXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782726324; c=relaxed/simple;
	bh=uGO4f5Qz9klYborERKHZ8M1R+CSZLCrxIAFDyam6IYY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jio2JuI++ZkKZFgAAkMnG9s3A26f1+ZX1d3HhyTJMkqLXezVTvSexCIvgxLa+chrIriXnB8qlqvtFq0agDPV2VkukTOAp7vRktoolNwtL9HQV4uqNfQw18hhfYFd06ZQW+kihJNDw3Jpq2YCzYVq6Di7g1x9eO7es/nlK+s0veo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1pSU1cYs; arc=fail smtp.client-ip=40.107.201.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1pSU1cYs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cf5eU8OPSvIg3AQnCSjpyOmg9HOD1p6WdT+GNX9jVmYfFgodbum1f0wIsK+Y6cQ/Mo9ZZm89vdb2sZDxEOMAn3hChCEH5xL3dYVO3j5c3HUGdxij4/V8JKkeMHmnwIxevRsycWJlDixQYjzijLni9Y4H0aaGur69E91uJmCy6F6CMXF9U4MlNp/JgnmdY07qL+LJfmtoPHeHourER9+yy2amUZnslT8+VTznjZ9G3bjfN7bsZ6MQ2JOzGjC5cr2p4EIuRvPxTsyn9KjeC9BlhNZlv7q/mzfcw+FPSaGtrwsnr2bOC+zDVOchxrZEWmLJ0JUvTudb2aw5Fv5pkdo6aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xx+W88/vRKLfFzo1NixEud0Ivz+j/A3bm2cPaVddWTQ=;
 b=NzzkRzNHF47T6FAEDEH0MufrsB1vyHRgKgp0XzdQdUB4Lbjy/NIE+znUgXPp3C6yDD3BFdT6Fx5XQGOoELKuZ29U0kuvFJt99eJbHXOHIt/z9Avnf//8IrPfrONlC2+wQhBKGzIpY9vt2V0D60ZYFzbfPgipJie/DuPNA0CIaxokn8GFHgM8U8hmFqCDWy95kIiyLJyP6pXGCeBCGuvTgfnOhPw8VjPgyvXzJYeqiEsS62rTUJss8Ydh5wrKUpLbxHJu4IvIxun2SHIFf1RpkYKZnGWdESaJaTx8uo2bywPZcBNWm1A6GnjIIPClZjc0QP7ht1zk9H5qUy5LP8Q5FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xx+W88/vRKLfFzo1NixEud0Ivz+j/A3bm2cPaVddWTQ=;
 b=1pSU1cYsEvqsZ4dacgQITlOyblVlB7XzBPXwJ2H22rNV2wxFeLTOgcjSTXCeXRapfLKVHbOpVIdDQfv/j18fqCyOitwkr8HHI6ygbt1KUUkJuMh5DYoWH6kWyjBi0c7HEySwiBRBiqWkxD5BLGjqdedtU0KrfJ7snyndhvQZ78k=
Received: from CH2PR14CA0010.namprd14.prod.outlook.com (2603:10b6:610:60::20)
 by DS0PR12MB8576.namprd12.prod.outlook.com (2603:10b6:8:165::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Mon, 29 Jun
 2026 09:45:13 +0000
Received: from CH2PEPF0000009D.namprd02.prod.outlook.com
 (2603:10b6:610:60:cafe::ae) by CH2PR14CA0010.outlook.office365.com
 (2603:10b6:610:60::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 09:45:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009D.mail.protection.outlook.com (10.167.244.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 09:45:13 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 04:45:09 -0500
From: Vishal Badole <Vishal.Badole@amd.com>
To: <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<rafael@kernel.org>, <lenb@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<peterz@infradead.org>, <tony.luck@intel.com>, <chang.seok.bae@intel.com>,
	<wei.w.wang@hotmail.com>, Vishal Badole <Vishal.Badole@amd.com>
Subject: [PATCH 2/2] x86/topology: Add TOPO_CPU_TYPE_LOW_POWER
Date: Mon, 29 Jun 2026 15:13:49 +0530
Message-ID: <20260629094349.533301-3-Vishal.Badole@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009D:EE_|DS0PR12MB8576:EE_
X-MS-Office365-Filtering-Correlation-Id: 07a21fb1-b256-4da6-6161-08ded5c31df1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|23010399003|376014|32650700020|36860700016|56012099006|18002099003|22082099003|11063799006|5023799004|6133799003;
X-Microsoft-Antispam-Message-Info:
	mv9B9NlTCScFE1OLwYdQhv3PCJla+7VDQG1g6X3ISTpOxriZzCE8IBCDJIo06uPhf2jRyMsQIc3OJfRaw4tqCiYj+TmUr3klnk2TbGK7p/Qzw5ptEY8x7NmpKD097wjexK59Zt8i7Hr+CF6E3NBN+xS02kbKRcrD+b9qw5zs4aSNqBZx8jhHwMM0UHxnN16HWeFKXB8mm1HexWi7qh8eIQyOl3Q21Ri7AKmGa9WyiZtjBDz92TqIbhDmWMecaJVAUH//CMUDDoRscHq0sD52J1tKNh0exARfNyBaYbky0widszetnmi4I2nJ3CVim/WUjNLdpA3N45+gvA2ozagsW8HHQ3yUPYpGVNLb8wAXGfMaD6HeucKbN0lYmwFJhxpRy+cgAx5PsWRDvzO+9zjtve8puXJZAehYZJAkmWHnQNdaT/pqwpqV48bPE6JiDGmpZ9E0RwseIUYBDiQvbBuFnUzb2nyLwYcGYM9Q9wmXhvzRZgWPwn9irPW+v4YLI0l0c2GmTH4rs7LvK4/r3lNbMjPWX5ORArXQnx86OYSejyW+bvjozeMnGDHbswJVpR7ZZZzPDte0Dsh8fJ5GRIlA2uDvt7ldQsWHZDkvTt39eQF6niXD0Znf8s2xKenuWuBQEZZk9PgqA37rcMbJzDq7uWmK8Ky7L+l0Wm2OBxSumqd3hkGHvAkpmhLgHCsxgtaUWqP3lMkx653YAYC9znzv0w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(23010399003)(376014)(32650700020)(36860700016)(56012099006)(18002099003)(22082099003)(11063799006)(5023799004)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Fmt0KAT7kmSTDZskWN0hCnHO+w9p1HDJTxqPVTNQn3yDUirADyEHfsktF8W9rnC4gNPS+NMpSocjzvN1kD/k11fKkDcLeg5f35QvEAO6e+ilpwSCS5LeR3QkoxcLrAuU79EE/EPfPPcO9XQtzo5O80qoKfQyGm8iUQc2Lho57Yvf6jEwXgQOzNywTRFz4lCnu19w5J+diasXL4Lv0OpUdlXBQtqkMzfalOxNiA6/jZOZOPnpWgdxVetzr7we36+daF3PEw3yFNxX7R1U56oOcA+CbmSuv1bf2214UgjWf4sy/eO+MATQ1A8NJ1HpuPNaPbhPSBfy4q6Oij+Dy3oHR3mW5MvBf1vIwUomAlno9EHWrmOfJfIntDbV+F7ugoGs/e3wHcm2yePJ7PKhSdXAoRCiy7XCNxmfQNcoVkrRHsHXK5DvZS8qPkfmFbf5XZvv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 09:45:13.0567
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07a21fb1-b256-4da6-6161-08ded5c31df1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8576

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
 arch/x86/include/asm/topology.h       | 1 +
 arch/x86/kernel/acpi/cppc.c           | 3 ++-
 arch/x86/kernel/cpu/topology_common.c | 3 +++
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 9658b5676ce6..1e65a6ea5de4 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -117,6 +117,7 @@ enum x86_topology_domains {
 enum x86_topology_cpu_type {
 	TOPO_CPU_TYPE_PERFORMANCE,
 	TOPO_CPU_TYPE_EFFICIENCY,
+	TOPO_CPU_TYPE_LOW_POWER,
 	TOPO_CPU_TYPE_UNKNOWN,
 };
 
diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
index d7c8ef1e354d..df2c7579309c 100644
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
index e1cc25a115ca..8c8267c812e0 100644
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

