Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013005.outbound.protection.outlook.com [52.101.72.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626672FE575;
	Wed, 11 Mar 2026 13:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.5
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773235196; cv=fail; b=rj3c4Vxz6F0figdOtlZsFGwi3J/Ldl3685eDhLVBDe8WkAgCnHa5S1PQUk0//x438Qetl+ue1ldPc7z5a4QV0g/sLku6pIM5mgxrtXHsTYuJWIdgH99QnmvaO1NCPsQr6QGtHpUTE5xrOKYXYWrvWye+KWV94PAuBNH8sTOWCpo=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773235196; c=relaxed/simple;
	bh=h2nSgBmdiUkMjpXhQpaVFQMFnre0iV3ytW6Ui/oLiFw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gb4hs5Jv763huMs6Dh+4BQUtw8FXutNTSxOrEQlDV0Syllan4pER9aW2KvxQp89yaLizXtsbjtSdno3XwxERblqzX5iIumzNouc90vwTC/4Pp3eK3yVxeF6HDxF/BqIOeYjPHugrTGtMBpOP5q8CHd3XxkKC9WfObUB9Ueoot84=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=AO4ygi3F; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=AO4ygi3F; arc=fail smtp.client-ip=52.101.72.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="AO4ygi3F";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="AO4ygi3F"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=nPvx4jgAA/X7D6W2ukmaSrVzu72gsytigvsvpTiIR7mhzZAQXeWXv3sxQ1jjRCIJf1bTaVCYH7bBXlqkFuyKFXOz7CyJ5cxbg6lruwg6AVunITvTzWtAhQABkFTf+CLRuzdJcv6m/rfftYduF5bHYQZ1vjJw0Pp74BE/62r6bDTMKNTd3UZsRTEVfb9z3W4PPacBWVTAF6uMCwlei6ZZs7jJnxiBjnn2wAUCmw6kZelvAYfPkh9ijsZlx3jR2jxenqg6wb808jo/8sk3sKuIMuyXfey42wxRz1utfNGeNeNt1wisnFmYpBPIwonRFG+4bs6HYpsg8ifpGd1hAxnj+g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XMEjRqdxPX/srP2bjicoAEzeWzubmUyoQp4REBg6JrE=;
 b=gRTP8q8lK5oXCIcJ8xCzuCvB4tLyBPlZFIUw18iPMZfVfiV+MKsebRLhdQ+scxC94RulUY7/gBkH+40VlTFyQCgv2ZiuoXdkRxazWDLtDUqONsT9XsOE4fnGP+9HH8BS2GK9TQlCqGd5bKpJtOWUJrfW7pLaeyxWgwgc3X1gNnM8BKPESWqDICnZ3XL3yE3v3JzA6M5t/vw8JmJp0Hgjs8PouRTk2318E+tdBJ1++hacz1Lq6VTZjLoZdzGVOX+/q5ry2VaITEwd5P990zc6sA0n7Kk5Rf63aA8VVyPaI7xQbdEAIcLVgxS5PZM5PsZy4DJRjTB8Zx7Lp0Rn6DukQQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=oss.qualcomm.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XMEjRqdxPX/srP2bjicoAEzeWzubmUyoQp4REBg6JrE=;
 b=AO4ygi3FcHC6ptIlolj+PJOTtQqcLI/L6WQH9h3al5jd7bqUhB+x71C7A/R81wNkB/NpHNxlZ1sAGCxs0aN1Oq7DQKQREbT+0/jyDcZK8eCzdtxAGubdUkUBlKRiuIrZLFb70F23QnnvQGQXvrCGJFvMem6J4sFYVwF3DTUM4UE=
Received: from DUZPR01CA0162.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::10) by AM9PR08MB6193.eurprd08.prod.outlook.com
 (2603:10a6:20b:282::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 13:19:46 +0000
Received: from DB5PEPF00014B9B.eurprd02.prod.outlook.com
 (2603:10a6:10:4bd:cafe::bc) by DUZPR01CA0162.outlook.office365.com
 (2603:10a6:10:4bd::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.26 via Frontend Transport; Wed,
 11 Mar 2026 13:19:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB5PEPF00014B9B.mail.protection.outlook.com (10.167.8.168) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18
 via Frontend Transport; Wed, 11 Mar 2026 13:19:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qz7rJKd1HxUWBgd2DRgj0DLUL5nIq8pgMZhmg9rdgFD5drR5Oa3RTMoZxL1PtN5rCPkRv4wniGUV5+lCJzPD7hxTAb/3MRkS1j3NTxDuUIDzU7WWvKt0zIE4Y168U1wVvdUA6N00MpaAYhJTVEUUDxAOor0Yz2Gx+h5TMqr/AaOO9Ud71+EjN5RkMCdOgTMG3XbcD7KT09aRlWBHI7uSBuquE0ZzO8jVGyzvXZqlZJkiorByr22n8s1ksfl0IuySWV7i5a3rEw8Nwri6jYGiToXFvPJuldXKV8VE6qje8F0opBro+rYkqVLLhzX/kRQLTqeMzh0cr04rp5Zp4kdllA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XMEjRqdxPX/srP2bjicoAEzeWzubmUyoQp4REBg6JrE=;
 b=B9OJ+9idhOkEQv331LoqObtSIGc60yUOFXPhrFu9FSxkMdKuoUXWs5lHZT1/lc3PtD0YenSsq1RERFSn/zEw/k0CwCPjO4QZYRVEmgSlfP+P4GJbe7vuPYQ4WuSrhJasqZ9GWGCV0mBAL5+rsxqRJrUJRi5qUfZ3wWPgayd8Lo0oSTjiFDGIBpjn5KIH0boRudTIe0JkhCskHWoiH32WYA4MBy6wz7iPO6d9zGgWCHdw5BNPAwhuF6pICvWuKsvavjMhGO5CjHUBE3xx5uzJkKfKMv+Z8oyJPsGh0RzR4CY9lsTI8nbqsANnWWoIwoEp18Z3Gz+4oyWjSzA8bjQVmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XMEjRqdxPX/srP2bjicoAEzeWzubmUyoQp4REBg6JrE=;
 b=AO4ygi3FcHC6ptIlolj+PJOTtQqcLI/L6WQH9h3al5jd7bqUhB+x71C7A/R81wNkB/NpHNxlZ1sAGCxs0aN1Oq7DQKQREbT+0/jyDcZK8eCzdtxAGubdUkUBlKRiuIrZLFb70F23QnnvQGQXvrCGJFvMem6J4sFYVwF3DTUM4UE=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11823.eurprd08.prod.outlook.com (2603:10a6:800:324::5)
 by DU0PR08MB8930.eurprd08.prod.outlook.com (2603:10a6:10:465::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 13:18:41 +0000
Received: from VI0PR08MB11823.eurprd08.prod.outlook.com
 ([fe80::694c:3790:be1a:8ddd]) by VI0PR08MB11823.eurprd08.prod.outlook.com
 ([fe80::694c:3790:be1a:8ddd%5]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 13:18:41 +0000
Message-ID: <df306958-bb99-4728-b461-e5ef1f731be2@arm.com>
Date: Wed, 11 Mar 2026 13:18:28 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/11] ACPI: APEI: GHES: move CPER read helpers
Content-Language: en-GB
To: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Cc: devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
 Dmitry.Lamerov@arm.com, catalin.marinas@arm.com, bp@alien8.de,
 robh@kernel.org, rafael@kernel.org, will@kernel.org, conor@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 krzk+dt@kernel.org, Michael.Zhao2@arm.com, tony.luck@intel.com
References: <20260220-topics-ahmtib01-ras_ffh_arm_internal_review-v2-0-347fa2d7351b@arm.com>
 <20260220-topics-ahmtib01-ras_ffh_arm_internal_review-v2-3-347fa2d7351b@arm.com>
 <CA+Ht8=aL8wp0nwH3vnnm8FnRmfp1nUasfXh3HjeWwi8UadBLOg@mail.gmail.com>
From: Ahmed Tiba <ahmed.tiba@arm.com>
In-Reply-To: <CA+Ht8=aL8wp0nwH3vnnm8FnRmfp1nUasfXh3HjeWwi8UadBLOg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR3P189CA0020.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:52::25) To VI0PR08MB11823.eurprd08.prod.outlook.com
 (2603:10a6:800:324::5)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB11823:EE_|DU0PR08MB8930:EE_|DB5PEPF00014B9B:EE_|AM9PR08MB6193:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f749009-806c-4930-ce03-08de7f70dc56
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original:
 SPphcGGHx0UpW9/buHHnmYSEdPTAroFQkf9VRSdeQ1pCzTokY/YrWlNQODU+BuADQEv2/qSEiwKh6Z2a2L7lGTOAWf6vo2mSyhNxgUl+u7wz9GV9Rj4hX6V3pSQzIsl82bwRO5eVDeRQ5OCF6l+zUHn1uTWRQ9owTfM0IDjDlolBA0XLLrEzQ7V8sJCbLKmKigVMiyd1M+7FJL1G5I8cXYYEGldW73BQIcLDnLM9F5J7GYNnxoQpoxSSX7bR21K1EY3wQPN5CEpvVNF9UHRQmRZrE5tvcSVP/lkJyRNWb1aZsBVYWu5M54A94hU2W0x6gbLROJI3SNV1naKIrwwruxscWmlaFXZFQGmf2eKlonP8mnZm2ix61ECb2k4hzMKPnZyubuLNegJk5JHynGiHrdF1RGv+J9oXRQet39EPyf6Fx02bTRjFsqRdbZmAunS0OGLur/v2xnk64vfBDoOZlAoIgvVfYx4jJjVrAhWC+wwuvctl6mI2lQkkhqOkv19ri7I+h7cxgCJKJW/Wsw3cFdaVMfx5g5YWFxKqYmRn+gBFHlJNcRmBEkQPzeNc/BDnluSI7zlrsOj0T2CvMdAs7NO9iKQLUF995WEDeLEllsjDSamOWbNVnKKL4WDJF8bejQjrXkSRgTib/Y8aVa5NVd91Tw9drd72U0xjG9TTaNpgibsyYG/vOPTJZVo24WXUKaQh57EC3/c/xyVrlPqZLg7lvd/dKHopw1I4EommkIc=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB11823.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 idIC3lIFIGqIs+KanaejIGJzhxcgUgRE+B5+WmqpqoqXLcFZEmalM1qPgD/WKP36sdHu4ff/pgDs7pCU+xd7GeYvxUoHB518CoRdyFzqrDkkE+hrN3oCWnz5NtKGs14C8qhaSGNo8OErMsPUHGxW5U/W5v5XtN670pgh6vGBgZCq4dae3OHuDBoPQwanIq2pGF5se9rPG8y7hQO29QkJW3rmKVYGS4ZHkwgiU0XdNwMZzQ/CIOlZmBJuLn6PDVufwq3meLMroXNlMudruB7Ze6SN5A3xi8EanDtf3dCVftgwmFbadFCQdmKSzVKfsL49KpSxQV4XIZrszpRdGbQuLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8930
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B9B.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	9fce7bc6-6047-4c63-4003-08de7f70b6dc
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|35042699022|82310400026|7416014|376014|36860700016|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	nqZVqa5HhcmU6u76WqudRmqO3jHsNCgrXzhfbEj03H+A1KCgQHUJR90bkU2VYQVR0AfqTPJrXitwG8KIMohrYYmlhT2h1IE9CVWergtKzdTeS31djB1C/NDA7dHrPtesl+ze5i+8bwK8DK7GWGD/nDJ4Y9g1gf5gfTL6jehh5oDyAwXVPfYz+cqTQaF0McVorP5hyAGxkqM6OCbDRLADYk839EiqE+3YoBPruSfp8FTezvYU8Jixg42IUzzJS1XlvzkGuurWPRtnZMXn18JOCZF5GccvHKx1SjhwGk73NraXs0O/Pv8plg3dvS0dC1ktI5y72+rhfpsiNJRWl/Gfzg53zNKMCuI+EpcrqKv0SrxyyWUZ5JCrRMvf6hxtJh8532kjODIUJdIEo65Fy2Niy2osYw0Ph8HH8Fuxc2XWlU6oG/HVcQm5XDG9Ogn+lLWktmbo5rC45/m7tC8ndnDE3rVwNocte3B/F/g91iHNfrFs8SBwyC4MGgjOt0Bph+Y8DP2fna3jsOEBDXwvj7sUiyohcM9SZwZiD9q6GFbafuRb7kYyRbGnYEGg5rbCHj09+E72Wzf9UqY8m9Vs72orZbUVpdOemZKgjNPSdTULnlO8WULkxH46zk5HthHUYcePhkoZ6Hh6rtLcuR+2GeGTGtM7ssWc/xC5U+5SkWMi9B4qjjZWR4pKWF/0ib719bvultG/VoC69ixT/azNj7moGKIyGRkdtKRFq1Vz9xUzdAEkPT4QdrGy40vHnOKsG8dIx/Rl3xs0fVyAL1vs2H/YjA==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(35042699022)(82310400026)(7416014)(376014)(36860700016)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YZaewvNplqj7d1puvx0w/N29JeDDBCSrB3WEv0dlUTa/cLcL7OOzELIhdvJ4I+bHbzqj7pw6RDHjOt+PJLamPrYqWWdzPW/qGNx5g0Jh55qlrRvEReTodONn48Bh7cM/xgL1c2l3u+7iF4C8F+YwT0p2duETyaur6R1T3zYW+36fGP9BCf5a5zYJwItUDlOeNEcWN9am0eAGqakoJvW+sRzewER1V+tXDn4UxBt9xY+o94zzHIZA914IAua1xUfDnyggNYuBvyBDUOILU3IWXwazRd47Qx9wEnkf7pyl+9IQFc00VJJFfWBmFtzJfEJGY1YlqNZkoTtXUw5gqEB4aQUoXFKRPLS9TvhMDfx9BgaBKg/1hKw2kCQ9AJq8CkqKGdI50hznkSQUPQ8E+9mVsKXRoe2+T4kPwLIwhVycZJikKYcgl0CowpLZrrjeQrcJ
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 13:19:44.1740
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f749009-806c-4930-ce03-08de7f70dc56
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B9B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6193

On 26/02/2026 05:58, Himanshu Chauhan wrote:
> On Fri, Feb 20, 2026 at 7:13 PM Ahmed Tiba <ahmed.tiba@arm.com> wrote:
>>
>> Relocate the CPER buffer mapping, peek, and clear helpers from ghes.c into
>> ghes_cper.c so they can be shared with other firmware-first providers.
>> This commit only shuffles code; behavior stays the same.
>>
>> Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>
>> ---
>>   drivers/acpi/apei/ghes.c      | 170 +-----------------------------------------
>>   drivers/acpi/apei/ghes_cper.c | 170 +++++++++++++++++++++++++++++++++++++++++-
>>   include/acpi/ghes_cper.h      |  14 ++--
>>   3 files changed, 177 insertions(+), 177 deletions(-)
>>
>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>> index 07b70bcb8342..b159dbee90ac 100644
>> --- a/drivers/acpi/apei/ghes.c
>> +++ b/drivers/acpi/apei/ghes.c
>> @@ -118,26 +118,6 @@ static struct gen_pool *ghes_estatus_pool;
>>   static struct ghes_estatus_cache __rcu *ghes_estatus_caches[GHES_ESTATUS_CACHES_SIZE];
>>   static atomic_t ghes_estatus_cache_alloced;
>>
>> -static void __iomem *ghes_map(u64 pfn, enum fixed_addresses fixmap_idx)
>> -{
>> -       phys_addr_t paddr;
>> -       pgprot_t prot;
>> -
>> -       paddr = PFN_PHYS(pfn);
>> -       prot = arch_apei_get_mem_attribute(paddr);
>> -       __set_fixmap(fixmap_idx, paddr, prot);
>> -
>> -       return (void __iomem *) __fix_to_virt(fixmap_idx);
>> -}
>> -
>> -static void ghes_unmap(void __iomem *vaddr, enum fixed_addresses fixmap_idx)
>> -{
>> -       int _idx = virt_to_fix((unsigned long)vaddr);
>> -
>> -       WARN_ON_ONCE(fixmap_idx != _idx);
>> -       clear_fixmap(fixmap_idx);
>> -}
>> -
>>   int ghes_estatus_pool_init(unsigned int num_ghes)
>>   {
>>          unsigned long addr, len;
>> @@ -193,22 +173,7 @@ static void unmap_gen_v2(struct ghes *ghes)
>>          apei_unmap_generic_address(&ghes->generic_v2->read_ack_register);
>>   }
>>
>> -static void ghes_ack_error(struct acpi_hest_generic_v2 *gv2)
>> -{
>> -       int rc;
>> -       u64 val = 0;
>> -
>> -       rc = apei_read(&val, &gv2->read_ack_register);
>> -       if (rc)
>> -               return;
>> -
>> -       val &= gv2->read_ack_preserve << gv2->read_ack_register.bit_offset;
>> -       val |= gv2->read_ack_write    << gv2->read_ack_register.bit_offset;
>> -
>> -       apei_write(val, &gv2->read_ack_register);
>> -}
>> -
>> -static struct ghes *ghes_new(struct acpi_hest_generic *generic)
>> +struct ghes *ghes_new(struct acpi_hest_generic *generic)
>>   {
>>          struct ghes *ghes;
>>          unsigned int error_block_length;
>> @@ -255,7 +220,7 @@ static struct ghes *ghes_new(struct acpi_hest_generic *generic)
>>          return ERR_PTR(rc);
>>   }
>>
>> -static void ghes_fini(struct ghes *ghes)
>> +void ghes_fini(struct ghes *ghes)
>>   {
>>          kfree(ghes->estatus);
>>          apei_unmap_generic_address(&ghes->generic->error_status_address);
>> @@ -280,137 +245,6 @@ static inline int ghes_severity(int severity)
>>          }
>>   }
> 
> Can it be "ghes_finish"? We already have "creat" without 'e'.

This is a pure mechanical move from ghes.c. I’m keeping the original
name here to avoid churn. If we want a rename, I can do that separately
with justification.

>>
>> -static void ghes_copy_tofrom_phys(void *buffer, u64 paddr, u32 len,
>> -                                 int from_phys,
>> -                                 enum fixed_addresses fixmap_idx)
>> -{
>> -       void __iomem *vaddr;
>> -       u64 offset;
>> -       u32 trunk;
>> -
>> -       while (len > 0) {
>> -               offset = paddr - (paddr & PAGE_MASK);
>> -               vaddr = ghes_map(PHYS_PFN(paddr), fixmap_idx);
>> -               trunk = PAGE_SIZE - offset;
>> -               trunk = min(trunk, len);
>> -               if (from_phys)
>> -                       memcpy_fromio(buffer, vaddr + offset, trunk);
>> -               else
>> -                       memcpy_toio(vaddr + offset, buffer, trunk);
>> -               len -= trunk;
>> -               paddr += trunk;
>> -               buffer += trunk;
>> -               ghes_unmap(vaddr, fixmap_idx);
>> -       }
>> -}
>> -
>> -/* Check the top-level record header has an appropriate size. */
>> -static int __ghes_check_estatus(struct ghes *ghes,
>> -                               struct acpi_hest_generic_status *estatus)
>> -{
>> -       u32 len = cper_estatus_len(estatus);
>> -       u32 max_len = min(ghes->generic->error_block_length,
>> -                         ghes->estatus_length);
>> -
>> -       if (len < sizeof(*estatus)) {
>> -               pr_warn_ratelimited(FW_WARN GHES_PFX "Truncated error status block!\n");
>> -               return -EIO;
>> -       }
>> -
>> -       if (!len || len > max_len) {
>> -               pr_warn_ratelimited(FW_WARN GHES_PFX "Invalid error status block length!\n");
>> -               return -EIO;
>> -       }
>> -
>> -       if (cper_estatus_check_header(estatus)) {
>> -               pr_warn_ratelimited(FW_WARN GHES_PFX "Invalid CPER header!\n");
>> -               return -EIO;
>> -       }
>> -
>> -       return 0;
>> -}
>> -
>> -/* Read the CPER block, returning its address, and header in estatus. */
>> -static int __ghes_peek_estatus(struct ghes *ghes,
>> -                              struct acpi_hest_generic_status *estatus,
>> -                              u64 *buf_paddr, enum fixed_addresses fixmap_idx)
>> -{
>> -       struct acpi_hest_generic *g = ghes->generic;
>> -       int rc;
>> -
>> -       rc = apei_read(buf_paddr, &g->error_status_address);
>> -       if (rc) {
>> -               *buf_paddr = 0;
>> -               pr_warn_ratelimited(FW_WARN GHES_PFX
>> -"Failed to read error status block address for hardware error source: %d.\n",
>> -                                  g->header.source_id);
>> -               return -EIO;
>> -       }
>> -       if (!*buf_paddr)
>> -               return -ENOENT;
>> -
>> -       ghes_copy_tofrom_phys(estatus, *buf_paddr, sizeof(*estatus), 1,
>> -                             fixmap_idx);
>> -       if (!estatus->block_status) {
>> -               *buf_paddr = 0;
>> -               return -ENOENT;
>> -       }
>> -
>> -       return 0;
>> -}
>> -
>> -static int __ghes_read_estatus(struct acpi_hest_generic_status *estatus,
>> -                              u64 buf_paddr, enum fixed_addresses fixmap_idx,
>> -                              size_t buf_len)
>> -{
>> -       ghes_copy_tofrom_phys(estatus, buf_paddr, buf_len, 1, fixmap_idx);
>> -       if (cper_estatus_check(estatus)) {
>> -               pr_warn_ratelimited(FW_WARN GHES_PFX
>> -                                   "Failed to read error status block!\n");
>> -               return -EIO;
>> -       }
>> -
>> -       return 0;
>> -}
>> -
>> -static int ghes_read_estatus(struct ghes *ghes,
>> -                            struct acpi_hest_generic_status *estatus,
>> -                            u64 *buf_paddr, enum fixed_addresses fixmap_idx)
>> -{
>> -       int rc;
>> -
>> -       rc = __ghes_peek_estatus(ghes, estatus, buf_paddr, fixmap_idx);
>> -       if (rc)
>> -               return rc;
>> -
>> -       rc = __ghes_check_estatus(ghes, estatus);
>> -       if (rc)
>> -               return rc;
>> -
>> -       return __ghes_read_estatus(estatus, *buf_paddr, fixmap_idx,
>> -                                  cper_estatus_len(estatus));
>> -}
>> -
>> -static void ghes_clear_estatus(struct ghes *ghes,
>> -                              struct acpi_hest_generic_status *estatus,
>> -                              u64 buf_paddr, enum fixed_addresses fixmap_idx)
>> -{
>> -       estatus->block_status = 0;
>> -
>> -       if (!buf_paddr)
>> -               return;
>> -
>> -       ghes_copy_tofrom_phys(estatus, buf_paddr,
>> -                             sizeof(estatus->block_status), 0,
>> -                             fixmap_idx);
>> -
>> -       /*
>> -        * GHESv2 type HEST entries introduce support for error acknowledgment,
>> -        * so only acknowledge the error if this support is present.
>> -        */
>> -       if (is_hest_type_generic_v2(ghes))
>> -               ghes_ack_error(ghes->generic_v2);
>> -}
>>
>>   /**
>>    * struct ghes_task_work - for synchronous RAS event
>> diff --git a/drivers/acpi/apei/ghes_cper.c b/drivers/acpi/apei/ghes_cper.c
>> index 63047322a3d9..7e0015e960c1 100644
>> --- a/drivers/acpi/apei/ghes_cper.c
>> +++ b/drivers/acpi/apei/ghes_cper.c
> 
> IMO, just "cper.c" would be fine.

"cper.c" and "include/acpi/cper.h" already exist under EFI. This code is 
GHES‑specific CPER handling (the GHES view of CPER), not a generic UEFI 
CPER API, so I’m keeping the GHES‑scoped naming to avoid ambiguity.

>> @@ -1,7 +1,7 @@
>>   // SPDX-License-Identifier: GPL-2.0
>>   /*
>>    *
>> - * APEI GHES CPER helper translation unit - staging file for helper moves
>> + * APEI GHES CPER helper translation unit - code mechanically moved from ghes.c
>>    *
>>    * Copyright (C) 2026 ARM Ltd.
>>    * Author: Ahmed Tiba <ahmed.tiba@arm.com>
>> @@ -17,10 +17,176 @@
>>   #include <linux/slab.h>
>>
>>   #include <acpi/apei.h>
>> +#include <acpi/ghes_cper.h>
>>
>>   #include <asm/fixmap.h>
>>   #include <asm/tlbflush.h>
>>
>>   #include "apei-internal.h"
>>
>> -/* Helper bodies will be moved here in follow-up commits. */
>> +static void __iomem *ghes_map(u64 pfn, enum fixed_addresses fixmap_idx)
>> +{
>> +       phys_addr_t paddr;
>> +       pgprot_t prot;
>> +
>> +       paddr = PFN_PHYS(pfn);
>> +       prot = arch_apei_get_mem_attribute(paddr);
>> +       __set_fixmap(fixmap_idx, paddr, prot);
>> +
>> +       return (void __iomem *) __fix_to_virt(fixmap_idx);
>> +}
>> +
>> +static void ghes_unmap(void __iomem *vaddr, enum fixed_addresses fixmap_idx)
>> +{
>> +       int _idx = virt_to_fix((unsigned long)vaddr);
>> +
>> +       WARN_ON_ONCE(fixmap_idx != _idx);
>> +       clear_fixmap(fixmap_idx);
>> +}
>> +
>> +static void ghes_ack_error(struct acpi_hest_generic_v2 *gv2)
>> +{
>> +       int rc;
>> +       u64 val = 0;
>> +
>> +       rc = apei_read(&val, &gv2->read_ack_register);
>> +       if (rc)
>> +               return;
>> +
>> +       val &= gv2->read_ack_preserve << gv2->read_ack_register.bit_offset;
>> +       val |= gv2->read_ack_write    << gv2->read_ack_register.bit_offset;
>> +
>> +       apei_write(val, &gv2->read_ack_register);
>> +}
>> +
>> +static void ghes_copy_tofrom_phys(void *buffer, u64 paddr, u32 len,
>> +                                 int from_phys,
>> +                                 enum fixed_addresses fixmap_idx)
>> +{
>> +       void __iomem *vaddr;
>> +       u64 offset;
>> +       u32 trunk;
>> +
>> +       while (len > 0) {
>> +               offset = paddr - (paddr & PAGE_MASK);
>> +               vaddr = ghes_map(PHYS_PFN(paddr), fixmap_idx);
>> +               trunk = PAGE_SIZE - offset;
>> +               trunk = min(trunk, len);
>> +               if (from_phys)
>> +                       memcpy_fromio(buffer, vaddr + offset, trunk);
>> +               else
>> +                       memcpy_toio(vaddr + offset, buffer, trunk);
>> +               len -= trunk;
>> +               paddr += trunk;
>> +               buffer += trunk;
>> +               ghes_unmap(vaddr, fixmap_idx);
>> +       }
>> +}
>> +
>> +/* Check the top-level record header has an appropriate size. */
>> +int __ghes_check_estatus(struct ghes *ghes,
>> +                               struct acpi_hest_generic_status *estatus)
>> +{
>> +       u32 len = cper_estatus_len(estatus);
>> +       u32 max_len = min(ghes->generic->error_block_length,
>> +                         ghes->estatus_length);
>> +
>> +       if (len < sizeof(*estatus)) {
>> +               pr_warn_ratelimited(FW_WARN GHES_PFX "Truncated error status block!\n");
>> +               return -EIO;
>> +       }
>> +
>> +       if (!len || len > max_len) {
>> +               pr_warn_ratelimited(FW_WARN GHES_PFX "Invalid error status block length!\n");
>> +               return -EIO;
>> +       }
>> +
>> +       if (cper_estatus_check_header(estatus)) {
>> +               pr_warn_ratelimited(FW_WARN GHES_PFX "Invalid CPER header!\n");
>> +               return -EIO;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +/* Read the CPER block, returning its address, and header in estatus. */
>> +int __ghes_peek_estatus(struct ghes *ghes,
>> +                              struct acpi_hest_generic_status *estatus,
>> +                              u64 *buf_paddr, enum fixed_addresses fixmap_idx)
>> +{
>> +       struct acpi_hest_generic *g = ghes->generic;
>> +       int rc;
>> +
>> +       rc = apei_read(buf_paddr, &g->error_status_address);
>> +       if (rc) {
>> +               *buf_paddr = 0;
>> +               pr_warn_ratelimited(FW_WARN GHES_PFX
>> +"Failed to read error status block address for hardware error source: %d.\n",
>> +                                  g->header.source_id);
>> +               return -EIO;
>> +       }
>> +       if (!*buf_paddr)
>> +               return -ENOENT;
>> +
>> +       ghes_copy_tofrom_phys(estatus, *buf_paddr, sizeof(*estatus), 1,
>> +                             fixmap_idx);
>> +       if (!estatus->block_status) {
>> +               *buf_paddr = 0;
>> +               return -ENOENT;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +int __ghes_read_estatus(struct acpi_hest_generic_status *estatus,
>> +                              u64 buf_paddr, enum fixed_addresses fixmap_idx,
>> +                              size_t buf_len)
>> +{
>> +       ghes_copy_tofrom_phys(estatus, buf_paddr, buf_len, 1, fixmap_idx);
>> +       if (cper_estatus_check(estatus)) {
>> +               pr_warn_ratelimited(FW_WARN GHES_PFX
>> +                                   "Failed to read error status block!\n");
>> +               return -EIO;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +int ghes_read_estatus(struct ghes *ghes,
>> +                            struct acpi_hest_generic_status *estatus,
>> +                            u64 *buf_paddr, enum fixed_addresses fixmap_idx)
>> +{
>> +       int rc;
>> +
>> +       rc = __ghes_peek_estatus(ghes, estatus, buf_paddr, fixmap_idx);
>> +       if (rc)
>> +               return rc;
>> +
>> +       rc = __ghes_check_estatus(ghes, estatus);
>> +       if (rc)
>> +               return rc;
>> +
>> +       return __ghes_read_estatus(estatus, *buf_paddr, fixmap_idx,
>> +                                  cper_estatus_len(estatus));
>> +}
>> +
>> +void ghes_clear_estatus(struct ghes *ghes,
>> +                              struct acpi_hest_generic_status *estatus,
>> +                              u64 buf_paddr, enum fixed_addresses fixmap_idx)
>> +{
>> +       estatus->block_status = 0;
>> +
>> +       if (!buf_paddr)
>> +               return;
>> +
>> +       ghes_copy_tofrom_phys(estatus, buf_paddr,
>> +                             sizeof(estatus->block_status), 0,
>> +                             fixmap_idx);
>> +
>> +       /*
>> +        * GHESv2 type HEST entries introduce support for error acknowledgment,
>> +        * so only acknowledge the error if this support is present.
>> +        */
>> +       if (is_hest_type_generic_v2(ghes))
>> +               ghes_ack_error(ghes->generic_v2);
>> +}
>> diff --git a/include/acpi/ghes_cper.h b/include/acpi/ghes_cper.h
>> index 2597fbadc4f3..2e3919f0c3e7 100644
>> --- a/include/acpi/ghes_cper.h
>> +++ b/include/acpi/ghes_cper.h
>> @@ -74,21 +74,21 @@ struct ghes_vendor_record_entry {
>>          char vendor_record[];
>>   };
>>
> 
> ditto. "include/acpi/cper.h"

As above.

>> -static struct ghes *ghes_new(struct acpi_hest_generic *generic);
>> -static void ghes_fini(struct ghes *ghes);
>> +struct ghes *ghes_new(struct acpi_hest_generic *generic);
>> +void ghes_fini(struct ghes *ghes);
>>
>> -static int ghes_read_estatus(struct ghes *ghes,
>> +int ghes_read_estatus(struct ghes *ghes,
>>                        struct acpi_hest_generic_status *estatus,
>>                        u64 *buf_paddr, enum fixed_addresses fixmap_idx);
>> -static void ghes_clear_estatus(struct ghes *ghes,
>> +void ghes_clear_estatus(struct ghes *ghes,
>>                          struct acpi_hest_generic_status *estatus,
>>                          u64 buf_paddr, enum fixed_addresses fixmap_idx);
>> -static int __ghes_peek_estatus(struct ghes *ghes,
>> +int __ghes_peek_estatus(struct ghes *ghes,
>>                          struct acpi_hest_generic_status *estatus,
>>                          u64 *buf_paddr, enum fixed_addresses fixmap_idx);
>> -static int __ghes_check_estatus(struct ghes *ghes,
>> +int __ghes_check_estatus(struct ghes *ghes,
>>                           struct acpi_hest_generic_status *estatus);
>> -static int __ghes_read_estatus(struct acpi_hest_generic_status *estatus,
>> +int __ghes_read_estatus(struct acpi_hest_generic_status *estatus,
>>                          u64 buf_paddr, enum fixed_addresses fixmap_idx,
>>                          size_t buf_len);
>>
>>
>> --
>> 2.43.0
>>
>>

