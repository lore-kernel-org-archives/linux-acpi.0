Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793806719;
	b=l6qWzHFredu047PVVnfPwO73UzXFBwE3yBgNLGwrWgwNsLUeQi8m6dLVgw/qtEXlZid+
	 WJYXbibczCTSWukVM+d41CpN6kRIldo9RXLUHLicEaDKkGavQi6bbnagWu/eyS+lUSAyj
	 sugJkdgM0vgPICL9NNu7jcFoPxVAVEBPzZY8+S7ViLO6C7tK3vFmIdBDoQHJjMprEIvU6
	 axteb01RU6A3GhUCIU/1lBKx9uxwPoFqVmSXfN3eqWo31t+wg8C1pfzMYll4m6If8IYaI
	 P7vniy+R0SCp8AqGAp+jRJu+InTlgo5ZsuD8y5neagDnPh76rDeRjTocY36Y86xD6FA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793806719;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-ClientProxiedBy:MIME-Version:
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
	bh=msWRcv5G06x++MqOpdMJZ0t7pRDPxhyoWA9jdK9x2ts=;
	b=Ciaaer9HVWkx7tLx0la4llp/8aZm8G6fckBjYantdxS3fYC7yAvj1aQ9i5EkWyyjPJgq
	 TTXBUWSvEr1dSDTGHl1nnq9KUMPCW3Aequ3kLPqrWc1gQsKeAclTA9DVHr0q/ZH/i2qvJ
	 D4gZjEmGlXKFBJFd4jUTGUc4HLsQU+sDgfxmApug/mJVq+3jQx8Pn5XAttIET9DUKglna
	 /7yPeaqe29vftKd539Swip3zSA8f0DHvVI8bhRPpke3ciSInX3N2nFU3JlfmgxSrY2zW3
	 kh2LmgNq53B3jrsEOkZCCE9ygcxIy8wFAaRrma/nu4EjC8nzizYh0Q40/lOLKjZwkFQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=KY12VrSL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.14
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011014.outbound.protection.outlook.com [52.101.70.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D976C6083609;
	Wed,  4 Nov 2026 15:38:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D976C6083609
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=KY12VrSL
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L/EcHcKej+P/nZtbcjoLgElaM6d8neFlfILhuLgm7JA3fT/WkZ15FlWj+qXHx1p03tk2OFwLRuG1+CR7MwcKSPzBC8JiteHR14CZHKewKD6RIYDMQkRzghjjTZoCh13dKgo/5iUa+ujZyMeRwBSzTOrX5oWhv51lQePF4NgsVxiPyM6fxh9NuWOkHVTmBTKqi+s1P1p2H5+7UUHAyYTWlDJxcxpyagxs7eXhJbK44u2wfhe1Fa6+Nhg9oHHsqisETwGBSPfEvDFeHoZi1U57NYhFMsOLg8VQIQbbpHxUCyObm84Q0oHAzUMLLNKOtNBOgqJ6N2+U6sRRuP7hiwMSgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=msWRcv5G06x++MqOpdMJZ0t7pRDPxhyoWA9jdK9x2ts=;
 b=Xzv69TtKpvIrdonqySUcwFyyVAbzazdKwCt1E/4trrLWganYb2TaBd9Z3Q3hd5H4xEHbnwI1YrETeJh8ptSh3AYKocy6xDu/umyosBO3Txd4Efwf951e4hrjMwLK3W0jrIiw22B9uwsAsAZPTlHxW/q36sVpm9BkgD5JP+XZSRr/Dd7DYFbYmBSqxVTWT4A6/3WOA1pl/WKM0tl8ZbyIlbWl7OtPaf9ppE7BcbzhMDGbvHi3/RyktCGYn0NA14M/pXljJg0pbSXlvUjufReUhHf8lVPQK61LSkZTsjKUXdXE/fRfHCw1IhCzqszoU1a5fRd4tne7WDJFMaryGArOSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=msWRcv5G06x++MqOpdMJZ0t7pRDPxhyoWA9jdK9x2ts=;
 b=KY12VrSLFhf1B+gQIANp2Ru/jiBc2hJ+4B2NmDEqKw/9D6tQpL9c0lpsHxB32IoWjBuUBrCKQ5AyeVuVKOjqVgZ1HC2sMEG3IMO2fHTBwNoKCkJcRsszHqjawaU3eIfkJEsUfN1FHQr0YP3s69cbe9+p35NUl1LzN42IlFM0QjKdr6321UFYNKqkQgHRojP+MmAjsil6w/3fH3/sDHK800pmL0sUIXvNAg0wPrkrchfqGcJMb+4NX0lWzmnRou/6A/euOdhZ2ryYyEE+gJHDbE5UpHQmkHGDxJ1kWaAxz3FVNYk+w3Hx/+AiAsMj/Fgy+1amzp564479f4pMqPieXQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by DBBPR04MB7564.eurprd04.prod.outlook.com (2603:10a6:10:1f7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 15:38:35 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 15:38:35 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 04 Nov 2026 23:43:13 +0800
Subject: [PATCH 1/4] software node: do not resurrect swnode being released
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-swnode-race-v1-v1-1-9406a67e25be@nxp.com>
References: <20261104-swnode-race-v1-v1-0-9406a67e25be@nxp.com>
In-Reply-To: <20261104-swnode-race-v1-v1-0-9406a67e25be@nxp.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Bartosz Golaszewski <brgl@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Johan Hovold <johan@kernel.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
 linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.16-dev-7bc12
X-ClientProxiedBy: SI2PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:195::8) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
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
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|DBBPR04MB7564:EE_
X-MS-Office365-Filtering-Correlation-Id: 00e786c3-67d8-4c2e-c6ab-08df3a89b051
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|7416014|376014|23010399003|1800799024|6133799003|10067099003|18002099003|22082099003|56012099006|11063799006|261102130727099003|261022105027099003|261026121527099003|261102123227099003|261028144727099003|261026140227099003|261021123027099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	ySLIeXZxPgkrhqpcNCHlbqauD7ZAkD6CaccGzimAB5oUA5mMgq93z+hIUp30sgaGpp8nS9V4JtCvdj+6VB41ysKSVQdKyFRnuX4XO4aHEczJ1BvqSLqIUxP0h5d7hhxyghUMrEUX16Cj6/pfGzNbx5deOdiPzStA2AqX6ajDXTZpHHcJnT+ruRZh5LsHi/1ISiO3Xrgiik9sNU1JNIYJclRtBOrEItRoaBKKhvUJv8fk0G7gXUv5TsG733WLMlZ6EmtFQVxZ75AFatuaf2QAB2Ogaq+SQZcbtAJZdQ5Q4BbcGzEWdmKWCLaumpJBN6JTjzOxsp4zChKIZNYY/5zIj9cZtb9sz+bjBoQS/tp2dg8VLcww0MRr47LrBo7eI5blV0cPejZb3GOib6j5A5uFsEGXaiCdgjAUGfPSpPiEC5cI/OgAIVAbw4LHQHApceosc12yBnag77GUYgn2+EwTMW0Jnu8TtgFHeO+4l34tNcyYTqqlmvsV0c7lb40v6w9kPtxozr3wTFcu6skCh2vHv7M72r00gr4GxsJI+jLnmwKxrCxzolJuh3i6Wc5vxwwudCrdyfnz/4UFKLRPxN9yuFeWWhTBOov8nVBWLmVSTYBaG+UE0102tLg1DDP1yp/EizyyYTsOQ3NFeVQdhrF5uyNb5BDV87bCIgXEfXLtfuA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(376014)(23010399003)(1800799024)(6133799003)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006)(261102130727099003)(261022105027099003)(261026121527099003)(261102123227099003)(261028144727099003)(261026140227099003)(261021123027099003)(261021121427099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WHNpMnQrK0FsOHVydVZYUG10S1lpSSt2K2tOOUpwbFVXZG9lSVZZTlFBZEFq?=
 =?utf-8?B?NVBDVWRPMHVtUXN0UTZRbktkL3pHcmhJQmJ5SzFEVXBrRWNtUFZ5SjBmSWg4?=
 =?utf-8?B?Q3pXZXNBUDdqcVhQT2lxZWdkd2FDTEovaTduWnNRZ1diSnd4bEk4b2lndVAr?=
 =?utf-8?B?VmN2bzNBODArbDFKbkFEbVZobzJiTjNjQkFUVmNoMkUwWlZqNmRpblpNdjdm?=
 =?utf-8?B?bkR3bUY0SzcrNW1SaVNCVWg3T1Vmekp3cGpuWmpFRmhyeFk1UXRXb3hsMm8y?=
 =?utf-8?B?Z1AxU0JLSm5uVEs2M0R2dXZpL1FGckZEelA5UHdSa1NKRFl5c0MvcGJQMDZ1?=
 =?utf-8?B?b0cwK2JuejRUeWwwd1RVQllkTWx6NUtaNUw0Q0taWkwwU0xHOGE1d3lKZGcr?=
 =?utf-8?B?cXZOZ2JDOW9sWGNQTDZvYkpBVjFWOUlMNWN5VktXWXlyYm5NWXdpWFl4WnhD?=
 =?utf-8?B?akVFYWd3R2tsSVR3clJBc3B1OFJwUXUwYkE0M2NIL3FOYk9PWWx3QnRoUHkv?=
 =?utf-8?B?RTB4RXh6OXpTYmtaVUE4U25ZOWo2OXJuUVRuOFJaeDFFdHIwdjdpUDNXYWd6?=
 =?utf-8?B?SVlTZGVCd1BOVlNvdy9DMjg3SHZsbzBOYzFib1ozUlFHNUxWM21Xa2Z2WWo4?=
 =?utf-8?B?TG5mdVFUWWJjT1VxZEpPUm5yYjVqbE1VOSsxbzFhZ3ZRMm11L2tvSGN5TXJ4?=
 =?utf-8?B?S3d6cTlUUER1eUtPcDRiV3ZCd1ZEbDRFdVFFUjZ0TVlab1JtblJKSzRMSXpo?=
 =?utf-8?B?M2psc2IrOUNEWndNZnBOZHNTc3NlLzlEaTVvenRqcTVPcEtMM0g2Rk5teEFl?=
 =?utf-8?B?ZkV2K1ZnUGlCTzhuSmNIcTdab1BPNjFlNXRobGtXTVd2dXhjcm5Bb0dqTEJh?=
 =?utf-8?B?TU12ZS9hRjVBbGNHUkNMOGxQeEZFZ2ZzOUJYTHc1cWJzb2NXazdLQS9rWGtv?=
 =?utf-8?B?OFZNdFBZeXZJRkRCRWc5YXRDc3cwTFBWQ3VLU2hGRnd5S0h2UWZoaWR0dzdu?=
 =?utf-8?B?NWowSlVRcXh0dDdISVQ4UUtna1ZKcG1SN1pJVWYzVGxEamRTYlgvT2pIMm10?=
 =?utf-8?B?TTYwTWgzZTZ0ejQ3TkhRNTJCRWJYVS85YmFldUV0WkcyWExHMnloaDFRWks4?=
 =?utf-8?B?YytKelJwR05wbGNNclZEUCtkaE5DdmxIY1FETEpGSUpDaDVMTFJPOFFOSit0?=
 =?utf-8?B?WDV6SktPMU9wT1l4WURoTmlvb1dSWWpWM3hZenpnQlpySGhWUGt4cEdmWlNC?=
 =?utf-8?B?a0F3cEhzTWVTbENycE9sMVh1a1c5WlRpUXVKUW16NkpxY1pLUlVzam9Cb3N5?=
 =?utf-8?B?b1BRQWRWaFkxYWZzdlpyVDY2YkJGRkpua1lhSEVuOW9BK1FPdFZqYVppZDV0?=
 =?utf-8?B?dEJ3bDhHTmgxLy9nZGxNSGxvSG5YbC9pSEk5ZmVKc0svaVNMZXRpN3FJRmtQ?=
 =?utf-8?B?bGh4aFYycUp3L3VJSU9BbURwekNBTkpsUzZ5SzduWjFFOUQzcFlNMWw3QTN6?=
 =?utf-8?B?RjBjQVUxQ3FlL0Y1djI3OWdZTm9yY2lnMTYyWGdQYkVpL2lZMG9PN1RCVnhP?=
 =?utf-8?B?REF2cERhZFpocDZSYkM4L0FxWWFNb2UxSzVMR250UGNUZE90Y3FyZmR4OUhk?=
 =?utf-8?B?ZU5xNklHNmp4QzllOUprMWpidSt4N0xZbG9mbUVpWG92dFJnb0ZXUnI5UGVS?=
 =?utf-8?B?KzluR3dGUDJyckNNUXpGRzFvRE5Zb05RbjB2bTRscG9PSG02UHhOd0t4WTVu?=
 =?utf-8?B?UFNSS2Nza2syWWE1ZWk4V1YvdkdZbmlIQzBoaWdvSEFsNE42M29ub0JuYWZO?=
 =?utf-8?B?MmxiYm5acUI5dzExRjdKaE83OFFIbXNwVmhhOUNWNVJ4SHFMaG93ZlhxdnJv?=
 =?utf-8?B?c2VOcVViRXIwVEZWTVRzN29RY3FpV0ZTMzVSRkJVd1Npc0NBRmZsbVBXM0xn?=
 =?utf-8?B?dkpMa2c5c2NBVWtqOW5wV1owcVU5RnVrVVFSaGMzeGZlYmZHdENtKzFoOFMy?=
 =?utf-8?B?dEdRb2FONHBDcW42clluUmJETXNpdmJlK2cvcXI5b2ZxWkFWajFodWJmREVq?=
 =?utf-8?B?QU1OU1Jqa0tJOTZlUTQrVkRFVHZSajVEVkovVytvRU1UdVkzUjd2M1RYSzIz?=
 =?utf-8?B?Y1N2eS91YUZzRDhucHBUcmJ6Njd5SXN2cEpXWExwU3BlY2I0Q2FSTzN5V3lB?=
 =?utf-8?B?MkVTbWJJdjlCbW1pa3JVSkp3R0M0MUlzNmpYU0g5c3MyMitZSGp4VWkxMWdW?=
 =?utf-8?B?aUhSdk1ESWsvS3NpRGl3MWlSY0o0Nkc4cmRnM2lSVXo0V1FNQlhldkp3V3Zz?=
 =?utf-8?B?cTR2azJuYkJXZWRObUUrZUI2NDdnTHNkeGNtTE5sUGJTWGpWNUxKUGVKblRN?=
 =?utf-8?Q?+NfHUDAnPPNQelonO/Wov7vOyIH3hcPtmJW27?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00e786c3-67d8-4c2e-c6ab-08df3a89b051
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 15:38:35.6091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kczaj9dBbrSbThpNPpqsklHOHQ081sOR2/aI0jZK1qzzZI/GUS1cJ64Yz0aUTLCUbfzSKFaOxWj0OKbdwRy8AccrlnF7XhFuhVxyGZFh+9NRiF8ZzyWKyryff944VPGP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7564

From: Peng Fan <peng.fan@nxp.com>

software_node_to_swnode() walks the kset list under list_lock, but the
last kobject_put() drops the reference count to zero before
kobject_cleanup() removes the object from the list. A lookup can
therefore find a zero-ref swnode and call kobject_get() on it, which
triggers refcount warnings and a use-after-free.

One way to hit this is the dwc3-imx driver on i.MX95: when
dwc3_core_probe() returns -EPROBE_DEFER, dwc3_imx_probe() removes the
static software node from the device, and the deferred probe retry
immediately adds the same node again. The previous swnode is still
waiting for its release callback, and CONFIG_DEBUG_KOBJECT_RELEASE makes
the window large and deterministic.

Fix the lookup by acquiring references with kobject_get_unless_zero()
and skipping objects that are already in their release path. Use a
reference-returning variant for callers that keep the node (register,
unregister and device_add_software_node()) and keep a borrowed-pointer
variant for software_node_fwnode().

To avoid looking the node up again after registration,
software_node_register() now uses an internal helper that returns the
newly created swnode reference, and device_add_software_node() consumes
that reference directly.

Fixes: 80488a6b1d3c ("software node: Add support for static node descriptors")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/base/swnode.c | 114 ++++++++++++++++++++++++++++++++++----------------
 1 file changed, 78 insertions(+), 36 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 84a77ffa3dc4b..19a4153f3fac1 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -75,8 +75,28 @@ static inline struct swnode *dev_to_swnode(struct device *dev)
 	return to_swnode(fwnode);
 }
 
