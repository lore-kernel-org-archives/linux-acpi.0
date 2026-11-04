Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=2 smtp.remote-ip=52.101.72.47
ARC-Seal: i=3; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793790472;
	b=VeeYms05jFXQkgX7hTieqb+3eDoezsjkXpEu0CdBQ70fVST2CpO+H7Lc2hE13s9nAiVu
	 SFMWE8fQId6y5uPU2CTF2DH+geIYwaB/3XXMhSQiJ6EXex48SsfkSOk9TZA8D1FxYsY2q
	 yUIBEBfIizb/lXKRY+hb0xJl/hkZ71jSMuUAjGwxlo+j+7FX8F2e+ohnJn6BtPvc8XSWu
	 zPGNP4UPPDmPnJwWn4yZgert+L4FrAfra5szdcdZ21Ml+LVEW7gkq8Ga6S1MbIm6QhcxB
	 YTCKsMMVuj55fY0hhLIbnQ+MoItH0fI3TG2nrxUaUXBIkBBSBCDOEK9JvyknlWLPK2w==
ARC-Message-Signature: i=3; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793790472;
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
	bh=p22c60Zr9+yDIsy0yDxCUsP2DlLvzCDlPZ07r6AYaj8=;
	b=VDfbSt74rG1+qbz1nb/J++iHhOYl0DLl4nb0AGRzE4o/2SeGyWfRrmwMBI0DAFxVdTvn
	 1Q7/jGxNtFFvhRT3PyM226R4RhfNNH9EJ+CENCxnQ9jka+PHcCMGwBxGoZlVKugH3rn+e
	 njRgghpZ7z3iPS/gi45RpSBpmuoV95coFLaDOZgaN93nV+vQrCcJ07oxcjyvBc/wBMDsA
	 g8RxXZ0yOKaG8I3dCMJDX3brSFYQhEXBqG9Lls3I36tyZyibELwoglHO+Zo2G9rpFlKNb
	 U0durATrqBsbF3Zah4OQ9Go55n5BJiT5yJFcRwroBc3svnUwUI87zxNtK362iyU48Rg==
