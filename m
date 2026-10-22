Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=2 smtp.remote-ip=52.101.69.66
ARC-Seal: i=3; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792652888;
	b=GLK6KyKb5IHlHI0pcwG9nGlJRnzJ8kyrXjcQbA/b4XCGtv1N421Y2yx8imB5k3F9I9re
	 PgxsEXrzQnDqKYW5b3dvQBxW5a3muZIA894b5FsEYi6pGv7WTDJTIlXkfPRKBPwoUeMp1
	 pR/y+ROqSvm4R+wo/vKUlbYFNwVFt3H/ohYI7amNy7NdIqn60dkBRSU5Q7cOOXbxCPWl5
	 Z0bn4W0bAMqNX/w5tPegKMfWtCoF45kYUwXSPr8wz2dFSMPZVgBc2xDm0rlhtZKVQWvcn
	 aMIE1jPiggO/E3LcvoCn22ptmSYtDR+ZOVGG3NkDAMRAQHE0osQpjLInsGAU3zOCHjw==
ARC-Message-Signature: i=3; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792652888;
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
	bh=B7wd/Gi2j/nfsCtmMPCLQuvF3H358IuX30uGA0uWjHk=;
	b=RiSOHA7/rDXNrzeXweVtpAQsHfQL+N1pNajlpQFrHlk+JNc4M4+zJsBKcJczqkw+NO02
	 piQfrYCori5N85AhyBJOAF1ib38o/GhUw87nAwy4xlqvz2KUcGw2KcWJT6NJfQtB4nyxV
	 RCV03uDh/cIy9082PuayZbA6gqScdRe7Zc42KBurE/1jLzvC1lbaGBj2uSOizL5tQf0sQ
	 Z1Wtn1epSQusLwOZq/QZGivqlJovxbD3ayM6zNJrc1ALEy88Yk2Y1sMCMPOVA7GUg9bjt
	 aiRg5fUJYK7Z8/1p9XGEje6vjfoM2jd1WnYINzKi5mWWCnLd685Z+aoEmtN/MOiQ1Bw==
