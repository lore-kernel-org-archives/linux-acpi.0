Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012053.outbound.protection.outlook.com [40.93.195.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F5C31F99C;
	Tue, 21 Jul 2026 15:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784648764; cv=fail; b=K/8g/TOyOJS+3u5uX1MYvMaqddfET/EziHSvrfiOMRyvFlUJfj8pait3hnLDIMl6+NtOZuhaArc0/d6exjqLWAiGVLhNk5B8wvonkWliEscPs6vazYFi3XOYR/8HV+BRZd4BB3MYbCjhV2LFLBZwyndjio++5b5C3NGBx9zH1j4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784648764; c=relaxed/simple;
	bh=pRX95jPAXtzqjd55QEM7pl9oAL7+eHMPZ076dODemOo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KcbAFBnSOwprqDO6Z2wa9OGvX4EYfHo8CGPrOrho4mIQAdt9o+4DnUiHLSnv4TEOppRRCkIpemI4OkA1h02n7PvWKk25aQyXmQxog7m+elOPwDY7lWXW3EDFnXQ725DfrAbRrenuigUC3ZIUTO7sjNeUmpPgRmy7jQKh6P18eXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ioGgyOdJ; arc=fail smtp.client-ip=40.93.195.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ioGgyOdJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=myvc+qrGJ/c00Ztg+/Hi2uKk9P/73lfFfGdh/WxI3KcBVJ8XOv+ICjwGJPuG/SpAmcwcjRBZeFsG0+CiUZXJuS0+XBLiCk3471/isSahr6vcJD87wWlc+jMFes/YmzQPExOf8APGZJN0rS/3tN8tSfy3rBa5LygRZ7YploF4oVj0DjppRP7pVKZWrNVsM0kxxduLvmlaMYw2RiXJYUxqI3s4cIyQCwnsKQkQdD8vV0gMCs6Tfv3ZEvt4QgC43goO6wVYJZLgEa2FPqCHe2o9pIM3H2OQfYJLNloeGB6lv/gA0enupOzcWRv5/hLQxMwCcXyUGKcM4oY2hLtOYzq0ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iIPQbX+Ki0YmUoxL0n/peqkCwBEP4tPvgF/+NCd/pnU=;
 b=iM+wyZTILroGI/eQRTVSUfeDOQCQ8O6EFI7Hs6BhKZ98NX1AGddCpmX9pb8ugTPk77OmhiDt//bzd5U7txKLufFQjHAbTh4+xfEBayTuvz/Zj2rSxebS0aUmXeJ9kq2CJtLsswDYk0RxOnQz8X4zUW2FnpJooPHHJlh/jyaRNp65PMImR3MbtX7eEw44eRdDVi9gwOH+B8W0e1+ZG0BOvd7mRdu1USxCdIOkqouWWPclr4i9l6vtpem3n+DzCom2tpXUJBKoXtb4b4GlIEraXD4jL1hf1nrlg+4QypdKnKKf62OlE82ssxIMdKH05kY5XcV1UIZu+y1Ubdm8w+GHNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iIPQbX+Ki0YmUoxL0n/peqkCwBEP4tPvgF/+NCd/pnU=;
 b=ioGgyOdJhPW0wvG24IVuuXGt+XaC2zCMW9g3VGw4A9TNGVL+/sbcNYqWB939sOsUA+6TcoZhTp+7N6o+OGBG8lk3GyvST1nS+Djcrx2ckJSiMaHqSY16hCZLUK81JUJvQM0U0QzxwWk9BSpOYqX30rygj35XF9Vn023hBGhrw7E=
Received: from SA0PR11CA0067.namprd11.prod.outlook.com (2603:10b6:806:d2::12)
 by PH0PR12MB7472.namprd12.prod.outlook.com (2603:10b6:510:1e9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 15:45:50 +0000
Received: from SA2PEPF00003AE5.namprd02.prod.outlook.com
 (2603:10b6:806:d2:cafe::68) by SA0PR11CA0067.outlook.office365.com
 (2603:10b6:806:d2::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Tue,
 21 Jul 2026 15:45:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE5.mail.protection.outlook.com (10.167.248.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Tue, 21 Jul 2026 15:45:49 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 21 Jul
 2026 10:45:45 -0500
From: Vishal Badole <Vishal.Badole@amd.com>
To: <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<rafael@kernel.org>, <lenb@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<peterz@infradead.org>, <tony.luck@intel.com>, <chang.seok.bae@intel.com>,
	<wei.w.wang@hotmail.com>, Vishal Badole <Vishal.Badole@amd.com>
Subject: [PATCH v2 2/3] x86/topology: Name the AMD core-type values
Date: Tue, 21 Jul 2026 21:15:13 +0530
Message-ID: <20260721154514.2506972-3-Vishal.Badole@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE5:EE_|PH0PR12MB7472:EE_
X-MS-Office365-Filtering-Correlation-Id: e972d1d3-9caa-4020-75c1-08dee73f2382
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|32650700020|82310400026|36860700016|376014|7416014|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	iKNg/Xe8B6OCqWtlru5cEaJSjoruvTqVmU8a9K3Z/ZwfNi9u+JLXiDy6oeiUwiMaY07ImdMITC++aK2YwR3Arb/NhUOR4e+Jhqlo+ts1Aa3pTISCRZ6IxP+bx0C1pnAs9rNMeeiEjQ/H/Kx55/NxRnSKTHhU3Vnkco7gXvMtT2yJAIke0AE+uJU8geke+CwSL49d8T1B/TpNi6CP3GfLgRY/ZJRiY8umdDbRT7ZoTW69cz8yqfbadg9oGzVTRVc+/Uf1klwemyT1kNrV0im74FF77kHIJFaBKQkGlvIQ0Bs+16iCSeHY/dYsJhSxhcgB0n7MsKBra+v17Mvl5fYdmjgWKxMGpazSnJr42+AO+mArL9ROGJcTzg+VrVBcJ1g8CYXAP94hcoD0MDFFZDIbVX61vgymZ/pAXE6XCL6w1NFAc0RJpcR2zTFjce/4UybnzFZod4pJJVsaHEG7csiz0CGK/k3PW3SNMbCmB085/rr4+s6dFDOpWF585RrrhT/fgMFdFAIxynW0wthRqa1CpSVisLt6YepJijWIefY24I0OCnpLxLTPYDbwnCoMxsG/VHsa9HBRSm4NClhi64dI9nuC0/xa6kcJTMaJiMGl2YbDLGCUbBHKUTPEG5n7y/qmaQTK82fNVAi1360MBfSkquO89fAVBcmiIq/l1EL7+Rupla1t/IvlwfbUcWEC75PcmN3c5J0ZXry45Pl3zrgSgQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(32650700020)(82310400026)(36860700016)(376014)(7416014)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BrwW/r9fElYtKtQoedF8Yyr6KNNWMH8qwExEWo079T7TkqCKgPIGHmuWNZXg3IjYA3CI0URIksg+J7WAIQIBrmFRekLWeOCrO/uqaOJKCrvuMcaEV2D9PjgT8LDOwxnJxjQmFGkdJfupxaBci2czB7AScIFGF3aLJ5gldC7AiaHyHCji2welQO46JabNPatoixN3cMjXWe4UHjvX6wkf+F8R6OH9jQB4SpU5cVqELWjf6iRGuKgTJ/xH80z7wyopzDzP2K9tsDxuRMr6Fr3GWDNFZJrmsqKfT4xjz4TQlfBl6nU70ZOab2QD4FgMGMxZW58w4/gBuO8+F9EY1gB42yKKWJzL19O1yFByTZKuUpxmDHk5ZHJRbQfOKCAfQ3UtGkH+SICsO6Y/Ch3QXcFnj3TbKLqLoJRyKCODSBhiz+p7Da7g0UiG9hCreD72CcWR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 15:45:49.7262
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e972d1d3-9caa-4020-75c1-08dee73f2382
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7472

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
index ef76ba674f1b..1825691af941 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -114,6 +114,12 @@ enum x86_topology_domains {
 	TOPO_MAX_DOMAIN,
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
index b9d025f3373a..71b6c33afe0b 100644
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

