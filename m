Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=2 smtp.remote-ip=52.101.66.63
ARC-Seal: i=3; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794221767;
	b=EBkKsVIk6QoQz23Oz7JU8bL4uad71dzIMYEuEebcv8L6KezOXKX8LJEFYL/GGBZU4e4Z
	 +D3UGFxOZTS5U1ACkQtUUt15KkpHLHIXrtoQhkqNsNqe+OJIxROzbbL2QPtJQnDKfq/Ax
	 hOjNzKF3isiJsQuaOd+ilQdYi7fMPZKwApXCbBeS0pDBe/dk5z/s7DiLm79Pylp3Pkpmj
	 H52ufqeVARzhGOouV6ccX9fphC9oOV4KwfzmDqzSL+tF4kPx9EM+xYjxZyDhYT4rfH9gX
	 y0JlHozidK7rdvct9FtfjeoBhTfChIJ8SaUMxwMDvazGfLmnQKSKUzp+Hk2E2exsXLA==
ARC-Message-Signature: i=3; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794221767;
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
	bh=6dFETyewJfLn7z3fRCFePIWIe7ZaOVUtQb/Pt+e6j9E=;
	b=L3E/uio4tBeiifb3+OK3XAjAbnJevQpNodYxcC5u82wEr3hO5RJOVcwbZRSjP7O7671d
	 zHOHqBtHl88E4JQbNujja2pfN4CGvSlZlO3TBM+Gr0h3tSW9YtuIFKZaOBbdXAMbdfKuk
	 fGarJR58rJzuN5w2HjAjv8f0ANWdERzn7jOfQ3P4eVY3hhBlmSEfujQ9Yxd8wfDAesvfL
	 MsW1iCOtJGTePmQZfCdz4mdXy8w7cJsmPOUohzlBfzj0H0YxOy+g0BvPZAUMd4/0UuszI
	 9PCrmhSXJWpqm4ciRMZ46dj5+ikO+bUSDj0ysB7+kVa8bAwq3xxH3aef4RCV50FuFKA==
ARC-Authentication-Results: i=3; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=pfqfalnK;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=pfqfalnK;
	arc=pass header.oldest-pass=2 smtp.remote-ip=52.101.66.63
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012063.outbound.protection.outlook.com [52.101.66.63])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9099606A31C;
	Mon,  9 Nov 2026 10:56:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9099606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=pfqfalnK;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=pfqfalnK
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=s6/O/k0ZmwYGkN3jmKxZVTXtLzQz24u3Waav6ioH2tUSvw0HjdXPBS0Qa95bZ5/fNZfV6svvU0ul0SAn+uyT7nXqvaQODgQL2Z1EY8NiJNb/MoTICKUQ5oGbVpBhs3IEhxNqtYWJ8898QXzb/+ChzC1ijUqo627ekbcVoIpogcIg+OBmBzdh5vQnpXQN6bZ+KoBI23OVzHzZaGykdSHfWtGF738dj7Q4faKkTUxJ7NWnZvyoVlTZphFrucWNk+LYGOKWnCit9+TJQ0PALL7jpd6qZX+2WOJZCxdxJYuZnPLMkCnOoh9Cy3ItH6FWxlaeMhxZRsiDO7RwQgYVaGWejA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6dFETyewJfLn7z3fRCFePIWIe7ZaOVUtQb/Pt+e6j9E=;
 b=C+T11FsQ60Sp/XwuX69wHNeW+ciwe0ufnWSYb6WaAqrf7NuenqVlAyT6ipiAy+jRD5NvYTlao9TLEuLvab2rjk9GySVYPFwHzMRHUrdqF4DPaDkQ1hO0xqPLdemqYJBBrSmfskVrWiVLOyGsHgPEPREpxoTHW0ZO+okU/RBFOpnOyzVO/nveBtOd8umrI1shb7pgESjTrNg/fNnFq20bhqreqNkfuEYupR5RQum5ymrVuHOGoXyfL5b+FGskofJ46hgkeeEZdwQdohX1exTLjDbpUr17b/d62WmgBmjVpsIIZsoKhZdeWKdiBj7ORAkepFn5/9+4lGRyayrfeuDy5g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=debian.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6dFETyewJfLn7z3fRCFePIWIe7ZaOVUtQb/Pt+e6j9E=;
 b=pfqfalnKDkdL6ebAAW4MOTCLc8vANundU4F50urwkjyoY/6JvyGlgc1sDdDFCd3x7j6uTZACX3WZK3cebs1kKbyEObVYrTJwFzkZslkpYf+1H04xJ2s5NgDw/XuxwipmNO6wMtppdnHfaCfchUwWzxo1nrQ2OGZpyu3JA4ygEm8=