ARC-Authentication-Results: i=3; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b="fH2u/URs";
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b="fH2u/URs";
	arc=pass header.oldest-pass=2 smtp.remote-ip=52.101.69.66
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010066.outbound.protection.outlook.com [52.101.69.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDB2606A319;
	Thu, 22 Oct 2026 07:08:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CDB2606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=fH2u/URs;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=fH2u/URs
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=UwLbD3V1bFyRZhHIMFI95mrUNzW89uPSpIf0qP/E4BVk+DUQbE9QuHdrtj9e2prNRid6gkTixGw6OJ4KtcTQbvxPoJv5RHp1DndSCIPMO7MeRaSgsfxZTxQ5kqmomiMzgas7Mxiriw5L1zbEeuKeu+JcLnvlMCVFXKolPPxrZbh/ot2VzaF468nlF49Tz5secqcyS7otjMRQlecXuLel2a7HYE45jTm+FUfiIIhzpQTSomA9SiFqgxI721XYmQ4qNvkPfLTAThkAlYpg7Szt3zZ3wrUaelZ/goU6doGAXmAYEZnYvxzXCxvKzBU+qLpYWxHsDash1fNwK4/wR5hHNQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B7wd/Gi2j/nfsCtmMPCLQuvF3H358IuX30uGA0uWjHk=;
 b=M8clJCdJbK0Z+VZOHHr42mnvLNUZz9W0lETZfEsy5Q4yGJvmudF/CiK3527PfbL6qf+CSLQzKK2g0FdSMD7BPmE+To4WZeG0mPyOw7rLIoHeTFpm8ArmWUlf/Sa504UtG0smwG/dzRHTC8dPOLfYEKVimOxnRnSuvFAsUQVkaWXlj295PnUXQ2Ps+w816mcfErYGOtuDmp1A/sjhDpYpc8Vi2k/S5rv1lVIi0BG0su0K3oI/znte3eHx2WprmWUNReNxzKVAe/aJ3B9VRxebN0asPbuwbRih9cxrL4i4e5MaUlInaElV/aekU5QGlg0N9T/OfJ6+cTMB6z8ukllDQQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=oss.qualcomm.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B7wd/Gi2j/nfsCtmMPCLQuvF3H358IuX30uGA0uWjHk=;
 b=fH2u/URsZ/84JSziAST6bc+SV91ID4vOCXv0MVz+Vm78d62Uw9gjXKrF33IBXP7qOV7jL5Blc2M9JQQYDeWEw3Rj0v/hXn0OtLgbqeMdsuLXUPvNTGgeGT90hXyMIFss4iuQarapUY0NlTLi+XviNz0wY22Uv8I9HvUbGQFd7/I=
Received: from PR3P195CA0005.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:b6::10)
 by AS8PR08MB6373.eurprd08.prod.outlook.com (2603:10a6:20b:33a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 07:08:02 +0000
Received: from MAD0EPF000008AB.eurprd04.prod.outlook.com
 (2603:10a6:102:b6:cafe::4e) by PR3P195CA0005.outlook.office365.com
 (2603:10a6:102:b6::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Thu,
 22 Oct 2026 07:08:01 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MAD0EPF000008AB.mail.protection.outlook.com (10.167.241.183) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15
 via Frontend Transport; Thu, 22 Oct 2026 07:08:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QOIti4oi1u8IpW42j2r3ZOj+aVkgEn7E4ouPllAeBl0sLAJIUYVPrm2Zjtxoglt7NzIToasc0C0qppE6uaVRzLOfdcu2SqPqNEZ1bxXttO+D2W0pObTZ/sKLYVEi0PdqNszrq8Y4AquiqO8LoGJkkATvyTkY9iPe3o0ZR48XyR0Cg9QtUj2jSPEJvhEFs+w6j1TTX+Ck894drmYf5SDXLsQxStddfrd4qM5CS7deGCQS0LfBnEz/6R96q9kiYLumtoIrEho0JynsET/5pJmGGuh39m+5FREINTJR5qEPHUQPc3D0gmGygInDzfbvABHod+CZhPsmNrLVXg70xUR5RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B7wd/Gi2j/nfsCtmMPCLQuvF3H358IuX30uGA0uWjHk=;
 b=yfQkH3/vxXMdPpjrXhDOkO7N86Gdnr19H2U86qWfVXG2s6UxD+NdPQGiyQ4AXoLRLBPzAoYRek66ACWIhMZTxYtTNtSsbKT/TMvXSP1/qAx6G+Rr3BdHg0QlTcXtbJ9rabXLiRzVBJnoAQi4zZrtUXKqhYtcBtdxP6z6zNC5wjF/qkCtQj/x+MtMf9TslBi5hOLt/Hxm7g5ZPk6tNonADqIenM5iewkxgYp52VsRl3TFA4P/wCcZQA18x4npIBeUHnCCvFaE2cuQIo2h9y5gd3euIMMd0orb3tu6jerUOUkVPtdCrxJDAu/oGVwMzoo0yYfzVd2L1RRxgsEXeJHeNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B7wd/Gi2j/nfsCtmMPCLQuvF3H358IuX30uGA0uWjHk=;
 b=fH2u/URsZ/84JSziAST6bc+SV91ID4vOCXv0MVz+Vm78d62Uw9gjXKrF33IBXP7qOV7jL5Blc2M9JQQYDeWEw3Rj0v/hXn0OtLgbqeMdsuLXUPvNTGgeGT90hXyMIFss4iuQarapUY0NlTLi+XviNz0wY22Uv8I9HvUbGQFd7/I=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from BESPR08MB999898.eurprd08.prod.outlook.com
 (2603:10a6:b10:109::23) by DU0PR08MB8164.eurprd08.prod.outlook.com
 (2603:10a6:10:3ef::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 07:07:27 +0000
Received: from BESPR08MB999898.eurprd08.prod.outlook.com
 ([fe80::d62a:5300:bc89:9f62]) by BESPR08MB999898.eurprd08.prod.outlook.com
 ([fe80::d62a:5300:bc89:9f62%6]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 07:07:27 +0000
Message-ID: <0817615d-5e96-4a3a-b39e-3e5d1b88e716@arm.com>
Date: Thu, 22 Oct 2026 09:07:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] CPER: Add Memory Error Section 2 support
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
 Mark Brown <broonie@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>,
 Borislav Petkov <bp@alien8.de>, Hanjun Guo <guohanjun@huawei.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Shuai Xue <xueshuai@linux.alibaba.com>,
 Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
 Pawel Chmielewski <pawel.chmielewski@intel.com>,
 Dave Jiang <dave.jiang@intel.com>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Breno Leitao <leitao@debian.org>, Dan Williams <djbw@kernel.org>,
 Terry Bowman <terry.bowman@amd.com>, Ard Biesheuvel <ardb@kernel.org>,
 Morduan Zang <zhangdandan@uniontech.com>, linux-acpi@vger.kernel.org,
 linux-edac@vger.kernel.org, acpica-devel@lists.linux.dev
References: <20261019203915.2019037-1-pierre.gondois@arm.com>
 <20261020101048.00000186@oss.qualcomm.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20261020101048.00000186@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0277.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:373::9) To BESPR08MB999898.eurprd08.prod.outlook.com
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
	BESPR08MB999898:EE_|DU0PR08MB8164:EE_|MAD0EPF000008AB:EE_|AS8PR08MB6373:EE_
X-MS-Office365-Filtering-Correlation-Id: c8215d87-53ca-497e-ed5b-08df300b35ba
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|18002099003|22082099003|10067099003|261021121427099003|4143699003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info-Original:
 KwFu6HJcceQp9V47iprTbKDIYJFr/Cg2T2d/5q3JRZlNLR4N1mcYS1+mOv4bjaf1aS1n5P2dXTZ5Out5CS+5nNJp92DPo886bmtFkHzJzye12RhZtq55eRvtpyh7W8PRvL0IVWYnrCGJHxjeHMxsAWk4VkVsAqfzyjbBk6AJ7wPrMIBTY+mqaPPHmb4q3A8eTN49Lymf9eiYTcpQGtw067Qk1S4dCbIDtyHN58cMh1Sk4/djSH0lEg9SpecjeR8Fe6AA3Ofk9vGpaEbaC2iYq5mlHOuIYClMRDX12IDsM65FkirFLpJyTOsJUy0IkGO7qKZCcz3Mo8pSrGm8fh4MQxMdW86dUJeqa/HimYg3HE5HLUTQhFJIQngkeBc+sndMB0jNizeJowMKGF7Z/Otvua4ETxxUU8xS34L0KEUELMKI6FDR+pUmhz2JNJF1eSq2cr8t01j5FJYNzsPtPoy7c/VoYKJDCB8fMfo9qt43O49uC4Vho5H3Cfv/UKVwD2iUWzjBWhTgy5guMHcPOW5V2gTScwgELDHQe9OfZ8EPKFPGpmUv+4PioKakg06T2thP6WvqfIDlHETIHHgK39INmILmoVSFIKEfLc5Kcs8adtvHmrZKtJ5s1BnD59SL+XLeWy073jNVScPEKWyR9bkcwjZE6W8TjPG71Rtj8Odu2+c=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BESPR08MB999898.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(18002099003)(22082099003)(10067099003)(261021121427099003)(4143699003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 NsjEppnfwzAFMVm2QfutG+Iu8GX/syjNA6OXab/gEfXqE/l4a7zdsO1troNwaERbdf4Jo+iaX8omjf4OJR90+H/fddiAWMN8wRoLIRD1+opNyZI+Y/R8Ns9IjcOwTBSvM7YIv3LvAgdLss6MlE8lEa15Wmps6S+9BC3IU5dNw0SnbatZGCT28Ix34qw4lfhA68kAHWCQv82YPKEpUte+9nJdkSlSBhpfl2DDC1NsPUd+iBsm62tHBXtQMfww+XXuGnGgWFHAGqnp+ciyx3GEvFquieMI4tDkK/2Qt+kgntCeYIhq7JegQLEw4b+S18jfLyoIYOnBmkEMhfKXHqs7Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8164
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 MAD0EPF000008AB.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	ada6b0e5-c43a-4dbc-1d18-08df300b2104
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|14060799003|35042699022|36860700016|82310400026|23010399003|56012099006|4143699003|11063799006|261009223027099003|10067099003|18002099003|22082099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	awm7nhIa1W28/wHBR1R3y0Cn7pdNOTCy89Qk+Xs57TJ7hbbGu3Ms6vHIQYikWWqr+d6ZB1z/skCYmrHyNW4cImHgYY7q+ad28v2yzIt+GJ/+qTRKNVCdzHEU2Hj++7Q3kU7ZG5jGSNmn2yvU0Egwl8wI6OV8NbQy7sPM+qQpoFjVW5yEdyoQFUglrJFXO56Kpgj+XzcYgASdrOc/B0yr17pLLW5PgXKdIx8JG/Gs3ASFXmer03Pud2x4joPuyVwemu+9hf/8mM1ogJ1eC+PXDPWllYuPjzMmqCP2NUTO0D1jAvZdLiWe9Q5oH3WXVZFYXItHR/QcRC5Xg7+wnZsJ1aG4I37NecV381MXGc9mOJ1gg//OkOwPwxMylk0KYaNnWGVG2hf3P/ivkD38049XTyGhlfrS+1tMCMErqwmK0Wu0OtxVxE2a597HGKO6KmGHWUlOFhI5I7tH8t0CTOjiZd6m84yX40XuexMjiSwTnnN68dHxpZysjPu/Yd5jkm3aNc/21HIxatFuT6gwrcujsY0am2dTVe9H3qXNBOQS9oZ4jjgte1QyXQ15qAtENcCbqoCsr3fq1LcNhUVU3KqI4rl7d0IWV5lqABe6OP+bb17RloFLvXdgz4z0sDhjJCwDe0tjbiNn3KF5s5lcsMV8/mKeCCz14b7/kjHZ3yOl0cbwC+51p9PbY69kdUikC7fEFYzWAjvkeMr+gKYJi3VORA==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(14060799003)(35042699022)(36860700016)(82310400026)(23010399003)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nDOA7uxl/NP+HAwZAhdm7ZuVdpt9zGz2zH6lUEPBk1LkGZp9AYyiNqhUeFidONNW90wi9302XGRD5EF7A4Ws+Yn1/ZkCH26P9RPv7/NESa+XBeQBMVong3rYxCtYgkq23Ltr4A7bhh2f+R8zK4r5bn1ndTJ7WTTYOgbKkzdK+mnpNl0JNyxCjMTf01IonhJ+QeTPcomV2b7Z67pOdN1vNWOAh/O7VH5v16x6EglVOSTJZnrFh4bUDctAwdkq721xyb4w1Wj5m+L1a/tcutzRFM9/FgMvo4FBbKbXZGcZAiyjgqBVcPSe2qKCjG8tLtX7oUgGWDXWoNRA09nVEp2g01gd49VgmLanWI3HZ7yQOrq6g4YZaWpGOIjsrm9crLjfRQjSRGgUu1g9jjPukbGwY/9WgcgeIzHM6e9i9405MZC6vdWbjVa6jWBrpSrMXr3j
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 07:08:01.2495
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8215d87-53ca-497e-ed5b-08df300b35ba
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MAD0EPF000008AB.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6373


On 10/20/26 19:10, Jonathan Cameron wrote:
> On Mon, 19 Oct 2026 22:38:39 +0200
> Pierre Gondois <pierre.gondois@arm.com> wrote:
>
>> The support is mostly duplicated from Memory Error Section handling.
>> Other than differences coming from the content of  Memory Error
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
> Hi Pierre,
>
> I'd slow down a bit.  We are mid merge window and convention is normally
> one version a week or so anyway.  Better to gather up feedback from
> a number of folk and spin only one revision to cover it all.
>
Hello Jonathan,

Ok sure, as the v1 was reviewed quickly I thought there was a chance
of having the serie accepted quickly aswell. I ll wait a bit more.

Thanks for the review,

Pierre