ARC-Authentication-Results: i=3; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=QZoIw3ez;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=QZoIw3ez;
	arc=pass header.oldest-pass=2 smtp.remote-ip=52.101.72.47
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013047.outbound.protection.outlook.com [52.101.72.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A4C606A326;
	Wed,  4 Nov 2026 11:07:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1A4C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=QZoIw3ez;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=QZoIw3ez
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=hLIGdHLodjcAEHw9XS1O2KYgw+LYON3FOE2l1Xm1TV6O6qDZZVl9oqNUjG9o+9BvBONPsonH3U1jxLWVujS1FpL/5ARSLD6AeTT1Nm1V6a3X1sN8E/0unecUT3BJbZgBHDfVEe7nWrgs6D7NklGFWMf+lmERq+f80Frpxf2AT6EdiFTqfpCewF7/RAdvwhqx2Qdaar97GYyPp35U731zKIHrCLOpqafK+031mr9AI8zKWzlPavOKeYi1ZBuJ5vV0H/ryZvg0e4rSzRqpYI0QE/6k56338zj4g0R8exBJ5gMUMaac9jKTH8JScFgZ1rgjTaDzRIuleQkrafF/YOCfyw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p22c60Zr9+yDIsy0yDxCUsP2DlLvzCDlPZ07r6AYaj8=;
 b=nHM22GPuafoMbIhzDjejx4bWKHI3pMBVP/gsdf0eZ/rpw060XjzLdQqzD/DH7T6UG/weLWqdUmaZauQwK8tHZlLgQXg3qoDZfzEewXH3xVLEAKjcFi4mT6Ge81Ue7veIt9Gs2Ex0LsbWMh6MwQnm/liNawKPcpPlO4ecYSLAAzme8o0FqiszNoSrg0fkluLi2I228GBFVyZvk/vHV5qcyswlfpJNJHfiZnbhZzto3CRzlJVfIWOYe5KMMApCULyQ/bgiPfH4HiJsXDImrEyFoFfPXgbChcDCy5vvT4BRIdqGdwLVmeG6SaN9/oLlA/zD066lQtIcOnetHJ443yi3cQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=oss.qualcomm.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p22c60Zr9+yDIsy0yDxCUsP2DlLvzCDlPZ07r6AYaj8=;
 b=QZoIw3ezGhw4NYBpD3ZwCZNjuDdBtBORJR5MrU1Ik/LpKgV4x80X+CTKBUp6rkCPfVjdkDl1EWNXWElv2fXPdmlX9HLFR5fP4n8f6a1p62uokHLC5YaIya6ud/mxXT/VbBRQeYWp7RiMg6bAauZOeaaGdY0NuFHMDUjNRgwxp9k=
Received: from DUZPR01CA0345.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::28) by AM9PR08MB6068.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dc::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 11:07:45 +0000
Received: from DU2PEPF00028D09.eurprd03.prod.outlook.com
 (2603:10a6:10:4b8:cafe::58) by DUZPR01CA0345.outlook.office365.com
 (2603:10a6:10:4b8::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Wed, 4
 Nov 2026 11:07:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D09.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.5
 via Frontend Transport; Wed, 4 Nov 2026 11:07:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FQqq6OxftI7N211+aAD+zT5HRD/272FAL54qgGYsl2UYikpy41OZ6IgzkUYGRr1dqGkVFI9qhqQogsW8Jd9Up1lNfeC/ZYEVVEYHyxhYghcJa5FLU51hn+Cv+6x0+MeH20nI1WY3MDf+jyDeCaCwOvezbwH2N25bIQ3LQMa9vE6bGvnYmkCbADutoWxMWhxGhoe7ME5F+tKDiOUJRUOFVUWQhGlppahpR4zaS8yPeKQ8ES2qoGmbilzV9fRIfwsMd2yUtUIqZdKPmSdPNxgm6rfY19Jn+F9tqEhMUD7WkEBE3jr3LcJCyhPjsf7knO/1mlf8Ad6/KIzkyab+K5Nz4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p22c60Zr9+yDIsy0yDxCUsP2DlLvzCDlPZ07r6AYaj8=;
 b=AyIgSiLKCLTu+qWWhehCF5OvE0RI5VCbmXmeameOuC4uU4OTdlM3fmNqg7W/Iquh+QnCITnbWdBe8hpdEqzdEVQ9Qc3Cn4WHYaJt8IvKmQPjibNDy0boRymBYOgA4q5OCYDOK9fQOLgMfQhbh9BDy9mfrlon0GoSxMBZzDQsH5g+yZOcLykg/PEcKFMaswcAbFUkcOC801TqrgcdSsMzFII63NOPGWH8dcPZ/IjgOYa6/ZrVDL6K2q/+asqrb/6mutZsn/KlrhV38fwUa+/uDqjXR34b2psnedsDGJAnWYz8IbBPflebZzzEoUxYJH+BzrE1fl9oG2H41tvGQOOYOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p22c60Zr9+yDIsy0yDxCUsP2DlLvzCDlPZ07r6AYaj8=;
 b=QZoIw3ezGhw4NYBpD3ZwCZNjuDdBtBORJR5MrU1Ik/LpKgV4x80X+CTKBUp6rkCPfVjdkDl1EWNXWElv2fXPdmlX9HLFR5fP4n8f6a1p62uokHLC5YaIya6ud/mxXT/VbBRQeYWp7RiMg6bAauZOeaaGdY0NuFHMDUjNRgwxp9k=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from BESPR08MB999898.eurprd08.prod.outlook.com
 (2603:10a6:b10:109::23) by GV1PR08MB7876.eurprd08.prod.outlook.com
 (2603:10a6:150:5f::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 11:07:05 +0000
Received: from BESPR08MB999898.eurprd08.prod.outlook.com
 ([fe80::d62a:5300:bc89:9f62]) by BESPR08MB999898.eurprd08.prod.outlook.com
 ([fe80::d62a:5300:bc89:9f62%6]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 11:07:05 +0000
Message-ID: <7c59eada-ea8d-4b04-a24b-9ba6aa2a6c64@arm.com>
Date: Wed, 4 Nov 2026 12:07:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] CPER: Add Memory Error Section 2 support
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
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20261104110355.1437249-1-pierre.gondois@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P265CA0004.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::20) To BESPR08MB999898.eurprd08.prod.outlook.com
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
	BESPR08MB999898:EE_|GV1PR08MB7876:EE_|DU2PEPF00028D09:EE_|AM9PR08MB6068:EE_
X-MS-Office365-Filtering-Correlation-Id: 177a5c41-34af-43c2-b7f2-08df3a63da1b
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|7416014|23010399003|376014|366016|261022105027099003|11063799006|56012099006|261021121427099003|261021123027099003|261009223027099003|261026140227099003|261026121527099003|261022075727099003|261102123227099003|261028144727099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info-Original:
 3cRfCByZk+XA26gP+wardMV9Ru68mdidDlhC+OOjZ/tz3LThLnO0r5BVReB72KQ2Hm1uvxSEbWUDlYob9EmPa6uQFuk3B9t/m9xumop2obw3UdBucHU0GIqppQJyNCf3WFWPquqLbPQpBR9SEidjljMG41LSlFhziH9wbgLfle1TB1yaDzSdVr1syT5dqkZZToosmEaMauj9clsWZTYbVf1HWvZcWWY8V0aXo4CuvuqPP5+1waEyL7Mj0RSw5zJuNpAWIJq2R+5qmpLpCQ/hUHhGZ05jdx862WMJq1UtP2e7fLXfs2mw0948yiyCfoNMoPbrIIV2k/rtxqsUnHXq9cCtYQJuLk8mQgEjA26SRuVAtkmAxacIGxuvEbx4x7bbNg6HTAWRdqKUeedG07VKGZzd5Rr1juC0Cbuk3PO1NXbUJNPv12y1HZ0eE3XBtA/0fTLUazPEP1wfrYYbGOqgfn9EVhL2HTKT7mHo8hybQHrXqN/oNnNPQ/1+tyEM9dmKfg28Vbk+naStixqgDfPqsJ+5sO4VE04vTzq7A9zrm6S7+dhDS4HNHAq9m2Er5Q0QTJvDH4cbOluK0Ga9bFPQ78jixZ5WyiWnEZPQmCfMFcreq+DV0FBFplPeV6TR2lBp
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BESPR08MB999898.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(23010399003)(376014)(366016)(261022105027099003)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261009223027099003)(261026140227099003)(261026121527099003)(261022075727099003)(261102123227099003)(261028144727099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 cjgYAZyBuC3MZTWlBghSUdhCM9BFpThfDhlxJwTpftShmmnxLW9AIRAvsd0RnYSqdF2oeJtnnD8t0JJQTD38fEuftUT6i9Rmaeg+Y4V1cdCsYz3A0e6XEW5mtaj8spAPlo27U6vspInWro1TAgys/BIjLxv56rZoZ1bFGumTco4UCJk59IZEI99rI1mEx/D5uBEJstT9AWARtLZ4/EatZfn73jK0FrdteU8HuvVu473zGFsxxM2SDpCtK+MP85m42Sjtzu3epOD5ShDlyOKfzHJJPX6bokCv/aEMda6pqtBqsT7SKvj+aeZW+YRenGghdNKGdfLbO2wQtaKvtF0mAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB7876
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D09.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	f5f2f427-a65d-4b07-efeb-08df3a63c2b2
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700016|14060799003|23010399003|1800799024|35042699022|6133799003|10067099003|22082099003|18002099003|13003099007|56012099006|11063799006|261022105027099003|261022075727099003|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261021121427099003|261009223027099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	bsoWY4F3Zhc3vuQjiUth2pH6Lp1cc6lRWJ9E55MBgXr2gOAU9c6Vt9h96jToe26ACFevWuCXdRFDGJ8bdyivHy7gdvxCOalSAiAq4BXXzHlkvXO7H9IS1PAMZoBYfvFGtibwum0hFKMdfvfXURaCerIWgdflgAwcf0ZRTbkBINhZTTy9H4/kfxPW714uRnCjM7Wx36cqxzDgtbfCXPXI1+AScKmna23LB4bhxif/T/gd/J6vsKvk/R9NNOuUimRUo0afJ18zkATcsV8P2h5LOVTm2bqZeJSFcsJmt5+/y+STm7ziij8f8H8Wc8jmGzYGWeR+Mt4P3Q6lZxL3j+4brFU1LzOfRyJCJQsG82NzZo9zE57ZnBK1x/QnkKKBGCCcbc/A61+djfk+7GS2MMu9Lr22yeN04c5d7N7lUgZ7m73le+JpIj5HvDoiNBjFxYTc0OFPiWm6neh31KaJOwxYg9ceywp12kaqpOynqb+2QVphepZ8q6mEJVhJyZQ3TNYHOcRqUFIz8iJtnNIgszcwqrj8Q0cuLV3kQbCJK+iSwD3BpShUbO1hxW74Z2xsTGChlZunVCd2V1yO41hnvIFfINDQ+YW5uXbH5W0L3gwb1LwBPXpBBIvLm/gHl5wxUGOUL+eakC3v9uN9p6ll5/QJgOcNyuaYJFscwWwWQnhjCNc=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700016)(14060799003)(23010399003)(1800799024)(35042699022)(6133799003)(10067099003)(22082099003)(18002099003)(13003099007)(56012099006)(11063799006)(261022105027099003)(261022075727099003)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261009223027099003)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	yadTC1ae6I+QSc1CjcmVOgbX275G0ubJb2M0cig6CyUDvpuw+c1gVphh2PeZ32HhbZrV0V87KUsipVWUBkGVglCJkzpk7ErfhqW1VkyVtibF4aKzjDprjw+bwR3pzgXIuLp/5ROxgS48a5+m59+L7rggIgx9xla5RFMPtJw2XyWXUEMe6tzLpOflnlpa/ml4kanHN6Mlek0QAtiSflySDl3FEMT74NEMm9AQxtLkzlyeRL5W1OjUiD1RINO4E3nxh0oSo+DJFmHVsxQWsPbmSnN3sw9E5SFm8KE6b3vc7iZ5UMxfFXZm2yyKzGQa1njWzdW7IvwqPBF5xz4Ss22dOMod9ZBhFZMT/D/ZmXzNWX6KzFa9tCHQvsGyBIUvKxp7bybXCsrIQitcl5f6FY3csBgWjl1YzKdxG5MvcXejRZkRatX9JiVWUjJVh1tIzmqE
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 11:07:44.4324
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 177a5c41-34af-43c2-b7f2-08df3a63da1b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D09.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6068

