Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011022.outbound.protection.outlook.com [40.107.208.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977E43630BA;
	Mon, 24 Aug 2026 15:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787584348; cv=fail; b=ZOoZq/6nL1lm2VlMG6wwCRmgj+fd76UvE8VuN6mr5IeBpzpqKRVQxhwpKbq/AOWadORF9kya8F/0ui0u3VszCuk3drR+gWm6/1JyjWo8wJkmrk/1jhq2K5mYKd8yBcUScuep7iW5UyfNbSF8fv+Arc05EFQRiIcfpQy3arz/SoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787584348; c=relaxed/simple;
	bh=YBEDcmtVTnbAo1VfBtjGi0WbEGrywloMq73RTU00lrk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DaX1RkjIVNepETeQOD5DFDFDxVm7AzQP3biS5XRGgitSJBmHn2dl6RuOVYqoRJaeRr8WTaiutJj255X2Azbi4qigfU90ukncGCwCXSstujMDW/jBkY67xnMmHZTGW8u7apTkZRH6kBEC3tTvrWGH87fVqELXTCb33snozS/VnNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AEYPEHXz; arc=fail smtp.client-ip=40.107.208.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AEYPEHXz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s1i3aNFjcySp1/1qp38EsuxefONKEX/Vh9FYOGEuGxrZrIeGQE0kwaTW58kRQJC1xkmU6y8mMOeaD6SyvJS8f6o8Jsjz0gi4nfAdfN0sAb0CJsBIgA/cL4CZhxDelWsoC1yZn+GxNRi4TZvMvtby0VINQYvw+6htVzTX8gYJczjT8gedEnSTLqGG6mN8f1ZgNZREvSeAx0JihnpDNq/8EG9x8k0WyV543OQoC8M/Ah12aUb87MTmgjILpcrznKK9cCD8mHbZ0DX7UQoV0ocRrxy7XsaTKzItbFWkCB1GACbY7VZHUDMMX/s86f1hphA/9Rhl8xXWNvauBtIfazgO6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eIE5j1GWf6UYRl9nBFOBMCPbRKuA8VN6FLobxrQODXs=;
 b=M0FBUaGYxQPqdokSstp3jzpo7B7hYVdQtrV8VesPZ6SFlIiPS8UlZCtSPx8E7Hdah/G8gZh303GEkg82sBvjTNZ8rPkq//0wU2thigQOkbXDMWojjEg/q3qKPc3jc0xNclxHidBfx1z2pxJCJe2YrmUqWlhEL7p+g98MIlaH8PTFWlf8FlPmJ4WQwhLYdf53cM/2g22ORP7M/evM1IJPhZWIgrV09Tkx3XDK74LyeDQ5kb5DsQbScWF0BzIqj6Ph1TGlFW5Qb4IbMqGXJ9rafVRqJxZ1XKdF41bLPTk+HIKps2HxVFAzeVwwivc8tfKnYfoXwM1/EBKvHVeVJVnOUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eIE5j1GWf6UYRl9nBFOBMCPbRKuA8VN6FLobxrQODXs=;
 b=AEYPEHXzHJb+MAmP6BiS8PMw7Hjv4e9J5zQ8gzwMAg+kvG2X8jfm2UP25yF6SUQ8LSqCK7L38UXd3rGHQCI/391OrUb8m/bxdSCpYo1hp/BdsKv1lK8hM6qWFMwbILYVd/M5TmtKJG+qdgYGcXjCQHVjiBtedbNr2bJ6RW/nFcc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by SN7PR12MB8771.namprd12.prod.outlook.com (2603:10b6:806:32a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 15:12:21 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0315.012; Mon, 24 Aug 2026
 15:12:21 +0000
Message-ID: <a89e95e2-abaa-4ea4-9be2-2a179f6f5257@amd.com>
Date: Mon, 24 Aug 2026 10:12:18 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpiolib: acpi: Add ignore_wake quirk for ASUS TX Air
 FA401GM
Content-Language: en-US
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Yao Qi <xnorigc@gmail.com>
Cc: westeri@kernel.org, linusw@kernel.org, brgl@kernel.org,
 linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260808155513.2221976-1-xnorigc@gmail.com>
 <aoqui1OfwEfsmQRu@ashevche-desk.local>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <aoqui1OfwEfsmQRu@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR16CA0014.namprd16.prod.outlook.com
 (2603:10b6:610:50::24) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|SN7PR12MB8771:EE_
X-MS-Office365-Filtering-Correlation-Id: 21e34875-9734-4836-931f-08df01f21842
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|6133799003|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	0gRFlxjiI502EETry6l7HY5GIOoeRKX0vbOcl3nfh80ASfUpAJbWicQiHRhSsCdE1QvxZJ0EEzgU+UNn6YunemesJhuzgc5SxfH6Zz5L96dC6bv5+6Bq5zCcyOGMEbOVMbjFgkfMKc/+yLRbWHVvqxgf+szp3dvdeaeaMw0V/N9pw0nTfQK9kXIacUuIGTEyS2gQ8HUDRW9XlCAlD0Kkvl/RSCv3k5ljZE6qFPmeSoD9cNOJuVr88au2R9h0tNJ2Kt21ywwlaji7bVUUjHWq6bQd9iyNGeWzSizFczUfqWL/FNhQK7D92gPYYrofzN1xSysc4HsLRuuj+p6fw1+8jd3ItOlOy/xx0gZMDoJljpbkfmVeKmODKMrlbTm/BRA4so/MpbukvpxLC0qiVqy3MMKNTbDbK+MYpmGSYzKLdLpDpGBBPCPz4xmQ4olZauCaWRBlPHuK8LOIXcAFK19JQE4XijoLUNCbQ/8QmolOcSQJ13uYKDL04uU5GbuYrTEwiqkvMDMXJH2u+y7qzt9RDS0A/jGjKov0UZMZ6Fw5zBKq0qHFVAQ9GYbhC9g3pstpQUTzRO8YEr+rukbIn5mxRRI/r6Q6vlr4pyViXQNQAzsjz4t81S3bmBUKKEWjRsKLYThHfRKwXxsbdE+uFInl1/HR//hp/0jXkVjK5qSJ9A0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Wk1QbW1ZOS9aeXpRSDFWTUViRkVLWGxCQXJDb1JrU3RJaU80NTdJbDgvSUVO?=
 =?utf-8?B?ZGxSTVgvd2NBOGJ6QW9OV0Y1dWUxUTVHMCszOG1WTG4wd0VOeHVVb2dUeWo4?=
 =?utf-8?B?VWgzTG9McHZVR0Uyc2lKNENFMnlKMTlITitEVit4Y2NjbHpKTDdZRmFMQzdk?=
 =?utf-8?B?Zk1IWlZZam1lbW9oZzU2OVo2L2JyOWVrdFV6UXRXYmJKdFNHSDdBWWtHTkxW?=
 =?utf-8?B?TitCeExRWGNSTDdPTUg5NGFISnM3YW9lU0VWK09sYVZJZkRCb2RYWWpmMGR3?=
 =?utf-8?B?TXIzTG84NVF4aVJOeEpJUWJ6R1dINjlaZWQ4YTdlclp4VDNtWFp1YzE5YnFn?=
 =?utf-8?B?c3BPSmZvekVVcFAvTTVlT3cwQXg4eTNsQjMwSGI2ekNVVEVsdWxkRVBPS3dX?=
 =?utf-8?B?alp3c3A0R0ZyZGpJaGNSZzB6R1VQcjgrT2ZOUW1uQ1NxdjJTaXBmZlp2bWtT?=
 =?utf-8?B?eXZFa0J3dW50anZEYWJsV2Q5MS9menJ5R21raEZaeWVFay9VT245UjBGZ0sx?=
 =?utf-8?B?dmlaWWFYdWsraGJ5bkQwSE9ZMHNNdUxLeWxRYnM4WDhZaFR4SFE0S0E4NnBG?=
 =?utf-8?B?YytETjhoek80ajBQYStqS2JJMHFlSXpqZWlUcUR0d2U0OThHeWdhNitjaTRo?=
 =?utf-8?B?WjRUL0thK3pRQ0p5Snozd2Q4M3kyQWZxWnRzTitkQ3hGRlNtRmZ3bTAyTmpl?=
 =?utf-8?B?QXBVOGhPeU1pNjRRNkhvblVXYmh0OTRCTXF0dm9qMXhFZFBHQWtPUUxOMXdD?=
 =?utf-8?B?UTJZaC80U3F4VExPS1ZkejYyclVPWkVwOHZaSnFxZjYrT1cydmYzMmlkOUQ5?=
 =?utf-8?B?ZzVsVVRYTjFzNElVdTREcG1oNk9hTjN3NGxUTE0vLzV5dU53MDl1THNXaWpC?=
 =?utf-8?B?Wkg1eDB0ZHNUV0RVY01jOUphcHpEWEMyYTRrRkpOSHpVZG5ZcjFWalhBVHUx?=
 =?utf-8?B?a0UyMUY1WU1tUzJVWUlrZDNBWjVHNm5NZHZsNUFOWUF4RnZBUnlINmoyOXZ6?=
 =?utf-8?B?QnRtRWRtZWxSMjNXQXlNTzhNOE1DK2xyZTRLNTdlNzRpMFRVNVY2MUxaRjZK?=
 =?utf-8?B?ZUNHZHNydEdQR01VZjZCN0F1b2IwU0R3NkRqZk5TMldXY1FsbURubXlDQXBC?=
 =?utf-8?B?ZW5DVVM2VTRZR0Y2VyswU0o2UDk2TFkrcHppMUhZU0paWTRGTWJReUZvMlFT?=
 =?utf-8?B?eGc5WVAzWCtvSVhST0pwZEpBdlMvNkhORGsrZ05IVHV6S3NjdVVaOVp2WjF4?=
 =?utf-8?B?N2gyZ25ncnBkbkJ0L0ozSnlMbWRsWm01blF2NnNLQUhZQ2JRY1FaWmZ6Z1pC?=
 =?utf-8?B?cTFVeEdSWkxBSFh2aDg4OXgrUDFDbVgxUW9uWG9hL1ZWUy9odHJ5K1l3UDdx?=
 =?utf-8?B?RlhzRUxDZEY1NThGeXIzZmFubFlrSHBJNGtZVU9PeUNqRDFnSUxyWnZzMmkr?=
 =?utf-8?B?WkN1L3c3SXQya2RSbW9zcmIyM3IzajMyVmpGbzdGYU0xMnpqMm5Zd2tUSUxG?=
 =?utf-8?B?ekhBaTJIRDh4MGpLbGdjTFdaL0VRRGxjL3ZjNTRnbVh1K0hKVmQzS1BYbGo5?=
 =?utf-8?B?UHZTRHBLNVVzcnQ5OUpDZkx6eDk3Y1ViT0p0ZnhnNHd1RTV2MmxZMEk5SmNk?=
 =?utf-8?B?OHo0dGt3WjFOY0U4eXJwK3F5Qjc1d2tJdkFxd2F4bFFOM1A5N3pyRHRnTm1X?=
 =?utf-8?B?UWdPdlJrRGcxaGZLK1pNN3Y1bzN2OEpLWSs0dC9GdDZQN3R3ZDhCUWc3NWNO?=
 =?utf-8?B?bDh3TkUvZ1Q3TzBrMHJsR1JoYVNOTi9GamM2WVp2UVBxWTZzdUxXOSszL2gx?=
 =?utf-8?B?aThSbkhwczFhaDNpVERGa3Bpd0NSczVLVUxLRWNzSHc1czJlcER0L1FVbXpx?=
 =?utf-8?B?MHZUek1vaXI2UEdVbFdPY2d4QWNiak9ZY3FpYytDV253L2FJdGhzNmFVcjJv?=
 =?utf-8?B?MUxGUUNVc1RhaFpITXVhcGRVQmgzeGxaR2V4UzZpL0pxdVoyZk5QM0NERGw1?=
 =?utf-8?B?UWdXVjVyU0xQcnM3cDB4eG5pbDBIdlE2YkoxMm1BNlZkV1hXalBFY05RUHVK?=
 =?utf-8?B?MndqNUNoSUR2U3p1OVlrRmRMSktSSFhXcnUwYnQ5OVphMUZsM05QRDQ2QTRT?=
 =?utf-8?B?MHBnRE5mNWplTlliQWUzbmtab1FSbzNEOE00bkpBMmY4SStKNTJ2dElHM3Vu?=
 =?utf-8?B?VlZIM21PMGcxMEp1TmR0RXNrOU9ZdXlwOWVEdUJnQkF1cVpzeTVrdHlINlI3?=
 =?utf-8?B?d2N3c1VobHFiWUUyL1E0YTFNbHBncVdLUTBkWXo1MGQ1eTRKRXJWVkZZQ04w?=
 =?utf-8?Q?Xq9L0G0OJ88D2WiX+0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21e34875-9734-4836-931f-08df01f21842
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 15:12:21.2918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lv85o9XCZfJnP9QV5sEPx5W3jYl23HHL5L7JLwxqF+6D3tQ5zlMGgYiywELs/0Le15DgqZmNseSWyXcr0MqLOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8771



On 8/23/26 03:25, Andy Shevchenko wrote:
> On Sat, Aug 08, 2026 at 03:55:13PM +0000, Yao Qi wrote:
>> The ASUS TX Air FA401GM experiences immediate wakeups from s2idle
>> (Modern Standby) when suspended with an external HDMI display connected.
>>
>> This issue is caused by spurious ACPI event signaling routed through
>> GPIO 24 on the AMD GPIO controller (AMDI0030:00), which triggers a
>> system-wide IRQ 7 (pinctrl_amd) wake-up interrupt during sleep.
>>
>> Add an ignore_wake quirk for GPIO 24 on this machine to prevent these
>> unwanted wakeups. This has been runtime-tested and verified using the
>> `gpiolib_acpi.ignore_wake=AMDI0030:00@24` kernel parameter.
> 
> Mario, can you ack this one?
> 

It's likely very similar to

https://lore.kernel.org/linux-gpio/20260821070651.39763-1-vaknins33@gmail.com/

As you can see that's also GPIO pin 24.

Can we please see an acpidump to confirm though?