Received: from DUZPR01CA0321.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::15) by PA6PR08MB10526.eurprd08.prod.outlook.com
 (2603:10a6:102:3d5::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 10:56:00 +0000
Received: from MA3PEPF00000407.eurprd04.prod.outlook.com
 (2603:10a6:10:4ba:cafe::11) by DUZPR01CA0321.outlook.office365.com
 (2603:10a6:10:4ba::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Mon, 9
 Nov 2026 10:56:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MA3PEPF00000407.mail.protection.outlook.com (10.167.241.152) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Mon, 9 Nov 2026 10:55:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tg9uULs46p2qYMptP9aPPemfb2ba9hEdC9gAl20PZjlWLBDAASQFVzuWz3lSeqagDkWoMdUfr/dmdmXPupm6yCjz8zkxJHmZzOzTzoFasTDQj009hFcdhpOMHZ9JsUrEIhp6kEsuVRf5Cisl5kQnTQuow/uyIyFnK90U0QtMiTsWh8woHszJl2iWM1rTUssD4FI5Balo9u8vDdtT/qDNzfKs6GmhJ+ZWL4OlMP/0cIoYX3jnL5VEltu2GG2Df6Rp7UJvrB9+UciiamopZmIa90UvUxoGL/K86PTYbBGXZg9Sq1TCI2Ki30u3P3z39Ativ7PmBFsJF7apmh4vjFr8BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6dFETyewJfLn7z3fRCFePIWIe7ZaOVUtQb/Pt+e6j9E=;
 b=zEtdEWoprrUAR8KytLzKIruuyqOT4V9zNKiIK3jJX9VY/JkXH5EtGmodxdXv7SSl7NC90LdSx3+6W2xHUePZIF9Fb1mIA+EcSS2VhXTFNPiOqIVsKC//YPJ4+wgRRxJojpo1RTred4ihBOh0g8hGXbb89UBzaurDwpUXnj68ouDupqFsG30/qPS+PP72UWDaZRcQ0TEObBr4nPKr4xb3skjuOuX3zGRcyPJ9ZPfM9uJn1HC7aFItFkryA6pT4gpUrtnaXCJq2NTbV7I8s8364CaHS950Mlfv4MppBF8QSUdWQIYYNlzR0kzY7Te8TWZXldPjvD72zZAWrL+2qLKHzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6dFETyewJfLn7z3fRCFePIWIe7ZaOVUtQb/Pt+e6j9E=;
 b=pfqfalnKDkdL6ebAAW4MOTCLc8vANundU4F50urwkjyoY/6JvyGlgc1sDdDFCd3x7j6uTZACX3WZK3cebs1kKbyEObVYrTJwFzkZslkpYf+1H04xJ2s5NgDw/XuxwipmNO6wMtppdnHfaCfchUwWzxo1nrQ2OGZpyu3JA4ygEm8=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from BESPR08MB999898.eurprd08.prod.outlook.com
 (2603:10a6:b10:109::23) by VI0PR08MB10390.eurprd08.prod.outlook.com
 (2603:10a6:800:207::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Mon, 9 Nov 2026
 10:55:25 +0000
Received: from BESPR08MB999898.eurprd08.prod.outlook.com
 ([fe80::d62a:5300:bc89:9f62]) by BESPR08MB999898.eurprd08.prod.outlook.com
 ([fe80::d62a:5300:bc89:9f62%6]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 10:55:24 +0000
Message-ID: <4eea61c1-01d2-4481-9339-c09d8ee9547a@arm.com>
Date: Mon, 9 Nov 2026 11:55:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] ACPI: APEI: add separate Memory Error Section 2
 handlers
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
 Breno Leitao <leitao@debian.org>, Dan Williams <djbw@kernel.org>,
 Terry Bowman <terry.bowman@amd.com>, Ard Biesheuvel <ardb@kernel.org>,
 Morduan Zang <zhangdandan@uniontech.com>, linux-acpi@vger.kernel.org,
 linux-edac@vger.kernel.org, acpica-devel@lists.linux.dev
References: <20261104110355.1437249-1-pierre.gondois@arm.com>
 <20261104110355.1437249-7-pierre.gondois@arm.com>
 <94b213b2-dabc-46b4-8d21-a5dc8e8e51bb@sirena.org.uk>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <94b213b2-dabc-46b4-8d21-a5dc8e8e51bb@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0240.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::20) To BESPR08MB999898.eurprd08.prod.outlook.com
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
	BESPR08MB999898:EE_|VI0PR08MB10390:EE_|MA3PEPF00000407:EE_|PA6PR08MB10526:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b485b0f-4a47-4f5a-b175-08df3e500a57
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|10067099003|18002099003|22082099003|11063799006|56012099006|261026121527099003|4143699003|261026140227099003|261022113327099003|261028144727099003|261022075727099003|261102123227099003|261022105027099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info-Original:
 brka41iQMhx1J2M9ixiY/ZKdR7nPJM7WCn9nuN0DXYEW4XwP9XPyDyC73aiU4BAZutsNHhKx4A9TnUa7h4A6/A7Sxfs+KuICVZE69iPRAiPMfEXjhS5/7wvk7mMrWWtvp8yuften6iVxtZZVEkUW7WEYSDIqZmCf25C8JYcNPl+GJ7uN8Es0LKahq3LihTr2GMmucFWy3wuUhFlij9PEYbWwWHz/cCenGYmN3JnLng442TgI/7/YwuuB7gnxklJYLSTBJLKmtLb7vYkmwwMT/0rwRgx1ht4Qdly6+bCE+uXvxASpAup2IdF5cQFlYvB0A4X3pVo566mFAJUR8KTB6N0JGchnKbf+OKQKJh/6RODYuReqZIGJYjGvBvRQKy4YnZQElOaHwaFoMmJ537+muu5asF0DNt0fdjoMvNWY/nngWOp28g7mnh9H6ADFUp+PA8R/zLqElSey6z99vwx0bIawfU12bEwgNZDOzZv5D3QplaPyaFYKnVaAJEkpjmRzW2JUySObyHUOtlbxDKnesiQNRipoYl/geyDaHQj/Mu6IKcKj0Udhw8E/N3mXQRz3IThUziKWi+AnqQmpZ5JJAHKpMipVpaT2fyyoCxJwAsEZssRE0odTDuyr2Q3X//XgybxAt4PogGtCe7NwXbj3JoLn89HeuAolhRMeK1FxkDU=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BESPR08MB999898.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(10067099003)(18002099003)(22082099003)(11063799006)(56012099006)(261026121527099003)(4143699003)(261026140227099003)(261022113327099003)(261028144727099003)(261022075727099003)(261102123227099003)(261022105027099003)(261021121427099003)(261009223027099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 VxTeLS8o5UkyFG2u3lC3ga3AaXtJdDzZDwE7CgtN3bc38bJma3sPhv+FostzYHCiunzosE2jeh+tkEfQS4qmEJDCoC4GhdLIJqy0/pgN3ZKqM7n0SsWnp5leN8Zp1As3Omw2zNmWF9LuNHEvNIA3KdMBIQq/XPxlj2VrcG1h+fPdnw3LXKAQbI+XU/bkEt/pf1GY10YZHfE6eGfd9u4FFlUvXuVUU+EdotWmg+3TbWcdYn2dWevix4WSC1IaQ8qpfF4T+B8XSRV1x5vUHHO9AGLiypbtC3K6Zf4/VjoY90ocNLHa4dJZttinATTmsWVhfTuWaAs8DYnBI/IL1Nu22A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10390
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 MA3PEPF00000407.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	4d23b7ec-83e2-4768-ca96-08df3e4ff53a
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|35042699022|7416014|14060799003|1800799024|82310400026|36860700016|11063799006|4143699003|56012099006|261021121427099003|261022113327099003|261022075727099003|261022105027099003|261009223027099003|261026140227099003|261026121527099003|261028144727099003|261102123227099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	lw7lMkbpAbm7hM1Q4S7LMkaGYgfL5dKKGQbNB93Y+/L7SYBu8dV3Bf9tViuWsxZ0ThRDOCiEod0L6arJWgAd3tDHoJux45ZGgP75fIi0lv5qYFnYNppEl9Slv4+Sf3uHcy6CyMjXldWcsbT9lkjuACGeUH4IwAp81EXjZVoI0m3UKi7yTFXQdiL3fbGGSHLY1yGb0/P0JE+/EgzhbnFkdPpgHrCJ1Et+10lyRuCnnfar6hvLE9UhxSyj2IW8LvdBXm51Rwh9SFY34QBYBQN5XBNpzdZDlmR2GklH8+eGMAlZnFU7NnnjBg3fmsGQCyoaf1ABdIDd9BSV4mT4L3yHW3qJ+yvpQ6qkkNtnNYJwlURGUro8AjyS+YQorEzef3TKGcJ8t6nDr03xwCmNvZ6DytYVQbm7frszZfE9jV3UBZW1JBIDOGvell/3zS/XYruXxuloMiPTMkFvgGr/7DLUV3l46Uxg5UNimC4/zB1QUjEMT0W7n/+bt2Q8I3z1D/6gbKGP6+8sPbu1SjWJDXER+kiwYEEUd0ohTpr2mLcFhL48LH9p7nfAE8a5OK0z63ZlvuytD/U8GLthCY/htMCl4O6XiOQ9nB9YCu606DDblepIAQinJDK7Ra4C4jtpQdJpQligHUuc9ZrvgAK0ZJFG0Vu5IcRNR/IrOGcXoJOgHj6aIkv8SxK1OfFp9idLAvESLZUeZrZIF8kgQldCjFWwog==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(35042699022)(7416014)(14060799003)(1800799024)(82310400026)(36860700016)(11063799006)(4143699003)(56012099006)(261021121427099003)(261022113327099003)(261022075727099003)(261022105027099003)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261102123227099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5+H1SfiSge4JqZ0gtIVgVWp1IzJ6Ljcpxn/rvzZyEvtZejez8aWpdjEEwP8tlDE+leEO5kum/vKQB5lOLgxPwOvLLHg6PToW/eSdi+lJ+hAle9YUtaYWThn8zCfLQ1e9ZimvTeiVCgwJDjCvqB+t5PxUrE3/K5h8xSlDm8nB6ZmCi74qR0wMMcd3LKn5JI6k+Fj4Wu3mFFKVdLZJYnALhuiModXavwON0ljwezauOnvFDEOkgIV4nwMfk/SVINAe/rRQci7bx2PM0RZ99Om+FOJl4eHhv3O//UDhOFvDUI1FvWHIKEnxF2PggVtTTZOKCPy0B5ltYASu1SdbcBwVynp9oyXYdcJRLOlBKoazCHRj79mb4h8HKV3F+DLsEaDFmg85I8meR1hl9apHPjbXYbIKanbte+oLaPYUjKz9xxyyXUL+7E0PwUY96pydmU6B
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 10:55:59.9885
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b485b0f-4a47-4f5a-b175-08df3e500a57
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MA3PEPF00000407.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR08MB10526


On 11/4/26 18:51, Mark Brown wrote:
> On Wed, Nov 04, 2026 at 12:03:14PM +0100, Pierre Gondois wrote:
>> Add dedicated GHES and EDAC callbacks for Memory Error Section 2
>> records. Use a separate GHES notifier chain so existing consumers
>> continue to receive legacy memory error sections.
>> @@ -1008,6 +1021,16 @@ static void ghes_do_proc(struct ghes *ghes,
>>   
>>   			arch_apei_report_mem_error(sev, mem_err);
>>   			queued |= ghes_handle_memory_failure(gdata, sev, sync);
>> +		} else if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM2)) {
>> +			struct cper_sec_mem_err2 *mem_err = acpi_hest_get_payload(gdata);
>> +
>> +			if (gdata->error_data_length < sizeof(*mem_err)) {
>> +				pr_warn(FW_WARN "Memory Error Section 2 length is too small\n");
> The v1 code uses pr_warn_ratelimited() which seems sensible.
yes right
>
>> +static int ghes_edac_report_mem_error2(struct notifier_block *nb,
>> +				       unsigned long val, void *data)
>> +{
>> +	struct cper_sec_mem_err2 *mem_err = data;
>> +	struct edac_raw_error_desc *e;
>> +	struct mem_ctl_info *mci;
>> +	struct ghes_pvt *pvt;
>> +	char *p;
>> +	/* Memory error location, mapped on e->location */
>> +	p = e->location;
>> +	p += cper_mem_err2_location(mem_err, p);
>> +
>> +	if (mem_err->validation_bits & CPER_MEM2_VALID_MODULE_HANDLE) {
>> +		struct dimm_info *dimm = NULL;
>> +
>> +		p += cper_dimm_err2_location(mem_err, p);
> Do we need to raise the size of e->location?  It's 256 bytes and
> there's an awful ot of potential fields that could be decoded here,
> including some with 64 bit IDs.

cper_mem_err2_location()
node:0000 card:0000 module:0000 rank:0000 bank:0000 bank_group:0000 
bank_address:0000 device:0000 row:0000 column:0000 bit_position:0000 
requestor_id:0x0000000000000000 responder_id:0x0000000000000000 
target_id:0x0000000000000000 chip_id:0000
~244 chars

cper_dimm_err2_location()
DIMM location: not present. DMI handle: 0x00000000
~51 chars
DIMM location: %s %s
~depends on string length

So indeed LOCATION_SIZE should be increased,
512 chars should be better.


>> +		if (mem_err->mem_dev_handle <= U16_MAX)
>> +			dimm = find_dimm_by_handle(mci, mem_err->mem_dev_handle);
>> +		else
>> +			pr_warn(FW_WARN "Memory Error Section 2 module handle 0x%x exceeds SMBIOS range\n",
>> +				mem_err->mem_dev_handle);
> There's an equivalent print in cper_dimm_err2_location().
Right, I ll remove this one
