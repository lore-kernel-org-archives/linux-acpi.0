Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793939651;
	b=BKBeFDBmmPPBCdE+7/clCuPPzPhxhQHzlUIJlcC7sD6jgpnY4RoIl7pz4PG5J2AgqxkX
	 tYx/M/Pyo6el9iP6fF35QDb3k2hkxCqqYgQxsNJfWA+9l5xRATykXJwqLKUfB0Lk3jb37
	 QjEYbcudKLB9irXNXbJOj5gLyLORBWbHAwn6aqLCK6F5GAzzCkk4+8RErznTszgAupmgG
	 6HX0juWUVGl1KgH/xoDIzw2Q11VksOrpBbsXsIK8nflRi4IEqhq2Ku6dOeKthodMK132E
	 uJxWcFQeNgVG6jo/H1AvJiqrZIgj3Se6LGpCUSOWJBLYCMcdklHzePu5DyRav0IIQag==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793939651;
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
	bh=JmLeKu7GIq24i16gKKnQOpVP5+9fQMP3BO6YX5Z9BdM=;
	b=yaOlcJTWF6CBh1OHuDd/5SQSLPnR9W0BbPjwUizO79dw68VCAORV9ae9Dv4xoLXgDDFQ
	 nCiWh8Qk3I+Spq0kV3W4cOqi2c1HvLoKqHxNhYpBjvygbtMGXfcYLkkywhR6UYEmA/qTP
	 i7lflhy6WT1gz36vZoWpQPqVHUFF5ZG45Y6+80PK3QZNy4ds27SUyir8Z1RqKjcPVYQS7
	 C3vbJLqSy5Er2auA8x2cxjWTBxUT7z3YcnvVoG55HFU9GG6NOW+15ny4UrsPYZh3FFQXq
	 rjNyvVD279uXathoxP4KlKkcrzT05NhDiyNjdA7jwZ/YGTc2IctNCaCxC45lIKrpsJQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=TqEJz46t;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.16
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011016.outbound.protection.outlook.com [52.101.70.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC33606D81D;
	Fri,  6 Nov 2026 04:34:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDC33606D81D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=TqEJz46t
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GrBbf2CBD92s7jPajDQC9V40FvER7LZ9jG2f/+uScCS6qt37eFUgJ6DRgDdayZTogfK8IXrri42qZhKrpk5S7be6PvjTXREyjkqbG+hlOnqlvjmnljSUCqZVln5OL6lLBKWuDMWXaqtnDWy8noprxeAJ0xMS3YLF0yqVDclcYc79jtuHzs+Ro8+EjggcKShMPHd5JZPf1cc75IyPEDSNyQmMgKZVZA7x4dTTPhxihO3KhnkSusNVUck/w2JaRt5rKjBeEuoAIi0T/KI45tzXuihNZ6mUfrnQIeraCHvlTL784ThLQWSIGRJIunGiyAzPS1+70hS/X6mN0hL2FZN/uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JmLeKu7GIq24i16gKKnQOpVP5+9fQMP3BO6YX5Z9BdM=;
 b=FtvVWmEIaQPGXeGGJh1tsCModA1ssMBFPqr85NjUhHVXgEMb0or+oqfCqxSPdtsUfRg+qBs+KPq3NvaCGHFCtPtPrlz3qLuqSiaR+99TD43vUImoX1A2RdYfmMr1Vco4mxeET9KYMpO2y5su+ODvgKBddV6g2HHj7BWraYEw0J4rJOMyn920Y+m8XooWkJalof6xwQCA1scnEWanjBJHe19Ho3uLmGb52AU39hfVPbf43CvWGbM/bqN2Q5foc3BwaR7AUZ8djZKobxAu4/3jNOPsViPa2nil/EhaHeqPtKawgXJDe4HKy5wAK6Ie2/zWMif5Pug9iKaI0nqFj5YJ6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JmLeKu7GIq24i16gKKnQOpVP5+9fQMP3BO6YX5Z9BdM=;
 b=TqEJz46tlUvmyU36CA5JB//5xdIlePWZmW0rSV4Y7KYSVJwDe3N8JVAgXT9RfEl3JbrEZQmCgoa/CRP0WWukIY9FeKE15PPOauKPPndgdA/0/Z4V0WrFBbbQriYBkEstTBXxZEfSzgNxzKqlEvySWxzptUcISJm32vbn/KmmvERnIdCYUTGiJsM0FbTYWznQ/LbTiZheKyW9sgPSzsw5iBruTqP7z0KukP/BBKlsT7e5ZIadPLC64usaGWyJxW+DnyZAi2n57xtGdlvDtLA4lUN2NMe/UDBedtdKHMOJrNy2ocVPAVxtvfWMoDwnkd9FoYMnJmWhWEYEji5/4+h4Bw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by AM7PR04MB6902.eurprd04.prod.outlook.com (2603:10a6:20b:107::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 04:34:08 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0592.010; Fri, 6 Nov 2026
 04:34:08 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 06 Nov 2026 12:38:38 +0800
Subject: [PATCH v2 4/4] software node: pin remote endpoint swnode
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-swnode-race-v1-v2-4-f8bc7b14d578@nxp.com>
References: <20261106-swnode-race-v1-v2-0-f8bc7b14d578@nxp.com>
In-Reply-To: <20261106-swnode-race-v1-v2-0-f8bc7b14d578@nxp.com>
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
X-ClientProxiedBy: SI2P153CA0010.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::13) To AM8PR04MB7874.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|AM7PR04MB6902:EE_
X-MS-Office365-Filtering-Correlation-Id: f61ea3a0-c39f-44d0-7c8b-08df3bbf3275
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|376014|23010399003|10067099003|18002099003|22082099003|56012099006|11063799006|261026140227099003|261022105027099003|261028144727099003|261102123227099003|261021123027099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	+mo3j7znLbvgOLqa+2BHBHMX0JYhViUxZy2j04GolWtAYFmDbJrhZY7laOPBE3EO2IVX4IeJPLFhXq+j4OdDUwzPC8ulPmh9LSCNaCBgzXWJmBWdGzoCUjIL90xehjItJoEYEc5lu208ZuRWWGF4BhVQtP4O2ZkIfIf52KOXS4nrKqSSymQKFU8wOoqkrlj0D8xvGjwf5yzQ1oJF9cXE+RWVNMnTb+kNIYs3fn6lmx3clL40EU8sUpurhGucdce0Mrx6iCXlPtsEnIKu3x+ly73BS8qZe0RqqYascApyvButeustI7THao/tlu2ST7AMYdKus8YeBswFUHuyW1hdjLkvWHfx6hY2FGiIcw7XMt76gQkoQcm2e3ktgBh0SunKXsPwAAXtB/TmxVAgnDTneEiwvLup071c8PzURLv42dxoOZzbI90xqI+KuaZc34GD6o5AJYOS9SgQTPua+O+yZxWWxAe+K0BSTdUzfYwneoQNl/iueR3DTTiulXt8qDmNNv59v/c2dXh+Guhv0hDXO/l1QrThd+86hPoQ1sPtIj5wo514mjJdd34owr0nm3Z94hqxGpV9OfLzmtY66Q+XRvURX6a4OJWjEotC6u4EI4VVpGxP+kp4kOhSTl7OJkNMOnoAKbqqgQg0JeYgAdTEPQqs9qYMJsqRvECvfKgvd80=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(376014)(23010399003)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006)(261026140227099003)(261022105027099003)(261028144727099003)(261102123227099003)(261021123027099003)(261021121427099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0RTOEN5dVYvdWIxY3RwcmVUU014QTM2OEl2Q2FId3dxMTNLaWJhc3FLTFpW?=
 =?utf-8?B?RG1RY2hkTmpFcGpzT3MvT0NqakUyU2hWU1R2N2ZxbUY1VWl5ZzEydU9EWmNz?=
 =?utf-8?B?WjNvbzZLM3IyQnd5dmwzWis1UUwzV3p5VUN0cy9zYVlTUnVjK25kZnFpOS9a?=
 =?utf-8?B?SmZFeHNqWjFtL2lrSlIyUE02NVhaamJ3dVFyNmo3OGpkcmpSalVVdjNrSVdG?=
 =?utf-8?B?cGkyd0g3Vlo0WmhCd2tOOXgrMXppN2FwSnJ0WnBteTdheFk3REtlK0Q5bVZL?=
 =?utf-8?B?UVl6ejRvSmpwR1BJSHFJVU5yT1VBdHc3VjVzUWZ1R1RTTjlvekZjbm1zcTlJ?=
 =?utf-8?B?OS9xLzNyN1g1ZXFwdzNvMG1heG42K0k2cDZXMjNWaGZTeWw5Sk1TSXd1ZG4r?=
 =?utf-8?B?eEM3UnZFNVNJL08wZURUM1FndlVxdzlBakJjeUhZU29rekQ5S1VTUWc0WVBj?=
 =?utf-8?B?M1JubE5MaXMvMndKOVpzY2pNdW4xV2ZmcU9TalBveE0vSEhSRXNicEJjR2VQ?=
 =?utf-8?B?WklLb3BjcXcrckNtV0VUUGtNNTFHZDZVQ0dJKzY0WVhnei9wNTJBc3NDYy8z?=
 =?utf-8?B?aStaQTVBam5TQm1Lb29LMEhrOHdaZENmRUUxWHZMVC9Fbmo5U3lXUVlmY1RI?=
 =?utf-8?B?TWNmTThqRVhkVFkwR3BVbGNUQ1N4WDBJQ0lxQkpVZGxsWW12R3QzOU9Gb3d3?=
 =?utf-8?B?VGV6djlhSTF4Wm5rUmtpKzVPc0FSMmFrbEZoMDdXYUtKdi9GUlNwM21Ibk5q?=
 =?utf-8?B?dkZWKzZEem40bDRxZFliSFpPa2ZiaDV3R2xMQ3NPR2ZzWDk1c3dUa25Jeldj?=
 =?utf-8?B?cmIvK1BLMHA1T0pQNlk1bWluTFFzWUJmUFIzaFAySTR3V2k1aHNTcTJadXZ0?=
 =?utf-8?B?clUxdG9td3FlMFMweGF3RTJYSnBSRktsL2FhVUt0SVhTRmNhRnlXR2Iya3Z1?=
 =?utf-8?B?ZkF4dGtjdDlrT0VwL2pVMDA5YlV5VlR5emF5emRYWlI4eVFNOXN6SU9HYlFk?=
 =?utf-8?B?NUs1ZDM2anpCelN5QUVsaUNrVW0zbXFlb2ZIWEF6L2dlVmZ0K1AvbmlIQzUv?=
 =?utf-8?B?TnRETVhsOVJKL21Xa1M0ajRYVEFuUXJBeDJJOFgxRytLNmZqNTJDNi94NW1u?=
 =?utf-8?B?VDBHcjE0MUpNeU9BVjF5VmRnSUlVU1JMZm4rRTR1cVdpM1dhVTBhcnlkZ2hy?=
 =?utf-8?B?eVAyWUNZVmVISlhTTyt0TS9MMUlkR1o2N0xFb2VaSy9ZaTVHaHk5dXNYNGg1?=
 =?utf-8?B?dTlvTWpDcG9NSklsVmt2T3UwSHM2NmgvbktVZmFBMTkyV3dVemdBeDVrM3U1?=
 =?utf-8?B?U2tLc3EycTZvbU1WN3pWZVhUbEIxaWdYSjhxVDY3Yk1ST1FkSTNXdHBUdGMy?=
 =?utf-8?B?SW5YU3k1V2hMTTVRK1NERW1FOHdGODc5eW1BQUtROWdLa0E2SUxGYTYzR1BP?=
 =?utf-8?B?N0srdmc2bVE3c3BjMjc5MG1kU1JqUkRTU2dPZ0ZuT1E0WHROTVNFYkJxNkZT?=
 =?utf-8?B?TFRnWUwxbVpEcFBhNHpUb2tCMXVMMEM0NXdYaDM2NWRwRHVvNWZ1bjNhZG1S?=
 =?utf-8?B?dStYR1FGbVFFdWQxNlNEazVrU25sTUlFZm5VQWRRWXlTZU5STmQvUFhzMGdw?=
 =?utf-8?B?eFlEOU54enJXTkFCODMya2QwME1rRjZjNThIMzlaeUFBWDRJa0N6ekMxVy9z?=
 =?utf-8?B?dXVrTGdnbU5YV2ZyK1JQVlF2a2FxR3l0N09qMmVsSWVDMzlVZFVxMnBtMlAz?=
 =?utf-8?B?WktKVjI4UVJMOVhWMmFmYk5UYmhkZUlIUmErZVlUT1hpNXEyQk9ML21ERlBt?=
 =?utf-8?B?UzJTcjlsTU9DQVpUMXFQdWhYdlR3SnRBVVpXYTRvN1kzSHBCSERuOHJXR0ww?=
 =?utf-8?B?TG9IYm0rUi92TGl3QlB1SVpDTFFyOXRRSm1HTDRhbXR6Z2h1WGNIUFNlRG4x?=
 =?utf-8?B?MEVWN29QeXd6am0xbk0rd1VySkgzTnlVczh1eUFkaU9NMXhOSDI1RFN4Vlc3?=
 =?utf-8?B?NGhKdzl5c2xvQUhCS3ZVQnNQNTBuQ1ZJaDVZRW1palkxQk44RUF4bXNBaXJ0?=
 =?utf-8?B?YW0reVJoTUttdmlTMm1POXRiNXBOZmUvOUoyODNTT2F0VVBVbGMvNzM2UURE?=
 =?utf-8?B?eEl6dXNEYS82d2NOcDdVYW1KVjFxWHllczV0enNuNVdURzBLeDB5THljTWgx?=
 =?utf-8?B?QURaTWs3L2FNVnZHbzNCZTNhRDN0ZHVVTVFBVEc0c3pNYWhSMzlCczBwaVVN?=
 =?utf-8?B?RUduRVUzUVNxNDRkaXNMb251eVJzdXdBaFFwL0RRK015ZUVHbFBNOHBtbk05?=
 =?utf-8?B?Q3hPaEY4STRuTDlIbGdCQlh1MW4wallUdDhhRTV3U3BtekcrNWR0TUFkYzZB?=
 =?utf-8?Q?pIDpq6NiOq7Y2U4Df68ZOQzSB/6EAHFq9eCSc?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f61ea3a0-c39f-44d0-7c8b-08df3bbf3275
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 04:34:08.2115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Xy+Kfbt4cgFpGOJY2aGVBbVFfqYdGFtihnDDmqZ/1RSu2eo1di+Bb1EzT9wt7lS6f8ElTBxTdqAhTLRBKD0GTUXUqX4jgQShmX6cAxUdhIT5Q4Bo0bD/AHiqBwMVaQY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6902

From: Peng Fan <peng.fan@nxp.com>

software_node_graph_get_remote_endpoint() looks up the referenced node
with software_node_fwnode() and then takes a reference with
software_node_get(). The borrowed pointer can be released in between.

Use software_node_to_swnode_get() directly and return the fwnode with
the acquired reference retained.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/base/swnode.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 1b0ecd3e814f9..e7c57cfb277c6 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -696,6 +696,7 @@ software_node_graph_get_remote_endpoint(const struct fwnode_handle *fwnode)
 {
 	struct swnode *swnode = to_swnode(fwnode);
 	const struct software_node_ref_args *ref;
+	struct swnode *remote;
 	const struct property_entry *prop;
 
 	if (!swnode)
@@ -710,7 +711,11 @@ software_node_graph_get_remote_endpoint(const struct fwnode_handle *fwnode)
 	if (!ref->swnode)
 		return NULL;
 
-	return software_node_get(software_node_fwnode(ref->swnode));
+	remote = software_node_to_swnode_get(ref->swnode);
+	if (!remote)
+		return NULL;
+
+	return &remote->fwnode;
 }
 
 static struct fwnode_handle *

-- 
2.34.1

