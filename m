Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011047.outbound.protection.outlook.com [40.107.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9C53F9F4D;
	Mon, 29 Jun 2026 09:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782726313; cv=fail; b=SSzpY2pFkVFb56eht4r6tYsOkp5W6z9FmUOdDZuZpILuEKax9Nj8lh0TUKKnHlNVIDxdAM8QHIv8T9t7jgZkv9o/YuUVaNJ3+2GI6BxQ7ovWocQQ7dqmcUQGxmZuQFp3lYbpXYPgSAViUlBrBB0fbBy8N1umm9QjIv/eNQ0zW3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782726313; c=relaxed/simple;
	bh=SzYywgF/JdN1fzkAlnP1wrR7VromZrJ+pvPmISxEHnk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nSy9luOzjM3WagXbow7L21fqQAfmiyYLwTEcg90L5W5U1jQGnBNSOSCp0sbVMIopdDp0Eh8QxROTv1N1bs3dh5t3afoc3dHZmkHelfZYbYsNlpl5jvOF/QKFdiBcxfSyvrK0hs3MyFloCIngz4DaHtzwJYAkmhji7UzDozrrIjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uGA650Jq; arc=fail smtp.client-ip=40.107.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uGA650Jq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=onmjMMUmrv9pcR5tgksbwGw5VwHfjkUEYG1NSshP1y3koJk77trMzD3CVexXvRVEpVfTr125ajruXGrYnAiYiWOo32MSjSIW7JKI7Y2heUxEWfmNCFPDAY/4L8z4Jgbdv8opGhtHLuiZTpZtaO4r5r9cP4+lW//H6YZYQ6zPXbsIFtMS8HNtZ1/nVSM3SSRQzU+/frL9cFIMChiurSxcatNgohT9b1uGHlQEhDeAr65BtEe7XFMdn2xxE45bIvVJfaAGGpkH/ibi8QZ2urGfA7ZPYkgIjDDVofYxqkDeWQk/7CfVcQ6tZ9oKa1JPWIVZJqmZsd2czDHthNN4TOowfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3cYpjkP1KSJWHI4InanXEI5cZlqo+Imm2/7e4+5Z6MQ=;
 b=EiHkZPeeHFNB/CyO/jMwwkd8aD1qLPTOOw8zdDHftvMBE5VIjuMb4QV2DnVhT+8jfmDDjuRncxC83CzDmBhUgTbUBrTi7OwOGrlcQ25JB8BqRwmxd8d8Pnefa+nYWsDDWctP9y5wvGN4gYLDz2Vb8aSpRi+X9hMNQ+rdyu9KZoOtmwQrishXOyRiH3wRhp7uDBcouqpz7E3qcVi3FFduzKgtctracsbs+I+67BHvZlJ2a0sfnzOwjuyKlxrXPnA+L5I29ZACyp4PSgbuN7FOphDRNTzjiBa4YIDOssvB+LMWA98CAUZzFJclSwooCesLbaIWWmHTEg4SArApimyZyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3cYpjkP1KSJWHI4InanXEI5cZlqo+Imm2/7e4+5Z6MQ=;
 b=uGA650JqwerOujHF/SIJhpnZsKvAIwDbYtSOOGxgmuBAu/f4aUiKoo8ejZqCmz+Qr63PIbyfiTXIFduor3UvC3rIL9cricemei3E8TDZfKVSN0yPUALv7dHNoX7c8tsLGh4+fgrH0QY9/ipjgfgHY4EDw9503tdonTMc5d45BtM=
Received: from CH0PR03CA0200.namprd03.prod.outlook.com (2603:10b6:610:e4::25)
 by CH2PR12MB4069.namprd12.prod.outlook.com (2603:10b6:610:ac::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 09:45:07 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:610:e4:cafe::6b) by CH0PR03CA0200.outlook.office365.com
 (2603:10b6:610:e4::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 09:45:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 09:45:07 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 04:45:00 -0500
From: Vishal Badole <Vishal.Badole@amd.com>
To: <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<rafael@kernel.org>, <lenb@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<peterz@infradead.org>, <tony.luck@intel.com>, <chang.seok.bae@intel.com>,
	<wei.w.wang@hotmail.com>, Vishal Badole <Vishal.Badole@amd.com>
Subject: [PATCH 0/2] x86/topology: Add support for Low Power cpu_type
Date: Mon, 29 Jun 2026 15:13:47 +0530
Message-ID: <20260629094349.533301-1-Vishal.Badole@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|CH2PR12MB4069:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d0d0db6-4f66-4ad7-c761-08ded5c31abb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|32650700020|36860700016|376014|1800799024|23010399003|5023799004|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	Of52MAfU2dmfKbQjQtYfl2CGFrhhzv0ph//ds6NNiQPAKkCDj3yqfM+8ioQ5DW0+GfNKwQVJSYFcVxao+wwrhQFnlJ5ELPt9LIcG4PgG1EEjvw9uVeQpWQq7bREl4rv2ECQzlsl7sEMuj46H0gPAVZ7iHAm7d4uvf2icpYmPlm6cwDwX4MlFDrzf2gPP/2v02CGCC78vHKbud7vWAwE99lJNhmlDih6cpsqk/l89vTWiN8e60JRS0GgWGGKfFPuu4tudunCxFih6EsYziEQVCvNRUht1Z003Uo9iAM4TPvV46d+oo4ZvxnyjV0U4mqzgbCnvAJOP1ZL8MCqK2tTjDOkcgwM2dz6aDCngLXAMyUCTnOk6Pu5RKjoppXx7Lldg60VEyaQ0F8taCGNbn/EQ5D/WMdLTJxGkkq9y2zhqtwfaXfnHcLbFLcz0otP8dyAie3qsM7PkG+Mp1qkWCooHDdi+SlhkDsjyw/rkqHzbMoS8PqIJ6xWdYtg++oTAKtjxV31cipTv6sty3xH1YyG07W+jTC2bhe+/4W2DkhvtJPG9P2Ts4oFfpB8XYdLg2hPV43UG2omFB7uSiMXlVbt9FbofF+/mZltNLBCkKwqub+3MbtnQFigbSwIkuGior0hW9pvdK5Fny6DV6aniBdBlVCPNWTPMMpKJUvhoocUC2kKhCzbB51dY+Wvx9uNo9D+tq6ozc/swJHVC5nLj9YCpcQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(32650700020)(36860700016)(376014)(1800799024)(23010399003)(5023799004)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	U3o2u95Na7oRXi0A7s7zqnYyJAAvMG9hrtYj7GrFh2KohL5UyiYJHmURVFIjc+vSYzYOXQWB0JNiNYoXKuGziTW/jnA1O1u3f4vr1fHjXPqDahwMrv4Y0yjLYllI/6ex2nxpB411uSsxmPiRss5hygab5ifpmj3C1IjTX07IR8D/cZXHOoqlM7Y0areD8IskT4o7DeZFzFntePfL3hAUUtMltw9DZzRFkbyAv/ax0F1aa2i090YFKdoL7AXaPuft3u0jfN9/Y053uTQOzHt9bYRCmK0gldshac3DknhgifXRRC9C5Gl6NpFkzMvpPHoxzp4+GSUDCPg4+0WY0k0sgwmLJYbt3VVGu/tBkVkOExnAsSSLEH2Se/5gsT7ISj45ltY5JveD5X0mJX99DfP5FUEgQAT60vpPsbgVF08VyOj0DW0uosJGwGJ0zLpr7Aow
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 09:45:07.6499
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d0d0db6-4f66-4ad7-c761-08ded5c31abb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4069

This series extends the x86 topology cpu_type classification to support
a Low Power core type, in addition to the existing Performance and
Efficiency types.

AMD heterogeneous parts report the core type via CPUID Fn0x80000026
EBX[31:28] (Extended CPU Topology, Core Type). Value 2 identifies a
low-power core designed for minimal power consumption during background
or idle workloads. Distinguishing it from a regular efficiency core
matters for:

  - user space exposure via /sys/kernel/debug/x86/topo/cpus/*, which
    today reports cpu_type "unknown" for low-power cores

  - amd_get_boost_ratio_numerator(): on every
    X86_FEATURE_AMD_HTR_CORES-capable AMD/Hygon part, low-power cores
    must scale by amd_get_highest_perf() rather than the fixed
    CPPC_HIGHEST_PERF_PERFORMANCE ceiling, matching the existing
    efficiency-core path

The series is structured as:

  1/2 Pre-patch: replace the bare 0/1 in get_topology_cpu_type() with
      named enum amd_cpu_type constants, mirroring the existing Intel
      side. No functional change.

  2/2 Add TOPO_CPU_TYPE_LOW_POWER, wire it through
      get_topology_cpu_type(), get_topology_cpu_type_name() and the
      switch in amd_get_boost_ratio_numerator() so allmodconfig builds
      cleanly under -Werror=switch.

Vishal Badole (2):
  x86/topology: Name the AMD core-type values
  x86/topology: Add TOPO_CPU_TYPE_LOW_POWER

 arch/x86/include/asm/topology.h       | 7 +++++++
 arch/x86/kernel/acpi/cppc.c           | 3 ++-
 arch/x86/kernel/cpu/topology_common.c | 7 +++++--
 3 files changed, 14 insertions(+), 3 deletions(-)

-- 
2.34.1

