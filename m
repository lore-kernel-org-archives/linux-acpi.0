Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=2 smtp.remote-ip=40.107.159.28
ARC-Seal: i=3; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794221907;
	b=YEA7Vh+f7ZhDx3y6VUVsJKNhnz8weyJEBfdSB6y/8AZwYM4kB10fj/0+MaLxo1j4Jvdl
	 KI5QS9Mgu7COXdNbcJON6BpyfOdEiB3FNrECJ4lz+DdK1jcJXrINIx4pwGPvDGz4FMEZx
	 zKXk8xvSFWzVEwaVdqIWGqQJksKOZUom5YWwUKzEueMkfAh61A4KY3j7/aK+m33yJiE/j
	 p85QGRPEZ2Hwqb/tRyR/TP/w7KbF3qzfHKO8ZywT5+8aRLKgHhtCOySB7LkciEf7uQ3OI
	 qiVytUc3FqvyAnqfPRz6yffUuFSouywrGvh+HgFgwGwA8kR1f7EY76lkiEH1QBy6/kA==
ARC-Message-Signature: i=3; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794221907;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:
	 DKIM-Signature:Authentication-Results-Original:Received:Received:
	 Message-ID:Date:User-Agent:Subject:From:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
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
	bh=NLPgPnkCHLCkx0RFvMdRc7kji3xyT7ihZE1Ix4nn0xY=;
	b=Xqfem0Ulfck6PIP2eQNSf8yWM+diHFe05fLKv9uFPeSfLfj0anoYnyhJLVVtZMc2zCY9
	 VgwVjEOAKtewYw+KEqmUJJOgLaHeXkc5pMwJMezWxRVHIvhsIOGlcQhKX8HAQpeUM2wiA
	 QPRDB7K6dLDfhv7ZYzXBJujDMM5vY4tCyfnDL86773sa4VvBlgK9S8p2/bADEROb0qY6R
	 jVtAymMWZJEm2GEPS/8zBaLTYgEEVTJpt4iIoDrtuDNLMeROEpw6ruRVK8RUtuWGNKsOT
	 2Y9YBwRJPVI6wod/oK+6Lw/PbLwrg4DhgOB/0MpA7XVxWjOPRauxui7NBv3ZUH9xmVg==
