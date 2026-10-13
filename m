Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012008.outbound.protection.outlook.com [40.107.200.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0CE51AEFB;
	Tue, 13 Oct 2026 18:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791915142; cv=fail; b=OfeotjsCutLOYfwYaJI0evfEtcC8Coxe+Stog1TYCgxthohBLhFoVxfpK317iLkUSDCnD9s8OMjTEwT0s8AlPtVR8znaplDCGZdHJuUiSormKfrFbpmu8NkCiBa4HsJe1WBWF8WsqKx1+1j8IPwrZ40GkT90OOa1HqO3faOFIBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791915142; c=relaxed/simple;
	bh=CVLil9F2Ix9LsWeOzFnNd7/vuDTNKEGRHASKqjhmiJ4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jbF8+ow5fxKfJN5TMg4/ZF7pYn+0F0KTCnDrdoxtj8GpguuWey7fHdk0CH1q4Cj/HupdBmS/e3W0ZFE01SoPW5zVXUWPXf8PeCwF82jqvL2i/yA6yr61L4VeFMUUOJ+n57acwU1BMdX/BHxBCfjw8Us6C3LeQnrGcrHB9xv+Yx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V6ONttrR; arc=fail smtp.client-ip=40.107.200.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V6ONttrR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qkxY6amCywleWSMNKU/SPFSzO3d0GwnjIHDGOURe5xlZDg7OnThuPUgieapRuOBxxN5CBrWehhfsUD9FrbAq8rnnXgYmCVVEyu87m8O6KT3mKR3uizHaJ31EsLDrkkgc1CZRJ9QDPNUX5TAZjZPWohh5Wqa4npy6NtJgmEuXbsGF92+cHHuiaBXSf49fnDbqfp8DxCUq/+hcmcbt6YmqyWoGd0F/dbay9fZx7eYE0G6C39iRXd7z/6Dlgj5/5288rGJ20MayDksIA/oRPpnUV/Fm7brbaodOCGUiOc4knFE2ca2S/E+UhrO9xtfaJbX5lt2HNmm4pE+v1YdDTYekZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CVLil9F2Ix9LsWeOzFnNd7/vuDTNKEGRHASKqjhmiJ4=;
 b=PBPIJBgGmDt3hkEYdeAD0Wc2JaCFQgaNtkISabbybmDBGayfBpW8N5lDF0WYJ8w8MITolfQ11gNYe46FarnQFuMnYMQXI15VaVxNyoQbDDYu06mJs6FbCF1a9IXifwNycyxACXPBaYAeVaLeyg9opFtmxTsH/wsdK5mK6xZ1sCdfrObIREZUt1elsahx+x6Deh6Qz3QkaUBBojKBvygdN1CvEKlTmBjQZs2lLW5A+O6qVH5Et5h/rge7DPpwoF7KA7e0z2Oz77SW8f1cKiq/CzXgsig9dcz1MaWPeqBywLY8rLj9lU7oyv1W8eq4GrycttfS+E3udJfHFtxqSRd7nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CVLil9F2Ix9LsWeOzFnNd7/vuDTNKEGRHASKqjhmiJ4=;
 b=V6ONttrR6fkcWfYyXF0vPGWgZFvh5LQFvmsxBIlDWCMYYTRumq9mog+QA8ZPMkS6Amk4k7v6RV0b+JzL/giuT58naS8lxg1tdUHyvLNLKYBNmtGuXdxUcf184/2Rma2zLuYMDF1qqM7iGkaPjO5lN6Xdh+HGx+EvPVnosb+YtEGznV9KkTBAGyHPYLR7pmoXUkwhiZvQEI6ZIA7Gt0JLJPsGvXDCXkpzTse72wvWZPnjwNdSEvCted72yBDr+h77S4WB4RxsbD3779Sd6OlWmgEq+qCLulBTjc/SDVQNCbdbjshuR6AjraGqZHVkR5SLP3yhjbnylvB4LCSePJH/pg==
Received: from MW4PR04CA0312.namprd04.prod.outlook.com (2603:10b6:303:82::17)
 by MW4PR12MB6683.namprd12.prod.outlook.com (2603:10b6:303:1e2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 18:12:15 +0000
Received: from CO1PEPF0001885F.namprd02.prod.outlook.com
 (2603:10b6:303:82:cafe::5c) by MW4PR04CA0312.outlook.office365.com
 (2603:10b6:303:82::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 13
 Oct 2026 18:12:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF0001885F.mail.protection.outlook.com (10.167.249.248) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 18:12:15 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 13 Oct
 2026 11:11:47 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 13 Oct
 2026 11:11:46 -0700
Received: from dgx-1v-42.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Tue, 13 Oct 2026 11:11:46 -0700
From: Jamie Nguyen <jamien@nvidia.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, "Punit
 Agrawal" <punitagrawal@gmail.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] ACPI: sysfs: Expose BDAT data region
Date: Tue, 13 Oct 2026 11:11:46 -0700
Message-ID: <20261013181146.978514-1-jamien@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAJZ5v0ixQ_5jmrfm4mz50tZtCEq6nJt1b2eMoBdhr0f3AY+k7w@mail.gmail.com>
References: <20261012230632.3574987-1-jamien@nvidia.com> <20261012230632.3574987-3-jamien@nvidia.com> <20261013021258.3843871-1-jamien@nvidia.com> <CAJZ5v0ixQ_5jmrfm4mz50tZtCEq6nJt1b2eMoBdhr0f3AY+k7w@mail.gmail.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF0001885F:EE_|MW4PR12MB6683:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bfde012-4008-4c75-560d-08df295582f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|23010399003|11063799006|4143699003|56012099006|18002099003|22082099003|10067099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	OKV6E+brY3ZrsEefNGGjkWqZLlAcG9vdjjL4AFWUqsbrn8zAC8Of9XauLZqLbUQDijEfQJDpsWADKMV2httCUCMt+6pyHboeay6KBPDAwn6f97H/pjIobKCxyT229n2yoUAYumhCVRkCF3V4rFplEd9KNsHGiJZrg9wfWeZdcBk8utVBvVFYungz0poEDQ/gAGso4Z8BEINz+zowigmEh+uCXPBi1fXIHpvzQ7z3l0ao0XQlvGXhUnRgqYcAShHr4SBuZZRaOst4AJ3+/LvFMsTAkK3p1EvYullIRsnahjzvVQtVbdHyg3kJGi2nkLJZxrFjlWJ1Mx4KnYaWqf3uremCCGMs0tWjMHQEjvQSGzc7Ybew3sPXIeet0+slZKQ5/Vahhx75Xignppr9ONkuu+KEo8gIn/e5FTqJikqVPOqQTJbpXya1bfzGULBjdkyEVMbivwIYCe89FYF9xj5Uu2Bb2eByv5XJwpNXlE6Hqe6Y2Z9v/B9Cq/3Qf/Foeqh/upZwEPzUR+nzeVV9XeK7dVnTfEuNH5ge4bAlnIg/4EG1R0jlSFWLONVUkY0nkpQNnh4kcR4TJkFL/P+jiYYd47vVByjH20RF/MFMsxTSq/IBzp1nBJRPsyadcG+CmuhX8G/hRHqmdunF+Ck2joh89vqAYwKImgnkrmR/OZ5TXQGLZaSCxzhFzcKghxYOhY6fyh8VyIdnzjOM+YaXVECo7g==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(23010399003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003)(10067099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	j3t6wO985+bMPdLByyrGlWhIazHp4Z+479O3KUlFhNCuZytbmoD9QOkeT1sG+cBJc3mt3SGKPmJTg/3B3jS0LjyHRtckdjFJkFwgis7rMuxloP4bRRaoFSoyRhwf6DXBE3udWX1F+qM41D6BpMjYvqNYNu4kGnQDPlEab715l9Rxj+KOdXsmhXMu75cQ40eergbo8Q79laOLGYVAuXoKgVLsM7PNZ/Id1W7+4xahURp25W4G2ltJa+F6/ULrEVcu9wv8kTE72XFMTZkGLrjZDEBUnsl1m6/iRkXzT5ZSgQHUVPiIV47nw9rSNd1WKcQc9SWSBsA9k9MX2F+eHgbuTGg4vL9R63LplFAiwDS97/j7TvLKQ2Qh/p+l1RC6P8+S9tQLw2GdB/5AR114WrjLar+Fx3ohuZrOvgvAjK28Ux26YREfG65+AYpKi368zLNE
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 18:12:15.4192
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bfde012-4008-4c75-560d-08df295582f0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF0001885F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6683

On Tue, Oct 13, 2026 at 3:53 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > If it's worth tightening anyway, acpi_data_show() could map only the
> > range being read, which caps each mapping at two pages for all three
> > tables. I can send that as a separate patch.
>
> Yes, please!

Posted here:
https://lore.kernel.org/r/20261013180728.957618-1-jamien@nvidia.com

Jamie
