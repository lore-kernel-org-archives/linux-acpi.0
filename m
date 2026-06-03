Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010071.outbound.protection.outlook.com [40.93.198.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861903A960A;
	Wed,  3 Jun 2026 14:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780496808; cv=fail; b=GacvBwDkcmwoFmyGnlriU26ELyEeC0O/7tvlPg3gctF3NGUOam3eRsjaTfZGW2hMFQXnghgsShQyNVl4RfOr8vUNx8bep4sAGUtkcU9OdVZG4/s2BOnU7EoC8VrTk3X4cpFZ7ZL0pNl2S5O8xQjftMDzZRYzMWN0v46Gqgh4/Zs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780496808; c=relaxed/simple;
	bh=WkLbhO6kGawW2txwIzp/prQ4F/J235JPoxhb0C+ItOY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EqzrXQ+UgEkzQD1vRgSo2VA89xWg25t4XjMRd2spkAjsYGpHCMxbAFI4Wb39DyCGqZ6kF1u9vLL2fJEIXm5C52ykQ5lB3PtU9x8zCrfjZaAfGoOblqlSw3tQxmgb678TBAlXFYM7/uNKhIqOndarA8YhkB82n8+/0x62hz1rjEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QbgMTRTJ; arc=fail smtp.client-ip=40.93.198.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QbgMTRTJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WwYcv2adwBL91ZVfO5+62+UN13Vg2R3wS2b3kYZhzvvWaMDfDq4nqYk6uBPKFp4JESu+w2fyMsA0+fWuqXefSfuQrVEHnDGR5WJVikzKpR7UfvgjInKhKwiEZ05KWY1ss9FhCVc+SDN20f9Vxzit14zkv/q8bYjUFH05tU0Yzcy9V0ntq72xwkJuvBkJBa/y1KtRyXOMd+Wnp2dH4rkjreGTdEv2Jnf+APFRHOweCrouVmbkDqfIJw6/qsqWqr+5I15a0S3H+gRD4qjfx6AA2OjX+KoYUOdBeiR6OtdL+Z+jcxJr0MEhuPNZyOdB05m6EwHXvMpuwA3Fxo0PqILolg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KwZLTECyJkPjYjTPsEbI8NJDt7c4Kw9Xg9isR1wC0kw=;
 b=RXsscchqWekc9Mej06toCbbCQBKLW5NZOkkNcMVIFVAPXGafRbOtHx587r5bYQeStvvmZIRdadfc1Ry1cRajAcQKx80RR8gH5+etiD+NuyrApR7jUVpeO6N6Z1Cfrzfn7GI+P2tzToD50B1gkz05U5v3uEuYwO+87klA6CxBky0bPKT5UBHBonZ7n0NxH706HGG76ZIklqM9lU6wXVieEzXp1MXlKkH/y0iqadR2aYGUUQAdCyFp4noyrjYvDlh+/5LtztBtWYecrm5OuLsFjaRJ8wOawulYFdcZmjMnUF+jiL6TyvBhdNMXOlIQK4vrGc07FDAGywienO6O3Ud0Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KwZLTECyJkPjYjTPsEbI8NJDt7c4Kw9Xg9isR1wC0kw=;
 b=QbgMTRTJC3qKBJ3gquNBLZjw4W91QBI1jDY4vst2UnfR/vWcaF1EFlNKJ0NeUFdU8UtW1s1Rlh7mCDQ5L/FNHdkh4WGQLWmmyh6VDaUL1MiK4nMjhD0scyN93w7bDspy8dWHdsvQV8Kfn1tTsj7puqPL/U/Fhk0Wig5SfTMcr4Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by SA3PR12MB7832.namprd12.prod.outlook.com (2603:10b6:806:31f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 3 Jun 2026
 14:26:43 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 14:26:42 +0000
Message-ID: <d45e3051-ced5-45d8-b3ff-c50f4e41cd1f@amd.com>
Date: Wed, 3 Jun 2026 09:26:38 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/3] x86/cpu/amd: Fetch S5_RESET_STATUS from PHAT when
 supported
Content-Language: en-US
To: K Prateek Nayak <kprateek.nayak@amd.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Yazen Ghannam <yazen.ghannam@amd.com>,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 acpica-devel@lists.linux.dev, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org
Cc: Vilas Sridharan <Vilas.Sridharan@amd.com>, "H. Peter Anvin"
 <hpa@zytor.com>, Andrew Cooper <andrew.cooper3@citrix.com>,
 Mikhail Paulyshka <me@mixaill.net>, Kai Huang <kai.huang@intel.com>,
 Rong Zhang <i@rong.moe>
References: <20260603063317.13665-1-kprateek.nayak@amd.com>
 <20260603063317.13665-4-kprateek.nayak@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260603063317.13665-4-kprateek.nayak@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR19CA0025.namprd19.prod.outlook.com
 (2603:10b6:610:4d::35) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|SA3PR12MB7832:EE_
X-MS-Office365-Filtering-Correlation-Id: 1156f7e0-c511-459a-9ef6-08dec17c220b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|56012099006|921020|4143699003|18002099003|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info:
	6Dk1+0C2igFCYCVn4fQNBFvYhNrhZsTrk3f162dh22a2XTpMvO+pSaXvachpldXeIrNj6R9g0ktBLl2wL2rxqw1yII7+KmIyeV0Dtef6EACcUO8mu4NUZw6wdITanGBrkcw/tgWLvRwAKzBYEnQKXntVGqT9s7uNW6an6uc2tAH+6DAP3fNBwR31es2VOQPbaC3PqJGOJoXqWfEqpyTyB1TDKHWeVHZm/HaItOV8eEtINJkNvVVRlLrOAnCoHFoYOqcVU3PcAkkl1C6r7yOw7P5+i60JfMjRuDJAEu6VY9orJBlC5P0skJxGUEuBeBYZygsFa2vHGnrVm+czdpigiZ62ey/oaVnNJnTk7jK4xDtTFFApMDXrFAqr7L6CrBKRUtMUU6KbewXLioc5LMNuAQZVuWlcBwqOxI/+I9hKKouzo3JXg97VAn27l1KDCLTo8ccUHuq90DVUwrCijeF2abEKezM95bEbzTUBpMGFsb9F8jkVMGskJ/y8pE1WJtvoOixc9Q5ao2KF1GvU+WEz97N98Dxz6iWy2i9aioxFv/IA0k+frHvLpB7LRBUFYqvRjSTfqJMyulC/EZt9MGXtbURBHOJWLjhJyfw/bLluiXgM/ydH/Wvfa9lo9ue+BKwYznEKRyXHijkGv1NpHKb1SOVW7qx19WV1DHqwIBMljiEzh6462sZoli7AeOhb4z3y0QyfIRfuyjcpoSAzJgv7pWlG43tZZLipMrAxK+InZVo4wYmrTvExijBL1hKZaqSp
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(56012099006)(921020)(4143699003)(18002099003)(11063799006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?emE4V0ExT0JNUHBoR2pETW9LUm5SK2pNMHJNNGxpY0l5dGZlb1o0dXV2cFU1?=
 =?utf-8?B?cUxxZnVSaSsxZi9QNUljNUgva3pCeWhCMHZ4NzdoaXFTRWZ1Um4yZ2pnYjU5?=
 =?utf-8?B?M3JKK1l3bTJpTVlvYlRIRWdVNWlzb3FETkdlNndKTmNrcHFVUVoxZkJUblN3?=
 =?utf-8?B?R0hZU0ZjeEczNnBxSDNPV0ZtdkFsZG1aQ3ZlZWFyQmhUaTNkYzYxcTY1OHA3?=
 =?utf-8?B?K05qT1BPd2ppQUd2RWV4UFhob0N6RDBwL3hJZnl1RDBLYndDWnExeFVtc0E4?=
 =?utf-8?B?WHF0K1dYa3dvWHFVT2RJSXowT1ZPRGxzQjBnQ1BteFRySXdjV25qUDZRdTZX?=
 =?utf-8?B?c2pQWFRFbnZnSW1XODhYTU1Cb3pJN2ppWDdoTzhUdjdMM1lhNWpGQkNMeE5o?=
 =?utf-8?B?RmdxVi9HUnlTZGY3SGtYaVhNajU1U2FwOVE4QzV5eW5LNkM3RUYrL1pqRW12?=
 =?utf-8?B?TnhLQzY1a3htTDZaN0h5QjFxZjBRSnhOZGt0a3RMeS92UDZnQ3VHbEwzUDM1?=
 =?utf-8?B?ZlBVeUNJZU9yK3NvTy9acWJtVk13OUJVbk9QMVhvckNldmhGWDJGVzdjRm1S?=
 =?utf-8?B?NzlMVWNpc0YwTTdhTTFOOEt2cC93YUEzS3BYSXpNd0tHQmtGeFVmOHk3NXRI?=
 =?utf-8?B?NWlyOGxOWVVRcDZxL215NlduUnhpazhxMlVkWXNwRzZpdTJlU0VWNEdxOGdi?=
 =?utf-8?B?SkMrT216ei9QZ1JVbDl4Rm1FOE03dytCZnVLSEtMNFNpZkpUaTE5RXZjS3V1?=
 =?utf-8?B?ZnVyeHZPMWl4U3BxcUVTTXUxRUlXeFFqTkNCVVdDcDlDdG5XVTBYNmRqbFB1?=
 =?utf-8?B?cC8xV0p6REtSbGg3NmVRUVBQUmtOWEJkbGg3R0xHMTNXYzFuSjFSczYxSFRJ?=
 =?utf-8?B?dVg2SWd5eThReUg5ZEJhOHJaUFpDQ3U1UEs1S1JOK2hHcGIxTVREY1dMV1FI?=
 =?utf-8?B?cG41bkJSOEhlZzFqd3V3bkU0MjN6NHc2L2tJRnNaL3QwcVV0SGN0U1JkZGg2?=
 =?utf-8?B?cHR5T1dGZWpJSW94emVXZTRySVZ1RUZoanVXTmlTVE13SDJKWHFjTXVpMUVJ?=
 =?utf-8?B?RDJadFlPTTdCcGFyOXZwSkV5UTM1bzhpWVBQVmczS3I0VXFaMjVPVzNkTWdz?=
 =?utf-8?B?dlBNc0tpbVVRMVdOZStKNWlqd2dLNjR1akZOTHpSN1I2SC90cDJadDM2UUcz?=
 =?utf-8?B?d2t3cm42bjF0QzIyRFdmNmJpV01jaStybWZvTE1tNkY4YzJjUjhtT3BsL3hy?=
 =?utf-8?B?SFJreFZpK0JoR2xlN0xVVVRObndxSVlReG9BSzJRcld3V1p0Sm1Mc0xHSGdk?=
 =?utf-8?B?QmpGd3orRSs2U2FDb3ZEcUI1cHhMWUdnaWppZVhVWWJ2MDNBeEU2RG9sYS9a?=
 =?utf-8?B?NHFraXBxRW1kQjBBQk4wUVJDaUVRKy9MYllRY3ZzRHhoaEs5M08wZ0h0eWUz?=
 =?utf-8?B?dXFXVTdFMmVDWmVkeHZCOWVoTGdlOEZDVXRJYTRQUkQyd0xkRGVNVDhhc1Iw?=
 =?utf-8?B?d25WWkx2RlJNWGFLSHRULzVKbncxTnhPVW5WcTFnT1hsVWJxcUM4Z1d0eUdx?=
 =?utf-8?B?ZEJCSlBrWjZNbEZwU0FYMXRHZW9vMDRDY0NqQUErRmpRZ3YwdWJ4azZKQ1M3?=
 =?utf-8?B?bkNiMGVnQUhXdUxOWW9KaFhodml6QWNGU1VXNTZ2UittbURUN1dQaHFHMkJZ?=
 =?utf-8?B?Sm4xWTFjdXRmQjQxWXdnWHNZU1Qvd0JsL0ZiTDZ4QlZaUUZWR2lEU0VRcndR?=
 =?utf-8?B?OUVQTCthVGtzYTJ1M3M3U1QyTTRMYkRZQzlDVE5qWTF3ZEY1K2Y2WURWY3k2?=
 =?utf-8?B?UUx5S1FFM2xYaVh4T3pRS291Nmo4UW9wQnpTZC96dXhuQkhwWWVnT2RRZk11?=
 =?utf-8?B?YVNqQWFqSlV1d1JtbEZVSitVcGw0dE5BUzlTbEIva0I5L1N3THp2cVpNLzZ5?=
 =?utf-8?B?VTJzU1o5N09PQXNpa3JiTEpCMWFQdHhxeHZKU0ZYNnd6YU5lR1dNekNFd2dH?=
 =?utf-8?B?Nk1EL3I0dTU0b1gxT1VLK1RsU1IyV3VZZldyb2VYOUlYNDExVzVGRHJnNkd5?=
 =?utf-8?B?c1RNcXpNdHFrRUlpbjJVeVZ5NERqMFV2cFJmK00zeHNMVk5od0d6c1Y2Zk9w?=
 =?utf-8?B?RDM2QmIwYVNUd1FsNzNRTDE5MWNKMnltMjF0NDh6ZUZBbi9oWnBLaWFsdHF3?=
 =?utf-8?B?RXI2OXVzWS90eC9OSzAxMjlxY1JNWm5xblhrNzBMS3pzNU9pM0dtZzFmM2w1?=
 =?utf-8?B?b245djJxSUltd3pJQ3l2eUo3dDdPS1I3MWxobWZWejlrMTB4ZGJwMlVCK0xY?=
 =?utf-8?Q?R2e+RARR7pDeP7wuFF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1156f7e0-c511-459a-9ef6-08dec17c220b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 14:26:42.7263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /DCpm+ISpahBfAQQAFE+rWnECd1BG5JGnhactswePsj+4TXyfxYsR6vRJT5ssnc9RT11Kkx1J/BarlgZOpoxqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7832



On 6/3/26 01:33, K Prateek Nayak wrote:
> Firmware can consume the S5_RESET_STATUS from the FCH register and the
> OS may see an incorrect value at the time of boot on certain platforms.
> 
> Vilas, Yazen noted that S5_RESET_STATUS is also populated in ACPI PHAT
> on newer AMD platforms which is more reliable than the status from the
> FCH register.
> 
> Use the S5_RESET_STATUS from the ACPI PHAT which is described in the
> "Platform Health Assessment Table (PHAT)" section of "AMD Family 1Ah
> Models 00h–0Fh and Models 10h–1Fh ACPI v6.5 Porting Guide" [1] on
> supported platform and fallback to the legacy FCH path if the PHAT
> record is not found.
> 
> Unlike the FCH register, PHAT only provides a read-only value which
> cannot be cleared once consumed and will persist across kexec boots.
> 
> Link: https://docs.amd.com/v/u/en-US/58088_0.90_PUB [1]
> Suggested-by: Vilas Sridharan <Vilas.Sridharan@amd.com>
> Suggested-by: Yazen Ghannam <yazen.ghannam@amd.com>
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> ---
>   arch/x86/kernel/cpu/amd.c | 34 ++++++++++++++++++++++++++++++++++
>   1 file changed, 34 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
> index 2f8e8ff2d000..d3dee7fd4c51 100644
> --- a/arch/x86/kernel/cpu/amd.c
> +++ b/arch/x86/kernel/cpu/amd.c
> @@ -1,5 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0-only
>   #include <linux/export.h>
> +#include <linux/acpi.h>
>   #include <linux/bitops.h>
>   #include <linux/dmi.h>
>   #include <linux/elf.h>
> @@ -11,6 +12,8 @@
>   #include <linux/random.h>
>   #include <linux/topology.h>
>   #include <linux/platform_data/x86/amd-fch.h>
> +
> +#include <acpi/actbl2.h>
>   #include <asm/processor.h>
>   #include <asm/apic.h>
>   #include <asm/cacheinfo.h>
> @@ -1342,8 +1345,21 @@ static const char * const s5_reset_reason_txt[] = {
>   	[31] = "a software sync flood event occurred",
>   };
>   
> +/*
> + * "AMD Family 1Ah Models 00h–0Fh and Models 10h–1Fh ACPI v6.5 Porting Guide"
> + * specifies the vendor-specific GUID of FCH::PM::S5_RESET_STATUS record as
> + * "1f425831-da46-4f65-9296-3c4d44c387ab" alongside the format of reset reason.
> + */
> +#define S5_RESET_STATUS_GUID GUID_INIT(0x1f425831, 0xda46, 0x4f65, 0x92, 0x96,\
> +				       0x3c, 0x4d, 0x44, 0xc3, 0x87, 0xab)
> +
>   static __init int print_s5_reset_status_mmio(void)
>   {
> +	struct reset_status_record {
> +		struct acpi_phat_vendor_element		header;
> +		u32					s5_reset_status;
> +	} __packed *record;
> +	guid_t guid = S5_RESET_STATUS_GUID;
>   	void __iomem *addr;
>   	u32 value;
>   	int i;
> @@ -1351,6 +1367,23 @@ static __init int print_s5_reset_status_mmio(void)
>   	if (!cpu_feature_enabled(X86_FEATURE_ZEN))
>   		return 0;
>   
> +	record = (void *)acpi_phat_get_vendor_reset_reason(&guid);
> +	if (!IS_ERR(record)) {
> +		bool record_valid = false;
> +
> +		/* Sanity check before using the parsed record. */
> +		if (record->header.length == sizeof(*record)) {

Why not do this sanity check in acpi_phat_get_vendor_reset_reason() 
directly?  Then we can always assume if something is returned it's valid 
and it's simpler here (and any other potential callers in future).

> +			pr_debug("Using ACPI PHAT record for S5_RESET_STATUS\n");
> +			value = record->s5_reset_status;
> +			record_valid = true;
> +		}
> +
> +		acpi_phat_put_vendor_reset_reason((void *)record);
> +
> +		if (record_valid)
> +			goto parse_status;
> +	}
> +
>   	addr = ioremap(FCH_PM_BASE + FCH_PM_S5_RESET_STATUS, sizeof(value));
>   	if (!addr)
>   		return 0;
> @@ -1374,6 +1407,7 @@ static __init int print_s5_reset_status_mmio(void)
>   	iowrite32(value, addr);
>   	iounmap(addr);
>   
> +parse_status:
>   	for (i = 0; i < ARRAY_SIZE(s5_reset_reason_txt); i++) {
>   		if (!(value & BIT(i)))
>   			continue;

