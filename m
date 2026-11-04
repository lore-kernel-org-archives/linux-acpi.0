Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.57
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793806737;
	b=DzVjPBRv5i1/jeOaBhbdyEfzv2+M9hLX0qTTU36SUjZBhaaSL4JU+O8PUcKyqF7uiQbe
	 yZIvZ3no9ut/TNEHK7QWuzFG7ObpgNoT1c4z2+HVCc8XZ126wXzPtOoQ1LTZRIW5h0UD5
	 ysXTlFuqu35TY7PLIKwnuVnO76YP7D+w9qmj/JFqCwgEKrESTWxCQUQONfr3UMPx5y358
	 NU4FwTYXJVoTAAiChq+iWjgJHCJ8+209rkT0LZW0nYE6UkxV9O+IH/oxsuJexjDt526eu
	 rU/k3EbYH3d2iBrtuqfDUEAqG7hwpfxXSRFIO6DaIBwAPlDy0YOZR4yCOKGJ94PYJDw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793806737;
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
	bh=NNAz+1hEr67PeLtPRXXLOLc27j+aONXqEV/TdCQjQs8=;
	b=CBO3zHlhnNlmSOl+o+uzFdPXiC4JBbhypSnTAN0KqbUPuLvCgx5iJjsfnD9kZbuCibaH
	 pMSGbptqCiDS/BWHbFXs2jscOBty2v2pKM6k+ldk2Xm4AFeGPNruCg3aHfMyOOSo2Mezb
	 9ik059dc4q+4dcWXNmQ6SX44/8xS+YDsevZXKrsH8Yw6EJH5SwJKpbxDGV/SURhcDsDhY
	 4ib0gV/9JIOPw1fDalh1bssSZ4Ea4zECzP4GytPjox9DDfsKxnjvQiDFbJUitLBwKz7n6
	 JQKS/mOhQOg80j7DweRByTR9XBgVM137s6AwpebeYp2tNq05DrLBVzYJB02xnHBYXxQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Uhk1wDY5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.57
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013057.outbound.protection.outlook.com [40.107.159.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7DD60A2619;
	Wed,  4 Nov 2026 15:38:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC7DD60A2619
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Uhk1wDY5
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XjrgDZl2uwRhOxsQfcDLQZajRVbbIgzwMkKXbEKglWW6KwGk+1kIihzqcVq9DgpD98AH3rOWIVs6Qn8JqTuUvam9yeHVrU3sj8V1eY1rxWTFEkvT0ItFOHWDW4gJQOTEU1BMJBDrCe39U8A+svsPdCaTGwTGN+mnaEypEHfXvRUWUqfFn1uusCyqAUw3Nnxmfmu9h2bXVjaK34FOEgEKCf8nWfvT/j45y7+8jsdD4kaG1skGMxmkXOxERGPgalN8FKEydiH5skMOBLjkrZ3IUlofix9Bw0OyW3F6VUwvEeOM5kajOXX1ky4TBlLFZCHMzlPyu+4KVXsLJJRasi9UTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NNAz+1hEr67PeLtPRXXLOLc27j+aONXqEV/TdCQjQs8=;
 b=R05wlGNrWwFy/b0+bjAHC0nIaoicEyQ2EnlSbGtejosKqvY/TJAZwJXFAu7zF7OmimIdkUl098SwNBxmDMWLK/zu8gdiHlaEThqLNGp19STwhbUV40+RbIuG2h6Ncx7bcIyTZPDb3LzX3UtsPMerQ0t4l03M1bgyCKnW4rPtiDzjlrvRzK738kmZNhu2vMYCq878bgUqSTmGFBlpZQbP+HqB+7pGuoPtAXBoUUrsKPTyKXFrfY/Pmpzv2Q3vHDqbWqZXm4TDx38zUkOes4btjbYn96STjwj5RMfuDnIvU9sfp1LmlQMlw5QUc88BC9nlY9EMSPe6/+9dfTJhKepEXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NNAz+1hEr67PeLtPRXXLOLc27j+aONXqEV/TdCQjQs8=;
 b=Uhk1wDY5vSHZDuvGNr4+ANZWuPa6/JnJx+GOs1PpA93bpcFxZJzVAuCFtCeXk9UC4FQk8jiwBynicdcv9K3xJZt/UJMLz/rJ02YBQllb5LS4LviWXsj/PoGepxeZ+5zOscllT1DMzllsLqeHTf4dru1g9ScFeOs67rYnaJ868S09kZT3QRAFHqBaNTpe2EdyjZJi/BZap0sEYafd7gX1iCicNGrKh2kL0fQWalZuYYy49dqBMOwrxIhKLIZnLWQ1vqpbFTnMwqUMEeVmv0h2N5dOLPUkQNXkfHMKi1hJrzWkVSw38+yfF2ImzzPenqhuK1VMjrzORogGrz/kWROTMw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by DBBPR04MB7564.eurprd04.prod.outlook.com (2603:10a6:10:1f7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 15:38:54 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 15:38:53 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 04 Nov 2026 23:43:16 +0800
Subject: [PATCH 4/4] software node: skip dying children during traversal
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-swnode-race-v1-v1-4-9406a67e25be@nxp.com>
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
X-ClientProxiedBy: SI2PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:196::7) To AM8PR04MB7874.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 67ce8aac-77cf-4f16-07a6-08df3a89bb4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|7416014|376014|23010399003|1800799024|10067099003|18002099003|22082099003|56012099006|11063799006|261102123227099003|261021123027099003|261021121427099003|261009223027099003|260925021311599003|260925022911599003|260925021911599003;
X-Microsoft-Antispam-Message-Info:
	Uxi0MB8V7kwI88yTRJuIUpwNmPqsyWGqHyQQg4+YUKIGOAkuEzDAfCPAp7zV+m2uqQmLMc6YDAKz0GTvd+aByTYFWRXhQtAeiV+G3MtEI2HjU5q5wvCTzZP4hWJ/DSa6xdvwhLC3aYhV7Lo2X/hU1jYY2BtEf2KnTyLjLoSVzXs1K62o1GWC7AV09xGC20ucs58SFe+IkmBp4O9S1xkvxbSoE155EuAZ8Mgq1NufFtEZbUqzX5oNYYJXqZKUMq1he8YMUetTN0GCi1mlOvrZdNhpyi0zPQIrVrmROZ30b7vCABGUaHXZhXIYIn9ywEC+ChqhWxbKVKAc/l1t1xR7guKT3HhmR8+a+oHAVUzFqIGUMuCGKKtqhw/3Tq8LeFm9ynf8XGTkBNypxX5idxLj8V+7dP4T5D1aAsOJot6lteI8W00rtdh0kGP8bowTS2Fmhb/VcLzGJpURp4upKv4DWaM7zKU7iC2YVysQVRP7TcpbyAc3WxS5BvW5PxF3sg9lWduNCgg2k7CPf2igmGXnOq0ndOW46tXR4HLqKhh9r6qy6A3Z5V1gSMtHUmHz+muWaPSsmO/qFQbwSMrQfDmTUd+zmm4PLgNEX+lmcRRJdaiKSSFdYjOeqKjKcwZ1sFXhomfFY9XIpx8tSKdngnjOU0ZTC5gXBl3s6sZ6nmf/TWw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(376014)(23010399003)(1800799024)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006)(261102123227099003)(261021123027099003)(261021121427099003)(261009223027099003)(260925021311599003)(260925022911599003)(260925021911599003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SG9HcnJJZFM1ODdHWDh0bnR4Y0laOWU0L1RDdStNTWg1MnBZenl1RVJYQnNG?=
 =?utf-8?B?ZGh6Y1lDWkJ6RnV6NmRma0U1ZVZBZ05RVGFZNFhVSkNhTEllNEZpaTZHL2RI?=
 =?utf-8?B?Qlcvczg1ZGg5UnFLWUR5U2tWUGpDN1RwRXlvYXhoQzFQQ25IM3ZSUHBCNFdk?=
 =?utf-8?B?cTI2c21ncGxuRzRkUjhLOUlzaW9HcGRvWHFUU3c2Q2sxQlUybTZmUG1IU3or?=
 =?utf-8?B?S0ZKN2JXS3lneG1lSFlra3ljemo1cWxvbmh2czhzTUJVYVhxVnAxT3czNFhV?=
 =?utf-8?B?S2tQVWhoNTUrSWlhODFVTnRFNW5UbkpBdXlRWDBiN2JjOTVpaTRjZ1A0cVov?=
 =?utf-8?B?Q3N2WGlzRWlQSWZnc3ZNekhNNWZtUGRSZDFCeWV5WkhySjVGOEk5KzBOUGM2?=
 =?utf-8?B?V211ZjZsalVwQUJPbXhSbFdub0kzK3VDWjJCYkFjOHYwUEhiSHpHTGwrSDQy?=
 =?utf-8?B?ak1BdXJnM0g4Ulk2Qm0zeElJR0EycUNmK3o1UXFpUTNiemJxTlZ0em5LeXUz?=
 =?utf-8?B?Y2hmNUhwUFJkVXdNdGQ3UXl1SDl2NjhZM1pwdFVrZHNNZUR2UUxLYXRXdzds?=
 =?utf-8?B?OURjenZBdGhXSkNQNTNhTFRONGpGUDF3SitHM25vTTREdSs5L3UxcTJzaUZN?=
 =?utf-8?B?bU5OTFNvc3c5K3VQZFpCOGRXMGx2cndUQjVlYWZjT3V2cTZ2WWFHQmd3cHlF?=
 =?utf-8?B?TWMrWUsydE9xRDNDTmtzYWxnbU5TcUx2WE5SNkx2a1JoNHBXaXdXeUdzVzBr?=
 =?utf-8?B?OXUyUUp2VStSWWNEajJKUGRWMlVoL0IwakJUT3BuYlRsbU5iMDhlUk9QckVI?=
 =?utf-8?B?bnJtNHAvOVBDZXI1S096VHRyQTQzNmxXUzc2SkFsMmhpcFRzSldxRE1yb0Zj?=
 =?utf-8?B?aXZveXVRQWU0SUoxcitORHA3WWorNzVCN2NHRXZ3eXdJeDVpandyaHZWVDc1?=
 =?utf-8?B?QnlxQkF6SGp0ZlkvMVJUOXg5RWZzeG15cWgvZ1VYdmZJd1FiWmZ3cnUrZ0ZE?=
 =?utf-8?B?dmxQeGFHaXYyWEVxL0pHVFNxQVRmMDdWaUlROXdiZFlyVkd0SGc0K0wyTy9x?=
 =?utf-8?B?WE5TMmZMWk9IOGg2b1lYRVhyNHJYak0xR0RheGpsbDl6WU1iNG9HQ1grQXVZ?=
 =?utf-8?B?cEhRVC9TcE5IamRFZkovSVFKd0l2YkEwcWo5eGNnVS91U2dGM2hiUkQvT2Vs?=
 =?utf-8?B?YVp4dVJBcEgzOE90Y2Z1YzVjaDZtU1VZc0Faa1VXZENjMWxoZmdSa1lBekVH?=
 =?utf-8?B?VlhqbXdDOXpycWp4YlM2RE9Bd2FHNzVBSXZmbEFDM0RwZUplRWJDSjFneWdl?=
 =?utf-8?B?RmhQd3ZlNENBeTJ0L2U3Tnp5Tm56WktSZEJEeGJSQ0V5R0dYai9PMXlhNU9i?=
 =?utf-8?B?N3VPdlMzZU04TXB1S3pHL085Um1FSjg0d1BhMHNZYVZFd3JuZEtwWUhNZDA5?=
 =?utf-8?B?ZnphQ211R01tbHlKc0NUUElVemZvT05BdFE1emZ6V3U0SGFlaGw4dTZNUjZp?=
 =?utf-8?B?NERlUkpaNkI4SXBWcFdrVTdPeUorODcybWZsejRmNE41NDU1Z0ZDMTdJYmJj?=
 =?utf-8?B?T0QxTmFuS1V6cE96QzJveU1lTVU1Yy9OYTB0OFY1M2pUQ2hxa2VFSi9manRE?=
 =?utf-8?B?YzEvMStzRlNlb1ZtTDhkTEFva1pDMSt3WkI1RFU0K3N5aVhGclJHamtJbTZE?=
 =?utf-8?B?MnFqSGEvOTRleXRockNURXpTUVJ2TDc3NEFrRStaR0tJWkJ1N1hDYzIvV216?=
 =?utf-8?B?dEsvV28wS09oUUdEUzJlYnZmeW9DNGlzMmJqVUErc3NKelhiellqQVhmdVN2?=
 =?utf-8?B?UUhYN0R3VHN3ZXhCQUxpL1BKYUR2VWhvTEVyNm9FOGQ0QnNsRGVNVjFuYmhJ?=
 =?utf-8?B?VjFsd2ZhRlNSTUxXMmRJUUdXMjFUNkxrTmkrSFluSS94UWpzRDVTUmREV0Ja?=
 =?utf-8?B?RHdWY2h0azVsZ0tXc2pOUGNKV1Azanh5MlJQVkZZNzFXMHNOZlFxajE0N2Zj?=
 =?utf-8?B?bk9vWFUxUjk2UEVKeU5BZURhb09zZ0RXejJmWm40cSt3L3lSaS9VZzg1UldB?=
 =?utf-8?B?TEwxWnJ6YlozTkZFZWhEVW5Eekg2czlTcUtDVmk4SWhnY1daMitxYUNjZE1C?=
 =?utf-8?B?bWpoVUpvSHkwWE9QTlFQdmhaOVpMZ2JGNUk3NXRIUzR3T0pOSU1paitkTUtU?=
 =?utf-8?B?RE5WbzJYUktUK0Iyak5xNnk5RWJxVGZFRG1qRFFwaXNiZ1dzNit6ME9mWUl6?=
 =?utf-8?B?R0FjMzg4cXJJdjJRZzhkY0UyWkY2VEF1ZXBtc2NWczZuUVdvcU5EaE5PTkpU?=
 =?utf-8?B?b2ZBKytKSkg3TW5XWE5iTmJwUDU5S3BncVh5andJaUs2ZWN1QTBLRHk0aU1Y?=
 =?utf-8?Q?u+YAUuCSUykhf3SfM91P+vFmO2wIYdUe9LHeY?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67ce8aac-77cf-4f16-07a6-08df3a89bb4c
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 15:38:53.9498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SXyotE0mOmylrKC59XNB7H0cGQ9yZ2f4Zf8csrCramBFOaArhxFRrFtlhFli1PmVfPItSK/nUuWBql7bWgzc/l9OXGiiiGC2zeahRWiwkuVkW9CV5w9PCRtm2FD/6Neh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7564

From: Peng Fan <peng.fan@nxp.com>

A child swnode is removed from its parent's children list in
software_node_release(), which runs after its kobject refcount has
already reached zero. The fwnode child traversal helpers can therefore
find an entry that is in its release path and call kobject_get() on a
zero refcount.

Use kobject_get_unless_zero() in software_node_get_next_child() and
software_node_get_named_child_node() and keep scanning until a live
child is found or the list ends.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/base/swnode.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 4d95a59a27f0a..1354447069e10 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -515,7 +515,18 @@ software_node_get_next_child(const struct fwnode_handle *fwnode,
 		c = list_first_entry(&p->children, struct swnode, entry);
 
 	fwnode_handle_put(child);
-	return fwnode_handle_get(&c->fwnode);
+
+	for (;;) {
+		if (kobject_get_unless_zero(&c->kobj))
+			return &c->fwnode;
+
+		if (list_is_last(&c->entry, &p->children))
+			break;
+
+		c = list_next_entry(c, entry);
+	}
+
+	return NULL;
 }
 
 static struct fwnode_handle *
@@ -529,10 +540,9 @@ software_node_get_named_child_node(const struct fwnode_handle *fwnode,
 		return NULL;
 
 	list_for_each_entry(child, &swnode->children, entry) {
-		if (!strcmp(childname, kobject_name(&child->kobj))) {
-			swnode_get(child);
+		if (!strcmp(childname, kobject_name(&child->kobj)) &&
+		    kobject_get_unless_zero(&child->kobj))
 			return &child->fwnode;
-		}
 	}
 	return NULL;
 }

-- 
2.34.1

