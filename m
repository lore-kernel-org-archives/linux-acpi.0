Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=2 smtp.remote-ip=52.101.70.20
ARC-Seal: i=3; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793619243;
	b=p5LDPWCc+Gzp7Ozhp4byLYJTuVUQbBKFWPkT6NfSYc9T54e9ctxQUNFV1kXNYTTA9BQO
	 LcRv2Ac0MmtSFp4/hJq/t8VCQz3Rb+ANLeTKb7yyVKVozpuhKiKWlpz6T+NuFA6k574u8
	 eFeKSa/V94fR7MctnVhWBf7PCwupEL1mrdnwi00pgs1mmWC8zsZzrBTp72xvRhCLiT6DO
	 pDFpC69Ua4Z1YCP4xKOIunTrTBZHgSUS9om1PUOQg3FhyYLOLPzB4CBtkeKt1418gp+Q6
	 JjnS6JjeZMv85c/ablf9ddZtTYYzd+RQgVj0UGMNFc/+kGXVUkuqwUueSDYMaMM78IA==
ARC-Message-Signature: i=3; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793619243;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:
	 DKIM-Signature:Authentication-Results-Original:Received:Received:
	 Message-ID:Date:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-ClientProxiedBy:MIME-Version:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:x-checkrecipientrouted:
	 NoDisclaimer:X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam-Untrusted:
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
	bh=8YxUHfzl/SJB2a4GBlO2oTIQB6v2KREjdbgv5Sj/LMI=;
	b=jXc/DKfteUFKLOioYQbr9E4yZB3DPzCQmBO///FDVIENer32C+Iu/PcShDbWnGGLnJLA
	 VNwn42OEPhGbHGYEGS+kfrEGS1VNAhF4hIXGGSdfulBs6/NHHQmMsTKI5BshEl08OaAdc
	 58gb7Vx2gWTzSNShfeKqN1OQ1hilReH7IvOyUiqBZ4uTxXoJbYqvNJoo2c5RR+GSV4HBy
	 sTtq7imjNN61IZiU6rGASRsexyJTubAkAd9/1GDYoGf+zty/Oqa0S23XXgXktbhOyck7H
	 Iv5/p7URKxbZmrsx0jWWIIdjvOQSg+k4L074ktzBUNAQ6mJcR8yWB1uBuITVD+HibtQ==
