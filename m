Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=40.107.159.54
ARC-Seal: i=3; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793360375;
	b=nMJ+Bhc0Neb660N805JdROKpUEKLctt3iRfdTO+FVlBi2K0KCZyQ3TYGsiVpDxdTJgAP
	 li++w6xW3gfHtRF8F6UZNAqIHnyE9aacxNgch+df1okwfOYPpBP1FYSJ9TOjZ6Y0VgtDK
	 ZMmm1TLoqgY1sRUnEdFDiQBdkNjT5+PzMf3nBhWxz/hbz7qJXkcZTfmAUAh4xAGOsmOYF
	 Ti1BKDe9ZYGPTwZbuDKkLJ+nQhdEBdz/ljRnOE2mu5hxqUQ/IwDut5a07sotL0DKZpfrG
	 j3nbTUanznR+zm+e5ngiNtiY1wefIe8ED974tMu6IvrSVb+lnX45+Zs+Ol59NYme5vA==
ARC-Message-Signature: i=3; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793360375;
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
	bh=a6RedMqEgd3tkSpJDsRgFH/ecVwYMYo9cDfvEcAlzHE=;
	b=23WPENqp9CnjLjE0ylzrm+yS9m9g1kKQ0VYFu1EgGMQpe3wf5qgLIS5wbN4HucmX0DlN
	 hiBZruEAvS6cN/zsVfUg1hdfg5a2KaRSNZLWS+SYxTeodEJ3zDmtr1e6KIpsQ4iAGzrGA
	 KTBKDP6dEJUVHrTAe5oj/Bf30cwiR/lZRBKg4iY9exBSHkC5bz3z1bQ8c3D4ebBjpLZO7
	 STXxOY9LxfiTKEWRjyR7xMsprN1AeZm5A4MArpqErmNN1Mat7f8VpkrnvWhdbTz/27w3S
	 98mJg7Igo8aujPkeIAGNUdUr+HDBQpW217Mqkv89PKqdhQQBds8/qe+6dSE5F+eOH9A==
