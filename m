Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012039.outbound.protection.outlook.com [52.101.43.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8E7560AC6;
	Tue, 22 Sep 2026 15:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790092372; cv=fail; b=J4ZIVJ8tJVHbeshn2YQeH6FYFce/KslMuXZFW6DE3zgfF2yG08FMfH5vkN2NT2j9gmUt2PsCeF7m4voaVE2MUz/YiSFsRFoqGLrpAMkd6YHTpekJwaTb8zYtoGzdNyUnjUyVN5WL/dDij71kWwSypeCjMJaMyH73p9v3aAg6E2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790092372; c=relaxed/simple;
	bh=vyxky55saR20D8RVWroa4976RydiqaqM5jdSo6aQQVE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HWRKziK2pJhdZEiEpCeJedwovcBid6iLDxjIx5N6J5sBjyEczC3wIPJ2QWS1JZ6OxT6aGD1TISLrBBUjXe1GXDiQKGsA5V167Ss24DS4ClebxksUowlnReZBKlofdwn4MM2oo/BRzkHMby9qqcs6bQAKl8XwzrbjlRqCbc/K+s4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=m1nJ5Gk6; arc=fail smtp.client-ip=52.101.43.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="m1nJ5Gk6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jXAMs0W9jhIOTCMnsIAR8DRC9f9a4ynIGfQIxsrhFzXF1ZaMZYaS4HlORle1oVtv0DLgzu3xjc2IcH7AlRd55Tc9NQu9ToKY+16vDaKoO08Kr+r1Ofa6+hbwT6K1MzGJGNb5OgySibCi3UKGU/Au0LXfxMWzZXTKy95nrZJswcQdGRq89yyE9wNA4hj4LR50EcatZJwRDrzyPxPAr31iKeoPVx6nEO0eqjxZeB9E8zOvBb5WgEAPaBq8yGq4KFZOutpZoEUBNjBZCu3zosL2d7Cwq6NcXpmHXfDuS9otrubZqCa8wXkpv0HMp81FtPBjm/yXm816xU6jZm6D1EZcHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vyxky55saR20D8RVWroa4976RydiqaqM5jdSo6aQQVE=;
 b=KJNL+xGPch3qqQ1Ncw7CI5K/IiiEj3zgyngeJVSk5J1a1KMfmYycT7pMhV3zMw7PfFaC4h7tqWtEjHSjc1Y3ED94P3cLp2i6oj2BIgi05LSv2sJRAhTNV2npKDbNQPdKj6fOn2MP2howvjHwqP/VsShf1fg9f4YnE3paWFqQ839EZTjaATgXRsSYpolc0MCKxMUSWAUce0aYwLmrv4Ly6cfAmEQz8qmgdm4zglmD0sNurQ+SwjdrgHBo+ixlgCm5qZhjNwzdOFWG/KwNtud3fhibMdJJ/PD4S4itnUasIN+lNs3B5ZTmW4rx36XRwy+FAkuJycqYHGEsM3zcHkzESA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vyxky55saR20D8RVWroa4976RydiqaqM5jdSo6aQQVE=;
 b=m1nJ5Gk6EdK7dtzi3VN3zTzOiBmXNVCO9pnfQXsYgZj999iTzTkLghADREL3uVgG0T5xBS5vHmNprCkoDjUlWQpG04eS4211DZq9ZO8uNoeO5GkohBHc3e5ui9yBvMx1Ee2tA/0woj/Jnv4TwOlskYagBWH5rgBMW35wfPMF5KQBaCSjOEw/znL4L7CqlssfN9KWtOuGwjKugrzf7d5TQGk0c+TeSbuBhI3fHsE6oi2yYl4C0WiuSRu/NbjO9MlIoylZeXNqKIvgGE80tl07wPM9k0DDcXwyfu3/eD3EHM12Ghg16aC4z75LGYxiYMBJ9TN4Ai//iT7TEjTuvRsMJw==
Received: from BN0PR04CA0136.namprd04.prod.outlook.com (2603:10b6:408:ed::21)
 by IA0PR12MB7577.namprd12.prod.outlook.com (2603:10b6:208:43e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 15:52:41 +0000
Received: from BN3PEPF00022BDA.namprd03.prod.outlook.com
 (2603:10b6:408:ed:cafe::6c) by BN0PR04CA0136.outlook.office365.com
 (2603:10b6:408:ed::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Tue,
 22 Sep 2026 15:52:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF00022BDA.mail.protection.outlook.com (10.167.248.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Tue, 22 Sep 2026 15:52:41 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 22 Sep
 2026 08:52:12 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 22 Sep
 2026 08:52:11 -0700
Received: from dgx-1v-42.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Tue, 22 Sep 2026 08:52:11 -0700
From: Jamie Nguyen <jamien@nvidia.com>
To: Sudeep Holla <sudeep.holla@kernel.org>
CC: Jamie Nguyen <jamien@nvidia.com>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, Hanjun Guo <guohanjun@huawei.com>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Len Brown <lenb@kernel.org>, Dat Mach
	<dmach@nvidia.com>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] ACPI: arm64: FFH Operation Region support for FF-A (offset 2)
Date: Tue, 22 Sep 2026 08:52:11 -0700
Message-ID: <20260922155211.676134-1-jamien@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922-purring-fennec-of-exercise-bbce5e@sudeepholla>
References: <20260901192906.133670-1-jamien@nvidia.com> <20260922-purring-fennec-of-exercise-bbce5e@sudeepholla>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BDA:EE_|IA0PR12MB7577:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f367d70-681b-4fa2-1632-08df18c1891f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|1800799024|36860700016|82310400026|6133799003|10067099003|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	jrGHwinW5yyIaE6hisvvyZgxwhSZsgDmUOZu77F/KKBDGyIP7MzIAIJR+SLspIMcPf4shw5AruAApGYNVOsFdLeMiIt0HO5G+/cF18SmuF24/kLX55sCMM8ufOScGBdVjGimMDiDMBMitAUlKm8DHavJPtiyIKO0vuEph5kCBDl0ze3t4M/u02tExdh3TjlWaKmVkOLtbevShTfUXBim1Kg9muOhQAVIzaQu1R11RH0d92HoD4qsxL2Jixv7cA4PnY3oTCywMBudtGgIkqZ8jujbSiz9vFUQJPulJ6p9lOBtiwa1cfPLCYfU03pYlTiKzQjFECObYzSO1opO5Y8A96ZEO7yBYzQ6zAfqu15l3PsmUaSJE84N5UoHnt74UHnqZwsgc5SXanE4ICk5gtKXfI19+e4qn1VPkC/rGBBQp3ulvEIma7R4wrqS3DqmQj3baodEW3VRDysDCjq9kBtzZAhBHiu5OHlLAfHxlfP7due51F7caYr5RlTNmXOatGWzh81e06X9rL39P6AjdWaCkFcaYN0hJSWoU/XVM7yE8HgRNrzbWQMaAGFL1Vf8z6hVHgtE2wO68HQvxQtWl0fiquQKXwXSdmMpPlsXFnLgvJ88am3qxi1tIMnsFLlHHxEgx3PlNhzlw8GNe+0P+zht1x2YK4nQXPfRJr8pLnHzmcpAYXk6eAaxlZ/8EXO7frVNNki3XKuJwtiVtnOrfSZAbQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(36860700016)(82310400026)(6133799003)(10067099003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bN15vzE9wnMIM0GROtawBhJYDUXMCW0pWJ1MK73Y8TulqVFs4Xg98FGaX/CMvECDjrivW1HrFTSIhTjytffWCUcAyxDoDU9SsdBPW/1fD/3lVCI+K8gljL0Uqfmo/3mCJxAYwa7w44IRlTj3J85e4r2FBtWpee7oQT7fiYC9JCCDgCOE8ZRiVAmJnLM0cI6MO+5DxSg8d5pC6vLVzF7ZU3dwLjUnfm7OEjeNLlN5xIS8WLFwHAl1xXZRDNuojE6yQmfrAguEHZKRDg30WaPsiSFjhIXKlTFQ12JrVWHtD+0UNa8F9XvAYPXWoIgATilIEUmMKpgo8IcyS+f6mL2Asu570cgIRkIz3xrQqspPkMR1UZv+y2rt0ACx2mwBrH6Qv+V6pdlBOQ3osufGlY4M1Ja8Q+S7UpdKa1XpdAKiT7AvFQKg9SEm8U2olDGRgCe9
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 15:52:41.6284
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f367d70-681b-4fa2-1632-08df18c1891f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BDA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7577

On Tue, Sep 22, 2026 at 09:46:59AM +0100, Sudeep Holla wrote:
> Could you clarify how the build and runtime behavior are protected when
> the FF-A driver is disabled?

There is no build-time dependency from ACPI FFH to the FF-A driver. The
registration direction is from FF-A into FFH: the FF-A driver registers an
optional backend after probe and unregisters it on removal.

With CONFIG_ARM_FFA_TRANSPORT=n, no backend is registered and an offset 2
access returns FFH_FFA_NOT_SUPPORTED. With CONFIG_ACPI_FFH=n, the
registration functions are static inline stubs.

I have also built CONFIG_ACPI_FFH=y with CONFIG_ARM_FFA_TRANSPORT=n.
The W=1 build and full vmlinux link are clean, with no unresolved
references to the FF-A transport driver. I'll mention this case in the v3
cover letter.

> Are there any other technical justifications for this tight coupling?

FFA_MSG_SEND_DIRECT_REQ2 requires FF-A state already owned by the driver:
the selected SMC or HVC conduit, the sender endpoint ID from FFA_ID_GET,
UUID-to-endpoint resolution through the partition discovery ABIs, REQ2
feature detection, and FFA_RUN handling after FFA_YIELD or FFA_INTERRUPT.

Open-coding those operations in ffh.c would duplicate FF-A initialization
and state management. The ops registration lets FFH use that state when the
driver is available while degrading cleanly when it is not.
