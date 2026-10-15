Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011065.outbound.protection.outlook.com [40.93.194.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6693937FF76;
	Thu, 15 Oct 2026 18:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792090142; cv=fail; b=kcmJ+FwarV5tBpXQ9n+BZQZNDHVgh0CF23/5xyJWwUNtfCC0e4E0nacNfGCKYWE65rgPokc0S/+Fd8b7iBGxdwogBOJwEHJM+wGWAZsGmupPlw5X8wMWMbxKuGIHR4XeUTaDF5apfieuwhTk658JyznICjkDdlRbWFcoY63wSiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792090142; c=relaxed/simple;
	bh=LOJ76hchDW9wIB8UL2hPUb+z0oIJUtMkKRXIihvpfB8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IQWDon7WTVT8+MzBNLlh4nYmfYxYfz0t4gQbKimsiw2HCwmk7FsHSJOn5wcB+sOdQx7RPX8cH+2gw8hVhDk/+JzhYNT917RdKJouJhykHlR5Kw6cA7UzWuXCFBnG80bq3XxNfdcxWMDCoYlI79F76yobfy6MuKS0RXG5zyEVuqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=R3cxzK+n; arc=fail smtp.client-ip=40.93.194.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="R3cxzK+n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ugi+PhhI1i+TLKu92/s1/ogfrwm+RNM8vpODDZj9xp8Cz6iRt/4L/8y/1p4UWqzGLNw5rJRFHa8dwdHFAqc4bmScIxJYCdgqRLy8hztdm9SnoXVUp00XRvU4GQeQ0ljRh4IaU1+/sadSYMfTFUTYjmJxkddSWz9oyutSZvAK27efgpirO5yWiUHidle+IqJCJrHO54ZTo/v/5yfxsBIEuOxtD1wQjv9Ei99WCRiZ7rPyaTd6MZz6foaOZ/y/nw4zZ7A8OyH0fv8oNnidIL0y4ZSPZBLoDRycuIRKmdBBMJu5GFMnSvgP3is5kQHrbmgjgtcb/IgJiGXsQ1y8sGiP/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWp3vG3NLWxBLO/NysIiu8taeKci2MVB1xt5hvTDWpk=;
 b=RgQz3HYGRG5btk8DcM/m8YQvB+/50cNpoTewVG6uKs1lBSpoQig7yCpp2RCzFn7Y/VcurgO+ZegP+ll08QSiTpqWqqUuoEM8jsw3WBKXPQcaRyNTGteUHY4QzNHWpKz54TeR17jT7O+51wA5Z5atHL9E9A1RiCeJ2hh6myd0z45d3Vs9UGVJDpCaEOPKQy97Lx5+rhy6RRyZHm96YCtW26ZszBsHvBofbW5Szsueq4kVEJXVdJGVp33b7YgZGXUkFIRhUaANqL6D0KBnm8byfac3uFhZxkBVUQVK1gGCL48SjTxDCrLTjEM9W4bJewXN1SeXc3JsnSu/vCHWZv0Y9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWp3vG3NLWxBLO/NysIiu8taeKci2MVB1xt5hvTDWpk=;
 b=R3cxzK+n39O0XrrVWKUonXAZgwP8SY3ywQoL/yFlrw0PSIfDquM3SXqTaJIWCMjytXtvqIxPkDETIF1SEqhaU7mTsCsEo2Kqz0j0eDIgbWtF+55h9Bje/s+1rpquWZA5atO2cusNm3Yw7FD1RrwCJU4i4ysChPn/MpuM005X8fs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by SA0PR12MB4352.namprd12.prod.outlook.com (2603:10b6:806:9c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 18:48:47 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 18:48:47 +0000
Message-ID: <51c151fd-31cb-4ebe-8f3b-eb7634e68c31@amd.com>
Date: Thu, 15 Oct 2026 13:48:44 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: ThinkPad L13 Gen 2 AMD (21AB): Caps Lock LED broken by ACPI GPIO
 11 interrupt conflict
Content-Language: en-US
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Nikodem Sanecki <nikodemsanecki@gmail.com>,
 Abduvaliy Abdulazizov <abduvaliy.hbai@gmail.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: westeri@kernel.org, linux-gpio@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CAAUQFRPW-rbcZV-=qV1NMjF_358sdJTiGvQuRxRqAsehY+J9Qg@mail.gmail.com>
 <atEaguJD7dh7xNs0@ashevche-desk.local> <atEb6FN6ZbKI9xgf@ashevche-desk.local>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <atEb6FN6ZbKI9xgf@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:1ca::8)
 To PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|SA0PR12MB4352:EE_
X-MS-Office365-Filtering-Correlation-Id: 17be10d9-0bf1-4be9-e43c-08df2aecf1d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|5023799004|56012099006|4143699003|11063799006|261009223027099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	JHFYrv+rcb2yC3HhpTiG+1C79fs8UdR6EuATxo/varIo8ik6T7ceMDt0a5RXn0AU/D0uZvvVbuN/LYA3p1Z5o1bQTL9BU7IVj5I+S/Atql28vYxmFnLBl6+wp4Sf1w/MO49mTgNuygesZoauRiAx80iUXIWSTghVqzEBCytj1I3h6VJs05fDvI7MuC6Wwe68+xb4aQbMxzsMKJ3BpLuRufJaADqM4SUy5iYSE+WloRY6z4r0RD0cspSvCq87bTf+G/9yoXhGEVJWM+vYi9FT6+qQG8fyc+d2cpSslbD1rnv+OkRp2sgubLpVjjDH24Gy0Yp5fXg0UdpGtgThOnaFXX9anbhheWlB6JY2pmtLKI36gSl6N0dfwipS2Zxc6RJF6eObhk213yTzRjPa1PNQQDAAN1SgTJdikK9tBrkBC2ISYRmmvyvWcPUj1TpWGlueyuH5fDC9KgYCXuLHfXw2xgabEwuXk/vuCWzs5W/2iOr8NudlKr8HRP2gmT1Rc8bt1f7nYWZhp+sFsW458dkXDS0J9kT4gGJw5GuCk8UmgiVMrIWbFyUfn0phUXArMyFphld/jDPbb18dVbc7q+PtAawwF+m5BWo5sCeYu+sIQEcY1mNDsxfGLTbkHdMkVkDw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(5023799004)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dk1rYzJ1Z3JkQkVJR25lS1NIeHVhWS90K3c1QWFudEJBd0xDTWh6VHg1eGFQ?=
 =?utf-8?B?MSs2WHlHUW43QmlxVVJFYmdaTlJBZDJ0bSsxN0drQkFYd1Ztc3EyUUQ3ZHcx?=
 =?utf-8?B?RHZGTnc5cTRXU2p4aHNOOXh2d09hSDE4STJDZklJeWZGTWZsNkRiZlVHMmZv?=
 =?utf-8?B?SHZLZWZNa1BMMlJMWXdnTnFwWnJIejNvSlJKazU0clR0SDZCcVNUOS9XZXlD?=
 =?utf-8?B?MklxcnhOcytIcWUzNEpMK3BOSlpqM0dRYlBuc3BFamoxZ1VkQlBzY3VtbnRG?=
 =?utf-8?B?RUtYb2tkTnBJejN3S0ZpMnBPOGpjcWdOaGw3dkZWT0NQNFhLWVZXVmx2cEU4?=
 =?utf-8?B?V0xNQ3FicUU0cHpBZDdCNUJiR2hLb2c4OWxHbGJUZm91dm5HejBGYlBKekRt?=
 =?utf-8?B?OXMwaVN5VHN6UnZvK0dzT042OFlyUThoMlhSeVNxUUdBUGx0VWwrSy93RXpR?=
 =?utf-8?B?dFdEd3JJNWdwaXdVcFR5NzVYVHppUmhnOVMwM1JiYWJydDMzUElYL0VUb1pT?=
 =?utf-8?B?VlBxN1FxUnZFNklsMG9KY1lKRXFLUVk2N0ZTclIxb216cW9leTMxRitveXF2?=
 =?utf-8?B?czg2Y0d2WTZrWEVtQkJnalVNdjdRS0ZSMjdPeGI5ZGcvTWNnSFV0SnJ4V0Yz?=
 =?utf-8?B?bHYxMnJnbkErR2R6bndmNDRmcGRCdDBNU2FwU0Z4cHpZZll4aHdIYzhVcEZo?=
 =?utf-8?B?UHVjVkdXd3dyckxQdWRZSGVjaFd6Rzd5TFBHN1pVdGYzbUtGcFNSMXZtTC9H?=
 =?utf-8?B?RTNIQ0ZzVG8xNEtKREhvOTZkN1VpRTNhQWpOYVlRZDZZcVVNVjIrVlVxNHBK?=
 =?utf-8?B?a1UvMkZleVVzY2h0WDFZMzVZYVVJNDEwTWhKRTdsQkFXY0pPcDFYU05wNDlK?=
 =?utf-8?B?QWNCclJpYk5TUHNOeEFmWk1RQ3FtUnd4a3hya1hDKzVCQmhDNFJoYXppc1Fs?=
 =?utf-8?B?WnoyQnpLQit1UW5oOUc3S3VFTnMvbEdaeWtlZnZObnhweDlnam4yaTI3QzU0?=
 =?utf-8?B?dmZUTUNvUkJNV2c3STJ4TUdLY21kd0FSa2FyRHJ5d3Y0eFNaeFFWU0ppOEd3?=
 =?utf-8?B?ajVUL2kwS242dXBONDVOSlhsazQ4eEluaUpUVTErQzUvT3VmZjRvNjJ0dWpw?=
 =?utf-8?B?ejdzeUpBMGJBc0paK0JTOEdZb2NRaWRzQjVaN3AwdnBKV05WSUJnUjVpV1dD?=
 =?utf-8?B?b3NWUkptUVJab3NkN1BsWndqSk1xU2lXU2hyK21MTmVCejZSNEF1OUJLYXQy?=
 =?utf-8?B?dTJUWnlxOUY5Z2RoVkpKVE81UmFoU1ptbjVTdG9LTHVHTUY0L0pDMjJiOVhh?=
 =?utf-8?B?SEd0WFZsTDBFeXJiQ29lNytwZUlZMmNOQUNEcUpRR2t4SkM5a2t1UnF0eUJH?=
 =?utf-8?B?ekthRkJFRzRXUDFlNGVKT2hVbm15TUJDR0V1eVFRUlhmcE5jaVY1ankrTkpo?=
 =?utf-8?B?Y2xvd283dGZpZ0hjcVk2QThSVGYycGIzVUxWczR0OU9uY0hOTVJ1Tzc0Y3VN?=
 =?utf-8?B?d3FvaVk3SE5tK0Y0VXVYSzZVenRaODlMdStaV2RqT3VCWENRQUUxNFA1YkZD?=
 =?utf-8?B?U3ZuL1pqMHZEaHlONndBeUM2S0sxcmQxMWxzZ2t0VUZST2tPaVlLUTArSzk5?=
 =?utf-8?B?ZU56K0FZVjlzK2FHakRZd2krYytGd3U4bW9nSXdCU2xzVUNJbFMrVGx6WUk4?=
 =?utf-8?B?TUlmZlJsclg3MEV4WlNPTWlkQ0t1WUZsWGF5OTN1ZHVkS3hMQkovYk9FWUxW?=
 =?utf-8?B?d3d3UTF5VTFhRzVGazRZY0IwWCtCcXVaOVJsOUp3dkhXMmZhajlKbkNYa0ZK?=
 =?utf-8?B?SC9ldElTQkY1cjFodlM4eGJ1SUkvQUwwbkhpSXcvT1plR2pEcUYwMlhabDFx?=
 =?utf-8?B?NUxxWHFjSytrek9MZWoyWlFuMHBGUGdqMktiRVpINFBPTTZXWTlWYjFjNExZ?=
 =?utf-8?B?S0JZSm84QjZ2QTFiQ0xIcDc2KzBWckJsS3Fvd1JsN1RLNC9BOGZ6MjZUd3Rm?=
 =?utf-8?B?NmVCNksvaDQvTjh0UzJPRkJiOTZPcGp2SDVHNURZSmFzWGFFcm1hU0hrdzNW?=
 =?utf-8?B?eVBKb01ONzY0dFVNTkRnUVdyZzgzajZTYXlaTG15YlMyVU1hRnplSU9wT1E5?=
 =?utf-8?B?bG1IUjliVXpJOXlBZ2llOWpwMUpwdTRSYkVaUm9uRkZZZC9yQU5qTUtaM25y?=
 =?utf-8?B?TGc0a3hTUWJucjVLa1kvczBaV0pia3JxL0dnd2FZSm1lU09vbFJ6N2FaSnc0?=
 =?utf-8?B?ajVXdnBGU0hCZFBZdXl3M1BOMmJWTVFwUE5aV2tsYTZDRjh4MHF4ZytCQ1ZB?=
 =?utf-8?B?Vm0wRUVoRzdqanEwcDFZTC9FTzNRaGwwY3p0aXl6VzBBdHBYdlBjQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17be10d9-0bf1-4be9-e43c-08df2aecf1d9
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 18:48:46.9807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KiJO6P5CDdHwR3KmxQvoChNvOLzMLw/lygFA2i7VkeTONnl7azKDT+DSOJpU8qofFz8iVyf5Ej9HBkA9MSSsuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4352



On 10/15/26 13:31, Andy Shevchenko wrote:
> On Thu, Oct 15, 2026 at 09:25:10PM +0300, Andy Shevchenko wrote:
>> +Cc: Dmitry (as it might be related to keyboard configuration), others for
>> the previously reported same IRQ on the same GPIO controller but for some
>> camera stuff.
>>
>> On Thu, Oct 15, 2026 at 03:13:02PM +0100, Nikodem Sanecki wrote:
>>> Hello,
>>>
>>> I'm reporting a Caps Lock LED issue on my Lenovo ThinkPad L13 Gen 2 AMD
>>> running Arch Linux. I found a workaround that completely fixes it, and I
>>> hope the findings might help implement a permanent kernel fix.
>>>
>>> *A quick note:* This is my first time using Linux, and I'm a complete
>>> beginner when it comes to kernel development. I used ChatGPT (GPT-6) to
>>> guide the troubleshooting process, analyse my laptop's ACPI firmware, and
>>> interpret the results. I personally ran the diagnostic commands and
>>> verified the observed behaviour, but the technical explanation below is
>>> AI-assisted. Please correct me if any of the analysis is inaccurate.
>>> Problem
>>>
>>> Under Linux, the physical Caps Lock indicator LED never illuminates, even
>>> though the Caps Lock key itself works normally.
>>>
>>> The LED works correctly under Windows and during certain stages of boot, so
>>> the hardware itself is functional.
>>>
>>> After investigating, GPT-6 identified what appears to be a conflict
>>> involving GPIO 11 on the AMD AMDI0030 controller.
>>>
>>> Booting Arch Linux with this kernel parameter completely fixes the problem:
>>>
>>> gpiolib_acpi.ignore_interrupt=AMDI0030:00@11
>>>
>>> The Caps Lock LED now works normally, and I haven't noticed any other
>>> hardware issues.
>>> System information
>>>
>>>     -
>>>
>>>     Device: Lenovo ThinkPad L13 Gen 2 AMD
>>>     -
>>>
>>>     DMI product name: 21AB004LSP
>>>     -
>>>
>>>     DMI product version/family: ThinkPad L13 Gen 2a
>>>     -
>>>
>>>     DMI vendor: LENOVO
>>>     -
>>>
>>>     DMI product SKU: LENOVO_MT_21AB_BU_Think_FM_ThinkPad L13 Gen 2a
>>>     -
>>>
>>>     Kernel: 7.2.9-arch1-1
>>>     -
>>>
>>>     Distribution: Arch Linux
>>>     -
>>>
>>>     BIOS: R1QET54W (1.40)
>>>     -
>>>
>>>     BIOS date: 2026-04-14
>>>     -
>>>
>>>     DSDT OEM ID: LENOVO
>>>     -
>>>
>>>     DSDT OEM Table ID: TP-R1Q
>>>
>>> Diagnostic findings
>>>
>>> The following is GPT-6's analysis of the diagnostic output and decompiled
>>> ACPI tables.
>>>
>>> *1. Linux sends the correct keyboard LED commands*
>>>
>>> Using bpftrace, we observed that atkbd_set_leds() consistently returned 0.
>>>
>>> Tracing ps2_command() for command 0x10ED produced:
>>>
>>> SETLEDS: value=4, caps=1
>>> SETLEDS: value=0, caps=0
>>> SETLEDS: value=4, caps=1
>>> SETLEDS: value=0, caps=0
>>>
>>> The driver reports success and sends the expected Caps Lock states, but the
>>> physical indicator stays off.
>>>
>>> *2. The embedded controller tracks Caps Lock correctly*
>>>
>>> The DSDT defines the CPLS field at EC offset 0x0F, bit 7.
>>>
>>> Reading that byte through the read-only ec_sys interface showed it changing
>>> from 0x00 to 0x80 when Caps Lock was toggled.
>>>
>>> Enabling dynamic debugging in drivers/acpi/ec.c confirmed that each Caps
>>> Lock press triggered EC query 0x78, which was scheduled, started and
>>> stopped successfully.
>>>
>>> *3. Lenovo's firmware controls GPIO 11*
>>>
>>> The DSDT contains:
>>>
>>> Method (_Q78, 0, NotSerialized)
>>> {
>>>      If (CPLS)
>>>      {
>>>          WFIO (0x0B, 0x00)
>>>      }
>>>      Else
>>>      {
>>>          WFIO (0x0B, 0x01)
>>>      }
>>> }
>>>
>>> The WFIO method writes bit 22 using WMEM(), targeting address 0xFED81500 +
>>> (11 * 4) = 0xFED8152C.
>>>
>>> This appears to control the Caps Lock indicator using GPIO 11.
>>>
>>> *4. The same GPIO is declared as an ACPI interrupt*
>>>
>>> In SSDT12, _SB.GPIO._AEI declares GPIO 11 as an edge-triggered, active-low,
>>> exclusive wake interrupt.
>>>
>>> Its _EVT handler includes:
>>>
>>> Case (0x0B)
>>> {
>>>      MSTP (0x3911)
>>>      Notify (\_SB.PCI0.GPP1, 0x00) // Bus Check
> 
> This looks like some GPIO related notification. I dunno what Windows driver does.
> Mario?
> 

Honestly - this sounds like a copy / paste BIOS bug that they copied the 
SSDT from one system and didn't change it.

I would think quirking it makes sense if the BIOS isn't going to be fixed.

Before we go much further can you check if this is the latest BIOS? 
Check Lenovo's website, in case it wasn't brought to LVFS.

Also; Mark can you ask BIOS guys to look this over?

It sure seems like GPIO 11 shouldn't be in _AEI.

>>> }
>>>
>>> This appears to conflict with the firmware's use of GPIO 11 as an output.
>>>
>>> *5. GPIO registers confirm the suspected conflict*
>>>
>>> Without the workaround, /sys/kernel/debug/gpio showed:
>>>
>>> #11 ... input ... 0x457a00
>>> #11 ... input ... 0x057a00
>>>
>>> Pressing Caps Lock changed bit 22, but bit 23 (output enable) remained
>>> cleared.
>>>
>>> After booting with:
>>>
>>> gpiolib_acpi.ignore_interrupt=AMDI0030:00@11
>>>
>>> The result was:
>>>
>>> #11 ... output ... 0xc50000
>>>
>>> The output-enable bit was now set, and the physical Caps Lock LED worked
>>> flawlessly.
>>>
>>> The system was already using atkbd.reset=1 for a separate
>>> keyboard-backlight problem. That parameter alone had not fixed the Caps
>>> Lock LED.
>>> Possible explanation
>>>
>>> GPT-6's interpretation is that Linux's ACPI GPIO handling configures GPIO
>>> 11 as an interrupt input because of the firmware's _AEI declaration.
>>>
>>> That disables the output driver, even though the firmware continues
>>> updating the GPIO output-value bit when Caps Lock changes.
>>>
>>> Ignoring the interrupt allows the pin to remain configured as an output,
>>> restoring the indicator.
>>> Related upstream fix
>>>
>>> This seems very similar to the Acer Nitro V 16S AI issue addressed by:
>>>
>>> 6da1f3437435c82eaa15b121022474bb358ffe20
>>>
>>> "gpiolib: acpi: Ignore GPIO 11 interrupt on Acer Nitro V 16S AI"
>>>
>>> https://lists.openwall.net/linux-kernel/2026/10/02/1029
>>>
>>> However, there is an important difference.
>>>
>>> On my ThinkPad, the GPIO 11 _EVT handler issues a PCIe bus-check
>>> notification. I therefore don't know whether permanently ignoring the
>>> interrupt could interfere with PCIe-related events, hot-plugging or wake
>>> behaviour.
>>>
>>> So far, normal use with the workaround appears unaffected, but I haven't
>>> exhaustively tested those scenarios.
>>> Question
>>>
>>> Would a DMI-specific gpiolib ACPI quirk be appropriate for this ThinkPad,
>>> or should the conflicting GPIO declaration be handled differently because
>>> of the PCIe notification?
>>>
>>> I can provide the relevant decompiled DSDT/SSDT excerpts, additional
>>> diagnostic logs, or test a proposed fix if that would help.
> 
> Please do via some kind of file sharing service and reply with an URL to that.

I'll second this - put all the artifacts in a kernel bugzilla please. 
 From the current AI analysis I agree a quirk makes sense, but we can 
double check everything.

> 
>>> Thanks very much for your time, and apologies if I've misunderstood any of
>>> the technical details. I'm happy to run further tests with guidance.
> 