+static struct swnode *swnode_get(struct swnode *swnode)
+{
+	kobject_get(&swnode->kobj);
+
+	return swnode;
+}
+
+static void swnode_put(struct swnode *swnode)
+{
+	kobject_put(&swnode->kobj);
+}
+
+/*
+ * Find the swnode registered for @node and return it with a new reference.
+ *
+ * A kobject remains on the kset list until its release callback runs, so an
+ * entry whose last reference has already been dropped can still be found
+ * here.  Use kobject_get_unless_zero() to skip such objects instead of
+ * resurrecting them.
+ */
 static struct swnode *
-software_node_to_swnode(const struct software_node *node)
+software_node_to_swnode_get(const struct software_node *node)
 {
 	struct swnode *swnode = NULL;
 	struct kobject *k;
@@ -87,10 +107,16 @@ software_node_to_swnode(const struct software_node *node)
 	spin_lock(&swnode_kset->list_lock);
 
 	list_for_each_entry(k, &swnode_kset->list, entry) {
-		swnode = kobj_to_swnode(k);
-		if (swnode->node == node)
-			break;
-		swnode = NULL;
+		struct swnode *candidate = kobj_to_swnode(k);
+
+		if (candidate->node != node)
+			continue;
+
+		if (!kobject_get_unless_zero(k))
+			continue;
+
+		swnode = candidate;
+		break;
 	}
 
 	spin_unlock(&swnode_kset->list_lock);
@@ -98,6 +124,21 @@ software_node_to_swnode(const struct software_node *node)
 	return swnode;
 }
 