ARC-Authentication-Results: i=3; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=dIrFxqn6;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=dIrFxqn6;
	arc=pass header.oldest-pass=2 smtp.remote-ip=40.107.159.28
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013028.outbound.protection.outlook.com [40.107.159.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47EF606A323;
	Mon,  9 Nov 2026 10:58:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B47EF606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=dIrFxqn6;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=dIrFxqn6
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=ZTHd7h7VmkvDfRG7Pzo3hijVVhMp3te10KaKkVQ595VurQZqq8E0U/AhrEDey5BRqj3iJ1DbmO69Ud/EIPtxeqganfrUeH18JjugJkbHdCCZwE8yGO2n186AgPCVn+sVOchsrsdbGfH16Yu4pw9NvS2RW6rOBiwD5JVtSBXJVc+0UNK26GR7yAAFXvLqSDfdpwNHSnCqfetCHL0DqLvdIOqjn9HK/a14Z+72FEp8D1ZOibRtBdwdwp+YHWlmEcwy3KKJe8XEPADbAIEEl5k8mLPAB0MIqZ73cU6IMbVDDeNLU4o/rJH2R9r3e7uEVgZbKs27wYcr7NtLZ8Ru/FZceA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NLPgPnkCHLCkx0RFvMdRc7kji3xyT7ihZE1Ix4nn0xY=;
 b=DUMUgfRrxdUnKlIY+U3QzKn2xD9RseNnnk2uQau7tyRQx9oDnhrZPKBVMrNkeyELe/7lIaO70ExkqSAVrVvFl7eX2rNDCa5f6cPFz2bycKmwFbbWITtHwD53JkK9Kb7tOGc/yGKMtqCWX1rQHf/dEorkb/3RhlOvYUZfG7qDUZMTCc8Ta88esohY59XV5MQ069HeVWjNmKAYBbX93Y0Kj+DX0m5w+dYngtWAIwXimB7CqoZLD26KxOtRE5Xoi31FDcmWURDbmiQsCTTJusY2UMr8278eTBWl6BJqLDbhOdEgg6TSXg/dWksNRrnehbR2lyb6vWjJplv40k6r02rA6w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=oss.qualcomm.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NLPgPnkCHLCkx0RFvMdRc7kji3xyT7ihZE1Ix4nn0xY=;
 b=dIrFxqn68lvYjUZtcbqOfPGkuwf1ccRV9yWzKwIRqIj5apvxXjW8OjMFf3kwA8NuXyFJHCSr0RKONnZJ7xew0K8aeZ+uIexpBx/QJdzmQgDRU7JL5fe4wz8tfpeffaChxQPnibJJjj3YI1Pir0LmfiV86YEjr9WxgdwYBPXfbes=
Received: from AS8P189CA0026.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:31f::30)
 by MI9PR08MB664756.eurprd08.prod.outlook.com (2603:10a6:290:84::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 10:58:22 +0000
Received: from AMS1EPF00000097.eurprd02.prod.outlook.com
 (2603:10a6:20b:31f:cafe::35) by AS8P189CA0026.outlook.office365.com
 (2603:10a6:20b:31f::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Mon, 9
 Nov 2026 10:58:21 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS1EPF00000097.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Mon, 9 Nov 2026 10:58:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ch3L/x9cnmgqlvn3vWjLnX94MLu3XW8ymYvAHGMNN7ONn4uv36kxiKX4arEg0JVZO/1gTGf2d5pDvyBwu3CM2x6kTA+ulDS3+uJ11dxz+FuDN0j5S9NI4kwvRBJ3YEfQsetRbeyQ/gBCL+u+2NdWKKJhJyWVPUISbg9A/Kvrcz1cThClodKJ8rlqTtS71uV4jdxJbC8s/Vbi8aIsm6CX7FunRyqO2N6RgSpG3L4R0mlm7kWwoGD6M2uxsI/b3ZkpZv14t1G4skMDZzLNJRkKTZZ3OTTQ7qXYJa7+ki5XuRFySXCIdvwL94hHlXCB2Qw2sRkJwVSNTbCCP7X+aAUrSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NLPgPnkCHLCkx0RFvMdRc7kji3xyT7ihZE1Ix4nn0xY=;
 b=TKMbMDxGdS5wrhebJ4n7LgIZM2Go26xFHxnx3cqU9HfB89gn+JAGQrgz7D58L+Bolj0V6mjfJu+hdGlo1sBUlDBvPweTQx1fx93tTJo9axmJhCi7nQLU2jh0vqDQpFw8MPyMb0D6fu0dRezMoCGEs6Y7esivY/VAP1a5RFLJRpK5ZIZ3k7BsyNrk4zTzVHcKf33fP/psIgA05SEYM3/UO0pgdxlcVMYINxJmYlk/p/0eeWESEC3W9LUQRyiwKG+YXDNO7R4A2+67HE685/kNN5RyhC+6fbIRbUnY1H7kQstKYSF3+4PAKwqEUBzvaX4u4aXwiE2jNfJRnZxFkYO0ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NLPgPnkCHLCkx0RFvMdRc7kji3xyT7ihZE1Ix4nn0xY=;
 b=dIrFxqn68lvYjUZtcbqOfPGkuwf1ccRV9yWzKwIRqIj5apvxXjW8OjMFf3kwA8NuXyFJHCSr0RKONnZJ7xew0K8aeZ+uIexpBx/QJdzmQgDRU7JL5fe4wz8tfpeffaChxQPnibJJjj3YI1Pir0LmfiV86YEjr9WxgdwYBPXfbes=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from BESPR08MB999898.eurprd08.prod.outlook.com
 (2603:10a6:b10:109::23) by GV1PR08MB10792.eurprd08.prod.outlook.com
 (2603:10a6:150:160::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Mon, 9 Nov
 2026 10:57:47 +0000
Received: from BESPR08MB999898.eurprd08.prod.outlook.com
 ([fe80::d62a:5300:bc89:9f62]) by BESPR08MB999898.eurprd08.prod.outlook.com
 ([fe80::d62a:5300:bc89:9f62%6]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 10:57:45 +0000
Message-ID: <62430a5e-1e43-45de-9f8b-f0fdc826f38b@arm.com>
Date: Mon, 9 Nov 2026 11:57:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] CPER: Add Memory Error Section 2 support
From: Pierre Gondois <pierre.gondois@arm.com>
To: Ashok Raj <ashok.raj@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
 Mark Brown <broonie@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>,
 Borislav Petkov <bp@alien8.de>, Hanjun Guo <guohanjun@huawei.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Shuai Xue <xueshuai@linux.alibaba.com>,
 Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
 Pawel Chmielewski <pawel.chmielewski@intel.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Breno Leitao <leitao@debian.org>, Terry Bowman <terry.bowman@amd.com>,
 Dan Williams <djbw@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Morduan Zang <zhangdandan@uniontech.com>, linux-acpi@vger.kernel.org,
 linux-edac@vger.kernel.org, acpica-devel@lists.linux.dev
References: <20261104110355.1437249-1-pierre.gondois@arm.com>
 <7c59eada-ea8d-4b04-a24b-9ba6aa2a6c64@arm.com>
Content-Language: en-US
In-Reply-To: <7c59eada-ea8d-4b04-a24b-9ba6aa2a6c64@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0309.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::8) To BESPR08MB999898.eurprd08.prod.outlook.com
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
	BESPR08MB999898:EE_|GV1PR08MB10792:EE_|AMS1EPF00000097:EE_|MI9PR08MB664756:EE_
X-MS-Office365-Filtering-Correlation-Id: 772dc11f-d1a6-4ea8-e6a8-08df3e505e9f
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|4143699003|11063799006|261021121427099003|56012099006|261021123027099003|261022075727099003|261022105027099003|261009223027099003|261026121527099003|261028144727099003|261026140227099003|261102123227099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info-Original:
 q+iUkYOGbWywIMmWBxTz0Y/BDa7R43NyqXDFItpdG85pyJcLMAzXdR9hXVFz33nIJhnl03sB5Ie/6hoOh0IkaGJISFKIATpEYSYmwUHw4LGtP7nDu3mU2J8S+bzU+I8BF07ntbVWASNmOiATXd+jKd0b3Z4jJ7pWRtgy73iiQpgz7A4LNewc9WNb5Vsp6s78VQ+2kxEQgNFJCwJX0wMVEOMBuCD2yP46d8CxyDlpSZaN0e+uUxw0sWvL34RH1PAL0xLMCkFW7Lu9luFL7OgrWJClcBl2lPcmbOg8wkbhPESmEQSTUy5dnU6G4P6RP57Q5B0lFNIeVnAxyjtRmEYq8/8XCnCzxS/+f8QM0GtwKmcpH8yl/gFyY75HKMnGY0NY8f4tUC9Rs10IPdSwDyUH6p+MLj70jquT7dzg4wJ3Nn2saN12s278h3HdbYyZIsLATGLy7eQkzsG3Y9bfSpS9VginDc4gvTsMFwNbN7n6vvV2BKgsl79nQmU+S4FED6K6VBlcFaS3nnRC+BlLu4xcwPfIHkDCC3wyhCBl8MLdxNOw5vccUOSf1Bs7Utlcjr44HW2aBr7D0gJagxmnolq6k48cg2XSi/0vJBI08uJcZouF2Btvp17NqhPc1JsvlYXa
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BESPR08MB999898.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(4143699003)(11063799006)(261021121427099003)(56012099006)(261021123027099003)(261022075727099003)(261022105027099003)(261009223027099003)(261026121527099003)(261028144727099003)(261026140227099003)(261102123227099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 2ZdhpODqJM/xRgfxPY9OqlMuVqxzPXvqnB1DNt5Ejjgj9lco4PtEiXhYOTo76iPpVftHYXvwMUJiwV1PxJ/ANSmVA0YlgIeK2lqIfIZuGPqTy//rMoy6bsc7lIYOO3wwrIt5g8ckS9IEMELIue2pKZoU1vhNa28raMU12BdMdNCyhdc8LSLHfO5IzUgmKwXdD6SnKU+tq+PFot5Xk9yU3Qr4hZNxJOC2cE5Z2IgwNznuRvbIvyG2s+r2Q/VcG6V2EA/ZuHaIURmMhvlpUlcGrf8qYMcWTlzXxy1jUhFOGjXxpn0SxAUuIWajZlMJclwAO+2/KYsEwZeKdYviwhpXEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB10792
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF00000097.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	ac914fb4-4d84-431d-231c-08df3e50494b
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|35042699022|7416014|14060799003|1800799024|82310400026|36860700016|11063799006|4143699003|56012099006|261021123027099003|261021121427099003|261022105027099003|261022075727099003|261009223027099003|261026140227099003|261026121527099003|261028144727099003|261102123227099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	QJkRhmwzu/Nljx1SZwCRX+2WwRnPuVIhWDZG0dfLI5Bo+mTeWAgptABuPZXRCTrZlO152+N6vgKHeqEDUOkMLCS83gOlIcBppZ9cIXE6R/hT28F1PaAF93/gfwsVppFhJ84j4zzhGBYOxh4Y8rBp/4T0FijaVliBF6+n6A38E3xlLdrifMW5t9kpY/ApHIni/AisG1ysMWmwI5ql//GV+ZLDenCFYzDbvfcDdfvIzX/u8hBf1j4/sOThJ+X5T9bO/3+qh3IvecqjuKxOkhTLBKkbu0/e6D9LxfzH0FUjm6clbicOrsQq914qZqPG4TMmT5h6L75iTViyQyLowhPpe5zLowY2BeyD15O+YFErT5h71/ZPH4KR2g1cW3n9aQAHsNrtyJVTimJGBBXUCPFTMNs3zVx+v7SI2d1lT3tNr0bHIOEy7/LoMFy1JYsEiGH3BoUw227u+eLgW2Yjr2rgdubA/nr7aEnf1nxr/iu57iXBOOTRnXDosYGNuViTQakU7ZKw2opCWTDtYljps+oDqoRty5AVVPGsHP+U6/i8cKotoPTkEr6vSOMAkAPm9hVC1XDXgKZxdighqHRpSVzPsijt/fGDDPyy8w5AEppjirVo8FUKMYBqfXKa1Y5l1rQMejnLOX2oBrdA2blj3fn3yg==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(35042699022)(7416014)(14060799003)(1800799024)(82310400026)(36860700016)(11063799006)(4143699003)(56012099006)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261102123227099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	snLG62orlpnrxyvbTiT3afcOez9U1+a6fabci+tixlwtyhJNyYnY5I5HT8D7XIVcO5E/gFpNoWhRO49MNeUGPG1kMapJ0UTbLaoBkLd9zrk8m65ppp0A97xH5eDm1Bl5MijhdVOU8cj9HP1sb7mdJVrUCUIXxfuNJDEi9awz9yJ8giovM78XagLSCv4b+XX6gdHFyNJFBlWOV3OC7lVeMxGXwM45IZE5F4aB1tzECe0J+AaaRuCj3xvXY4O67b4RxSSXBfTNKKdlUOea5kqxl6zkzfWxyJkIyIEy4ei7LguNqDIi6auEwiHFMQ9dTH9T6OlJUHnHyIK4324JFyChTuQHtUA2N+5GMQh7c4Q9YPZFcH/rm7aFFEAOhC+u8ulxHgFhwXbPuS8BG2YzneJzhC9lBRWPg10FZb4HhiKwDBJPKj70U+b7zhDxXEU34CTP
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 10:58:21.4850
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 772dc11f-d1a6-4ea8-e6a8-08df3e505e9f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000097.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI9PR08MB664756

Gentle ping to check if there are additional comments on this version.

(Thanks Mark for the review)


On 11/4/26 12:07, Pierre Gondois wrote:
> + Ashok
>
> On 11/4/26 12:03, Pierre Gondois wrote:
>> The support is mostly duplicated from Memory Error Section handling.
>> Other than differences coming from the content of  Memory Error
>> Section 1 and 2, differences in the support are:
>>
>> - v2 do not rely on a compact "struct cper_mem_err_compact" struct.
>> This structure was used to support older versions of the Memory
>> Error Section (1). This is not needed for the new structure.
>>
>> - The compact version is also used by the tracing framework.
>> To avoid relying and propagating a non-standard record format,
>> through trace event (cf. extlog_mem event) the new trace event
>> prints each field individually.
>>
>> The last patch of the serie was only build-tested due to the
>> absence of relevant hardware. apei_mce_report_mem_error() and
>> arch_apei_report_mem_error() implementations were also removed since
>> last version.
>>
>> It will also require a proper handling from the rasdaemon. Applying
>> this last patch without rasdaemon support will silent the reports of
>> Memory Error Section 2 error, cf. ras_userspace_consumers() check.
>>
>> Future:
>> - _OSC support
>> - Addition of arm64 tracepoints
>> https://lore.kernel.org/lkml/20261023170405.000060b8@oss.qualcomm.com/
>> - Emission of lossy CPER Mem error v1 tracepoints for legacy userspace
>>    tools
>> https://lore.kernel.org/lkml/at0rs4parlHFGI7k@hu-ashoraj-lv.qualcomm.com/ 
>>
>>
>>
>> RFC: 
>> https://lore.kernel.org/all/20260929074659.2587216-1-pierre.gondois@arm.com/#t
>> V1: 
>> https://lore.kernel.org/all/20261019145643.1877246-1-pierre.gondois@arm.com/
>> - Corrections from Jonathan's review
>> - New patch:
>>      [PATCH v2 4/6] EDAC/ghes: Extract error report initialization
>> - Last patch not in RFC as it has been reviewed by Jonathan@
>>      [PATCH v2 6/6] ACPI: extlog: add Memory Error Section 2 trace event
>> V2:
>> - Updated ghes_edac_init_error() to ghes_edac_init_error_desc(),
>>    which now only acts on the input "struct edac_raw_error_desc"
>>    + added lockdep_assert_held() to ghes_edac_init_error_desc()
>> - Accumulate failures with "queued |=" in ghes_do_proc()
>> - New PATCH:
>>    [PATCH v3 5/7] ACPI: APEI: Extract common memory failure handling
>>
>> Pierre Gondois (7):
>>    cper: use BIT_ULL() for processor and memory validation bits
>>    cper: add Memory Error Section 2 structures
>>    cper: add helpers to handle Memory Error Section 2
>>    EDAC/ghes: Extract error report initialization
>>    ACPI: APEI: Extract common memory failure handling
>>    ACPI: APEI: add separate Memory Error Section 2 handlers
>>    ACPI: extlog: add Memory Error Section 2 trace event
>>
>>   drivers/acpi/acpi_extlog.c  |   6 ++
>>   drivers/acpi/apei/ghes.c    |  58 +++++++++--
>>   drivers/edac/ghes_edac.c    | 189 +++++++++++++++++++++++++++++-------
>>   drivers/firmware/efi/cper.c | 109 +++++++++++++++++++++
>>   drivers/ras/ras.c           |   1 +
>>   include/acpi/ghes.h         |   2 +
>>   include/linux/cper.h        | 129 +++++++++++++++++-------
>>   include/ras/ras_event.h     | 102 +++++++++++++++++++
>>   8 files changed, 518 insertions(+), 78 deletions(-)
>>
>> -- 
>> 2.43.0
