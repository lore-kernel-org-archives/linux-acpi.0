Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.26
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793811720;
	b=wB/OMVyWXUQl13lNqAuxkM2AnFTwZs2RbFp1IeRmY8lZAmxX1kkhrgeNAktmyk6k4lrL
	 xcszQ6ojrexa1yepZimmbVuQm9YIL5mA+Xeg4/09beb8rsfFzJdxwubC5V85NikshxU0+
	 JAYblBMrSHBV8FxgeqvdSpVpHkl55cy670+j92JKJ8xI7iWHSu2laG7ihdTZvOdXkhgw7
	 UdT69Z3DXiCesfIxed2kaKrYIqCbh9zLWDYvB/FsP6fvM8yknSoziKwrJ40EJ3VZXI9AA
	 vglKUuPotveQhDELZnHE9mF3DsgnhjZ50HoNc7dTpv3lI7TBEr01nqutw754g/2WE/Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793811720;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-NV-OnPremToCloud:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=dO5PvkddWLpNvKFbk+m8+55MaM+688ftRTh1BZ+IQiY=;
	b=nDd4Qlq41H5SKd8v/UaEvitG4kmSkAPN/38YM0uBI6DfvtDzacsCO7Y8fpr/Wc28i9np
	 b67slnkKjkrgCcfZx2M0bt3Y35jcOtl7v4Lw3m7L5nIZoQNQ/ThblPRd+afG+9LhBiQCE
	 j15h3KLJWPes/fp8D/p7l/8oMEYNv8f++q8Kbhj4Q29LK3H14cPLhBuXxI4jjnCQkUWMG
	 8DucaVZx3zW7eZnwG+HtxI/Y+G/VGBqlhgnW2aOwqg246JMisc9zw8T37RJsDI7AzzSk7
	 Z71qfsLzEu5Zz/6EqLHX0906awcO/gxUmU2ND9NzC+es91gKb8DKY+/X47wnMNkCisg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=PIvlG9eA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.26
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011026.outbound.protection.outlook.com [52.101.52.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5450606A31B
	for <linux-acpi@vger.kernel.org>; Wed,  4 Nov 2026 17:01:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5450606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=PIvlG9eA
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gz8ML518XXiIFRI4u9tdB2WTveUbyxNp45XcXyBN+pEhRVEJ+wvJ2SbJ8f+Ksujpa77rMi7GIvBGYFHQMO0TIfF5wctM1UZwa7kNdiBLsQgeWc2Dnb3m4sT6ojnQdpHwyFcp2pBdsnj8TFnZGO/AYVdkGUC/FaHvEZapHbW0A+j6IIBgMy4GXytM8nBDYYawhmmWVcUZdradrsnC00cYnjo0zWd88ik2k4QyuTF8wLs8vciqe/pCzRoG98txjaygKpikoIPLmFeDo21Pq6fmGzByNX2VgTan3Y7/mBxR6MbOR1hfaP69g/2kspID2XVHt0HaOUeItZBAjGMWXW/61w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dO5PvkddWLpNvKFbk+m8+55MaM+688ftRTh1BZ+IQiY=;
 b=HJxa+N8n4KGB94Ir9RjtGXPccgtOA3r1IWK5I76BvjyNjHAHt5QyjbshDIz5cWJPCRMeTy2ptemWa7kl51BWGqcxlyv3BO+OlISO+kQ2vp0hbpKK8+KwhA+ulXX8NDcD4L9hgCyuRvaZHfSLLGFHZpm/qDtO7ImM3eSY+UKuc/Q2Xgla3gnTndiCh++im8/qZyrh87zNiKMGOMRv3tWb33iSI9p2ddLmvlSh4jyC7f2YeQjRqHPF2P5lUi24wEKdaafok8MMZ3sFIgjnyiSlltTDJ6jyxhJYbkYQPhdZ7TWvtHnUMyl+HVwxIdKmCxAz1dsWoWb1WwJgobw5XE0qcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dO5PvkddWLpNvKFbk+m8+55MaM+688ftRTh1BZ+IQiY=;
 b=PIvlG9eA6ZOtu55Lg5bUd96WrDZXXeZUhgt5QC9oK7VOnSwSC6Xi31D0fKEOw/NB9HhEXshooSRBSDNtyEsxNzlL7AavjnKFFmSUkFiwxtOLQvh7uk7+njbXDYUgVnDhg2UAA1QMNOPO518Lxup2/xNDfH2xj58av+w82tzyOEVpMBzct0oOb6o5EmcXyHy0ZSqbrCdgYHCnAZiaXGzhHTDEVbZujCWeqcQrMLlFquPbMjQshOeVuvLVi4GCFPATB23xjAvsf1YCPZ9SCr0UbnREFoydFDxg5+Y2eD0fZ/mr8cfsea7rISjXe9h3nkUV5vB1i0VD1QsOY4+d2Phh8w==
Received: from DS1PR03CA0016.namprd03.prod.outlook.com (2603:10b6:8:233::6) by
 DS4PR12MB9660.namprd12.prod.outlook.com (2603:10b6:8:281::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.9; Wed, 4 Nov 2026 17:01:53 +0000
Received: from DM3PEPF000265B9.namprd04.prod.outlook.com
 (2603:10b6:8:233:cafe::58) by DS1PR03CA0016.outlook.office365.com
 (2603:10b6:8:233::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Wed, 4
 Nov 2026 17:01:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.233) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM3PEPF000265B9.mail.protection.outlook.com (10.167.23.246) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 17:01:52 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 4 Nov
 2026 09:01:29 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 09:01:29 -0800
Received: from dgx-1v-42.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56 via Frontend
 Transport; Wed, 4 Nov 2026 09:01:29 -0800
From: Jamie Nguyen <jamien@nvidia.com>
To: Sudeep Holla <sudeep.holla@kernel.org>
CC: Jamie Nguyen <jamien@nvidia.com>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, Hanjun Guo <guohanjun@huawei.com>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Dat Mach
	<dmach@nvidia.com>
Subject: Re: [PATCH 2/2] ACPI: FFH: Support FF-A direct request 2 calls
Date: Wed, 4 Nov 2026 09:01:29 -0800
Message-ID: <20261104170129.27701-1-jamien@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104-poetic-durable-jaguar-cdf3ee@sudeepholla>
References: <20261103173907.1996118-1-sudeep.holla@kernel.org> <20261103173907.1996118-3-sudeep.holla@kernel.org> <20261103211136.4122648-1-jamien@nvidia.com> <20261104-poetic-durable-jaguar-cdf3ee@sudeepholla>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265B9:EE_|DS4PR12MB9660:EE_
X-MS-Office365-Filtering-Correlation-Id: e2fe712b-fe92-4ec2-d401-08df3a955311
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|4143699003|11063799006|56012099006|261021121427099003|261102123227099003|261026121527099003|10067099003|18002099003|22082099003|10063799003|6133799003;
X-Microsoft-Antispam-Message-Info:
	iIcnMQQckzjE/bJE+cHFmRCUm3fldSdUfq6fPG6SNgwWowOKxqK3fLuhA5T1+P+Ia+2/YwQbdabYTdVfP1Vgggb7sC8CPvp9cxyTvrKsIuKALKQdDwjmnN4rHji45ZKDNulRX1uVBp0FErBhHEIee7s4Z9wLF9gI1/aEOdA6OlZ4HamOvxVizRKrPdh/o5V8y9wmZrWiyL1hp5gAqbQu4QCtdsCqKAUumAtvZ530yJuw+G5UzJsj2LeljW4MQ5hYGO4pOUNbH7F3esMF8OU/OrXXxbSpPnQYnuYaQTLI4CkDRtP3/i/TQU7mKqZxT4B3aqP4hqbIMjHY9DS+7typ0VtTPLvAtwAQtHb6OLOg/xRDR/78slKYU1HGu8Zb/nO4ExaaloFa32w17h3f5K2CHsZhrqpxJiexEn7qPN62JdMQjrKK6jmOftrsO7SwMMvZLZ5SfrOz03qf3eOoWb/yp9SE1mGwIwOgG8l7QVClGSTpKhK6qiOeg/1O9z7N26O+CYivvalz8/f04opP8Vxp61K0bA5VhI5Xz2ScRGgXOU2lCIk4R3AAs1kd6xng7QxI5OeEpih54PLXlGRcpuRErL5t/hPYKqF89jvOxlSG2n6OrNJxYFdiu13LU3GhfRNh6VaNRCWrKNHkS8oalMGCyrDSFOTcJgFhs4/xyq4zf/BTfzeYn+nlD79Z1ceJZWP3GpfhXrSGcMqr/uJCIZvNuA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(4143699003)(11063799006)(56012099006)(261021121427099003)(261102123227099003)(261026121527099003)(10067099003)(18002099003)(22082099003)(10063799003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qSDuLOTL7b029s8Lk5p6ANocMhJHH9du2yEVaJyGxG/s+w/ae/wgncOswevKI941oweQj8DHwjygJ8oXL+BQ9zspzq2cBhq8EelDoHH0DwEPXFh0XQwX2+XYmOdJvlElMuL4S5eZmn+CGowB2o2Gvvzl3E9h4yVEWfvcqW2j40ZlABR6NQW+C5LfhUDpHszR8nPPAdKymP86WBpBVpCbHD6X90VXOVJLYZXb8Z+Ac4zHiniZnCvCVAsC9jj0PsMM2RUtkUQilr1GPKORUyPQN7LT/5XIn8kQVfScYsUV+tDsgbOtaUhvcDCjB0BcEMt+VE1AF52SpKvI5cCqtohwy1H0KFw/d7atSwZTJMrD0BUEFD6iLMFZW9MPBNBeFQnI2JmsQ3C9LNF15oRBlEggqUC3wuuxyXl7cu7GPI9wez34edJs8qAiZlFtiE4xLylB
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 17:01:52.6664
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2fe712b-fe92-4ec2-d401-08df3a955311
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM3PEPF000265B9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9660

On Wed, Nov 04, 2026 at 09:40:08AM +0000, Sudeep Holla wrote:
> Handling this coordination is difficult, which prompted my earlier query about
> requiring v1.3 as a baseline. On ACPI platforms, this initialization conflict
> is already an inherent issue, as the UEFI or early bootloader might negotiate
> a version before the kernel FF-A driver probes. I welcome any feedback or
> proposals on how we might cleanly resolve or track this pre-negotiated state.

From the kernel side: the transport driver and ffh.c are the same FF-A
caller from firmware's point of view. Could a small built-in helper call
FFA_VERSION once, under a mutex, and keep the effective negotiated
version? Both would use it, with the transport's existing compatibility
handling, so it wouldn't matter which runs first.

I haven't been able to think of a clean solution for the bootloader
case, though. It looks like the same hole the transport already has
today, since the helper would negotiate the way ffa_version_check() does
now.
