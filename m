Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.33
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793939645;
	b=HmD9Z8ylNwOmvWVbAwn8XGW3mxM/AvoWxthMBcwuyAz7ZPksCnTKLyK7DmnzxqXvj62x
	 dNDU0lUCw3/QML+TEfdcvWzX6j5dDYNJ3f2ZpGTHzXISeWaJSuCTiqvo/yanH7jVN6eF0
	 AjC5rIcc0Ys8CF/hr0ybT1MK8TBYQjFWkUwfhY2+bh4FxSpzMdCm8pQeAFRHwojyx3g0x
	 cbska8RhmmCh+MlgG5t1Y5bsvgJuLhyLML2Ppey6FnZgOCF/RUhj0LLU1xzkR+6FDPLLK
	 SP2mHNR2uMhwjltonIhdnHjE1kKdcxyyGpsCrQyWkC++lRXMY1/JX57CBvfWYwEIUSg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793939645;
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
	bh=DpoBhrMddTq364As0V0R+FcBP11LQvIk2vyKn+vkveI=;
	b=W34foIB/o32/P9qkfHv+669/cdbU77kDLprzY7LEpwx7CsKkK4vEs2W8JFPrDuWQiXEL
	 EBnzoODN4eccYZtvy+j93TZiBOyvoxgdrLT1Xy7tVdwIaiMOg+bxuJm8EvDT++GykGoQP
	 apIFP/4xpBlW9LldkZGPWxJgWCQ2H8EQurcTxB6hS/T7UK0lUWlzxQwAFXR88peMsNurP
	 V+wMzXVonHpVhfGdsDoXT4ENowxX8pqVKTXSqBuOfqnXw2iJjQWydLcU8BxkBRIdCDUN2
	 ky/J9H/kqSrhzzSRQDfpxrNmAUEr1ctJBmuV0Xs+cXX0krOB0+hKCmkHhC8Gn23nl9w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=cNQycrHx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.33
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011033.outbound.protection.outlook.com [52.101.65.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33027606A339;
	Fri,  6 Nov 2026 04:34:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33027606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=cNQycrHx
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g7px4KYc/xGMX1l71n/GH1tKJjrV04aiCA/SEr72I53mx1BckQBli0z6D8iEoucYZdzsAhE+cZMZyevFs93+/fkzrh0rIYr7W+kIAl1DeXxSQq9WYx9X99QVoYD8cOofLHUNLBwe8a9V/Iqg7GbFc7+l+5MmIjTruvp05K6jiGuq1HYnwfRMV+6VtXHNiRYO+xkivhi+3fdomA6GJiW/Rwale/mv1en2Do5x3N87v0lhYoNJdZx2xVmmm2dXS6NP0jQxxr/BekwNF3GeUhw/5JtwRpcAalU0YmizafWWwTEUmiQHFjmy0awUHluUb5hhxeVrVL2mATQDYT0DPFWwWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DpoBhrMddTq364As0V0R+FcBP11LQvIk2vyKn+vkveI=;
 b=yQmcf4msoHvDSQwpx7EWy3EsAWHqKKXsDYsyO78Qs8eJvcsEeh6Qonh0rEXXgajx5WbBTjPM52azNYPwy6PlmjFTfxKjoRqBSqC7Ywe/rqj5ALCzMaO0El4B3+uEndTDjguOIPGEvS6sLf7l0iNn6v/oNbcQHwly0inAj7wfx2AxIWHCw0tL/NXM0P0N2BZUmVGN6mLMaVanYTD90SDbftb4RQ5ejUSkcycUZCrh+QMMjmgjT8dyn4QYv9bM8gjuSxcJd0pItTlkt4eKMyA6XDuzaX3FOY3FW3QZOo4D5AVQPUOqR/6hhbJchAQEgnkwqDpzj/TKJR5RlQvfmBSQQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DpoBhrMddTq364As0V0R+FcBP11LQvIk2vyKn+vkveI=;
 b=cNQycrHxm1QtBP8IHapWDyzqgLhwpF8zgccLnvBDPIINCe51jyrlldh9P68GVF4UC6BfX+McOyG4iNpcebe5MgWlNY3HqePNefXbCbg2RzgcBvoZivlzsHxMnVncZpDaEI1jKr5YavWqtG7H1nRVRpx+qLa1FeH08hfVZ1DF5UGHEcYzibXHgyTdrwBsX4B1CjplpSt7mKV5hvJHdpMUZSQDq1KkuU3Mb+p1NhOIGIHrQqhcmO4ST4U2+YJs+RLyCGiTJTx+NOM4Xi22yuqSScqLrpRhfI35c0xoiADWXcHiXQ6uU6YvUF/wg9e3Ln7eyG1tvS83fn0koRMlT6Sc4Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by AM7PR04MB6902.eurprd04.prod.outlook.com (2603:10a6:20b:107::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 04:34:02 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0592.010; Fri, 6 Nov 2026
 04:34:02 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 06 Nov 2026 12:38:37 +0800
Subject: [PATCH v2 3/4] software node: pin referenced swnodes while
 resolving them
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-swnode-race-v1-v2-3-f8bc7b14d578@nxp.com>
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
X-ClientProxiedBy: SI2PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:195::12) To AM8PR04MB7874.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 8ab19ff3-c1b6-462c-61dc-08df3bbf2f13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|376014|23010399003|10067099003|18002099003|22082099003|56012099006|11063799006|261102123227099003|261021123027099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	RD9QthKbYEULlhRkXNWXaWFTl6vMWNjqR6tEust9XPyqzpWWqdP5Htu4uPQAvTi7xTt2t8thXFFE5GBpDPFYKVtwzuoZnZ+ubqt85piqkPB484YFuaU6Q3SPYThdNV8akdIaE0S3MJH1cP76bG9jP/m1UJZsu3hqdCooGdDiYQPxJ/oSBrb7rjOzyy/a5G5qDq/BINU8wKzKMDqmwQGfzvVR0a2itqnj0S8+per26Xnfwft37R7g9vb8uCSMVg3lSpZS4LpddUQWEaXxT6NQVnERZOZDT4mmGOXw9aN12NVPwvf8ElXmoLT/Yn1CQd/p7rvIw+GUx2hosbHvjnrhEtV2cbV88z+xVvgr7XrPqw0qPNFyZB0igKW3WVWcI4/cCTotGb+kRDDM3gU04B4RsQc1iT1nxCq2UWNA4LK007hszVyVeUaSRM1hn1X7fmw9yWeQkP2SP6lFKsrPJC8fMRXCdxE8YByk/bBYf78RsI520+7iaL7xsFCqvL6Ezg6aa2VCfp9hcZY6bli91t+ULgJn1j/dWlIzJ/ZCwkAfC9DVHTnjOKCGCeqQrezsKP5kPA8OObgWdsUj+43h9JP7ch6pJ8Pc2Qb40aULOo4/OO1mgonm6r9RcDcPy1aY2rUsrdysq6RDSKgrndQJVSvpYD4QMKfZBaYULvoWyxZCT8I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(376014)(23010399003)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006)(261102123227099003)(261021123027099003)(261021121427099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?REQ3Ym9RcnVlN2IyRTVZdGt4UDczRERNWnhWeG1lQ09XMEdOa0w5ZjVxcG9U?=
 =?utf-8?B?UThsRTRwa2tqN2Jkc1VPd3hPeXB4VmpmN2xEU0UzTWVySStvb09naFBVUDNP?=
 =?utf-8?B?YkIwSU1WUVZYekRIM1lFa1FmeWhoVklMUmNPaHFSWkphMzVYTXpSb2FpaG93?=
 =?utf-8?B?akJVZ2F2Zm1ubWNqL0FhMUlrSVhIUjg4YmxETnBoY3RmOFpBU3JZTUl2UXhT?=
 =?utf-8?B?cEtCV05RWi9uV3VOYzlkOFdjTExKWDZEWVFjZWVTWlJYd1VlOTg2anBRSHov?=
 =?utf-8?B?azNHYnd6YjNDMTk5YThYSnVZSytxaFlyc0lTamQrNlIxSnhDKzVVc05FVnRU?=
 =?utf-8?B?T2ZOMDdOenRuUTE0cWlQdTZRS2RCWEhzbk5LUm90aFdNSmRCeXdpQzRGYmFK?=
 =?utf-8?B?bkVEZG9xbFI0SWlQeG9MVEFsaWtjV0p0aTQ0MGluOG9kVlR2TWZmUkU4ZFVh?=
 =?utf-8?B?UDN3L1owMjNNbkZ4WjhzTkZ1MmU3K2w2UmtpMzZBYUlES1p6TEpLbTFFV1Jo?=
 =?utf-8?B?MGdsTzh0REpuSWlsYW9PTzBBQWJSMmhXbENqbDFkQVNzNXJ5eGZyS1luNklv?=
 =?utf-8?B?QmJ4RkVkbmsxVVk5OW5RbytWZVBrM0FwNFk2TUplT2loVk5yZExYd3k1OFYx?=
 =?utf-8?B?dkh0YTZMYzUzVmdKUTV0VzUxcURoMERCVjNSMjgvbjlsMXZHcUhNQjdOK093?=
 =?utf-8?B?dmFabDRCRnFDalhWUzdVdHRsZ1hWcitLN21iaHdUSzFvOU45d1N5akhHa3lL?=
 =?utf-8?B?a0QwU2d6YW12Ym9XMG9HK3VYSHA4c2phdWF0SHhOSVNXSmxaVnpyMDZ3T21I?=
 =?utf-8?B?VlM4NWhIQjBzZ1M3cWw2WnZVVWNDTWFiMDAvZjl4U2doaDVYNWNvTlBwM2lM?=
 =?utf-8?B?NEw2cmFpbzJuZjdqM3Q5SVMyRzFBQzBoRjFYSG5aNnFndXNoRE1WT1R4U3lp?=
 =?utf-8?B?djg0UzdFb2FuckJlcDc1ckVuWjBmSTRZRHMyUDVxV3FFWGhtaVRaN1NIUUJW?=
 =?utf-8?B?M1g5c3Q2VGVyTGxaK1hJVHlmTWIwUFJHSzlVbmUydGM2QUcyZWx2V3IzSkgz?=
 =?utf-8?B?VGRwd3JWM1l1OVozbjlncEU1YWh3TUdZWXg3VGloQ0U2T0t6dWlQQXNQL1g0?=
 =?utf-8?B?ZDcxRkh6em5QZWFSb1pQZDc1cUhlenlxRWFQMXF6ZlErU1NRUktmSXFuUmwx?=
 =?utf-8?B?OGdlV3QrNTR1TExmcWExTWU2RG5GTzJtWm5vRVNDRUg4TlVvMmpiRXdCWFhL?=
 =?utf-8?B?Y0UwaHBaTTFhRCtxdnZ2VWFtSjdHWnEzbVFHTFV2VGYramRoVU1DdXd2UXpJ?=
 =?utf-8?B?dm94aHQyMXhIV1JRNU1TNFpFQkRRZkx3RC81ZmFrV0lxWnF4SnNLQUNKdGdh?=
 =?utf-8?B?VGlwOGFhbUZJYlNEbjdRTk45NlpSVEU0WDhBdjRONlNFV3d3QndLN0JsdjZz?=
 =?utf-8?B?Rm9OTWJ5a2NNNXNMTTlGNC9iZUVxT245aWc4MHk3Nm9oSm5XUlkxeG9PZVdn?=
 =?utf-8?B?MURWUlV4NDAwMy9jZGRzcG5JU2VLbVljZG9BbnE1WlFiaTFyTGg1VG90OEFw?=
 =?utf-8?B?ZS9sQ3FvSmpxb2tqMmVyRVJleVBJbk5vcHRlcDdPdDdiOEpxcnpzWS9XczZr?=
 =?utf-8?B?azdNSjZaR3VvVmFUQUVlK0lKM2V3eDVTaHhhNDJoSS92RDNqa1NNQUVZQ2lJ?=
 =?utf-8?B?RzlkcStWUTdRaytXOXZCeWNGSFVCc0c0dzRCMDVSYm9XRmt0WVV6Zm9xWGFJ?=
 =?utf-8?B?UWJ5K0dTSFU1QzBvQ1hJMVdNeXVFclUvWWtkUEpWWEdwdHB2eDR3SkRVZk1I?=
 =?utf-8?B?Tksrd3JhRkkwUDAweUptODliSDE0ZU43TE9jQXJlN252cDBwMk1vdDJ4dkZ1?=
 =?utf-8?B?NzhYR0liNHZPL3VJSlR6UzdyRmRHUXVwZ0ZLZVk4VE9qOENpNnJWUFIycWI4?=
 =?utf-8?B?V1NhczE3RlZJYml6WUJmMGdHb1F4MG1vejNoTFVQejQraE8wTGk4V2haeE1J?=
 =?utf-8?B?RkhxcWJQTUNxbCtDcE5aaDB5S0ZFQ3hKYi9qa3l1d0JicUFzUzRGNXhBK2VC?=
 =?utf-8?B?Wkg1K3hzVWtlUVR6emxLM2RHdWxHSUxLQVl5NGhXMi95QzcxcFpicUlTUnY0?=
 =?utf-8?B?anVSWUx3cDc1MGkwTnlBZnlLaGJHUDFDN2o5dGIvR0R5dmZOUEcwYTFpbnZU?=
 =?utf-8?B?djVtUm5EZUs2WGw5YktHWGVTVFJ0K2lTWTN6NG1NQVpQaFltRHh4QTJJTmIy?=
 =?utf-8?B?SE9YVTNpS1hFR2hsWFp2amRMZVdlTTR1di9oc1haRDNlUFlyb3BIOS9aTjZv?=
 =?utf-8?B?d3A4K0dRaXZxK29DV202MEVlaDBuRlVBZWpzRUN4Tk5GaU9TNXBTd1I1TFlq?=
 =?utf-8?Q?yARvaIzhysOaWOn/wZxGtcWm1aeI7EXDEtjWV?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ab19ff3-c1b6-462c-61dc-08df3bbf2f13
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 04:34:02.5729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wo3BdLyk5khTxSz9g7mjsu/F0NIBoS5BO+SDqgsDRz0gZt8O9wGyCobCNqjtlCz9/OKOBKi7KGa9LKEZvP10EY1N7n9wRYKmbnPZLzLIjaSQw/vBqY+++wcZwVqnWYpF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6902

From: Peng Fan <peng.fan@nxp.com>

software_node_get_reference_args() and software_node_add_links() resolve
DEV_PROP_REF entries by calling software_node_fwnode(), which returns a
borrowed pointer. The referenced swnode can be unregistered and released
between the lookup and the fwnode reference or link operation.

Use software_node_to_swnode_get() for software node references and keep
the reference until the argument or link has been set up. For direct
fwnode references in software_node_add_links(), take a reference with
fwnode_handle_get() and release it after fwnode_link_add() completes.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/base/swnode.c | 61 ++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 41 insertions(+), 20 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index ffca8827516bc..1b0ecd3e814f9 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -592,37 +592,48 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
 	 * relevant properties and bump the reference count.
 	 */
 
-	if (ref->swnode)
-		refnode = software_node_fwnode(ref->swnode);
-	else if (ref->fwnode)
-		refnode = ref->fwnode;
-	else
-		return -EINVAL;
+	if (ref->swnode) {
+		struct swnode *remote = software_node_to_swnode_get(ref->swnode);
 
-	if (!refnode)
-		return -ENOTCONN;
+		if (!remote)
+			return -ENOTCONN;
+
+		refnode = &remote->fwnode;
+	} else if (ref->fwnode) {
+		refnode = fwnode_handle_get(ref->fwnode);
+	} else {
+		return -EINVAL;
+	}
 
 	if (nargs_prop) {
 		error = fwnode_property_read_u32(refnode, nargs_prop, &nargs_prop_val);
 		if (error)
-			return error;
+			goto out_put;
 
 		nargs = nargs_prop_val;
 	}
 
-	if (nargs > NR_FWNODE_REFERENCE_ARGS)
-		return -EINVAL;
+	if (nargs > NR_FWNODE_REFERENCE_ARGS) {
+		error = -EINVAL;
+		goto out_put;
+	}
 
-	if (!args)
-		return 0;
+	if (!args) {
+		error = 0;
+		goto out_put;
+	}
 
-	args->fwnode = fwnode_handle_get(refnode);
+	args->fwnode = refnode;
 	args->nargs = nargs;
 
 	for (i = 0; i < nargs; i++)
 		args->args[i] = ref->args[i];
 
 	return 0;
+
+out_put:
+	fwnode_handle_put(refnode);
+	return error;
 }
 
 static struct fwnode_handle *
@@ -775,18 +786,28 @@ static int software_node_add_links(struct fwnode_handle *fwnode)
 		for (unsigned int i = 0; i < count; i++) {
 			ref = &ref_array[i];
 
-			if (ref->swnode)
-				refnode = software_node_fwnode(ref->swnode);
-			else if (ref->fwnode)
-				refnode = ref->fwnode;
-			else
+			if (ref->swnode) {
+				struct swnode *remote;
+
+				remote = software_node_to_swnode_get(ref->swnode);
+				if (!remote)
+					continue;
+
+				refnode = &remote->fwnode;
+			} else if (ref->fwnode) {
+				refnode = fwnode_handle_get(ref->fwnode);
+			} else {
 				continue;
+			}
 
 			/* Supplier not registered yet, or self-reference. */
-			if (!refnode || refnode == &swnode->fwnode)
+			if (refnode == &swnode->fwnode) {
+				fwnode_handle_put(refnode);
 				continue;
+			}
 
 			fwnode_link_add(&swnode->fwnode, refnode, 0);
+			fwnode_handle_put(refnode);
 		}
 	}
 

-- 
2.34.1

