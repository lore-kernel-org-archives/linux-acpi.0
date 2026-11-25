Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=2 smtp.remote-ip=52.101.84.38
ARC-Seal: i=3; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795624259;
	b=ExyfebrfcO023VYmEdQ0rP+Bwa7yTwo7jyvCVydwUvAO+O18k0gDev1Vtd8tw2eWpHwW
	 tCGgyjV7JYPKKndhJ9UiY8bQzk2rhpen10ZlE8JFWUFqlVdgY9rb60ovB2Ee89RUcETsx
	 wtVF7IhpoBR8+YWrWdrRrTC1DL93A4y3nx4VxfhpChJaQGwbToB6VnWjBuec/kVtHO8yc
	 O/ZqqaDuqrUT5i25mgvq3sHAKb/c4EPBzKzZ853Cu2CP/zPBhOrl7W8zSEgri9BQmrbAF
	 uE5y3mzJfHEhHJKuHlF/9q5/c0/h0s5/aOr5HFfvjbw8o6B8WanzwjY7YimlkkrKojA==
ARC-Message-Signature: i=3; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795624259;
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
	bh=IGhS1K5xgIXc3vHYTXyRVwMvKbNv2pPh5lYTP3sj/2s=;
	b=Y+Ys2cTPdP53xs9L0kwQz8lF4cfjtI2HRU2orbuAENplT/r+fpIQ/fjLfLlz32nZNY6o
	 yiTK9Edm2EDAmlZrAiGCkIcC3iowdXLw/7SOKzd4KkPKZ07R9xXjz8cx/YhEAgFAf+q7N
	 pLxb/gUtAt7xIvEv+G9t2jiKZq/+pWorzr4zYC2rdaKwx96cjGwKQSYYdeJqtRKEDVgjc
	 Eyi1BljyM3EhBN7vjcPR8I4kwiT0iAECCiW+tS0TM2npG1B+sYyiYmUSOWAagtGdIOvCd
	 sVAWxu5nejRM/gVlsbyx/gL3otjb7tWvmPLWJDAGsKrg7MDnkLJvY+X9cdAW/JsxFrA==
ARC-Authentication-Results: i=3; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=jgqBv4WA;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=jgqBv4WA;
	arc=pass header.oldest-pass=2 smtp.remote-ip=52.101.84.38
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010038.outbound.protection.outlook.com [52.101.84.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D43E606A6A2;
	Wed, 25 Nov 2026 16:30:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D43E606A6A2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=jgqBv4WA;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=jgqBv4WA
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=AEnSCrbz2qRGL5b4mlW0fugTw1jjLo6xXEQmyq4clSGzRTasNB6vW6u2NcfSXuuOu2oeMC7SOhX6034AP6YBQ7MuqMny2jnSZVWkg8i8ApnjbEzD/xXpmqFlaNnKDyAEJv22Y62tDjeoBlRxZRBshMO2UMytTCKlpbntjIz+OhFY332FKmEQ/EPYcALR8V88A+JTkTpQXwpgH+cfziMwNca7n3ch49eABKXiq9la6aw1P1Nzvh2XdHWppLxnrDZo+9nv7nkPJoGdzvr1hkD+FwSQ8QZP23CIW6WvxVRNsvnov/qGPs1ni4P6zzP0GjyqXvflDu2Cy7GJG2VFvXHaPg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IGhS1K5xgIXc3vHYTXyRVwMvKbNv2pPh5lYTP3sj/2s=;
 b=S6USJbv9J8p8QiqT9bjJZOjm52Vs3KLe548Hw8QvAyeNih3aTfGlj6tUwR/9n0JbuqwKowEHejk8Yi1ZDgr2zW5WFM0w6LnIggAyBZrRaQhOVVrQxPq+sETqqemdnTwBksVdomzgBCAUTRr+pFysI+6BXvvVH1D+VCc6omuFlEJAbcTB1UfbICtx7Zp8oNjNR6N5VE9HIqfR7i0UOW+y9ZB/RiDySce69v9TsfOqm/AVuPqOzPkMHqyE3zv1ue0OlPAgYve5Ov1YOzEeHions4MFeyXAgMr72yYDcwGrJWbUMGe4YsVYTrRGSa/0Y22WLjlAN/8Ayq5KxEh9uSu/PQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=amd.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGhS1K5xgIXc3vHYTXyRVwMvKbNv2pPh5lYTP3sj/2s=;
 b=jgqBv4WAj6XjrdYW8ujS1Tv8TDvi9uA9wycVGbblut7cralrwUviU8uHVKS8Lc00LuLWGIcFa9xIZNfBa6ZoalOpwZnkuFjWJaiWP3kU5koLV4kt3CpQTPjlS6v3yGAj+W+ddmjE0MpopkN9rnNA2BPYPy5XhM6FGxN/z55Jhwg=
Received: from PAZP264CA0013.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:21::18)
 by AM6PPF4B4EBFCF1.eurprd08.prod.outlook.com (2603:10a6:20f:fff1::b09) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Wed, 25 Nov
 2026 16:30:53 +0000