ARC-Authentication-Results: i=3; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=DPWnL3Jj;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=DPWnL3Jj;
	arc=fail smtp.remote-ip=40.107.159.54
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013054.outbound.protection.outlook.com [40.107.159.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAA9606A31A;
	Fri, 30 Oct 2026 11:39:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BEAA9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=DPWnL3Jj;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=DPWnL3Jj
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=DH7AlVB8ljs82Yeoje/73ogF4St2gjyvP+//S4n2QswBy9ebErbJKX5/Ga2g+5Q1DHxqZSzsa3cfIqIBGha5FHYkmh4njdE/abMLJP7icDZJTuVlPXiP7NZMJj8KGkeqmtuTcf8j31bv8rOcsXEvKN7Ff3SSUp/iau/PqSdR11xzEu7LvsedWv/v6Ht17tIPfhnyTD7MNA0F8hpVVr5d4bLDU9X8ouhmRW1Ku0EUPr/GUFWkL8qJ/OU5DGItKB5M1FPxOdnJMhtgmqDPQh4PDqedNKPDS06fZNjMvf1HnKlkgIcI7USFMKaoztA4OLJKMW2loHXK7mneNMqwl1XBGA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a6RedMqEgd3tkSpJDsRgFH/ecVwYMYo9cDfvEcAlzHE=;
 b=mA6WGMSpnPS/Q1c+wr5HitNIHkBCc92dGdeGMTPq55b9HWtAxN33KCcJQ8EkOn22YLIJ888xsfLK+zyOsI4SJvIMhWh4d43OiBQLkI+6ga6OKRyD0do9urYB/LKDmLNAuPMwpwqyg8mJy5AgwOSLOn9rz/mYezIgzH6YCN9RkP4yY8jsxAq/tKNBTkmUB2eRS9ZOl7LVgH1vztkYu7gNEnsnFOoKBFVKri+jPrqljqoTMTJwkLWroKKigb/tfWMJUkJIqZVwA66XYzyeybDCYEKfdCpFi4eDeAMWfN9nBzS1+POoYsSuoSdvF0d2JKgYAg21oEs+7h8lYkuQezf5Iw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=oss.qualcomm.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6RedMqEgd3tkSpJDsRgFH/ecVwYMYo9cDfvEcAlzHE=;
 b=DPWnL3JjRovosLptZw/MofmUPbky6ON8ugi+JVQGEmWXSTWz9vz0UlKH+ouk7MkUVNMwqJe7S3tcsB5nfoIyzRvZWhQH4rpLh3/Ufntsl7sTBMcUyBA2SijhMKoQwd5h9TVuMzEJ8z8gKnLsvRHBclhdefAKAW/FdETKLFFocz0=
Received: from DUZP191CA0031.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4f8::23)
 by AS8PR08MB7337.eurprd08.prod.outlook.com (2603:10a6:20b:444::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 11:39:27 +0000
Received: from MA3PEPF00000403.eurprd04.prod.outlook.com
 (2603:10a6:10:4f8:cafe::a5) by DUZP191CA0031.outlook.office365.com
 (2603:10a6:10:4f8::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Fri,
 30 Oct 2026 11:39:27 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MA3PEPF00000403.mail.protection.outlook.com (10.167.241.148) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.4
 via Frontend Transport; Fri, 30 Oct 2026 11:39:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cTsj/uGlhusL9Eerlx+HFT36NnKFh2UFMXQmLmXz7XcGQZdm/Du3CvArUqnUQgZfjyeBlpVI0k/tgU2JE5QpaHeKM2XIIdhVPp3UQidk7nWpgFFGnBKTor689A2AYv1495iUw1IdOKYiKwGd/HabdDVLrJWkpWQpejJfAsHza4eRWDOQOLGun2T6vEbwWokxrY67QX57i80uh4Lhn9sZWkanqcLHOozQ7fpuCpgcOKFmg9NmLqUgSHMMyduh3pNA3Eq9igeCjIZaUilCGg5vkshvG/x0oTbg9ucHYWrAFq9R05Xf6HrIdeBYWTpPbvCN1EgcJz3IqaHSdeH70UDBBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a6RedMqEgd3tkSpJDsRgFH/ecVwYMYo9cDfvEcAlzHE=;
 b=txqNgnj8FGbEY44EdwoWTgRRs2J4WNsWno97AnyujeUprH29/WNcSfGRDk9xENaFv9DQUWPPvCdw2b7Qec/9dpqx9owbfACBkxUUCwoSU8djd5/Aw44YWbrk8RPrZAjmhyeaT7ZCFaghfrEtPde8uF4Dz4OL7xkg1vBe9F1Rl/ht7Ine238IjGkytmpzOIWH3jLRfFVqqnCnEvWvxVtO0284Vdb6ZkMurgDJYRY+wL4PX2hEcAklLIkOTXCdnBpNXsob7wK7t7l6aoxMufkT+ipOVP4YjhT8XExFs5cJcHxIhp1cDyh79m3uA6XAbHfEhKJZ68Z6N3/+kGMiTmuydQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6RedMqEgd3tkSpJDsRgFH/ecVwYMYo9cDfvEcAlzHE=;
 b=DPWnL3JjRovosLptZw/MofmUPbky6ON8ugi+JVQGEmWXSTWz9vz0UlKH+ouk7MkUVNMwqJe7S3tcsB5nfoIyzRvZWhQH4rpLh3/Ufntsl7sTBMcUyBA2SijhMKoQwd5h9TVuMzEJ8z8gKnLsvRHBclhdefAKAW/FdETKLFFocz0=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from BESPR08MB999898.eurprd08.prod.outlook.com
 (2603:10a6:b10:109::23) by VI3PR08MB345405.eurprd08.prod.outlook.com
 (2603:10a6:800:378::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 11:38:51 +0000
Received: from BESPR08MB999898.eurprd08.prod.outlook.com
 ([fe80::d62a:5300:bc89:9f62]) by BESPR08MB999898.eurprd08.prod.outlook.com
 ([fe80::d62a:5300:bc89:9f62%6]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 11:38:51 +0000
Message-ID: <7a490079-e7ab-43ad-ab7a-94fcc133ae37@arm.com>
Date: Fri, 30 Oct 2026 12:38:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] CPER: Add Memory Error Section 2 support
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
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
 Ashok Raj <ashok.raj@oss.qualcomm.com>
References: <20261019203915.2019037-1-pierre.gondois@arm.com>
 <20261020101048.00000186@oss.qualcomm.com>
 <0817615d-5e96-4a3a-b39e-3e5d1b88e716@arm.com>
 <20261023142621.00007051@oss.qualcomm.com> <20261024003917.283b890d@foz.lan>
 <20261023170405.000060b8@oss.qualcomm.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20261023170405.000060b8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0019.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2df::15) To BESPR08MB999898.eurprd08.prod.outlook.com
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
	BESPR08MB999898:EE_|VI3PR08MB345405:EE_|MA3PEPF00000403:EE_|AS8PR08MB7337:EE_
X-MS-Office365-Filtering-Correlation-Id: a1a92499-a587-4a45-b28b-08df367a732e
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|10070799003|7416014|376014|23010399003|1800799024|18002099003|22082099003|56012099006|11063799006|261022105027099003|261022075727099003|10067099003|261021135927099003|261021121427099003|4143699003|261009223027099003|261028144727099003|261026121527099003|261026140227099003;
X-Microsoft-Antispam-Message-Info-Original:
 ZwhHoPWWFeOc9KUTiwBlwmzeMW3Y8MZPHIGauWC+mgfYC11ezje4kAxLT3BFKlDqa8lEi37XL6v6zEnqddNmszwVvUTDJGOLBRTesS9wDbRrIeAfvcYoz+TUltaSYMjaCRdLlLVYVkwtbqJHls90TQHQZYpSlrdl0RfSPrpSIfLwY7qSTaGxadV4JIO1vaY7xJYryDz986FQxi2m4KrEletnTx15Hwfu/tP8ki/VXVVwaFMG2bS/dNru8e2PVbxM5rR1/tOuj61sOYdmEUg2YNFskteS49M6cEAXAjraJtwxH7kGA/N38XsLsHtmGZaoswlKHm2kGBWUbY2RyMubHBZWdIYsUXVJMdHBdFG0IqmJK5n7mfHdxLeDMBiWhj6iuXdkYdSMptQ2gDNjMCXpBD7oNUTt3zcKn9aQ8Rn9b+xZCy7niwjAQfObZu2tp8Sq681Do+Vm/b95SeDuKWNi5Xo1EzVN+qvzEHg09nrR8mNfzNLpVzU1AF/dUc2TPyKHbtQTTTf6SMFPf7GX0+WZA+jV4O6Y50QkMiyXSqC0rMYzbVsJWFkAvBHPaFqq5GnVBKvs7hdiMVm7LS9tYOKLrs1nySyzP2Jr8htmG+6Om78c3sNZLVQMVciKMN9BULaIIR4dl6zVxV+fzN77qBormpjpCgh4OMkJelE+qibORxI=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BESPR08MB999898.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(7416014)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006)(261022105027099003)(261022075727099003)(10067099003)(261021135927099003)(261021121427099003)(4143699003)(261009223027099003)(261028144727099003)(261026121527099003)(261026140227099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 iLYTwmqfBMXiWqvi5j6/1bAGTaqGuB5uhLP3yVC8sZmDCk7TYFz3D/4/1Lx5FxxWMv/PxtWtAwin9QNM8J8Gdwph1Hn0JAkVgXMWW8aOAgEnfPJCI8GLeOAxtXWZ44rRkCJqiBAWEH5NMJAId+yLueC8+aueGfKRwg0bfNdu6Y/Eme4OhZ7iqfjuz1oc3DkSxjwlJP1lMbrYayV9xfp3VdfIaYhXJJzSHXsHgRPtB8kKT9UfM+oEP5qvizKibDBGSZUEFwoWyQADzOsm+8fXeX0lAiVxY/KHwXm2ITjo6juYI32FH5pxgjIh9AZd0MeaD0vLpUwReSKgocObYX2FIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI3PR08MB345405
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 MA3PEPF00000403.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	44e934e5-48c8-4c12-7ae7-08df367a5ef8
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|1800799024|23010399003|30052699003|376014|7416014|82310400026|14060799003|36860700016|4143699003|11063799006|56012099006|261009223027099003|261028144727099003|261021121427099003|261021135927099003|261022075727099003|10067099003|261026121527099003|261022105027099003|261026140227099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	XgooHlMKRYh7UoNSzSOQekwzeI0I7LLTiWpcVH6SSK1TuDd4/BgSO6I4OucAt6cL1o9ugZHjXcSUJ3wZ2TyjIzzCITy70KxK80l93iqCULErjw5uUznXIF3XpQDCdPp5Djad6mYv4n6CIxt9pzf3kTDOzdseMtYrO6j7PJAbU4rJYNGLqHGamINE7gdI10HWtsXrEtSR6BsRZZVq6FdMx8SqUR0jnAnK1mjSl7mNG53MZYd3Ut5i6U9qZ6N5R4E1Xex1FsTbXZf8FWzFtfzdtyPIm26I6C0dWL+QoYKMCZ64hEM11IS9P13mpAGkadIjfOnG6a+52vW19j4FhpykdQZ6ep5RVeaRyqB3Bln+0LcV4QW2shVuFxiRh1UfZM36U7yQR7camoE8Lq8Rd8OzlsFk1YAVqYAUD3iBsqTS1AtTnBAKbp29hbIZAuSFw1jHwUy5S5fljEjSwoJ2IwPgLGzypPJvY4/6PwWOdHN4z3XqsCDIcmrzzXdVggdKWFelQnwc+7V9NH0e7ShhWrUcDXuQsvmNCKnSoDkN9xLBxfPbm+6IIyAPt6BkUAif8/hviOeRGTFSB290NEswS0MHoIAaNiDUKg4DO1pMor6SzjbHrX4Z6Vto+HEb/nqBeTBfuPYnn5u9F3c6xSecsmmH2u8L0bUKfiEvI2TfTvhk7RJCNLHqBMq9XEESaeaTB906YbuTdcQd9Hl7BRE3WDZdKg==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(1800799024)(23010399003)(30052699003)(376014)(7416014)(82310400026)(14060799003)(36860700016)(4143699003)(11063799006)(56012099006)(261009223027099003)(261028144727099003)(261021121427099003)(261021135927099003)(261022075727099003)(10067099003)(261026121527099003)(261022105027099003)(261026140227099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	KwGrlF2if9Fl4NICetNzIlOcCSDb7K5wEtjnhXuhfxTr4enydwLNU83rrwSxqkga5WtGfR2hgZ1eNcdtxL2Q6v6MxzRyZnHwLMTZ8/NwxtbxG973nwEigkqs+zttKxxwlSpXZ+x8hBH7HUSe4/wF0qn/PTp71WJPqSR6Au1uocBnFrWasRVM19INYrPiHLYQS4WE1v+u7AC4HlrPQk36USWAvX+IlQNnQbV/5Kl/diq55Ch8vgnpPERrNlBvUS8kFpUJa8Fseheb29u2sIIdPMhhfTKgtkrAMo3aTmxuhxJLFT0t8RWMw36GVuwLBaePn626A2vxn/KJCrrezeJz7+XWo1ka0dPrxDGrhpvuscc8BKSAACEpEjt+b5oLc1MF7Y6iv0hfnYg55TG4eVn6s+XKGONO/brlrBWpvjsx4vb1+dYZQnrgZuk99l99ZBGN
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 11:39:25.4313
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1a92499-a587-4a45-b28b-08df367a732e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MA3PEPF00000403.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7337


On 10/24/26 02:04, Jonathan Cameron wrote:
> On Sat, 24 Oct 2026 00:40:33 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
>
>> On Fri, 23 Oct 2026 14:26:21 -0700
>> Jonathan Cameron <jonathan.cameron@oss.qualcomm.com> wrote:
>>
>>> On Thu, 22 Oct 2026 09:07:25 +0200
>>> Pierre Gondois <pierre.gondois@arm.com> wrote:
>>>    
>>>> On 10/20/26 19:10, Jonathan Cameron wrote:
>>>>> On Mon, 19 Oct 2026 22:38:39 +0200
>>>>> Pierre Gondois <pierre.gondois@arm.com> wrote:
>>>>>       
>>>>>> The support is mostly duplicated from Memory Error Section handling.
>>>>>> Other than differences coming from the content of  Memory Error
>>>>>> Section 1 and 2, differences in the support are:
>>>>>>
>>>>>> - v2 do not rely on a compact "struct cper_mem_err_compact" struct.
>>>>>> This structure was used to support older versions of the Memory
>>>>>> Error Section (1). This is not needed for the new structure.
>>>>>>
>>>>>> - The compact version is also used by the tracing framework.
>>>>>> To avoid relying and propagating a non-standard record format,
>>>>>> through trace event (cf. extlog_mem event) the new trace event
>>>>>> prints each field individually.
>>>>>>
>>>>>> The last patch of the serie was only build-tested due to the
>>>>>> absence of relevant hardware. apei_mce_report_mem_error() and
>>>>>> arch_apei_report_mem_error() implementations were also removed since
>>>>>> last version.
>>>>>>
>>>>>> It will also require a proper handling from the rasdaemon. Applying
>>>>>> this last patch without rasdaemon support will silent the reports of
>>>>>> Memory Error Section 2 error, cf. ras_userspace_consumers() check.
>>>>> Hi Pierre,
>>>>>
>>>>> I'd slow down a bit.  We are mid merge window and convention is normally
>>>>> one version a week or so anyway.  Better to gather up feedback from
>>>>> a number of folk and spin only one revision to cover it all.
>>>>>       
>>>> Hello Jonathan,
>>>>
>>>> Ok sure, as the v1 was reviewed quickly I thought there was a chance
>>>> of having the serie accepted quickly aswell. I ll wait a bit more.
>>>>
>>>> Thanks for the review,
>>>>
>>>> Pierre
>>>>      
>>> A general question that came up in a related thread with one of
>>> our RAS architects. How does firmware decide what to send?  As far as
>>> I can tell firwmare has no way to know whether the OS understands the CPER
>>> Memory Section 2.
>>>
>>> So options that come to mind.
>>> 1. Firmware must send a CPER with both Memory Section and Memory Section 2.
>> Please don't do this: this would require either Kernespace or userspace to
>> discard one of the reports, only if the other one is there, which can be
>> tricky. Could be done more easily at userspace, but only if some database
>> support is enabled, but, at least on rasdaemon, this is an optional module.
> Good. That confirms my view that is horrible.
>
>>> 2. For whatever other reason a platform knows it doesn't work with old kernel
>>>     so can assume support in kernel and hopefully userspace got updated too.
>>>
>>> 3. We propose some additional discoverability (quickly - code first) to ACPI
>>>     so that it can be a negotiated contract between OS and firmware.
>>>     Until the OS confirms it understands Memory Section 2, firmware has to send
>>>     the older one (or risk the record not being understood).  After that
>>>     negotiation it can do what it likes - probably send the Memory Section 2 form.
>>>
>>> Option 1 and 2 are ugly at best.
>>>
>>> Obvious path to me for option 3 is an _OSC like the one for generic initiators
>>> that we discovered a need for whilst implementing that years ago.
>>>
>>> Anyhow have a better idea?  The above doesn't solve the end to end problem as
>>> maybe userspace still has no idea what this new tracepoint is, but at least gets
>>> us past hop 1 (so through the kernel).
>>>
>>> If we conclude _OSC plan works I'll draft a code first proposal.
>>>
>>> Jonathan
> On another note, Pierre, any plans to actually enable a path to the tracepoints
> on arm64?  Today they only emerge from acpi_extlog which is x86 only.
>
> We definitely want the richer data for PFA and obviously for userspace nice
> to share tracepoints with extlog.
>
> Jonathan
Yes right, I can do that in a second step if it's ok
