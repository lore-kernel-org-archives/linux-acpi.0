Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010014.outbound.protection.outlook.com [52.101.56.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F62659572D;
	Thu, 15 Oct 2026 20:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792096001; cv=fail; b=QxzAzSDAP2WM96A5xS7VMwNzAGeXdy4Mj3QfGkQy7kVsu+9dQK+npeph89dKEeYzbedsjNdVV0bPva7JGB24IOTMCdZmt/66Tcod2NFk1SoMKjH0cNflAOTZWkrwyushjcgC+n/ZHN8fTkJgqTp6CoHwg6k0O4Qf+mzthgGm02s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792096001; c=relaxed/simple;
	bh=ExhHwLz6Khe8J2uOqvCuquuPAzKAf5bfL+JbJ/Fp0es=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mH5efpW1uFsCM8powh54O8YWqYOuy8ZCCbjFeLtmn+cyWaNj6QE2Qe2Gb1bqAJlzOIcel/bjKIWcIQYsaKrDtr6GduvWmUwK8NcyiTPRZvGGlMB3KJBT2CG5pKJWYGIimU991XN94n7Zl5qrQmEuQNpYWNZfz23jSgw4K+yHbNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cw6/p9wM; arc=fail smtp.client-ip=52.101.56.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cw6/p9wM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R3qjF4AtuIHXbsoRUAZCS3xrKl6vWXlVJE+g70E9QhbKbfBsdCnX5oL23iexnYPVLJs+d2BFQdkyga6Kbh61rvdWrNWeP0aKkWijfN85tAUdud5PSncux9pvGfR7zbq8BxrdeKJO6PrZC7Qz+1xpjoU0OImtgmSjEM0J8IFgFxBynN+yiTurq4ZyRD3rPhfBhWK5MGb0w4Y16Yg7plguBJDnV6bJz7JkTh/CJX5dtL7OZCdBE+3lDBSKRYZbgrdkBGDe+El673/rVRvbZRK9XM28Tq8hPXbEIFEo04XyqpRfQ5qHxURK5UdKetken4g48vo0nwny/7Ts0zAqorwVTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P+SPFmP0z4+Q/+Ek800KBpkDJ+a3G11/sNqqo5OZp5U=;
 b=CsSENCzim5ewW5QM/x50KeVKAV2glO33LEIQlLHH3ykDXNy4eTMbNxWUTVMH16NJhQjIWUwQ738D6TTXnP9jaHSRN5RolEpmbu27vNh1P2kI05ZCG+1iKERstG3rzYo4Fao2SHVAAj71i74vneQav++hTBo6RzlAUB4gjETSm+mknN6tAhi7xRxxIU4UKWlQdpSh0PPbvzqriE5BG/UYpFOH6Qnp7XEyNhgxN6oPuaXYZ2KcbhyYSxvv8z9C5KJEfCd1Yl7xEyN2lIgVX653Win4bSmtrwsC3Lyib5eASi46V8vTT8dSncq8AdlvLjRHbmgMBDX2LJFr4bfV3qpjzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+SPFmP0z4+Q/+Ek800KBpkDJ+a3G11/sNqqo5OZp5U=;
 b=cw6/p9wMedKUiZajyWhQKcPxbiAFE1cdDtnbVkLjycyX2BTQJyAiLLGqaq6vTA3+2Igtcpzpld4dKr9oEG1gICaMpr5w/GgxaJS1Jpvxvr2ok1S8tg9oxPJ091G9EUBTU9nm4K09y6P6qkpQQIc0pc+wvd+9ELKc7ahkr3fNHqo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by DS0PR12MB8785.namprd12.prod.outlook.com (2603:10b6:8:14c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Thu, 15 Oct
 2026 20:26:31 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 20:26:31 +0000
Message-ID: <8a94b2bd-70ae-405e-ab01-2a0d37dcc551@amd.com>
Date: Thu, 15 Oct 2026 15:26:28 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: ThinkPad L13 Gen 2 AMD (21AB): Caps Lock LED broken by ACPI GPIO
 11 interrupt conflict
Content-Language: en-US
To: Nikodem Sanecki <nikodemsanecki@gmail.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Abduvaliy Abdulazizov <abduvaliy.hbai@gmail.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Mika Westerberg <westeri@kernel.org>, linux-gpio@vger.kernel.org,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 linux-kernel@vger.kernel.org
References: <CAAUQFRPW-rbcZV-=qV1NMjF_358sdJTiGvQuRxRqAsehY+J9Qg@mail.gmail.com>
 <atEaguJD7dh7xNs0@ashevche-desk.local> <atEb6FN6ZbKI9xgf@ashevche-desk.local>
 <51c151fd-31cb-4ebe-8f3b-eb7634e68c31@amd.com>
 <4ba482fe-8b34-48ad-9d13-99ab532cbd97@app.fastmail.com>
 <CAAUQFRPDq6zdyySWtGM8i_uq-iZJK1qpvCvxTrRweLmS2+-AMg@mail.gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAAUQFRPDq6zdyySWtGM8i_uq-iZJK1qpvCvxTrRweLmS2+-AMg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN0PR04CA0111.namprd04.prod.outlook.com
 (2603:10b6:408:ec::26) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|DS0PR12MB8785:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bbac3f2-7129-45eb-de14-08df2afa9984
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|5023799004|10067099003|3023799007|22082099003|261009223027099003|11063799006|6133799003|56012099006|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	ruJqq20Zt5PvVNfKRe+ORMtcN7ZyqjxWMURfaUIeZ3b6xRwRJ1DO9Y/0JfvjC3DnryLZwzcbEMQ9A00GvkhMmkcfaLtKJUbFsk1+Dfq0dU7c1e7lsWDjT6fO9xL1TqVaT6vEq0O35dvwXOqbpSMC9bpuxkYelGs3UGv/mL39sjuapdySU7JHzrNjRAmYBEe0wZAW2nZE8LQwk0NQFsbQaFFRFAIV4VbGtxBqN/0ewBTJBVOVr4Rjr+32D/jz+rpVrBkJ6tkiRR1Q8+xV+XRriu/RnCNAa0dA72m362vMorS7pZFUGC1UdxXn3Nuipw6Y05RP3PMNKHqrkkf17BrslrPzMRCh6RlScPf7DVxtcpJN7R/78jxNaNnF6HeFqoxc+sYewNxC3dA2Cn4gr0EMMegNVa7d1eUHdSUf89f3ilQ5oHMzA/3s1R0j6rQ44BJ5cRJzfPBjdC6TqdKyIKozUmATyFTOR3wVMR30WuCr4272NQCt/DAz4pyyD6JLwSMkXc5TyO2wb6Ks2Hq+XHFuBnLh9wReJQztiGqQNJzzeG/dQwnvLxYZlh5i7Ti4OUtjhz19/YLnkG/QH5QFThc2qm0sB3yE7RCXR4bGSMDgYC6nsDCjuhkkD54GLqI38mpX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(5023799004)(10067099003)(3023799007)(22082099003)(261009223027099003)(11063799006)(6133799003)(56012099006)(18002099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MUovZEJrcVBsaitXSktsczR5MlF3VkRTVFBHZ0hoZncrd1htUzlZbUtUSFVl?=
 =?utf-8?B?azJNQndNNEY0VXpSaTFHeUttNDJ6UXNENC9CMW1pczFacHhNRkZTcUxVSkUx?=
 =?utf-8?B?d3UxNjdtcjFabU9nMndpR051V3RWVGdWT3RZSDM2OEZKazZNUW1vRGsvUFpK?=
 =?utf-8?B?T1JmbXVscmpKQ3VzM0NMY0VxM3F1ay9KNWRUSEFzSEJDdlNTUHZWVWhzdzBz?=
 =?utf-8?B?dVRvZk9OTTVqeWZuMTZnanVmUzJHOFBDajV3OGVrNlB2R0dPdmhpTGIwWVpt?=
 =?utf-8?B?bnZ3a3NhQ0NxeXM4U0d3eFA4bDB0WHBocHBXMktJbnQrZGtJWldMcHUycUQ3?=
 =?utf-8?B?ME44eXNNbVFhUWdHOXk2bnpZL3VCUU5mZ2JDQXpNa3J5cVgyZWZuQk5XR3JM?=
 =?utf-8?B?SFdmNGRNUjd1WG1RSFpoQThab1Y1dVlMSVNhQ2NpczQvckVEb29BYlZUMVM3?=
 =?utf-8?B?T0N1ZEJ1SEVqSGNROWVpb1lTNkc0UE9KQVJjRE5SY21aVnJyS3lnY2o5TjZU?=
 =?utf-8?B?aXN3MUxvYXZxTG01OUVsNzB5a1VsWEIyYlZMc0ZDQXNyaGxKald1Mkx6K0Fj?=
 =?utf-8?B?cittOWI5SmtGYVVib3BZdGtnU0tJbGJnOVlCYUxpZzRRcDFkVHZYQTFUYUVj?=
 =?utf-8?B?S2NUSno4TlpJUnJiVVpObUpMOTFpTXEvZDg2WTVhcVJnQ0ljQ25ZVUcwcVdK?=
 =?utf-8?B?UHFaRW0yT2VScU52a3UzclBFQ1k2UkpkbUx2TVdld0FUY3pBM1k5UzhMTis1?=
 =?utf-8?B?ejhPVVRkNFJHdTFJcXlZZ0N2K2FCck1aSmtwRGkyanlsMXhmWHpVRDE2cGpI?=
 =?utf-8?B?Yk80YS81eTR3dFFnUmZ2bG92RGwrUnM3WElsSlA1UTY3Y0U0SVllQktPeng5?=
 =?utf-8?B?amlqR2JJUWVZNzd0NXAvU3ZiSktoVUpsRElSckFSa1BxTEFMemtDcko2QXlB?=
 =?utf-8?B?L24rYTFRek5YNjQwM3ozSU5GaXdBY2diSWt0Zm1zbGpRVDZNdUhQWFJFOXgr?=
 =?utf-8?B?dlY1ZDhMQXVrT1NGNFYrRUhBZkY2VHBhdlU2a0RDcUtXczNkWC9JRVdCcHUy?=
 =?utf-8?B?aUE1dGM2VXlXNFNqeVVYZGpjYzdhdGNLZk4waVhlcEorbEs2WXh5QSsxTWoy?=
 =?utf-8?B?K2txZ3I5R2thbDlPbUEyK2oyYll0WHhGVGtsREhJV3pOV042OVNVa0czYS9T?=
 =?utf-8?B?c1AwYW1nRWlNeVhQUXVWNTFyM0M2QjRocjlwYmZQZDJNOUJ6Rmc5dnFDYVJj?=
 =?utf-8?B?MEdzWGRWY2pqQWdiWUkrZmhKcW9sWWV0TkJsQVRQRGZsTGU4RUg2WGhqQ01G?=
 =?utf-8?B?ZGF0eFN1bVlvUGlrb1h0N3l5cE9IQlphNXRNRlNjeVBlYlp0ZVMvUGVXb3BL?=
 =?utf-8?B?cFNDMlB0Mm9BYitST2I5T2lKREJxYzZ1MFoyVEQ0bk8zZkpMWDcvdjlSRUVC?=
 =?utf-8?B?Z1M5YWZ3ZmdRRndRa3Iya0hzcnR6cjh0ZnNGeTRIVGFpbDJqTjZheGpqTG5m?=
 =?utf-8?B?bUluZzBsSXpZU09ZY2Nrb2pvc29UZ3p1TmtwcDdSY0xFUFZTSkJGRTZHazNh?=
 =?utf-8?B?RWhTTUhpM2ozY3c5dG5aWG85RUZCbklxWDlQa3VsSkttenV0TWUxWjQ2aE5Z?=
 =?utf-8?B?SnV0MlZqUTE4dXk1TVU2VjM0bTFBWlhKRWlpQWhGb2lsSlVVZHZmUisrR0Ja?=
 =?utf-8?B?RVY4STU1ckRFSlBiMnp2d1lNY0pPUlF6T2RGT1RldVRYL0RSSVFWYno5Uzln?=
 =?utf-8?B?QU5nUi85NmxHV3RLcUkzNjM1L2E5VXhwREpsVE1sRWtqS05wY1d0QWtpZnZx?=
 =?utf-8?B?ODdSZXNRNm9oNnZtTkRsNnFpRzR2cW1nWGNYenNWSVlzYW9lN1JYeXk4SVMw?=
 =?utf-8?B?WTd5N3FESEZrQ3hBVGVFSnZxNE5YQVFaN1d3Nm90d0VuSmxlN0lxR3RYYW8z?=
 =?utf-8?B?WlY2OWVmZnRLSzU2QU5aK2RpQ0VnN3NENmJXcHRiU2Z5SldKUWxKMVlTMGR5?=
 =?utf-8?B?eWtQcEVFZjNaUjk0bStqeHJqY2Y1Wk5RQXdmOE9lMVpvc2FQWTY2QXVRSzFI?=
 =?utf-8?B?dFRpVXdERjFyVExPUXNVY2J3RU42bGlWODlMV0hTT245T2V0TnI1TCtQOGMw?=
 =?utf-8?B?T0RaVzMzK3FTTTZDbW80WmJ5bGM0b3hySklxYzlNSFg2bzRKUFR4cGIwRkZS?=
 =?utf-8?B?c1dmMXhEZC93dEZlL1g2aTlUaVd1UU9BRW5ZUkR5K1FQNTFKS2t4VzJQTU90?=
 =?utf-8?B?UTc1b0NBSUhSSG1acWovU2pTTHFsb1ZQTkdRUnlMSFEwTklRVWd2TU51clcy?=
 =?utf-8?B?ZDRkWWNXR3YzYTdTT2h5MC9ZNzVGa2wzTUVRQXE5WGlIUFlUT3Frdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bbac3f2-7129-45eb-de14-08df2afa9984
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 20:26:31.7080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XJzhe1vskWaWQvnrj/XVtauaEdz/o/xcZW6GUmzQTt9+f6UvITlfVB6AHQy0JU6RA8wU+BE/3UPUd9DK3/Kb1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8785



On 10/15/26 15:13, Nikodem Sanecki wrote:
> Thank you for looking into this.
> 
> I've checked Lenovo's website. My installed BIOS is R1QET54W (1.40),
> which matches the latest advertised version. The version history on
> their website appears inconsistent, though.
> 

OK thanks.

> I also have the sanitised ACPI excerpts and diagnostic logs ready.
> Given that a patch has now been submitted, would a kernel Bugzilla
> report with these artifacts still be useful?

Yes; we should still have the artifacts somewhere.  We can close the bug 
completed but add a Link: to the patch.
> 
> Happy to help with any further testing.

Can you please test the patch I CC'ed you on?

https://lore.kernel.org/linux-gpio/20261015193924.4081906-1-mario.limonciello@amd.com/

> 
> Thanks,
> Nikodem
> 
> On Thu, Oct 15, 2026 at 8:25 PM Mark Pearson <mpearson-lenovo@squebb.ca> wrote:
>>
>>
>> On Thu, Oct 15, 2026, at 2:48 PM, Mario Limonciello wrote:
>>> On 10/15/26 13:31, Andy Shevchenko wrote:
>>>> On Thu, Oct 15, 2026 at 09:25:10PM +0300, Andy Shevchenko wrote:
>>>>> +Cc: Dmitry (as it might be related to keyboard configuration), others for
>>>>> the previously reported same IRQ on the same GPIO controller but for some
>>>>> camera stuff.
>>>>>
>>>>> On Thu, Oct 15, 2026 at 03:13:02PM +0100, Nikodem Sanecki wrote:
>>>>>> Hello,
>>>>>>
>>>>>> I'm reporting a Caps Lock LED issue on my Lenovo ThinkPad L13 Gen 2 AMD
>>>>>> running Arch Linux. I found a workaround that completely fixes it, and I
>>>>>> hope the findings might help implement a permanent kernel fix.
>>>>>>
>>>>>> *A quick note:* This is my first time using Linux, and I'm a complete
>>>>>> beginner when it comes to kernel development. I used ChatGPT (GPT-6) to
>>>>>> guide the troubleshooting process, analyse my laptop's ACPI firmware, and
>>>>>> interpret the results. I personally ran the diagnostic commands and
>>>>>> verified the observed behaviour, but the technical explanation below is
>>>>>> AI-assisted. Please correct me if any of the analysis is inaccurate.
>>>>>> Problem
>>>>>>
>>>>>> Under Linux, the physical Caps Lock indicator LED never illuminates, even
>>>>>> though the Caps Lock key itself works normally.
>>>>>>
>>>>>> The LED works correctly under Windows and during certain stages of boot, so
>>>>>> the hardware itself is functional.
>>>>>>
>>>>>> After investigating, GPT-6 identified what appears to be a conflict
>>>>>> involving GPIO 11 on the AMD AMDI0030 controller.
>>>>>>
>>>>>> Booting Arch Linux with this kernel parameter completely fixes the problem:
>>>>>>
>>>>>> gpiolib_acpi.ignore_interrupt=AMDI0030:00@11
>>>>>>
>>>>>> The Caps Lock LED now works normally, and I haven't noticed any other
>>>>>> hardware issues.
>>>>>> System information
>>>>>>
>>>>>>      -
>>>>>>
>>>>>>      Device: Lenovo ThinkPad L13 Gen 2 AMD
>>>>>>      -
>>>>>>
>>>>>>      DMI product name: 21AB004LSP
>>>>>>      -
>>>>>>
>>>>>>      DMI product version/family: ThinkPad L13 Gen 2a
>>>>>>      -
>>>>>>
>>>>>>      DMI vendor: LENOVO
>>>>>>      -
>>>>>>
>>>>>>      DMI product SKU: LENOVO_MT_21AB_BU_Think_FM_ThinkPad L13 Gen 2a
>>>>>>      -
>>>>>>
>>>>>>      Kernel: 7.2.9-arch1-1
>>>>>>      -
>>>>>>
>>>>>>      Distribution: Arch Linux
>>>>>>      -
>>>>>>
>>>>>>      BIOS: R1QET54W (1.40)
>>>>>>      -
>>>>>>
>>>>>>      BIOS date: 2026-04-14
>>>>>>      -
>>>>>>
>>>>>>      DSDT OEM ID: LENOVO
>>>>>>      -
>>>>>>
>>>>>>      DSDT OEM Table ID: TP-R1Q
>>>>>>
>>>>>> Diagnostic findings
>>>>>>
>>>>>> The following is GPT-6's analysis of the diagnostic output and decompiled
>>>>>> ACPI tables.
>>>>>>
>>>>>> *1. Linux sends the correct keyboard LED commands*
>>>>>>
>>>>>> Using bpftrace, we observed that atkbd_set_leds() consistently returned 0.
>>>>>>
>>>>>> Tracing ps2_command() for command 0x10ED produced:
>>>>>>
>>>>>> SETLEDS: value=4, caps=1
>>>>>> SETLEDS: value=0, caps=0
>>>>>> SETLEDS: value=4, caps=1
>>>>>> SETLEDS: value=0, caps=0
>>>>>>
>>>>>> The driver reports success and sends the expected Caps Lock states, but the
>>>>>> physical indicator stays off.
>>>>>>
>>>>>> *2. The embedded controller tracks Caps Lock correctly*
>>>>>>
>>>>>> The DSDT defines the CPLS field at EC offset 0x0F, bit 7.
>>>>>>
>>>>>> Reading that byte through the read-only ec_sys interface showed it changing
>>>>>> from 0x00 to 0x80 when Caps Lock was toggled.
>>>>>>
>>>>>> Enabling dynamic debugging in drivers/acpi/ec.c confirmed that each Caps
>>>>>> Lock press triggered EC query 0x78, which was scheduled, started and
>>>>>> stopped successfully.
>>>>>>
>>>>>> *3. Lenovo's firmware controls GPIO 11*
>>>>>>
>>>>>> The DSDT contains:
>>>>>>
>>>>>> Method (_Q78, 0, NotSerialized)
>>>>>> {
>>>>>>       If (CPLS)
>>>>>>       {
>>>>>>           WFIO (0x0B, 0x00)
>>>>>>       }
>>>>>>       Else
>>>>>>       {
>>>>>>           WFIO (0x0B, 0x01)
>>>>>>       }
>>>>>> }
>>>>>>
>>>>>> The WFIO method writes bit 22 using WMEM(), targeting address 0xFED81500 +
>>>>>> (11 * 4) = 0xFED8152C.
>>>>>>
>>>>>> This appears to control the Caps Lock indicator using GPIO 11.
>>>>>>
>>>>>> *4. The same GPIO is declared as an ACPI interrupt*
>>>>>>
>>>>>> In SSDT12, _SB.GPIO._AEI declares GPIO 11 as an edge-triggered, active-low,
>>>>>> exclusive wake interrupt.
>>>>>>
>>>>>> Its _EVT handler includes:
>>>>>>
>>>>>> Case (0x0B)
>>>>>> {
>>>>>>       MSTP (0x3911)
>>>>>>       Notify (\_SB.PCI0.GPP1, 0x00) // Bus Check
>>>>
>>>> This looks like some GPIO related notification. I dunno what Windows driver does.
>>>> Mario?
>>>>
>>>
>>> Honestly - this sounds like a copy / paste BIOS bug that they copied the
>>> SSDT from one system and didn't change it.
>>>
>>> I would think quirking it makes sense if the BIOS isn't going to be fixed.
>>>
>>> Before we go much further can you check if this is the latest BIOS?
>>> Check Lenovo's website, in case it wasn't brought to LVFS.
>>>
>>> Also; Mark can you ask BIOS guys to look this over?
>>>
>>> It sure seems like GPIO 11 shouldn't be in _AEI.
>>>
>> Yep - created internal ticket LO-4711
>> Just a note though - the platform was not in the Linux program (and is rather old) - so my expectations of getting a fix is rather low I'm afraid
>>
>> I'd get the quirk ready, and if I don't get any feedback from the FW team by next week go ahead with that.
>>
>> Mark

