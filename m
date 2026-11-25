Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=2 smtp.remote-ip=40.107.130.52
ARC-Seal: i=3; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795624256;
	b=d1fF2zwAaAFwJiyu4fOPLcqFa7jwvY+SSAFl2JEHO0prS1lchvV6CHu7gQfIE0cWKSQw
	 SkA+GXuqZafmr8mZHwIUao+xdg8PCZ8BKAqx7MGARWpzSLEkJyx4DIAGksu+b14tyOOLr
	 HR0rcaRibtNhpl8XKy1AKkm0MjtMl6BGMfLNB/pTLTij74vMX6Nyve2/p4oeHnns61/ZL
	 4ebnbFgCAMsBh2UW+R/umROuCgRgjaMxyQsNyK+kvs5ZES+lM1pShj7tbptcO/VJDZiWI
	 tIsBp8ZyFAJ/O12xCM4vDbLbs7fVvqlz1JQZRb7OFZ1mZmUQhE+2/AMw4Vi0+IIXJvQ==
ARC-Message-Signature: i=3; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795624256;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:
	 DKIM-Signature:Authentication-Results-Original:Received:Received:
	 Message-ID:Date:User-Agent:From:Subject:To:Cc:References:
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
	bh=n2qzbBxlFuY8UsuyzuPI0X8DjOAwi9Rt+LyDieDNxAQ=;
	b=188FSeeOE6WAH8FvdsX6gC12m4PzrboUwp/soAmg1ORxeLXVeCUDDaLPQ7iQ7fmo6q6S
	 G3ts3I601tWrAG7CfpGQtJzDaMqJToTLRBI66jIpssbUD/LAlE2ef7JXEl6f7wxqcIfeX
	 5DmhYa4L2GZMgxVVxmkmOdFg1miuTNaglexW2kudX1m9tqpQNC88K7J2a+e5ZiFALr+I0
	 emk5rxuOsEVDRIs6NzGLTSpaWVm4aE8Y9yJF1SIROqTdhs6OdOMxEqdeG5OKx4r8v3Dl+
	 EqSgqvHNwNpRc/eJwdluLR1MgvPfO+f9CMHz0nNjfDUf9TXarhuXqBKYqmgyVdp1Ccw==
