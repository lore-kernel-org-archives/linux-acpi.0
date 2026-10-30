Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=2 smtp.remote-ip=52.101.65.3
ARC-Seal: i=3; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793361176;
	b=I/KwLm3pKYGvQI2reET56kKjiwE4MjGnc2dl3AsMZsqik4qbvdGA9bk0cNpIZLvb2xTW
	 XR0Nr/Ru5IcpAuUe4ykK5izSB26o0e+pZ7t/gvkzbKWqOYeiNMhR4b/c5OS43bypV/L/w
	 ZHIO69tTvlDQtXdYk0U6Q3sC38ZQHSNF7zUGVREqCBnwkAtLdlQfQWghIowqLuqpFIfnB
	 ASK1qsM3li25GESjt6G5m521KpNXDuOZrcUV+6w91w8TnuRmFChZycTK1iQ1+U+4PRicH
	 tT3wONWMbP4qunWQraLoGuYkVmx6GyPcfL2f6boGC7WS+cQBSsYKJiwJ2TY3L+ds40g==
ARC-Message-Signature: i=3; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793361176;
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
	bh=KP1LaiyWoYyhlNEf+wYSaK42cBNjkqMOoCFpQ05XOjA=;
	b=fkfcY6u4GdLe2puPAY14GF/hLd1GREq/z7R9nQ+qsVQVUC8cPwme25c+c8dfmH4F9A7z
	 xY7JJI4EE3h6/wsMRJvkd0P00MS5iyhAewXp839chnJyp/hEQNPr3uZsiIxFHp0oOmDRE
	 hIY9ff8Oe3qvKj01iSBoCrbAhdleEXIPL2C5x62VZYu1V1GlP7q+i6XG6lqP5GuYpo0yH
	 KNwqF1JH8V8VUclL7abGXVxqCkg2Cc2gxCSBbyElqytSZ8PurxJlpfkKpGCxNgSd+lOrg
	 MgadO+wsC+nih9Mrcb+BbOH/QakrrqqcP3+zMMSflGcm+Ro5d0REX9ubXKVhZsiUP3A==
