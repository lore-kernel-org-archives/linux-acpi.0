Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013012.outbound.protection.outlook.com [40.93.201.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B652DF136;
	Fri, 17 Apr 2026 03:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776394833; cv=fail; b=MUUmz6ErPBhoZXES/TdxH0bucCGybAW55a1r8hl54lD/RFLf8XgyhhvqlBwimGWGizPftufNT78gzuFMzLvBR7/+AgWVIyqqWgmdQ+FgvP9s1nA1pwjaY499Q+NKo5N2dgbixb1nRRgJbUIDFpSa8YM9btr601rb2+UkR7Xc1/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776394833; c=relaxed/simple;
	bh=SKvhYuXXBS6CNZ+Dpw7AhFBHRVHY22Z1BHEydLqQg9g=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CVPAPlCqV/nB1uYAtBVZyvADIlpP/WgyAX+cHKkEFMcUNi7bTVLgziLNndVF5NQNAQiaD3Ww7rSzXP+vMgOQKo4DIe6V5HrJEFCt4Ld5zrH7lwhj4Qz+Ma8cCbT5k6GzjB83tfAXIfkYlHBVACQ7cjgAddhEEEHshmPyY2jqo7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y4OOOI6p; arc=fail smtp.client-ip=40.93.201.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y4OOOI6p"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QV1fWMwShHvcndEJIwckppqH6JH2t79wxC4P100Qky6dI3o0o7jX5Howoua9RGcUZE/h/Km9ofzo9PTDlzRiSp9SMg4PSGbBtLMypp9CggaGSVz5jELkJkZWE23DZCmbEdgeXdaFoMBGEg4QpgD2J525CIX+PYXOfrzRYVBcyROi+HhJzPtY9ktAI2WFNW5iRNdWnFzABD94VirxHacryel5mpqDo9iPdjZbMJ66RSD8uEnSbqO/5o22Hehc//AWq97b5fVyZn5pO48YW0bOuHUey/F0INJ4xby9+2QR/9OFCvqxxbcnP1qMjT8rLgMLvBVMN/cq8qrK4fjHW3Stng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n016a8heWcbqSkBuuFtvTNHVIEwWikRDaDClFquupxw=;
 b=apgSpYa6NJdIYSJw1D7SwjaWB5kQzb1phZck48593n5AF16D5rV1GNwl7oaNbO5pS2hXgUal8Qj2stVQoIV2R/kDFlW2+14q1iCUneBOVJuljYaDlOEEDEONAnF+7DRHC3+pex4Gd7IJY6TYFBzkAH3i806hEPuOMJiH+SROjyj/3t+wdalQNIAs3u3y+p041xabsbJI+teo4CjYzbWkhQFgkMHNo+UeG1d14UyCRIwz4VBgxQYS7yu1N6Lma/ejeFam2pKQQamWfQd+5AAPbFzfPUKwNzsYuYUbtsGqEX5Bl4lUWsVI+Cl4z4qpb9Tuds/Zhxlskrek54ERwJoWVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n016a8heWcbqSkBuuFtvTNHVIEwWikRDaDClFquupxw=;
 b=Y4OOOI6pQjMuXxQjP2xOIm7bDQkbe3biO0Nin6oBFeFFvdXQnkyqHu5V936Ofi68gs7Vbg8vege10hEKR/j/Mgbbth2SicTTo9vsxJgYolaYHFpl9TTJcd8+uXZiFmOsq1e+dgtB2DGVQhspwJ/6ztsnFsF4NN0d8cSDO0F7oxcaqa+veivrrZHJRpwu2XsAyJjDYj6D+kwKGaR2Kw6hLk2aBRROT9dskU2JvCym+Ec0bpPEIMKEREVFqJrKRLnNEtzjt7OE6THSBpZfxc9XC9pCII/lL1ohmPGcUW4PLm6ambKVAzSj9yud6jz26uTp6mA5v5xhZHkNH87Vit53dg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY1PR12MB9674.namprd12.prod.outlook.com (2603:10b6:930:106::9)
 by IA1PR12MB7614.namprd12.prod.outlook.com (2603:10b6:208:429::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 03:00:27 +0000
Received: from CY1PR12MB9674.namprd12.prod.outlook.com
 ([fe80::4dd6:b793:a9af:5790]) by CY1PR12MB9674.namprd12.prod.outlook.com
 ([fe80::4dd6:b793:a9af:5790%4]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 03:00:27 +0000
Message-ID: <f925dbeb-27be-48e5-90e0-2a22a12e740a@nvidia.com>
Date: Thu, 16 Apr 2026 20:00:25 -0700
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
Content-Language: en-US
From: Sean Kelley <skelley@nvidia.com>
In-Reply-To: <407dc9c3-cd83-4881-a859-d7f14cb1b498@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0P220CA0013.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::20) To CY1PR12MB9674.namprd12.prod.outlook.com
 (2603:10b6:930:106::9)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9674:EE_|IA1PR12MB7614:EE_
X-MS-Office365-Filtering-Correlation-Id: 716cbe67-6e83-44e5-462e-08de9c2d7a65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	4uOoEnYm5L/tJJRDNv5IFSZBnmnlteeUFjEevmQOrc/Rh5AtB6XKjndoIqGL5ExjVJRFSazUetz5JXqK3G+WC4NGDxluAOd9xx2/NGEZsmobFMH++N/H5htCrNOijXQFNSvhB1eX/6GphvxPDJEPrABQYtLG6zP1PnYTsyUM/qmekFt2bLyeLtclY76SCnJCUoyUx433kS0Tx3C32E+FSStSZ5INI9TksfMVmCxDNUyi0UfOTHoxc4hPaNW1WHLE2lB8e5JYhCfirjNuUcRgWWbBi6iZwi7m5WMKknSSwXX1ZYUiXXkXpVCwUr6sBM6WxGpoIAyu7xY2bm5y2IZxnHcaMP8T2PjP+92JibZkgtw7sV2QCc+ppS1T20JTZ5Vqy1WkhWPhTgSNA3a5JKnKeZj8SweOeBxa6MKXUDT07Tz6CaSLSii25m8Y60QjgPYPyfeHjSmr+66+76XWHYpv9kNOYxZEJhdEi79O3p5HGGqOYoYAoHlUSZHSCrMmhlZy5gqIXRvjAHew7ZehD0akx4LApNVsWkBsjE5qvt86+TJGso+gskgFFMbMA//+/BO4nDxYpnb/l/8UAGpHjA98WgZlaF9bZoHS6/35m94+vuARWb265V4vEhvnrO+SYB/EojiBVvqIc8MZ0oXKP4nsfwnI4d7CIqBV/RJqD5hzIG04lH3+4KKw7oTetOymK/V4xGu6+BqQsKoHs1tHn7dJKhtyMVlOs9rCBLVDJ1kC+qg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9674.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YXpKZlhTdFNWbkl6UWJXQy9vMC9WZWV1ak0vUjVHMi9LdjEyNXcvcWJBNDlH?=
 =?utf-8?B?aWlLM1ZKWHZIRFNvWmY3UExBTlZWaE5ETXE1a251YndpaWc4dHp3L0lBa1Vt?=
 =?utf-8?B?b2FtZW9KaHZ0QWlMRy9BbzhTd3UrSG5scnNOeXhxNnNKWG1RZzEyOFhtTG1M?=
 =?utf-8?B?cnF0dXVRbU9EZUlmY05TdVNXN2RzM29UZldaYlhVcG0vbXB0VlhkaXNLL2xP?=
 =?utf-8?B?cmpYWmpWTkhQU2F1V3djRWpHSE52TE1la1liNmhaQktlSW5HdWs0V2pGb20x?=
 =?utf-8?B?MEN2ZllBYlMyejJ0aWxOb0ZqeVFDRVRuV1RjeXNNalk4L1BXdmhjRG8yS3lX?=
 =?utf-8?B?ODVTUytMRUVjSndJTy9rYVMraVBHOEE5NlNxck92bldZSmJvWXJpM3g1Y0JB?=
 =?utf-8?B?c0lXY3FJTDRlVXdCSm1yUnJ3dXB4RjNyOHZ4QkJEdkVLbWh0QVloRVR2T1JZ?=
 =?utf-8?B?cVowOEpmOFZaK0Z2bzdpVzdmdk9UZTRQRHI0b0tVcHpKcXRaVnJHSVlPSVNC?=
 =?utf-8?B?RHJvVTh0TkY1SWlsakloRkhRV3JQRiszZTl2bGZxSjRCRXFwQ2RjQTkyMGov?=
 =?utf-8?B?NTdEOFZ4R3Y2Z0EwSzRNazhvdWppNk1oMDNNajdKcURHdXZjdW1nc3ErdUV3?=
 =?utf-8?B?aTVpVncvVjQ5MDRtVVpGbkJ5RWYxSkdvaGZWNCtOaUJtL2J3U01SU0JJRlpH?=
 =?utf-8?B?dUhMdFZ2R0dyY3pQWWpETWs4Q1lEMVNvS2dHc0JTZkdDYnFOWWREeFR1WXVr?=
 =?utf-8?B?NGMyMTlxSCs1TXVsUXp4Qmwza0pFV3grQ2UrSU9OdFhVSUdFRHpqSnFzQUdj?=
 =?utf-8?B?NDk1TVlXVUJ3bDFPd3hsN1hReUhreGhWK2VSZTVNTXhHaFdzSWF2Yk8ybWNi?=
 =?utf-8?B?MVlVcUs3VHcrczF5d0cxUXZZK2ZXQitRdVlEd2QrTFVqeW11NmF6enRmMmUx?=
 =?utf-8?B?aVI4RmlwT29xU0JPb3I1L2Z6VzZHS2htQllUMGNrTytMVkdYRys3NThFSC9w?=
 =?utf-8?B?M0FTelByalFWc1NSb0VnMW92dWdnamdsOG1rVTZzZUdYK1R6MFYyTzNaMFlw?=
 =?utf-8?B?VkkyNUI1UE9PcE9KQ3MrQ2orRkhDQmVYbk80bEdya1c5MXZNNzJnWURiekMx?=
 =?utf-8?B?eklMcXpuam1Lc0svZHBjdXhXUVptVkJ3SzJVN1BKdEk5VFdNMmJNbm5GMXEx?=
 =?utf-8?B?OVdmSlBaUy9nM0ZZZ0xoUkZnZXpVaENFdjl0Vjh5Q0F6TzVucmdpTTk2ZzdS?=
 =?utf-8?B?Zi9Fd1lhWmR6VEJnazM0b1M3K3c4ZmNZcnkwNG9VRDVFVmZUQlYzY2dNK0sy?=
 =?utf-8?B?SDllVEFlYllRWGZrQ3IvRnluc3pkWTBycVNBNVF5eDVCMmVad2N3RTlHanpP?=
 =?utf-8?B?ZDZ3aEp6eHJ0NE1BTlFZRnBoT2Q0VG01Mi90bGQvVDBuNzh2b0dnTTBUcmJy?=
 =?utf-8?B?YjNnTllYT3lUaEp0YU0xUmQyOERKK3RCalU1MlRvTzZITnpFbXJKNEFCdDhM?=
 =?utf-8?B?RW1Ia2E5czR3d2VhamNQbXZBSUhLTGl2YTFBaU94aXZMV2d1Y1Zock03SkNB?=
 =?utf-8?B?TE1qWWQ0ZFhSY2U3K3pNNllKSWY5NGIyaGtHWkZtaitUZ1cvYkFzUnRFWElD?=
 =?utf-8?B?blZ0RlN4ZFlPRHl4ZjNkTmg3N0hZVld4aW5rbGpERS9PVnduRkt0NVFCb0JW?=
 =?utf-8?B?TlFOVXF3RTdZOUErb1ZwSStNOXRkTkc3TFJCZFdyNnZBMU80eG5wQU1GbkFD?=
 =?utf-8?B?R2tzTURSYi90bEMxY1NuVTFscFhhVEM4eFlyanQyMFg1Nm15ZzllVjQxRWdQ?=
 =?utf-8?B?OUZudnUza0VEenI4TU5IaklZbytpeWF6SG4rb2FQOCt2c3k3dHRIQUU3dDNs?=
 =?utf-8?B?N1k4RTFhY1pFTmFKeWhqNG1NTFVSUjhRSlBLYnI0Sk10Q2lVMFREQzVUWGRN?=
 =?utf-8?B?NVp2ZTdHTnRHY2l2bk1qbVR4SlBCcXNJbng0T2cyN2t4dFQxZHpTKzUzS2Yw?=
 =?utf-8?B?TGpIc0J5K0RGSEswOGdlT0VQWjRrSG1palFKNHg1VmtBdFRuMW1kNmE0eGlr?=
 =?utf-8?B?WkpBUi9hNUM2V2VyQVBFWjkrSHNPZk04aFFscXFmczUvZVJPYTF1VnRRUWh6?=
 =?utf-8?B?QjEwUExYd0psNVhLTnM5bnRhblNidkdQTThvSE8rVXNRRkRvOTRCT2hQNlNs?=
 =?utf-8?B?V3pGcklXRTZFL2Z6V2ozakJ6MzZkbGY4UXVBTmtZWTBwamljVm9rWEdiNllL?=
 =?utf-8?B?eHg5WEREZWJOeFhBVFZRSU9Da2xTQU9LMi9nSWhRbzYzdG0xZnFUaGNkRnp3?=
 =?utf-8?B?TzIxd3NRSFNoT29ZMkJkbzJEZkJITndycSsybStTUWdCcWpVQUU4Zz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 716cbe67-6e83-44e5-462e-08de9c2d7a65
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9674.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 03:00:27.5500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VEkSHWXgajy9KDzFYJzxKpmiIeFIcNb0YU8yuBvh8myU583yYnbltsPJV0gCUYlAx5xvv+aX6zj3UUCzbVokhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7614

On 4/16/26 7:00 PM, Jinjie Ruan wrote:
> 
> 
> On 4/17/2026 3:36 AM, Sean Kelley wrote:
>> On 4/16/26 1:52 AM, Jinjie Ruan wrote:
>>> This reverts commit 56eb0c0ed345da7815274aa821a8546a073d7e97, because
>>> this commit cause warning call trace below when concurrently bringing up
>>> and down two SMT threads of a physical core.
>>>
>>> The issue timeline is as follows:
>>>
>>> 1. when the system starts,
>>>      cpufreq: cpu: 220, policy->related_cpus: 220-221, policy->cpus:
>>> 220-221
>>>
>>> 2. Offline cpu 220 and cpu 221.
>>>
>>> 3. Online cpu 220
>>> - cpu 221 is now offline, as acpi_get_psd_map() use
>>> for_each_online_cpu(),
>>>      so the cpu_data->shared_cpu_map, policy->cpus, and related_cpus
>>> has only
>>>      cpu 220.
>>>      cpufreq: cpu: 220, related_cpus: 220, cpus: 220
>>>
>>> 4. offline cpu 220
>>>
>>> 5. online cpu 221, the below call trace occurs:
>>> - Because cpu 220 and cpu 221 share one policy, and policy->related_cpus
>>>     = 220 after step 3, so cpu 221 is not in policy->related_cpus
>>>     but per_cpu(cpufreq_cpu_data, cpu221) is not NULL.
>>>
>>> The _PSD (P-State Dependency) defines the hardware-level dependency of
>>> frequency control across CPU cores. Since this relationship is a physical
>>> attribute of the hardware topology, it remains constant regardless of the
>>> online or offline status of the CPUs.
>>>
>>> Using for_each_online_cpu() in acpi_get_psd_map() is problematic. If a
>>> CPU is offline, it will be excluded from the shared_cpu_map.
>>> Consequently, if that CPU is brought online later, the kernel will
>>> fail to
>>> recognize it as part of any shared frequency domain.
>>>
>>> Switch back to for_each_possible_cpu() to ensure that all cores defined
>>> in the ACPI tables are correctly mapped into their respective performance
>>> domains from the start. This aligns with the logic of policy-
>>>> related_cpus,
>>> which must encompass all potentially available cores in the domain to
>>> prevent logic gaps during CPU hotplug operations.
>>
>>
>> Yep, agree that using for_each_online_cpu() in acpi_get_psd_map()
>> drops valid domain members and breaks the hotplug case you described.
>>
>> But a plain revert also re-exposes the nosmt bug. On systems where a
>> possible CPU is never probed, per_cpu(cpc_desc_ptr, i) is NULL and
>> acpi_get_psd_map() currently hits goto err_fault instead of just
>> skipping that CPU.
> 
> I have a question regarding the original issue where it states 'This
> breaks systems booted with "nosmt" or "nosmt=force"'. As far as I know,
> the 'nosmt' parameter is only supported on x86. However, it seems the
> current x86 kernel does not support enabling CONFIG_ACPI_CPPC_CPUFREQ
> (only supported on arm64/arm/riscv). Could you please share the details
> of your testing environment?

Yeah, good question. However, nosmt is actually defined generically in 
kernel/cpu.c
(early_param("nosmt", smt_cmdline_disable)), not in any
arch-specific code, so it works on anything that selects HOTPLUG_SMT.

arm64 does:
   arch/arm64/Kconfig	select HOTPLUG_SMT if HOTPLUG_CPU

And acpi_get_psd_map() is called from drivers/cpufreq/cppc_cpufreq.c,
which has: depends on ARM || ARM64 || RISCV.

So the overlap where this bug actually triggers is arm64. Testing was
on an NVIDIA Vera (Olympus) platform booted with "nosmt". That's the
environment where the original -EFAULT failure in acpi_get_psd_map()
was reproduced.

> 
>>
>> So I think the fix is to restore for_each_possible_cpu() for the PSD
>> map, but change the NULL case to continue:
> 
> I agree.
> 
>>
>> --- a/drivers/acpi/cppc_acpi.c
>> +++ b/drivers/acpi/cppc_acpi.c
>> @@ -530,7 +530,7 @@
>>
>>                  match_cpc_ptr = per_cpu(cpc_desc_ptr, i);
>>                  if (!match_cpc_ptr)
>> -                       goto err_fault;
>> +                       continue;
>>
>>                  match_pdomain = &(match_cpc_ptr->domain_info);
>>
>> That way offline CPUs with valid descriptors remain in shared_cpu_map
>> (fixing the hotplug trace), while never-probed CPUs are skipped
>> instead of failing map construction.
>>
>> The send_pcc_cmd() hunk already does if (!desc) continue, so reverting
>> that loop back to for_each_possible_cpu() looks fine as-is.
>>
>> Happy to send the continue fix as a patch on top, or please feel free
>> to fold it into yours if that makes sense.
> 
> Thanks! I will fold your fix into my patch and add your Co-developed-by
> tag in the next version.
> 

Sounds good, thanks.

Sean

>>
>> Sean
>>
>>>
>>> How to reproduce, on arm64 machine with SMT support which use acpi cppc
>>> cpufreq driver:
>>>
>>>      bash test.sh 220 & bash test.sh 221 &
>>>
>>>      The test.sh is as below:
>>>          while true
>>>              do
>>>              echo 0 > /sys/devices/system/cpu/cpu${1}/online
>>>              sleep 0.5
>>>              cat /sys/devices/system/cpu/cpu${1}/cpufreq/related_cpus
>>>              echo 1 >  /sys/devices/system/cpu/cpu${1}/online
>>>              cat /sys/devices/system/cpu/cpu${1}/cpufreq/related_cpus
>>>          done
>>>
>>>      CPU: 221 PID: 1119 Comm: cpuhp/221 Kdump: loaded Not tainted
>>> 6.6.0debug+ #5
>>>      Hardware name: To be filled by O.E.M. S920X20/BC83AMDA01-7270Z,
>>> BIOS 20.39 09/04/2024
>>>      pstate: a1400009 (NzCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
>>>      pc : cpufreq_online+0x8ac/0xa90
>>>      lr : cpuhp_cpufreq_online+0x18/0x30
>>>      sp : ffff80008739bce0
>>>      x29: ffff80008739bce0 x28: 0000000000000000 x27: ffff28400ca32200
>>>      x26: 0000000000000000 x25: 0000000000000003 x24: ffffd483503ff000
>>>      x23: ffffd483504051a0 x22: ffffd48350024a00 x21: 00000000000000dd
>>>      x20: 000000000000001d x19: ffff28400ca32000 x18: 0000000000000000
>>>      x17: 0000000000000020 x16: ffffd4834e6a3fc8 x15: 0000000000000020
>>>      x14: 0000000000000008 x13: 0000000000000001 x12: 00000000ffffffff
>>>      x11: 0000000000000040 x10: ffffd48350430728 x9 : ffffd4834f087c78
>>>      x8 : 0000000000000001 x7 : ffff2840092bdf00 x6 : ffffd483504264f0
>>>      x5 : ffffd48350405000 x4 : ffff283f7f95cc60 x3 : 0000000000000000
>>>      x2 : ffff53bc2f94b000 x1 : 00000000000000dd x0 : 0000000000000000
>>>      Call trace:
>>>       cpufreq_online+0x8ac/0xa90
>>>       cpuhp_cpufreq_online+0x18/0x30
>>>       cpuhp_invoke_callback+0x128/0x580
>>>       cpuhp_thread_fun+0x110/0x1b0
>>>       smpboot_thread_fn+0x140/0x190
>>>       kthread+0xec/0x100
>>>       ret_from_fork+0x10/0x20
>>>      ---[ end trace 0000000000000000 ]---
>>>
>>> Cc: stable@vger.kernel.org
>>> Fixes: 56eb0c0ed345 ("ACPI: CPPC: Fix remaining
>>> for_each_possible_cpu() to use online CPUs")
>>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>>> ---
>>>    drivers/acpi/cppc_acpi.c | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>>> index f0e513e9ed5d..9ae29f2c6db8 100644
>>> --- a/drivers/acpi/cppc_acpi.c
>>> +++ b/drivers/acpi/cppc_acpi.c
>>> @@ -362,7 +362,7 @@ static int send_pcc_cmd(int pcc_ss_id, u16 cmd)
>>>    end:
>>>        if (cmd == CMD_WRITE) {
>>>            if (unlikely(ret)) {
>>> -            for_each_online_cpu(i) {
>>> +            for_each_possible_cpu(i) {
>>>                    struct cpc_desc *desc = per_cpu(cpc_desc_ptr, i);
>>>                      if (!desc)
>>> @@ -524,7 +524,7 @@ int acpi_get_psd_map(unsigned int cpu, struct
>>> cppc_cpudata *cpu_data)
>>>        else if (pdomain->coord_type == DOMAIN_COORD_TYPE_SW_ANY)
>>>            cpu_data->shared_type = CPUFREQ_SHARED_TYPE_ANY;
>>>    -    for_each_online_cpu(i) {
>>> +    for_each_possible_cpu(i) {
>>>            if (i == cpu)
>>>                continue;
>>>    
>>
>>
> 

