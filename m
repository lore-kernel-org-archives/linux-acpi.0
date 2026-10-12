Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010011.outbound.protection.outlook.com [52.101.193.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9256938E8BF;
	Mon, 12 Oct 2026 03:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791775539; cv=fail; b=goOVTubOiQrn9hMU0NYCG5oT7UBBaO0ESMqRAmnbykMBZ8WJd6UREBfBIIHjBy1N/1ZYIeopN1bnaflXl+k57DyChu4OieC3HDhXQv26YD3PeMPc/VxvnQ20TA7X41l2Cw5RDAQLGOj6oKDH2QgyNHSIw10EhsqIN23SZDt9DHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791775539; c=relaxed/simple;
	bh=58BfruVieXdkUQVRo0nRTLW8uXpz5XYNGUgK2z/LmOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mbeNsk4SKO5fsBxhCkFU6VJUg4P010oCBWQSqfsFXx6zZYoBjxcmISzETM1SKN1y+J9sYctyxSWJKJLjPtULvPxxLv2wCuQGWY3rPwg4q7NOtT6p8hKqRwki4YLPk0+0lkApzhKsdDu3osJvWIQzyg9fClPNTYytt3QCC3OIASc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oOOJ6D2b; arc=fail smtp.client-ip=52.101.193.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oOOJ6D2b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nBXC2/4aqX75UAS0fdWjJK7IEEqgPI6O1fDB/IVSUppPPWK7a2PnMpJqMBc0nLDbzSE1yIBYzSHosxM9qQ7VZnkAH97vNWnD+m44y1g63Er74sdp5IElamlpINynrn6D6JuVIW+f5GC0vPtA2Nmsa3DDf7LZKiZmJXcuMzfbGmRt9LZBOmFR4imGhwuwyjCNiz6g0gKOG81u1YLr71dd/yXGrQV3r5ijWg/jIoeoH/pGgQAVcbx0S0WMfI71pVKJ6hr9ahXBwC7Q8Vv5ydYQcnmfoXDaPEVuWqkOq7uilfTDX/GiwMtYMZiNjN/WFOUGxoX/PhuL9s6UwsGDLdLn7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YKcGqWnt4tcMk/6plhW2yy+rPIHOeCgzNSkwOGdCAwI=;
 b=pG5Fs2dSwbIc/vfv3h8VKhMTiodIxT0PwDHuUOY56xfqcyEo9ZBLnZhGsVqH57EVuUeqeh6gxwIzmR5cFujFxKLqvFV5diFEt65shpaS1S/Si3L9EdtyN+8OCMdTHXBUMqIQ19avEHCYLhKPe16ynLAXobXYkb0FE0qJ0OErPS3Cp9dIXD1NRLvZAY6vsphRKxPJNbferryEd6TlqPR/ZtYKwYM5IvxVuCMqsXnEPlv75hD3nnSauUvuUxE0f4Th6EGFDq0mJdYRIPi0Xxf1iEsP/7736z65B0AWhJcxRoYOc0FGUjvQ7R4zrkotZj37uBMLyw5Dls9tRD6P2Desjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=arm.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YKcGqWnt4tcMk/6plhW2yy+rPIHOeCgzNSkwOGdCAwI=;
 b=oOOJ6D2bE6uwvYNFxgZ3hsXCHnQtxup9nt6mZmqXDlxJg8in/L7jgphK2XMULxrRGxVaIhQ9ipUtfekiZIsujAiatBClTnTwDC2DIAAusBd2RhtWg6EIF6aZpCzk3XoCmVqA92JXCigE7MubscWKtrJHerqQz8g8e963ezz9IoM=
Received: from DS1PR04CA0015.namprd04.prod.outlook.com (2603:10b6:8:243::12)
 by MN0PR12MB5811.namprd12.prod.outlook.com (2603:10b6:208:377::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 03:25:34 +0000
Received: from DM2PEPF00003FC6.namprd04.prod.outlook.com
 (2603:10b6:8:243:cafe::90) by DS1PR04CA0015.outlook.office365.com
 (2603:10b6:8:243::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Mon, 12
 Oct 2026 03:25:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DM2PEPF00003FC6.mail.protection.outlook.com (10.167.23.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 12 Oct 2026 03:25:34 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Sun, 11 Oct
 2026 22:25:27 -0500
Received: from [10.136.45.168] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Sun, 11 Oct 2026 22:25:21 -0500
Message-ID: <f791ad72-6b23-484a-888c-6f493edb2e7e@amd.com>
Date: Mon, 12 Oct 2026 08:55:15 +0530
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] MAINTAINERS: ACPI: Add a separate CPPC entry
To: Christian Loehle <christian.loehle@arm.com>, <rafael@kernel.org>
CC: <zhenglifeng1@huawei.com>, <zhongqiu.han@oss.qualcomm.com>,
	<viresh.kumar@linaro.org>, <linux-kernel@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Huang Rui <ray.huang@amd.com>,
	"Perry Yuan" <perry.yuan@amd.com>, Vanshidhar Konda
	<vanshikonda@os.amperecomputing.com>, Shubhang Kaushik <sh@gentwo.org>,
	Pierre Gondois <pierre.gondois@arm.com>, Beata Michalska
	<beata.michalska@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ionela Voinescu <ionela.voinescu@arm.com>, Sudeep Holla
	<sudeep.holla@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, Jeremy Linton
	<jeremy.linton@arm.com>, <jonathanh@nvidia.com>, <zhanjie9@hisilicon.com>
References: <20261008212832.354382-1-christian.loehle@arm.com>
 <20261008212832.354382-3-christian.loehle@arm.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20261008212832.354382-3-christian.loehle@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC6:EE_|MN0PR12MB5811:EE_
X-MS-Office365-Filtering-Correlation-Id: fc61dfa8-e29f-4f13-964c-08df28107a05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|1800799024|7416014|376014|82310400026|10067099003|261009223027099003|4143699003|11063799006|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	ZoJOcMXFwGzz/5XAFNS5VxjYW//NS3bVzUP6IPucW1CsZ7e4O8Kitip6Ah5unLGzuR2QGIgZN946HH4ESemmIg4JpyfdPY5gvCAZKtwG9IoPJ/UwJQLbyHyvLvBVQl/mn0XDuvAK9zC+zxfAXs+cxcNnVp8vbmVAIJ/LZtWvetCgerSoVUVXTAGLTozJFtcZnReHKN3CiwtzZX46a6l19vLVUGOyt5IZpT3W6vrTzHJmNVlo+Msq22veZeWmEz88q/U81TDaKTTjsFpUwKlujav60fLKNx20/vyDnoAf2QdI4jG7CzHeG/ElQsSjykV300+JJJlsHXvbYHR5ldWQclVDv1BQAO8WXWIK/qb1f1K8K03PRhmiMKNc8UoniwdCjCoNN21wPe67tG7Akaea1BZo5nWkTlOaIT1wS0MG4xgAkW1jY6Ml/icj3OlCHwQ+taT3/6d/ELbmKKLuAKx+80Sa3VaFiFZWb/3FMawhga2x0FuQbTEkS6vFFN9A7J2BTUgf+pmYtOZXEkWc941kp/VkguoLfb0agMkMU+GOavZ6vR5TAMhXmjnerJfubY4W7o088NVfm2x7CEB8O1hGneBT3rhJC5uHCbSa5a92FDuJCz1q67Q5QgLpi7+3KWE59vfj1+tbgYdbtLk0SnkFsF5D/3GrQMxrC7QIJnjD+cYnW5dYz47N5clBTQ6bHssByy0m2LKjIrupF0yb0APycA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(1800799024)(7416014)(376014)(82310400026)(10067099003)(261009223027099003)(4143699003)(11063799006)(6133799003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QDdaBALkAphlTXvAbmwvIJVTGPJyIAEDmEaCRealfadOXYRyK9JUQznuNsF4/F31BZwkzYx2K5fT+pyzS7KbtRRL7HK/3tk+UgoL2PxJ+tWGjVna57MKbn8oHu1Nsh78TyOWsj0dxAbYkfDEb4bkCCYnMM/k+9VMlPDZgPkbbP+aXtVho19fd+T2y9sdvIy8x+iaqbjLv0ij0/af5XL4P4e6UZmobQlRW/eliLKYPEuqxcbeqIczLYAtyy4ysQ6rMD+pevlagJFbbCNuCz9i0qIz8JpiOw3jAVxjwD/HeMNR9fz+5UZAQlAqVtFw4mDh4WqHV37UvfmJEjEhoPCLhvyZVnHhJJeo+HFl5AL2BBoexbGLmOtKh9pjLuQVaMXwF+kYwu+Cwy/mjhkQZHItb+9GqS5b6VsbK52Cwiq7bxNG8sGKKVbOv0PUmlK512hk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 03:25:34.0876
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc61dfa8-e29f-4f13-964c-08df28107a05
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5811

Hello Christian,

On 10/9/2026 2:58 AM, Christian Loehle wrote:
> CPPC is a distinct part of ACPI, with its own CPU performance control
> semantics and register access mechanisms. Add a dedicated MAINTAINERS
> entry to help direct changes to maintainers familiar with those details
> and the various platforms implementing CPPC.
> 
> List Rafael and myself as maintainers for the implementation, public
> header and sysfs documentation.

Welcome to the driver's seat :-)

Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>

> 
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> ---
>  MAINTAINERS | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3064942ef05c..88e3bcfeedb9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -327,6 +327,17 @@ F:	drivers/acpi/acpica/
>  F:	include/acpi/
>  F:	tools/power/acpi/
>  
> +ACPI CPPC
> +M:	"Rafael J. Wysocki" <rafael@kernel.org>
> +M:	Christian Loehle <christian.loehle@arm.com>
> +L:	linux-acpi@vger.kernel.org
> +L:	linux-pm@vger.kernel.org
> +S:	Maintained
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
> +F:	Documentation/admin-guide/acpi/cppc_sysfs.rst
> +F:	drivers/acpi/cppc_acpi.c
> +F:	include/acpi/cppc_acpi.h
> +
>  ACPI FOR ARM64 (ACPI/arm64)
>  M:	Lorenzo Pieralisi <lpieralisi@kernel.org>
>  M:	Hanjun Guo <guohanjun@huawei.com>

-- 
Thanks and Regards,
Prateek

