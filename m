Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.63
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793939643;
	b=kM4TE/h3tth59xm5EUQeLqlRTMFu38y7waHgRlFiExvLIJWOGT4AI4vVy6XWbzDUM3Kh
	 oJATgYmiQcYtkhqF6irLNrD4w5p7rsAoO7xNJ74Ao7bGWRYMN+y4I8TsRNklBJXWTGioC
	 r0KYxyl/CTVTf3mVmwNrGFI4rpBgO1WaGKWtGjKhHTdtQpxyu6hL1eNCaQuoJ70onMWiQ
	 h3dbCsrfpVmBsY6Fybeq7n1lNSvZwE6KoeSWGRbqEPpwpRO5M7mlDlN71neaQ+d6/BgRe
	 G/e0PhZeMEIPtA3qvabEUTMGaZ80dNtvsCI8tL2LgRHNMZi6y3mSczSBy0QKyDweU5g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793939643;
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
	bh=SAjfIfnhli35DVXfc+/ex1RYyUwRvcj1oX5EC7JJNGM=;
	b=rX/J8EA8K1sO2Hl6IdUPgEEPFdRy3kBEX+epEqXVlj0JsuYsfbE6wzw6OKjRDcVFpGh0
	 rvApeRE+gdq9Luy5in6ChxGzHR9rx4Skcol7ArFknaoULU7F6MqOsccJoJy1D8zq2dCpD
	 HlMm3iUDISYZmCxyT3S+EGSgDAxL5k1Y0tqRcDaJSZuAiz268beRsCUZBQs7e97OuRen2
	 Sh6BRng8OyRAPHcLgX/KJqW+Zh5sW86hxIZz2Kkt7BMxSut+Ove4sGrf8Kj4O+WV9xgmd
	 r7s/W/rBZCM0m0CNbZ993ZSrOKr6pHfk6rm895bgcJiSNXBUp9p6FE9XKTYki7kRdvg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=fFP0zZlk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.63
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010063.outbound.protection.outlook.com [52.101.69.63])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81646606D814;
	Fri,  6 Nov 2026 04:33:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81646606D814
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=fFP0zZlk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HtJCjLM4uSUl3uHXqvJyB3G+j8XG8CQQ5kLgGZLZHPt1CmYGePNmMS51rJ+5+Y21XmIOd31ZUnwA14IxYyDeeRO8V4L/jDSJWQvr4CbF0uoPA4Pofzo/Zbf4LpByk6l9Q9/ADiRY5UNBWRyGnp/Lqv6EjLVB6fBshCgr/jqwD+bMqJkNd9zyp/+Gt6zUkQKHjAcbPPWSO187UmVBfKOOlFMEsYDDYdZaWQ6DN9VouWJUjbSNhtoF4X8hMyRstJaQrnYfSjt0kPnZNw2/sUlHpT045e+aRKTdS8CK8pM/UtB35zScceyNmmTcXxxOLLsz2zYlE3WLVyG7dKf9YX9nfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SAjfIfnhli35DVXfc+/ex1RYyUwRvcj1oX5EC7JJNGM=;
 b=pzSl8CiqtUOepRMvJb1pd6JUQ5YACknZ6LtTv1rG/1R1DcNDhL3zl80EQFk7t0Fx1BshjeZbDKlGnl69Ovhw3oR8PtAyGSUYoaHDf3bXAyJBmIuZYN7fSfdfnPw/UP2VBy5an8GJvM7nbrelV2wbF58skvup2fvnOYODqXH8b8i/+4WXpegO8ADP3HxUeDOJQc4BQHOYnxuQEaT6Mpw5+L/Ya4J4YsYDhxsOLMWgI3+ntvZZN+c4BGdjC8fa47i312BtiVZcD2CXXTe8uZCAlMYr5dlBRalWCMxH24fBqXLRqNMOKB4/GXQOJF74RUIBPAKrO3zyZd6QmMHV5Y8T1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SAjfIfnhli35DVXfc+/ex1RYyUwRvcj1oX5EC7JJNGM=;
 b=fFP0zZlkfyB5EXAD8i4udfMKddzyDKNSzxVe/+4KfYMifiMgZojN5fX1GZDReuup1/XLwEOfLp2FMPNyFTLACiDD3eiDUh6ZmgW33HFPuT/+QJ3OJLi0i4u6hRzKHl8iYDEWvcXNguRJcWwdEun6vaibVYAL191orEnoc8sIy4PHGMdr6hiJOBKxG2esCYktrXn09RgA3Qk3kyOj8aZGLhze+K8uzqDQjKSK/JD9DqkOj9lN85hqROhAVLeIt21Vyf0YacyEthRHZmZjTtvl6eDk5ilRgRcMqmoi9JzPUUMyrTmfWpTMu7UkGO/FEJd+RQr6xQ23hgidjgVQBAePRw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by AM7PR04MB6902.eurprd04.prod.outlook.com (2603:10a6:20b:107::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 04:33:57 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0592.010; Fri, 6 Nov 2026
 04:33:56 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 06 Nov 2026 12:38:36 +0800
Subject: [PATCH v2 2/4] software node: use kobject_get_unless_zero() in
 software_node_find_by_name()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-swnode-race-v1-v2-2-f8bc7b14d578@nxp.com>
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
X-ClientProxiedBy: SI2PR01CA0049.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::13) To AM8PR04MB7874.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: c72fc1ec-8c99-4396-90c6-08df3bbf2bb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|376014|23010399003|10067099003|18002099003|22082099003|56012099006|11063799006|261026121527099003|261026140227099003|261022105027099003|261028144727099003|261102123227099003|261021123027099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	mMsillbBqMWVx7DAhtBbB2rpfeM/K9grjuWBKWpHGpCzoY1Hwuk8qgLZEiZOovzpFFf2U3jUUQQACsERdROi9++LdwYHpYNMlLiqUjNNp6+yklvSOQNL6V/BUCgy3P2tPmCv/2MFrHvMCIX9rmxg3AaIp6OyKTG9aC0kHx60iVPlxelSFv2zqkPG4yRv4l/EV8fjx65RNbE17GDh00D+gpOeemNDTzW8TsfyRU0ieM3cAV8LkQ3oQpxKHKcXF+7jk2FSDZ4ky787amuJGkvs9H1ZXc1tJpGAK1FYNS2UqdsSswdIyR0eVoKosd7MurCEzIPn687HLPhMvY/CxIUpQXQVkAPbPQDTmj+3TVqEQFOPVsNZIZlzhVA8qMBysDAFHtjNCXVCDBxcxcaR0EzaLKCwofJFOydT9MI8o9JuFP4Qa2sL+NrdlXBA1yNsVzqceA5bBa+7dmfKFvLtcteNmSQlRz8s6prXJiipbOjDa/gz1MDTeCbKjw3ANOJnf/WNdMhStR9WksVauJHfoi2h7v6ItrTHa/FmVfZbXMNXn98U8yw1m/cfkOZmpCWrmzgahUcZ/sxS6yExPO16cg9aUx1W3MBisX7/aKy8ttSowrT+5ZouynXEcxP0UKcAOk6V5BtF19FhwAVUa0e6/83uiA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(376014)(23010399003)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006)(261026121527099003)(261026140227099003)(261022105027099003)(261028144727099003)(261102123227099003)(261021123027099003)(261021121427099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MTVoK0loVnlkc2RLa0taRTM3VFNHK0RMQSt3bFhobmtNR0J6VUZSY0MrQW44?=
 =?utf-8?B?dlNSYk1BbE83N2lYNllvb1NKQWpiZ3pMWmpEb3VRTmdOSXYwTnZod0poY0o0?=
 =?utf-8?B?c0U5T1ZRKzVuZEN1Z0tTQ25QNDNiUEVpazF2UmhnbmtQR1IyTlJ3M3crUmho?=
 =?utf-8?B?ajZPdFIwU2V0ZWg2UWJmWmEvRFR1cXBtNWg1Uno0S0kzMlZJL0lIaWpJQy9R?=
 =?utf-8?B?WHFrN2lZMzRXUUd2RUhhZ3AwWkhlZ2xYVDRkMHIyYWlYRVRURFA5TzhIT0JT?=
 =?utf-8?B?L0laQVNNbDlyalprY2Iwd2x3RnpuaW95dGNxaXY5QVZrTFVESExxUW96UkpO?=
 =?utf-8?B?NWJBdlkzQldtMEJsSzhUTXlpZzF0bEZiT3ZsN3RhNklLSnZKY1JYa3lKYWhk?=
 =?utf-8?B?SXpkWWx5eDh2Zm1DZCtad2h3NURYYUMrMDZYckUzQ0NWMk04a1pnK2hHNmRP?=
 =?utf-8?B?NnRnUGVvZ2RHTnU0TmMyL0h6aEl4YmVFYjVRZFR0TXY3MkRLMGxRN0x6NUVm?=
 =?utf-8?B?bFFFeDJSc2RNOERXZTQvTnp1ZHk3Qm9TVHhTZjVOVmdaeE95Z1J0UzU1OUpD?=
 =?utf-8?B?SWFjQ3hlY3VjL1pqcVhHaEtBV0ZOQ20xRTROWEhoVnprLzFTSE5DZjQydmto?=
 =?utf-8?B?WkxsOUJORkFNaFdzOGE3Q1ZvTlY5akZjMUZXTEtDNGpKVkh6QjRYcWpoVmk0?=
 =?utf-8?B?MGw2VU94RVNUWFZiQW1takZyY3BmMEZFbHZYWVNPSDZmVVlSTXV4UGpHMHY2?=
 =?utf-8?B?MUVCdXd1L1lOODdBWi90NFdmdThwL1NxaWdZeDNuQ0tNYXZ1Nnlsak5MRlNz?=
 =?utf-8?B?UlJsajRzOVI4ZGZoQjBPbVA4TEc5QmxnMUtJWDZETmp2OUlzbWxjNnNoSFFL?=
 =?utf-8?B?STI4b3QwWlVsejN5aDhxRDZzYlIwL3FjT2VKemdwbVpCVFRpSE1OaDlrUFdk?=
 =?utf-8?B?VS9iR1NGSzRsUmdIVnB2TGRUOWt4cGtVNFVnRTh3TTdHbngyWURWSWFhekxS?=
 =?utf-8?B?ekdRZGhpV2dOdlRzYVI1Y1Y1Y2lQWG1FRlZ3SFl4ejhYMzA2V1VpWWxES3Bl?=
 =?utf-8?B?eTdPcHJpcjJ1eTlRcUJUayt5L2RDQTg3WEs3VEh0NjN2WVh2b3MrM1dtWGNo?=
 =?utf-8?B?d1R5L2xIc3RlcXdVNU1nRyt0aFZYcmdJSmplNy9CODlZMHFjSC9aM09Jdk1L?=
 =?utf-8?B?KzBsNHlJazFxRUhTMmRoYTZyQkh1ZlR0WVdzSE9ZQ2VoYTYyOEZzZ01ZL2hR?=
 =?utf-8?B?RnQrcFpYNHc0bHVwMllISWV2bVZnL0tKUzZNTGFWbklrRXpUZU93dTJ0eEdx?=
 =?utf-8?B?amw2Z0FhS2doQngrb0ZUQXRUaWNCTlZTVXFMK0ZJQzZUcDY3VnJSYWlWOFpq?=
 =?utf-8?B?LzF0V2xLTXMwa1g0NGdtSVd6UkFVL2RibU9iZ3JFU1JTZk1FcS9WZG9PMEF0?=
 =?utf-8?B?cjRsNjZHS3AyNzEvUFpvdGZaMmRxM20wckVDU3Nxbk92dWVBZ3pCeSt6UG04?=
 =?utf-8?B?a2pteU1mZEdNTzVVM1p0K1ZRRVhTRUtHSFNRNEZoQmV1YUExMzBXUHBqTHhE?=
 =?utf-8?B?ZitLVFNLeC9idEN0WXRjWGltaEtuekxCZnpTZndXQnhzQ0RxckoycVhKblRT?=
 =?utf-8?B?YmNGd0lqelBFemlTY0k4UE1ZSFA0cWo4UFpKcGxRazZJTlNjUHp1NkFxd3Zx?=
 =?utf-8?B?WVJKZ1dwYjJvcjlLb3VRUjV4WUdtU2lTd1BjcmFlcmZ1SFljTG1ib1ZseE1a?=
 =?utf-8?B?VjkvYlZhTENxV2NNQlhocWF0V3B1ZHJ0cWxtalFLSytoSmgrcTZYeUJKVXA2?=
 =?utf-8?B?RlRSQmJsb1VoWlNqMWcyZ2tpcjhwVWxxbUZubVRNOEJFQys0dDhuUDAzQnds?=
 =?utf-8?B?aGZWWFBHck9WdlFiR1NkUzRHeVhiQkVpNU1BbFVZWnZjUnZnV2NySFYzN3I3?=
 =?utf-8?B?OEYxN2dXYkVWVitINEFWblg2TUtrWEFhZThNbU5QT2o0aFhtT25zMGlJUWRJ?=
 =?utf-8?B?UEQ3Q3Zid3NGalhDNFFkQWw2YkNlYk56ZnpQOTFWOTJEUDB2czN6aTkzWGww?=
 =?utf-8?B?amdFQW9sRStiK2cwSS9WS2JKOTFXaWZJZXl2czlsQk1wUkF4YTJGNlp5aUNq?=
 =?utf-8?B?RnQyUzA0RlZPWjBuSWlJOFRvbXFkU2VrV2JXQyt4K0lteWFEbG5vT1pIYVQv?=
 =?utf-8?B?ZTVod0NiYUErbGkvMlRwQkZJcFNIcGRMSmg3M1RUdnJoNVhQRkEzYzB4VjND?=
 =?utf-8?B?U0xFdVp2OE04aStFUDdzLy81NjJMdjR3VDZUcFMyR3JIWDJUblViSGJKTWhN?=
 =?utf-8?B?M0p0RVBiNm9VUGhMa09DaTR5cDlaaUM5TDZrR2d5RFJVNnIrS0R1aTBEMUlY?=
 =?utf-8?Q?7oRq+Wr0RbyfoHyPMi30fBZftxddG0GDKTBem?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c72fc1ec-8c99-4396-90c6-08df3bbf2bb6
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 04:33:56.9179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vERLgF25iIWS4UrItjS3IsRIwSrKZjrBEbEILMEh8S29HXXzYXXMIqrz2Nhv1+kaKhwPxJeGjE+OgcWWNslxLsAmm+rP5mGv7Y2dm2K+BL5IXEQV14rWxeEEmh+WkJaS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6902

From: Peng Fan <peng.fan@nxp.com>

software_node_find_by_name() walks the swnode kset list and dereferences
swnode->node before taking a reference. A dying swnode can remain on the
list after its refcount reaches zero, and the caller-owned software_node
backing storage may already be gone.

Match using the swnode's kobject name and parent link instead of
dereferencing swnode->node, and only take the reference once a match is
found. Record whether the node was registered with a name for this
purpose.

Fixes: 1666faedb567 ("software node: Add software_node_find_by_name()")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/base/swnode.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 965e960156876..ffca8827516bc 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -38,6 +38,7 @@ struct swnode {
 
 	unsigned int allocated:1;
 	unsigned int managed:1;
+	unsigned int named:1;
 };
 
 static DEFINE_IDA(swnode_root_ids);
@@ -836,11 +837,20 @@ software_node_find_by_name(const struct software_node *parent, const char *name)
 	spin_lock(&swnode_kset->list_lock);
 
 	list_for_each_entry(k, &swnode_kset->list, entry) {
+		const struct software_node *candidate_parent;
+
 		swnode = kobj_to_swnode(k);
-		if (parent == swnode->node->parent && swnode->node->name &&
-		    !strcmp(name, swnode->node->name)) {
-			swnode_get(swnode);
-			break;
+		candidate_parent = swnode->parent ? swnode->parent->node : NULL;
+
+		/*
+		 * Do not dereference swnode->node here: for nodes registered by
+		 * the caller, the backing software_node may already be gone
+		 * while the swnode is waiting for its delayed release.
+		 */
+		if (parent == candidate_parent && swnode->named &&
+		    !strcmp(name, kobject_name(&swnode->kobj))) {
+			if (swnode_get_unless_zero(swnode))
+				break;
 		}
 		swnode = NULL;
 	}
@@ -923,6 +933,7 @@ swnode_register(const struct software_node *node, struct swnode *parent,
 	swnode->id = ret;
 	swnode->node = node;
 	swnode->parent = parent;
+	swnode->named = !!node->name;
 	swnode->kobj.kset = swnode_kset;
 	fwnode_init(&swnode->fwnode, &software_node_ops);
 

-- 
2.34.1

