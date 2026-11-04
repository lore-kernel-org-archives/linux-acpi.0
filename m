Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.22
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793806734;
	b=XshXEyD7y73bMftffBI7CjkxB9anqDUSXSRAM1lE9sUjxcgnB8KNAo79CyOdW9CtKKDH
	 C9dRYSozgJnm3jPrOCSW8NspRUMtJpfWeU3H2MjsymT4+JMSBIhx6kHm8OS2rkoF71tUn
	 GfP42BIZR//jtpj/aiw2I3CyKqIMzOpyyDy+1KtecVyDdhh7hJi0OOYbj4H61JxOoa8IV
	 IlEmLe/LSvEFAfRMIbRHvUtaMPCQBMMJAA+8zDwLL7JsBgWSYJwoSFhs6qCRX6alPqDza
	 Fa09wSNPfj/s9Gok8WoqrCsB3lhxbnKiT9/jgug7afUtDvnTfUg16aAMSrqVS8jLwaw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793806734;
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
	bh=0ts0uWybV74LhsHgJJL1ZSv2UK98nYbxjEDTkxHX4qc=;
	b=wLQjUTAeEb8jh5VKGiLZXNiIKYGLzOwvrq8j6d1g4GqEzh/86z0ek/iZp6UhDLZ/9BvA
	 riwbzHyH64GzmENg0dWf4Q3Yal1whHet3L7rEgXRE863MuD5j+YuTWrKWQI6XEddBpdkO
	 f75AztACzrt4RfRXI91KUGDXCYkyhhmxHEV+Cpd1sLWWr3p3n6gGX6qGEMa9lfs8q7lSt
	 pik68ySmiMlHjJT9ajuc/VrlSdcL717Bm+PzrVbgzlZWI5yCtmTtQlxORBLib6YYVLL+P
	 D6j/pdpXkgFGWhChIUvKQuJUkstsE/g3pDhIOlk1NNXXIUkcdbQxrlU3231+8yqKk+Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=gPlTW7UT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.22
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013022.outbound.protection.outlook.com [52.101.83.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B41060A260A;
	Wed,  4 Nov 2026 15:38:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B41060A260A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=gPlTW7UT
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M2Bz6Yh/zzxQtSInvrI2MFTge8i/K1FFVA+8sbOmb0C99o4c+fCKFV3HF2uqMR+y9ugw5Zqf3+NTF2TWO119uI2rGX1bGcJjOaikMzUNRi0cBXnIZm5C4McP3CZIkgf76C9aO3dOinTHSomynzkJiV+6xSBDc8Thv4/Wqgfq8KRJo/HZiuTZPumLI/BaI/gO6H3petOprC3ud7z4ut5yjhn5y8k2SSJknnWRL6Jc+DujHJgxGuAp7EvkOd1CqlqC1M9/WwWM6C3yi/NT4ePFjxjRLDhxSifzvSgUQxhtvCtlk4vk2aH8rCW/oB78ocDC/N9OP1NYAwq4J4dXuj+WrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ts0uWybV74LhsHgJJL1ZSv2UK98nYbxjEDTkxHX4qc=;
 b=oP9B2EHLWeHXPRY1yvVe6IhfvVu4xXTHiMipIymKmBmo/EywQd2u1V/xB+l4i831JF17bh0YftxgYZv6Hue0LwvDe+1METjiB/b84iuH83YfNFAL1xpr4Hdp88sAt3oohFqUaJq4MP9m7pFg8QLlSm69+g52/8gMnhPI2xV/9Ver3qKZm/IwAcL1bT+yuzLGrW2ck46RbKToBIDTz+xvcyDvOAf6fEWfRc7TUYrwFH5sa8Y9MvxafwzjLKgCJf91e+RC7HpwGnSEKFeJ75Wv19ZCxK6vsDqWJRM7b1KKqE99b9CpdISc33EDa0lgd9VBBcy0Dx93NCn8omm/6NIzjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ts0uWybV74LhsHgJJL1ZSv2UK98nYbxjEDTkxHX4qc=;
 b=gPlTW7UTC04HD1EYC5yh4VbE+VMy1EqlzMIvj9NtZCO9VvWGp0wZzwzZIbUo5Wqt62CIGi/vvwRg4ySsD0uSCl5muAGAElWLm5YQ8Lv1DSqX2yh86PVrO7bwEQqz9dH1Gb9zfNr4BvGchpiF0O87lxjr9wfp2Su/crXXetc4ra7pN3E2mENuvhNNCIQ/Aw4+bIywZ28bsnqhq1auoX3u6rUpMd1gWoc+FXYwsz+c6r4Vgy2pwVbvnCMAomBoPduDlJHvWfDzdAClwFsJ0ZEdRe5vq8a7eEOjBaB44Y3mV9xd5YODLmhzCzgTIKMhkDUDn9kmgK6a9MmXEUT7MKp8fw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by DBBPR04MB7564.eurprd04.prod.outlook.com (2603:10a6:10:1f7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 15:38:50 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 15:38:49 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 04 Nov 2026 23:43:15 +0800
Subject: [PATCH 3/4] software node: handle missing remote endpoint node
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-swnode-race-v1-v1-3-9406a67e25be@nxp.com>
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
X-ClientProxiedBy: SI3PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:295::9) To AM8PR04MB7874.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 79d7d690-8275-4f4a-926d-08df3a89b860
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|7416014|376014|23010399003|1800799024|10067099003|18002099003|22082099003|56012099006|11063799006|261102123227099003|261021123027099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	gvMWNHEYfvlWb2kb8/MC4s13m1+mneijEy4bvngIy+l1YxasRwmHW8udTTgBcDDU5HB9pY+6XvNGSqmJutcH+WB0z0oaxnDLzi46WdbxdVqiAiq7QtpWmWZVixSBxS12ubQlU+RF03GuCkPr8NA36VBt+muNKLeBA0U3a2GOcFNCZe74s0uJffTNRE0seo/kRY2n6FuK3q+FyYSbbR7RWPrg0teWark3Pg6FAJEIUilSWBLWDaWlxB7mvvX0jKdoSZgXLhBmPGckpp/KOQ02rYdLUk6GSvAki2VZrmES+rU0ioGOEVFY5gkj/yoxqxZJLScJpMjI1p5A8EMXcrf1c7mtwfNAkxkg+O4E284Yn7cplgWWlKIGg+BLtGpX57Nxjoqxf3unipNES1L9voHvW9JTHVoQajewIJFG7FGuGCWZOG3Tlw7d+DjaMO59qu3JDI6Kf8FrLfxrwSfetP1R9WoyrUnWx3n8XlDqJh+Ihyk8+yDt/vwmBXFK93ofe2SROHRO+rv78K1nhk7ts81HqLqG7vtHbYlov0wH+Ce+FBfW9ZJhB0luSn15h/QtLR75vHxNwPccYRyR/Iz04b7jKutK3491M3ANnJRhNZkKJgfTJVi6lP8NPqBxEKldOdD4Nj81k70F6mMoOA7smCRIxWSb4QtjK3yeVEVA8W2Wxrc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(376014)(23010399003)(1800799024)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006)(261102123227099003)(261021123027099003)(261021121427099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXRCdzRjc0pvd0NSVVNIMkJxY3BSYjlhOURIOXFxZGlhYUxUdW9JeXJWN1pm?=
 =?utf-8?B?Y2RyUzh3Q2Q2SWxkcy9PakxkYWw0NTFRRUhFd0NVYU1QK2s1aGpXTXVKemFE?=
 =?utf-8?B?azlBRWFjcGtoMnpRVGcvK05YVmQ2OEFka0E0M3NqOU1zS2xURzJjamlHVGNE?=
 =?utf-8?B?cXJ3NW0waXFtVkMycExmTXpuMnhDZTlMRVNWTVV5SU5tY2J2RWI3S0xCalBn?=
 =?utf-8?B?ZTBFTndCMmMzaWpuQS9qdVJZcUV3Tml5RHhYQ0hnejVDQ21jcHNkVm9nWHJx?=
 =?utf-8?B?WW10SzV0VERTcFdMNjRxbWptR0xPYUZVTlFtbmsxTWRFaUhWL2trWlR1cVFl?=
 =?utf-8?B?eFQ1eGExRlhZK1huamJ1VHlOMGxvejIxd3l4YVM1S01yeFNDVWl1amVwaExD?=
 =?utf-8?B?ZHNZeFRtQXJCRDdPVlRHYytDaURYeWtwK2hIVk1VMkNySnBvZGxIdGxLR3Zo?=
 =?utf-8?B?NE96SFE3Tjd2elFpcVk5aFVUaEhCZFdEbGJPUEZqQU1OY2FaZGozeHJnMWpR?=
 =?utf-8?B?ZjVPbFNlaGxRK2FuSlY1YW05RXJOTndkc3UrOU4zUWc3MDRUK1dzblJhekF4?=
 =?utf-8?B?cXd6aVdQNVFWcC81cVRrT2ViQkhYL2d3b0VaS2NsbDhKcUl3M2dtRWhEcUp2?=
 =?utf-8?B?MHJxUndMT2RLUUJFTWszZ0Q0UXMwSm9EekYrcUhqb0xnYlhhY3JKVjhwdDln?=
 =?utf-8?B?UlBWQnh5SXZFWDdMeTFJc3RGKytEOHg3UklxOWtBZ2gzM2pPSVdiRWJ6aWRO?=
 =?utf-8?B?VzZGV0FWQVdXck4wSm9BbDl6ZzdYMjZ5Q3lzV1B6VjlhTWx6NmJGZTZ5aVNT?=
 =?utf-8?B?UU5MYlJEbXRld3ZtcldvaUF6WWh1QlZ3NkJza0I3ZFZNbHVmdHFCY21jVkNs?=
 =?utf-8?B?NnlnWEI4aFlJN291dFJnL3d0SjgvVnhjM2kxa2t6QVUvNmY4WmMwcUdlSjBB?=
 =?utf-8?B?UFRvamtsVmI0TjFHRGtOMWZqUjlYc1lIY0dNQjBZWW5GVjNVLzNnM2dXMFNG?=
 =?utf-8?B?RHZaVkxWc0w2YTM0MjZ5TC9zdGdGK21rTENLeisxVFo1Y2t6SlEyTHQ1anAx?=
 =?utf-8?B?WlpvYXBFak5xNW5nTnJiZTU4TVExWTlzcWhDNWsrMjBjQWwzK3RrN1ZRKzFa?=
 =?utf-8?B?cHVSVXI2YkRiRExWNjcyaEhXdHAzY09vcUZwdk9OZGJTMWZWUG1zWlpBNDc5?=
 =?utf-8?B?cXVJejJCMlVEUXI1bHVnL3JJS1YzM3oxRWVhTFV3Sll1TDNJcHJiQlVQa0R6?=
 =?utf-8?B?Z3JLOFZ5KzhCckphSk5lU1o3QUI2VG52ejRTWEJBcUdUbUNTQjltL01TdlNW?=
 =?utf-8?B?ZEg3dWdnRTN5OUZFdm9lcmphZ0FsUHFVOTN0Y3lkS0dlei9nSFpta3N3RjR4?=
 =?utf-8?B?VVNNaUc1c1VFVVl0MDZldVVMZmlKTzhUbmVZckRkWGNJSm9FUmZBYzBYOU9Z?=
 =?utf-8?B?eUdiTkhTaTl5MnR4NnAwSVVyOFNEdWFRNlBhNjIzTHhxWVorMEV5U3pFNnJx?=
 =?utf-8?B?d0Fsa3ViNmQ5SW5aRUE5YnpTelEvWHl5OGpveFJ3QUt3MnNtcmdPcGUyWnBC?=
 =?utf-8?B?WWliQmpWYkdoNEl1NWNzWEU5L2taKzA1RHJqeEI3M1dZZG56enQ5QnQzNHBU?=
 =?utf-8?B?TFc5eEhnRDFQaUtQendHR0JnVXRTZzRqeEpUbVNZdjdXb2FQeGJkblFlYWFH?=
 =?utf-8?B?OHZrdDhGM1VNeE1EU041eS9XWnpZL1d5S0doUHZQeE9UalVBODA3LzFJYlJs?=
 =?utf-8?B?RXBTOUxKdHYwZS9laXA2dERjTWc2TlhxU2gzd3NRdnJhd2EyT2hCSno2NmJs?=
 =?utf-8?B?QktyVUQ2YllIVmRSMWdoaFp0WnZjOFQyczZWbkxiKzV4QzhOaFRFM0MyeE1P?=
 =?utf-8?B?NGdBSnMzNXZHVjZjd3BNbGl5TS9rb2pNcjZubFQ3Q0NzOGIwdEptRm9VVXF5?=
 =?utf-8?B?eGRJeWZlSFlINlNzbk5uRFkzZVB0TDlBbW9SUW5Ga0RRQ1N4Q1JSUTFKSXIr?=
 =?utf-8?B?ZE9nczNPNFBiOFpVY3R2eUhYblBabWxOeEpHMlB3c3hIUUpvTWp1ZkRDYnht?=
 =?utf-8?B?NVJTVkQwMXZpVXgxSGxESTkzYnZpVFArU2QwbEk2bDk1QytVYzNOc3JiTzBt?=
 =?utf-8?B?ZDZyOENUZm05K3lreURlS3lMU2Z0NHNnQm5UbDdGV0VGcFdhemNHVlhhTG9N?=
 =?utf-8?B?eDhTU2tMSnA1SEpxN0RBSjc0b1IxTjc0c2orcHBnWVlxSzVGTWt6ZHhybDFD?=
 =?utf-8?B?YURWbWZTQnNkL2xjRUl2V1pXQ0VZeFB5RldRMXh1U2ozRERSekFYVFhZemlt?=
 =?utf-8?B?S1U3TVVEc0dRdFZJcVdNazhMODRFMFRSMHlQRXNRdmFGL0hmZEU5dSs3bE1l?=
 =?utf-8?Q?gjPOtGpQqiNPd+u4YjlgilKLz6cL4EfI+ZcjM?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79d7d690-8275-4f4a-926d-08df3a89b860
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 15:38:49.1593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V853Vjs/7TLKa3Lz4UfDmQM10slwmpZb9rWfUopjTavT4ya2F64OZPde2yH0jTxnS7is6DOb7LbuRCDbBGiI5x+EwpLjBUbpvhRxaZE7RpjLpPPuKmce9Nlze7WrRaQu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7564

From: Peng Fan <peng.fan@nxp.com>

software_node_graph_get_remote_endpoint() passes the result of
software_node_fwnode() directly to software_node_get(). That lookup
returns NULL if the referenced software node is not registered, and now
also if it is in its release path.

Check the result and return NULL instead of passing a NULL fwnode to
software_node_get().

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/base/swnode.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 9095d50ba146f..4d95a59a27f0a 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -676,6 +676,7 @@ software_node_graph_get_remote_endpoint(const struct fwnode_handle *fwnode)
 {
 	struct swnode *swnode = to_swnode(fwnode);
 	const struct software_node_ref_args *ref;
+	struct fwnode_handle *refnode;
 	const struct property_entry *prop;
 
 	if (!swnode)
@@ -690,7 +691,11 @@ software_node_graph_get_remote_endpoint(const struct fwnode_handle *fwnode)
 	if (!ref->swnode)
 		return NULL;
 
-	return software_node_get(software_node_fwnode(ref->swnode));
+	refnode = software_node_fwnode(ref->swnode);
+	if (!refnode)
+		return NULL;
+
+	return software_node_get(refnode);
 }
 
 static struct fwnode_handle *

-- 
2.34.1