ARC-Authentication-Results: i=3; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=sKjyGHvc;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=sKjyGHvc;
	arc=pass header.oldest-pass=2 smtp.remote-ip=52.101.70.20
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011020.outbound.protection.outlook.com [52.101.70.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F36606A324;
	Mon,  2 Nov 2026 11:34:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00F36606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=sKjyGHvc;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=sKjyGHvc
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=j1xUErBU5rB0W1MgF9QdehoUot1u4wIph0wQ+I+gE/2TIT7ZEe1jX4yR+tKe0Q209dDr6FbIPNmrmQlbzouge+2+M2/uFuK46Z7FPXe3CZMFaeUJXFae0fdLP6/csEtprAORJwWJQy5z+OKr8RP3YuuF6srWDfvW5hSORtBzxmZ1guO/8+rBx8IVH+QS3rnoQ65/WWJM2JGgfVQrDNP2s7yntY+n32wARsuyHH/JnwwqntQDchMQ4lpxOdiVWPryZwS4y6IqLmvvmjLix96n5mYLHRj4JrI7oNWy+v8hzMkczVc4Ly+Zz1nSgxG8N6G4eyUvg/gKs35ORMEyZlm2pw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8YxUHfzl/SJB2a4GBlO2oTIQB6v2KREjdbgv5Sj/LMI=;
 b=x25pkg7xHeju1wmSDjmwRyyvp/qn163CylCGbDJOr/iGcXJHKBGD1G9mF5+YwRqPUXE7VNbqZfnZ+zVcnT+9Kvs1bpl/wIpWpmHmasx9evFiA4n5yQfBSdRv/3zbxwi0ZVnkTcQqBeh5nzkcB1soRHRMoPO4OKbSGJJHP6D+l8tKdVGfbGc7F5/g4O+SwEUPqVzSgzKEkBBAEg59qIXhfLvSjaOg7LT4jsGbjAGDTAxS96JTFtMvOgZmWcNwjZipLQs3imnKO2Ohb87eLmsHiHZw41iUdSxl3j6l6gnmBdjzLLxwD04HctzKCmfOJgIc+HXVKCri2JBLs16d0G7cCA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=oss.qualcomm.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8YxUHfzl/SJB2a4GBlO2oTIQB6v2KREjdbgv5Sj/LMI=;
 b=sKjyGHvcAOUb7cqD/6bQVe8OwL8mnbIByBWe63HJDF6L3gytq3IHpbq3UxuMoDCkMquCquMvfqc52gV0cx7YPgTLVoHIoL3FJ+GmViQXIxzRCjMkcpemNL7rEAuClD8ZIxyzT/xqwDLfxGtsp9YjkC2RqepD5WUPDHaLzo+ihVM=
Received: from AM9P193CA0004.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:21e::9)
 by VI0PR08MB11268.eurprd08.prod.outlook.com (2603:10a6:800:31e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 11:33:57 +0000
Received: from AMS1EPF0000009D.eurprd02.prod.outlook.com
 (2603:10a6:20b:21e:cafe::70) by AM9P193CA0004.outlook.office365.com
 (2603:10a6:20b:21e::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Mon, 2
 Nov 2026 11:33:57 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS1EPF0000009D.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.5
 via Frontend Transport; Mon, 2 Nov 2026 11:33:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fOyLUC0YOnqnINblQWsJ+PsnLtxexnp655CUZkfFfWwI2ygcqJocW6kYI/au5w0R3/1HutgCv73N1oYqSdkIumnEEJCsSHs9jU3iuCBa1f4UWT/eSeR9PbU9hC67Qi2dW9nppd5OTlMQ5UY+xg8jsx/UCVqs1lsuHgaCASRAbnJKH6QWCJhKupClXLFwjseBPONS+JOgftwhTdvZ9/Xg9znnxReoa46/7a9YMci++aX+FswR1tNVG0roI/447F4/2XnEEZpgRc1ofAWxcrXK/ssr7r/Tou9n+A7anxhEzAzBzkrBCUAe/tgsOxNjsK/nATs/MPgzhY8I8H8JXqXInw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8YxUHfzl/SJB2a4GBlO2oTIQB6v2KREjdbgv5Sj/LMI=;
 b=g/G4+LhL8uL+e4vo7Po5Rk1tG04+jABBsXSW1tGEzt8q9Lw5lTbEeDOmnav1vFgDfQxoMGdhBnJfLuBEJXcSbysqmjJ5tTbYOAeOYof/N7PY+r9Y+Pnm4+FPt3qN2U5RWN1Uyau43rYRFZSV51BbJ5ZnvAAd89Rk25CvGkZx/+aXwwvXV1GezRXqdVl7id84EXrebnam1Et2EN4ILNtH4IiNBONbZY6ncJczHHSuXdjXoriRrKvzJ//B+RRO/nlxcnCl7ZpBZhBFgzIJF7+9g46c2EHiMth0IQR6k4y6UeeAU8L3Q16J+FISHUxGxLMCWV4seG/0vU3/4UHXABbxXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8YxUHfzl/SJB2a4GBlO2oTIQB6v2KREjdbgv5Sj/LMI=;
 b=sKjyGHvcAOUb7cqD/6bQVe8OwL8mnbIByBWe63HJDF6L3gytq3IHpbq3UxuMoDCkMquCquMvfqc52gV0cx7YPgTLVoHIoL3FJ+GmViQXIxzRCjMkcpemNL7rEAuClD8ZIxyzT/xqwDLfxGtsp9YjkC2RqepD5WUPDHaLzo+ihVM=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from BESPR08MB999898.eurprd08.prod.outlook.com
 (2603:10a6:b10:109::23) by DU0PR08MB9486.eurprd08.prod.outlook.com
 (2603:10a6:10:42d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 11:33:19 +0000
Received: from BESPR08MB999898.eurprd08.prod.outlook.com
 ([fe80::d62a:5300:bc89:9f62]) by BESPR08MB999898.eurprd08.prod.outlook.com
 ([fe80::d62a:5300:bc89:9f62%6]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 11:33:19 +0000
Message-ID: <3718c5fa-88de-471b-89f5-4cba15975a49@arm.com>
Date: Mon, 2 Nov 2026 12:33:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] CPER: Add Memory Error Section 2 support
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
 Ashok Raj <ashok.raj@oss.qualcomm.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
 linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
 Mark Brown <broonie@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Shuai Xue <xueshuai@linux.alibaba.com>,
 Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
 Pawel Chmielewski <pawel.chmielewski@intel.com>,
 Dave Jiang <dave.jiang@intel.com>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Breno Leitao <leitao@debian.org>, Dan Williams <djbw@kernel.org>,
 Terry Bowman <terry.bowman@amd.com>, Ard Biesheuvel <ardb@kernel.org>,
 Morduan Zang <zhangdandan@uniontech.com>, linux-acpi@vger.kernel.org,
 linux-edac@vger.kernel.org, acpica-devel@lists.linux.dev,
 Ashok Raj <ashoraj@qti.qualcomm.com>
References: <20261019203915.2019037-1-pierre.gondois@arm.com>
 <20261020101048.00000186@oss.qualcomm.com>
 <0817615d-5e96-4a3a-b39e-3e5d1b88e716@arm.com>
 <20261023142621.00007051@oss.qualcomm.com> <20261024003917.283b890d@foz.lan>
 <20261023170405.000060b8@oss.qualcomm.com>
 <at0rs4parlHFGI7k@hu-ashoraj-lv.qualcomm.com>
 <43301529-f169-493c-bc59-fa08b77e1ef3@arm.com>
 <20261030081941.000040e7@oss.qualcomm.com>
 <fdbce441-921f-4ef9-9c57-0685706cdf89@arm.com>
 <20261030144013.0000320e@oss.qualcomm.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20261030144013.0000320e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0347.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::10) To BESPR08MB999898.eurprd08.prod.outlook.com
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
	BESPR08MB999898:EE_|DU0PR08MB9486:EE_|AMS1EPF0000009D:EE_|VI0PR08MB11268:EE_
X-MS-Office365-Filtering-Correlation-Id: d7dacfeb-dbb5-49f2-2646-08df38d52eb2
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|4143699003|5023799004|11063799006|56012099006|261009223027099003|261028144727099003|261021123027099003|261021121427099003|261026121527099003|261022075727099003|261022105027099003|261026140227099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info-Original:
 gEaKdOLxrLIPyYI+Du4wJAXamSJi37NaIND8qdr5VHJDGiCgU4qchWnPbDo6+XS1Aok9GHp8SzXE1PwaOtkqsH43Rax4bTyGSKNjKhnYOWrI61ZRY7x65FvTbQoE1KtPLUrPZDBU1jcUTGHpabfQwpWN8dc6hynODowgLStoSq2FnBP1A3n2/PbH57LLD6ANVQ5ZrHN2KybXtOGeDvFk5aKwekUqu+9pfMof/1p5NKdvqN9C40+PeOh5xt82CN1vt4M/ua9GKXhZqKl+txQWOEzdsz67UgpzbVqs4Y2YWTZRFqgu+Hib5RhthlNAYdzSHez+gmPbhjg3/UQHUMmSkiXrVq6Iw9Bu1uoI1skhox1uQJge3nazrbosKUzvbwqBkkv4j8HEzp4NNkji0+BupgeU/YCRP35d/C57zqZH/qvLITqbjEoIgC/DK4jc+OwDSL6sMQ0m0KAkG5DV8X3Z23coa/2BZksWWcV0F9v00yWoRe/zHV5tt2ER3G48la3p0K5cLJ42YDy+AUzM1NbvPYTZEiiFzvrQaSvEqWvdaW2gxeLfirt5fBO169Op8yZM8Z5YUpDNdaDSeqKSzuxtFF6D79YIhnx1J6Hj1bM5UVeTA6zRkFQS5dcUeHnmu9UL
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BESPR08MB999898.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(4143699003)(5023799004)(11063799006)(56012099006)(261009223027099003)(261028144727099003)(261021123027099003)(261021121427099003)(261026121527099003)(261022075727099003)(261022105027099003)(261026140227099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 DrlGsDlE8OFAlfGWTxIWTJA4AoUH3OxOhNDwArDfui/fqYqlilRfPVYCEDDwHKuhjDGVrv1nYgw6OiJrVh8QgC2vRIL6liW/d8Xfq+oEMcwsBzCx7CpHojNLRD6J3IkS73qx9l7Cgw9bH1A9euSEFF+deneeyLW0QiqVAAqjLjc1nQD6Z284KangjZS8mIpKkDbssh4DPYW25W97D2REyww1FFj4YoLSlG+6kZ22PveifqNKz1w1dNPGKAWCFMW0GYqjvDANcbPf3WGzyk03TIbauUrx2TGPt8PEHO43VVRP9xxzoXtRGX3WByibqi/QFogONvSWRh4ipMEEUmU+2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9486
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF0000009D.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	3963a6d7-f8ed-430c-c75c-08df38d517ba
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|30052699003|23010399003|376014|35042699022|14060799003|7416014|1800799024|82310400026|36860700016|261021123027099003|261021121427099003|4143699003|11063799006|5023799004|56012099006|261009223027099003|261028144727099003|261026121527099003|261026140227099003|261022105027099003|261022075727099003|10067099003|22082099003|18002099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	1Mh0fQ4Mivn1TR2R8iGGYFWIAp6Qsr5+MEWEE/Yv5MrCT8tK0Mi5flcm+Qv8n8elxDyr+VzFUKpAvPWxg2oZbbP/Zds3zv766c1Dp3B3Oc/UjON1n5IzmuZeoTfP001qH7m3OgWFL/gNpia0L9orPrO66phrr47001YTlw8J2WWj5ylja8v3vENh5TPgpT6Vu+r6d1VIZPSx1o0CCHQxYvhIyY0J12yX4RN+T2dS2VWfL4WvgtSxbuUwbTM7yve9uKxz+yHl7//CiHR4x1HSdU0bJc/bLAVaWRuzXz8OOyL00sxUXIIvpWXBsgJwKAKcz+X0jhdarlBRvvYbI6siU1FT1a22PyO1VQQ9zZnqgHCTMcbMuVrseU/CqKIOpyf/P33SHrSAaSlQGbZHcBziZoQQXQaAFRV/yZjzwsVORujvrCsFW5krzuWkJiHp3FNstvIWiRUGskcYgJWq+AFtErkOR6xphDP/nXyw/qB1W32oAWh5bWccSxka1SlAzlbcqL2Girg1/TlxhuJYhyUiOKCkpmehzvUUW00J08ZDrnpi+3BkDXzkzi6W+7E5l+OiaAojw9ta6uLYMmA0XQElFGcG8FjNzo/E3asihltOkRwb/tFrrptCY8gB1eKNF1bnukFSiQmTmTyNUeHtDwdfgtQxIlNDUuL73PJboH+CCIA=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(30052699003)(23010399003)(376014)(35042699022)(14060799003)(7416014)(1800799024)(82310400026)(36860700016)(261021123027099003)(261021121427099003)(4143699003)(11063799006)(5023799004)(56012099006)(261009223027099003)(261028144727099003)(261026121527099003)(261026140227099003)(261022105027099003)(261022075727099003)(10067099003)(22082099003)(18002099003)(6133799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LV185ruuC7i1gZht5oOI7wcmWVgOrwbZfkZ98k0kZaw/jNj649MuTnniMcoGqe3GFuPiXZoSIWNGgkzFuWsNoUEKLViuLAFXLnj5ooLxwlLVGsQhN+EMroGO7RZ3n3c61S4w8deWHRilNAHzPvgqRhoDPgjULPABF3OLNXtIKlu3ZQWl86BtEyhJ5/RbYW6jAhnsaa2jbgYBryNSS8djHZ9/VoMLh5QUc0HPGPYHzg7qRv0MDaCR2S+SaLTqCq8gt6myoTIvt1GiwGCYqVacQVO3PcfcJ5D1DxWltS03g0uOVu08DXyF0k7aFKHjIoA99lM9FZ3vlmV/gnpsPBvRUu+tehrkRkk+gdQFOUuBjv097Sh4Wh72h4Gm16uci1myDGbkuRGSCf7aM4+ewD3FGBmuxGKjLWP1JiwIyzAgXaC9vZ8kh3M5cGd/04cDydBC
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 11:33:57.1524
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7dacfeb-dbb5-49f2-2646-08df38d52eb2
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000009D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11268


On 10/30/26 22:40, Jonathan Cameron wrote:
> On Fri, 30 Oct 2026 18:16:06 +0100
> Pierre Gondois <pierre.gondois@arm.com> wrote:
>
>> On 10/30/26 16:19, Jonathan Cameron wrote:
>>> On Fri, 30 Oct 2026 12:51:47 +0100
>>> Pierre Gondois <pierre.gondois@arm.com> wrote:
>>>   
>>>> On 10/25/26 00:05, Ashok Raj wrote:
>>>>> On Fri, Oct 23, 2026 at 05:04:05PM -0700, Jonathan Cameron wrote:
>>>>>> On Sat, 24 Oct 2026 00:40:33 +0200
>>>>>> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
>>>>>>      
>>>>>>> On Fri, 23 Oct 2026 14:26:21 -0700
>>>>>>> Jonathan Cameron <jonathan.cameron@oss.qualcomm.com> wrote:
>>>>>>>      
>>>>>>>> On Thu, 22 Oct 2026 09:07:25 +0200
>>>>>>>> Pierre Gondois <pierre.gondois@arm.com> wrote:
>>>>>>>>          
>>>>>>>>> On 10/20/26 19:10, Jonathan Cameron wrote:
>>>>>>>>>> On Mon, 19 Oct 2026 22:38:39 +0200
>>>>>>>>>> Pierre Gondois <pierre.gondois@arm.com> wrote:
>>>>>>>>>>             
>>>>>>>>>>> The support is mostly duplicated from Memory Error Section handling.
>>>>>>>>>>> Other than differences coming from the content of  Memory Error
>>>>>>>>>>> Section 1 and 2, differences in the support are:
>>>>>>>>>>>
>>>>>>>>>>> - v2 do not rely on a compact "struct cper_mem_err_compact" struct.
>>>>>>>>>>> This structure was used to support older versions of the Memory
>>>>>>>>>>> Error Section (1). This is not needed for the new structure.
>>>>>>>>>>>
>>>>>>>>>>> - The compact version is also used by the tracing framework.
>>>>>>>>>>> To avoid relying and propagating a non-standard record format,
>>>>>>>>>>> through trace event (cf. extlog_mem event) the new trace event
>>>>>>>>>>> prints each field individually.
>>>>>>>>>>>
>>>>>>>>>>> The last patch of the serie was only build-tested due to the
>>>>>>>>>>> absence of relevant hardware. apei_mce_report_mem_error() and
>>>>>>>>>>> arch_apei_report_mem_error() implementations were also removed since
>>>>>>>>>>> last version.
>>>>>>>>>>>
>>>>>>>>>>> It will also require a proper handling from the rasdaemon. Applying
>>>>>>>>>>> this last patch without rasdaemon support will silent the reports of
>>>>>>>>>>> Memory Error Section 2 error, cf. ras_userspace_consumers() check.
>>>>>>>>>> Hi Pierre,
>>>>>>>>>>
>>>>>>>>>> I'd slow down a bit.  We are mid merge window and convention is normally
>>>>>>>>>> one version a week or so anyway.  Better to gather up feedback from
>>>>>>>>>> a number of folk and spin only one revision to cover it all.
>>>>>>>>>>             
>>>>>>>>> Hello Jonathan,
>>>>>>>>>
>>>>>>>>> Ok sure, as the v1 was reviewed quickly I thought there was a chance
>>>>>>>>> of having the serie accepted quickly aswell. I ll wait a bit more.
>>>>>>>>>
>>>>>>>>> Thanks for the review,
>>>>>>>>>
>>>>>>>>> Pierre
>>>>>>>>>            
>>>>>>>> A general question that came up in a related thread with one of
>>>>>>>> our RAS architects. How does firmware decide what to send?  As far as
>>>>>>>> I can tell firwmare has no way to know whether the OS understands the CPER
>>>>>>>> Memory Section 2.
>>>>>>>>
>>>>>>>> So options that come to mind.
>>>>>>>> 1. Firmware must send a CPER with both Memory Section and Memory Section 2.
>>>>>>> Please don't do this: this would require either Kernespace or userspace to
>>>>>>> discard one of the reports, only if the other one is there, which can be
>>>>>>> tricky. Could be done more easily at userspace, but only if some database
>>>>>>> support is enabled, but, at least on rasdaemon, this is an optional module.
>>>>>> Good. That confirms my view that is horrible.
>>>>> Hi Jonathan,
>>>>>
>>>>> I agree that an _OSC capability is the right long-term solution.
>>>>>
>>>>> Firmware should select one native CPER format based on OS support, rather
>>>>> than emit both Section 1 and Section 2 and leave deduplication to the OS
>>>>> or userspace.
>>>>>
>>>>> For a Section 2-capable kernel, we may still avoid a second GHES notifier
>>>>> chain: preserve the existing struct cper_sec_mem_err * contract and give
>>>>> it a lossy Section 1 projection of a Section 2 record. The conversion must
>>>>> translate validation bits and clear validity for values that cannot be
>>>>> represented, rather than truncate them.
>>>> I understand we might want to emit a new extlog_mem2_event and a lossy
>>>> extlog_mem_event for legacy userspace, but I'm not sure to follow how
>>>> you want to do it.
>>>>
>>>> Do you suggest that we only need one notifier (ghes_report_mem_chain)
>>>> and that we should not add ghes_report_mem2_chain ? This would mean
>>>> that the .notifier_call (= ghes_edac_report_mem_error) should handle
>>>> both cper_sec_mem_err/cper_sec_mem_err2 struct.
>>>>
>>>> Another solution would be to keep the ghes_report_mem2_chain,
>>>> which would be responsible of creating the lossy v1 struct and
>>>> triggering the original ghes_report_mem_chain.

[1] Not sure about the outcome of the above.

>>>>   
>>>>> That preserves legacy EDAC consumers, but cannot carry all Section 2 data.
>>>>> Updated userspace needs the native Section 2 payload through a
>>>>> full-fidelity path, such as the existing GUID-tagged raw CPER event.
>>>>>
>>>>> This does mean an updated userspace listener may receive both the legacy
>>>>> EDAC summary and the raw Section 2 record for the same firmware error.
>>>>> They are two kernel views, not two firmware reports. We should therefore
>>>>> add a shared GHES record/section ID to both events, so userspace can
>>>>> correlate them reliably; address and timestamp are not sufficient.
>>>>>
>>>>> So _OSC solves firmware selection for old versus new kernels, while a
>>>>> Section 1 projection plus the raw payload handles legacy versus updated
>>>>> consumers on a new kernel.
>>>>>
>>>>> Thoughts?
>>>> This will put more burden on the firmware, but this seems the right
>>>> thing to do. I ll share the thread with the group working more closely
>>>> on the architecture aswell,
>>> We have will have a code first proposal for the _OSC part shortly. Just going
>>> through internal review.  I'll make sure you + others here are on the +CC.
>> Ok thanks,
>> If you can also also add Mark Brown <broonie@kernel.org>
>>
> https://lore.kernel.org/linux-acpi/20261030143802.0000231d@oss.qualcomm.com/
>
> I started a new thread so it wasn't too buried.

Thanks !

Just to be sure, the _OSC discussion should not prevent this patchset
to proceed right ? I think there is only [1] which I m not sure about the
outcome otherwise,

Regards,

Pierre

