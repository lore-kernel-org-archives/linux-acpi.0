Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazolkn19012050.outbound.protection.outlook.com [52.103.2.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740A540B38A;
	Thu, 23 Jul 2026 08:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784796329; cv=fail; b=j2Fo2zjQZKsfskw87BHEI2ChrgX0aSj3nIL5AeiNljKlk5RU0f69056WwaZTtJoP+jUXU8jlcqWmvRInhdSXHTZQZ0RgpRYf9Ocohwo9EbBpuYGHXUWzbaQwivgGogCn/cQ1EYeXbzcqXzplJBhMMQX7oVDp1dGoM2rkrlqKruM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784796329; c=relaxed/simple;
	bh=HtmDwx8cJiJ5clTX6WW3odvqM+KG2GQdXLOOOdlGUck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kgNHifaDXfTriaKkmZApIT0nunMrU7UMRiH4U8za7oucYNdWHZl1adxsub1GpDsJlnC2z3sGF7SuN4+bekuBDddGtHCKLbHF0RgNI7bnu/LtpkXQZ8PeXVvDDv0EvORKcE/rmuU19WWyTrjw4QodxQ3nDDxIWQh0TT870DCn6fw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.it; spf=pass smtp.mailfrom=outlook.it; dkim=pass (2048-bit key) header.d=OUTLOOK.IT header.i=@OUTLOOK.IT header.b=O6YhJpuI; arc=fail smtp.client-ip=52.103.2.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=OUTLOOK.IT header.i=@OUTLOOK.IT header.b="O6YhJpuI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VHGF8nqTaAtIon5fFf9C1dHwCLdpd3NpDIrLnIGNchn8okAIHm6NI5UQHeXQO/OH3A/Tv97of6i+1Y/yv9tLqMlZBErdZ17XvLrkXXxlOJQJXm3aiSwTwluzJV2amHZhF+WQ1WqnPS88IAlYoLzU3iwd7I59Pr0+7dRNkmpUJ1/DpPzKpVDwIr36ha5CS/vZyBILG5DSDqmivuLmgrERwQK0d/l7vBBBgVlZVzYjb3agOqkerxAQkONcjVw92OG1Dj/IeHfhKad/e9MQJSxEhLSrHVyLu8VZX/3JqgTZTX+WkDZYcQ7ACng83ZDwBBs54kTBCcUBvmzVHF6b6T679g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HtmDwx8cJiJ5clTX6WW3odvqM+KG2GQdXLOOOdlGUck=;
 b=sDdJDZM/EeiuHv1ODxn44SjyAHFclEI4CLPRSqlv2OF19CGfyFjx767THpmPSHmk5o8vED5Kmv7E8XsawaQtrKTq8OEIUc7uiH1CpNHHAx4ABbrrMjMWD2L88BjHa9ErxUeJPczOfNG8gAlTCI1Rr5TeS2yMS9QzjE/6hqx00jNklC7N5gFrGNoSK07wTnrgL7FLSl5cp2v3brT9WEOcKz0EsFvz5al3z1fVDYPuxTgLw3LNHd32NyPyEaJHutwaAOVsBh8xPCLL7Wkco5M7FwKiPqL9QxnAelE7QoEkK0XXC72j4sUtTYMc8y4SfLgzxmou3F/N60bmI/l4/Fqiyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.IT;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HtmDwx8cJiJ5clTX6WW3odvqM+KG2GQdXLOOOdlGUck=;
 b=O6YhJpuIMhSWcfmEp9h8bUu8jUaGq4hBNbJ5ByObXjMZXsZUF2BSVZgn1ZH6Qy067r1y8Zj0b3hEUj2R/O9vCPSNUfqghDMs+x4Y8RmvF3NvW1pIJ5Mf6WqVVL3cHnr7TpSRTlG/Qn58tBJ9H2gkU82dNtxtitoV53+zBIdaE412uJXEp33Bz9eWB6F75rpUWOmCCEe/1dQnCPdOa+9JdV1XDOMsycqdAm0z+mhuq2kUZR/F2HaroSdEElAmdeS1Q1SWmrLma+x/OiLyH/6pP0kUZ6wNEZIue2FZbUaXXgT8wtAEuh605PX+tGks05lo0jnAkcGeSx83X4GNR0bkng==
Received: from DS7PR19MB7724.namprd19.prod.outlook.com (2603:10b6:8:d9::20) by
 PH0PR19MB5426.namprd19.prod.outlook.com (2603:10b6:510:fc::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.10; Thu, 23 Jul 2026 08:45:24 +0000
Received: from DS7PR19MB7724.namprd19.prod.outlook.com
 ([fe80::70de:3c05:ac62:7f86]) by DS7PR19MB7724.namprd19.prod.outlook.com
 ([fe80::70de:3c05:ac62:7f86%5]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 08:45:24 +0000
From: Marco Giunta <marco_giunta@outlook.it>
To: ilpo.jarvinen@linux.intel.com
Cc: broonie@kernel.org,
	hansg@kernel.org,
	imitoy@imitoy.top,
	lenb@kernel.org,
	lgirdwood@gmail.com,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	marco_giunta@outlook.it,
	munzirtaha@gmail.com,
	nadim@symbolic.software,
	perex@perex.cz,
	platform-driver-x86@vger.kernel.org,
	rafael@kernel.org,
	tiwai@suse.com,
	wangweidong.a@awinic.com,
	yakov.till@gmail.com
Subject: Re: [PATCH 1/8] ASoC: aw88399: extract shared device library
Date: Thu, 23 Jul 2026 10:45:12 +0200
Message-ID:
 <DS7PR19MB77243856ADFA26B9878B1CAFFCC02@DS7PR19MB7724.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <68b8e29c-e7d4-ca19-2e40-ad3eade6d94d@linux.intel.com>
References: <68b8e29c-e7d4-ca19-2e40-ad3eade6d94d@linux.intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR1P264CA0037.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cb::11) To DS7PR19MB7724.namprd19.prod.outlook.com
 (2603:10b6:8:d9::20)
X-Microsoft-Original-Message-ID:
 <20260723084512.27354-1-marco_giunta@outlook.it>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB7724:EE_|PH0PR19MB5426:EE_
X-MS-Office365-Filtering-Correlation-Id: b8bb2b7f-902b-4b76-e946-08dee896bc57
X-MS-Exchange-SLBlob-MailProps:
	bHQ38DpbEWCyI6jAQxstdxgywVhfORYI2q0Eo1lNExcSUv9DTrLaqSIboi3Tz0rskaH+yR6u0rECbps3XJii968iejrX7CAbQt845NOz/WdtRWbnI0KDhV1kSaoLbC5wSDWnVuwEsBBqZEg/vUTnUcfPCWo53AYnCtmQZaJ4s9EeAld6SDH7g07nbYY7XM4VMkVUoF9iRklu7l2XRfWbQDHC4fp+3vnkX1puCUydpVqWg/zmQvxkh7m5ZWGUOZtzOc7kMXzlE/V16RO/n6gU7sJ2bYN5no1vIw/ZMqU1FtO4H8rnK2llNC1ENvryWPiIc7YVyfJU630RkWWP0dw5kfcCb5LQsbreU2t3GOkbOtcse6h0kCPI/juWOmUg00EiA/eOVNRKOzZGRBRhVffntkWQJtNwS9ZprYSIIwaFIoa1x2Vc31/44GRLfSSUsFnkIunPsRLH/az3CGQkS+RolDwcwq0sRuArI22/DV/r6/1SN1/3qsSsP6UEN+jFVp6XrZ6q8XaU4iMbRJu9eFE41YD0cejP8P2p49mq7qJM66AuQqbID61rhTV1fOYgTndGpV0JULqQ01uWekZa/9NpfBUhCfdFI0LebxD7uKnC9RGpMFKNeLohMr6X3LIzRGudxLm9oclFVb1GUGb122ITX6/oTfqyTPRxMNNPTR4KSepocDpKipNd8A==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24021099003|55001999006|15080799012|5040399003|5072599009|51005399006|23021999003|19110799012|8060799015|3412199025|440099028|40105399003|3430499035|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HNez5w6wW2bCAOM5g9I68yVoMZAMa/5AybV8THb0wyFcTM3dpUt+8idChA4J?=
 =?us-ascii?Q?sLOHhZrN1m4hcStNdrs+b68nPG5Nv3NTosPDZTvK2IbixoJF0RhDIZGLiAVg?=
 =?us-ascii?Q?5iU8U3kychY9RqLoZdLtJ+1piIp1IVveM1DBTEO7clSwuqZyR9IQgXK8hAJS?=
 =?us-ascii?Q?n2QuoF2R8G+nBgu5s3PWfPD6DowwTug6K346xfFOA8jvFfQlxImRkMBV0Rog?=
 =?us-ascii?Q?oNA9xir9L0UYu86Pl95O+1MQ8siE6biccmnOgU0UQs/i/7vjDwGByIGtf5/U?=
 =?us-ascii?Q?nW1MZXdd/xFo3MlFfR6xCDUL6IrD+xz960wM2QdplN2bUqpPnFuDQdRhBq/s?=
 =?us-ascii?Q?dbHJvVId0+Oujk7YOnPyEKYzgSqrrG1utvAPxUqY3xfIUCYRfYOPdbE1mK4T?=
 =?us-ascii?Q?oCQHcHY4Vc8h59mayfJoKICNt0wqdhGbtJZJsv45Vf/9gzKSalK2W8vmhNR/?=
 =?us-ascii?Q?gYan5Q5nZyZzkaChye6F1QCD9ZEfwvhvWaDNZdrjh2SpKVfFSmlWhnme/piq?=
 =?us-ascii?Q?/FCqMJBUEwbbOSTlsyOr+k3Uv79/8rojN1/jTAODnlldv9lBOHB7IeiNu1N4?=
 =?us-ascii?Q?xxG9950pAjSoWwhC3vviekW5/zJPEDhGu8AoJJbOaPDtKxxDhnbe/3UxG2Yq?=
 =?us-ascii?Q?dNTcIf8wFgVShxySf211nmEYsQf4/EGYcsxidaXnpJH/ynz1Y70YtPKCTv2C?=
 =?us-ascii?Q?zMAZ9TYDmZKygEbKs5g1SnzDFI0Sh+bmxCIUgY+3j24n8ty/KO8Uvlj+2I/d?=
 =?us-ascii?Q?N4WQMo7D2ThLPfpGwCoWCP4oytB2S72Z4PZ1/DpXofJPPTdpQC2up51l6OND?=
 =?us-ascii?Q?EPQJyJBBsrt9M+txvv4e7adjeX3YCpoffQS+J/YlbaWA1+GJbbB30a8S8U+S?=
 =?us-ascii?Q?lq7xkVcQySg4eX3t663y+EyhXq6azmBbPQnDPCod0c0yf/UhWoVlEm7sDwW+?=
 =?us-ascii?Q?3gYJWSjbR3H2wnKOhZ46IkrRiF929DCsGkhHLHjtuwJxmAlW0RsuaWYxF7tQ?=
 =?us-ascii?Q?wHZz?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SvQfxksCfD8eu7O4l2yT+BX7uFBwnbYMZO8xtQO+w4lP7cUa0Ta2FfXbCiJD?=
 =?us-ascii?Q?t2DvhF106s4YBaIW34WxHOmGscu06IQQXlCeCTx4vHCrv3BzQ3uGw/L+B07J?=
 =?us-ascii?Q?Ha77TM7sD2Wso7ULWDqXPMG1ydkX3PicvYdkfR6FDFfGWV5qwtaVHteARpGy?=
 =?us-ascii?Q?rIVd3XkqPLPX7C2QxRiEw0xZOdODkWwyE8VX3fu86lxpmcx7MrsQSygaucPs?=
 =?us-ascii?Q?eMYAIvIn+lnWAoeni4yzW0xxfA7OGrgxB9ets69v/W9K3m+nSyaUVXmAi8RD?=
 =?us-ascii?Q?nyM8Nolf1ohRasEFuSEp1+vLB7lghSYT4a2l9WKEcwljG+i36+tYfk+iPp4N?=
 =?us-ascii?Q?IPQt2jMTQ0mAo/pBlUSzu6tVQTLwlrutC6R+LOSAdinOylfnueghuAutEvOv?=
 =?us-ascii?Q?xPLU0w02+50luboHcRLvKWLGYdsSpAMK34h70yx9XG9xlAFfgS02R9ZUIVrz?=
 =?us-ascii?Q?OcoJB9WL/nMSwm5x4Iplep/k6LsrH0Ovn6pk1kqgIeaXP6mjfGlOodz3IZli?=
 =?us-ascii?Q?utgK4ecUK2XoUjMRKJHGAwjmCU6SdLrKr83lmCNHO2+sYt64RQppFXw1YYQm?=
 =?us-ascii?Q?sayLrOV39yfYWI1v8l+5RySu9gpgeX8rQhlHyTo9a66vhz1qJyJcv1XY99uP?=
 =?us-ascii?Q?86tJGASl+RngVzjOfObm/YrgwsxADzV6J/G2jrKJRRkR9j0rLzDDQ8RuFziB?=
 =?us-ascii?Q?e7EXZGQy+FwWuXEcA6Jf5swQk5K1pygjTO1kXvG+VBRl17S9gTMzmZyf93zw?=
 =?us-ascii?Q?I3ZfAoWwCGBb7IjnalY9m2N5WgjaZ3oiXL4CHDz7XVDBTSMhSpiD5vhN1x1G?=
 =?us-ascii?Q?yMxksxP7qkvefiTQmyrMbWQrbgL8QwASI8T238WuNxD1I/J6UpcYWzz9Oz1h?=
 =?us-ascii?Q?k0ZSGXq22iX5LYEuxrGERMXsF4PhBpMpTqCNM3QK+YSw04awVQgVb7Lu+M4E?=
 =?us-ascii?Q?GTnzy9ZN/+6ATAS9B9cUAd7IRUL8UIeccl+aw3Ex2xt1CkOu691xVbaPI6tM?=
 =?us-ascii?Q?bvN0Pg7bHcqgPFQ+2WNWfpzcXi/meGGoS1ZyBTBjdJBdyavsPJbtY2W9JQp7?=
 =?us-ascii?Q?3U2knBBIvniTBwqnIF3W9ZhXLju9I6jEc1TqTuIfSMSwmJW9sc9xN7u3AN9t?=
 =?us-ascii?Q?m6LvhTivVuCo/jZM/d4V+xfJi4quSXHvZvy17/HVIKtLMfQNaICMD3DwyFc7?=
 =?us-ascii?Q?SsBQwgFk2+78uTEDIU/MAamEZ69GmyFlaNk6hmhOfDHVbT34WxFvBznjfoCI?=
 =?us-ascii?Q?Bo75fQkxRKugPQkixYolcM2+LhUFlhtPSHfDtHkFNXJBZCW7T57SRV8YOuAa?=
 =?us-ascii?Q?NJsYpwbd8cehodZFV6RPADOjpwTEKdt566baHgh8IpAhulFk9xc7pU81O8LD?=
 =?us-ascii?Q?Tw2MQnRZQsMPZUUYPKvUwh9+Gwy5?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: b8bb2b7f-902b-4b76-e946-08dee896bc57
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB7724.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 08:45:24.2899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR19MB5426

> I know you're just moving things around, but wouldn't it be useful to
> modernize these to BIT() and GENMASK() in an additional patch.

Hi Ilpo,

Thanks for the suggestion. Since Mark has already applied patches
1-5 to broonie/sound, a BIT()/GENMASK() conversion would need to be
a separate follow-up series at this point.

Independent of the above point, I would appreciate your perspective
on scope as a first-time contributor. I was under the impression that
a patch series like this should contain only what's strictly necessary
to enable the new driver, hence why I left the base AWINIC
code untouched as much as possible.
Would a modernization patch have been acceptable as part
of the original series, or is a standalone follow-up the right
approach here?

Best regards,
Marco
