Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.8
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793740320;
	b=VbY/xPoQgYNd/417PRbFyJe1z8luLvLD1ueDlPtMPdpYrwlQCwJ+z+UtdwcZI+94MutP
	 LJXTL8TTNDdaaPOZ9dLKrVMWM6r/BCTCjjB9PF2xS4wMKJOM/tnpZSIzVlyfAoAcxnWkN
	 50MgwFL3eEYdkIoaN8FMvLVVHKbe5LAEQohbApQT6d+BbdoAJrX9T5zNxGA9tUv9TmIjn
	 /PVw4DTBQJXV/wrxecHiLfYdrh0KrsD2T0umZC4dIlETlWw4bjWqbce4cK2RyePpvMGia
	 p6H5iVSoNCNVQsSinuocMSlkGIJy4nskU6WiKktaROzF3OFe5bXoyUX9cGNvNc3DDMQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793740320;
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
	bh=YlfGwSVbL75ay+8vBxjrzjmT6cftmNmJQksKTUgPef8=;
	b=PQWCGBx98gr4u3HPhotNNJ1GvXu09n4B6Hx0PBGZ8C/sIIeh1rGMIgSQuMATTBPsqbYj
	 MtL9mmxDv9HYZDlyaj8lNu7CcaiDv08rJLTUK2jFLY/ZHeJEYMXT4yk7CEb6LK9pw4jji
	 b55Zo83QkijSOQbGBc+i0b+tNPfnwp/m+c07ujtRWqNKafQiBNhCE81/9IRnMdpotq825
	 HJ2gyp8/zpi5tTALBeLiVWC5XBXR+Ud1MniPxlad6PlmAviA8eCLlU5zfn1SFE+Yeozvr
	 pFjClsCF9oFBeDB4JtDqz/x+NnRbVoga5FIMPjEMRIoRm7CKWIjvzJ+3CYdGdV8TcLg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=lEn4x3wU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.8
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010008.outbound.protection.outlook.com [52.101.85.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8115606A324
	for <linux-acpi@vger.kernel.org>; Tue,  3 Nov 2026 21:11:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8115606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=lEn4x3wU
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ebZ5z5MsNbGkEHsldOIxpFZoe+vNQzfXBUaKxD6IaQtsp21n8GnKUt8m5CUxwM60uwjzehCi/TlPjfOnyEJKc837lfkg97A3R5f0pJ8mWucopEO7/E492Q0712nKD9XC5jHsNT0AoicwBU23Tc/TEGpuNszCwplso3zF7rjFOioE4V6m+DNhFHQwoyYCW7eE44YU68is6Gr6o7EeDrpILgbRfvumbtYB16LK/clEF2xVZrGhx9khDFZcXm0cmPc5CvZz1pvjsTA1d4IqTIMxWKee15EINOeNq27MFMfVa77+9gihrVYPKUqG2gTHmb0UNym84L+6xy3f4kVmf7Mtaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YlfGwSVbL75ay+8vBxjrzjmT6cftmNmJQksKTUgPef8=;
 b=USJop7FHomBEul1Qo+N8NJk3jSdm2e6IM6d6fav0SSSi5ThzW4LlWD0xH1P7BNYz7pW3lP+Qjf/WCKu8jJ2QIKfPwp6z928Xizfm7nzS4u1+8I82mtuBxo3aSR77floeE9rYbM3vEyYco/HhZcsTIffnaX0Mr00B9HpuvwZ2FvHp2JXHGyQ2tYn2yZ3kLIS9bAX49zWCV+4BHAKgw+kydL7oLs5iYSvTdVBegXaVy2NMkmrZXfo4M7nFL6ar7bYIZ7PAMnfxdQRCXAW2y9NF+TEAPsa2fv+MSLaHVibPvm77NHS+J/MRla4uAWeBbn2ZnJHwyDOuUwvkNhEkhmDqcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YlfGwSVbL75ay+8vBxjrzjmT6cftmNmJQksKTUgPef8=;
 b=lEn4x3wUmToQXZxBNqHuYjmKp1XnxkTYJHqzzZVuLdUHcdv+W1KfQlcvI3UrRB7Z5FWTrHq7Cuy95bva1ZG7fKZ3LH65ct71LUT234Sdmkn5w86mJUj/6gPHsE7xxMS1vZ5TP4SB9UAE4NZB6PaEmRXgTh9tpRqURxs5/8/ydaWsQw+iw3/01U0JmTSkJQJs5doAqlEnhMUkCfyqn47r1a5AaQd+Ot+VHST2Ur4lEXiDAAFy4NzloXvILtv37fHe5qqCixmNXlndNP0II41mn9vS/7QAnvzBzKknvN6e8o2SvDfRvI/EFOUxVGdswLXPE9r+QwYfSOMSAeHRg++jCw==
Received: from PH8P221CA0046.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:346::21)
 by PH7PR12MB7233.namprd12.prod.outlook.com (2603:10b6:510:204::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 21:11:53 +0000
Received: from PH3PEPF00059618.namprd05.prod.outlook.com
 (2603:10b6:510:346:cafe::76) by PH8P221CA0046.outlook.office365.com
 (2603:10b6:510:346::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Tue, 3
 Nov 2026 21:11:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 PH3PEPF00059618.mail.protection.outlook.com (10.167.243.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 21:11:53 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 3 Nov
 2026 13:11:36 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 13:11:36 -0800
Received: from dgx-1v-42.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56 via Frontend
 Transport; Tue, 3 Nov 2026 13:11:36 -0800
From: Jamie Nguyen <jamien@nvidia.com>
To: Sudeep Holla <sudeep.holla@kernel.org>
CC: Jamie Nguyen <jamien@nvidia.com>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, Hanjun Guo <guohanjun@huawei.com>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Dat Mach
	<dmach@nvidia.com>
Subject: Re: [PATCH 2/2] ACPI: FFH: Support FF-A direct request 2 calls
Date: Tue, 3 Nov 2026 13:11:36 -0800
Message-ID: <20261103211136.4122648-1-jamien@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261103173907.1996118-3-sudeep.holla@kernel.org>
References: <20261103173907.1996118-1-sudeep.holla@kernel.org> <20261103173907.1996118-3-sudeep.holla@kernel.org>
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
X-MS-TrafficTypeDiagnostic: PH3PEPF00059618:EE_|PH7PR12MB7233:EE_
X-MS-Office365-Filtering-Correlation-Id: e276aac9-0e49-4cb0-32d2-08df39ef15f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|23010399003|18002099003|22082099003|10067099003|56012099006|261102123227099003|261009223027099003|261021133027099003|261022113327099003|261022105027099003|261021123027099003|261022115727099003|261021135927099003|261028144727099003|261021121427099003|261021130227099003|261022075727099003|11063799006|4143699003|261026130827099003|261026121527099003|261026135527099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	xX1yKmHyW0qv6Q4VsbGohNE83G0vkhPrx9tLNnc8dXQqSB8NAGsXkIDghv6yo4Pzu1E8iNM/PByq/AdjyKq7wBaee6UcxUwgVU0iivp5FU4jtbUzmgR2MhpDAhuGy5VrJ3xUCfhP6FkC2/CFFouomGeAxvjNJXrnIdtg0HyeDREzJONZOZNULXEMXgm7v2x0/uV6nli/ibJUtBfo8s+KkPbD8gAChTfs+Tl3OLpuKe+DbHISyxPkY1vr5kUwhalHWdX2ZwdP/bXYPKyYGvjwVe71KbDEBcceRnIdcJcErsgn+xEwibDdvc3FiRusLVa40QfCNOe1O9wMc2NnIMHb9z9WVRDPueyVVOGagux4kBKWhZSapfSv++kmZnrNFxnH0/Wmkj4l20WnCLhtvZC1tkZtdEe+AcpAIni1ECTr5DwqM7FQCjtUg48W2KENztG2nNBZmrM4IsdPUvBCq/S/JKeXo7wTsJV1mMoZR9CXa2k36OQNQ2SCOT1dd7AAbqcpG8JfU0AhpT/fIaq3zNMdDl8t2zebymC+5IBLvgg/XgAaOtZVSw8OIXAJ8PemWK6C1OO8T8reIWrGNG7xWXk3ZKzkP5/Rigz9Y0dLl+ar8/jl/dljY0ht3NOkZ1A80xgd8h+GuAzB3xZPDap9Hzv1DNLJGrbaKyN7zwDldRizD1fnBe43WAWWllzdgHXEsTphWcy4qp8QFTqEGDmrqEza+g==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(23010399003)(18002099003)(22082099003)(10067099003)(56012099006)(261102123227099003)(261009223027099003)(261021133027099003)(261022113327099003)(261022105027099003)(261021123027099003)(261022115727099003)(261021135927099003)(261028144727099003)(261021121427099003)(261021130227099003)(261022075727099003)(11063799006)(4143699003)(261026130827099003)(261026121527099003)(261026135527099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0kjiUbkg00o/YDqpjzg211BdfEIAuU4aecjcTyugKow/PCKqK1pKU14mIatXQvZ2RAQ3KaF055w+tekVx8SkmlFbM6ZpBcxHX0fU6CeRW+SZ4+dAbSHs3Ty+HmSnoDi1OcsAp+4bOF5sqHJT3PTUrHictwgDmSpXP/ulPTAm6X+14DMP9LH0rW90MnrKxm2/3WTZdO1Pu5igB+JGvNUqjoTyMgGMNj1PJir/Cg7C2F7RiES7vnKyKbqFMIDlGtOcovsky/HQoybsSPYtB/XKTK53LMn1DgKeFYshgM/NSkPpQnUIgSS8pzxuMldetWeEO3yBV3cR13xaiHAdEtIKAIdRa5LJJ2onJKQDgFgZFl+LHr9q5ZRXHJXPhTdRa6DHo54jSz3HY3/Qm84HqfurU7vZ52JyLdsF9pzXHm9DX6Z6tZLRYM0TfC6X3ALKNSFi
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 21:11:53.7088
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e276aac9-0e49-4cb0-32d2-08df39ef15f2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	PH3PEPF00059618.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7233

On Tue, Nov 03, 2026 at 05:39:07PM +0000, Sudeep Holla wrote:
[...]
> +	if (!acpi_ffh_ffa_version_negotiated) {
> +		args.a0 = FFA_VERSION;
> +		args.a1 = FFA_VERSION_1_2;

Same question as on the earlier thread: how does this work if the
transport driver has already negotiated a version?

[...]
> +	ret = acpi_ffh_ffa_features(ffh_ctxt, FFA_PARTITION_INFO_GET_REGS);
> +	if (ret)
> +		goto out;

I think REGS is only needed when X1 is zero, and if I understand
correctly it's optional at the Non-secure physical instance. Would it
make sense to check it in the lookup path instead, so an explicit
receiver ID still works without it?

[...]
> +	memcpy(&args.a4, &buf[4], len - 4 * sizeof(u64));

I believe this would trip FORTIFY_SOURCE's field-spanning write check.
So I suggest:

	memcpy((void *)&args + offsetof(struct arm_smccc_1_2_regs, a4),
	       &buf[4], len - 4 * sizeof(u64));
