Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013043.outbound.protection.outlook.com [40.107.201.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CCD4D9550
	for <linux-acpi@vger.kernel.org>; Fri, 25 Sep 2026 16:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790352071; cv=fail; b=Fw3Lzcmjh6Cj7GaYWw1oyhn2ncHW+TYSZwsCvdUXZjU3bags8zg0i8BBCy74cnGq2EwjxOVmNNIwkvrbw6NEDvECiXUvy7sRXd0G13D1mERpj1e397cLND5wrS/TB8wr2HceDrwxn3qhtAKnAJqT5YevO03l8CVRMV3tnYMoiW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790352071; c=relaxed/simple;
	bh=PL8ghTpQTEB5hhQ/mcLR0/wKHbiQb+ybddWSx88CtiE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V/Hj4RvN5MMLCMvD1oWOD5HfVOPRZwxIDi/5n+JJFCkFDbUGseBHv+X6GT/b8VzyjbmFwcMT/LcgRTUDGBMUMKVRA/bDnfTmvaMkVct962uLg+luR3Aln1haeeH+ecna/RUCFMdKvX4iYWrc9dm64wdSp6Eawyu0PixNb5GpaMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ykc3JNSG; arc=fail smtp.client-ip=40.107.201.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ykc3JNSG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vvwe1FdQLVDui5WMfNWMRqZwc/kKNJgmIma0VQ+Kd5pCdPXY15UKvZt5qrkcNz/J/JaaPzMRWjjXDF2QAc7DLHvFt19wTPz8CyXlVE94LyM/WOCBmEGGN8bUIMuENMhD/ueTTA1qRbx3HHfiRNXkOfb4gTYdMs6Xlp9vVSIlmoMSMdGwL8+PXPOR+7cDA/fBX4o29OCjGStLyYjCSI2y+JW25aqzugPe5xNfjkDKpAuaS9A6qWevGX2jOjdv7GA45s4BV6xQccbx0gMpjcATMTVFs+4v5g1/fQEAebVTmqUeOpm9BaL5yrH2oMU3nO6ZjdhdGWYNiVeed61PE4HZ+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iN+A1F0pPn58H1j31OP0Zq5UFGB7tD+BQ1TDT5W4kqk=;
 b=e0IJ8J84lR8/ml+1PNz661hEWVJjKAkg+qkLYFYdXPLM7eFr+JZR3GMRmg8aeSE34m/okQ9jn7Fxm1ECYrFcN0TIWQPKxMy8GlBI8ec7V9WluggRkLgLzNc/QQLtYJEZb7HJQ0rK3fbVra74xewgxBpVb93LSzBWBeOH/i+t5oGJUZjSaOz69OSFvlPYP/wZ2R6lhCvlx8iwqJYiF8Hh1hnVi9QCqAvDMTFTUNcki0CHW5DHdGDCeoInav/8Rkr/qjGvMr2cGaUiAMv67l397j5kZmTm/odN6TdiF94A3PH5kZpwXrZiwKs5NMDJiooB3vNgUc1qvTehjAUldgpsiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iN+A1F0pPn58H1j31OP0Zq5UFGB7tD+BQ1TDT5W4kqk=;
 b=Ykc3JNSGavo12bvatV3FJy/ZyrbtwxzbRW6w9xg0aaoKRVzBLYk/7BvFxTTHVTX9tYyTxvgVlHKw5VD+Fn97fzQfoMLk2+/LrbxqBzA4HamQJCEn1pgv3GdL7GPwpMZjZPsT8VfSmVXYLjzXYMPnIaNzgPV8g2mWB598abBucEw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by SA1PR12MB7443.namprd12.prod.outlook.com (2603:10b6:806:2b7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.22; Fri, 25 Sep
 2026 16:01:05 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 16:01:04 +0000
Message-ID: <88bfcaf4-ef13-48dd-820f-d41b605105b9@amd.com>
Date: Fri, 25 Sep 2026 11:01:00 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ACPI: Add stub for acpi_find_child_device()
Content-Language: en-US
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: lenb@kernel.org, maciej.wieczor-retman@intel.com,
 pawel.chmielewski@intel.com, Arnd Bergmann <arnd@arndb.de>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
 sound-open-firmware@alsa-project.org, linux-acpi@vger.kernel.org,
 acpica-devel@lists.linux.dev
References: <20260925155220.4110300-1-mario.limonciello@amd.com>
 <CAJZ5v0j99C7=w-umijjqL6dVqpWh1WSq_iHfk44asG9GLLAhxw@mail.gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAJZ5v0j99C7=w-umijjqL6dVqpWh1WSq_iHfk44asG9GLLAhxw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0409.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::24) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|SA1PR12MB7443:EE_
X-MS-Office365-Filtering-Correlation-Id: 416e8fa2-1882-4846-88a4-08df1b1e3403
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|1800799024|366016|4143699003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	X8p1m5pKECEEoqDexeR5/lfJ+0yjullZRzzmKmECi17AGsZvtrq/6CVF6Z8aULeEqSpk/pZTf8DWoF0yKmiTIA5wASlGojdbiiZnF06PMIql+0Yj8pwKOgveuyxveS33POnnMi6MED2A+DhLioL7k9P9oee9sxt7Fqbje8kX9NwufHqiDTpHbOmzfV5E4tF1V6eESDMmA/Ob9dzaFHBGQU1dYaTrtj7bWc0FJ9U/p0/4IVCxR3/0Cu3Zl/fYb9fKEv/qODS4YHLBgZ691xe0FL7RPTvBdj0oaNIu/fC23M+STaMh7cdHkEqRqsdD8Um7lVGstTGO1zZ/9vix8hGC7P93iRQevmRX4rx4YW7rcynFVNCCdK1yC+gkoG6Y03mD3tD0d7qrBD/XYjl2WJbpU7RNcad4w5gTHK+b7Sq9os7x4GT6HezZaVrJKw3UsCc8MBRlNe3w7iynPjks7m8QxZkIva/YFoNdmv8AWgEmOIPv29y2L6pT7//AJAiDd2rEA9GUy4pBzop3AxJYat7VfWeBBxr0ml3VaEbnOjGEqjdu/bDHIYdfjOElmTFf2PtEWTBMjd327oIylRLOQMTiKK7UffcxCQ0qIYPZiSiyQyxV1h4vwGWNRfrQvPVHaxcA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(1800799024)(366016)(4143699003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q2x6RmJyZFNLaGRiUjJ0ZUo0K2cwcHFVaWxZSzdOMG9kcTJmczUraFNEazNi?=
 =?utf-8?B?VFczZ1Y5cGNkMTBhTE04OE5nQzRTS1BadVBYUkZ0eEN2c3g4Mm54WUdxb2FN?=
 =?utf-8?B?dTZ5cDBvb2VJeW5WcnVYZ21EQXlxQUpsUDg1SkJhOEIyZmRybUVENGE4SEpC?=
 =?utf-8?B?WG1KSGczb2VpMkVFZTNVakI3SmM3clhLYmpVUmJNTUEyNzZwWjZTSjBGMjcy?=
 =?utf-8?B?bE4vNW5wY24vZVhZd0d5U2VaYVRpYTgwdVJVV284K2p1MDJQU20yZHZjYzBl?=
 =?utf-8?B?bWI5b3hQNjV4VkcvMlhVQVZncHFIOHhNMzNEbjJVRjFSVHVSUXhnNXh6R2pl?=
 =?utf-8?B?aStiVUUrZytYdnpNc1FrWkhQYWJ2cFRlb2xPYXhUdjhxQVVDL0Z4SkVNNnVj?=
 =?utf-8?B?TnI0VUJ6M1pUdUJoWnU4MFFsbWNDSkp1V2VaR0dpNTViMS9aM1JJcHJCaXhL?=
 =?utf-8?B?Qi9Zc2cvbWtJSjBpT3ZxWnJmUjVJUENPMUprSFZBVjFBc25tdW5yYXlMSkpi?=
 =?utf-8?B?a0lISFdGZE5YWWRZRWFHM0s5ZkdSWDE3N2kzWHgrdFQyQWhQRlhUU08ya1M5?=
 =?utf-8?B?Qm5lQlNWQmR4K3B2V1BDdUp1SnlScU5wSlNVYXplcUdZY3F3VXdObUtPY0o5?=
 =?utf-8?B?Q1NrL3o2emc2MW05WHIzRDZQNXdYVU9oWlRyd1NMZzVnaXdsRmcrcU9DaXZr?=
 =?utf-8?B?NXdUYW9sWWhXVkkwVnZBRU02c2kxQnBvbFFyNTdvTnZCZitHL3lZNEZUaHl3?=
 =?utf-8?B?WjZ2ZjlQd0pETUlxVGpGcTVxeDgzOEc3NXR2aVkxS3BIUnBJUS9BY3dsS29O?=
 =?utf-8?B?Tnl3Z2VTcXhCVFR5RUNWSWQvOGNQM3pWc0ZhYnBHQWZJZVUxR05mc2NGWU1x?=
 =?utf-8?B?RVdELzFxcDZwbHdBeHdOZkRSMlZvT0lCK1ByVUE1Z2gzV3lsSDQ5cEh1a1Jo?=
 =?utf-8?B?ZUhJNUFwTStFVndPTkgySWIzS21hYm1ENHg5eDFPRXJhK1ZrK3hQakZlWkw3?=
 =?utf-8?B?MCtXR0ZFRWpKUmdtdmY2c1BHb0N5L1BqcmtQMkpRL2Rsa0h3ZnV0c0tpRms5?=
 =?utf-8?B?OTZRRXFZci8zWnRFemJUNlhKc2N0TmhLSXdLaTU2STFQMHJPMm10U3ZlSXZH?=
 =?utf-8?B?UXpmN1A5RFpMMXM5Q05TVEx2VTJ0WlEzWlJOWml2VncyNzVVTDNjZjcrcjg1?=
 =?utf-8?B?cjVtK0VvNTg0alhZWThrWGhmOW1IN01WeTdRclZHbWpGWHBrSFdpRzVJaldz?=
 =?utf-8?B?RVBGWElHTDNoRmxGRml0dG1DYjAwRmVsU3cxUWx2T1FHREZuWjh2Q1g5eitr?=
 =?utf-8?B?bFBkMTBsMitDSkZSb3k1aUROb1FtQStHbEh4azVXKzVYMUhZUDlENXpWM1Bt?=
 =?utf-8?B?ZVZweWxPQ2pkWDJNK1JTVWM4Y2xJVXFxL0JLbFdXR1dDemxkQjBIUjRXeGNu?=
 =?utf-8?B?NW9wcHVNYnM2S2NScTVhend5eFVBdGJub01xSHVKWXgrcEhlekZkMEY5Z0Zm?=
 =?utf-8?B?RWIydWJ5cXdCU3NYOEZZWXJaa09PQUQyRm4vWkU5d3FGTHVrandXMXh5Unpz?=
 =?utf-8?B?TDJTZ2wzLzdlb215L3NLRE1OK05PYWp3NzJ0RUR4bi9ISmlNWFpBYkVJOWt6?=
 =?utf-8?B?TzdjWUxvV0MrSDViMzhiT0MxRm9RLzV0VTdjQmpNcHB1TzJ4L0tWUFhQSUJh?=
 =?utf-8?B?UHV0elpYQktxUVdhemJ1anNGWktTSExxeW5jVENBemFacUVQTTlmU1d2clVM?=
 =?utf-8?B?SlFhMDlSbnJOek5JMzM1VlVQSzl3My9KOVFaZ1Q4c0N5TVNUZjFscFE0WG5H?=
 =?utf-8?B?TVozMlVWZFZrWno4cWtPclJWN3J1ZmVYQVFRL2c4N3ZsYTFlazRDMlNtcUph?=
 =?utf-8?B?VkxJUUNtRmhaWVdVT1QvU1FQV3p0cmk4c1lCOVJEZ0MwUmdZWXpvMkNMcFBJ?=
 =?utf-8?B?NVFPdDFSZWhJT2pLL2h5UVpEZGJoKy9ZK24wNWF1Wmt4ZHI5dVRuSDZOKzJN?=
 =?utf-8?B?NG9tdk9mSjVuOVM5bTZ4NUhiMmtkVTV6Y3lTcWQ0VU9kS3BNQnhWTkM4NDN6?=
 =?utf-8?B?M1dYV0toR2J1L0hyS0czVkxMUmJwdHNFR2hDQldDRDVJRVZCYWIxRnRkSUpY?=
 =?utf-8?B?ZnZQNFBBNW5aTmRtRU5XbnkzNnR4YzJWVEt3bTNUZktEVkxsZ2pLWUNVN292?=
 =?utf-8?B?c29DRHo4cnBmYWx2dkNYSHBjazA4Zmo2WkVWVmZvN1VCeTA0WG1XV2QrV0d3?=
 =?utf-8?B?OFBQR0V1OVJhKzlieG52QStjTU5QMDRtbEt2aGpHcDNPZEdVTitxb3FvNzZu?=
 =?utf-8?B?WjcvaTJOVk81MVZuM3FOd1VIVXJGVVIrR05OMmkxWlVNZlBaYWtGdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 416e8fa2-1882-4846-88a4-08df1b1e3403
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 16:01:04.7766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ttjB2ndCAwG4/S2jNoGe8vO/HSCl3/z4ns5iqTg/heATZfGdEqOu1jOZGwjsJdKN3j/NJTd0Hu8FHHTBAcsPKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7443



On 9/25/26 10:54, Rafael J. Wysocki (Intel) wrote:
> On Fri, Sep 25, 2026 at 5:53 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> Provide a NULL-returning stub when CONFIG_ACPI is disabled so callers can
>> be compiled without ACPI support.
>>
>> Reported-by: Arnd Bergmann <arnd@arndb.de>
>> Closes: https://lore.kernel.org/linux-sound/20260925131104.118993-1-arnd@kernel.org/
>> Suggested-by: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> v2:
>>   * Move to acpi_bus.h
>> Cc: Liam Girdwood <lgirdwood@gmail.com>
>> Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
>> Cc: Bard Liao <yung-chuan.liao@linux.intel.com>
>> Cc: Daniel Baluta <daniel.baluta@nxp.com>
>> Cc: Mark Brown <broonie@kernel.org>
>> Cc: Jaroslav Kysela <perex@perex.cz>
>> Cc: Takashi Iwai <tiwai@suse.com>
>> Cc: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
>> Cc: Kai Vehmanen <kai.vehmanen@linux.intel.com>
>> Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
>> Cc: sound-open-firmware@alsa-project.org
>> ---
>>   include/acpi/acpi_bus.h | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
>> index 7dbe5d42c67e8..b7771b4f36c80 100644
>> --- a/include/acpi/acpi_bus.h
>> +++ b/include/acpi/acpi_bus.h
>> @@ -954,6 +954,8 @@ u32 arch_acpi_add_auto_dep(acpi_handle handle);
>>
>>   #else  /* CONFIG_ACPI */
>>
>> +#define acpi_find_child_device(...)    (NULL)
> 
> Well, thanks, but I'd prefer a static inline stub.  Any issues with that?
> 
That should be fine, I'll test it and send out a v3.
