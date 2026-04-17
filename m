Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012033.outbound.protection.outlook.com [52.101.48.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1133321BF;
	Fri, 17 Apr 2026 07:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776410561; cv=fail; b=nCCP4ZFep5nKc975POR8qf+8qrnTM+ASljPgwbNGhHv4pQzMMZRAz8vmd7mhHRCHd01TBxS173joFdXDT128POf/8HlTOIYJbrcF2mNGl0H3NE70YF62+fPY3/1m+dpVZpVdqBQU2WQXAcuOHM83jjQiYNyOlELy+2D7fqLaqcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776410561; c=relaxed/simple;
	bh=q0Ib/TD8ZolbppX5ePdC/268JcgTO6Xg7LYs50Bhivc=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=J2kCd0W7YWa8opQeL+qu2q6Ar/4sdahT+uRcwUauyhGDculQ4eS9fb1nWvPhGcn1mwQ9nKbIEqQqatynPSYnZCHD0Gsmd3Ggxw5GQX44EbEEhAO1XJID/UZsjwnxQYdsma5GC8VhQswr8I5VKptYpZgTjDD3PltIA2dp48MXsFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Gt6WuvbC; arc=fail smtp.client-ip=52.101.48.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Gt6WuvbC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jStF57mRrF5V3UhvUwbSi64r1HQPvHaiXvRCsZNNMHRz8tqSkhKLgHoKeheDDXFWqmIqGzEO12rqrtzNpLf8EbkPQicXb+jMpEDVFnu36ewxDIu8TH+csllhe9afRflq3DO4f1guNlF6BdmhECtljfI/fEhbD4RwQSIZ5dNEWJ04Uwe3wzcyLvHnycoxMEZ3h+LWmubtJFWubt1BraUtQOsaL2ITUHG5Y8TAanXLliZQDUg/oJ1dUsU6UlUPyTW/NJZC8p12wigUZkgquKK5LgHpw8yF50U/WzhcXG8hbRC7AO97XqWpzi1rpXGq/D/OD3M3c9dnwDqEER704W6mKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KORgjQ0TacuyxpuwaflnmatJSZQ7lzXfBwROvje0Oe4=;
 b=YeF63PTieBLip8g9lWQIfy6KopZBiilu+kZpyYTnxA79Pc4EYVXa7uIekbeFbuKFxkY9mTfJX49b21xXiyj+2h9Tve0f6WjOxCvq+l5FhJkXKBoXCJIgAOHjq0OqV0KsGL4lprEwYGJQaX0RoP4KQBX5cWLomsgEWECdseyPJNBmQ5w3NJwskpguMARuziYVa5/3/7gLk35XIyywnnlrleoJWg7tA3tmYXaTLgfGKo+51YFT4Juz6fmLT001Utu46CqwUK+hZAyHh+T1N4MaeUybKcmFkt2bS2dbRjwCediORfVtp9ZAk/LUGlukGOEORRUbxPYrBpD1IjgyvFUr0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KORgjQ0TacuyxpuwaflnmatJSZQ7lzXfBwROvje0Oe4=;
 b=Gt6WuvbCb1GmxFywfA8YNzlB+LnpYybqGs0qGnGSfIBarEYCzulAO+CsW1Gmbt7YbmTPwrRnpQYoaL1qUyz8H2fbW4abvBDBzj8in56yI+1OO5vqWIOwtpXPMh8a13fkWcyKpmlJMkXhpNeVVDnjx5JfCF3viw+muktsm4sOqMQIpbCF0MF7KWB6ntIYN49a2JPFBm7xfLjgVlNooDl1bECMmOXidoZSeoUWnQtkfi+6w2dsv7Mota6F3+d/iIBEbGztYNzL4WtCBB3FA8fWFdcRm/9+424WffohOIso+lM12CaDjBBdUjKw6Cr2x/LAl4mBVS1fHNjjElVhMJVnfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY1PR12MB9674.namprd12.prod.outlook.com (2603:10b6:930:106::9)
 by PH7PR12MB6953.namprd12.prod.outlook.com (2603:10b6:510:1ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.34; Fri, 17 Apr
 2026 07:22:34 +0000
Received: from CY1PR12MB9674.namprd12.prod.outlook.com
 ([fe80::4dd6:b793:a9af:5790]) by CY1PR12MB9674.namprd12.prod.outlook.com
 ([fe80::4dd6:b793:a9af:5790%4]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 07:22:34 +0000
Message-ID: <f2e926b4-b82d-4036-8098-484d3d72f3d1@nvidia.com>
Date: Fri, 17 Apr 2026 00:22:32 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "ACPI: CPPC: Fix remaining for_each_possible_cpu()
 to use online CPUs"
To: Jinjie Ruan <ruanjinjie@huawei.com>, "rafael@kernel.org"
 <rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260416085221.3476726-1-ruanjinjie@huawei.com>
 <c2669823-a057-466b-9e86-114386764f8c@nvidia.com>
 <407dc9c3-cd83-4881-a859-d7f14cb1b498@huawei.com>
 <f925dbeb-27be-48e5-90e0-2a22a12e740a@nvidia.com>
 <0523407c-de2c-4463-bde2-8753e01971d5@huawei.com>
Content-Language: en-US
From: Sean Kelley <skelley@nvidia.com>
In-Reply-To: <0523407c-de2c-4463-bde2-8753e01971d5@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR02CA0068.namprd02.prod.outlook.com
 (2603:10b6:a03:54::45) To CY1PR12MB9674.namprd12.prod.outlook.com
 (2603:10b6:930:106::9)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9674:EE_|PH7PR12MB6953:EE_
X-MS-Office365-Filtering-Correlation-Id: cbe91c45-8353-4af8-402e-08de9c52183c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	oNxMYVOcadEVWeBlrvnBjxMMBc91gKBEezUkmjRVlPMk/c69m1J0wgRrrm9dbrkJ1VexIarJYi5cPiDylVn5pMxDcip7QFBC5Xrvh09sve6eSnGn51/dNLsD89lVdLFPnH9SRXohLAWqwMdTEkL9J8k7k3vL5MiL+7sU9HJ32+FobOBQzbAnAXYmj2dOQO/RNmrQTJxDLqU+H9vGae0pFKYdeoU7CCBm1C04xhFGsCyQqj1yX6ANOmwcAyXLKDegmfmjolOUa4PLb9wdZ6yEVQeeZJQhdnfMAF0irqVArBnmra6Pm5g/azI98oyRErIq1fx7PE+3bG1/rAjDTnzNV+9yVrbBqyLh/rHGWmR+byqd4EB8IJvKGRhaikQMQx541EMWuuALuq432CcaQi00lu8GGdhEZtRTMzXFK62kn3BbuNvh1AhL4d7K2MQQULX44Sprn1Qu103JDmoaTNvm8WNUmJK2wF3cEsSAMSmZIZIavszwZag1UMUwbgMNK4pKgBFbmg1w6D4GNP3/mZvXJRdP4kahb0l07T91wrouwdVbkxi4AiH6oo9qOKy7CKOTZPlUqTNRAbbrkfcLIf+Ngp4HhKZUOi/9vI+ZjI0qOrr3nxrUm+shPtj8d3HGAmW5kPFci1ejY1DoDchbgIdGtnsuTptLnz83mIUntLM6BDtqxCzm8bSV1ryx9XBRl3/DiTQLZMvQS+W+0uTSF3I7oS+TAIW7dC2sD/bkgIAMYeY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9674.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q0s2UmQwalJKNGFxZHI3N0Z5aFNUU0QyemQ1QmRrSGNWamR1QytLUmp6ME0r?=
 =?utf-8?B?MkN3aStDcit4bnQ3RVBiRzhscW1tZUJ6WUtFd3dOUjBidnlTbUM5MjNJS3dN?=
 =?utf-8?B?UEFjQTIxQi81Y0JxbFdJYzZjOVM3QTh6ZTJWcnVRZVJWRDZDS21ESEhwS21a?=
 =?utf-8?B?bEwxQU1VaTBYN1dDQWpia2ZmbGplcXpzL3pHdVJRcFpwQXFOOUVYb0JDanVn?=
 =?utf-8?B?TkR2REt2aE13ZnpsbjRVL1I1dCt3RDE3cS94Tm1IOXZmMHo0dVZ2cVFFaTZt?=
 =?utf-8?B?ZWxtWnJQUzBoSWNPSGYxMmM0V29NU2dRSElPVVJkdzFBdW1Hemx6QlZIcCtZ?=
 =?utf-8?B?cFA4YzhRd3ozT01OdGI5Rzh2ZEVBamtZV1dBOFNjU29OU3NLT1NKSEkwQmdK?=
 =?utf-8?B?dnJrTm95SXdnSWZsV0lqME1xVmxvbkxWUTFhSU1LVmVsc2VnVzVnem1hb2w5?=
 =?utf-8?B?M0p0WnAvMW9JOUVqK1pBQk02eVdSbnQzQkFCcmtBRVh3M1ozazQwTXFxK0xh?=
 =?utf-8?B?YWZxVkhDNzJXanlmWHJSOVhOREZoREpyWmk2M0Z6T0UrUlhLUDN3ZTFXbWh1?=
 =?utf-8?B?amFuNmVHMm9ZL3hmajVmRjZNNGEvdmR0WG9pUzkwR3pFRFZwb0ljRGh5bk51?=
 =?utf-8?B?UUxqN29veFBYbExWMFZDUzhQWm5CZHRvd1VYTm15SURQUXA5UU5MQ1NkZzAw?=
 =?utf-8?B?N0pXR1N2Mm9BYWEvbzkxdTVJTCtRR2NuZDU1dXhvTDlYRmVmSHNFZ3VaY1k3?=
 =?utf-8?B?WkJMWTN0b0U2N2VodjFOU3pRUitLZ0ZoUndSNnBDS25Qak9QZ3c0NnBoZGwv?=
 =?utf-8?B?WStPNzNwYTlsa1Q3K3NweW11aHZxUlNtRkZHaXVUUFBXcG80bGhxTWttczds?=
 =?utf-8?B?WFVNdlBoSGJaUEpFSlNoc242V0Y2a0htL0VxMFZvWCtCV09yNW03cnF4cFZI?=
 =?utf-8?B?UDN5clZYbUdaRU1OYlZIK0lFeTFmZ1M5eXlaSk5ja05JczVsUDJHWWdlUENU?=
 =?utf-8?B?Wng5M3Rnc2d3UWVZb1pQWGRiKzBWK09MU0VJeG5qZDZjQnB0a21wa1g1Yjl4?=
 =?utf-8?B?NWdMRjE0ZzgxZVFya0JXTFJhdmtaQzg2K3VzYTBaZDNCWWxGenFGOUpFNmJi?=
 =?utf-8?B?VkhxUnNLbS9kUjFTMXUzRVA0TzMyOTEwWHJIeWRZYjFxS3Jld29MREwyaHJY?=
 =?utf-8?B?UmJrWHJtY3k3RVhoVk54blhidEF2ckxMUDlrWkZaVHdObVJMeWZQRjQ0TDds?=
 =?utf-8?B?LzBrNVMxaW1ibS85TzZCTjlRUXFxbGhMUUYwdUpSUzNiZEdpSmQ2SkRWd2FV?=
 =?utf-8?B?TGZWMHBHUGFEbCtHWVpQTXl4ZGNPREJGOXAxQkxGNGRGWWdqMG02Y1lHSG5j?=
 =?utf-8?B?aEI3N2xrU2pqRSsvWmlZTjZwQ0ZFVFZSbjdGSXI3aERvOEFUZ3ZrdWE1WFRy?=
 =?utf-8?B?TnRDM05CT1hOSExvS2MyM25oMXNLbzJBVjM3OVNsRjdWTzBaeGJwUXhzcEd3?=
 =?utf-8?B?c1V0M1NhRkl3RHczQnllKzQ2R292amh0Q1B0VGYwdUZxejZkcWJLbFJnZ2Y5?=
 =?utf-8?B?MWtVb0x6VG53R3NNTWIrZkw5YXE0R09BK1l6amttekt4UUl5WDdPcFVHRUxD?=
 =?utf-8?B?VHhBZmNmcmdObHUycGJUcStEeVFPVk4xTy9GTUFEenhkUXQ3S2R2dmJCcEVh?=
 =?utf-8?B?Mk1Xd09LSzgrS1BKYzhtcUdZMjV1RjNpaG8vSkpOck9XUzM0bUNXNUtzQWJ4?=
 =?utf-8?B?YUczdDhmYW5YRWxuZnd4VGs0Z2VXZkcxR0UzWThCQ2dLWDhSZ2FJVHIrNmJ1?=
 =?utf-8?B?azhsVlNycFpxd1dWZ1FXbnVzVWNmRk1BWEMwZWxsOEdKdWJnbFlXSFRJa0s2?=
 =?utf-8?B?VzI1cHJLbHVLSTkza0RqVTd1WTgvZ3BWd2NZeDRaNUNKeTJzWG9pV3B1OUFG?=
 =?utf-8?B?cDZPajVHV0x6U2JHSVhwR3FiWW11OE1DNGJnM3NNWGs2cFIvSC9RU2YvcDNT?=
 =?utf-8?B?VWt0c0hicVBhMFBaSjhEaVBWQkFYbU5TZWEyNDJlTmkySFQzTk9MQmJyL1l2?=
 =?utf-8?B?dVcxL0UrUC9TZm1ZbmlxWXc5WmhuN3ZZeFVkckV1Z3llRlhmMkk2VStVY1dH?=
 =?utf-8?B?Sm50S2JoRVV4SlJoME5wdTl1bkd4bnp6dS9rQ2hFQjI1MWFlenl6cUh4RC9w?=
 =?utf-8?B?b3VndUp0QitwRjh0WXd1YzZHcjZ0RzJwT2xycjlXN3FkODJwWktER0Zjd1E1?=
 =?utf-8?B?TitXUXlZeWtuU0hqMlhVaWh3akllUEtGK2Y4K1lJUU11K0g5VWUvS1NuZE1r?=
 =?utf-8?B?dkU5ejYrRmp0QThJOXh1TFgrRUUyckhHTTZ6RkJNNFJ5Y2xtYTRRdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbe91c45-8353-4af8-402e-08de9c52183c
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9674.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 07:22:34.2223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aHA7J7oHZKkWc+gdiYqclQhiwBa3YIe0r+mtQbF1U+dm84xI2IyyIjChPpHa66j4CQz4djcM5zB4eSfLpmXN9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6953

On 4/16/26 8:46 PM, Jinjie Ruan wrote:
> 
> 
> On 4/17/2026 11:00 AM, Sean Kelley wrote:
>> On 4/16/26 7:00 PM, Jinjie Ruan wrote:
>>>
>>>
>>> On 4/17/2026 3:36 AM, Sean Kelley wrote:
>>>> On 4/16/26 1:52 AM, Jinjie Ruan wrote:
>>>>> This reverts commit 56eb0c0ed345da7815274aa821a8546a073d7e97, because
>>>>> this commit cause warning call trace below when concurrently
>>>>> bringing up
>>>>> and down two SMT threads of a physical core.
>>>>>
>>>>> The issue timeline is as follows:
>>>>>
>>>>> 1. when the system starts,
>>>>>       cpufreq: cpu: 220, policy->related_cpus: 220-221, policy->cpus:
>>>>> 220-221
>>>>>
>>>>> 2. Offline cpu 220 and cpu 221.
>>>>>
>>>>> 3. Online cpu 220
>>>>> - cpu 221 is now offline, as acpi_get_psd_map() use
>>>>> for_each_online_cpu(),
>>>>>       so the cpu_data->shared_cpu_map, policy->cpus, and related_cpus
>>>>> has only
>>>>>       cpu 220.
>>>>>       cpufreq: cpu: 220, related_cpus: 220, cpus: 220
>>>>>
>>>>> 4. offline cpu 220
>>>>>
>>>>> 5. online cpu 221, the below call trace occurs:
>>>>> - Because cpu 220 and cpu 221 share one policy, and policy-
>>>>>> related_cpus
>>>>>      = 220 after step 3, so cpu 221 is not in policy->related_cpus
>>>>>      but per_cpu(cpufreq_cpu_data, cpu221) is not NULL.
>>>>>
>>>>> The _PSD (P-State Dependency) defines the hardware-level dependency of
>>>>> frequency control across CPU cores. Since this relationship is a
>>>>> physical
>>>>> attribute of the hardware topology, it remains constant regardless
>>>>> of the
>>>>> online or offline status of the CPUs.
>>>>>
>>>>> Using for_each_online_cpu() in acpi_get_psd_map() is problematic. If a
>>>>> CPU is offline, it will be excluded from the shared_cpu_map.
>>>>> Consequently, if that CPU is brought online later, the kernel will
>>>>> fail to
>>>>> recognize it as part of any shared frequency domain.
>>>>>
>>>>> Switch back to for_each_possible_cpu() to ensure that all cores defined
>>>>> in the ACPI tables are correctly mapped into their respective
>>>>> performance
>>>>> domains from the start. This aligns with the logic of policy-
>>>>>> related_cpus,
>>>>> which must encompass all potentially available cores in the domain to
>>>>> prevent logic gaps during CPU hotplug operations.
>>>>
>>>>
>>>> Yep, agree that using for_each_online_cpu() in acpi_get_psd_map()
>>>> drops valid domain members and breaks the hotplug case you described.
>>>>
>>>> But a plain revert also re-exposes the nosmt bug. On systems where a
>>>> possible CPU is never probed, per_cpu(cpc_desc_ptr, i) is NULL and
>>>> acpi_get_psd_map() currently hits goto err_fault instead of just
>>>> skipping that CPU.
>>>
>>> I have a question regarding the original issue where it states 'This
>>> breaks systems booted with "nosmt" or "nosmt=force"'. As far as I know,
>>> the 'nosmt' parameter is only supported on x86. However, it seems the
>>> current x86 kernel does not support enabling CONFIG_ACPI_CPPC_CPUFREQ
>>> (only supported on arm64/arm/riscv). Could you please share the details
>>> of your testing environment?
>>
>> Yeah, good question. However, nosmt is actually defined generically in
>> kernel/cpu.c
>> (early_param("nosmt", smt_cmdline_disable)), not in any
>> arch-specific code, so it works on anything that selects HOTPLUG_SMT.
>>
>> arm64 does:
>>    arch/arm64/Kconfig    select HOTPLUG_SMT if HOTPLUG_CPU
>>
>> And acpi_get_psd_map() is called from drivers/cpufreq/cppc_cpufreq.c,
>> which has: depends on ARM || ARM64 || RISCV.
>>
>> So the overlap where this bug actually triggers is arm64. Testing was
>> on an NVIDIA Vera (Olympus) platform booted with "nosmt". That's the
>> environment where the original -EFAULT failure in acpi_get_psd_map()
>> was reproduced.
> 
> After reverting commit 56eb0c0ed345 ("ACPI: CPPC: Fix remaining
> for_each_possible_cpu() to use online CPUs"), I tried to reproduce your
> original issue on my local ARM64 machine with the 'nosmt' boot parameter
> enabled and I have confirmed that it works., but I couldn't trigger it
> and the acpi cppc cpufreq driver successfully registered. Could you
> please help test if the new fix resolves the problem you encountered
> previously?
> 
> Best regards,
> Jinjie
> 


Hi Jinjie,

Applied v2 on current master and built for arm64 (NVIDIA Vera, has SMT).

Tested both scenarios:

1. nosmt boot -- cppc_cpufreq registers cleanly, no -EFAULT, no
    warnings in dmesg.

2. Concurrent hotplug of SMT siblings (your original reproducer
    adapted to valid CPU indices on my system). Ran the dual
    offline/online loop for 30s. No WARN, no cpufreq_online call
    trace.

Both pass.

Thanks!

Sean




>>
>>>
>>>>
>>>> So I think the fix is to restore for_each_possible_cpu() for the PSD
>>>> map, but change the NULL case to continue:
>>>
>>> I agree.
>>>
>>>>
>>>> --- a/drivers/acpi/cppc_acpi.c
>>>> +++ b/drivers/acpi/cppc_acpi.c
>>>> @@ -530,7 +530,7 @@
>>>>
>>>>                   match_cpc_ptr = per_cpu(cpc_desc_ptr, i);
>>>>                   if (!match_cpc_ptr)
>>>> -                       goto err_fault;
>>>> +                       continue;
>>>>
>>>>                   match_pdomain = &(match_cpc_ptr->domain_info);
>>>>
>>>> That way offline CPUs with valid descriptors remain in shared_cpu_map
>>>> (fixing the hotplug trace), while never-probed CPUs are skipped
>>>> instead of failing map construction.
>>>>
>>>> The send_pcc_cmd() hunk already does if (!desc) continue, so reverting
>>>> that loop back to for_each_possible_cpu() looks fine as-is.
>>>>
>>>> Happy to send the continue fix as a patch on top, or please feel free
>>>> to fold it into yours if that makes sense.
>>>
>>> Thanks! I will fold your fix into my patch and add your Co-developed-by
>>> tag in the next version.
>>>
>>
>> Sounds good, thanks.
>>
>> Sean
>>
>>>>
>>>> Sean
>>>>
>>>>>
>>>>> How to reproduce, on arm64 machine with SMT support which use acpi cppc
>>>>> cpufreq driver:
>>>>>
>>>>>       bash test.sh 220 & bash test.sh 221 &
>>>>>
>>>>>       The test.sh is as below:
>>>>>           while true
>>>>>               do
>>>>>               echo 0 > /sys/devices/system/cpu/cpu${1}/online
>>>>>               sleep 0.5
>>>>>               cat /sys/devices/system/cpu/cpu${1}/cpufreq/related_cpus
>>>>>               echo 1 >  /sys/devices/system/cpu/cpu${1}/online
>>>>>               cat /sys/devices/system/cpu/cpu${1}/cpufreq/related_cpus
>>>>>           done
>>>>>
>>>>>       CPU: 221 PID: 1119 Comm: cpuhp/221 Kdump: loaded Not tainted
>>>>> 6.6.0debug+ #5
>>>>>       Hardware name: To be filled by O.E.M. S920X20/BC83AMDA01-7270Z,
>>>>> BIOS 20.39 09/04/2024
>>>>>       pstate: a1400009 (NzCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
>>>>>       pc : cpufreq_online+0x8ac/0xa90
>>>>>       lr : cpuhp_cpufreq_online+0x18/0x30
>>>>>       sp : ffff80008739bce0
>>>>>       x29: ffff80008739bce0 x28: 0000000000000000 x27: ffff28400ca32200
>>>>>       x26: 0000000000000000 x25: 0000000000000003 x24: ffffd483503ff000
>>>>>       x23: ffffd483504051a0 x22: ffffd48350024a00 x21: 00000000000000dd
>>>>>       x20: 000000000000001d x19: ffff28400ca32000 x18: 0000000000000000
>>>>>       x17: 0000000000000020 x16: ffffd4834e6a3fc8 x15: 0000000000000020
>>>>>       x14: 0000000000000008 x13: 0000000000000001 x12: 00000000ffffffff
>>>>>       x11: 0000000000000040 x10: ffffd48350430728 x9 : ffffd4834f087c78
>>>>>       x8 : 0000000000000001 x7 : ffff2840092bdf00 x6 : ffffd483504264f0
>>>>>       x5 : ffffd48350405000 x4 : ffff283f7f95cc60 x3 : 0000000000000000
>>>>>       x2 : ffff53bc2f94b000 x1 : 00000000000000dd x0 : 0000000000000000
>>>>>       Call trace:
>>>>>        cpufreq_online+0x8ac/0xa90
>>>>>        cpuhp_cpufreq_online+0x18/0x30
>>>>>        cpuhp_invoke_callback+0x128/0x580
>>>>>        cpuhp_thread_fun+0x110/0x1b0
>>>>>        smpboot_thread_fn+0x140/0x190
>>>>>        kthread+0xec/0x100
>>>>>        ret_from_fork+0x10/0x20
>>>>>       ---[ end trace 0000000000000000 ]---
>>>>>
>>>>> Cc: stable@vger.kernel.org
>>>>> Fixes: 56eb0c0ed345 ("ACPI: CPPC: Fix remaining
>>>>> for_each_possible_cpu() to use online CPUs")
>>>>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>>>>> ---
>>>>>     drivers/acpi/cppc_acpi.c | 4 ++--
>>>>>     1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>>>>> index f0e513e9ed5d..9ae29f2c6db8 100644
>>>>> --- a/drivers/acpi/cppc_acpi.c
>>>>> +++ b/drivers/acpi/cppc_acpi.c
>>>>> @@ -362,7 +362,7 @@ static int send_pcc_cmd(int pcc_ss_id, u16 cmd)
>>>>>     end:
>>>>>         if (cmd == CMD_WRITE) {
>>>>>             if (unlikely(ret)) {
>>>>> -            for_each_online_cpu(i) {
>>>>> +            for_each_possible_cpu(i) {
>>>>>                     struct cpc_desc *desc = per_cpu(cpc_desc_ptr, i);
>>>>>                       if (!desc)
>>>>> @@ -524,7 +524,7 @@ int acpi_get_psd_map(unsigned int cpu, struct
>>>>> cppc_cpudata *cpu_data)
>>>>>         else if (pdomain->coord_type == DOMAIN_COORD_TYPE_SW_ANY)
>>>>>             cpu_data->shared_type = CPUFREQ_SHARED_TYPE_ANY;
>>>>>     -    for_each_online_cpu(i) {
>>>>> +    for_each_possible_cpu(i) {
>>>>>             if (i == cpu)
>>>>>                 continue;
>>>>>     
>>>>
>>>>
>>>
>>
>>
> 

