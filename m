Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012053.outbound.protection.outlook.com [52.101.53.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684D34048A3;
	Wed, 23 Sep 2026 17:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790184796; cv=fail; b=DGVhlZfDhTn8Ho+SCSlgldnRBxEz/pPUGWoE9zlPQgvvDrN2jZEe+4LSj/kE9X0L132iNa4cBRlj+C9i/mBIdqKPXrZ7eWyLLcyr1tAZEnGjWJLUPSK/IgCfEx8/7gTurFb6dBS7VV3amublsJKDWE9/mkBxXO1v5fQlCxO/l7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790184796; c=relaxed/simple;
	bh=Q/JkCKT5XcoUFzSh7MLxkjHs4jndLNMi7JmC5FQ/tnw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HrRfj3FXWjpjs/lhvnFXoQjBSvFuIsGYasHux9AgnzwvOJi44aYp+uVUW+Hths1rC54QB7A7offIW0mMUSaJWuCAXAh75fzhz0qQcF1OEQpgGGzeCveOdAs8XHHImDHnuInOCRclEdB5ojb4H+CdH00VfbIEUwpRW3DqsGwujiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CoKPcDs4; arc=fail smtp.client-ip=52.101.53.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CoKPcDs4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mff6z+W9/2PlpQF6vo9Ys/SIinqks0ob5V2Z07UpxQbBttCunomo6laY+NYShywKTHnDPsa5nGvQiyV5zJux9IIUftDqxwHJ/TNczkLq+4wTqk5eepJzBb7KZCbgxtcRVYhtqYrmXRohMoE+sijAg6CZ0qlJlOjuQJOVstmVB6fTyupCK1fjIA4325cUFcOwpfp/cIGDuFWpUkSjL/CP1eNcSlAM4n1LrQp+XT1DPDRbea1xEX8K8HRV+d6pUAd3EB194BHjBGv8ahBk4HSoxoV+KeRb5N+7zhc2KfZI7ySUm2Fy8tlfdUu6lScvqbU2+URbeIe02gV92JYfjWclKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ayk1Fu9/kU+2Ydle5NnuAlPK6ghhqC4r2KdpjnxkWVg=;
 b=BD10tO21PTGOmDiJ2FAq9/y163pDQ8nGic6n95elCfk9VbYeTPLgJJW6Hr7+HrPGClRYkq27jwYemsemhxJ84FGljgz/9pAIvfzpbFR0wns9y4dMqpeaPRB8Gl39QRDj3kDdrPRy7tL2g1zQ3X96Y1a/4WcmjdYYReOKXPK/rqZwGnI8VTOVavy3tDGWydlnddkJrDxkmNg/x4STX/WP1Np2tYEEoPRJI0nbMGiMB7IAwu+5kyJzRqsEVn8rI2qExKrOcvktndmztKoQDoTnY+j5ZmjpZnaXAUliefF24XXRpnz0rLszvi34TvWIN3TsPzGFiEusuAvVGSK9h3Ur6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ayk1Fu9/kU+2Ydle5NnuAlPK6ghhqC4r2KdpjnxkWVg=;
 b=CoKPcDs4+dO1QoUG6HVEPE1H4i8gsGtoYfFOK8OjbOwHdn3Vz66bOkrR4FKvR60nMI669GOfUkfmZuZ2iHE0zQoKTfk1q5BqNn+brZ2XxP0Z5/TmCttb8Fi4WPX7WwZ9goZIzkGApMdqDNozSY+/t/tFqjTiHOJcA0QEDX8k8uP+euzH0JP/4OJHJVtVjC8lDkIJ54GSu0UXlytX4kGzpvU+FHMvtpg3jplCqrQBk3sQf8yCbSLJxp8C8lwztHRbdRegEiHu2JJbECK5aAPW+QyzkJz+l4aOZyzreF0E4us/o0bcR0UHaIYcNjV6w/KjzM5MrfcB76uQMXfwRQxcwA==
Received: from BN9PR03CA0782.namprd03.prod.outlook.com (2603:10b6:408:13f::7)
 by LV3PR12MB9259.namprd12.prod.outlook.com (2603:10b6:408:1b0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Wed, 23 Sep
 2026 17:33:08 +0000
Received: from BN3PEPF0000B06C.namprd21.prod.outlook.com
 (2603:10b6:408:13f:cafe::2) by BN9PR03CA0782.outlook.office365.com
 (2603:10b6:408:13f::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Wed,
 23 Sep 2026 17:33:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN3PEPF0000B06C.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.0 via Frontend Transport; Wed, 23 Sep 2026 17:33:06 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 10:32:40 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 23 Sep 2026 10:32:40 -0700
Received: from dgx-1v-42.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Wed, 23 Sep 2026 10:32:40 -0700
From: Jamie Nguyen <jamien@nvidia.com>
To: Sudeep Holla <sudeep.holla@kernel.org>
CC: Jamie Nguyen <jamien@nvidia.com>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, Hanjun Guo <guohanjun@huawei.com>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Len Brown <lenb@kernel.org>, Dat Mach
	<dmach@nvidia.com>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] ACPI: arm64: FFH Operation Region support for FF-A (offset 2)
Date: Wed, 23 Sep 2026 10:32:40 -0700
Message-ID: <20260923173240.3710620-1-jamien@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260923-lurking-pony-of-fascination-ac6c49@sudeepholla>
References: <20260901192906.133670-1-jamien@nvidia.com> <20260922-purring-fennec-of-exercise-bbce5e@sudeepholla> <20260922155211.676134-1-jamien@nvidia.com> <20260922-exuberant-earwig-of-opportunity-4fecff@sudeepholla> <20260923124050.3270801-1-jamien@nvidia.com> <20260923-lurking-pony-of-fascination-ac6c49@sudeepholla>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06C:EE_|LV3PR12MB9259:EE_
X-MS-Office365-Filtering-Correlation-Id: aca38474-8598-4b92-9f5b-08df1998bac2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|36860700016|82310400026|376014|1800799024|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	c5tmLfgjYpZXxulyYu2QL4uo+wacxo0XXGYKzR60VXxJHpw53Kb45MgOhFQdcRUuEo7sIi/JGlUKPRmJipAD6sYVJBSXUif1WlosJgPvCEPhLl8Z6FCUoeMP3busv9++gghWfCQxHRXLitew+UR8u/QvM5PIF+HYzFk1vUnnne/89kioQJKErhGjiguutFB43RNm0PTkp+nWiDxtqtCV8KIjxUNuluWd+HkyA+S6VrZBRDFDFEVFCr64OZtBSKAbLwlMfxpUFdBY8VuzPGX+KL0dtKTbiQbQjT3/zM68GHy94/Nt5nVJMnlK6Dhf7V+1k8KdW/RDIZivU7yStz3OCDv6xbC1BWgrDQXF8PcNteQ70K9pCqpHeEySNA6Sk1EKf31dg3QUV14MS/ikUl5jgpEf/hugj9+lyWGGhpp0MmLqSoYsoHw6Ax3X/GUscAqMNU30w5V0xc+wu0Xf/AZl+cs0J/+G2Bt4p2bYD+psqFScS1DKxDYEXN9F7WbcMqepHSQuqTCXADTZOt3CB69m3oPLZ7t4OoEReCk994kqvOxZhwqZoXNMsXDIXWfFDRSmcT2dQRk2B+kCubP8LdfpCMbONMJPSG0pnMf1EJ8xiD/QBY5DTE4LKAr4Pi0IrJuJf5UtY1gI129FMW4i2umUoUaT6EMvVLkZggLLAV/WQf6I3qS0CnsgvzhUPk8VTasqnJh4Y6oD5ehkK2keWs8IDw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(36860700016)(82310400026)(376014)(1800799024)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VNRCn00G35G9WO5SPE3DOO8GJVXu1zFUnYvZyPKL25+LQlSqaTex5KliwUy9jyGfuUtDV538c16N2k3wRPNPPL0HjC5YwNhO2F+VlwvfAvo30QKqoVnKADx7VDPtgfioWs2V4oPERt/9qQmWJgxiWxur1Rab+BXsE/EDqMNvBsjptiqaYDgsskDD6Ibl5YEiPIiqQHcqNXM4i1CVTJM2tM+GE5BAAPGlPMx/CwOe0yDQ7OKiHFXRkSOkwlszxqn2lvutjyAeup49aGtvoJjT+DkUjgtBayLKVke6wFVjHqNk+ueihZWGhlxAF1Q9OqamwQ9BdqvHHMhxixoM5G/okanciuxkQqRTmcpk7Q9u/YuY33F6dZiqAPvf2dGEo9nFpvP7AjVJTFR7FLZC3W4Pk8qYzH+xbtUvznrxdNnUX2C+31be6XiLOSsZRrXuba8X
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 17:33:06.7156
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aca38474-8598-4b92-9f5b-08df1998bac2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9259

On Wed, Sep 23, 2026 at 02:38:28PM +0100, Sudeep Holla wrote:
> I did try to come up something simpler and independent last evening and
> this morning, far from completion and I am also thinking of 2 main changes
> to it yet:
> 1. Maintain hash for receiver ID list
> 2. Drop the whole FFA_VERSION fuss as it must be dealt with in UEFI and
>    that should be sufficient.
>
> Of course not tested yet and even not sure this version is compile tested.

Thanks, this looks much simpler. I can confirm that both patches apply to
v7.3-rc4 and build W=1 clean with ARM_FFA_TRANSPORT=y, =m and =n. The =n
vmlinux also links with no transport-driver symbols pulled in.

On FFA_VERSION: as written, if the transport driver has already mapped
its RX/TX buffers, I think DEN0077A R0216 has this negotiation return the
Null version, so offset 2 would report NOT_SUPPORTED for any AML run after
the driver probes. But if it's dropped, I don't think it's guaranteed that
a compatible version will have been negotiated by then, right?

[...]
> +	memcpy(&args.a4, &buf[4], len - 4 * sizeof(u64));

This would trip CONFIG_FORTIFY_SOURCE's field-spanning write check
whenever the region has more than one payload register. I think this would
cover that case:

	memcpy((void *)&args + offsetof(struct arm_smccc_1_2_regs, a4),
	       &buf[4], len - 4 * sizeof(u64));

