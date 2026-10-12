Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010010.outbound.protection.outlook.com [52.101.85.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFC63AC0EC;
	Mon, 12 Oct 2026 18:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791831141; cv=fail; b=kheTA1vWqp5W4wZSGo0d/nXd+oJKgYPQLswOXc0a9QdlY2WAF19kFUPTSo3D2TT2g9YJQP373EPjQL1D7Cd7ulowdlijFdBpNrNLdy56dzIvsgK+ccg8JOifdG5Lkz9glqcCzlIcBjYiTgk8pSTqZ/vc8w/+zQGbzRlIWtAy4s4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791831141; c=relaxed/simple;
	bh=6lt0KqEJeemUH80pJjaQa2RwR5/EL3WIfydZE2UDPvw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TZrrrgfVj0uXOCXLf5evTj3hM4u4pp+UTon4IP9whmr80hOpRKc5809VUHf+9gC5phrH/uvmbs0JjS5ylDEsRUBD1JXejfJTijXNwRBP1ei23ea6oLCOs660dHSCoNumJVUkmp8vasOANKHEgzTz3+ILwWWicQZV52j0XZODyNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G/A+hqsq; arc=fail smtp.client-ip=52.101.85.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G/A+hqsq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I47ckeE5spCqw7f5xtkTvyMG9pf7GREi5yYMMNy8iQYzBPbMbMHwkwbqsO0k0WVKpQSjtYH+OsuFftyqlYi68E+O6BJAe5kl+ilIwYWeJdTWsd9kDNhRfKuXxUa4PuHTRT9epOHTlCx6BokRxSFEKVzZJv22v8n+0U58Z4ovalpG5mDeIDn8ZfQxW9AVdvCoQgg79uL9o+ijv4sY6M0zpgzFhDCO6m3AQqog9ZsAWB4lHjNRDft++WC6Ou0Fj850Lo7iInAWX/HQ+FgTLOX8A/0GyIMwHbaf34A82xKRQb42ZLQqFiOCLMtwBok5o0mo9kSx0osfhrcjMvxqagiJMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6lt0KqEJeemUH80pJjaQa2RwR5/EL3WIfydZE2UDPvw=;
 b=Vnkri5PVZGG5QZo2gqNB4cDJFMqQ9FVzETCB2Je4grUb0/XeXP2rL9c2+sR4Yp9/O8qIlVHcqCSKLjghEK2IjA4UZHfW2BCJ9917Mp90im0p/F1cFeqFnpAB0CpySmsxy9Kh2TaOe6f2nGA4/aVDWL63ER4Mx835XHXTz7rautm71dM6OLQ41En8pnAcm6QpALWZLkXqtR0bNC5RqUufX8AOXcWINtvaYI6fDDyM1IxidodXJKIDNc1D6hULuVhOmpcdSGCzo1LGuv3gyR8Py3YzfPCuISurUg5/Q20X13WiqsBaI+H57yVSj2cQOWv3vdPkFct94nE5Xp1oyDXuWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6lt0KqEJeemUH80pJjaQa2RwR5/EL3WIfydZE2UDPvw=;
 b=G/A+hqsqz9gPsUeONLN6reEr4cH/Btxjg2FDEf5zubcsb4phT08pJEyBN5cLnRe5SNGFYJNCEKqzYAwR6V6gM6QnJkBjpYvbGRM5YZ1G8W2eJH5qtXJkJtAVM/IrHkeuGS6pCXc3iMCQ56R2pnQ0X82NTH7P6tJKaBooMtFrE5N9wV8c4HbLHECIVo9JRM7dG1sdgAfnfWn6gLahscNgUSq4vuUvnL+B2rXoh5FGGKW16gCQ+tFLUQIL09YwF26Xp4mbPkKhe9Fxr3d89Ngkcu26OeTOxaqPUj3sEuXlL4OFG6fuoEhQkb6LS/y+Jx4BsTZywuPlU9hGk8kLJht53Q==
Received: from SJ0PR03CA0061.namprd03.prod.outlook.com (2603:10b6:a03:331::6)
 by LV2PR12MB5991.namprd12.prod.outlook.com (2603:10b6:408:14f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Mon, 12 Oct
 2026 18:52:14 +0000
Received: from CO1PEPF00012E80.namprd03.prod.outlook.com
 (2603:10b6:a03:331:cafe::a) by SJ0PR03CA0061.outlook.office365.com
 (2603:10b6:a03:331::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Mon, 12
 Oct 2026 18:52:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.233) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF00012E80.mail.protection.outlook.com (10.167.249.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 12 Oct 2026 18:52:13 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 12 Oct
 2026 11:51:49 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 11:51:48 -0700
Received: from dgx-1v-42.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Mon, 12 Oct 2026 11:51:48 -0700
From: Jamie Nguyen <jamien@nvidia.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Len Brown <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ACPI: sysfs: Expose BDAT data region
Date: Mon, 12 Oct 2026 11:51:48 -0700
Message-ID: <20261012185148.3192127-1-jamien@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAJZ5v0ghc7Ks=nMNwtvm9727NbUQb0XDEu4GrXiEcaDELgRk+A@mail.gmail.com>
References: <20261009232955.866131-1-jamien@nvidia.com> <CAJZ5v0ghc7Ks=nMNwtvm9727NbUQb0XDEu4GrXiEcaDELgRk+A@mail.gmail.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E80:EE_|LV2PR12MB5991:EE_
X-MS-Office365-Filtering-Correlation-Id: f03d4ce8-0b45-4278-04bb-08df2891edf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|36860700016|1800799024|376014|10067099003|18002099003|22082099003|13003099007|11063799006|261009223027099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	V6S6vmpJ1iiejGwU9+0oxNHRGqzlxNqAhi0tRCdKURxt9gTdPujrDDLWbwMPEj/BREbiTALe22P/vwiMD2ca+jDk153mh+FlG0E5gunba45lydjBDDQMDhMi10tEmX13i9fIqTPgrqTnm8OBf+iR0FOABJqfUqL9Jrvx4EWfgM0zepqI39ACbzqJ++udZszEWfY9AMrTCpEuxBNxEVHUKcpaIh6nNcva8UrMGLRiChloqzQhlUYoG6Hy6YjY6uqe10c4VafQUs1kYsbzSLAsIQcLmnH8nJDrLP05VBhe3x/9gr7brQYYIswPcgUPJ/wGqLrvpPuK4oLRS+oAyK6OvTv91VBYeQGkDp/8zV4HlEeWeH88aqTyl/MNSBgJdQv+sKk2mhYEBr8v3nsPdJ/XzxtTDkg3M5SVG0sV3+A9opG9Y+g2Af2ePne7ZvtLmWiy0ev7BgvIjpSU2PNlSrzEppLphBV1Kd3V+fgbpPk9MFSCLflKsWEqORrkTMmxCBkKVLUzfzFfnuCcFVk7BNK5MFKadUA+5eR1hFwAn6XFx0ifnEZ0ZSakmt5Drc14FLHXY7vGc0pzHHGGDzD8iLEhoTq38nYesFz35iHePhOAwa+XoLB/JiN17SAd3Csp2iPQF8E9cHvcA97atAxYkbbDlfiBjwEx77IXX/5p8el/I00PFnsqx3PrAhkJgr5ogc8IGc2fmz5XnRb6+O28MNX6Sw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(36860700016)(1800799024)(376014)(10067099003)(18002099003)(22082099003)(13003099007)(11063799006)(261009223027099003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CUOZw0Me5w4y4nVLEJVl3YjlAdznonuXwG+sOUCKj5bXATHjd5GGlMBG50N0hMQMTn4qUoocj4+8yRN1wlrbVA8kuRSVjjPB2Lh+agsGorOJ/iVba/kBuqbSk2sfTGq5ZJ4vmutmkC7v0R0iWERdQnJG+td97YS/KCUgyFsV18h4QQusurGfze3+shz8L+pVOYrmtHZXE+bjMZjTJCkH+1Gnbs35R3hnxK8Jb8TDEb4JoBJIueP6Oxc4HhKq5kEjKS3JJVXPtCyz460of0aeg71xhtnD2MUDWBN0joTW3pK+35x0bTuzkuAayne0NU4S0sZU5MDHHnPsrZp2Q+zeSbet195w37FJrwj0qi29y30H3r9aFcEbRALIVXVNnSn3FzZPuy9orvn8s/f4MlAHRN062npGh+7Gt5FRou5vPN6u51X4ea0XSKThzvbmAVfH
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 18:52:13.6422
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f03d4ce8-0b45-4278-04bb-08df2891edf5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E80.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5991

On Mon, Oct 12, 2026 at 11:15 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> Please see the Sashiko feedback on this patch:
>
> https://sashiko.dev/#/patchset/20261009232955.866131-1-jamien%40nvidia.com
>
> and let me know what you think about it.

I agree with the Sashiko findings, and it looks like BERT and CCEL have
the same problem, going back to commit 7dae6326ed76 ("ACPI / sysfs:
Extend ACPI sysfs to provide access to boot error region").

I'll send a v2 with a preparatory patch that moves sysfs_create_bin_file()
and the kfree() on failure into acpi_table_data_init(), so it is fixed for
all three tables, with the BDAT patch on top.

The other concern in the report, the direct returns in the
acpi_tables_sysfs_init() loop, was there before this patch, so I'd rather
handle it separately if that's okay.

Jamie