ARC-Authentication-Results: i=3; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=NlsXbX1D;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=NlsXbX1D;
	arc=pass header.oldest-pass=2 smtp.remote-ip=40.107.130.52
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011052.outbound.protection.outlook.com [40.107.130.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44625606A326;
	Wed, 25 Nov 2026 16:30:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44625606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=NlsXbX1D;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=NlsXbX1D
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=cmvODMcUbl276ZAB89SYpaagTxeflZtPTrznansskaxE9Jc5mbXPgAiWkr1H9Bfkyj4qVM9V+7GrLpkIo/8K1E8dPJ6kN4RQ4y/PgIbCHYLG85bdV798RFJBH1BW6zFydcRc9cOnKAq1r3xyEyMbG+vqpr8iVN39yEmrjULsjviDkzhki376UNOjkmeum3AOqWV+UQb4xJCSiwz9Pr/tXSMbib888GPOYV9Xnae/q1cvdbiC0UN5y//vJSHXdGlmSWQyJPp+ReWNKlrQfuhZmD3Xz/nWGsQE3r6rfATCYpai+q7DbEyoPW8xbI3IKBqA565580sqypeZDrSfdXZU0w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n2qzbBxlFuY8UsuyzuPI0X8DjOAwi9Rt+LyDieDNxAQ=;
 b=QNI1+HZKf6aV/ngKioD9GoMGQUFdKCIF5LzgrKDnvKB8kVSOv009ancyhDjx4G4CiJPU153Pq9nyh5/0caRfIZNSzfrL/AmF9ne1riaVyT3IvUM+AgmPeEJ72wbYNrbmNJnA2hPbY/7RljBmIDzbUd5uIt2j4cpsbtDe9IDbk18lJ8pw42GLir4qyMvpaKsIs2uoAQlk1E5Bs+zLDeTZWWdEMhxnJ9NVyTxqUD+CPnJdmbkKf/UxIZJpXmTyIWvld3QIdfh0WOkvZO25TWxkpnicAF0zxHP3qTnKy3kKZss6xFDbxozIO0eT5fPL3/VAlM0D08XV8+ydK7lD/mzyrQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=alien8.de smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2qzbBxlFuY8UsuyzuPI0X8DjOAwi9Rt+LyDieDNxAQ=;
 b=NlsXbX1DA4ApXKUaS+OCTFqsgDjRlSzWlj0umbZVHc7l5X1+8GIeo8mOdn3voiNvLxagXbd+6uJfTcTBOEmDhebLU9kT4xzZUbO4q4KR5CzXfOfKNYd68SveAnQKKvPWZUNhi1NpL1efcDAlQh75YlztCnEb/Sk6uslHVXQkHWU=
Received: from DU2PR04CA0152.eurprd04.prod.outlook.com (2603:10a6:10:2b0::7)
 by AS8PR08MB8159.eurprd08.prod.outlook.com (2603:10a6:20b:560::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 16:30:48 +0000
Received: from DB1PEPF000509EB.eurprd03.prod.outlook.com
 (2603:10a6:10:2b0:cafe::44) by DU2PR04CA0152.outlook.office365.com
 (2603:10a6:10:2b0::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Wed, 25
 Nov 2026 16:30:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509EB.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.3
 via Frontend Transport; Wed, 25 Nov 2026 16:30:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pKvTd5QbPdgijc//1zcSONtkZOpeIDlpDzyOpmIXfWPsHSD8dHfvczRL1x37rQx+GyTUbHjurUbXt2XsTEbe6UcwrCqVHoYxE+CqvgKBv3J3Sl3vKVMyNoTwGZfbfCUH5nFc8C27X0cstqrMcWZP6i98b49jieya+qaO37zRadFR7GnJWY5yDf6UDXWk1y6bL8IaIaqm/6b4H3D+0nt8LPAd9+RtEX2w9q1Rq7iLKbTn+loc23CCnpXUyxEI7/p9OQs0AzORj2u7ORFKeCh6AeIVy/2mDLL2DRz3Qvdhg94DuDQtWs36fuIyaT176GA55Z2/Cw0tk2aIFrOxymNcEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n2qzbBxlFuY8UsuyzuPI0X8DjOAwi9Rt+LyDieDNxAQ=;
 b=wfs3sR7kZQF45wNKaEqOCURO/qUQM4xpZ3As8MCS1yVmUN6tvbvCSyZTc7TpDOATZ67XIj7zjBxtV0qztwqFeE5KO62hFYNsazSJlSCl+Z2hyBr3UayZFPjO40FAXqYMSmr3E0pVcrV1Fi04rAbdNM8MTkB/PLp2QPRSo9nMjJDzZJNf8LvCPYDhXWG5yGEYz9o1WocA6/KvZOnxiXUSDvQNta4axYjLQOJpQ1nhV4ALhCR6ogJgLVUxJSEaPcEDc34XC78sBT9nnzBapgh1QrDVb0fIit5xYcf7RFltjSRgJXoJnKGbgO2kMFK9feHCfs72O5t3pg18g1vRer8FbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2qzbBxlFuY8UsuyzuPI0X8DjOAwi9Rt+LyDieDNxAQ=;
 b=NlsXbX1DA4ApXKUaS+OCTFqsgDjRlSzWlj0umbZVHc7l5X1+8GIeo8mOdn3voiNvLxagXbd+6uJfTcTBOEmDhebLU9kT4xzZUbO4q4KR5CzXfOfKNYd68SveAnQKKvPWZUNhi1NpL1efcDAlQh75YlztCnEb/Sk6uslHVXQkHWU=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from BESPR08MB999898.eurprd08.prod.outlook.com
 (2603:10a6:b10:109::23) by DBBPR08MB6315.eurprd08.prod.outlook.com
 (2603:10a6:10:209::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.5; Wed, 25 Nov
 2026 16:30:13 +0000
Received: from BESPR08MB999898.eurprd08.prod.outlook.com
 ([fe80::d62a:5300:bc89:9f62]) by BESPR08MB999898.eurprd08.prod.outlook.com
 ([fe80::d62a:5300:bc89:9f62%6]) with mapi id 15.21.0639.012; Wed, 25 Nov 2026
 16:30:13 +0000
Message-ID: <5260f980-87c0-49e6-a478-34e815f6410b@arm.com>
Date: Wed, 25 Nov 2026 17:30:11 +0100
User-Agent: Mozilla Thunderbird
From: Pierre Gondois <pierre.gondois@arm.com>
Subject: Re: [PATCH v4 00/12] CPER: Add Memory Error Section 2 support
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, Ashok Raj <ashok.raj@oss.qualcomm.com>,
 James Morse <james.morse@arm.com>, Mark Brown <broonie@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Tony Luck <tony.luck@intel.com>, Hanjun Guo <guohanjun@huawei.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Shuai Xue <xueshuai@linux.alibaba.com>,
 Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
 Pawel Chmielewski <pawel.chmielewski@intel.com>,
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
 Dave Jiang <dave.jiang@intel.com>, Breno Leitao <leitao@debian.org>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Terry Bowman <terry.bowman@amd.com>, Dan Williams <djbw@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, Morduan Zang <zhangdandan@uniontech.com>,
 linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
 acpica-devel@lists.linux.dev
References: <20261113132600.3355836-1-pierre.gondois@arm.com>
 <20261124042434.GMawURgn0Uap26S6US@fat_crate.local>
Content-Language: en-US
In-Reply-To: <20261124042434.GMawURgn0Uap26S6US@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0507.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::14) To BESPR08MB999898.eurprd08.prod.outlook.com
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
	BESPR08MB999898:EE_|DBBPR08MB6315:EE_|DB1PEPF000509EB:EE_|AS8PR08MB8159:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cbd5681-1bd5-435f-526f-08df4b117600
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|18002099003|22082099003|4143699003|261022115727099003|11063799006|56012099006|10067099003|261102123227099003|261026140227099003|261022105027099003|261022075727099003|261026121527099003|261028144727099003|261021121427099003;
X-Microsoft-Antispam-Message-Info-Original:
 h2gBFqEgg4o2gkVagx0IFJX2NygmQ8xLGK7/ME2UFCsL4md5Taw7ziBVMpFt91Eykm15jc8dx3+EFcwDrlCZ5bi8BBl+vPmbUnthws1ZJ0Yd/+gFz11GYCJmkRWh9FFSItsjO9qKRd3j2D2f/8dqCeWNqhP6mrTFXqrs97BM8vWYHeMAM2IqnEPM1jM5fwjS7xneLUBsS01Mpcv/Yoza9u2a37xLTRWvZTQ+qVC4mXbYTzHin0jRQwwQLUVuIPcekLmk75lJ31npSzgeNiIxAAfZqmLC74l6dXHxRxZEqgftPzJ+P2iwegiOgLWCq7R4aY5X8FTQY5aHDqQwYJckhMPG1mlDV4okJou8d8p21MGMuJDol97MWJacgqq8w8wJkyXrfADNMhJgh9wpisTtSZDqIaeGzQiXiyY14P/4hx0T2CQkBTxjncPyi0Od3ymIBbRvUyw78XaZssqy+01zmauZRklnAUyOW/WQTqQn1YlKKKz+/PQAAEhcCLKuvLrX6MrGrRhChESS5AxF0GtQZFIZ7SsfqRWDgUWttDzEvabZJVOr9NGMU/AD6r+HCZxpxLXTHyVx32ojguzvWRJKCbxoA8HX+lknyqaI7VQqjMbDdCh9M8AVnNrDzKO53f2e
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BESPR08MB999898.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(18002099003)(22082099003)(4143699003)(261022115727099003)(11063799006)(56012099006)(10067099003)(261102123227099003)(261026140227099003)(261022105027099003)(261022075727099003)(261026121527099003)(261028144727099003)(261021121427099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 pJyhi7ZiO9lnirHPcQ8+LDvSUkPwY+hlKN6OsTekHZsCRyEzi2nGygM141sGdIFfymlNAv7V915RxcMRRTXBSjkdBfQvTXsgDIl3OpNpO7GSs94M22UqsjqreL05TDGPeIAvIaW7NLLZHDch1uRDk/qs/hcdCMuC9hjSiz0qFJzAjjt2ckdr80sgnFES6o6GkmkoeK+jfH5Szflfp7Kxj0WSQcvvrkteXUzGWeZ3TUz9hcA7xXl+af0uUyUWg9avA+Lm+3Cvyi/aCGefT65S8BJWJbWUEWvUfac42BF2cTwzMcL71aCvzM0npgwo3APt1VQN1swApqiuqVGTfKr+CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6315
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509EB.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	9b29a767-4f5d-4fc7-2234-08df4b116175
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|23010399003|376014|36860700016|35042699022|7416014|14060799003|18002099003|22082099003|13003099007|4143699003|11063799006|10067099003|56012099006|261102123227099003|261026121527099003|261026140227099003|261022105027099003|261022115727099003|261022075727099003|261021121427099003|261028144727099003;
X-Microsoft-Antispam-Message-Info:
	BK3qZXTddIPekYhpz7sBdQJtGL+3E116XjO3c+uw/S61y/Z6dcVvfiuA2/fABVpeg3ZT4KyUO/2RGm7VizWT8/6dSKYdeFVISQ8tqOWd7oV/JLEiZ9Q38aiE8uiCWjZj5K2JMt5UPvjZfv9nILyl2w14CwK3jAZCkvVGX/Xrz6El5t6o+YX8SdTZ7BP1mpJEANIFpowl8zueNANe4do7oDX1KSC6SVWaWzIP3YWC3qbneR+hkKwzqxq84l9Zr3vlbIU8PHxEGugT+K+0astxlINFNkaOI95/Nr3wZdFpIbAcIoTFxCI0G1v+NY3xZaxJHcVcyaM4B0zzDaOuYWbWkNcVj4yZhDEtPOlixPMwET23Ck6ZB/nExOd7B39/XNeE+/hsjh4cDpB76WHkhpSEGLC/AixuiUBevrUH13VpnhKBWA2hfgaGW/YZCBExYmAXZCWcYoDluRdX5a236bAu/I/Dq4BWX/JIoqUUUk2FjSpIyP9lJnDJ+DLRsa+W591YNnveDE+hWQ5xaqB9QnRxC+J8JkZLrJ8zP+RxH/Rh57zHdR8C39wS4CCq3IJxQQNauWaFA3BGBPZDotzoDmti3qnSQrz5Cz0k8wgE6uBYU5hxgzwzfUCW7/k9OHNsf+N/07QcGsGaEvhsgRSuUlTZOqAodgwE1Xhx5BXCZmHVbgU=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(23010399003)(376014)(36860700016)(35042699022)(7416014)(14060799003)(18002099003)(22082099003)(13003099007)(4143699003)(11063799006)(10067099003)(56012099006)(261102123227099003)(261026121527099003)(261026140227099003)(261022105027099003)(261022115727099003)(261022075727099003)(261021121427099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CyS9/qsxjzwOUamM8lzXREqv7KY2sto6b1uvzG6pCNw93Tx1xkakUakWeRz1rvLfmTdYaBTsbB6VtkHtLy5aProdh7IThPixQLBOVA5hbjW32tQKd8v+ZkSbnMR9Tm3fUNyPsum09WO7hz/2NdubgdwRLycrRqxKsUQDTovIdoNbcKTrxk16a/sVZ7UuUcdH5Rtqr0Xkuc8n8Cqv1lAigCh4+cG1OrIbWWyZe46aLdoKo3O9pD1iku3n7N/8pVTBMQjP0dZ+6iNwmXyZJHIvCelgFXn6AZxOZldNlfVyOPyTYoZ4C1q/V6Mog8+7qlfbbvMYiFy4b6IhJKgoKhtqE7NO4Y57IhdBTxpJ8Tj4xjtewZ+2ETn1tueYClEimhy4yJwoCyikUnPQ8b1sd8KPi/tlDurp1tm/MvP/Yxsl+PQq8PsjxSjlxgu4TQp+k+7s
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 16:30:47.5170
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cbd5681-1bd5-435f-526f-08df4b117600
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509EB.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8159


On 11/24/26 05:24, Borislav Petkov wrote:
> On Fri, Nov 13, 2026 at 02:24:42PM +0100, Pierre Gondois wrote:
>> The support is mostly duplicated from Memory Error Section handling.
>> Other than differences coming from the content of  Memory Error
>> Section 1 and 2, differences in the support are:
> What in the h*ll is a Memory Error Section 2 record?
>
> Your RFC doesn't explain it either:
>
> https://lore.kernel.org/all/20260929074659.2587216-1-pierre.gondois@arm.com/#t
>
> so it must be something magical...

I'll add the following to the cover-letter(s):

"""

The CPER Memory Error Section allows to report memory related
hardware errors. To support:
- up to 64GiB DIMMs
- DDR4 (bank group and address) and stacked 3DS technology (Chip ID)
the record was introduced a short-term solution:
- Validation Bit18 "Extended Row Bit 16 and 17 Valid"
- an "Extend" field at offset 73.
and a long term solution: a new CPER Memory Error Section 2 record.
The new CPER record was introduced in UEFI 2.5 spec release
(February, 2015).

This patchset aims to add support for this record for existing/future
platforms that might/will use it.

"""