+ Ashok

On 11/4/26 12:03, Pierre Gondois wrote:
> The support is mostly duplicated from Memory Error Section handling.
> Other than differences coming from the content of  Memory Error
> Section 1 and 2, differences in the support are:
>
> - v2 do not rely on a compact "struct cper_mem_err_compact" struct.
> This structure was used to support older versions of the Memory
> Error Section (1). This is not needed for the new structure.
>
> - The compact version is also used by the tracing framework.
> To avoid relying and propagating a non-standard record format,
> through trace event (cf. extlog_mem event) the new trace event
> prints each field individually.
>
> The last patch of the serie was only build-tested due to the
> absence of relevant hardware. apei_mce_report_mem_error() and
> arch_apei_report_mem_error() implementations were also removed since
> last version.
>
> It will also require a proper handling from the rasdaemon. Applying
> this last patch without rasdaemon support will silent the reports of
> Memory Error Section 2 error, cf. ras_userspace_consumers() check.
>
> Future:
> - _OSC support
> - Addition of arm64 tracepoints
> https://lore.kernel.org/lkml/20261023170405.000060b8@oss.qualcomm.com/
> - Emission of lossy CPER Mem error v1 tracepoints for legacy userspace
>    tools
> https://lore.kernel.org/lkml/at0rs4parlHFGI7k@hu-ashoraj-lv.qualcomm.com/
>
>
> RFC: https://lore.kernel.org/all/20260929074659.2587216-1-pierre.gondois@arm.com/#t
> V1:  https://lore.kernel.org/all/20261019145643.1877246-1-pierre.gondois@arm.com/
> - Corrections from Jonathan's review
> - New patch:
>      [PATCH v2 4/6] EDAC/ghes: Extract error report initialization
> - Last patch not in RFC as it has been reviewed by Jonathan@
>      [PATCH v2 6/6] ACPI: extlog: add Memory Error Section 2 trace event
> V2:
> - Updated ghes_edac_init_error() to ghes_edac_init_error_desc(),
>    which now only acts on the input "struct edac_raw_error_desc"
>    + added lockdep_assert_held() to ghes_edac_init_error_desc()
> - Accumulate failures with "queued |=" in ghes_do_proc()
> - New PATCH:
>    [PATCH v3 5/7] ACPI: APEI: Extract common memory failure handling
>
> Pierre Gondois (7):
>    cper: use BIT_ULL() for processor and memory validation bits
>    cper: add Memory Error Section 2 structures
>    cper: add helpers to handle Memory Error Section 2
>    EDAC/ghes: Extract error report initialization
>    ACPI: APEI: Extract common memory failure handling
>    ACPI: APEI: add separate Memory Error Section 2 handlers
>    ACPI: extlog: add Memory Error Section 2 trace event
>
>   drivers/acpi/acpi_extlog.c  |   6 ++
>   drivers/acpi/apei/ghes.c    |  58 +++++++++--
>   drivers/edac/ghes_edac.c    | 189 +++++++++++++++++++++++++++++-------
>   drivers/firmware/efi/cper.c | 109 +++++++++++++++++++++
>   drivers/ras/ras.c           |   1 +
>   include/acpi/ghes.h         |   2 +
>   include/linux/cper.h        | 129 +++++++++++++++++-------
>   include/ras/ras_event.h     | 102 +++++++++++++++++++
>   8 files changed, 518 insertions(+), 78 deletions(-)
>
> --
> 2.43.0
