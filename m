Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=2 smtp.remote-ip=52.101.72.58
ARC-Seal: i=3; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794221826;
	b=vUlPTpva6qVKnZGXyfO5mux3WzpWG5OXrk2U3gZfrv68kavWRzKMcHoCSIGADJbo5WEz
	 MfYQdPC9h3Vv0Yxwe2zXL8Cg/7/7mKyzhSFT7uKAA3RKUyMJ7IdFiy4C/kGkhSXnN9h2T
	 tJZHfzpGxVZdV4Zxy9evKOWUSnaYv4xK++PY+fhZ1rFlHqn5Ymf6DEX14+CWRpUdit3ZB
	 nkth0JPpjfS9OarhzGWNsrJsROEiP5tDQCt03B0BVK+TokgPAqjiJtpeks2YyeZEFjqCH
	 ymjtZepsb+BR40trBvlbFgashSLBYM5oV3hJY1Yf6cuTRemBm7U7df60G5xXpz/GdkQ==
ARC-Message-Signature: i=3; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794221826;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:
	 DKIM-Signature:Authentication-Results-Original:Received:Received:
	 Message-ID:Date:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-ClientProxiedBy:MIME-Version:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 x-checkrecipientrouted:NoDisclaimer:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam-Untrusted:
	 X-Microsoft-Antispam-Message-Info-Original:
	 X-Forefront-Antispam-Report-Untrusted:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-EOPAttributedMessage:
	 X-MS-Exchange-Transport-CrossTenantHeadersStripped:
	 X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id-Prvs:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=QTOwRVQp9BlblwR3oKEgIhohgyUaXPcL1zpzpoXzukM=;
	b=t1mlkz15FeuuBgMNPUMDYEWkCpT9R6cFqYdLdAaPHlIv2V3FsVQvtX8hiOYbmpif+tci
	 0lW2Jdbfvl7E98pg+vZWof7/8Go4Zo5zeEzGVVhcw/Ka5EbSDSa/14nCNjDvbOHZ0qUvI
	 KOH97JOtb6IaqW+0Vcg5ZNuZIjECL28wxvzMuQe2lPzH8hS98izsxlwdvJ+eYLISmznYc
	 OQ23mE9s74FcaA7lSlD5Ea3/176D2ijskatEff/HQSba6ViFsy12Ufam0thzxvfOVXpHX
	 e6gP7C+tQTwC5l3R6B6MPZWde6/cRomG5LjDiPN6GGo7wALgV+pugij6Rbv+GHD3XVw==
ARC-Authentication-Results: i=3; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=VDtDLzX2;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=VDtDLzX2;
	arc=pass header.oldest-pass=2 smtp.remote-ip=52.101.72.58
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013058.outbound.protection.outlook.com [52.101.72.58])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60182606A321;
	Mon,  9 Nov 2026 10:57:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60182606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=VDtDLzX2;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=VDtDLzX2
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=H+xDTyO7dpn7llR+X60KY+KADQCAP+Xa+CqX/WDakEChiRC0fmK6yc5TNmjI8A7+4TsIeh24lA3r2BT7vKBMvRoLtgKP0XSXwXKTgYcAYJqiK0V3Pis5R0A6e6rjCbE4JpLVNDYAnnkMKjZEBGT6bDYAOVOwNfDPqTJq/5RijkSSCHfD6DoSme484hShAv58KgKnNim347HHISt72h/5c2sigIfDaSJXoivd1fSumdxjWpo8f+bWxZeQOaE04TC8CgOksw0WnOp2mHhpn2ajKBKPMNv5z1eDDpB//pH794TEfJwbpnbHVWkx78XihhJrT4hBljbVaB1Elcik1M7nkQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QTOwRVQp9BlblwR3oKEgIhohgyUaXPcL1zpzpoXzukM=;
 b=Boj5aNBjcbZJXPcwldDQQrMCozmq6+jY+m3sTbX6L14zD+lQML6+lWhh9GfamxC4JRyGfHcRxrZFDbIMXL/UgzUU4q4MDES7+KI4ug4hRU2BFF4jxQP13es9t1fcTzX590GyZmoEWPQ1+feGcMn20PH+bGQ94UuxYVwz8h7SWVJjKjhueNJDoE8Rd9l4P7YDDobsvOwFlzY+fE9YELKnmnKqFxSjuXFCAv3c0fi2lPwkFl0DxfdOd12qCT1MjuxMl1EEKnsjZ2jU1sUwlEVeL7EuHRuFI4XPhKNfT5vbFbxiE8cKq3Xh/MfM4wXrosxbyuy1hAJ4sSFd7FWq1AbP1g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=debian.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QTOwRVQp9BlblwR3oKEgIhohgyUaXPcL1zpzpoXzukM=;
 b=VDtDLzX26DNg3vIIgHNWYFIr1s7DHmtmLCG95J7Jq3Txvf4Ey5bSMw0jrKoTnULYMC7SYgNMDZ338Mvd3/KXif+Qui/yrOQ9NAucjZYLWAqUsoD4kkzAnrI6MqE8L9VT4Ue7bdRS9R5jxc11wLSh73+42+SzhwZMV45WkGiACg0=
