Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.24
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793979768;
	b=Rp8UxI1T8Hos6XnzRnCjQbtj1UoLWGDbYbstLn200F/1ToYWzfN1a8ymVPS5rD5Q14sb
	 tqpgV5vSD609vcTYoMUhbue+aiTSQQzIICGgo6EqURlcE8is6ms3mmKzw+AihLllmiDo/
	 jw24HbPiOlX/xdsvwBMVCZk75xqSM5r81OeDdW+xdqd+utV5lvp5ZgUstwLwgpManWxkk
	 D/4pe4jnLjxlEd9HdrY005dUnB91qwzFfVyFSGLiQZzdvAnC1K4VHDKGXwAi7Qco0K5Ef
	 xQMk5/1xemhDKRYXW05UVqpkVtge93N7T5bD68C32giLESji1WuCq+47gtRbr5GzitA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793979768;
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
	bh=Hj6ebMK07zlV3s5gIZvVBVEZOPqPgvM5+76waFNyUSE=;
	b=eqFhfesYI9DxrCVaEKajKBsswLrVO3FWI10YshU3dnvqov80U7vpJMwygHAxhT6bhrmn
	 7va33r3YQzSA1zN7ilKQLtFABsko9FuguBg/xG2cHrWs+x4gJfx3+1ibDbyr04Sd7Q7tu
	 24DTuXpNLHR/lWa/Wjku8lQDSL9Wnp0cbA3z68c1wFqu4Rm7JWhHpZYHpmblpSfsJZF2l
	 UigjMCxEv6GsdiC8bd83j/TBJ3JW9s4z+yMXPphneNJZdSxDK767z5zr9FQqc54JaUZSp
	 W42kk2R5rX0YV+1rFqHTkiIUy1BLQYf7YFNpTKBamF5p5e3Kqs5tjdfAyix/jIRrPzw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=QuxMikds;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.24
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011024.outbound.protection.outlook.com [52.101.57.24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DBA606A326;
	Fri,  6 Nov 2026 15:42:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83DBA606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=QuxMikds
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FRDqApcGy+jMYbkZgEF35k6bcbWvYx8Uxg7OfhOAywPZZsMK1K8XilWM58rXa6nh97Q0TxNo9Uay6zKFm0GGfPkopqxNOzeDVxDlxF3GS9WzaaBqSppT3udLKYiS3o1yHqh2itjnxnttiHagojlMmv8nem2L2SBskrEKG6CyTWjOE5v3h3KbAYYKNM6xkns/ScN9rYeITXV3yI3YijXDvnHImCbW/GusKgkVHavGPty4rgjGTfXnAXcl175cea7yAZb1wg5zWW9E7XpbwHcYv/rXy8kyjVYDCR1ngg/8+G2kdy8fw5yl/TpQ0IBYn+HSoQQqRw/6tKqHGFT1g2YtAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hj6ebMK07zlV3s5gIZvVBVEZOPqPgvM5+76waFNyUSE=;
 b=vRmYasD6GEknNIXobyZt6ArNqmk3KX948TxoUauVQ0RRWVEb1cPhflXPsHTLseeBWKzT12+L0Uy1tHDjOL1yPSG4XoYWsQBW8Gd9RV4tpWFAnk6EHwiDv8wg8nzq94JxswTN7OfHlDkB3iGE3/ToY2w3Wmhfpf9jHvB0cZ4GY7zGkswyBb3wAxC491G9POJbOAcM6T90tsx3wk3E8qLE8UOM/DBYF2TNkgt3Q/b0slKQuHwWu9QcRiUDyAQdxjqEywJiZXQUbyVMBFx0I4mdXLmK2bq9Qq4F1AmmgmZclq6YUYX3X3//I2JZBAQpKO/wV0QWpcXeiW4/wiG+FoFbww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hj6ebMK07zlV3s5gIZvVBVEZOPqPgvM5+76waFNyUSE=;
 b=QuxMikdsvzXn7Gi6H3WZqYn3Ub6WEy1kooaI/GH2KYyI5m2HbVXGunmiZJPez0cTZZlIWR+J4xWj64BSDiw76gnInrWVkBds1wFbcdFRrySP/8HF7aoocrPBH1KyEYVHnvqO+Ioki62iylfjRmUDfrCzRKh3Hm/Xo/Gkc5yssZicbXRmDI7VeD3LuQCzYvGSGLwBqqnDYHLPqKbw06bmMHjd+EyZQIQkOO10T6GARHrNNb2kygKoqejKoish40T9X4C3Aw92ohWMJTbjlceAHMd/eRpBAiK5yGbh0tVApJ9/dZH34PwNW0oHLuS32RKYADfsNtwkylgWduEauw5wBw==
Received: from DS7PR06CA0038.namprd06.prod.outlook.com (2603:10b6:8:54::19) by
 DS6PR12MB967764.namprd12.prod.outlook.com (2603:10b6:8:4fc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 15:42:41 +0000
Received: from DS2PEPF00006E24.namprd05.prod.outlook.com
 (2603:10b6:8:54:cafe::7b) by DS7PR06CA0038.outlook.office365.com
 (2603:10b6:8:54::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 15:42:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.233) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS2PEPF00006E24.mail.protection.outlook.com (10.167.23.217) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 15:42:41 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 6 Nov
 2026 07:42:27 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 07:42:27 -0800
Received: from dgx-1v-42.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56 via Frontend
 Transport; Fri, 6 Nov 2026 07:42:27 -0800
From: Jamie Nguyen <jamien@nvidia.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, "Punit
 Agrawal" <punitagrawal@gmail.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] ACPI: sysfs: Expose BDAT data region
Date: Fri, 6 Nov 2026 07:42:27 -0800
Message-ID: <20261106154227.1445127-1-jamien@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012230632.3574987-1-jamien@nvidia.com>
References: <20261012230632.3574987-1-jamien@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00006E24:EE_|DS6PR12MB967764:EE_
X-MS-Office365-Filtering-Correlation-Id: 747c96ea-2538-4dd5-a712-08df3c1c9822
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|18002099003|22082099003|10067099003|13003099007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	xIYRm7iEdvPlEO+khPN43UW1D1YdkSoey/es2vkqQ2t0nVWb/C+HuZIi35cGXmcWjnOuF6gpJIbJznfOZ1pwNCGXxiKXMm6NbOaRVP3VFSo101cYRtZzRkfcYuTIukfrYc1nAUV88UKOJdH3KvZNfcQgPh3WNNJW/TKeIj+U3vgnfxk4v6GlAfnW4/yTLdjuYZhz2L9AgmQ2kSJP9khx6YAbRX0PDRzxX5VR8CnZs9xJ9cU1pdXu/7KV9byUVFkCj52O4IQvoVz6etwkadBXLm2mUR+ClEcDH+ChqfUvpkqJC1UQ0/0V4OzIEhD5FZXVraHd5LoHC20ciKYvT33xP4QUpnCHjWr80RPM7JFWvc23XlaDCzpcRLv74mRt37U+ZNj7C8QCGqs8dXEBlESyUj9+5OZQ/X+/h/4KLkaoZCu0HBgZgtRtgXCi7NceRpjM+9bkfNfvPnytNN44kZ2jENjvUZmrR8zfI41zIjVF8oEgtn62oMo5N5VN/kNk6EkGgXtsz6jUerAHq1QKKYGK34fbPaOB/lWbBzFuBOB+5kR9zohgrmTkCOzwUsJscrXbgwRKQ0/L5gZxhTkgR6/6FP/r5RQ2GxgcNvHlClLyWEOtsfDP1UvKSdM8apMVQ2Mm3ZRyR1tpmj0FK19iBJDaGc8mrv1jDAv9DLxI9fjSKWwYowdE6+BUXeMdPwqzBIJEjrbt6SvC/FZJsx+QGUm/eg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(10067099003)(13003099007)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3C5tcnsLJIZliMgLi23/z7ckMWtrl5PER+4yi8oM8zoojRheMiv/v/QN65Lees7LICVaztvoRglKr009L3DZrPmQAn61zCezmt8gc9LfuJwZUX0LHqg+Z6KxZlfWN1QvR1S+6wjiolRI3/59yC0tR+Y0w2EJXodeJ/ghCrhPmgmGJvBu24zy9MAyzZoCVgSsrM81i3ixqkwYaEtQgowAEO4Y6u73EDoOjiF+T3EvrNPig9VnALTM70cM924yk3LNdhfgj10ON7HDsYSGqliSh23+lcPtQk2LilZ/NLMNxioKJJOfgh5cviSOVAoqsmqRvtIctOtWjBLEunsnlVf4+FxzHoaADZZ4sUqo+EBPTgyctlWXYT9Tl/aTcgtnvMjpy76mpN4jm7wlgm0gXGyckpHzagF3soEHhE8BEhMxOKCY6vkrHXJLnuDFqcWdXWar
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 15:42:41.7687
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 747c96ea-2538-4dd5-a712-08df3c1c9822
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00006E24.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR12MB967764

Hello,

Gentle ping on this series.  It still applies cleanly to v7.4-rc1, on
top of the two Sashiko finding fixes [1][2].  Please let me know if
anything else is needed, such as a resend dropping the "Assisted-by:"
tag.

[1]: https://lore.kernel.org/r/20261013180728.957618-1-jamien@nvidia.com
[2]: https://lore.kernel.org/r/20261013193900.1258808-1-jamien@nvidia.com

Jamie
