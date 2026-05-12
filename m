Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011055.outbound.protection.outlook.com [52.101.70.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A37368D72;
	Tue, 12 May 2026 07:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778572081; cv=fail; b=pDPjc3ZeThAV1uSickruaAz+WNAnyFXq/XAYme1wXzjN+z/buuzmQ+zf1DADurYyPgXS3J7WvgvkqcflfX2PCDXLEK14mGLdwylb4JXoNqx6pFjuYayihwoSSWxkIquuW3jQ1vozr5zHF3qXZGI98qIMGVAOnASyHBmKHQt+gAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778572081; c=relaxed/simple;
	bh=i9xMNaW41gF++VOdKrx6W29C8BlF9jdaDA2+fujcQKg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HdQucqIQsoyyHQbKEwN04E1CiiVGKJKn5mzVy/ltMueUVpNQT3s5xcgb/J347AaQzxwV22r4XoXUP/t6u5WzYRAV8vCMe0DUMbW2Vd76frq1K8ztIrHzp2dpdydpLsG6ojiWdEbF1IT9yEdshd1M1quMhe/t+Jf2Uv0GeMZQYUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=qZHLK/oQ; arc=fail smtp.client-ip=52.101.70.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="qZHLK/oQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PQ49ZVHvavmX1IzUUdDMdrsSXOToJhOIXk9351WNOJgyweAV+jTMYzaNFaAoCe47hR8YSuh3D9KjyVH2QVZirGUmTwAxfHM64+JXYSH4BDOot1NIpBOUeYXa3nfh0pSr3XtvJHB6mRsndJHJ87sErZyGjs09RrDeVFh6CUFISSjHj2LfMXAK+MDKgLgqSE8I5n8eV9UEQJRPceZRvwRInrIzCEOJ6fmuk0gRYc3sGF9yQbpY3FRPyGwTAJWZKRMUbwMFgsxqKV2L4PDaK4gkp8VX0mDMyXEtgNsN0ghiIT+3r/5+D2+SsDU1XOWNM5DX6TY2GHzsxZ82u8OowUUVUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rbDOmqluc1IDjvYfnWRCm36E4KM8t7PnHuLr7aE5Lqw=;
 b=SLIATzTpDUKXQ8BOS6tOxhifDOC75wvk9j3I6pYx6q41SZv6BphR9bB3tv9ZGXtFE7dTjbCwt5qxH+aa6Yx0gzkCZ4Hj436ty+Xq/xzCB2pe/XCy9hPSlBVg+WJKe6xXC5Ilr0jnpEpxHBw79jPJF50NozL8qxKK+WoJgnDWZC46YEtwCZvEkwqQYnIGzkOPpo1p7zxK8vKeGKkJ7fiwMp4YNpJID+PC2O4hEW4yUmwtl2OJuigNL+p0qeRYz0etI/MolPDVFlovo8Gh9BESJ5iYP55flQo48a0kWB/mP/XjPWlczXSiBr+8RV30HkAPHyXcGPlSqS2aVc75aYq8+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=amd.com smtp.mailfrom=axis.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=axis.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rbDOmqluc1IDjvYfnWRCm36E4KM8t7PnHuLr7aE5Lqw=;
 b=qZHLK/oQvynzdiUBGr7HqDazg2lLn7zCHy8aOsBTF8DWIoQ5OhsLmnj03eItZVytW0Es3TIQm5rRY3ftPN1M/Su1xkop5fnlMAzAkpAK2mSB+lwtb0AeUSwjkqvtLS1iyRsjKwD+T3tyeIJUXF4Sk/wap7LxkGJ/d9z23OUp3Xg=
Received: from CWLP123CA0030.GBRP123.PROD.OUTLOOK.COM (2603:10a6:401:58::18)
 by PA4PR02MB6749.eurprd02.prod.outlook.com (2603:10a6:102:fe::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 07:47:53 +0000
Received: from AMS0EPF0000019F.eurprd05.prod.outlook.com
 (2603:10a6:401:58:cafe::1d) by CWLP123CA0030.outlook.office365.com
 (2603:10a6:401:58::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.11 via Frontend Transport; Tue,
 12 May 2026 07:47:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF0000019F.mail.protection.outlook.com (10.167.16.251) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Tue, 12 May 2026 07:47:53 +0000
Received: from SE-MAILARCH01W.axis.com (10.20.40.15) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Tue, 12 May
 2026 09:47:53 +0200
Received: from se-mail10w.axis.com (10.20.40.10) by SE-MAILARCH01W.axis.com
 (10.20.40.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Tue, 12 May
 2026 09:47:52 +0200
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Tue, 12 May 2026 09:47:52 +0200
Received: from pc36611-1939.se.axis.com (pc36611-1939.se.axis.com [10.88.125.175])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id C6F6A1D39;
	Tue, 12 May 2026 09:47:52 +0200 (CEST)
Received: by pc36611-1939.se.axis.com (Postfix, from userid 363)
	id C118C60E4D; Tue, 12 May 2026 09:47:52 +0200 (CEST)
Date: Tue, 12 May 2026 09:47:52 +0200
From: Jesper Nilsson <jesper.nilsson@axis.com>
To: Marc Zyngier <maz@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, "Lorenzo
 Pieralisi" <lpieralisi@kernel.org>, Hanjun Guo <guohanjun@huawei.com>, Sudeep
 Holla <sudeep.holla@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu
 Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel
 Holland <samuel@sholland.org>, "Neil Armstrong" <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Ge Gordon
	<gordon.ge@bst.ai>, "BST Linux Kernel Upstream Group"
	<bst-upstream@bstai.top>, Jesper Nilsson <jesper.nilsson@axis.com>, Lars
 Persson <lars.persson@axis.com>, Alim Akhtar <alim.akhtar@samsung.com>,
	Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Dinh Nguyen
	<dinguyen@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Thierry
 Reding <thierry.reding@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>,
	"Bjorn Andersson" <andersson@kernel.org>, Konrad Dybcio
	<konradybcio@kernel.org>, Andreas =?iso-8859-1?Q?F=E4rber?=
	<afaerber@suse.de>, Heiko Stuebner <heiko@sntech.de>, Shawn Lin
	<shawn.lin@rock-chips.com>, Orson Zhai <orsonzhai@gmail.com>, Baolin Wang
	<baolin.wang@linux.alibaba.com>, "Michal Simek" <michal.simek@amd.com>
Subject: Re: [PATCH 07/16] arm64: dts: exynos: Add EL2 virtual timer interrupt
Message-ID: <agLbKDWlJzZxB9uS@axis.com>
References: <20260507125544.2903406-1-maz@kernel.org>
 <20260507125544.2903406-8-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260507125544.2903406-8-maz@kernel.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019F:EE_|PA4PR02MB6749:EE_
X-MS-Office365-Filtering-Correlation-Id: c4c11cdd-3864-4266-9b99-08deaffac64a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|30052699003|36860700016|82310400026|7416014|376014|1800799024|13003099007|56012099003|22082099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	xRuIvGl0acACs6zEpoQgzYCukTdTI8RgJMLsjNQEuXLQqLzPSAG7ESkr2+izu4nUpuhwaHvf+JBbpD+UJKzv/BwFs/L2QPro+Z8MXVcWLTMObluOAFfBu6slkdqLui9eli5C2E707yNVeyNyX5bOHi1Go2D2ZG6K3mxMDK2K/D73FL5O+M+91K1kMBMtvpjSxN9O234y8qD2vBEnJI/vcHmf3q+hrJPIMxAcYVK6gZT0D9rqO6bHvXraTbeOo2yqk7W/9voiVfvwR4GBosUg/5zXIYy7Kw9bw6NTCLsgCuJtlPm5sQOcT9e63W/OUEDUgpPZwCI46nhdK8ov/vCarVQdEibolFKGn2qv9SEyj9wBzpT1GzTksoDlAH43PYif4zniPDfj1WVHM2sd9L0OhHP6IdMYo4JcYlLJLMV2Egb5EMTtPc93y1MA+nnkN171FFOhgt7nRlg4sKEyWKLkpTjwspvbJqfHiImYexBXjm5ix76gIzVYui0Vy+jiUSoM18bmUNoGyl1LF7Te74I5B2s6RKgM2IaO2XuNhGisiaruTg5jNIINfpMlIZ4bvGSPlY3hq/v4rVPtssnwwHN1SLR9kPxsZJOVW4ff2VFQQSwxVLpuE21mNoPXCDH4hF7k7fuTZNiPQ7ddIaH/7Ozzp+ZPB8T8VqYoDIgih0JeAEGQPgxqYYeHsvoEtHkXcSRimjs2JGmGnUUx+vTCBC9yV5VCpjIwV3j6xCBJerbQX3w=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(30052699003)(36860700016)(82310400026)(7416014)(376014)(1800799024)(13003099007)(56012099003)(22082099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ktEgpbf8P7q/9mP9WRlsxwYhVyz4MyhaW87Y8IZx8Po0BzuxJs+72ctUOMlq153V21K4vRk24BZt75Tb1nc5GxwdxMJ4jnU5FrcreIrDSonhYPfIInHuYppgdpffYggysU6jpqZaU/1UWZaCoE14bzaffQbdh0BgIFjVw6rwesZmv45kgufEku1TLlK7bWSgVstCd/gQ244Bk2vojo2wdajxJAX/oQdKJOB8RwNOPqUYodp+VPKCRGESyvZKjjtudvu8mJcuGZqHyvGQqSzc57RqvOiL8OPZ6B/Cy/37IvC9QI2jERQFKOlleRw0w6l6B5YmFiDVEdepa3j3Ktr2BQaPC2glw8nf2+DqutbcV2LvtkW2KT7SSfiTDpwCYQkNpO3r+6V2WtoGXZW4tOdr+BiyxxYnTbK2tMelroHjxeBiUO5JFyMXmOVj9wgzFTtb
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 07:47:53.4521
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4c11cdd-3864-4266-9b99-08deaffac64a
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF0000019F.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR02MB6749

On Thu, May 07, 2026 at 01:55:35PM +0100, Marc Zyngier wrote
> [Some people who received this message don't often get email from maz@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> A bunch of Samsung SoCs are missing the EL2 virtual timer interrupt
> despite using ARMv8.1+ CPUs. Add the missing interrupt, except for
> those broken designs where the interrupt is documented as not being
> wired.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/boot/dts/exynos/axis/artpec9.dtsi | 3 ++-

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
