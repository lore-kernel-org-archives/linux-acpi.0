Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.63
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793939639;
	b=xdmyff9/JiljXe9qUdJ6JtMVBfpAEWS8i7wgwlwzquIJy85Ai7rmW9bPqAzj3hndkAIn
	 T1wiXKuybbk/6kmtJCvz/khKHHOnfvXpxBrNt7X5CcNoL4ygSUOj5QD9ZLLpvrphmG1bN
	 c6GkJJbNpTajJ8wRnrdfRrBEZx4bB2BTB6O1lnXNGjsFL5djYza54LiGHYBpu/fy6PK4M
	 rF2BE6Ca8SVnE56NuOkjhwtI38qrWwcJKAFpPFsgsnvJulbXyR+0x8AmkGhT7jsaCNqLr
	 esbEBTABsI9sWPSlPzVrpucFYOoWG8zuYjDS2R0gnN6E8OcTWd9GHUi/POFkj/xCocA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793939639;
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
	bh=Um40dUCOZoX/exYmB7sS6CVPrzwd16W3xdHnerA0FeI=;
	b=Ga4/P+VSN7oL6sctyPt1iW5xngP8n92G13BSk9QTSfxZVsJOvBaBoOiqWc5RvwOxKzgw
	 VDSCDwYnYIZ3jf9U3fqfatIQaVTgAV2HSFv2kYaBRW+dSwAUOlwft+AVTpq0e+oZzSPQl
	 HrPt+AGRxyOxq+qPiiggObbrxDV6s6nQm0744RKUWAOGpiBRLEDL1O2SURs/VQ0WpOAul
	 8CKcaHLiJen39OCZzDk+S5XZ0gl+hLCuT1nC+ARhr66Gluv5Vilqe68+eeQA6dvtDTi1j
	 7TX033OsbMWL33LANLavnFYXdQF8RuJiRPw3KJTVTnaSqn+LQwB5F12IRSDKT2bIAlg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=vWhOOUuP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.63
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010063.outbound.protection.outlook.com [52.101.69.63])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A868606A32D;
	Fri,  6 Nov 2026 04:33:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A868606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=vWhOOUuP
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oYf6DbFEK/WjeG52Enlm0G6XNhHyqQK9CSyAxbUAx900MvhAMShToJEea3rWI/pGrbLqJ/eAM/TUi7jEzEvOjMD1XWwUmAHqUgyI6jijn6t0rdIqG2oAenLqBYKyEzkHKc0jsi02TfMxkFp14Ioa0ueU3GkHEDyeOAgc4Q72Q3IZCNsikmVerefJOtWg1rffzHVcvtM6s7i6g+3tSmM//bYJhC8/qWF+C8Ck3uzVDZKSobotJ5cV+1JZIqmrRnM1bBbEhkEOgTNC/pLagDOYss0bowmi/wfJx9hYqqKvl3W7AltzXngro7frXNAUST0l4twg/KZthx67poXZ4urlug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Um40dUCOZoX/exYmB7sS6CVPrzwd16W3xdHnerA0FeI=;
 b=PsGB5SQUNjk5eesAalkV4CS48mnAeeSIFG0DXHbOyl23ubp7VeRAEYMxRkutyQSBjrBf+pml0dE8QxK+c4OIV4OFD4Ft4C6QsUo80SrYeMe2wmTsqTaahln6pnam7QK6CA7tYpEU+EJMgBaSZ9lTxLMBTUr4Skj/ohp8VzEptPMd6SaI3CX0LKgbH3M0CBgVrgeE2uLIgAQhLTKzeUC7IBvbFEg5d+ufJ9LkR3X4lt606K6sogDPlVLfKfdq6nhYH+H9YmkoSssa1S6SCM3rfqvJaiux4Xe9/sVrnZ9tVOafsSp8mFc+rOBeBXaa7LqC6WS4yDgXY/Z3aFFdaizQEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Um40dUCOZoX/exYmB7sS6CVPrzwd16W3xdHnerA0FeI=;
 b=vWhOOUuPKylIqb24A3m8DLKkpctXB0v04t/fO7/D7gpwhh7xuA82muaVl+bDrTPPXeA82XONuIrsEB/lu1u3mKoDLIBRRiJNqNq90EiHPdH+Z691uUKBMj+bbyATaBAxhb0mjDjRTNRS5Pg0nVYLk1qbSaU9jdFKUD4j7M2JVZ4P7BbWtgPiyKXE9WwkCTw841D5Xs0bu+xwS9Bq+yVZ1oFqEqFmHyAJcGv85Mk4/dAOXvjnvMgoKHEyjxOkt8ym00lxuJdY33qrzZeI/3iKzbF9UV4fC+4kQrGwiEwiebxTpJUmRrRPF0G93DgNcSj9C7/4tqi6S45tFhS17WdxKQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by AM7PR04MB6902.eurprd04.prod.outlook.com (2603:10a6:20b:107::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 04:33:51 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0592.010; Fri, 6 Nov 2026
 04:33:50 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 06 Nov 2026 12:38:35 +0800
Subject: [PATCH v2 1/4] software node: do not resurrect swnode being
 released
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-swnode-race-v1-v2-1-f8bc7b14d578@nxp.com>
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
X-ClientProxiedBy: SI2PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:196::13) To AM8PR04MB7874.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: c190e693-906b-4f5c-3edf-08df3bbf2804
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|376014|23010399003|6133799003|10067099003|18002099003|22082099003|56012099006|11063799006|261026121527099003|261026140227099003|261022105027099003|261028144727099003|261102123227099003|261021123027099003|261021121427099003|261009223027099003|261102130727099003;
X-Microsoft-Antispam-Message-Info:
	I8tzy7uzmXf6BvIm4vbTcLwLqKga48oTxCjsNqUcU/8xAGGwybt4MagGQ+BCiWKIxq5XzSrSYzkCbDAuKqn4kwFsDKVTo0V4n8tela7tH1WgTJh/gw1WJuc0E3vtkaYNoI0mzEI7B0ZQ/fCCJW/sblPYpRVv/L1tYdhKU/LDr3DW97a+Gxv53yRnhM7JhVb/tBY9HOMl7WwYvKzsQW99DlVYLYg4LVArhLyttF/HQoE+l0d4vPTTtbq/JRFgnLIl6xzKIL1OAPk5iqiU3hKmI+Uc0vb3kD+xkmbFSh0O3lXE/7MCevw4gkMWHCl26CVdW52+Dp7LNXszgu7wkyPqDWV7zHFDe/wZIiXSzQTzxEQrgf/RsDDHQHvMidb5YY64i816BgZQN0EI8cr1865VqP8LRsnz+mMyMIGEXy0cXyKlOJx7KLbCqn1qp3Ws+/yLFDFkIl4glriPg+Q4iTLg37DcC1JBbbmvjbpudnO9aWGSJseGYvMt9/3U8zFoLXctaFfmFO9EbJJcVJfH4j0Eb8XOuYiVawPZg5uLhEA/GkjjJOblrge5zFUdq2UYfOGxw6vHSoK2LNLMjwvDAWQq1jcHutv9cnoaS+TRbPReyE5DRpA5QQl/ScPXAreQd+F1pVH0URuAYFdZvga0EwuPLc6a59i+aOY0Ufn+AdEpFPk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(376014)(23010399003)(6133799003)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006)(261026121527099003)(261026140227099003)(261022105027099003)(261028144727099003)(261102123227099003)(261021123027099003)(261021121427099003)(261009223027099003)(261102130727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?blBwNXBtQWdmSHFuazRCMmtiQnEvNkZjWHVvbGkrRTV6c203cEVmM1BUUk1n?=
 =?utf-8?B?cWtMOG02ejE4YmRCQUpESUdjK2VQTUxqNk9ZdEFTK20zb3BXczNmNW5RRlQz?=
 =?utf-8?B?c29oNC83ckJBOExUQVI2UDIvZUxHb2VEdW9JMm5lbFNOS2VqOXBLMlB0MWVl?=
 =?utf-8?B?blo5bWx0ZTk0YjhlVFlzZG5WaE5nQXpHRXdOZEN6ZlhqUUErN0lVaUJPRS9u?=
 =?utf-8?B?SzZkTkRHVGthUGd6cDVwdWVzbTJXVWNsQlpTbU1qekQ5Q25kWEtMTVYrL3o4?=
 =?utf-8?B?a2gvejQ0MFdZNlhmcHVmaGRSSi96eXB5by9ZeEhNeC9xL3QzazNuYkZITGcv?=
 =?utf-8?B?bU1sWmp0Zm5IbmdldGtrbHNwZWRYbXZnT1lFY3RrbGMrMWk4SjRDK3RwWHls?=
 =?utf-8?B?eDdwbE5DV05DWWNqUEJNUG9oYzlSYm1HTVdZcHg1RFFTSlVUb2d6U3NiL3Ns?=
 =?utf-8?B?bzFyRVl2TDA1ZTdqWkZkL1pSemhldDBLZHhBSkRqR2JiQTNibGREbGw4dW5H?=
 =?utf-8?B?NGx1YURLV2JpbFBpaHNGS0QydjNOSWxPV2pMbVRnMUwwb240QWJwdVpkVXVT?=
 =?utf-8?B?VUg2YTZhVTF3U3dGcGgzNlVnSDFqMHZDeUU0dVNVMEtyWU16b0JlY2lBTUd5?=
 =?utf-8?B?WlBXelFKSEJKVklXNkc5MXRwOHBPa1RFSmgrNFp0aHAyT1hHdHY1dUQ2Zjdx?=
 =?utf-8?B?bnBCeUtKNzNsc1pLelJxTUNSZUNFVEVDMnI1cHBKZUUzZExXOUhpQzZFMzE3?=
 =?utf-8?B?RURUdHFsRDdiVVgwWkdYNnI0cThOR2I1QjJ0SDRYSjVtYW8rOTBGYlRCczBQ?=
 =?utf-8?B?Y3VaQlpTeWVxYzF3U0I1UW53eG8welNZOUZWc1U5dnV5QUxuOFRoek1QcCtF?=
 =?utf-8?B?cXRKOGxtdzdpZHpuNEduQ2o2M20rM3Awd3pCSGhEbGNhdU0wc0FZSXk4SGp3?=
 =?utf-8?B?QzhLd0Q4WDRTRmNKa3NTZm9uSmJhd0ZlVWM2REF6Y1hyUU0rSEVDK1BqS3N2?=
 =?utf-8?B?bGdLc2lXaGd0eUZvb0JpTHVWUGRDTk1mK2NjbjNWbGtxN20zZkU3RHdGMGkv?=
 =?utf-8?B?MWJNbWhHd2krUVoyQVJiMDVudFdzOEp5cTJuWVhiVHZnbHZQaERua2Jpai9G?=
 =?utf-8?B?MUdvOHFKbktjdlJtNGc1K1VOVUhDN0JIS3g1TzJWdmEwTmxNb25QNlY3S1ZY?=
 =?utf-8?B?NzFNYjcwbVhTMXR5VHQ2bnpDemF5RXlpaVVlNGhKK3VNQkM4NHRxTzRNTTBZ?=
 =?utf-8?B?TFhIQUdZS21sQzk3c3hsck12c2FoMlNvRTNyMVNTbkhJb3ZNbWVTYUxtOTRT?=
 =?utf-8?B?OXVvMmZEMmcvT0lRbzd0VFgyNkF1MUlkS0lBcUdZSkd2bjQ0dTFyYmYrVnBt?=
 =?utf-8?B?U3JmR2dYeGY1eXo0eUNKL1NNSEZTUUxuQnJaK1l0MEdhcUo5T0gwRlZlYzZu?=
 =?utf-8?B?aitkOEhvT21BN1BSQjl5RmN0V3U0bk5QY3RYdWR0VFRsTFlZdU93ZVg0cnBt?=
 =?utf-8?B?Ui93Y2hSQXplakxDL1I2TEhyWC9ocjhGUjNMalQ2VGdiemQ1OHBhYlFDRGlh?=
 =?utf-8?B?T0s1WndONVZqMnMzZ2dwY3N0RVdWVHlBSlV4bVhmUERWNFBNYTAvV3BpMmdV?=
 =?utf-8?B?MEI3bW10dmRKcXBGZ1lzVGdOVlZXQlVFK3oyQUlubzJ6YW9UeHl5dFMvNXc2?=
 =?utf-8?B?ZVk2LzJKYlZVeUd0eHdEUmY3UXc2OGhOY1I2K3ZhODBocEEyUEQvZGNzS3J2?=
 =?utf-8?B?ZS9OVkdJTXpXSXNkSHFQazhpd3hHaXFBNnBCWTdIVXRaeVd2Y2tBM21vbEZu?=
 =?utf-8?B?ZG1YNEdKREszVnRuUXdKeHBXNmJsdVZNOFA3amt1ckVpNGFuaS90a3R0NzRw?=
 =?utf-8?B?Y1NjVUE2N1V4SkNYRVJlU0pNTENHMG5wVExackEwSEhCRjFtYkZGbitXbUpu?=
 =?utf-8?B?Z1U3RmwvYWg1aU1kMURkNURna1UxZ2syajBmTUNVVEZ3L202UVpkQTl5c2hC?=
 =?utf-8?B?VTVrVytOSTZ1RzIyTGl2emdaaTl6OFpNVi9UUVp0TU1UYnRvQzJDdGVJZ2Fu?=
 =?utf-8?B?N0FvTTUzanEwYjArbWNDTVkzZ3pzdkxzYWNJbFBrdDVYNnp4TnR2cFZGL1pD?=
 =?utf-8?B?c3VtdzhBZFFsSm44V3FjVEt6cnVab1dMSDM5MnFJV1gwSzhEb1hZc3kzS2NT?=
 =?utf-8?B?akQwQjl3SGthZkZyUGp1bTdwSlYvWXc1RVh2YTZ4UlJSQjJCSWw5QTVLQVkz?=
 =?utf-8?B?ZWlmMk85blZmdkl4c1UwTEM1NXJNRWFSS3JWNmxacTBoQUhwTzlDNTIrRTF1?=
 =?utf-8?B?RVZHMy9DcEdPZmg4dUNscDM4aVFCSWhQc20zbCtoaXlQSkhpTTdzUUFabWUr?=
 =?utf-8?Q?a+/K5NnFtJGnlWUc3niGjXcLwsvkUMzPolWxc?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c190e693-906b-4f5c-3edf-08df3bbf2804
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 04:33:50.8863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1795DUUSc0/7NvgKozsc6IWoI3YuLab9t24fBcM7dB1yw8vbXMKqcri4hRa4l/vfMhsKGVwfx9wHAQYdtjz/4oNcBb267VfNLLlQ3ZlJOYyFMFtaOaJTaPPvte5yyCtf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6902

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
reference-returning variant for callers that keep the node (register and
device_add_software_node()) and keep a borrowed-pointer variant for
software_node_fwnode() and software_node_unregister().

To avoid looking the node up again after registration,
software_node_register() now uses an internal helper that returns the
newly created swnode reference, and device_add_software_node() consumes
that reference directly.

Fixes: 80488a6b1d3c ("software node: Add support for static node descriptors")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/base/swnode.c | 122 +++++++++++++++++++++++++++++++++++---------------
 1 file changed, 86 insertions(+), 36 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 84a77ffa3dc4b..965e960156876 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -75,8 +75,36 @@ static inline struct swnode *dev_to_swnode(struct device *dev)
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
+static struct swnode *swnode_get_unless_zero(struct swnode *swnode)
+{
+	if (!kobject_get_unless_zero(&swnode->kobj))
+		return NULL;
+
+	return swnode;
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
@@ -87,10 +115,16 @@ software_node_to_swnode(const struct software_node *node)
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
+		if (!swnode_get_unless_zero(candidate))
+			continue;
+
+		swnode = candidate;
+		break;
 	}
 
 	spin_unlock(&swnode_kset->list_lock);
@@ -98,6 +132,21 @@ software_node_to_swnode(const struct software_node *node)
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
@@ -374,18 +423,6 @@ EXPORT_SYMBOL_GPL(property_entries_free);
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
@@ -977,21 +1014,39 @@ void software_node_unregister_node_group(const struct software_node * const *nod
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
 
@@ -1061,21 +1116,16 @@ EXPORT_SYMBOL_GPL(fwnode_remove_software_node);
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

