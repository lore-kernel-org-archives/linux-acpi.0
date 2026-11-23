Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.34
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795451557;
	b=iwNp07hyum8ET2QvoOc78Nl99Xtl85SxQpEYCg3Y3pdM1/uPnqROISvmNODIb/EZVzRQ
	 bsEbIKx/ybUPCJ74u2wOZ9ZIfNyGHPZDKdcXsYAzH1M5E6087j+TMOxhXqXrLs3bTlYto
	 2J6bYMfRuUIdGrRB4AOe2RAb7mxXWJNZhr5zLKY6n8/GtyuAGvo3H3tW7PG0t48WlKbu/
	 WbIIDNhCEUnF3Lu6zASuyu99JiFgbeVCf0ZgFTGRKC7dIfqx42jAh9hnK2Go+6fBNtdpc
	 ZC+o8uHC4vmnUPT6i4aLvgHNQSx7QUDnCIqRKbvWNv7kXdEvDXMHSeqWjIoifi/MjYg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795451557;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=H2xHejBippHR8dvsk9ry1XyysyTA/2NLrSBjVWam3J4=;
	b=C9KGbhbypoQCClYAJdcVUCeTQiFVfIUXBez3AbhafSa4bbhNZWr6HISc1dpAXbnanU6k
	 ada4NSrWwTSd2grYXdHoJecePj6EHmy87DUX43SuH8GOhDpzyhuVkzBnUF7Y1e/20zJRo
	 l1b0NbxuCHf4zoz5la41lMUVrG7rXYZ8yYRjiX1PzLmqueshHeamB9X+ibAgLJkpbadzq
	 7K9QOv9JIQvclk61l5Gb0WkxXIBDB3/yeCzIuDKa4rL2ZrJ3jVCm3BcVbRT6TfRvejYlV
	 hrWExvQSBbpzXrlZCbU9C9XgzevpM+e/HuVtGZuGYjbifZ8nbg9rNH3ay1TqlbqDrUA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=rClbh3Y9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.34
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010034.outbound.protection.outlook.com [52.101.69.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99987606A330;
	Mon, 23 Nov 2026 16:32:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99987606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=rClbh3Y9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nBLDSZzCnX81NnnaoVsFhH3FoZ9zNtcqxwhXifSj3Gl/N2jO8HKT5Ez7dY34co2gac5WSqcf3S9FUZ5Jy33Ds+wH3UUA6zUaA6lbRNNxbGvo5u1SxrYbbKrVp7qCCqEHi84aeboj8EKePNyKESepk8EVpgm0VvxegOcp82Yic/WCS9oeEzLWFS5N7gGUotREpki0CgMTCXIIst4AgkwcClr/xVNoNw1O+7MJRV3ZcCWS1Fu3KoRpUQT0kf852XgRwBDrJnoLFbkSpoFTIYKhznvPfPIp2I6A8K1ozEeh41RPRkzsMgdXOr3adIuT2GCYswl31K+4w2kPgvo+1mEyxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H2xHejBippHR8dvsk9ry1XyysyTA/2NLrSBjVWam3J4=;
 b=ZJMBsYFqXmrds7YSVaOCCcDomluV/gyXAv14AKvAjVOO27Dj6ns8K8kkHOIV/14szfCmgYTP8yCJsQXjTQhkpiOFusm7T7GzQO4sAy17TkE3hNZTemJoMCW2MVNFxm2NLLL1zj8Sos0iWSiKuiuyUwpu3DMcPuoUWR+xx48KO91CjWamrTLGVdYeq9WJNycmGfSHzva2LxKatrsFUVTpjYb0JAQehjNdC4u2zGGhmM/7r+BDAt2Z6zQKsJ6z2sKH4WXT8WjFdILAXqN1iZeZN25W9SDZbL9g4H2f5hiprtF8riqn4TlLi6XcKBVJk8BSCDQ2n5gDUTuRqtUGN7YGKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H2xHejBippHR8dvsk9ry1XyysyTA/2NLrSBjVWam3J4=;
 b=rClbh3Y9rQnmhNeNjHVXMsaLV8w5ogLHfMzVAKMVLPpjGlRWy4r0C3R0FujRZK+tShGeOwGgaKhdE3C+WLwM/VzAYR65Yb2HzDXM0FNF+9abv+lB/95s+411IEaZEig3rkljlZRCU0qH40+hfb+bNyQcI28OVogqHt4ynWlQ7CPneT4JyYA0vfhU8z5r+ZmNVhnvSrjR61JExHlfCruJsGBC2tuVFMaY1VXn7RBiIp1Hs+ZQoDGyHO38x7Cnc/KVbj1LUbn33xj0soefhCqp4OyQOQB8ebL4ybp7wUNxO47BRbOqzS3XcELYoC3tGpS8PC2ALJ6jNQ4xs6aKg9T3QQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by AMBPR04MB12288.eurprd04.prod.outlook.com (2603:10a6:20b:730::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 16:32:33 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 16:32:33 +0000
From: Frank.Li@oss.nxp.com
To: linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Marc Zyngier <maz@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Ge Gordon <gordon.ge@bst.ai>,
	BST Linux Kernel Upstream Group <bst-upstream@bstai.top>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Lars Persson <lars.persson@axis.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	=?UTF-8?q?Yu-Chun=20Lin=20=5B=E6=9E=97=E7=A5=90=E5=90=9B=5D?= <eleanor.lin@realtek.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Michal Simek <michal.simek@amd.com>
Subject: Re: (subset) [PATCH v3 00/17] arm64: Use EL2 virtual timer when running VHE
Date: Mon, 23 Nov 2026 11:32:25 -0500
Message-ID: <179545153817.2472106.1922836629751112370.b4-ty@b4>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260523140242.586031-1-maz@kernel.org>
References: <20260523140242.586031-1-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH1PEPF00013307.namprd07.prod.outlook.com
 (2603:10b6:518:1::14) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|AMBPR04MB12288:EE_
X-MS-Office365-Filtering-Correlation-Id: e77b5baa-c896-4857-f912-08df497f603a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|19092799006|10067099003|261009223027099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	PEXcfTQberP5tvqt6R/wZJzVGc5zH1py08giVs5IcS7pjENZ2wRbFlcQhO7kXgVl6zcyC5D0w2kRiqHJcbbw2RzPT2886ZsArixqD8PmDT4NyY0Rc8ssI+5xOR5FkxUgEHg0pG1T9RLwuqHGUDcD7TjqwK+Ny81dP/jGCTna1m1r635TSow8+s0fi7Bzr6C9hMNsQRe86SFlqHT9S0r3Nsix3fRnAJVXMANUVj8LPHbUQUqR/zGs7y2wOGUE5h9w76qej3nD05ZkgFnPdox2NgfsOriK8Xx/BbHiRFXx0Zmc038XKQJwQv0e6yOhjoQALLnOmqNOFkY8d0NnvDkGQliO2qL+6RDh8zdXOoysgSUIVNh2UJlkU5IOLHX7JuJuq9DZ/hynD4K60ZbE73VywT/t/54HIM2JmHWM+qkPEwuVLVEPYSBe7OqQjfUCECIIHyPTOuMD9FXsyfrdquy/pI77YrG/tDcfP/Ql7AaJe9FMvpSGn/2VsEkQJqg96EblS29DQ0mjyU4Vdodjhi82HSCAuSH413D94sRSnLS7STZEcBTAs01qdEuyWBDibkPB56VHlbBUFtruxs4wj5RjytDBuLE6VztKGH21dikHS0oZ2FcF8iH1VxOGdNwPUgztCr32s2zd70vPOUpFkhK3pTRnrJJvwxkagf+8MdjXpaU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(19092799006)(10067099003)(261009223027099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vm4zQmVPYlhJc3JqVndVQmYxMGlxV21PclpQaXRCNFFPbmpXSm5kVkZmS3No?=
 =?utf-8?B?MzNIWGZOWHIvQkN1U3U1aUNiODJvR3hhVTVURDM5SFhlVUJrVDEvZUlrTTNm?=
 =?utf-8?B?MmdGUkxBR3N4a1M5OVYwTUxYR21yQjRtektsNkRScEJGK3B5VnMwRWdNNGdB?=
 =?utf-8?B?akMxdHRZSmpKSkJLYTNIWTZHNllZTCtuRUdFNHMySTJRTmVURDJEbjQzTU81?=
 =?utf-8?B?bi9kU3BHUnlrL25tYVNJdjVVR0x3d0hBTDBqMnBmMEZxOG11T0ErRkIzaHM4?=
 =?utf-8?B?U0plaUI0UHN0Zi9waXQ5TjdHSEFiTFFyMjZwTzk2SnoyQTBFak5Mb0lRYTdX?=
 =?utf-8?B?OWNNME9XZFp4aFdnNTdqeU1BV1RkVUtVV216em9STEJIYkJuRFBpRUtuWnNh?=
 =?utf-8?B?bGpmS1NrVS9sOEhoRlZQTGd6WXN6d1EwWEVzeW5YeVNveGRtUUFqNDBwd2xw?=
 =?utf-8?B?SmhtVlExTENJMUYyYlY0QVlyR1ZlQ0JNVzhuLzlrS1Z6ZFRvUzBZSy9nOXZh?=
 =?utf-8?B?aENGN1M0OHlENGt6UkpkeThiUHNneVd6VFY2L29VcUx0cXI4VThueEI1MzJQ?=
 =?utf-8?B?SUdLUFg5M0ZheTJpR2RjcVFiaVFQVTRhaEJMUDJUSTVCSkdNb2tiYXh1MXJv?=
 =?utf-8?B?ZEVmNWNIZEl0YUo1QTNnQkZTNGVQQkhYY2xIdDhpbUpBRmg2b3R1dm1wMTRi?=
 =?utf-8?B?QkVyWTNXTHBoemtoZzlCLzN5NE1nbUlxNklNYTB5aTl3TEQ5VzliWS9SUEgx?=
 =?utf-8?B?QlRwUGVUSU1Fbk5vVHJmdS9MVHQxenF5SjV3SEtzaC9FdXZFME1wR1B2ZjBh?=
 =?utf-8?B?YmhWSTIvZENSeklmSGlrT2ZQcDVQMU9EYldXZTExRHdDdjRua3Rwb0RBemMr?=
 =?utf-8?B?TDVBbytQOTd2RnlrV2JrYkFqR21OamhPOUVPVFkvaGNHSE9naG4yMnlONlRU?=
 =?utf-8?B?TWFBTVo1NXlIbFZTQlBodnlITVB5T1UralhIcWZrMVRISGI3cWJVUis0Ty9M?=
 =?utf-8?B?Wkw1Q1ZtdWxZTDBBTHhDMFN4SVVsVCtldTYzR3dlZ3FrN1NpdWFLSHdOeUJp?=
 =?utf-8?B?VG54UngzdEtSc0hiS3BZeVZNaUJWUkVJV1FybFplWFVYT21xbGZKMDVCOTM5?=
 =?utf-8?B?WEpyR3RJTGcwSU8yTjl3YUtid0tGczFpTloyN2hsbE8zVVVJS0JmY2tNN004?=
 =?utf-8?B?aTkxWTZhcDIwVlRrazJGNVpXYkQxY01kM3hUbHppeFNLZkZOKzl4c0NQeWhY?=
 =?utf-8?B?RFNLcUQ0WGNrMmVhMllZR3BwUElHVG5qSE5DSlJKREZ1Z1NXNGI2bCtzNTJx?=
 =?utf-8?B?Y3B4eEVwU0tWRStFQlorRFFGMVRaMEhvZjdxd0FBb0JRYS9yU3dJZWhoTnp1?=
 =?utf-8?B?TktyN2pIUUNyVURmK2RFUEYxM0ZtclNqbW1Ub0Ruc2dVUEdrSUd5Z2R4MVRX?=
 =?utf-8?B?Z1VqcWJZTUtZOCtnZFk3MTdxbnAxR3MrQ2RrQmx4MmFCRXppTGovdVFBZTIr?=
 =?utf-8?B?dHo2M1RZcFlvMHU4S0VRMk1sODJESTdZMGlnN1NvNjJYMHNPdDU4SDM2QzJE?=
 =?utf-8?B?Y2xqak1NaUxaYWVwLzRRN2sxL0QzUGlJVGxKM2JEbjJMWWtlTHhsMTNtMHo0?=
 =?utf-8?B?cDc2bGJnajJLeDlvVlJ1bFM1VDBUNTRCVFIweVZKRStaQU03aDB4UC8xcXFi?=
 =?utf-8?B?NmNwVFlGNk9xREdOMkx1OWpMSmh1Z1ltT0J0UHUyZXdudy9LMmhFWmxWQkN5?=
 =?utf-8?B?ckRxQ0gvU3N5MlVnUFV6bnZBeHErQURuQitxT0xYSnFQc2pRMlgrSW5mT2tw?=
 =?utf-8?B?U0V1V2VOUXFwN0gvcDVia1ptUnJGazVVa2xuWVJCZmtRTHJ0dDloLzZPajR4?=
 =?utf-8?B?NUcxQTZsdFhqRVRBRlRUZmE1dFJ5MGp6MDBPaVdacmFvdC80QXhFaDArOFNu?=
 =?utf-8?B?NjN5NytsdUZ2cDVnbGRubjBGYTYyQzZxMFlrcVNrWk1GWG90UW5qYXNPLytm?=
 =?utf-8?B?a3NJam1zR0lVMHlyaWYvUVpVSk1OSDN2UFJFY0xUTnJQOGNtamY2THdOQmd2?=
 =?utf-8?B?K21mNUwzYWlTcXBUaXZiRndGNGRuSnZLbktKUTFoZk93eXJid3Z0REJ2MThi?=
 =?utf-8?B?MzJkRWk4dE1jL010SHNkTnYzSVd3R0xDNi9DY0tIamJWd0Myck1xR3RjdUVP?=
 =?utf-8?B?YXhBT0ZZTzBGL0s5Zk0vVVlhRGN0QnFIRXFhQ0IyWEZOR1VuOTh4UkVCNjZG?=
 =?utf-8?B?UmY0QWZ0NzBQNEZ6L3hJVTVOUFBkbXMyL09JemlQNStGd2JQK292anFUcmNi?=
 =?utf-8?B?bmFZdGh0b1FFWlErK1BvOTVSSHJqNXY2RmNlcE42ZG5GcGFDaFhCMmhndjhI?=
 =?utf-8?Q?kmlv2RpBF0zgku2M=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e77b5baa-c896-4857-f912-08df497f603a
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 16:32:33.5575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 80WF8l2zbn+geADFlwQ+3KPgC0PFCcgr1GLxiImCh4KOvNTwZpu97yI0PPoHm311G5m0ZvBWqs4NF9ZJPD8gbfQKgXJaI72S0M3r9TuMN4JksZGoN0wvh002xsq55cRk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB12288

From: Frank Li <Frank.Li@nxp.com>


On Sat, 23 May 2026 15:02:25 +0100, Marc Zyngier wrote:
> This is the third version of the series initially posted at [1],
> which
> 
> - updates the ACPI GTDT parsing to deal the v3 layout and the EL2
>   virtual timer,
> - moves the architected timer driver to use it when running VHE,
> - fixes a number of DTs to reflect the reality of the HW.
> 
> [...]

Applied, thanks!

[09/17] arm64: dts: freescale: Add EL2 virtual timer interrupt
        commit: 57ab25412874a93cfabc74175d2791b7cec2656c

Best regards,
-- 
Frank Li <Frank.Li@nxp.com>
