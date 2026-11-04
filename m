Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.21
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793806725;
	b=P+g7D+ImSKZbnZkGspm76Ax+0/WfNhmiQTtI3pHOQuxq0Jdrx5GQ32wcghAmV1hP1SeJ
	 a91S7wW24jsSTwvnfHP5EqBvH2qi9qjycl6tcwIEB1QX3Ee59S83i1J2qFUZGMv7xxArP
	 kICOyx24F1Fp0l/AfzWjL4/sOWXUUzyTegayzoKEgZh5as3NqlquaWYcu6dgekUf0y8hf
	 UwVMN6biz0RB05Rc0UpV0s7W+FE5lPVPvMJUl8RQh2stgySPm81W+w/ML02GJuvBHJeFW
	 QuAuFr8xYQVCMkZa4Jnp+odeU5cQTLxjfBOxyKKlnos0vgKZRvGMA6YQvr1QBJTVetw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793806725;
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
	bh=wgzSA2+/TJ2WiziLG5sKH2RTbP2dtAihULwP949zmZc=;
	b=NIvpFXDxAtL3zTMUpX70HtLqgBFFwwOsEGLv3DCJzqk+spJFkyaP3Trp3a6Qnmo1tTai
	 bRwLMYrk6C+oYm9TcCirz4gJZltTPN2s5ZbwYqztXBo6YZS/Ik8GlnRNfRXsbWh4eLlz3
	 XOZ7X7uPqbkfimJjMyctayt96a9dedYWZwge/XGzBC4BgYNuu6v8rxL5uqZt3Avu9SAl3
	 NNwNvx/w5kHSmj8OTHrWY7stlI91fvIQ9CnWSwoGOzUKEEsvC4ZJDI/PzJ6P47SWgXc6A
	 ko3BW/nRdgpV+9YzGSKuNrOp3bVyGrL566tCbr38/rhSSoptlXxvd2fGzp99gbN84QA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=SM0fGshr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.21
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013021.outbound.protection.outlook.com [40.107.159.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CFE6083611;
	Wed,  4 Nov 2026 15:38:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02CFE6083611
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=SM0fGshr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yh/TKXpMchh8wjxvQmopJc1CS3XD2E1SgLKY8zWPuKtbMCo7KaUQjfPzl79J/WuJhDS73R/eCfDk4efxmx4cJDL2i5IisRFTwCchlnCL0fPMDGPDY28Z9W0hFbzDCdf/kMFTVWXjfYSgWdC8NF8yo2D0uNw3ksMiGZCzti+poRjTlujQuy9XzxyIuN9rEjZzzyrAsh88a7CUzi2s2lDkjvO9Ivx/Y+84txEOT0zZcEigaJ4DjTCucl4h3g5vzVL83EFS6XuN0mlqZxImhctnSY/4jVvYOkuGPLTBaT1zyMvIlcDxWbcU66Q40RTeaDCUsBoRFr8k+CR2FR1k+6pM6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wgzSA2+/TJ2WiziLG5sKH2RTbP2dtAihULwP949zmZc=;
 b=khsxxqAesdgYp8dujKEg4H/bblJLRRbOZWDbSLlBYijee0dMdFhhc/Lwlu4lRBNefZ/u3f9Lap0sjn3s70iCUvJE4546BrsfKrdbgfKomg/s31aBnstzfV3GLr9yw5IB0r6td1aTiPyLB9SeLGfDzZLYzh4z8GF3JhznfyjJhXbqaCw8wz0quU7S9tPybcpssGGK3A5Q/pWZerfCzvhc25l0WAlLgNA6LtB7ZZg+VB3GR6oDUpsbNTs80s5JO50Hb4XTdxF6H2b3iRjMsSzIi7kFrLB7IrgKceRh9Kyd23EWJ1Fbv31yS9dvvyITm8j/jRIYJoaGLwqbXACQDKyXnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wgzSA2+/TJ2WiziLG5sKH2RTbP2dtAihULwP949zmZc=;
 b=SM0fGshrZaLh3oYMWxpmpwGm6a5K/Zuql8ttAdvEoYfH5xzJMaQbYwHffu0uW+psqQUeoKlCWUTsh6oF6fiUIx9nDy579gA6URPZVZ8JI6G36r7AcsZxSK/Rxu03CDx0s4Pjveoxi0AqUQZXVAjs83X26Q6g2gxXWu199PWD6v9wOAelFh65Y8ObbmNOchmgmIKEM1o+HW4aABHNRnnlhD/ipTap0fgb0H9ZSmqjnL/C6O4ivVYPncyoEcuUy8Vp8n/zM9QYoMEWinb9b6I+EY3hjnk99rJfXVP9s5VVBq0rUzBiaKtlc3eWNnIMtNhjoCwSEPjKsOvXgJiinNlVow==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by DBBPR04MB7564.eurprd04.prod.outlook.com (2603:10a6:10:1f7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 15:38:42 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 15:38:42 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 04 Nov 2026 23:43:14 +0800
Subject: [PATCH 2/4] software node: use kobject_get_unless_zero() in
 software_node_find_by_name()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-swnode-race-v1-v1-2-9406a67e25be@nxp.com>
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
X-ClientProxiedBy: SI3PR03CA0003.apcprd03.prod.outlook.com
 (2603:1096:4:297::13) To AM8PR04MB7874.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 8fc68344-c809-421d-79a2-08df3a89b422
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|7416014|376014|23010399003|1800799024|10067099003|18002099003|22082099003|56012099006|11063799006|261102123227099003|261021123027099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	bBUdefT1fcak0eSpVj1TLjB+1Z7ky6ygXcN72/A1pe2LQ/o6P1IBqFzIi+xJGd775w0o7aKO/uqAAyCyV4U+5/IyjU22XiVYN8vDkwy2HCw3LJOrkPiUr7XQwQnjGnmDnrNjR59hEYpPqwnK5gX9mxVYZ/cZXqQwI0UIQ4+gMwFDwBkxHPspBZVRXQo4IrUFfZD8pjX5TavStXHbKu8wEL7Sd1nvvgCQxG8YWv4zp/AtNZZ9rpSLwbn6qVgdBvip0LHwMxTD4ysbWNj2UzzchGVweOwVQ82RMNnWBVkIQ3grRosi2J7keGQ5bl3CIhjzBzY8Dii36EUYM2xSgmEJGFGzDvb9LThJMBliFtU5xOhsTVAajE8kC0W/hgbpbywf0upLmNpIz5eL+yMRs4D+vvIaGwcKgPy2H1aho4AqJNJnMksZUHvKNeKRzVTikI7phLCR+G5ehCfaeh6HgUmh4ZqoMoHvyS4RQ9VPmVGPxiu0f/jgnNrMhpQYVD12jfnFG7FoIDIAydGyehX8wq94F7Xj9caLSXtQ9ftBuWbh5oOVZLErmplRNi2acCz41NCmu0L+EdEOB7DDJ1kSUy5lBACuXcPSsJ56/RWsk4oPl3O4gpKq9KJYeU9l2TLf+aomDiqg41vNlfQ9WVzZqw47/0iKFMCvYP+4O+4rOYJdE7k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(376014)(23010399003)(1800799024)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006)(261102123227099003)(261021123027099003)(261021121427099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGd3bzR6Sm50azZCcTlCVnRNR3E2elY2UVJEcStXcmkyTk5UY0pHVG9lUyt5?=
 =?utf-8?B?S0JNZmZacmFoZ05lYVNwbUdtUWpIQk5aY2N4OEFhQXlOcnd3RUpvTk1tUHEx?=
 =?utf-8?B?bmtPdW5pUVE0TTNYRUtaNVBtTWU4RG0rUkxHZUJPK0JlcjVwOUk1RGpSdEJH?=
 =?utf-8?B?eWlXV3VpRm5HQ2FtVTJGR1pGSms2cTdpWWJYWHppclRPT24vTkJiSHcyeStv?=
 =?utf-8?B?ZkVpQ3lnTVFOK2xmT2VtUGhab3lOK285eGRtMGVvaVB5TTVIUDQvTEMzSFR2?=
 =?utf-8?B?ajVSbWxnYXRONGdHNSt4czVSejJHaGkyR0xnR3dXSEdWYXp0UVlQME8wb2Uv?=
 =?utf-8?B?OHJVQjBsT3QvaXhTcmZQZzZtMzNUL2NFcmpYeTI5VjQvV3lqTDVITmhUbFFP?=
 =?utf-8?B?S3NXRlFEemxkZm9nU2VwOFpCajZscnRWTWRQK3NqSGJIQzJ3V3BWdU1NZEpU?=
 =?utf-8?B?WFlvSjBMRERobTJESG1SVWozMWk2Z05aM245U0RNdUlQTG5saUpwS2JQS2dH?=
 =?utf-8?B?cjhoUmxFbWsxaUZiYytSUUlJMFVaSVBLR20yQjFoV0Y3cm4valQrMC9GYTR1?=
 =?utf-8?B?aWJrcXh4blJiZGwxS2RmcVB5dWFzL0ZaOU9jclgrandYeXdDcG5VeVd2VWxE?=
 =?utf-8?B?bFpRbTQ2Y1lkWENTcFp1Q01jQi96Skd2MitTMldaUWtFUklOWkFKNGxxMmph?=
 =?utf-8?B?VFlFamVQbkI1UkE2T0ltM1lEeGhrR1hhTXhpRHZmS1Q2bTA2VmMrNlllODRS?=
 =?utf-8?B?cnRkQkVaS2w2U0lBVnlwYmhWOWhiNFkxU29kSW14UFZsRlI5a1M2TnNJMDF0?=
 =?utf-8?B?WHQ0RDRMYysrN21NeHhWb2E1N1BNZk9EK0tMNmR4eVJkaThiZTNkTzRZaVNU?=
 =?utf-8?B?d1pWU201YVpxWjl5S2N3L1dPWlZWdmxSUWZvSG1SSDZvWHY5djRVNjBEb3hZ?=
 =?utf-8?B?VDBEVWFIdllwd2U2a2tpNUJpdi9BZUV5cWh3VE1jM1Q3R2FSVTJaWk1HLzM4?=
 =?utf-8?B?dXVXOHA4bDd2VTdCRW55bnVVY2NtK3FaaE9EdHVST1A5bCsyQ1RDYkMwT25h?=
 =?utf-8?B?ays2SFFxRHY0bGtoRTc1VEtmYU5pODF0RE9EbDBNdHI5Vlc0eld1dGNJbHBr?=
 =?utf-8?B?UXMxc0xva1RoZDdhWGRqZktSWDhoR3pwei9ZMUk4a3A2ZUVCTWMvVzRkenR1?=
 =?utf-8?B?M3FZbkR1NllOM0JNVjZiUC84QnUreFhSZHBMN3dCeGJnazVnOEZoSUV5MkJT?=
 =?utf-8?B?Z29PUWpJS3ljZ2RqcVlJb2c2U245cENPQ2ZMV25CRklveGw0c2tSZDVQUExU?=
 =?utf-8?B?YVdsNEJZa1N1UnJZVU1UN2YxdHgrK1R3ZGk0Y2xhZVpGVFN6MCtaM0Z5RzEw?=
 =?utf-8?B?YVBMWjBKSUJoQml2NGtBWCtJTW5QS25UNHdHY3V1SG80VnRSMWJhRjNwNmpw?=
 =?utf-8?B?bHVjU0JkVTRhQm9xcWYxc2VxR1dEVFlObFA4dWZmN2FjdU1IcE40VnZiQ3RP?=
 =?utf-8?B?Y3duRGdPMHRsUmo3dzZDQ1kySTh1Z2NxTXBYdFBSdEhCUHQrR1JtNjFEbGtp?=
 =?utf-8?B?K0c1T2g1ZkZINnEvVGVGRVRXVG9ZdElCeVRFbnVKSitaZFlIZVBYZzJ4TERR?=
 =?utf-8?B?Z0JRYUdub1FKeFN3SVNxbWkxa0g4SWFBaHIzRmVHc2lmYnEzRUNEd0F4UVlp?=
 =?utf-8?B?SXVTK081RVRSZjEvdEQ0d215bzBDL3phV2tXamsxT2RQelJueFh6SjduQUtl?=
 =?utf-8?B?L3ZTdGpucWkycHhiM0xOT1pFeWpaVXlLeVEyR2Z6bWlhTXFSZStScGZ1QmVL?=
 =?utf-8?B?NE1xamVDMHpQNXZoc0VndDl0VjJCemN6dFFIb3NGWStzVXFkYVNQRXBMb0gy?=
 =?utf-8?B?Vk9NYTNrZHBySElHT1Q4eFloNDd1M2xYbHYybFVvbWxzclFJS1lnM21Ob3Bv?=
 =?utf-8?B?SGRKc2V0UXI3cFZ4azdQam8rek05VlQzeTZVQkdScVdYays4Z3R0MkpKdlVC?=
 =?utf-8?B?Ykw3SnMzS2lnWStsaDJMaldLUDIrNTBlNFI0Rm8zZ2JFWEg4eldmTmR4YTZi?=
 =?utf-8?B?bHlKTUMvbnJxeW5nbi9tV1ZpLzJLUVlMZ1E5U0xJeEdJbzlnTHNyODczOWU0?=
 =?utf-8?B?dWlSZjA2QlpJWGNEdXB3Y2NpMFpHTmVydklDVHc1L1pLUVJTR295Q0REZWt3?=
 =?utf-8?B?Zk0zMUVQSm1lY1hMb1NZMVhVbG1idXhINXZPSGd4VzFneWE5RnRLNjRJVS9p?=
 =?utf-8?B?c3crMnRmVm10NW5PVk1DKzhTWlYxd2xSS0VRUFFnR3lzWHNVNTNDZXM1dG1D?=
 =?utf-8?B?NXIzVmpjbU1iYVlRUFF6OXY5WE0wT1VMQWk0Z1d6NkJtVmlyMzhYbkROWisr?=
 =?utf-8?Q?dHpM5IfFZMf/H4qnBOjh1FArGc6imQC+z05W9?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fc68344-c809-421d-79a2-08df3a89b422
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 15:38:42.0214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Y3bI/tWX52hjrcLWNudnUDnCajxwUqA+ssB+fefTvzrxsVvL5/hK8lYHLIuLNBZar91sZfys7SofgTw+YHtDXvtYZg3yt7ZShRhA1Z+l27iVYPfR6jSmdJ9+gnLNYWO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7564

From: Peng Fan <peng.fan@nxp.com>

software_node_find_by_name() also walks the swnode kset list and takes a
reference with swnode_get(). Like the pointer-based lookup, it can
encounter an entry whose refcount has already reached zero but which is
still linked until its delayed release callback runs.

Use kobject_get_unless_zero() and continue scanning when the entry is
already dying.

Fixes: 80488a6b1d3c ("software node: Add support for static node descriptors")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/base/swnode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 19a4153f3fac1..9095d50ba146f 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -831,8 +831,8 @@ software_node_find_by_name(const struct software_node *parent, const char *name)
 		swnode = kobj_to_swnode(k);
 		if (parent == swnode->node->parent && swnode->node->name &&
 		    !strcmp(name, swnode->node->name)) {
-			swnode_get(swnode);
-			break;
+			if (kobject_get_unless_zero(k))
+				break;
 		}
 		swnode = NULL;
 	}

-- 
2.34.1