Received: from ZR1PEPF0000E6B3.eurprd05.prod.outlook.com
 (2603:10a6:102:21:cafe::a) by PAZP264CA0013.outlook.office365.com
 (2603:10a6:102:21::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.6 via Frontend Transport; Wed, 25
 Nov 2026 16:30:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 ZR1PEPF0000E6B3.mail.protection.outlook.com (10.167.241.90) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.3
 via Frontend Transport; Wed, 25 Nov 2026 16:30:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IkduhW2D5VXfkuHMMhcDQvnVLNj6QzMs5DQvdYbTo1J2bdfsDg72ghNzJSpirrs6fPhynMKx2usx+QhCaoii1yIdUiwtLpwe30ze8Gf7t1VbUtNc6ssteBw8iQ0Y6BKgzOediACG69PuKaOoWBXt09dyVhhE9mjtyenkGME0Rtjh+Bhg/EfC5DNGhHVAzMhzE12xPzomdqgPlz/VkEt2RBouGpG2HlOfWOFPbgZf4RtUEW3VSOh+BAptLuc34N0Nd9XFeXB+hxxscBHiM1ZDZ5Ty8Gs2xcoqCBeNsyLzKqaIzy93pggcfpqQn2PNjj1iQWBexXZR8y/5vsdCFHYvHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IGhS1K5xgIXc3vHYTXyRVwMvKbNv2pPh5lYTP3sj/2s=;
 b=OgbJ2zNr8JNR23bqT8b0TtYd6iLkfeId/LaXZYr9PsJG8detGpgyD8NW6dFXwd71O/HouHAsIMPF48HY1SeYcGHru8xWaBr+RZ8wfLZTPaoWjWvPQSxfRAKimh2TAPsiHRks536tQTt3+egTVm1rViVkdDCDyzyiRu7OSZwbGf2f5RjTbhaC1hvyoP4wvNsov7fX43glFPIw7M/8XbnD7CDrHUDZD9IpIaUX4x1DrDYFrSfS/Au7xkIEvf22N3/fy13j1udHGUdUsIHPA7pzCRjrE8xBrQPukfvxDFKHp26xm8ajS3+4VDCkfzhj66NBe5YcnYwHh3+cz9wSYarCmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGhS1K5xgIXc3vHYTXyRVwMvKbNv2pPh5lYTP3sj/2s=;
 b=jgqBv4WAj6XjrdYW8ujS1Tv8TDvi9uA9wycVGbblut7cralrwUviU8uHVKS8Lc00LuLWGIcFa9xIZNfBa6ZoalOpwZnkuFjWJaiWP3kU5koLV4kt3CpQTPjlS6v3yGAj+W+ddmjE0MpopkN9rnNA2BPYPy5XhM6FGxN/z55Jhwg=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from BESPR08MB999898.eurprd08.prod.outlook.com
 (2603:10a6:b10:109::23) by DBBPR08MB6315.eurprd08.prod.outlook.com
 (2603:10a6:10:209::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.5; Wed, 25 Nov
 2026 16:30:19 +0000
Received: from BESPR08MB999898.eurprd08.prod.outlook.com
 ([fe80::d62a:5300:bc89:9f62]) by BESPR08MB999898.eurprd08.prod.outlook.com
 ([fe80::d62a:5300:bc89:9f62%6]) with mapi id 15.21.0639.012; Wed, 25 Nov 2026
 16:30:19 +0000
Message-ID: <7288ecda-6a1b-4b3d-9e2f-8bdbf935efc4@arm.com>
Date: Wed, 25 Nov 2026 17:30:18 +0100
User-Agent: Mozilla Thunderbird
From: Pierre Gondois <pierre.gondois@arm.com>
Subject: Re: [PATCH v4 00/12] CPER: Add Memory Error Section 2 support
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: linux-kernel@vger.kernel.org, Ashok Raj <ashok.raj@oss.qualcomm.com>,
 James Morse <james.morse@arm.com>, Mark Brown <broonie@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
 Hanjun Guo <guohanjun@huawei.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Shuai Xue <xueshuai@linux.alibaba.com>,
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
 <20261124151417.GB2156781@yaz-khff2.amd.com>
Content-Language: en-US
In-Reply-To: <20261124151417.GB2156781@yaz-khff2.amd.com>
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
	BESPR08MB999898:EE_|DBBPR08MB6315:EE_|ZR1PEPF0000E6B3:EE_|AM6PPF4B4EBFCF1:EE_
X-MS-Office365-Filtering-Correlation-Id: e3e87088-9ce8-4015-1a2a-08df4b11791f
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|18002099003|22082099003|6133799003|4143699003|261009223027099003|11063799006|56012099006|5023799004|10067099003|261102123227099003|261026140227099003|261022105027099003|261022075727099003|261022113327099003|261026121527099003|261028144727099003|261021121427099003;
X-Microsoft-Antispam-Message-Info-Original:
 5qUuaP7tfmpDNM1i43Jzsj18ovFzHcHh7n9q//nydf1Obul37cJCp0+TTtQHJqBvs9VT46lRhj89681Gwa6WEzt+rI+G1jGhFlDHjYntiFQ+fjVGY9XnDAy/D0ZDt52nJhmQFX/gqjdHrHdidffBFJbhMQmxQaTXcnLq+DEM0SzyMhZUobpYsVGmKyRvitfAtS1k69+0YLy1TDe7XTSTKHW7yMiyn2foqiOVhG10IrV/FrR7NumpYReJK84/rIW063FK8lOgqz/bObcZrEZHNmz4Cg1dXg9LdASO6RtLYHsDRSMveSF2xrKLYRFIye7nUjkK7atHgK6uOuWgB3BBAmYCme7C86Ba+cZQENKxM3kH2PFoa5JPYfXV14DjbWMTuezBAMUpG+w0R3cGLG0sCnyuGB/92C1SgyAI7ribDziv4XXPGV7uTybuDRgO13Eq0u5Ljz/F+RRRukVQn0adCaBmhAaUhqWF7jNE+vvYc0W1liPqO7oydGo+I3NQeaP7sUtaaUOJCNqXdm++wiX5POBBiwW+YCAJxIMLv2C9rXa2hqOnfFcUq6QHhUyvyUbzTtuPhQryK0Ut5p/oLJab9eS8Ck2E6mk1ng2BheBEPWR9DWgJpfcZ7cEherkKVWOB
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BESPR08MB999898.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(18002099003)(22082099003)(6133799003)(4143699003)(261009223027099003)(11063799006)(56012099006)(5023799004)(10067099003)(261102123227099003)(261026140227099003)(261022105027099003)(261022075727099003)(261022113327099003)(261026121527099003)(261028144727099003)(261021121427099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 O/k6H9HU6AvGQk5TSSIZ3it1kNZfInZwkszYuQNOcmTgi38ZbXMYn+3Bvv3Mst1XfPSH4gYw4t88L33i4azBbz5HS8cbgVDt3QIlbhuzBxFlLCvrr+PQ+TGWU9vMkkpkfakrhgPCUwQ5c2MkzT6GdhtyrFV01GbLKg9ESnGedZkc6vsD8aCGj3iGGOfyM7t7WzEzP7/NyMbYgYN6hWB59St9wJjryqSKq0JxHx+piFc7a5Qp7DR9LyptgBvkmsojFc23mDumdIXteUOwD3+SWklHT2cqF4hg6fbpwhmLt70EQimhf0+KH34KV2MJucZ2mSbVsUVsVS/F7tCtXze31Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6315
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 ZR1PEPF0000E6B3.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	7e5280ee-0f49-4cfa-aee6-08df4b11652c
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|36860700016|14060799003|35042699022|82310400026|10067099003|261026140227099003|261028144727099003|261021121427099003|261102123227099003|261022105027099003|5023799004|261022075727099003|261022113327099003|261009223027099003|4143699003|56012099006|11063799006|261026121527099003|22082099003|18002099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	YTIjXkEosbRhLHtplC+SMEn6K2Ogop7x/NDs00KZFQMXpe3OmJA8SieEdXAfE5jF53aTuYHNtYgFYEeH//WlNIQdUDpefOnbOuh45ttO1hdSjhJj4AN4hT44i/Q9acqLijePaKjGZb8b0xngAdt+cMyoHD4eAP9X0Q6xlf5Edlfv2vpgJiIsOSRQNFprtdGhLn2S+kby49kQw1hW7wwF1sp8Ih1MuLfzYMJ7sQNm3oZwh8x0w1fDkyyS2ISmpWDazeeSsUF7v3xAkD1nPi963v1zW7A/Zd4lZ2iVdpij1eOX4+5Ut17fQ+CAMLaSSK8+/fj7xJmvDzyfwa1haOzkw83lzmWM5NMY0bOIQWxEyW1x+6LK7qbDDOLPcUCEXAry6S//OE85kZAt5rirBWOlI20BSKT/gh25lFYb8kBCU3703tvO6oJURAlZMNmadLcgrTCqVRxTXJUqIljWnmArEKFlEdXuvA/TzcZ7/BNzQR606brIbm00EUmFAli9RUmd/5lBGqZA3XQoh1wlQG272vVaPBJ8yZ5luPZ8QOyT6K93WVOgvRamEpWNLZWv5mOvUi7XkkZcfgHoZURoeZ257stp+OBUven/lM6nUrd5P+7fbibO9QEnMsevkuZQufYfNIOs7DMz7D18vc3QjgGWSQ==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(36860700016)(14060799003)(35042699022)(82310400026)(10067099003)(261026140227099003)(261028144727099003)(261021121427099003)(261102123227099003)(261022105027099003)(5023799004)(261022075727099003)(261022113327099003)(261009223027099003)(4143699003)(56012099006)(11063799006)(261026121527099003)(22082099003)(18002099003)(6133799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	X87yiSQjtySYf82ivRCdGfW7EkNTeBwYjB4JuJ8/IN7R+MaaSYjCQjKHWCwdRyN60yWP2FE4StaMcWqmnTPqnnfGploPIEDweWlmGcBWUJnd+3L+aMf5l3WoeEsYZtu8DJUEOp96j+837YJf+yMPknMlU8i9tTlTf+oPbxqEf15FP3a5tCK8rxMuz9Rxti2q3fAlSwSKZMMtyuQH5dMGtP9xp7LVKu26LdI7cc0CFh/EYzR4p7yMEKXtSDL3zMj6ZhUqvs1mS1BD18yZEdCWXWV6GoDwRDfEaaZzgRRxeS8N+UrkecoV8Y+WLOlzSnb5yTJMairQXh/NH8bQ66tEObIVYlXl2BelotBuxlJoWKUc0ee+n7GK3jt4Xdn1ogAPuLywvtpENcszTyEU+0k12Zg//FPwtbSlYekkdJQmtACSsL8/nGxQgpVQxgAYPo56
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 16:30:52.6805
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3e87088-9ce8-4015-1a2a-08df4b11791f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	ZR1PEPF0000E6B3.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PPF4B4EBFCF1

Hello Yazen,

On 11/24/26 16:14, Yazen Ghannam wrote:
> On Fri, Nov 13, 2026 at 02:24:42PM +0100, Pierre Gondois wrote:
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
>>
>> Future:
>> - _OSC support (if agreed)
>> - Addition of arm64 tracepoints
>> https://lore.kernel.org/lkml/20261023170405.000060b8@oss.qualcomm.com/
>> - Emission of lossy CPER Mem error v1 tracepoints for legacy userspace
>>    tools
>> https://lore.kernel.org/lkml/at0rs4parlHFGI7k@hu-ashoraj-lv.qualcomm.com/
>>
>>
>> RFC:https://lore.kernel.org/all/20260929074659.2587216-1-pierre.gondois@arm.com/#t
>> V1:https://lore.kernel.org/all/20261019145643.1877246-1-pierre.gondois@arm.com/
>> - Corrections from Jonathan's review
>> - New patch:
>>      [PATCH v2 4/6] EDAC/ghes: Extract error report initialization
>> - Last patch not in RFC as it has been reviewed by Jonathan@
>>      [PATCH v2 6/6] ACPI: extlog: add Memory Error Section 2 trace event
>> V2:
>> - Updated ghes_edac_init_error() to ghes_edac_init_error_desc(),
>>    which now only acts on the input "struct edac_raw_error_desc"
>>    + added lockdep_assert_held() to ghes_edac_init_error_desc()
>> - Accumulate failures with "queued |=" in ghes_do_proc()
>> - New PATCH:
>>    [PATCH v3 5/7] ACPI: APEI: Extract common memory failure handling
>>
>> V3:
>> - Added <linux/bits.h> include
>> - Used pr_warn_rate_limited()
>> - Removed one warn for smbios handle overflow
>> - Replaced __string() -> __string_len() in trace event
>>
>> Added patch to us scnprintf():
>> - cper: Return actual bytes written by DIMM location helpers
>> Added patches to increase buffer size and prevent overflows:
>> - EDAC/ghes: Small buffer fixes for mem other_detail helpers
>> - efi/cper: Pass buffer length to memory location helpers
>> - efi/cper: Pass buffer length to DIMM location helpers
>>
>> Pierre Gondois (12):
>>    cper: use BIT_ULL() for processor and memory validation bits
>>    cper: add Memory Error Section 2 structures
>>    cper: add helpers to handle Memory Error Section 2
>>    cper: Return actual bytes written by DIMM location helpers
> Why not use 'efi/cper' for these ^^^ ?
>
Right, I'll update it


>>    EDAC/ghes: Extract error report initialization
>>    ACPI: APEI: Extract common memory failure handling
>>    ACPI: APEI: add separate Memory Error Section 2 handlers
>>    ACPI: extlog: add Memory Error Section 2 trace event
>>    efi/cper: Pass buffer length to DIMM location helpers
>>    efi/cper: Pass buffer length to memory location helpers
>>    EDAC/ghes: Small buffer fixes for mem other_detail helpers
>>    efi/cper: Increase memory error location and detail buffer sizes
>>
> Boris already mentioned having fixes go first. I think the common
> convention is to have "fixes > refactoring > new feature" order. I asked
> an LLM assistant to propose a new patch order (copied at the end). Some
> patches would need to be split/reworked, so it's not a strict 1-to-1
> reordering. I hope this helps.

I thought sending fixes/refactor/new features separately would
make it more difficult to understand where the patchset wanted
to go, as the refactoring part is usually preparing for the new
feature. E.g. B2 +B3 only make sense if v4.7 ("ACPI: APEI: add separate 
Memory Error Section 2 handlers") is applied.

But if you both prefer it in split series I can do it sure.

Regards,

Pierre

> Thanks,
> Yazen
>
> === PROPOSED PATCH ORDER ===
> A. Fixes and cleanups to the existing Section 1 code (could be sent
>     first or as a separate small series)
>   A1 efi/cper: Bound the DIMM location to the remaining buffer
>      (Section 1 parts of v4 4 and 9: scnprintf, a len parameter, the
>      ghes_edac caller passing len - (p - e->location), and stripping
>      the trailing char only if it is a space).
>      Fixes: ed27b5df3877
>   A2 efi/cper: Pass buffer length to cper_mem_err_location()
>      (Section 1 part of v4 10, API consistency, not a fix)
>   A3 EDAC/ghes: Clean up print_mem_error_other_detail() buffer handling
>      (Section 1 part of v4 11, cleanup)
> B. Prep with no behavior change
>   B1 efi/cper: Use BIT_ULL() for processor and memory validation bits (v4 1)
>   B2 EDAC/ghes: Extract error report initialization (v4 5)
>   B3 ACPI: APEI: GHES: Extract common memory failure handling (v4 6)
> C. Memory Error Section 2
>   C1 efi/cper: Add Memory Error Section 2 structures (v4 2)
>   C2 efi/cper: Increase CPER_REC_LEN for Memory Error Section 2
>      (cper.h part of v4 12)
>   C3 efi/cper: Add helpers to handle Memory Error Section 2
>      (v4 3 plus the Section 2 parts of 4 and 10: scnprintf and len from
>      the start)
>   C4 ACPI: APEI: GHES: Add a Memory Error Section 2 handler
>      (ghes.c/ghes.h part of v4 7)
>   C5 EDAC: Increase LOCATION_SIZE (edac.h part of v4 12)
>   C6 EDAC/ghes: Report Memory Error Section 2 errors
>      (ghes_edac.c part of v4 7 plus the Section 2 parts of 9 and 11, and
>      OTHER_DETAIL_LEN)
>   C7 ACPI: extlog: Add a Memory Error Section 2 trace event (v4 8)
>
> Why:
> - No bisect gap. Buffer sizes (C2, C5) and length arguments (C3, C6)
>    land no later than the code that needs them.
> - No API changes after the fact. The Section 2 helpers are added once,
>    in final form, instead of changing in v4 4, 9 and 10.
> - A1 doesn't depend on Section 2. It can carryFixes:/Cc: stable and be
>    merged while Section 2 is still under discussion (Boris's question,
>    _OSC, rasdaemon).
> - One maintainer tree per patch (v4 7 and 12 each mix trees).
> - Consistent prefixes: efi/cper:, ACPI: APEI: GHES:, EDAC/ghes:, EDAC:.
>
> Caveat: C4 takes Section 2 out of the log_non_standard_event() path.
> Nothing else emits a tracepoint for these records until C6, and nothing
> ever does without ghes_edac. If C4 keeps calling log_non_standard_event()
> (the patch 7 inline question), the order doesn't matter for userspace.
> Otherwise squash C4 and C6, or keep them adjacent in the same pull.