ARC-Authentication-Results: i=3; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=WdSBcreL;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=WdSBcreL;
	arc=pass header.oldest-pass=2 smtp.remote-ip=52.101.65.3
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011003.outbound.protection.outlook.com [52.101.65.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46A060A2618;
	Fri, 30 Oct 2026 11:52:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A46A060A2618
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=WdSBcreL;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=WdSBcreL
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=q6ljCrKSU87LfFy/Khk0NnII/9X7nEbGXDsO9UZATTDTq+MXEOwKfKZUcVt9DK1tTaV0A1bhpG8sbu89g2p3JdAH1+qbb65iOvWtvqTXT9oM8f3WE71kDt6x0SO6dIkYaT2lwN1sjAObhFUBsFXwYu1r5r1T+GfP1CHRTQpqoYUIIYXI7qaqKZtL2p8mKCl7xzqxe9qHn8Tq0W9+bEoMt93W8i5p8JWzo/I3yC0aSYA5L7dTLtarJp+6SbctZsmTypfW5Xp/rggoqWtocdsZwX/Y8piWSH7dwYpADaDjD9iQTmB6jzsMhYWhjELFKo+GZz5Djcm+R16Bt07/ZqvdTg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KP1LaiyWoYyhlNEf+wYSaK42cBNjkqMOoCFpQ05XOjA=;
 b=N+ttspzjNUFYLC9z1sElIEexTLzUoBmIqYd2C1IRPANIc9DrIQXhvTav611epBBraCy8Lbn12241Drwmhmp7ehWanWSEgkCAfhY1E+Mjhk+DhmlmcTVkFPYkxogU2eA12wgayUJO9a7Vf5DulIvmjtqMCYn8jVV88gdLJgNhJcZSWwCjFIvCVw2gNK+rjPZLp+/E5X8NMP+i2+yYC/19tOOIfTqvrgCOHwWr6UXAYIYR8QoIouIsJs5XMe56JT14OtQPN5Ov4c1U4/vJrXLptOwkytwlMv5tqUfvr2PCbPycnb7uIsaj+UmJhcbo2fPbVGE1qPCQT5MMyB0TN27iUQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=oss.qualcomm.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KP1LaiyWoYyhlNEf+wYSaK42cBNjkqMOoCFpQ05XOjA=;
 b=WdSBcreL+VEG5thSj/cAEKRuA0gQLJCsnMwlU0NL8bAjbFelF3FobOIOn9/Rqgev1uwuhLyiUKai7qukX+spnQzF16/mD+HmR9oMvpK6XvZ9HdLmmxXObC8IasG/WNvsG/IAq8wmGsAI3cxW4FMXC2hfRQvMZQ5P3OLxrd1vTbc=
Received: from DU7P191CA0027.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:54e::29)
 by PAWPR08MB10899.eurprd08.prod.outlook.com (2603:10a6:102:46e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 11:52:49 +0000
Received: from DB1PEPF000509F1.eurprd03.prod.outlook.com
 (2603:10a6:10:54e:cafe::3d) by DU7P191CA0027.outlook.office365.com
 (2603:10a6:10:54e::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.9 via Frontend Transport; Fri, 30
 Oct 2026 11:52:49 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509F1.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15
 via Frontend Transport; Fri, 30 Oct 2026 11:52:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kcjx4dEPMokTkcTurmX1lLSJMlmxDkANLeMdjTGVdVAe/m4/HjiyPjOG8TMNf2M+rM16rWU9JBvQtKNwBILAS0CeCPuVB5cMSXIreEkpIMH4JOax5YU0ag0uZejrrZLbjM89N+HO60pstQihDNOdvdNqlfinDF/juGjPEDLvgnjSjrB47h73LyZsRZTezCcMHDoMnVSFuv/sBcnzbhRZCABPVr5MHOQ+ELr6u+g2FJRv6c9UNFkKNCyWusXy4WWkMb4o9OY3AP5GAjKWVwsSJmzkbpGdMYBi2ZU0QVOH6haDNWI8l/tjs38Oi7myez8tPtNmp9eNIs0wwO7oQeQgWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KP1LaiyWoYyhlNEf+wYSaK42cBNjkqMOoCFpQ05XOjA=;
 b=a1xTtmrPVC4en302XvOmpttR0staO7NRLYGoircXLDOcrA+nG8KDyKaZFG3IuhH06jlNLRQsLfKiagntszjoKqK4ZwL7d4L4V+SIqBuyeN5Aw5zDxGZHcpQVu8BgRwSdxfKVGtzb2SuV9shWKkIumzQLmtkbGN5e72/0u6Rz97gL7LU8/P9pe2XTe9Zk0oI2av8CJy/Fw/mjAD+D1qdxK1lnCFaYqmvQ1BqGj+z4kHZkCBqJqulb3QxvsKnZk/nFAgfBkPB8LC8D/5UQtCRU82n5udddh/9KU67dF7otPtNukKB2AX5M1DWh+9ElmgcbhdoMalYXPVEwnjiclCo7/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KP1LaiyWoYyhlNEf+wYSaK42cBNjkqMOoCFpQ05XOjA=;
 b=WdSBcreL+VEG5thSj/cAEKRuA0gQLJCsnMwlU0NL8bAjbFelF3FobOIOn9/Rqgev1uwuhLyiUKai7qukX+spnQzF16/mD+HmR9oMvpK6XvZ9HdLmmxXObC8IasG/WNvsG/IAq8wmGsAI3cxW4FMXC2hfRQvMZQ5P3OLxrd1vTbc=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from BESPR08MB999898.eurprd08.prod.outlook.com
 (2603:10a6:b10:109::23) by PAWPR08MB9590.eurprd08.prod.outlook.com
 (2603:10a6:102:2e8::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Fri, 30 Oct
 2026 11:52:08 +0000
Received: from BESPR08MB999898.eurprd08.prod.outlook.com
 ([fe80::d62a:5300:bc89:9f62]) by BESPR08MB999898.eurprd08.prod.outlook.com
 ([fe80::d62a:5300:bc89:9f62%6]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 11:52:08 +0000
Message-ID: <43301529-f169-493c-bc59-fa08b77e1ef3@arm.com>
Date: Fri, 30 Oct 2026 12:51:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] CPER: Add Memory Error Section 2 support
To: Ashok Raj <ashok.raj@oss.qualcomm.com>,
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
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
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <at0rs4parlHFGI7k@hu-ashoraj-lv.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P251CA0023.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:102:b5::10) To BESPR08MB999898.eurprd08.prod.outlook.com
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
	BESPR08MB999898:EE_|PAWPR08MB9590:EE_|DB1PEPF000509F1:EE_|PAWPR08MB10899:EE_
X-MS-Office365-Filtering-Correlation-Id: 565bf476-11a3-469a-6448-08df367c51b7
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|376014|7416014|10070799003|1800799024|23010399003|6133799003|22082099003|18002099003|261026121527099003|4143699003|56012099006|11063799006|5023799004|261021121427099003|10067099003|261009223027099003|261022105027099003|261021135927099003|261021123027099003|261022075727099003|261028144727099003|261026140227099003;
X-Microsoft-Antispam-Message-Info-Original:
 es8J7emo5CPkisUl3kR/BelspkMLZNL8a9VdzTqzNpbyg2Kgqew6vxTfnf/aMhF+QUkUkbKt1qd8s37SXOrg5tqzdC6+3cqIt2otY7xka1tLSu/bZPuF9fEUnehMvet7tm4vEdxwSXHfNd6SWIbJUhB1SWihmEfmfgA+1e6QDnEJyBq5BaQpkfu+4sajqXMHI7aiJuD9lt5OGrAh+oGXgpN8sgtMqgeRpfdPZxaLTAG33EgDiMoZxpfi1IYOFWxZHR1t7cWsrUswZkh+XCHEgIfVJwtMP62nZ0EPwmy1ZeiGJyIWzV2vVjOEHfQQnpK4Eg/K2BnxQ0kjXuILD4KHfiIDACnubJJYDxYZ4WDUJl7syXCHGBjqGwEbz38kSBzcim+jhIOgOpvAiY19M9qB8cKvLfdqQAjmIT+mvobdIB91xQ42tTKknHAqsToqUlMmA+vZGzYjI3UznYcXN1Vss8xH35BufFao0Wq+VYMmzDAcg5eQiVJdlUMEkd2E4GW0DC9xOl7aiGXuw549BavPxLB7FasbGl8ykpQ7AmNGXmZOZTOdcfuamluaJKZZsV0Ucka82eXdaqVRJv9deAH64Jsp08G3uDpiSRDcnoJ/UOVy6r7vExEjSrkur4wNN0UIgB8u4R+yHE+DHb8Gqu/B6b9YX3g3dthITUt17wQhwYE=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BESPR08MB999898.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(10070799003)(1800799024)(23010399003)(6133799003)(22082099003)(18002099003)(261026121527099003)(4143699003)(56012099006)(11063799006)(5023799004)(261021121427099003)(10067099003)(261009223027099003)(261022105027099003)(261021135927099003)(261021123027099003)(261022075727099003)(261028144727099003)(261026140227099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 30x/5hde4ipS7+MWUeQcoYtiX4ixBf2kuuvqz23evonK+i8Pl/QO0DWKCqw32t2lFaP/P5q9GcR7+6ONn4SyWh4McugjS2iOLUk4wVUdqab1F2qdeZ1AYX1hohpKbUPkltquTSzl30nxbK0T6rmVMUifECZRCL/eqKnHB83Ghjz7iGN/g+b0FHwLvgZNspF++yB3r/S7oIcKWDpeaSJyvx9os0WNw1gTsSX0igv3Z08LizHt+Nmq6J+Y3j3RcED2rSAjWdhUARWo2a/IN50jwmQkTLUKjHGnqsgAjYW5y11owqkjrzy7tFJ/pq/1h7lFXNMjGRJTnk80IcBPzYRvSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9590
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509F1.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	4d696b4b-71b3-4613-1bfc-08df367c39ab
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|36860700016|82310400026|35042699022|7416014|30052699003|376014|23010399003|1800799024|6133799003|18002099003|22082099003|56012099006|11063799006|5023799004|261022105027099003|261022075727099003|10067099003|261021135927099003|261021123027099003|261021121427099003|4143699003|261009223027099003|261028144727099003|261026121527099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	3N2sp2dFrwtFgBBEpcb4d/rPssQEwW76/EQKsqumIZXDGn5cyglhdCxIaRqNHiwWlrfYAiwdf8fGWeseB61Y4e3JVvth73qltlwGWj6J3CsP3cl9kDu9AqDgt5S9SXgzTd3MnwZb8TZ4xawrG3jKF5uYg1SOwtFxMJmSCcx/ginbjOLTy2Fe0/2xNhLa/w79GKMKdbMK8V21IvqxiVfPB2jPi3oxbUydEORxsaJEVLSrRehtfFVn8WXkncFAmjeOzWb52RhVni21RWziGaBWH4tHLJGrWaIRQD6unYwOrZjMRhAX7bCrbIwF2s1yind6PzBed8FqY8wzmU1npN32GVd6URGxZy+05MdtbsqI7wl+eI/CkXcUiV3BhuurzKBsumiPpY7Ik3oIVLl/MMY+qIEaGTv2UMREcHtYTSVJQ1JQKEWC2bH1iWH6OvHCli+m9zia7anmP+MA+3kYd1ouH5ZPVoPf3ejvw+iG+zObM/chU00Se4qGbRhLKBrt8lf2Zqdudj78J0T7QS5PNvSx1s+n79ja+x4YofEvD2iGGGQHbaI8/P8lIyQUiqe2Cqcl4tV0JxIEFOLAfO7ou9Yc1m8MjXfoNckfWvl5NrmHguYNbnpqw5A9lcDoEFZv723Z/zjtCJmLy9uldZbUisWhh45hMXUSRrSiXUxc35ZwKA08LCpVzfVO6tzg+S9SAp7XYg3BGNP2gaK8DCOp8eW6pw==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(36860700016)(82310400026)(35042699022)(7416014)(30052699003)(376014)(23010399003)(1800799024)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(5023799004)(261022105027099003)(261022075727099003)(10067099003)(261021135927099003)(261021123027099003)(261021121427099003)(4143699003)(261009223027099003)(261028144727099003)(261026121527099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xvsxcpQtmEvTBR/daeho441u/lG4v9oHhN88eWUk8H3HXkQKFOSh+hW2TiWBkKTzYugpfI9MGXAC7ILbrxhnu075wWqwbebmln2JP45BE9HMm98mVG8VGELPBcRRRYfvjVdZYdAL5yBb9QC5nJvKFLQb44qxmHNiDIJlt0bOoJmo66q32m/SEA3JXG0wJY3qc51Jrg8aPo/88CJKTJXpDbGs9HRpMNEbFzeXKxwBBLDWnokgsZOlBC7p6clVoNjMfu3KkibL2XzMedUrDSF4rxbIKwyLcKfrpsq2ohLVlFsCRPl2iutvX6n3jB1mQqXWkaF+54QKAWffHKS79GpBdFXXqTZVObat05DFMqta8jX8BdrAjUHVgt3qQ1gvxPbQIm7bEESXl4JiAPmHx78NaTmNixy6QgunnCDXMbpDu1A9G6CpLZcFhgC3LjpEAowU
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 11:52:48.3615
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 565bf476-11a3-469a-6448-08df367c51b7
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F1.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB10899


On 10/25/26 00:05, Ashok Raj wrote:
> On Fri, Oct 23, 2026 at 05:04:05PM -0700, Jonathan Cameron wrote:
>> On Sat, 24 Oct 2026 00:40:33 +0200
>> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
>>
>>> On Fri, 23 Oct 2026 14:26:21 -0700
>>> Jonathan Cameron <jonathan.cameron@oss.qualcomm.com> wrote:
>>>
>>>> On Thu, 22 Oct 2026 09:07:25 +0200
>>>> Pierre Gondois <pierre.gondois@arm.com> wrote:
>>>>    
>>>>> On 10/20/26 19:10, Jonathan Cameron wrote:
>>>>>> On Mon, 19 Oct 2026 22:38:39 +0200
>>>>>> Pierre Gondois <pierre.gondois@arm.com> wrote:
>>>>>>       
>>>>>>> The support is mostly duplicated from Memory Error Section handling.
>>>>>>> Other than differences coming from the content of  Memory Error
>>>>>>> Section 1 and 2, differences in the support are:
>>>>>>>
>>>>>>> - v2 do not rely on a compact "struct cper_mem_err_compact" struct.
>>>>>>> This structure was used to support older versions of the Memory
>>>>>>> Error Section (1). This is not needed for the new structure.
>>>>>>>
>>>>>>> - The compact version is also used by the tracing framework.
>>>>>>> To avoid relying and propagating a non-standard record format,
>>>>>>> through trace event (cf. extlog_mem event) the new trace event
>>>>>>> prints each field individually.
>>>>>>>
>>>>>>> The last patch of the serie was only build-tested due to the
>>>>>>> absence of relevant hardware. apei_mce_report_mem_error() and
>>>>>>> arch_apei_report_mem_error() implementations were also removed since
>>>>>>> last version.
>>>>>>>
>>>>>>> It will also require a proper handling from the rasdaemon. Applying
>>>>>>> this last patch without rasdaemon support will silent the reports of
>>>>>>> Memory Error Section 2 error, cf. ras_userspace_consumers() check.
>>>>>> Hi Pierre,
>>>>>>
>>>>>> I'd slow down a bit.  We are mid merge window and convention is normally
>>>>>> one version a week or so anyway.  Better to gather up feedback from
>>>>>> a number of folk and spin only one revision to cover it all.
>>>>>>       
>>>>> Hello Jonathan,
>>>>>
>>>>> Ok sure, as the v1 was reviewed quickly I thought there was a chance
>>>>> of having the serie accepted quickly aswell. I ll wait a bit more.
>>>>>
>>>>> Thanks for the review,
>>>>>
>>>>> Pierre
>>>>>      
>>>> A general question that came up in a related thread with one of
>>>> our RAS architects. How does firmware decide what to send?  As far as
>>>> I can tell firwmare has no way to know whether the OS understands the CPER
>>>> Memory Section 2.
>>>>
>>>> So options that come to mind.
>>>> 1. Firmware must send a CPER with both Memory Section and Memory Section 2.
>>> Please don't do this: this would require either Kernespace or userspace to
>>> discard one of the reports, only if the other one is there, which can be
>>> tricky. Could be done more easily at userspace, but only if some database
>>> support is enabled, but, at least on rasdaemon, this is an optional module.
>> Good. That confirms my view that is horrible.
> Hi Jonathan,
>
> I agree that an _OSC capability is the right long-term solution.
>
> Firmware should select one native CPER format based on OS support, rather
> than emit both Section 1 and Section 2 and leave deduplication to the OS
> or userspace.
>
> For a Section 2-capable kernel, we may still avoid a second GHES notifier
> chain: preserve the existing struct cper_sec_mem_err * contract and give
> it a lossy Section 1 projection of a Section 2 record. The conversion must
> translate validation bits and clear validity for values that cannot be
> represented, rather than truncate them.

I understand we might want to emit a new extlog_mem2_event and a lossy
extlog_mem_event for legacy userspace, but I'm not sure to follow how
you want to do it.

Do you suggest that we only need one notifier (ghes_report_mem_chain)
and that we should not add ghes_report_mem2_chain ? This would mean
that the .notifier_call (= ghes_edac_report_mem_error) should handle
both cper_sec_mem_err/cper_sec_mem_err2 struct.

Another solution would be to keep the ghes_report_mem2_chain,
which would be responsible of creating the lossy v1 struct and
triggering the original ghes_report_mem_chain.

> That preserves legacy EDAC consumers, but cannot carry all Section 2 data.
> Updated userspace needs the native Section 2 payload through a
> full-fidelity path, such as the existing GUID-tagged raw CPER event.
>
> This does mean an updated userspace listener may receive both the legacy
> EDAC summary and the raw Section 2 record for the same firmware error.
> They are two kernel views, not two firmware reports. We should therefore
> add a shared GHES record/section ID to both events, so userspace can
> correlate them reliably; address and timestamp are not sufficient.
>
> So _OSC solves firmware selection for old versus new kernels, while a
> Section 1 projection plus the raw payload handles legacy versus updated
> consumers on a new kernel.
>
> Thoughts?

This will put more burden on the firmware, but this seems the right
thing to do. I ll share the thread with the group working more closely
on the architecture aswell,

Regards,

Pierre


> Thanks,
> Ashok
>>>> 2. For whatever other reason a platform knows it doesn't work with old kernel
>>>>     so can assume support in kernel and hopefully userspace got updated too.
>>>>
>>>> 3. We propose some additional discoverability (quickly - code first) to ACPI
>>>>     so that it can be a negotiated contract between OS and firmware.
>>>>     Until the OS confirms it understands Memory Section 2, firmware has to send
>>>>     the older one (or risk the record not being understood).  After that
>>>>     negotiation it can do what it likes - probably send the Memory Section 2 form.
>>>>
>>>> Option 1 and 2 are ugly at best.
>>>>
>>>> Obvious path to me for option 3 is an _OSC like the one for generic initiators
>>>> that we discovered a need for whilst implementing that years ago.
>>>>
>>>> Anyhow have a better idea?  The above doesn't solve the end to end problem as
>>>> maybe userspace still has no idea what this new tracepoint is, but at least gets
>>>> us past hop 1 (so through the kernel).
>>>>
>>>> If we conclude _OSC plan works I'll draft a code first proposal.
>>>>
>>>> Jonathan
>> On another note, Pierre, any plans to actually enable a path to the tracepoints
>> on arm64?  Today they only emerge from acpi_extlog which is x86 only.
>>
>> We definitely want the richer data for PFA and obviously for userspace nice
>> to share tracepoints with extlog.
>>
>> Jonathan
>>
>>
>>> Regards,
>>> Mauro
