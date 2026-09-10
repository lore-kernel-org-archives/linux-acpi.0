Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010046.outbound.protection.outlook.com [52.101.56.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459A554A7CB
	for <linux-acpi@vger.kernel.org>; Thu, 10 Sep 2026 17:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789060436; cv=fail; b=D4ZH5QQVpOHcs/UGoeNOvoKPP4X6GWRmcnfdKfs2sNcjWZ4AFI43bIKEy7aCZFZdeFT6cJmz15Qty5FFlTDXwjCQtmB78uBtrpCawJmfbj6GMeFDD1qUfQLEMtWaye7rDlGu5C7d5yrqUwi84ghjSEZyutr2ndrrMp06TF0ZrLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789060436; c=relaxed/simple;
	bh=F68rWrehjBxTC0orHI8CeK0MZUgUK8wqrodNgIdY8BI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ye29mQ6RD19yFY0Z5z+4UAl21M5eIL/PsIo2YVlNY2krQP4NfVcGTAHUKo7I5j+nFMUH1zPUMDaVryrFBBPsR9Wc4hJCnAQQMHc56HctAkZDrYnXOvLXrm3WhO61hF9YQqoHaiXqrFC6mqyGEJ1w8++9cT3JjyJTeIeAYEMPLz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lXjHMVxo; arc=fail smtp.client-ip=52.101.56.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lXjHMVxo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vBwzTV4lEeaoGhNhpoWkpO5fJ0oKvWEs21KQcxcKEGkOAWpE3Euzp0eTcACh40Sar86E2geGPENhT5bmQKKmp8e2fRgktNFXMTRtNtMYNxe3sbXoJA5oSS0r3eYwtZJXvCJYH3/4wdqiYALQZL1R1NvU2tYN9pLLSLI56MwHzqbwbMGTlIUHcPUxuKQYvmTEdScTE2jgTkfjnA/ax8N67JnK2pzCqhDg112dfsaXdwcW6YCEH7ZuqIjWYJF4n8Vea9kokxe1PjMCPEk2Pohafhwad9bs9vUBJqrYlpLHmOs+PNfmj+2Lx43r2x3CD11bdj9YVKcTIo41mGPpjMeiyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kx5OXQWrT1vnlzhS1ZHEvurBofVD3ng92Y8ArwHibAA=;
 b=FbxDPeS37okA9QrbOIyDqGWz0vPn23e/Sh/B1yGu0aLux4tLOqC1oQFmBObx3kuh+fOpM5pU9Bo+h6T21orRvgfRF36QqINjKO5FvjxO3ClYnx0Dn1fp8yeWJl5jPbQj7V/VAwY3O9Vtju1VQMvwwXiqGR9qjUnm3mDRUbcb0S6PpZK+mnVgRqI3UUZhRrvUSh1yIa9lIRiHjADtLg1MVrixfAzA7P0AQg67JDz2NSW+dD4x0OPpPdQLTyIfgmdg5h1EPAuFFNE35g7fxfOVR1GkId/IxqDgWmSPXX9JjYfeEjQTZZ9vNiiGCilDSN3gTBbTWxB/PBcGTA8Dvew02g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kx5OXQWrT1vnlzhS1ZHEvurBofVD3ng92Y8ArwHibAA=;
 b=lXjHMVxo/fiKA22k9OMCvjgeTwK3zrf5Z168U5dcguB3Jz1MwR14x5zfTHQZr5V7kfYtkcqOJ/JsEg/cy3hGIiiTeODxqydnSbOYdsOyX+UfuIKv2SlrhNfPcU6JKkw4ISjPDZ8NFwAF9AAFmQvQMgVP1boICQAiov1fUe6vBt0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by SN7PR12MB8103.namprd12.prod.outlook.com (2603:10b6:806:355::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 17:13:41 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 17:13:41 +0000
Message-ID: <9b56cfc2-ad06-4fe4-8302-6615e0c50b71@amd.com>
Date: Thu, 10 Sep 2026 12:13:37 -0500
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH] ACPI: utils: Ignore leading root scope prefix in string
 _UID match
Content-Language: en-US
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: maciej.wieczor-retman@intel.com, pawel.chmielewski@intel.com,
 linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev
References: <20260831180214.2231161-1-mario.limonciello@amd.com>
 <CAJZ5v0hgn+_L_yvEg0yo0vPk9_brbxsywyu_77tEyww4nV+eUg@mail.gmail.com>
 <7f86bfc7-efda-4719-a0c2-fab04fba532f@amd.com>
 <CAJZ5v0gFPcoC4nLFdjcfY5Ysk9Sw38r_rLpzWSxtVPTyTuh-0g@mail.gmail.com>
 <aqJ22yK9h4ZHSo__@ashevche-desk.local>
 <CAJZ5v0h-229tKZ-=eXpWrSD9Y+2YBa4cPNiYoeu54k=T412N2g@mail.gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAJZ5v0h-229tKZ-=eXpWrSD9Y+2YBa4cPNiYoeu54k=T412N2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0414.namprd03.prod.outlook.com
 (2603:10b6:408:111::29) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|SN7PR12MB8103:EE_
X-MS-Office365-Filtering-Correlation-Id: a7842047-bebe-49ac-4e80-08df0f5edc82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|6133799003|3023799007|10067099003|56012099006|5023799004|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	FaQynEJqlDxiopjonN1dBLa8fbGNTg6IhWsmuJ4X8B3A5vFDj4ZUX1euYDpUp7gV3tbTSNbvzxktZNL+/lABxgHEaxNSZz+fftgW++RPDkoDFl5w1Kixl1T6TFLL8MqXEIYOOsfbKHt+gC/7I6PJDy+nZcti4UpzMVsSvwIcX+XK63EvONmC+eSePcseY/Cs1g4IQ0lXxRlOPbuJCWS63BD/RemjsJ8zzEIDqBxM7yqH5KVX5FgR4ybIE1OipM6+xcfeycBbde6pnTWCZd7GdG3pkJeDlBRvTUvT+jqXQx+cDnl9MmstlyPHyQboueFyJAn8dgClnBaeCVwCz5r70yYEKH4AS4BvtDnHqbfz3CRyftWwtwp7ABRMbAvxivVvcYVrQX/wiy6/WuhdmQnC28iCM128WXuKi+03Ml7et0YfoZWCFcfnxS6yKRjJmFA1dYlEmOFKWRsI1VTJjZtWtJdAAmNr6q1+/EsxkLaBxzgY8LkWod7EIge6Vn70DARDNRGPFnydC6Rka565PelZJLxFfCJSEsNnFWrnDV/bTM48KwAWt4ba8MDvueu7q4yziPrSzbAMkTrlwECkZksHGmqa6kAtqsjNLHsvOfWCkjVw7HLVt34RKgWC7hkOQtBHpaRRIk1T32vboDkvHzhij1uHxvmBdVriUiZi5q1gPEU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(6133799003)(3023799007)(10067099003)(56012099006)(5023799004)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WklSVlphWXpkYmxSTThCRU5rVGRTWG15WnhDMWE3U29FcU8vZy9QQWlDSlZT?=
 =?utf-8?B?OTlWMTcrVDB0MHdzT3RXdkhMdzh0cEYxZit4NExkaTRNQ0lVWXgxUUEzZFll?=
 =?utf-8?B?L0YzNW5yTlZWYi9INnpmVmNlWjdrR1JpQ1NOeEd6cXAxVFNCNDJjM0hwZE9N?=
 =?utf-8?B?dTgwa0grcHFVT1BZUlpwcDNoTnZFK3VqYlhQaTVzcDZDNDcyU2tlTnVqNmI0?=
 =?utf-8?B?cGpFWFVsRjM1R2YwMzFMcTgvWEdJbXVDZEdhL2dHUW5sQ2FhQlZEMTRTaDFt?=
 =?utf-8?B?QkRlQTBRTGl5MDNaMm8rYVVBVjk1NnVta3FIQkJ3dm5Cek5sQnFDeWtDdjhQ?=
 =?utf-8?B?NkV4dFhrdXhrVFVRSEdDSFpabm5TV05xNzBDTHlmK1VUMkltZEtIMnN2cmJa?=
 =?utf-8?B?djNTd1Zsak1wUzlVRlB6S2JPSjhmcEVhdnRwNTJla05UNHc1NzJreXJkUTh0?=
 =?utf-8?B?RVR1QUo1Uzd4WDh3cWI2b0VLWHFUb1JTVDhkcnNvK1lJRHh0SnQ4RUFZV2dB?=
 =?utf-8?B?VkFkQ2pUSGpxWDBaM1dGT3N5WWpMWlhTKzFyM0pWZkE2Y2JFOXBjU3pnMjMw?=
 =?utf-8?B?VnNrd1RQenZsVlphTVdtOVlGU0lwMldTOXowbmhpUzF5T05xdDhMMWNqVUlj?=
 =?utf-8?B?TkwvdXlaSSswQUxSRVNtMUhLRmh5S3RiUzZjOUtjclNtUENlMlZLUkNISVE3?=
 =?utf-8?B?UUNqNU5lUzlkdjkrVFNrT3M1OWw4YnFGdjZ2aHpDWWxCSGxJY1lRQmpleTd2?=
 =?utf-8?B?RXhnL2NNVFllczRNbEdJNHVkSlYvMEZwaUVhK2NQTCtIcEZYSE1HS3FzdFZS?=
 =?utf-8?B?NGQrQjlJYVN0STdvUk5FWUhVbDBSemxkVGo2ZmlUb3RBekYzZjFMaDZXUUdr?=
 =?utf-8?B?d3MzbDU1YThhWFZLd2ZwUDkxR3BEZWtJMzFweUVCR1NBNGRDVlVlNE5wdFFm?=
 =?utf-8?B?R09LOHBiNTVTSkliMGg3RjRFN3ZDaHcwVCt2Wk9zVDRTM0E3ODlSTEF2OVU2?=
 =?utf-8?B?d3g0dThHVkZIU0dpRzN4M3hTbjBRYmxoRTlQZDZIcm9paDhKWFU1SjJ0bnpC?=
 =?utf-8?B?Q21yaHhZSDg5YVFjam1lc3V2YnUxUVNYMW1kZXJHd2RCSU14OWlSamJwMllk?=
 =?utf-8?B?aXQ4WG5zclVhVmU3VlYzUUF5aEdDN3JRMnczemRkT3NMbG9GR3hQUWtkVUgr?=
 =?utf-8?B?OXdTOTRiOHdsbHlvRDlSTGlWUUpBd0RPb2lWZDh4OXpENjlTZWpHSkVUQVBN?=
 =?utf-8?B?c0Y4T0NuVWJKNC9FL2F0dEM3QVdDYW9Ea3VhQjBsNUtWaW8xTlE1bUNVckZT?=
 =?utf-8?B?NWdFVFFhREpMVlZ3U0cvVVdQZStYbVFxcVk0VFNkZGVrdHpFOWcyakp2RHpq?=
 =?utf-8?B?bUdoTERGcGl1WC9zOXRsRGpRSGR6Njc4dG1kMHVHSVRJQjlremtEbmE1YUdD?=
 =?utf-8?B?RElrMi9wVTVsTnhPb2s5SFZIV1J3aEg4WU9uVzN0UWM1cGdVSEg1WlphdHdB?=
 =?utf-8?B?cjVjZTdWSzVwRVpXZkU4d3cybG9pTjU3a3BOdU8wOWs1QWQveGNRVW13d3Zx?=
 =?utf-8?B?Zk1UNlJzRnJmdGpiOHBaTXRSK0ZzaE1vWUsrUWw5RzJ2KzI4VnIyNmluNHh4?=
 =?utf-8?B?cktwRU1JY29wUEl3T1VZRndNdkdoNmhnblkxdExyVFFtaTIvWXRvQ3hmWWRj?=
 =?utf-8?B?V3luUkRKdGQ5TndMVkMvVXN3OFlZeHhudjUwRGZFcWczM0UwelJVMTloSzJm?=
 =?utf-8?B?TFZTNkFsSzJORE1URGlXT2ZwMGhaV1BDK3lvaFk3YTUzRHRlaDNUZ2V3eEl0?=
 =?utf-8?B?d0lEeFEwb2Q2ckhtRUNVUG1tZktFeEpqZS9FT21qZzAvMng4Sll1NnZRQ0h1?=
 =?utf-8?B?dEV3RUNXT3JYbWJxUHVnaklSNFVHTE55ZmtSTXFYTS9NdThUaGtVNzc0eHd3?=
 =?utf-8?B?Sk9PTzduSzZHQWE2c2ZGSkRqaVVCZkJGRjFmN2Z3UEo5azBYR0h1MUtKL2Zt?=
 =?utf-8?B?c2paOVNHamNZazAvMm45bUdyMmZrZW5RMWI3aEgxOW16ZTVxaFB3ZVFhMldI?=
 =?utf-8?B?VzdGYUtsOUd0amVpSDNFekpxUklKbktxYXExQXNGWmJJKzVac2FEU0FxUlFS?=
 =?utf-8?B?Z3Y1dmVXSFREQ1B3Qk05cnFtaGxWNGxDOWV6NkV4dXA0cUJiTFpCYVJNa2s1?=
 =?utf-8?B?TVRaVXBPWUdQeXBVMENxRUFON0VaNDd6SEVtUEk5ak80b1BDR0ZxWG5YVmZ0?=
 =?utf-8?B?dzI4MnVRdENIMnFFeDNBVG1xc1FTOE4xcFJwVHlsem9LWjd3bjk3YkFJaXhS?=
 =?utf-8?B?cytxVWVyUnM4c2xSZmRXOHdEblV2OWJWNmVTSWlJS05mZlZBdHV3UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7842047-bebe-49ac-4e80-08df0f5edc82
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 17:13:41.2737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gq8NP+G4RWZVvx/8rq+Sgb5WDh4JUhh2GBoQ4l4+yriqXLGnthqHGchBCntDtzYODRSeQXz7LzX60wRxY3uKbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8103



On 9/10/26 05:56, Rafael J. Wysocki (Intel) wrote:
> On Thu, Sep 10, 2026 at 11:22 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
>>
>> On Fri, Sep 04, 2026 at 07:58:56PM +0200, Rafael J. Wysocki (Intel) wrote:
>>> +Andy
>>
>> Thank you for Cc:ing me. And sorry for the late reply, too many emails
>> in the box...
>>
>>> On Fri, Sep 4, 2026 at 7:32 PM Mario Limonciello
>>> <mario.limonciello@amd.com> wrote:
>>>> On 9/4/26 08:26, Rafael J. Wysocki (Intel) wrote:
>>>>> On Mon, Aug 31, 2026 at 8:02 PM Mario Limonciello
>>>>> <mario.limonciello@amd.com> wrote:
>>>>>>
>>>>>> Firmware may express an ACPI namespace path used as a _UID with or
>>>>>> without the leading root scope character ('\'). For example, an AMD
>>>>>> IVRS IVHD ACPI HID device entry may carry a character UID of
>>>>>> "\_SB.MHSP" while the corresponding device's _UID evaluates to
>>>>>> "_SB.MHSP" (or vice versa).  This semantic difference is due to how
>>>>>> Windows PnP enumerates and uses devices.
>>>>>
>>>>> Can you please elaborate a bit more?
>>>>>
>>>>> I would expect _UID to return the string without the leading
>>>>> backslash, so where does the other one come from, exactly?
>>>>
>>>> It comes from the ACPI IVRS table.
>>>>
>>>> https://docs.amd.com/v/u/en-US/48882_3.11_IOMMU_PUB
>>
>> Link is behind SSO, which Intel employee most likely can't get :-)
> 
> Yeah, good point.
> 
> Link: tags should point to stuff that is available to everyone
> potentially interested.
> 
>>>> p306-307 talk about this field.
>>>>
>>>> Here is a sample entry decoded with iasl -d
>>>> (from BIOS on an affected system)
>>>>
>>>> [223h 0547 001h]               Subtable Type : F0 [Device Entry: ACPI
>>>> HID Named Device]
>>>> [224h 0548 002h]                   Device ID : 0068
>>>> [226h 0550 001h] Data Setting (decoded below) : 40
>>>>                                       INITPass : 0
>>>>                                       EIntPass : 0
>>>>                                        NMIPass : 0
>>>>                                       Reserved : 0
>>>>                                    System MGMT : 0
>>>>                                     LINT0 Pass : 1
>>>>                                     LINT1 Pass : 0
>>>> [227h 0551 008h]                    ACPI HID : "MSFT0201"
>>>> [22Fh 0559 008h]                    ACPI CID : 0000000000000000
>>>> [237h 0567 001h]                  UID Format : 02
>>>> [238h 0568 001h]                  UID Length : 09
>>>> [239h 0569 009h]                         UID : "\_SB.XHSP"
>>
>> As far as I can tell this is weird (very unusual) interpretation of UID field.
>> Whoever created a specification should be informed about this.
>>
>>>> Setting this field to _SB.XHSP does fix the issue for Linux, but this
>>>> has problems on Windows.  So my hope was to let \_SB.XHSP work for Linux
>>>> too.
>>
>>> So how does Linux process this table?  Maybe the leading backslash can
>>> be removed in that path?
>>>
>>> But I guess it may not help because _UID may contain a string with a
>>> leading backslash.
>>>
>>>>>> acpi_str_uid_match() compared the two strings verbatim, so such
>>>>>> entries failed to match on the UID even though they refer to the same
>>>>>> object. In the AMD IOMMU case (get_acpihid_device_id()) this caused
>>>>>> the exact HID+UID match to be missed and the code to fall through to
>>>>>> the HID-only path, spuriously raising a FW_BUG.
>>>>>>
>>>>>> Skip a single leading '\' on either string before comparing so that
>>>>>> paths that differ only by the root scope prefix are treated as a
>>>>>> match. The integer _UID path is unaffected.
>>>>>
>>>>> But this sort of assumes that the string returned by _UID will always
>>>>> be a namespace path, but is that the case really?
>>>>
>>>> For IVRS entries this would be true since this is what is in the spec:
>>>>
>>>>   > If defined as a character string, the ACPI UID marks the instances of
>>>>   > DMA-capable devices with the defined DeviceID (e.g. IOMMU visible
>>>>   > Routing ID). It should match the ACPI device name space strings with
>>>>   > unit number, but without a trailing \0 character (as the UID length
>>>>   > specifies the size of the string already).
>>>>
>>>> But I don't know universally it would be true.
>>>
>>> In general, they can be free-form strings AFAICS.
>>
>> Exactly, the semantic of the content is just arbitrary set of characters
>> that is agreed to be unique (enough).
>>
>>>> I suppose one possible modification could be to look for the length of
>>>> the string being at least 2 on the string before incrementing the pointer.
>>>
>>> I guess this change can be made because it will only possibly cause
>>> problems when the only difference between the supplied UID and the
>>> string returned by _UID is the leading backslash and they are not
>>> supposed to match, which is unlikely to happen.
>>>
>>> However, the kerneldoc comment of acpi_str_uid_match() needs to be
>>> updated to mention this.
>>
>> I don't see the direct question to me, I assume you want my opinion about
>> the implementation. Ideally the specification has to be fixed, so we do not
>> interpret UID as some "special" string. In a new version of the table
>> specifications it can be amended with a new field, for example.
>>
>> If we need to solve the old behaviour, the skipping leading \ (and backslash
>> only) might be good enough quirk to make sure that the rest of the callers
>> (and possible future interpretations) won't be affected. TL;DR: Make quirk
>> as narrow as possible to avoid false positive triggering.
> 
> That is a good point either, but I think that if two UID strings
> differ only by a leading backslash, it is kind of reasonable to assume
> that they were intended to not differ (or conversely, it is hard to
> believe that someone would intentionally add a leading backslash to
> distinguish one UID string from another).
> 
> So I'm going to apply this, but I will remove the Link: tag mentioned above.
> 
> Thanks for the feedback!

Thanks guys!  And sorry for sharing the wrong public URL, I didn't 
realize I shared an SSO one.  The important bit was copied into the 
thread anyway.

