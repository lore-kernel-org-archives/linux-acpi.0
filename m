Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011003.outbound.protection.outlook.com [52.101.65.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636AE5474F;
	Thu, 12 Mar 2026 12:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.3
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773318307; cv=fail; b=UdcVeg/CWvBm2kkvazFx7KGywARvIrilihQelsBsMx93twGsPI2cVMT29c5Lg3fRADCT6O/iDP8KVhYEAyI0mE87+08ULqqC6d99f2FWT6MCirNSnZgwf0omEwvwIr9qs9z1mFxsaK4g7Ss3k1ZlNx5TnLAy/I3rbJnLP8k3IVY=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773318307; c=relaxed/simple;
	bh=tUjWEebliLvI6MwAAtGr9F5o/+S6ZybAFkSrCpT7fWM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D2M6qJCSSFPFB5xgFrOargE0IwkaIQUe46lFTTw9zVzVf5ehP6UyPqLN4kR/6xjbHdgA2ovtbmZ8QYb09B+QqOD/k9caT0aXIT0DIVvfQTi9+4zQZZ+Ypm7HFc1pnscPd7XQkaoz6KdZRyXz4wcj6pNrTHhMWXbXvSZHENxCvOM=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=DHRS0PN6; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=DHRS0PN6; arc=fail smtp.client-ip=52.101.65.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="DHRS0PN6";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="DHRS0PN6"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=L7VhD+dWILsaPhNS47CJeNRSrVFCa/UusjkkuFoEXGkWyfjH21vIE+3Rfw5ZPOsKKIrmoxGV+J+/aZRbS140oBq+Rj9lkwa/eXP5tLvq0FV7T0f2hUT/XEYxb8PHd6DFpmxitGj+W/6drYKd5znsWmjTn+iLnh1FL3f1gxifWl4ne0AJMUi0M8g+++60WrWu5M5KJo8RmUxhugECVHj9u6Ilu0E0kAxFruqDuC0IPl/2QBBAU/pZSmPcm2dO3PTzuZ4pBPI3hSkrQenlYJ0H+Bcp8B6SQPpg2U558XYF0O4rVYPZW9Q4pv/QFebNkZ2fKYc9Qf2dObVfb7nKe8hc5Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6aMI/mTg9wW2n5ALbgftnvbEcBsoJN4eJu6ca1REITk=;
 b=dclnjtE31Ce7vpx/ZD3CwgenElJjV7xKUJyi42b3JWVJVSY3p7wM1Bytrxo72I0d+u+FLUosgYGeEpwdkppQmbTe0GFvsNq4v1Kx2Ccslf3n+OpGJ5FO8N2HBxp7XcskgzxoR92hR/7vXD55hm6BIpHFSIlnS7wvd60HAWzpKV7xPyT3rR16VQxCM34e2CGeAei/HkEV/TeQP9+V+a0CO6+PoHn6tXPME+kx61fOgk8qxuyBMjMNMKDQPncTLlC5j9nF7mRIxRjvbmnnZHE83S7xKSsjvU2xMcAJnGvgZcg3DpTi8/yENKzg+MibX/v51eqFh4y/sv2Ti3IV7t0yzQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=huawei.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6aMI/mTg9wW2n5ALbgftnvbEcBsoJN4eJu6ca1REITk=;
 b=DHRS0PN6/e+ky3pV+BOol9tZN44SOON0gWFk/CAGc/32IhkXoooivmKRzf6HMnkZWQyFlhje+HdZyQh4gUojdf9UY4F001PRdLsCLZuusdZpkYmNbSAaSSVUF6IgQk0EtUS9bvp0XMrRKEJt0Zg5oJxeBlCNFspk3Gu9qp3jyGk=
Received: from AS4P195CA0027.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:5d6::16)
 by AS8PR08MB10221.eurprd08.prod.outlook.com (2603:10a6:20b:63e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Thu, 12 Mar
 2026 12:24:57 +0000
Received: from AMS0EPF000001A9.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d6:cafe::90) by AS4P195CA0027.outlook.office365.com
 (2603:10a6:20b:5d6::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.28 via Frontend Transport; Thu,
 12 Mar 2026 12:24:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF000001A9.mail.protection.outlook.com (10.167.16.149) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18
 via Frontend Transport; Thu, 12 Mar 2026 12:24:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PhAcuy+17cqLh4Y01RuSgNOLhwqPriUntYgxxKQaPshc9IGDn/Qcm4W4HKssVVcnGmduqqKJpbnrN8UcavSjLEgXnW3McgTP1nULgaSkPMADVcDGcTjMkA+I8GhihwsXoqF2K8JYpI3Od/GMeASeuNC0YedYJc/wHkMheYbHIy+w95igYmmvfBAZDPlMmUmp0qv5PChXzEkuKiRa8HkSYcmlSDbV/f/QGaPTmgLOrnngRtlrekqbNUx2nqvkQQClStBXVY2ETgPrR04qG3fSWjUVotm7rjDIkpzk5ig7dJJ852YpVGSTndx2MvT4TGpTsrAGeKpccqjlkTCXT5fI7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6aMI/mTg9wW2n5ALbgftnvbEcBsoJN4eJu6ca1REITk=;
 b=t/AOjxH1vme12cPvI9lhNwvHeC30NRZ47wM2n3G1UXITb0XIKV1KwIXQGgpjwzoZ4P2wVgM3tH3QhLER0y7dQet32dzj0mp9bUUUeOw6yLJ0/+PKJG06sUV/vQXNgANAwGEvTZVMObFWnKd5NA63WJSu7wnyuUzWte9PTE+4UkGACLgV/k0uKC6vhcu7G9eRpnM69vDml3RBQGtHVM8ZwpTsKTNc6Bk5ymZuJQyrQWX4H+kcesVlIRXLO7lfFk6gb3W+X3/U6S9aNQf27QhPgENcSK6fE68JX529r0IjK9GWGasW92pDpctWbMhxPnmXOAcimtVljkaBAkL7XNNPzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6aMI/mTg9wW2n5ALbgftnvbEcBsoJN4eJu6ca1REITk=;
 b=DHRS0PN6/e+ky3pV+BOol9tZN44SOON0gWFk/CAGc/32IhkXoooivmKRzf6HMnkZWQyFlhje+HdZyQh4gUojdf9UY4F001PRdLsCLZuusdZpkYmNbSAaSSVUF6IgQk0EtUS9bvp0XMrRKEJt0Zg5oJxeBlCNFspk3Gu9qp3jyGk=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11823.eurprd08.prod.outlook.com (2603:10a6:800:324::5)
 by DU0PR08MB9300.eurprd08.prod.outlook.com (2603:10a6:10:41f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Thu, 12 Mar
 2026 12:23:49 +0000
Received: from VI0PR08MB11823.eurprd08.prod.outlook.com
 ([fe80::694c:3790:be1a:8ddd]) by VI0PR08MB11823.eurprd08.prod.outlook.com
 ([fe80::694c:3790:be1a:8ddd%5]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 12:23:49 +0000
Message-ID: <4a193f85-e0ed-4367-b69b-587b2cbc977f@arm.com>
Date: Thu, 12 Mar 2026 12:23:41 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/11] RAS: add DeviceTree firmware-first CPER provider
Content-Language: en-GB
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
 Dmitry.Lamerov@arm.com, catalin.marinas@arm.com, bp@alien8.de,
 robh@kernel.org, rafael@kernel.org, will@kernel.org, conor@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 krzk+dt@kernel.org, Michael.Zhao2@arm.com, tony.luck@intel.com
References: <20260220-topics-ahmtib01-ras_ffh_arm_internal_review-v2-0-347fa2d7351b@arm.com>
 <20260220-topics-ahmtib01-ras_ffh_arm_internal_review-v2-11-347fa2d7351b@arm.com>
 <20260224155520.00004e92@huawei.com>
From: Ahmed Tiba <ahmed.tiba@arm.com>
In-Reply-To: <20260224155520.00004e92@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0130.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::19) To VI0PR08MB11823.eurprd08.prod.outlook.com
 (2603:10a6:800:324::5)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB11823:EE_|DU0PR08MB9300:EE_|AMS0EPF000001A9:EE_|AS8PR08MB10221:EE_
X-MS-Office365-Filtering-Correlation-Id: f3359a33-25b2-4eb5-735a-08de80325f90
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info-Original:
 uwNy+hhFBWac9ZFXIkK//QiZVVMgE5Rff76Gs3PaLc6z3I3ms2zxnc17SyBKidK7Bl81mT8UJy3WIiLXewasVLEclsEeR6d5AKKWWRQ/VLKtqySDjcTMYzsr/huDWIXEhWXDRrNUw6UMHT7vUqJHVJ69EFFVMBgfREu8dZbUMPxMKjR6GyvB5ASkvIs8g5Jid/uBsdIPJmuaxy9fe4wtOtaJnQT4Y6KnGwwiDncjKvd9VdlgRxqg6whsk08sfKaJR+7VLepk7Xf+MQEFCD4ZFSS1ya3UVxDt4jums6fPoZY/chGcvpCp/te9AnJKEYNvBylyBFZ69dpnbd7lw5yJdxwTuxj4lMvfphYJCk55Ru5jTC5UZyALisi0WsQi73szfD1iPTkcvypc/MbH08hAcQ9qPakoNlFPoKv8azJ4JBfKRQpSD8GeDkm6RwXUYwranVatyUOHiafkvZ/KqpCcArRT4SG5E6tLKipS3pybk4yJjIfvhneqY/Xfssj1+sME8XO9W8IDO3Sk/Vv9Cff7co9NyxOl0jwgFhodfLu8OoPqX2Bz5RaBVPFyNTldPTczRFnSb1a4IsCEb5xKmPG7MkXjIpcyhrL7zNPZIsrelzuOO0Ci1Xx57bBJmt0ZHgCh9VjSlWymSE/P75Do7Ehf3gZk+L5rDhgnWV/WsUfUUe0+5kuQcFoQJUtI2Nq5jYqbA6ZWnF4zvxDQnr5d8JCXhiG6jKOHZzbw4ze+nSExnCw=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB11823.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 TX/iK20PomtSzE7PVIMiugbqVn4QCsXLvRWFMYB2Vx81ZBm32/Jd1Px9HHpH2YHTmfP2sDujTYdTZOIZyN2H+L6PYo17RgG1sBqW+SFE3b0ChbKlHmOANS5vtQHkd/TNUeFoFRILGrH7qbd6USMgZ2H6xTPBjw3kSEzah2rHO3sHrlJmE4TRedN5ACWEHDMCT/jqP0+qGwqVHYavpTntKe1igfhauAzquR1bECRWx6ZiT/pK02qeSaorMdnV24Fbh/DKeMloHSZf0G8B69ENIr0gCn7xQxXZS5c0dM2UxtHNtyVmPW2a5+PT+dG1xyPCWDeZ157vYRj5awdLsbNtAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9300
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001A9.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	d084e39b-ef54-4b47-3d81-08de803236e6
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|30052699003|36860700016|35042699022|14060799003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	iEdQ5l/E70orGl/i7m6AyoNukf7RgirDhG2H7/vghhW/xzw9wO9kzKGnMLmqLOaap8/8e7nt8Rkf2s9bAiEgjQdH2dUywmjhFBAUpctUw2jY9Rmnr/P79CoBrxSPDJIJxO37S13ZB+QewVnIVkyn8Fm2f+3EqkLIuBKJST+ZP/fEFV1C2FaffsuW/bRls+MtAgfswf7J41DBMAwPflUkH6/ISYz6eS9GspcULbPR+7RVeNtQjpB1WUnuQFN87jY+YfmW2T3MCx9Nq12FbC8q/yp8WvY7NXLRA+RKEGrfUSmyE3xFSynfCOWESpa2Fc1/syrELrRsMvuZhJCgLU8yD5PnCWEY/ldl+m8zwZgym1KhpX8asH1LKYWgcMeji7O4vF/yy3ZWZQwy0fbefm5vXDhjvbEvqqh/OvRo4pJdAnmpc8lobQLus24Z0SCLS8Jp2te+XIasRY8niD0cZvat+dOr7Vbagg3FTtKdNk8n+B95eiBHRwr4aLYY79Lqftxa4A5aDgVpGYkctX4c1lpgomjffdCZl+cgTPlP+K0int2+Uk25gyfhfxOt+vd4oJMl6pVym94CzmpPd++kqabagIV+JbUhP5VLohT3By9oczF2BukNe9qp+P2SgYVIGETpwbO295I7aJUKscVIvftBipGESfIlVUTCSkHDJRaFZjfGZTG6ID/0Lm4+iWu/S6p+e3775f97uPBhyqIVPT4C6y6NxQms6xixfhN94x3QdlRuo65LhAZBU/2ALZWloZOt9Yof8zUiLuQ9dX19rttyxg==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(30052699003)(36860700016)(35042699022)(14060799003)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	G5EYKejkYnbFh0XvMohkgbKvXaE8eJz3icfbtXAftkKu/sxaeVGp7UyMJUhjWVHl02pBYb6Y9W1bQDwFZlLnvxJIXI+CV/noyQF0x52u12V+KeoPGK2otV3NOrKL2SyVGHi4gvMvaXEdnq6h/3Hke5YaYoSohkKmHyxHo2ZVbAvkPC+Ty67eJzTqDYN21oOwPJTOqzoZ3ncAXop1KiB52gJP59gXJhackfp0vegyEhwDR6JSBbK0d0S1I2zl6+JdI1Lji/AtCXdJ15UoGPMH5duHWd8OhXIrckz7yuG5oIWbAi5uQ0tW+RRyvJW6GAqHAsatN9fseNj0uQgCyYZS4Zs5v+e9QciXyRia7+DW2hR7VkMOAm05vKyq0KRPw+8e6H91CktFp0qzKtV6/9LIqMSFBXqwVwVb+pK/k08LqjOYTorfFXxfszi92Nqzp22y
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 12:24:57.2160
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3359a33-25b2-4eb5-735a-08de80325f90
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A9.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10221

On 24/02/2026 15:55, Jonathan Cameron wrote:
> On Fri, 20 Feb 2026 13:42:29 +0000
> Ahmed Tiba <ahmed.tiba@arm.com> wrote:
> 
>> Add a DeviceTree firmware-first CPER provider that reuses the shared
>> GHES helpers, wire it into the RAS Kconfig/Makefile and document it in
>> the admin guide. Update MAINTAINERS now that the driver exists.
>>
>> Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>
> Hi Ahmed,
> 
> Various comments inline.
> 
> Jonathan
> 
>> ---
>>   Documentation/admin-guide/RAS/main.rst |  18 +++
>>   MAINTAINERS                            |   1 +
>>   drivers/acpi/apei/apei-internal.h      |  10 +-
>>   drivers/acpi/apei/ghes_cper.c          |   2 +
>>   drivers/ras/Kconfig                    |  12 ++
>>   drivers/ras/Makefile                   |   1 +
>>   drivers/ras/esource-dt.c               | 264 +++++++++++++++++++++++++++++++++
>>   include/acpi/ghes_cper.h               |   9 ++
>>   8 files changed, 308 insertions(+), 9 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/RAS/main.rst b/Documentation/admin-guide/RAS/main.rst
>> index 5a45db32c49b..4ffabaaeabb1 100644
>> --- a/Documentation/admin-guide/RAS/main.rst
>> +++ b/Documentation/admin-guide/RAS/main.rst
>> @@ -205,6 +205,24 @@ Architecture (MCA)\ [#f3]_.
>>   .. [#f3] For more details about the Machine Check Architecture (MCA),
>>     please read Documentation/arch/x86/x86_64/machinecheck.rst at the Kernel tree.
>>   
>> +Firmware-first CPER via DeviceTree
>> +----------------------------------
>> +
>> +Some systems expose Common Platform Error Record (CPER) data
>> +via DeviceTree instead of ACPI HEST tables.
> 
> I'd argue this isn't really DT specific, it's just not ACPI table.
> You could for instance use PRP0001 and wire this up on ACPI with only
> one trivial change to generic property.h accessor for the boolean.
> 
> Or use another firmware information source entirely.

I'm intentionally keeping the scope DT-only for this series,
so I'll keep the wording DT-focused.

>> +Enable ``CONFIG_RAS_ESOURCE_DT`` to build the ``drivers/ras/esource-dt.c``
>> +driver and describe the CPER error source buffer with the
>> +``Documentation/devicetree/bindings/firmware/arm,ras-ffh.yaml`` binding.
>> +The driver reuses the GHES CPER helper object in
>> +``drivers/acpi/apei/ghes_cper.c`` so the logging, notifier chains, and
>> +memory failure handling match the ACPI GHES behaviour even when
>> +ACPI is disabled.
>> +
>> +Once a platform describes a firmware-first provider, both ACPI GHES and the
>> +DeviceTree driver reuse the same code paths. This keeps the behaviour
>> +consistent regardless of whether the error source is described via ACPI
>> +tables or DeviceTree.
> 
>> diff --git a/drivers/ras/Kconfig b/drivers/ras/Kconfig
>> index fc4f4bb94a4c..ea6d96713020 100644
>> --- a/drivers/ras/Kconfig
>> +++ b/drivers/ras/Kconfig
>> @@ -34,6 +34,18 @@ if RAS
>>   source "arch/x86/ras/Kconfig"
>>   source "drivers/ras/amd/atl/Kconfig"
>>   
>> +config RAS_ESOURCE_DT
>> +	bool "DeviceTree firmware-first CPER error source block provider"
> It isn't really DT specific other than one call that I've suggested you
> replace with a generic firmware accessor.
> 

I'll keep it DT-specific for this series.

>> +	depends on OF
> 
> Generally we don't gate on OF unless there are OF specific calls. Here there
> aren't so you are just reducing build coverage. || COMPILE_TEST
> maybe.
> 
Agreed. I'll drop OF and add COMPILE_TEST.


>> +	depends on ARM64
> 
> Likewise, nothing in here is arm64 specific that I can spot.
> 

Agreed. I'll drop ARM64.

>> +	select GHES_CPER_HELPERS
>> +	help
>> +	  Enable support for firmware-first Common Platform Error Record (CPER)
>> +	  error source block providers that are described via DeviceTree
>> +	  instead of ACPI HEST tables. The driver reuses the existing GHES
>> +	  CPER helpers so the error processing matches the ACPI code paths,
>> +	  but it can be built even when ACPI is disabled.
>> +
> 
>> diff --git a/drivers/ras/esource-dt.c b/drivers/ras/esource-dt.c
>> new file mode 100644
>> index 000000000000..b575a2258536
>> --- /dev/null
>> +++ b/drivers/ras/esource-dt.c
>> @@ -0,0 +1,264 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * DeviceTree provider for firmware-first CPER error source block.
>> + *
>> + * This driver shares the GHES CPER helpers so we keep the reporting and
>> + * notifier behaviour identical to ACPI GHES
>> + *
>> + * Copyright (C) 2025 ARM Ltd.
>> + * Author: Ahmed Tiba <ahmed.tiba@arm.com>
>> + */
>> +
>> +#include <linux/atomic.h>
>> +#include <linux/bitops.h>
>> +#include <linux/device.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/io.h>
>> +#include <linux/io-64-nonatomic-lo-hi.h>
> Used?

No, I'll drop it.

>> +#include <linux/module.h>
> mod_devicetable.h for of_device_id definition.
> 

Ack. I'll add <linux/mod_devicetable.h> and keep module.h.

>> +#include <linux/of_address.h>
>> +#include <linux/of_irq.h>
> Generally very little reason to include these.  Not sure why you need
> them here.
> 

Agreed, I'll drop both.

>> +#include <linux/panic.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/slab.h>
>> +#include <linux/spinlock.h>
>> +
>> +#include <acpi/ghes.h>
>> +#include <acpi/ghes_cper.h>
>> +
>> +static atomic_t ghes_ffh_source_ids = ATOMIC_INIT(0);
> I'd normally expect an IDA or similar. If nothing else it clearly
> indicates we only want a unique ID.

I'll keep the atomic for now; it's just a monotonic unique ID with no
lifetime tracking. If you strongly prefer IDA I can switch.

>> +
>> +struct ghes_ffh_ack {
>> +	void __iomem *addr;
>> +	u64 preserve;
>> +	u64 set;
>> +	u8 width;
>> +	bool present;
>> +};
>> +
>> +struct ghes_ffh {
>> +	struct device *dev;
>> +	void __iomem *status;
>> +	size_t status_len;
>> +
>> +	struct ghes_ffh_ack ack;
>> +
>> +	struct acpi_hest_generic *generic;
>> +	struct acpi_hest_generic_status *estatus;
>> +
>> +	bool sync;
>> +	int irq;
>> +
>> +	/* Serializes access to the firmware-owned buffer. */
> If we are serializing it, in what sense is it owned by the firmware?
> 

I'll clarify the comment:
firmware owns the buffer contents and the OS only serializes access.

>> +	spinlock_t lock;
>> +};
> 
> 
>> +
>> +static void ghes_ffh_process(struct ghes_ffh *ctx)
>> +{
>> +	unsigned long flags;
>> +	int sev;
>> +
>> +	spin_lock_irqsave(&ctx->lock, flags);
> 
> guard() + include cleanup.h. Then can do returns in error paths.

Agreed. I'll switch to guard() and include <linux/cleanup.h>.

>> +
>> +	if (ghes_ffh_copy_status(ctx))
>> +		goto out;
> Like here to give simpler lfow.
> 
> 
>> +
>> +	sev = ghes_severity(ctx->estatus->error_severity);
>> +	if (sev >= GHES_SEV_PANIC)
>> +		ghes_ffh_fatal(ctx);
>> +
>> +	if (!ghes_estatus_cached(ctx->estatus)) {
>> +		if (ghes_print_estatus(NULL, ctx->generic, ctx->estatus))
> 
> Combine the two if statements with &&
>

Will do.

>> +			ghes_estatus_cache_add(ctx->generic, ctx->estatus);
>> +	}
>> +
>> +	ghes_cper_handle_status(ctx->dev, ctx->generic, ctx->estatus, ctx->sync);
>> +
>> +	ghes_ffh_ack(ctx);
>> +
>> +out:
>> +	spin_unlock_irqrestore(&ctx->lock, flags);
>> +}
>> +
>> +static irqreturn_t ghes_ffh_irq(int irq, void *data)
>> +{
>> +	struct ghes_ffh *ctx = data;
>> +
>> +	ghes_ffh_process(ctx);
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static int ghes_ffh_init_ack(struct platform_device *pdev,
>> +			     struct ghes_ffh *ctx)
>> +{
>> +	struct resource *res;
>> +	size_t size;
>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>> +	if (!res)
>> +		return 0;
>> +
>> +	ctx->ack.addr = devm_ioremap_resource(&pdev->dev, res);
> Why not devm_platform_get_and_ioremap_resource()?

Will switch to devm_platform_get_and_ioremap_resource().

>> +	if (IS_ERR(ctx->ack.addr))
>> +		return PTR_ERR(ctx->ack.addr);
>> +
>> +	size = resource_size(res);
>> +	switch (size) {
>> +	case 4:
>> +		ctx->ack.width = 32;
>> +		ctx->ack.preserve = ~0U;
>> +		break;
>> +	case 8:
>> +		ctx->ack.width = 64;
>> +		ctx->ack.preserve = ~0ULL;
>> +		break;
>> +	default:
>> +		dev_err(&pdev->dev, "Unsupported ack resource size %zu\n", size);
>> +		return -EINVAL;
>> +	}
>> +
>> +	ctx->ack.set = BIT_ULL(0);
>> +	ctx->ack.present = true;
>> +	return 0;
>> +}
>> +
>> +static int ghes_ffh_probe(struct platform_device *pdev)
> 
> Consider using a
> 	struct device *dev = &pdev->dev;
> given there is only one device around and it will shorten a bunch of
> lines a little.

I'll use a local dev pointer.

>> +{
>> +	struct ghes_ffh *ctx;
>> +	struct resource *res;
>> +	int rc;
>> +
>> +	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
>> +	if (!ctx)
>> +		return -ENOMEM;
>> +
>> +	spin_lock_init(&ctx->lock);
>> +	ctx->dev = &pdev->dev;
>> +	ctx->sync = of_property_read_bool(pdev->dev.of_node, "arm,sea-notify");
> Hmm. I'd allow for other firmware types with
> 	device_property_read_bool() instead.

Given DT-only scope, I'll keep of_property_read_bool() here.

>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	if (!res) {
>> +		dev_err(&pdev->dev, "status region missing\n");
> In probe you can always use dev_err_probe. It pretty prints the return value etc and
> saves lines of code.
> 		return dev_err_probe(&pdev->dev, -EINVAL, "status region missing\n");

Agreed. I'll use dev_err_probe() here and for zero length.

> Don't worry about slightly long line.
> 
>> +		return -EINVAL;
>> +	}
>> +
>> +	ctx->status_len = resource_size(res);
>> +	if (!ctx->status_len) {
>> +		dev_err(&pdev->dev, "Status region has zero length\n");
> As above, use dev_err_probe()
> 
>> +		return -EINVAL;
>> +	}
>> +
>> +	ctx->status = devm_ioremap_resource(&pdev->dev, res);
> I'd be tempted to use devm_platform_get_and_ioremap_resource() and just
> not worry about mapping and unmapping that will unnecessarily occur in the
> case of error.

Will do (as above).

>> +	if (IS_ERR(ctx->status))
>> +		return PTR_ERR(ctx->status);
>> +
>> +	rc = ghes_ffh_init_ack(pdev, ctx);
>> +	if (rc)
>> +		return rc;
>> +
>> +	rc = ghes_ffh_init_pool();
>> +	if (rc)
>> +		return rc;
>> +
>> +	ctx->estatus = devm_kzalloc(&pdev->dev, ctx->status_len, GFP_KERNEL);
>> +	if (!ctx->estatus)
>> +		return -ENOMEM;
>> +
>> +	ctx->generic = devm_kzalloc(&pdev->dev, sizeof(*ctx->generic), GFP_KERNEL);
>> +	if (!ctx->generic)
>> +		return -ENOMEM;
>> +
>> +	ctx->generic->header.type = ACPI_HEST_TYPE_GENERIC_ERROR;
>> +	ctx->generic->header.source_id =
>> +		atomic_inc_return(&ghes_ffh_source_ids);
>> +	ctx->generic->notify.type = ctx->sync ?
>> +		ACPI_HEST_NOTIFY_SEA : ACPI_HEST_NOTIFY_EXTERNAL;
>> +	ctx->generic->error_block_length = ctx->status_len;
>> +
>> +	ctx->irq = platform_get_irq_optional(pdev, 0);
>> +	if (ctx->irq <= 0) {
>> +		if (ctx->irq == -EPROBE_DEFER)
>> +			return ctx->irq;
>> +		dev_err(&pdev->dev, "interrupt is required (%d)\n", ctx->irq);
> If it's required, why call get_irq_optional?
> That only serves to suppress the error message inside the call.  Use
> the non optional version and drop this.

I'll use platform_get_irq().

>> +		return -EINVAL;
>> +	}
>> +
>> +	rc = devm_request_threaded_irq(&pdev->dev, ctx->irq,
>> +				       NULL, ghes_ffh_irq,
>> +				       IRQF_ONESHOT,
>> +				       dev_name(&pdev->dev), ctx);
>> +	if (rc)
>> +		return rc;
>> +
>> +	platform_set_drvdata(pdev, ctx);
> 
> I can't immediately spot where this is used.  If it isn't don't set it as that
> will mislead people into thinking it's needed.

Agreed. I'll drop it.

>> +	dev_info(&pdev->dev, "Firmware-first CPER status provider (interrupt)\n");
> 
> Krysztof already commented on this one.
> 
>> +	return 0;
>> +}
>> +
>> +static void ghes_ffh_remove(struct platform_device *pdev)
>> +{
> 
> If nothing to do, platform drivers don't need a remove so get rid of it.

Agreed. I'll remove it.

>> +}
>> +
>> +static const struct of_device_id ghes_ffh_of_match[] = {
>> +	{ .compatible = "arm,ras-ffh" },
>> +	{ /* sentinel */ }
>> +};
>> +MODULE_DEVICE_TABLE(of, ghes_ffh_of_match);
>> +
>> +static struct platform_driver ghes_ffh_driver = {
>> +	.driver = {
>> +		.name = "esource-dt",
>> +		.of_match_table = ghes_ffh_of_match,
>> +	},
>> +	.probe = ghes_ffh_probe,
>> +	.remove = ghes_ffh_remove,
>> +};
>> +
> Common convention is keep this tightly coupled with the
> struct platform_driver but not having a blank line here.

I'll drop the blank line.

>> +module_platform_driver(ghes_ffh_driver);
>> +
>> +MODULE_AUTHOR("Ahmed Tiba <ahmed.tiba@arm.com>");
>> +MODULE_DESCRIPTION("Firmware-first CPER provider for DeviceTree platforms");
>> +MODULE_LICENSE("GPL");
> 
> 