+/*
+ * Borrowed-pointer variant of software_node_to_swnode_get().  The caller must
+ * guarantee the lifetime of @node by other means.
+ */
+static struct swnode *
+software_node_to_swnode(const struct software_node *node)
+{
+	struct swnode *swnode = software_node_to_swnode_get(node);
+
+	if (swnode)
+		swnode_put(swnode);
+
+	return swnode;
+}
+
 const struct software_node *to_software_node(const struct fwnode_handle *fwnode)
 {
 	const struct swnode *swnode = to_swnode(fwnode);
@@ -374,18 +415,6 @@ EXPORT_SYMBOL_GPL(property_entries_free);
 /* -------------------------------------------------------------------------- */
 /* fwnode operations */
 
-static struct swnode *swnode_get(struct swnode *swnode)
-{
-	kobject_get(&swnode->kobj);
-
-	return swnode;
-}
-
-static void swnode_put(struct swnode *swnode)
-{
-	kobject_put(&swnode->kobj);
-}
-
 static struct fwnode_handle *software_node_get(struct fwnode_handle *fwnode)
 {
 	struct swnode *swnode = swnode_get(to_swnode(fwnode));
@@ -977,21 +1006,39 @@ void software_node_unregister_node_group(const struct software_node * const *nod
 }
 EXPORT_SYMBOL_GPL(software_node_unregister_node_group);
 
+static struct swnode *
+software_node_register_node(const struct software_node *node)
+{
+	struct swnode *parent, *swnode;
+	struct fwnode_handle *fwnode;
+
+	swnode = software_node_to_swnode_get(node);
+	if (swnode) {
+		swnode_put(swnode);
+		return ERR_PTR(-EEXIST);
+	}
+
+	parent = software_node_to_swnode_get(node->parent);
+	if (node->parent && !parent)
+		return ERR_PTR(-EINVAL);
+
+	fwnode = swnode_register(node, parent, 0);
+	if (parent)
+		swnode_put(parent);
+
+	if (IS_ERR(fwnode))
+		return ERR_CAST(fwnode);
+
+	return to_swnode(fwnode);
+}
+
 /**
  * software_node_register - Register static software node
  * @node: The software node to be registered
  */
 int software_node_register(const struct software_node *node)
 {
-	struct swnode *parent = software_node_to_swnode(node->parent);
-
-	if (software_node_to_swnode(node))
-		return -EEXIST;
-
-	if (node->parent && !parent)
-		return -EINVAL;
-
-	return PTR_ERR_OR_ZERO(swnode_register(node, parent, 0));
+	return PTR_ERR_OR_ZERO(software_node_register_node(node));
 }
 EXPORT_SYMBOL_GPL(software_node_register);
 
@@ -1061,21 +1108,16 @@ EXPORT_SYMBOL_GPL(fwnode_remove_software_node);
 int device_add_software_node(struct device *dev, const struct software_node *node)
 {
 	struct swnode *swnode;
-	int ret;
 
 	/* Only one software node per device. */
 	if (dev_to_swnode(dev))
 		return -EBUSY;
 
-	swnode = software_node_to_swnode(node);
-	if (swnode) {
-		swnode_get(swnode);
-	} else {
-		ret = software_node_register(node);
-		if (ret)
-			return ret;
-
-		swnode = software_node_to_swnode(node);
+	swnode = software_node_to_swnode_get(node);
+	if (!swnode) {
+		swnode = software_node_register_node(node);
+		if (IS_ERR(swnode))
+			return PTR_ERR(swnode);
 	}
 
 	set_secondary_fwnode(dev, &swnode->fwnode);

-- 
2.34.1

