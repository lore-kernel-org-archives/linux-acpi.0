Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793939630;
	b=prRLSBSuRfzkRpIzfukrE5tpDgh0TxkFYuHNOhSjKkXKJtjgoszCmOgFVtCNHyRAioX3
	 sW2OyeAdWw/g9oUs0dIuxAfUun8xCiFrmI8CWY2pseyZxuC9qnmAGjcqpEvoFOq6pERoy
	 SPfCG+E8kb4glhvgPjg2exZghxBV2SwPogntPt5NXLEbAqCzESc1BqLCFgZ+hvrogXuSb
	 4EQxeB0WRidRvJt+153lexwZ11d7Pzs0mjIIOfRFX3q5SLhywt/Xvh6U+9/CkYU4FaR1D
	 PeDqsfuYQMdlCap5u9VnZbZTQeupfP5uzzCHk10Sz4BgeWTD0ua/oLjie+6Eu1nWc0A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793939630;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Subject:Date:
	 Message-Id:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-ClientProxiedBy:MIME-Version:
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
	bh=K25TqPh7z8AKTtPcUqryrp2c9om8IN8jQ14sMud28Oo=;
	b=VW8nIdngLbjG2lqdrCg+j9NesiHVxcO7SK7vTFeuAmSCiHI7FyDri9eSNprOPhm/BGNR
	 qlM+1mgDUgGU2R9qTRx2KCFdoizbzN2E29buy7ZDTop8R6d7/D5f921Hnku2XJoDu7Bw5
	 OTFECyw+fskVZtnvEDFDMzY7G82x60Y+aFaKGkkAdzLq1a2EwhwQsgBQRdWwqvS+wml87
	 B548oedEoLfMe7Y19CHDj3Ti+SyA9NiGgzuL1Lb6CSs0wajruGvMb7bY77912uRUP8Xqz
	 7kIFKu2EMrohmJlgtIKMWUDvw0w0UkXHh9dV7yjoBNyIFPFzepaXWf4uFJ1GhwfJ+WA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=HRNDNxGj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.28
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011028.outbound.protection.outlook.com [52.101.70.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655C6606A326;
	Fri,  6 Nov 2026 04:33:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 655C6606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=HRNDNxGj
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ho4Vq4AkQPjvOxxUQm1fLBeZQTl4LT97APxWmCzsE58GzSFsKUJiaM2v2lmbrTuxyPzSWH5parzPZSu4AZdA39rR4AIC9qnRXjV/A+KcR+S+au/h+key3C8FseXBn7L8VLFPTJjIne8N0gNaOYkKFFnMqQrdlhEQljhh2BE9PbhaUXMsFk4B0v0p0CcKPaZdhRYBDGrr+ddhQvTgN+CaezHKM8bORb60jBU3DRDwpSgy8wEG6P2mRkOjA8U1N5Gq1EY9uRfWkYj7SvIa8WOUFuDoL3QqO4BX60dXqNLM4zxNxewMFTc703FT0zyxCxazgNg22rkRYvopO6KDNp5lOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K25TqPh7z8AKTtPcUqryrp2c9om8IN8jQ14sMud28Oo=;
 b=kqFSTe9iFnBJv77+e9wrHt5nAcEYoq2LPX+bPjHnDEk/jUJT29hrvaGGAS0dPxOS52AVzZzEFbUj0/3u2a1in/TR8wtaAsDqU4vxy4tzG7aUjWCK+/DMqxKT0iYjeEW2GRT/N2eB/C8ZK/vcHzsCH0jy/NnGEMFTc3LOXsyzjnQNpH5k8fTr+abZixs7wVgKKmvtS27wQ/X7t9uwgcPkSntvTlv/4b9kbQ0b0y25l4v1TZ/mx97lUcOtr4FYI7P3qfrkymhcE3G+Ag3Di0kFKD2sXrBMOqEi7PmaRqQcOsB7e+BOufqHyu8xLK3fMEOO9ztRoUOBWjVI0+jvcxIrqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K25TqPh7z8AKTtPcUqryrp2c9om8IN8jQ14sMud28Oo=;
 b=HRNDNxGjrlYhu7ydklYlFlRFGxe81+PpznyAlbmzHUqekuvXmIRez9q79lAy7xMmYusG8UBHUOffGl/EO2ZST5qGbZwy1hiP1meF5LZ8KWJ7avxGeNJpJ7AqTgl3JyTjFDfqY5H3QtpqDjAwu9/huXLTaudBiKhXhgfwsNKrDA0u0HB4XwsU2TsH59qFzAG4Nac7FQY04U0G0f92N0ixIvvPoJUXeJgcDspufAcRlkX5CM/3XIx8LV1MSwA/jfirShzelklRkNi5j2P/AoZH3pPdRP4/qKt1fPdBCbxwd/6ljXBQwzWTSIcA/InLGZYeks4ir28mwwx14sI7EGU48A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by AM7PR04MB6902.eurprd04.prod.outlook.com (2603:10a6:20b:107::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 04:33:45 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0592.010; Fri, 6 Nov 2026
 04:33:44 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v2 0/4] software node: fix lookup of swnode in release path
Date: Fri, 06 Nov 2026 12:38:34 +0800
Message-Id: <20261106-swnode-race-v1-v2-0-f8bc7b14d578@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMpZ7WoC/3WNQQ7CIBREr9L8tRggtFpX3sN0QT+/FhOhgYo1D
 XeX1rXJbF4y82aFSMFShEu1QqBko/WugDxUgKN2d2LWFAbJZSMEVyy+nTfEgkZiSbC+HaRBbGu
 FZyijKdBgl114634cX/2DcN4sW2O0cfbhsz8msfX+yks4axVvdHMiWfd0dct0RP+ELuf8BROCJ
 DO8AAAA
X-Change-ID: 20261104-swnode-race-v1-b9f2dcc954c8
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
X-ClientProxiedBy: SI3PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:295::6) To AM8PR04MB7874.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: f2bb5ce5-4fb4-4644-e6d5-08df3bbf244d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|376014|23010399003|6133799003|10067099003|18002099003|56012099006|11063799006|261026121527099003|261026140227099003|261022105027099003|261028144727099003|261102123227099003|261021123027099003|261021121427099003|261009223027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	K5l0hEMRD6SBF0BtWkTdmuq2LuyZMyw3cj79MSCC81laAF5JwiobkwOw7udgzazxW1FiBpXfsZYLItNIiI6Xh/f2gtInvilOYNrvHMGo3mGXCb7OimALq+7JMC0up5ZKsaD10sQoMACrKBKTm5yDXGxIWEX3qbgQDvkRPH7pHE61tfnQiTGvt1tyTx11SZt8MEzCYURj/P32ZuMLuZXigSGF0Znc96atj4EG/+XaNfsiKuMaEct8dUFAJ56JxUKAjd+nuK82nkQHj7mgPTgGsYlPiaYP+ThvIjwf6q4Fo3MU5BILJEoICpEW2+j7Etar7wiPKsrLO6btHQfK0/VZV0pAULe4SxWUmtz8HsvQYkT8/Vc2UsuDh016E4M8NIZN8uhjVEWozcTj4FkCJmnV6f3CN+bENem9O/UiUJaKnY2VQ4YUXj0Bb4Gq2IWp3mT2Wgwho+V2diMkirh6tLii3PTcRzZWYzBNaDSiFerCH+IHE0AAQB3jyNGp1Rp/KpYP++lS6CTQxulcCK71jsRQ1ISkNq+nOrugalvT+xLsT2UYDCd+xCWyFZfPUGdigUsDHSxqVAyk4ujpHxRCgoZS6J+VIhFcx0Ax/KuXDjJCm3MrVGu8rre/U+sbaQvDOAEL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(376014)(23010399003)(6133799003)(10067099003)(18002099003)(56012099006)(11063799006)(261026121527099003)(261026140227099003)(261022105027099003)(261028144727099003)(261102123227099003)(261021123027099003)(261021121427099003)(261009223027099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VjQwN202SWUxeUZWMDlOejRuSWFWNWd6dU1TNUJKVThLNjJlTmRXcHpJRWtF?=
 =?utf-8?B?TnVTYTgrMHhQN1JtK20rQ25oOXFhY1dYdHRZM0FhN0YyZEJKOGw0WG9hSFNl?=
 =?utf-8?B?Z3JuTXJna2E4ck45R1VEMGdWRzF0Qmdmd3J5ZEplNlE5R0pJV2FKSFp1S0R1?=
 =?utf-8?B?ZFFuVTh3c3A1MjlUMXFWQ2lWZTRPU0JEOGxsN1ZUV2FlU2pOK0tQcUo4UGl5?=
 =?utf-8?B?bFlWS1JMNzRJVE5JNU5LUGUyZHcyUU1IdHZROHc5R2JnVDBES3JMYjJBWXlQ?=
 =?utf-8?B?VzdFd2lUUGJyWGsxSEZoVVBFKzRrUFVleFN3MDh6bGVudi8rOFRFZ0lXTlFB?=
 =?utf-8?B?ODRmVFRyTExVSXZHU0VTR09VWHNxVWN1SzRreWMvYkdLa2pMOXpBcXg4Si9t?=
 =?utf-8?B?cXF4R0lwWkhyVWdhekxYODdhNFppR2crVXVWTHhoZ0lwQ2cyOWtWS2FTVlBW?=
 =?utf-8?B?ZXEyY2JjNnc1empBVjVoMk5xTXJWWW9qYTR4SFREVFNuTnNyaEN3WXhEVEdu?=
 =?utf-8?B?Vnk1L0xHN1FWdUlpcXZEZEJUemdLeG8xdXFQN0JQM3lnOVJEUFNlaDQzZFFI?=
 =?utf-8?B?Q1ZkNXluTHJzOHRCMkVySjBqYlZjNGhNMjdNbWlOUHRuSjZNRzZZT2lKd2VY?=
 =?utf-8?B?T1pZam45cnhYb3VVbmprOFp3Tk1PaXhuZlBPd2ZFVzRhTFpuajVBWHh4UG5V?=
 =?utf-8?B?QzBFTWx0VUtlbkl4VC9DdmJYVjc0clk0S3dELzdVK0d4MUJWK2QrUnhYeG9B?=
 =?utf-8?B?UkNsK3RYNDhIVklTaTF6RXN3T2xFZGNXSTNUTERCSHFNK3NqdDRKSE9ZT3Jz?=
 =?utf-8?B?amVWSlozREovV1VMZ1U2WW1vSm1VdmNWbUsrREt0bkdzSDdRNDlKQWNpZElG?=
 =?utf-8?B?TGFVQWpETmtIMmk1RWJUVks5WThINGYzblN2WWRISkZHWERFR1NVWG5qQklV?=
 =?utf-8?B?eTFTMzNOSGhBZFVJYXg5bitMMCtRSXpDeWtmaVZkejlaYWdqSUM4MURyWjdh?=
 =?utf-8?B?Tk9zMncvaVc3NmRjVTMzcWp2SFpIVTZSYnd3OUZGc0kzVlhrZjlZSm54c3Rj?=
 =?utf-8?B?cUkwU2lRR2VEdXN2WjBFaW1ScXBkY3RoK1BjQlE1NXE0d1NIM0ovcldvMGNZ?=
 =?utf-8?B?MkZMWDl2MGZISld3MUIrazVmSFgxV3ovaW1uZzFiSnhLaVkxQzROZjVjT2pi?=
 =?utf-8?B?cXhxc2lTaWlacnhNamJEbTZGdUQxbmpjWHV5VWI0TSs3dDRpczA1SlErMFhT?=
 =?utf-8?B?T1BJN0tIT1IwM2JndTI1S2tFM2ZsUGZvbnd0UTdWeDBHSnQrT2k5RE51cTRl?=
 =?utf-8?B?L0hENEJIZHExNlBkMTZlK3hjdkFadXZPblRNc3pOaGVHSXNuTG56WE5GYytm?=
 =?utf-8?B?SDZTYmVMdmp4RmVyUnh5YmJ0Ylp5VW9GNXU2OTdLN0VkQnk5VDduT0pVMlB2?=
 =?utf-8?B?OUx4b0R5YmplZ0x1U1lsTHVlL0d1NHNoZmNDa1RMTm02L2xFM1g5T1ZRU04y?=
 =?utf-8?B?V3JTb2NTK2VRN29FKzJUb0tpRUpzY3ZmUVlBZVhNSktlQlJVK0hXdjNvdnV3?=
 =?utf-8?B?VTFMQmhpWXI5VHQ5M2V5UVlFRkxsWDdtWGlWcnV0V3dudER0cUNMUjVNWlVw?=
 =?utf-8?B?UU5IOE5HbTFoUVBXN21kcW8vRTl4d2dwS0U4NUliTFFtdjkxb2FLVm9QdU1a?=
 =?utf-8?B?TVI1QWZjdWU4b0VLK2hZaWRJbzYrRjZ2RHQ4YlBEOVlTUzZ5MU52SHNSU2NF?=
 =?utf-8?B?Unc0cUk4ZEJJUEZHTnFkRVlSYkpzb1Vuc2E0RGJtK2xybVFpaVd6U0ZPS04x?=
 =?utf-8?B?NjZVSFdrS0ZMTlFqaUJoeU54Z056NHFEWFBSS1E1cExwZ251Y2dZWFFPa21K?=
 =?utf-8?B?UEZ1Q2c1cVhEVUFTc1FyemlsdEMyWk4vd1V1Zmk2UkFMcTFQRlpIZ3E1Zzdu?=
 =?utf-8?B?Vk9QVzdoVVdlM05FczF3WFRhM0lPS3QvK2xrdkkxWlFRQ21jQStRWmVCeGZU?=
 =?utf-8?B?MWRlSThXMmxldnlYQmlUZE5Oby9QcU9TcURMYjNGYmFzT055aWxtbFJ4UWUv?=
 =?utf-8?B?VGpXMnJ5aEh2SFlweE9tODMzQTVUcCtwRzVvcHV2RTVZNUE5YVR6QlVSM1pl?=
 =?utf-8?B?ZG05WlRDdWE2NE5xUlBCeGg5THBqdHRZU1V0S0ZjVXpENzBPd3JwdW51V0J0?=
 =?utf-8?B?c0FpVW53Q2FxQmhFd3hvV0RKM2VreGVGemJXb2U4VnJIeUllNlVyOTBGVEVC?=
 =?utf-8?B?YWRHMlBiNXdCcHBzVndsWVdJVm94OEpyeWtYaHQ2WG12dzBobVM3cFg2dUNn?=
 =?utf-8?B?SGJiVmtPQ1pVYVYwQmViSGE0WllCakRDeFlKREFweFRTbUNRdUpXVk5rMUZO?=
 =?utf-8?Q?FZmBP/gFEOpuGO4zjFJQAfAM1ZyTCY8e24oaW?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2bb5ce5-4fb4-4644-e6d5-08df3bbf244d
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 04:33:44.7821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TSx+KRrXaxZJU3Zlb4kQ9Ob64lvGzgyygSoLWcjt6NPzRtFDh2Q945BrllZAeH+LfkVboU45faHaLRtA1K0GfUENomc36A1VCAEAQonSXLvREX4cF+Z33DCZmjbYZxJa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6902

This series fixes a software node lifetime bug where a lookup can find an
swnode whose kobject refcount has already reached zero.

The kset list keeps an swnode linked until kobject_cleanup() calls
kobj_kset_leave(), which happens after the last kobject_put() has already
dropped the refcount to zero. A lookup that does not check whether the
object is still referenceable can therefore call kobject_get() on a dead
object, triggering:

  refcount_t: addition on 0; use-after-free
  refcount_t: saturated; leaking memory
  refcount_t: underflow; use-after-free

The problem is easily reproduced on i.MX95 with dwc3-imx when
dwc3_core_probe() returns -EPROBE_DEFER. dwc3_imx_probe() removes its
static software node from the device and the deferred probe retry
immediately adds the same node again. With
CONFIG_DEBUG_KOBJECT_RELEASE the old swnode stays on the kset list for
some time after its refcount reaches zero, so the retry reliably finds
it.

The first patch fixes the pointer-based kset lookup by using
kobject_get_unless_zero() and skipping entries that are already in their
release path. It also makes registration return the newly created swnode
reference so that device_add_software_node() does not have to look the
node up again after registering it. Reference-owning callers get a
reference from the lookup, while software_node_fwnode() keeps its
borrowed-pointer semantics by dropping the temporary lookup reference.

The remaining patches harden related weak lookups for the same class of
problem. The series is organized as follows:

  1. Fix the pointer-based kset lookup and avoid the second lookup after
     registration.
  2. Harden software_node_find_by_name() against dying entries.
  3. Check the result of software_node_fwnode() in the graph
     remote-endpoint path.
  4. Skip dying children when walking the parent's children list.

Immediate re-registration of named software nodes, or parent/child groups,
can still fail with `-EEXIST` while the previous release is pending.
This series targets unnamed static nodes such as `dwc3_imx_swnode`.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v2:
- patch 1:
  - Added `swnode_get_unless_zero()` and used it in the pointer-based lookup.
  - Corrected the commit message: `software_node_unregister()` uses the
    borrowed-pointer variant, not the reference-returning variant.
  - No other change to the core reference model.
- patch 2:
  - No longer dereferences `swnode->node` before taking a reference.
  - Matches using the swnode kobject name and parent link.
  - Added a `named` bit to `struct swnode`, set from `node->name`.
  - Takes the reference only after a match is found.
  - Corrected the Fixes tag:
- patch 3: new
- patch 4:
  - Replaced the borrowed `software_node_fwnode()` plus later
  `software_node_get()` sequence.
  - Uses `software_node_to_swnode_get()` directly and returns
  `&remote->fwnode`, retaining the acquired reference.
- Link to v1: https://patch.msgid.link/20261104-swnode-race-v1-v1-0-9406a67e25be@nxp.com

---
Peng Fan (4):
      software node: do not resurrect swnode being released
      software node: use kobject_get_unless_zero() in software_node_find_by_name()
      software node: pin referenced swnodes while resolving them
      software node: pin remote endpoint swnode

 drivers/base/swnode.c | 209 +++++++++++++++++++++++++++++++++++---------------
 1 file changed, 148 insertions(+), 61 deletions(-)
---
base-commit: 2637bdec0535a2044cd830eba9a79363651d9043
change-id: 20261104-swnode-race-v1-b9f2dcc954c8

Best regards,
--  
Peng Fan <peng.fan@nxp.com>

