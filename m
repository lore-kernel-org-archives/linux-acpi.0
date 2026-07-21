Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012041.outbound.protection.outlook.com [52.101.48.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B8B335555;
	Tue, 21 Jul 2026 15:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784648751; cv=fail; b=n/8RbRqHc3jtanfxYDlg2fdLm4Win8nWYZdPfoyu8RbPXEpxuArnwXXJGiorzlYo4JeRjLUEDtNSZymV3I46MX+5/zAatU+siq3lBhq0WhCopDVF1pu+e5SIGeYNOHB9ql8sHDX8BY2/AlbMJ4E5Tx4N+gjeFBrS5H/g4Ben+to=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784648751; c=relaxed/simple;
	bh=C8i5Y7St449LDGNJEJlPh1BRhByP42SeQZ/rv7tbe4Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hU5zoqT9iDl1TjsHf5wcvFNnsNY+VanwTlnA47K+GLNl25TqaX0PzLKE5whxlJzFXf34RU2LFd6kMmSlW12PzSG7j6a141jVtbHNcFn5eBecums7cUp44nsR6+mSG+6SimdtNbuaf04XA7PC6zFj9JoKkG0L6i0CChXd1xuAhgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pCvD410s; arc=fail smtp.client-ip=52.101.48.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pCvD410s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FoGncp1jJqXUr9jUw0OHnzleZS1ksRAPeneEp+rH67/5A+KQTfSRFtqi92AkP5Vru1Kz0aeiurvBb+xyWhHuWf9KQKM2WY+8Vh7hoIXolvQsSftgjki1by3NdIzcKi2hx6uhTtol9bcVoEgKZZ/VWd4q18IB50t0SPQeXnKzieS0PSSvUDqQcOTQ2RQnLxFHxtU987t+O860NwlwvegIwGTKsBfHS+GviLy9GcdDRVbzWKF6deetUZLEJvXJMCdKPHXSuyilHtBwHQ/uk3mYIz+hdiBlP6RSDPaNKjE0RKuFJGU05vklfK82d5KBG7Fg91sopRhvUtlazKPyTyYU4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rVD3XhY3cj0p55heWLt7RJMaUMYHUrqOu3maSJZle00=;
 b=fYZQrMgSIfsFHD4ol1u4pYwkDGniSXrU13En7ekhpHSbiWrORxVrr3iOlafO8HfSG7L7wpA0L2RugQ3XykhrwWEU8fNm7DEe9cfVdHZbrbhA6KN7EZPYeoCYypocZ15KNoFNYTddeoVrnrxwtjaIxd5+55ztk4CznqwzWg0h74JwD68mZ3Pulsaun7vKeyWrjWixUZEFfbycuNF2OJ27OMraAiXD5U8tYAcggmuY/tOgj8gW8Qr/AWoDVmGwGwLSz4BE+scO+qWioNMk2zrZCL25tFmjQGJ/oXB1NhiHCgg6rDGwz6wVCJju7Ra3lxKpaTTjr6v6M7rzflpprSP03Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rVD3XhY3cj0p55heWLt7RJMaUMYHUrqOu3maSJZle00=;
 b=pCvD410scJbnfShjw2OcL+niUQ3Iy4eZ0AengZDk7C6sofnAfQaOnGKQXSZn+3l/9ymWul4BFfrQ9C/RxWaWytwEG7ZAGtu4vGrfDgwVAa3j8ZF1q1Bh0dh7UpRufrnqRx/gHJGPiWe7gEbK+SdqdPVp/WRD0wlMs5YVImIZDHY=
Received: from SA0PR12CA0017.namprd12.prod.outlook.com (2603:10b6:806:6f::22)
 by PH7PR12MB8053.namprd12.prod.outlook.com (2603:10b6:510:279::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 15:45:44 +0000
Received: from SA2PEPF00003AEB.namprd02.prod.outlook.com
 (2603:10b6:806:6f:cafe::30) by SA0PR12CA0017.outlook.office365.com
 (2603:10b6:806:6f::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Tue,
 21 Jul 2026 15:45:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AEB.mail.protection.outlook.com (10.167.248.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Tue, 21 Jul 2026 15:45:41 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 21 Jul
 2026 10:45:37 -0500
From: Vishal Badole <Vishal.Badole@amd.com>
To: <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<rafael@kernel.org>, <lenb@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<peterz@infradead.org>, <tony.luck@intel.com>, <chang.seok.bae@intel.com>,
	<wei.w.wang@hotmail.com>, Vishal Badole <Vishal.Badole@amd.com>
Subject: [PATCH v2 0/3] x86/topology: Add support for Low Power cpu_type
Date: Tue, 21 Jul 2026 21:15:11 +0530
Message-ID: <20260721154514.2506972-1-Vishal.Badole@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEB:EE_|PH7PR12MB8053:EE_
X-MS-Office365-Filtering-Correlation-Id: 32d4d9f2-2ea3-4343-5341-08dee73f1e9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|36860700016|32650700020|1800799024|82310400026|11063799006|10067099003|5023799004|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	hj5KMgN3j1v9ISy2UChVpTzobSnPlQZqjt3wsavkArZWKU03asmig3ov0iEhEcPJfmncr0VjexZ6R6U64OkFABOPlKayhA2Akfhibol/ZYbC/5kYruEBhboD0J8gOwm0F3w9Hfgm4H3WSDanUommKjwqIUC3vZM/VkKHECy6XFUBb53X4iDoKHjoXDG9A9FdJKedW13bqMQT0zUMBXMYcu/1wXvpGlXaKO/Y0FfjA4fHm3iMVvVH6Dc0oe2rVUblAZl0w36hK9dcU3nUOF6Wd3jpUDXssJJaKWXCVnp5zpssIL0bKjjc/KpeF9+BNp3RZ1aUcARwrgif7rhHLHFtSaOK68BYYzosUAUeHYD6daSGqs1/o/Zigtm88bz1BwRdTf686fupIdhaeXWZyaIAfz+Impn1eKe6ehBryzq+zmdZRP1N42WpwSAI6Lv0QCGtHI0EE3OzcHcspqyHPVgo3YPwzidtDylYpWbRde4whUbIj9WyIn8ua5Fu3FeHtDLFWuvtue18KjFX3VsfbEwmuuH4sHBUYsyQQS8Ww660M3QigdKxzzRUd0YT4keUr1g7ahUnFHw6TWU4QdYTpRJbDRX1gYJQyGPPuZ5vhbDX/72h0B2Jm/ZJRVJDCkB3/J/AOT5/8VDxJF6i/ditLUrZhcuSQlvupQf0TYTC51Q1JfmfNIyOK4KycifdoWJEY2cqEuLfq42paGyghXk5GQJMYQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(36860700016)(32650700020)(1800799024)(82310400026)(11063799006)(10067099003)(5023799004)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zhmns1DIOPUtPpt84qJsHwWPZHe07ZdUr6pBqoB2KdQuLNMivvlZND2ke8YGN0mMNFKPxT9VJibbXd9ir2vLPissPO32sFr182pbOUDcLXTKn4uL4lrDCUgmbO4qAdKgodv8IkUsPmVUenwaVknR0NDLtm0rQVShvHhUQEIrCbpNS+7JjwvQKiJb3xuSIgySkiNglWR9/Rmzp6udgi6us2EUzIXdQLd3/o5cMMg6ykH2w/uzrQ9LMQIqZx4lbJtU+6J465DYcqxI7hhrhHsVH+SmD+lD46PoaLbdsvTSkkQ2t8Xg5GZu4Q0StroLMi10jHuQhr1hiKNkbsBZYhPcrxeRVHTB7/H423TRyOT+xhHwrrCKOXBi/aYAA8LAk80DRzF34JbTrZQ4nJ+KWp/p/vmGx2KrIWp0S9YqcO49V5N1OV7CFB4W2cbvQ/N9J4y5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 15:45:41.4908
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32d4d9f2-2ea3-4343-5341-08dee73f1e9a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AEB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8053

This series extends the x86 topology cpu_type classification to support
a Low Power core type, in addition to the existing Performance and
Efficiency types.

AMD heterogeneous parts report the core type via CPUID Fn0x80000026
EBX[31:28] (Extended CPU Topology, Core Type). Value 2 identifies a
low-power core. Distinguishing it from a regular efficiency core
matters for:

  - user space exposure via /sys/kernel/debug/x86/topo/cpus/*, which
    today reports cpu_type "unknown" for low-power cores

  - amd_get_boost_ratio_numerator(): on every
    X86_FEATURE_AMD_HTR_CORES-capable AMD/Hygon part, low-power cores
    must scale by amd_get_highest_perf() rather than the fixed
    CPPC_HIGHEST_PERF_PERFORMANCE ceiling, matching the existing
    efficiency-core path

During the v1 review, Sashiko flagged a pre-existing issue in how
x86_match_cpu() handles vendor CPU types. v2 therefore starts with a
preparatory patch from Borislav that switches matching to the kernel's
vendor-agnostic TOPO_CPU_TYPE_* enum; see its commit message for
details. The Low Power support is then added on top.

The series is structured as:

  1/3 Map the vendor (Intel/AMD) hardware core type to the
      vendor-agnostic enum x86_topology_cpu_type at enumeration and
      match against it. See the patch's commit message for details.

  2/3 Replace the bare 0/1 in get_topology_cpu_type() with named
      enum amd_cpu_type constants, mirroring the existing Intel side.
      No functional change.

  3/3 Add TOPO_CPU_TYPE_LOW_POWER, wire it through
      get_topology_cpu_type(), get_topology_cpu_type_name() and the
      switch in amd_get_boost_ratio_numerator() so allmodconfig builds
      cleanly under -Werror=switch.

Changes in v2:
  - New preparatory patch 1/3 from Borislav Petkov switching
    x86_match_cpu() to the vendor-agnostic TOPO_CPU_TYPE_* enum; see
    its commit message for the rationale. (Thomas Gleixner,
    Borislav Petkov)
  - No change to the Low Power translation logic itself; patches 2/3
    and 3/3 are the v1 patches rebased on top of the new 1/3.

v1: https://lore.kernel.org/all/20260629094349.533301-1-Vishal.Badole@amd.com

Borislav Petkov (AMD) (1):
  x86/topo: Map vendor CPU types to generic Linux such types

Vishal Badole (2):
  x86/topology: Name the AMD core-type values
  x86/topology: Add TOPO_CPU_TYPE_LOW_POWER

 arch/x86/include/asm/processor.h      | 19 +++++++++++++----
 arch/x86/include/asm/topology.h       |  9 ++++----
 arch/x86/kernel/acpi/cppc.c           |  7 ++++---
 arch/x86/kernel/cpu/match.c           | 30 +--------------------------
 arch/x86/kernel/cpu/topology.h        |  1 +
 arch/x86/kernel/cpu/topology_amd.c    |  6 ++++--
 arch/x86/kernel/cpu/topology_common.c | 15 ++++++++++----
 7 files changed, 40 insertions(+), 47 deletions(-)

-- 
2.34.1

