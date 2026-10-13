Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013042.outbound.protection.outlook.com [40.93.201.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED9F41837D;
	Tue, 13 Oct 2026 02:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791857602; cv=fail; b=ZRlMyEJuI6IznNdmqqAUhFgCqYVj1DP24Rl0V4GfqX02oLT3E9fxp64IuHEvhrV+GXkgTG2saMzr/SqReGvl7Pd4KrI/278sRhzQmcVGebg2LZPm32ZE6bGXek/lPTUxb7SZfJldTSf8zfC0HhzSJLsg+QPLiRUoDlb7PSKGeSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791857602; c=relaxed/simple;
	bh=NsOTIaVH2E/UL3w/gzEbFavc8FzLr9WD9Vggj5EjDLo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S8NZ1M+MxGT865yhEwkz4jfwPC5ADq3KjBIK4X/kln5VLDS1JMGpmvYq/d0vZOK7wKJV2geqMnf/EZp8HeK0dDDzfBaeoOfrPNFiyy0nB7mEL4xgejI/U9l/WHGPyJGA7pY/3EWQxTPnltt8ug09sgZGXe3VwHwfSEA7bXD1ZwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=phsrUAKC; arc=fail smtp.client-ip=40.93.201.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="phsrUAKC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DGIKKXoDYJfjkX8FWYWnmlt1MZBlvaqipdruUR2eBuStkM2wh3OAaMZ/vyxaXw7Te6YAXuMR0vvVspv3sKHppfBMIBksDuYUcJyVxIL1vzbT8sNw4uSLdAngCpaKkFs27gGuaYgkKjmNLeghJn8ILA/Y2R8yx8Hz/N1Vx3VUT6E3l5MCY2sdZToE0r9Seix81QxDbF0TEEsXIgaZh7cpDTUKzaRQwz/Vxjzx8IsGuOP3tMwBPIQS+uTpKmnI5X34JrZ2DI13OtBK5oVQTZt170vsSOvw94QM2/BlQdhD4Y2HWC5KQlZf5uahzHzT4z7U2Y0BIgSBttVf7bPICMzTwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ycr8LQOwVLBbCyxhFCf/DBQM+8v93TFshr57xLd5HnE=;
 b=nWMcL7unPM6K1fMBLov8GQpxlvur+bSRQZpBUWniN3HVqkF7wtNgLcjvXaTYqteqlhUlzE7O8UWGMyLwggk8DW23Nj+H09Xi+Re97w72NUkHoMwf7+koCrY75RWqtZ/cu9CTWGVr77Pkl1a0ICB3duQsjxzTExzAbSOaqkronYjxSVcATwhlPCFd4FjBUNIepqU2tqsoHCghLZezn4aJE5KOA3aikbBMKC8L8QVLBhpHNNbS2EoSI9X+ReLr37h5iU/9hIfuYlN3v71kyPxN+ZNYu+VIVNNV0yMJJGjhhelW0I12Vaw1dbOt8X7NR1d1gWEr1i0T2sIhQWYpwwajjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ycr8LQOwVLBbCyxhFCf/DBQM+8v93TFshr57xLd5HnE=;
 b=phsrUAKCN519UWqSIqL1DaiBXMivDiXMMGTh1YvBbYVV9l1TMyYeGV2rHoFt9xvX2odHc5c5rBTfc6mnoJfToAyWF5GFGR/w1LofPwaaVK5kZLmmwzo5x4AlH3tePugnmHhrU8Gm5WMZSZjXYhkNU+EtivuXr3Q5VIjAuRCXOefPmkJnYwI6N02b+0blNLNhcmt/JGv5lHIH5sKc8BWaxt4Rk1IKN9o7Rp58UYA3WyN8dkUbz87iO19YcGzi5xJZXkh4t9ccwyC3kfGtppQgdZoGraiWDqbiWKpJGKBCItgq5HO6+ayyT/FnCe4cFUgFzuJtRxo4mVdbSGwH4EkOuQ==
Received: from BN9PR03CA0263.namprd03.prod.outlook.com (2603:10b6:408:ff::28)
 by MW4PR12MB6875.namprd12.prod.outlook.com (2603:10b6:303:209::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 02:13:16 +0000
Received: from BN3PEPF00022BBE.namprd04.prod.outlook.com
 (2603:10b6:408:ff:cafe::7c) by BN9PR03CA0263.outlook.office365.com
 (2603:10b6:408:ff::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Tue,
 13 Oct 2026 02:13:16 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF00022BBE.mail.protection.outlook.com (10.167.248.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 02:13:16 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 12 Oct
 2026 19:12:58 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 12 Oct
 2026 19:12:58 -0700
Received: from dgx-1v-42.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Mon, 12 Oct 2026 19:12:58 -0700
From: Jamie Nguyen <jamien@nvidia.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, "Punit
 Agrawal" <punitagrawal@gmail.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] ACPI: sysfs: Expose BDAT data region
Date: Mon, 12 Oct 2026 19:12:58 -0700
Message-ID: <20261013021258.3843871-1-jamien@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012230632.3574987-3-jamien@nvidia.com>
References: <20261012230632.3574987-1-jamien@nvidia.com> <20261012230632.3574987-3-jamien@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BBE:EE_|MW4PR12MB6875:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fa52a98-a841-43e9-7651-08df28cf8ae2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|36860700016|376014|82310400026|56012099006|11063799006|4143699003|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	2fcpwK+OBeslMRFI2xc2z38vngXu8tcqkSVo0MSGGGpZRQa9bsk2TJL+UgcAch11RleJp/3NBE1X6m600j/NQedP8r2xhlmbAwSGxG08iWcqtTX33uoSE3B8Ka2j3U42Q4qBimwBcQwncZZhks7hNaWcqzY8QahAC2DQGt5JrTvlXWqeTH+q881CR80Na57j03p2ya9v7zed8rbsiecCw2vTCnhrU4eDIb3y5ihECvHpJhOoCSmnjU9YVEDWK1XxntBV9iU/whbiPInR1q1SKkSAl7aSb8V5am90zd9HzC3+1Pgui0Ev0js/JTbBal/LjkZ8KC4Y/EPcSFRYdO/RTW0Lu80h5baf1zuqCiL6PfgsoLrr8Bol845UaQsGedoBHePoFKKWYM+Tiz1JHmvxdvYW656GB+3nJ+LuPK88h9CJRNSapDRkpBn1kqPQntwR7XHxQcYpGca96pI9w5HQstzxzaazpQvgmCZ8fMqhA44FcruXJ7eKc4B9niZ93xhqTdytNZ1w+QlSIqnI2ObLwgMpkgA8uTsEK6q69edbM7EXf3vbi0CHvp/2mY1LoAZJd1RLfEuOo8rzZpQbY1R4yHR4gDnEd05abdgbLM92nPlZXpbxVzCXFqhBnTs8GKE1XkMzdhp27mjwi959tMhm1GcDnGBb5Vw8F0dFzor6Rcum11SWCZqeA6nASTctDp3r3JlCcAik80VIMT6KvyYMjA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(36860700016)(376014)(82310400026)(56012099006)(11063799006)(4143699003)(261009223027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	j1UkmmcOgjp6XMByFsECdzYfcQkjbj2MLdLUbKpU6eMegcOJqz69LVkAZ17b99J256k3jHdcXUHm15FtHg13THgGg8OdpwQBHj9YwsEJdskceommbJ286HkoL3qR6mXSRyTCDuILX34c/CnE6ZSFAV/jOCt/kGCmBh6RrMlbg4R4Yprp2hi1sQ0nNkADr7R8BQ1zZCPDlV4fswqw/fTigZyXqaTe4LH/jCIcykjfV1tnOFUf7mTzZg0SmndyF3t5InTW19oRKuVi4WAWq9cKPF+rNWA9EqS9shq5pCetGtwih0u6xUhZvChmqp9tjftJ70wTmKhJ9DSsy4oYBh8dXeNtKPCt8S1PirYEtCpn0xWa2cbMECsLaTsq0qVUc6K0CGn9pW4eqKujozszIaFzmVi7qqWY/+kXMrSIviMYXxpHsG/VmcB/qsNsG+p4HvFt
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 02:13:16.1498
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fa52a98-a841-43e9-7651-08df28cf8ae2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BBE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6875

The Sashiko review of this patch [1] notes that acpi_data_show() maps
the whole data region on every read(), and that the unmaps are deferred
by RCU, so repeated reads could pile up mappings and exhaust vmalloc
space.

That code isn't changed by this series. acpi_data_show() has mapped the
whole region on every read since BERT support was added in 7dae6326ed76
("ACPI / sysfs: Extend ACPI sysfs to provide access to boot error
region"), and BERT and CCEL use the same path.

I measured it with v2 on an arm64 server, with 4K and 64K pages and the
90754-byte BDAT region:

- Looping full-file reads, with 1 to 64 readers, kept at most about 4500
  deferred mappings (426 MiB) in flight. The count stayed flat and went
  back to baseline within 2 s of stopping.
- The worst case, tight loops of 1-byte reads, peaked at about 34k
  mappings and 4.6 GiB of address space, and also drained within 2 s.

At those rates, exhausting the 126 TiB of vmalloc space would need the
deferred unmaps to stop completing for more than half an hour.

If it's worth tightening anyway, acpi_data_show() could map only the
range being read, which caps each mapping at two pages for all three
tables. I can send that as a separate patch.

[1] https://sashiko.dev/#/patchset/20261012230632.3574987-1-jamien%40nvidia.com

Jamie
