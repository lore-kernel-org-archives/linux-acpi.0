Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010065.outbound.protection.outlook.com [40.93.198.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9FC4AF667;
	Thu,  3 Sep 2026 13:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788443070; cv=fail; b=s90lgwELRtHw9KaZMY5hIFJV6NV5Vd6SeZZ4Hr98Unj7/9eFVUe+c05XlhPhrYZiEIKXTZsZtYhzji1w31X5yRVH+N5Q2Wy6M9tnyeLS99k+cRZx8p2VzYezMHxVXXEJuPHpEptZJtA2zecWjn73GtHiodNtHyISTaXhjAgsmy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788443070; c=relaxed/simple;
	bh=np3kBzbYacG5WvHCRtlL3y3pcTkgDMmloGYIyacF1xo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b47MXecj3lu2LUY1iP1vy4oi7eDjeIOGOjZE2Rz2VnLwDsUBf8CtnwTG0WCgLb76+xcIyNbfN9jx/aofK7lVkD13eg+lHhKci6fuGI35X3g14GBGqW1k4pWPG1r+C5ehV9MxGj6HvLPns5i98lVAym+I3/+ZWzjNUXSF4COmCm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cZjAq+bg; arc=fail smtp.client-ip=40.93.198.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cZjAq+bg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PUVUi2R27TLay22wRRSZjwoqHKWJDJV+js5vJOssVk7teYwrUTuM1l7RMQUZn/UgKNO2BPaXHO/27dVymi6l2QQET2mE4PZ9NRq1zR4qnIM2vTeYyyzp31uj7/a7OLdltaVyg/rFDVEn4JjEP76C4oNahpTxozGJPjlf2/hCGmuIFnpsaZDvnUJ92KjCtwV3nUudMm4ZXkUAA+CFb7WMA3QNuWdJq54Zsf2+kCHiSQ9RBr2opwpfPibr+frsEXvL1HDGWmXcKbtLDTptb05VFNLinMK6RcB+8ZuKXZNbZ40NfWow0sIYV+dfLCASmkGMKB3zKHahU40g/LB7xCsnBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kc6pzNteoYY9jf5qkyrfPVHsRpqroz2qLAYPTr7x2ek=;
 b=oj425c22BjCe1ORpvRu/+rlc4EbPPGuS8sqjNUJPSLX/MNt2nzp2HLhtC1nohDU+pFCs2MaDWHxoqQ2ih1z7BflEBdLUaXE3jDHkZEI33xFv8EjUmKyYKFFuma4Tlqv36czRyoxQVqncGw2/i8FFvn7yJQisKuPe662+Of92B+2fd4RQ+a7kavpSYX4dMKcVqe4SJ6jxngw8zhdtcG1WJluTkSFO7zyV8E0tx96NTBpzE+vXuaUYlcmb0J9Le3xzAio6UNXGI0lSHuXV3/ZsEDiNXNHx8JyKnn6fq+cJbVelLqEVdZtHG8L8Xui3XYMiPM0hqN6qOYvq2nyXsqGwvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kc6pzNteoYY9jf5qkyrfPVHsRpqroz2qLAYPTr7x2ek=;
 b=cZjAq+bg8T54xFY/8xyTiqDg48vVKje2a1w/+okF0MiaZpC9iN4+JngeE3dJbOsjC6MvW9wVbYKigwv3pqYTy8GttuFpA7hCygOdg0sTUkSGLDf4kGiwtN+5fbhXLve2OanD7EpyBPCZLDLkIahakSkrUBOUYp/RxI8wTkuhCS8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by CYXPR12MB9338.namprd12.prod.outlook.com (2603:10b6:930:e5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 13:44:06 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 13:44:06 +0000
Message-ID: <7f0826cb-13a8-469f-a098-c7212efa26eb@amd.com>
Date: Thu, 3 Sep 2026 08:44:03 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpiolib: acpi: Add ignore_wake quirk for ASUS TX Air
 FA401GM
Content-Language: en-US
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Yao Qi <xnorigc@gmail.com>, westeri@kernel.org, linusw@kernel.org,
 brgl@kernel.org, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260808155513.2221976-1-xnorigc@gmail.com>
 <aoqui1OfwEfsmQRu@ashevche-desk.local>
 <a89e95e2-abaa-4ea4-9be2-2a179f6f5257@amd.com>
 <aplgRRCxGEC-ahyw@ashevche-desk.local>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <aplgRRCxGEC-ahyw@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR02CA0029.namprd02.prod.outlook.com
 (2603:10b6:610:4e::39) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|CYXPR12MB9338:EE_
X-MS-Office365-Filtering-Correlation-Id: e735e163-90f3-4015-7cd0-08df09c16c1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|6133799003|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	12juWGphEt0O+GmWBySWsUS5XQrT1n61t4ot7A3tDpHIn4r3B1WCNHgJ1Uq+bE3Ti+t4U0qcMsKxaLKSL5In+ZQu4ilKZYzIhLX+/Eq7T0xG1k5k1HebvNELrr0lWcH74vExcfl7YT9ZIjf5glZEYIaURdxJsuFBLDUwgtmlra2aYt+Qx756Zzy3B5vERXL77bsljc3P75/ti3S44/YdKxYlCTNLSbAbqSO6UI/nXKKiPBpr9CxfGq301WRFJSCQa6pAGWX9G5e141YfQnfNKywgDZia3NlKLUwGjgVOiiU67Ngb3l5g1Vci6NM56E/c56CsPm0cxvcul3hM/VOkYa5ObWiUHTcz+UHRl0F8goQLrRBxF4xRMvOeoGDptHkwZQVtGL2xdUB/+ne6fHt653xZJtL3hnJxnNOR+RlEbxd57qxjLEzXWTmFUTY9cFtfc433PCF05cZQAPt5F3DJKTaKL22uSflRN3UIrmxyWaWybViIJJD+T+SqOTz3OA4h0TxZgKZFOyFElRe+Tat0KYIN4MUfXxDczqBl2akAe6Xpu/UHAYF9AWF1JtsvbeGAKxEH94kOCXlolVILnFK5FoFNzts1Niivf+Mrd+rlt2kP6UsEBPObjJTYXBaMaZd605bRgIxosiAGkkXxDem5OjTDCBkZSLrvQMMzIHIbXRs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(6133799003)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nk11dmNRckhQYS9zUkxLMCtPemhRNFVha3ZMcHk5ZUFEQ0ZhblU3dWtyb2xa?=
 =?utf-8?B?cHpqMkJZSE9aRThjYkZ6U2V6WitMNGlqd2tjczNJVTBuamFHT0JMTVY2UEdq?=
 =?utf-8?B?M2Z6TjJMWlpQSllDNWdqTWw3cGJxckpMMk42dkhSaHBrZjlQQUVlUXdmdk5u?=
 =?utf-8?B?RjJUaUxGM2lpYXVQWllhRXovYTdSNHphZ3ZqWUlwcnJtNjJqRm5GTGFML2hB?=
 =?utf-8?B?MGxFb1JGTFhURlNLa3FWbmlQTmJDQlFYc05pdVBxdnVFdkdhMzhhYXV2VXVZ?=
 =?utf-8?B?L3Jzdzc4UkJGUU5Ya1BSUVNKMGQ3VVpDcUpaQjB0b1ZUejIzMlFVdWdqLzRj?=
 =?utf-8?B?VzFBcWxyNGh4c1JiSFhudG1YVkhPanpRWHl6dUVtelFTYllqWlZadUNIb3NF?=
 =?utf-8?B?b0lYSnZpRkhib3pHQWdlTkVqUXZielAyUDVqVWZHOFR1b0R1cTNhZGt2ZElw?=
 =?utf-8?B?SGp5VTk2TXZYV0t2NSsybVcvdnU1RmNPdHdTNUpZNDl4Vmtrd3lWdHhORFJZ?=
 =?utf-8?B?L0FseFliMXM1YUFTaVJnWjF2OER6Qlg0WmJQeWErMjVkVDNCb2dlem8wZHVy?=
 =?utf-8?B?dUJhcWtTTVlxUzg4cko0K0pzZWdnYi9jM3FHcVpYRlVtUjBML2lYNzZ1VGRS?=
 =?utf-8?B?UnpPVmE1dEtYYWdSaStEN21veDBVRSt3MDIwL2NCUFlDTnc1SFZNZE9RQlJC?=
 =?utf-8?B?WHFwbnV4TUhrZFIzVnNicWJENG1NNWFBSUxrc2tRd1BWc2w2STBGMzBoV1ds?=
 =?utf-8?B?MTZ3U01TV0FNd2JDVjl6Vmg5RElLRWdNRVMzaHBaRnpGRDJxSFFGMDVOLzZL?=
 =?utf-8?B?TzBLZDkzT0V3TDByWjYwcmhQNXhxYnRuejZvc3BMc0dubERUK2t6aUdWWENj?=
 =?utf-8?B?MGY1S2pNeFNaNDNWd0hCNW1hZ2hQcnppQzREWi9YWis3TngyeDlMMHlKK0Jz?=
 =?utf-8?B?UVAvVUN1QmRHYjBMdGxTeDg4Mmc5V2xYZWo1ajBFNW1qTVIva1JFKzhCWEFs?=
 =?utf-8?B?ZTFBZWlwTUZDUW1NWjkwZkdHMEJvR2JZanowN0x5WlZieUJwQkYweThKZUV6?=
 =?utf-8?B?SGRvMzMzMlI2dW0rT0tMUldBcCtHTExWVEc5eWUyYmRvNFhxaytBRVJRaE9j?=
 =?utf-8?B?cVF2T1FVNndFS1hwdWQ3Slprb2tpTTd6bFgvd0JhVTdUVU5WTmdKUStvKzND?=
 =?utf-8?B?eklmOGlKdTJ0YlJtVWF0OEdnR2xnaWdkaFRmc3R6ZU9xVUV6RlhEZ2w4MzJS?=
 =?utf-8?B?c2VyejdCczJ5Qnk5c0N4VHFpSzVrVmwzR0tManpUMG03L0pxeW5uUTVoZmNl?=
 =?utf-8?B?RXkySWhTWS81YkkrV1EzbFZueURsREhnWTlRZlVaOWNqbGs2WkQxZy9jSVpG?=
 =?utf-8?B?WExrMmJ1UWFJY3o2NXphK3Fha0ozVGJVWlFjZnFNbkFoVFdRNGFOV083Q1R1?=
 =?utf-8?B?NTlmMWh1SFdlRGtsSHNaZU9OcVRZSnlmU3BtaTFQdTV2cUxPZU1XOGVxOGJO?=
 =?utf-8?B?TnFjWDNvQXZEK2xpNzlDakRTMTlTRS9QbWk3SjdnR0luL2w5WWhpSlZudG83?=
 =?utf-8?B?VnJKMXdEU1Z5SDlDcm4zdTRxVWE2TTdEeXIyeXpKcTZRcDMrYSsvRzV0RUFo?=
 =?utf-8?B?RkMvbGFnZWRnbnNxNmtpVDlORzNWVVVYLzUrd3VDVmhtSmU0SzV3TkFQNXVz?=
 =?utf-8?B?WFFtS21qaUNzYlBYMHd2WDJmNmgwYW1wdFk1aEwyYVZYQnZUZVE5bHlLQXNW?=
 =?utf-8?B?di9iZ3BLNUphUjZzTzN4bW5sNVNCUFNYa1NpZnp4NXRSQk8xd1ZiM3hvNmRB?=
 =?utf-8?B?eXpaWTdiODU4WnJYVTU3SjNHdHFOK01DMVJlY0pudkF4NXFyelVwMFpKRlN6?=
 =?utf-8?B?R2Y2Q2xOb0NiRXpvZFdTclRra2pueEErdE5WQzc4TWg4dVY4VG5nWFZBVHNr?=
 =?utf-8?B?dFFQb0twclVtaVdUTU1oK0FjaDJ3SUJNWXR4TnRNNCs4ODVjNHNtSmNwTUtz?=
 =?utf-8?B?TEdRQTBvM3EyZ0NYRDhXbkNUQTQyaTFEQ2ZEVVRGVWhpcHhHeHJNdzZzNUZt?=
 =?utf-8?B?M01PdjNkMS9qN2RlUk9JcitaWWhWQ1lqMUdDRmtXazJ3QXpwVHZvSjBnNERk?=
 =?utf-8?B?QWYrRndsRElhNXF0K0w0S2d3dmJURnJkSlRIcFBIblhmWG50SnBORVdpQ0pn?=
 =?utf-8?B?UTNleE1tZ0dja2JJMlN3RnVpRmgrSGI0anhEejBYcTN5Y1MvenROYWJnSDFE?=
 =?utf-8?B?ZlFFMmRQSk1vUHk5dm1VK3JXV0R1clFQOG1tdlJZSjMzaFVXUEl6NWRteHkr?=
 =?utf-8?B?U2ltWHFaNm11ajBGUThTZFVxNHFJeUlzWjBITXk3OGlzME9SY1k4UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e735e163-90f3-4015-7cd0-08df09c16c1c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 13:44:06.0812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u1eXJI6COPkXSe0sSHlxGV2wl3zcq4uO0ca99s1XUqSvfhvclSE3+G4Xl9erSZHFhiWBNYOLoLeVpD1dl006ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9338



On 9/3/26 06:55, Andy Shevchenko wrote:
> On Mon, Aug 24, 2026 at 10:12:18AM -0500, Mario Limonciello wrote:
>> On 8/23/26 03:25, Andy Shevchenko wrote:
>>> On Sat, Aug 08, 2026 at 03:55:13PM +0000, Yao Qi wrote:
>>>> The ASUS TX Air FA401GM experiences immediate wakeups from s2idle
>>>> (Modern Standby) when suspended with an external HDMI display connected.
>>>>
>>>> This issue is caused by spurious ACPI event signaling routed through
>>>> GPIO 24 on the AMD GPIO controller (AMDI0030:00), which triggers a
>>>> system-wide IRQ 7 (pinctrl_amd) wake-up interrupt during sleep.
>>>>
>>>> Add an ignore_wake quirk for GPIO 24 on this machine to prevent these
>>>> unwanted wakeups. This has been runtime-tested and verified using the
>>>> `gpiolib_acpi.ignore_wake=AMDI0030:00@24` kernel parameter.
>>>
>>> Mario, can you ack this one?
>>
>> It's likely very similar to
>>
>> https://lore.kernel.org/linux-gpio/20260821070651.39763-1-vaknins33@gmail.com/
>>
>> As you can see that's also GPIO pin 24.
> 
> Right, but this will need still its own DMI entry, will it?
> 

Right.  We just need to look through the acpidump to confirm this.

>> Can we please see an acpidump to confirm though?
> 

