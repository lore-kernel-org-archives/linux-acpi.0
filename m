Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013045.outbound.protection.outlook.com [52.101.83.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBA244B692;
	Tue, 14 Jul 2026 12:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.45
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784032444; cv=fail; b=bYcn24UTbjHJQWXxHTem4Eom+LTkHiffN8Wh0hYA2LKzICiY1cZKSGqZIfFmKGA0ndL8+Rg54IrPSKRujiD993PWV+LFnmxjHeGheJHFG/0Qoeii5+7GS5fMJ61255Zndt95IvLlQfh9qcK2EKPU83Uhqfy7jNfgDKhoheJ2gJc=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784032444; c=relaxed/simple;
	bh=8IiMli0Ua/DNWmemDKga9tYt+X2MMIyEYG3+uFNJPYo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rYDJ5uD4IDlGA1sEVLAcX3n5AKK+GqV9fMEN0C4wR2vwhtXCztoXci8pHDJxxYdU1Wod2Mg05QplRhKqYxmFYxeLGrClq3cj07Gw8D31oOPrNdmuX5TpTx/mq5gZhO0rduklVt8gw60WckoHvGfV9KTpMhezokSzaw6I64Uvzxc=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=fG+X+EJY; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=fG+X+EJY; arc=fail smtp.client-ip=52.101.83.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="fG+X+EJY";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="fG+X+EJY"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=JTfReQzDtCsnZi5pwFK3czOGw+LvPFZ9IjdnhMkTEJh4S1dZiG+yAL7FH7kY0xmNBQeQyGB0D6nLPMNB7e+SEixTeIf7B6I2wG9ffDsWHZtZUiQL8dPOBcERFZRsVz82M5RhuZC5H0cvqKGPRzO4fFb4PCt4qwQpqBHGPhUJwjG+resXj7IOg82QThI40yk39m8iuspv0ex0EA54/NIlJdf9S7ZZ75egRNYFQKVYwdwGaISB9eyUTX4vUrbMikM9goEQH/U0Xq/cimYMmP0TTe+kkay7JbIM9SjbcWKlqtRsY6OO8A/cyTcZTBO4nOUBpvvprSQxW8nopdtoyjp2rw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+D/Yogmb7QtCVRCVk/4EUgSg9WRRvAhhsaYx1LDAFds=;
 b=dnMM6n77Pi20q0+ggSKoZXN2G74RoBC2qQcnQL/NkauNE1puREgBJDqVAwebSdJTY7sTLDeDpwkvsmURIcsDyxWdvt+LCSozwcY1u1C+Q4ogxsSmWj/3cAxzJ7UBPSCxsGFK2CXVFxeX8Ar/lJUY6UnxXBDBgB5wNRR1HjaJPqhWNwpyqTntQBrFzq74FTB68NPNE7MCHyqlNlVpZIgSYKE3b5N0EAOsepGHyHAlJyEPFM3dljVbFilYESVBONreq+KxeKBXv4ygtxZ2CBiKHl+8honDjwIWB45otOptU9pz5qeSL0B32d5gdRj8ug8XDmWBJqkCg7KRWYx/MvsQcw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+D/Yogmb7QtCVRCVk/4EUgSg9WRRvAhhsaYx1LDAFds=;
 b=fG+X+EJYiNRIaYGFmV5Hk1PQh3ne2Zlufjz1vapu+24uzgdepcphjJrC2nB6q4SLuJdDD8jZKIV0FLogvwLHiRYchQI7GW2HeVC557mcCAci2dNxBpIuWBi4bam2Yc70Jdto412zMg4THcchQvIC22RmaA88T6ZGHd0XuV+qNuk=
Received: from DUZPR01CA0317.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::27) by AMDPR08MB11306.eurprd08.prod.outlook.com
 (2603:10a6:20b:71d::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.9; Tue, 14 Jul
 2026 12:33:49 +0000
Received: from DU6PEPF0000A7E2.eurprd02.prod.outlook.com
 (2603:10a6:10:4ba:cafe::53) by DUZPR01CA0317.outlook.office365.com
 (2603:10a6:10:4ba::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.10 via Frontend Transport; Tue,
 14 Jul 2026 12:33:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF0000A7E2.mail.protection.outlook.com (10.167.8.42) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.9 via
 Frontend Transport; Tue, 14 Jul 2026 12:33:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rDBeiD9DPY6uOjtumavFQ3KDvh+eO77P26jUvyF6Lq9vCSpRpYvgzjtWL6KKWcCWEAx8CeWUckw/y8LP30dtf+mldLXZlbkful7U4ug+/qSW4sQ/SBTY/vw9XcmTu+G6RN0+POlurSWSfp0KwwZ0zqdXuSgAeCulw/lpN/QYTzb2keS8HvLeOaPPGFw92f/Ex1YnHu8aQn3ntjQ7CFbyLYIzlHrLcpOj+6vllK9RLLHpuO3jIZ4r1l1HkM+FPg0oUyI3vA7tTBs5+dFbH9ieOxX/4Ios3oidEMMCcdPuTZjOXovySTwhjTZ5DCdKVsbvZ0rJTI3HJrCM/Kjp4Baj+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+D/Yogmb7QtCVRCVk/4EUgSg9WRRvAhhsaYx1LDAFds=;
 b=xLs+gmbQEENx47hnKUEAVpwkL68/zAAXmyNYRQ+JbKra+opxNpyMhwYMWE6WZqBTPh5PkvLyAEtas1J/hmxDi3Nfq3AQQR9sEaYIJtDItIkRs524PP4am9j1nUZxZqzDSJUWnfU7j5PCyw6dJ5KgJd2xiAHurwIaKa07XIlNJ3UsALjiGicCnBYjxlLVkLVanwgvMg7p8EBhcUo2++eY/jIW+Kvy/ewULbhEGrOBPkOuoC08v1fv9cbcKd3rQL1gzrgszXyGYV/s2ZVyX8+tgtAY4SI2S//HTtbCX2bVo286sUymMcSnPC25wTEFefYihSjZmWvdRKbgN14ittyB9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+D/Yogmb7QtCVRCVk/4EUgSg9WRRvAhhsaYx1LDAFds=;
 b=fG+X+EJYiNRIaYGFmV5Hk1PQh3ne2Zlufjz1vapu+24uzgdepcphjJrC2nB6q4SLuJdDD8jZKIV0FLogvwLHiRYchQI7GW2HeVC557mcCAci2dNxBpIuWBi4bam2Yc70Jdto412zMg4THcchQvIC22RmaA88T6ZGHd0XuV+qNuk=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7626.eurprd08.prod.outlook.com (2603:10a6:10:30a::19)
 by VI0PR08MB11197.eurprd08.prod.outlook.com (2603:10a6:800:24f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Tue, 14 Jul
 2026 12:32:41 +0000
Received: from DB9PR08MB7626.eurprd08.prod.outlook.com
 ([fe80::cc66:a76:1104:9f50]) by DB9PR08MB7626.eurprd08.prod.outlook.com
 ([fe80::cc66:a76:1104:9f50%3]) with mapi id 15.21.0202.018; Tue, 14 Jul 2026
 12:32:41 +0000
Message-ID: <9ac5f187-ff48-434b-a1c0-7f73b442083c@arm.com>
Date: Tue, 14 Jul 2026 13:32:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 16/16] arm_mpam: detect and enable MPAM-Fb PCC support
To: Andre Przywara <andre.przywara@arm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 James Morse <james.morse@arm.com>, Ben Horgan <ben.horgan@arm.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Fenghua Yu <fenghuay@nvidia.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
 Srivathsa L Rao <srivathsa.rao@oss.qualcomm.com>,
 Ganapatrao Kulkarni <ganapatrao.kulkarni@oss.qualcomm.com>,
 Trilok Soni <tsoni@quicinc.com>, Srinivas Ramana <sramana@qti.qualcomm.com>,
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260710144520.917375-1-andre.przywara@arm.com>
 <20260710144520.917375-17-andre.przywara@arm.com>
Content-Language: en-US
From: Niyas Sait <niyas.sait@arm.com>
In-Reply-To: <20260710144520.917375-17-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0501.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::8) To DB9PR08MB7626.eurprd08.prod.outlook.com
 (2603:10a6:10:30a::19)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	DB9PR08MB7626:EE_|VI0PR08MB11197:EE_|DU6PEPF0000A7E2:EE_|AMDPR08MB11306:EE_
X-MS-Office365-Filtering-Correlation-Id: 823dd9b6-8a93-424c-4d6a-08dee1a427c3
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|921020|22082099003|18002099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info-Original:
 Fw0x9R3FWrA9qf3DmUCEjcWZKBBtwMZoZKEILnNBj4bxzSt4bbz78wyFcDoXFJYtXgl8I/Wwh9JWV036fUWEucypLUozHOspjmGbUpD70I18i1e/PTrhPSy8v4zhUc4qNKydqSdaHIas3noERewofA70Oig8SbIzruM/CSAY9ZYEBO/jNHmESFzdrqO3Ye4M/6SA9ly0qjoG+n7cToPoqvnVTT/F8XRoFDiSSWYADi2/jDjxiJQ4YryRP+jR/PRkMwHvX99yWYeLM//S7KeeGo2gXEyH3FXLZ7aDWFslsoikUsI5wtrp8swJydAzafKEysHwvkdgdlgL07q1KMILuZZakHNkglyFDrZefx5DjOSnRasX0xfxbzH4ZlZ7m1eg/M8feZ3dZDYXwiWAX8HuJqE2zw+qsJY/qmFGFnyHD8yWMA31XrdRM3vtwUkGjFiC9T1jfsRhRC34GXrn32AE/DkG8uSQo6op2x29hcG4ftu9cDL2whCTzT0j+hUrFKDvtZm9DFDZEjKX4WlbEEa2QOUtt9fd9bZUumf0mxrFDJGScN1ZoIWmgJzCQKHzzuUu6zjWksLXGkbSEosHTRYLHlY4n81K8HheSqWYf4Fh8kP416Z6LP15XVpEyrSSpWgm3M1UouXeCHU85EW7YYUwlSS/YrbYNOZyS5oleWsdifg98JyiKYZFPeomv2uzvl9Ejb+u5BMdU717TXciB38XSg==
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7626.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(921020)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 cpO7xyI0PKAS6vje0y7i8dDHoXifvWgu2VOEFpx1EuS3dnA2ix18i6n/gNtvJiRrXYythssMwnS+WO9EFoUoQ91znX9ehLiysP1wU/pHYfZAYXzy6LePpAMHJ+mPky1T0KV+2QAwJ/9eWnMRC18MOOgaCpqmf9eGfbr+cDigS0vYKDk2nnq0mu25RMFcwzemGcGJjyheDfU9cCul6SgGu/lLVVlP3K9Zku4x9dRcRKNlhM7T39ChuBMiAoiNcfofanCzGi1uxNoRMyqtugHydlh8EW6rQJXZBtWPzsffwQuptWtuI93Z+tgkfxA2QZlZKHEIQ+7pLtwWdNnM4V7HhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11197
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000A7E2.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	ada117dd-f014-4c25-b5ff-08dee1a3ff51
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|23010399003|1800799024|35042699022|36860700016|14060799003|56012099006|11063799006|4143699003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	WS/1jtmpBzTRcE0K3QaCENYzV6i79PWN8wZYpqbQav1fUYfcPj6VcXzzuBo00RU8GjL/jQkigvEEp78oTMG005HxzLKzOOKTyzmdhquocHysFGezyHh/JlGtWMstpIRdiF4XhmgP7TERHlD4waXhK06oD/XY+DNo9FZtx8CiR0hLdmWkdGeCfjEC+5ZNz1s+9dOqh1E90NfPzGpar2pCieB4bhI8y2mfBJd7sjZ9Id+FAbXo9E2PgwJMqB+K3yvvNk8iSbDWDd/JdRNI06gIpH4UKbdVxiF1iir/o5JF+T1hVwGdD7ygPZCkwSAD8EySswNHPumwFTUzmM1zqMujqiNvSistet3KU8RxfYsaHl5VKeDcl2mrdqIJV3aQWKWMMUNma8vCEAY/RVbyJJsGKNTE7Mj9gyGc9xtyB7w8OQ/BH2srYjgotlA8WM8raypQZ2Tskt6McGc9uWvSoR9xV2Cf8CrVx4h2mQiBhbfgNi9ngTCNwdJmvKg9QAcvbXgDdA3aDhrp9Gkdn3MuRKyOlQVnpBsevbxKo+/KvodAp4UKTg1NWdZPwcJkOY0iAnRs07eht/5m+2nWfJWYSRej0PZ7VhMX5t4WkqlmhJxLw+VVPX90rKHl917+UgrsFtyAZUkwCrhAmswlfLBka5RXAwlZutUcrn6qvNL4wF1kulhUYIBSl/keNY2+h47qFK1vQ+0IpRuSioVLElc1z26ggkaDOr+K+sbtejRDGCa5fR2fYn7lic0JMhzwqX481Uun
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(23010399003)(1800799024)(35042699022)(36860700016)(14060799003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	L3Czx3P4QVyko5UD0TnF/FDaJVc5aVRzp6x2Y12RspagBy3Lz3jpf9yVHKS3VD2wu7Wdb7TFvX0q37Ewdt53z0gKWwx+NnmmCXXaLRsy9yA83STVqQJ5ZnbJbZzFrtmzhzW08JcxqX1MJQq1YE4RIVVdenAPbTzP0NIVu/AqPkP3XkBLqkGYZ1ECH5SWiCciXqdiK3uaBT68awdWpehfuaspYO91sxIbZ4ORoo/4BIpmaMDykWKuiEQD5JMOTydxK8ToDAWscykcNazGIes5OftO+sW/eq/Ko2m9ERw1/LdAQ/4EkItiNDNLOcUiYeJ+8cGttyyceu3jukVf3aUYNM3Bpbsc/nQU5BSB5sMH2AWcCnC81bSW7UVDoC93b0SSfQiw/E6maPMlydzKGSvBDNOiIoJ/Ld3/pU8CRi/5U2E9PoSy/X0AMzl9jqwhZ9t9
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 12:33:49.0167
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 823dd9b6-8a93-424c-4d6a-08dee1a427c3
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E2.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR08MB11306

On 10/07/2026 15:45, Andre Przywara wrote:
> +	cur->pcc_cl.dev = dev;
> +	cur->pcc_cl.rx_callback = mpam_pcc_rx_callback;
> +	cur->pcc_cl.tx_block = true;
> +	cur->pcc_cl.tx_tout = 1000; /* 1s */

Should this timeout be based on nominal latency reported in PCC table 
instead of being hard coded to 1s here? May be some multiple of nominal 
latency reported

Thanks,
Niyas