Received: from PR3PR09CA0024.eurprd09.prod.outlook.com (2603:10a6:102:b7::29)
 by DU0PR08MB7637.eurprd08.prod.outlook.com (2603:10a6:10:31c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Mon, 9 Nov
 2026 10:57:00 +0000
Received: from MI3PEPF0000855F.eurprd05.prod.outlook.com
 (2603:10a6:102:b7:cafe::48) by PR3PR09CA0024.outlook.office365.com
 (2603:10a6:102:b7::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.12 via Frontend Transport; Mon, 9
 Nov 2026 10:56:58 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MI3PEPF0000855F.mail.protection.outlook.com (10.167.240.27) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Mon, 9 Nov 2026 10:56:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K8n7UHTvIsqxkvFLnNgMw3sKffRCf5nV1aIKtXiO2NfAtaZt+GNH29L7RSftpoTPLxliNmzDhipy/Zu8mP4cYhZKQ1tccjuxOy7Sa4eBfjMLi3zXLUK4jhrK+7DTSjin1N4avTghR3xltBU6EAWGvQ1tbSOidCArhWSsYssUOJktw1RaBSv+7009U3YqTg3W9Cc8YLZ94hulhkHX0EXOhtsHBJPP0UIEj3sk0hkmVkbCfkCViX3FXqMUexOE4mUkEK8mdZ0ttukWqmE8chNvX/yX7gzEKTy4iLIwCEAd20t4DcBP3S/g4Ciae6o2nr1lx2jL6uzm4yXXM7yf/rZMEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QTOwRVQp9BlblwR3oKEgIhohgyUaXPcL1zpzpoXzukM=;
 b=jf386gIfaxdc2i26bYp6RJfdHY8LC0D8txpj+AC4Pm3D1zIiVEiex09rB9KmQJi3W9dLpVpvUmVNssdyxqLX9NjzQDFHvOsFG477FhRBbHznRRrXSNqO9SU+2gdWqPiQic3FzUa0UzI0p81Jt3ShC4xzdv5R9vAQrjYrLP5tfZgi1jhH9PyZWpV4modjKUWdRupc/mIbhSgbeeIbc7WNLVOeCfIulMhhZQ2m/XLzLyx1fNqD0ohCq+T0riIX+TqFWpGQ5zC5bbE94bD3io9+mpIYw0CKDz2jl17EuLjBUzZ+TXiLRYjLHplzX6oLi4BPyAqDF7jEvj0fNBm8ragAMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QTOwRVQp9BlblwR3oKEgIhohgyUaXPcL1zpzpoXzukM=;
 b=VDtDLzX26DNg3vIIgHNWYFIr1s7DHmtmLCG95J7Jq3Txvf4Ey5bSMw0jrKoTnULYMC7SYgNMDZ338Mvd3/KXif+Qui/yrOQ9NAucjZYLWAqUsoD4kkzAnrI6MqE8L9VT4Ue7bdRS9R5jxc11wLSh73+42+SzhwZMV45WkGiACg0=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from BESPR08MB999898.eurprd08.prod.outlook.com
 (2603:10a6:b10:109::23) by VI0PR08MB10390.eurprd08.prod.outlook.com
 (2603:10a6:800:207::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Mon, 9 Nov 2026
 10:56:25 +0000
Received: from BESPR08MB999898.eurprd08.prod.outlook.com
 ([fe80::d62a:5300:bc89:9f62]) by BESPR08MB999898.eurprd08.prod.outlook.com
 ([fe80::d62a:5300:bc89:9f62%6]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 10:56:25 +0000
Message-ID: <da9a9306-2966-442e-9bf0-916b54f74b5c@arm.com>
Date: Mon, 9 Nov 2026 11:56:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/7] cper: add helpers to handle Memory Error Section 2
To: Mark Brown <broonie@debian.org>
Cc: linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
 Hanjun Guo <guohanjun@huawei.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Shuai Xue <xueshuai@linux.alibaba.com>,
 Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
 Pawel Chmielewski <pawel.chmielewski@intel.com>,
 Dave Jiang <dave.jiang@intel.com>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Breno Leitao <leitao@debian.org>, Terry Bowman <terry.bowman@amd.com>,
 Dan Williams <djbw@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Morduan Zang <zhangdandan@uniontech.com>, linux-acpi@vger.kernel.org,
 linux-edac@vger.kernel.org, acpica-devel@lists.linux.dev
References: <20261104110355.1437249-1-pierre.gondois@arm.com>
 <20261104110355.1437249-4-pierre.gondois@arm.com>
 <6016f3f4-7bf7-4b71-9b8f-06a7f31095b0@sirena.org.uk>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <6016f3f4-7bf7-4b71-9b8f-06a7f31095b0@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PAYP264CA0002.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:11e::7) To BESPR08MB999898.eurprd08.prod.outlook.com
 (2603:10a6:b10:109::23)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	BESPR08MB999898:EE_|VI0PR08MB10390:EE_|MI3PEPF0000855F:EE_|DU0PR08MB7637:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f60c7f1-18b5-4a99-e6a6-08df3e502cd2
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|10067099003|18002099003|22082099003|11063799006|56012099006|261026121527099003|4143699003|261022113327099003|261022075727099003|261102123227099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info-Original:
 pNgwM/ioUrQUuqqfrz6PRYcvss1jt7kP6I8AmbOsqB/928AQCXonzKBYHUFarJSKKr83FqU4FTXCIuOqKI5FmnaBO3+17MHtHWPCux18uB5Ns6QV4Xe8nBjUkhzavI5GCJtTttcBsXfD7aXQV0Sfd6i3dYFQnMV/ERPaBvkZOD/S3/R6WIiZ2EDq7S/B2WyOQDVUq5n3NnJlqizW+okJ7Fjyc73KapPQKn4RaRchGRq3qOnLLLGN/6OtASGI6DI80ppA3/dfOnd54yJPd4sZ3LtaepXgwN2cx55vdFvlHk3+0KYT5Cs9FHGlpTlNdh9xUi/Yg2DY25ChfFVo0xJVhR9skJcFUqbpR/pGr9mgRNBvgpd8w5bxdlNoHhY6GgAHnpV0unpNWgfv56Wm3NQ+LPMdzSt748Q/Q5YZdnSxwkLQDKNVfmtv0EUtJ9G11lBzw7RJbHaaNUv477+yaBH1qMoTANZlP+VLRCsk+L0hMSIxHO1+VxCVeSLkIFyP2i1U9U3BY+CSQpxQrAGc6boO0lCaNX5TNtkVH2D+VKTh/AOei7b4PPlyA0woRgoIQd43MaWwQMiKp7NcvAWbPbhj3NHxhPZH+Uwq0M2mVwnM2RtJtAi4+2bhybHZoEIMpRXkNgh8W2kBOnAshbYYEB7+gBTPgxJ1/KEk7cnEQ4jWaJk=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BESPR08MB999898.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(10067099003)(18002099003)(22082099003)(11063799006)(56012099006)(261026121527099003)(4143699003)(261022113327099003)(261022075727099003)(261102123227099003)(261021121427099003)(261009223027099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 Jm1WlOQeVvAfrlcS6Qivhimtl8KbAkzz/w6hsC7Ux2W9Gi8mhbE81L6TTeTkfo/ClDpzYpa+ZuN8pX3evCCx1XQDEcnRyCShNyrdp9nMIrrdsHR6a5+wrClgJncueDNPKR3bEkIwc04zORWjYA9vBcgvTbso6qEpZx6JJ4oLhJMt5w/Q1euvox1BHHESWx0d2OO+Hil5BjEphmDat+2F+nGkQF7VW0M0FpwwdN61LY1CtEfLuDxT9qYuUUYkRLpQ/jvUAnK4sd70AYPXSQhOhMHcFgQbUwX3jv4dFCbC6X3hq17GHMGXEhd0VGsj9Iw//r0m2+kCHoFcxWzO5ny9Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10390
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 MI3PEPF0000855F.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	5006f985-91b1-48a4-e477-08df3e501919
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|35042699022|376014|7416014|23010399003|36860700016|1800799024|82310400026|11063799006|4143699003|56012099006|261021121427099003|261022075727099003|261022113327099003|261009223027099003|261026121527099003|261102123227099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	XzEdpzfKD87lh5aNfgkNIOR3DcPbf2bj+4rhMoMFQZv1y7FCgTFBeN6SZwFknp8TCkf401nTp4sZ+chEPCUXyt8TigVFocQLvLV+TrMfkfMSHDvZvvGtoIRamVPkMjn57+5wdNy0dhDnUBg6cRiPtn28PwHx9OOTSs6Vet+y9klc/9eoLWgnjpzqL5Wi89lLooCbqp3FBy/MBQ9HiYdiIGJkWqD2D4LP2Cf05y3iNqJOJdAWKdJWyFvZQ4IA5JhlfehbpPP4BbpsyuXbCw0xI879lg26AIuz21lZfkABj6iojpYD5gRIpH5qGdcgjo0NHcR+3WcYhyNzxV9OkauiDabb9nRcPZ381ODz8uaxbqfqhDsKeYv6XaiVwUOESsPRR+4ybbK5128I5cmxfb2zrkNYffX1epopMPTcJv6doZ/fPZeaA8nqd68iXPzIugr7gzwi4stj7GIl6vmWq/RBbWHvSWLN0BD/JS+Au3vshgIfgoVm/dpvkcCvEItCODPugb5FJ1c/P2Gz+Zoiu/4majZ4/y8S+awvhg6zMfHjQUluxov0bBeuvWAW6j77amvHQt7wsy4YRSXIbQqQQFkQUYChzgEoIctFPPRfbzeaK0CTpAY6plAttHpr6UO+DVbDNeY+OuVB7Q764U840DpLV4Otq2PsP2O5c1bREtOAcjFNXkYA50Axn9HDhIQJk8PShJFbkJg0dMYdej7CB+0NaA==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(35042699022)(376014)(7416014)(23010399003)(36860700016)(1800799024)(82310400026)(11063799006)(4143699003)(56012099006)(261021121427099003)(261022075727099003)(261022113327099003)(261009223027099003)(261026121527099003)(261102123227099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xHlPtlKCzF3QtH/HhxnpO1178kWAX+NrzMEr09l6GicdHxNXZx9QxvCQC0zlnmj9LqIlCCAv6cGPSr49ElPhvc3woNcYoeDXRUgHAw+9d1ovosA0vXQyGLAkTS7buT0z1ZFDKJEvkr5DX+4aTYfZ6PNEuRIVlvctmPnusezzyot0VZMwzDTW9GbAVlLpWNlDnSR0nQ1qd1D8mP7fcwIIBujCULNEc9gGOjQrQmyklxHCORzGLFOSb3MoRuYtVIkLnk5TrxqWvd4/DowkatO5VY0VGNMz6H70b9zEwCDfBSeEAjQzroq7M7ISUC2/7drSeBdeaBJTJeFbEM1ELeddUI7kYSc38lQIZrZB2n3ZMn4JizJKzyED3irBcxvpwpP4A/hOc3Cf9F3jZp64ECn9eI5+9xXbduIPCkqdN0m2zh+tH+cmqMy0F4Gp+pGWzmKJ
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 10:56:57.8483
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f60c7f1-18b5-4a99-e6a6-08df3e502cd2
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MI3PEPF0000855F.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7637


On 11/4/26 18:25, Mark Brown wrote:
> On Wed, Nov 04, 2026 at 12:03:11PM +0100, Pierre Gondois wrote:
>> Add separate location and printing helpers for Memory Error
>> Section 2:
>> - cper_mem_err2_location()
>> - cper_dimm_err2_location()
>> - cper_print_mem2()
>> +int cper_dimm_err2_location(const struct cper_sec_mem_err2 *mem, char *msg)
>> +{
>> +	u32 len, n;
>> +	const char *bank = NULL, *device = NULL;
>> +
>> +	if (!msg || !(mem->validation_bits & CPER_MEM2_VALID_MODULE_HANDLE))
>> +		return 0;
>> +
>> +	/* SMBIOS handles are 16 bits; never truncate a Section 2 handle. */
>> +	if (mem->mem_dev_handle <= U16_MAX)
>> +		dmi_memdev_name(mem->mem_dev_handle, &bank, &device);
>> +	else
>> +		pr_warn(FW_WARN "Memory Error Section 2 module handle 0x%x exceeds SMBIOS range\n",
>> +			mem->mem_dev_handle);
> Should this be rate limited?
>
>> +	len = CPER_REC_LEN;
>> +	if (bank && device)
>> +		n = snprintf(msg, len, "DIMM location: %s %s ", bank, device);
>> +	else
>> +		n = snprintf(msg, len,
>> +			     "DIMM location: not present. DMI handle: 0x%.8x ",
>> +			     mem->mem_dev_handle);
> Shouldn't this be scnprintf(), especially in the first case where the
> strings come from the firmware?

Right, I ll update cper_dimm_err_location() aswell.

