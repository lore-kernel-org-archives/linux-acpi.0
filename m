Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013016.outbound.protection.outlook.com [40.93.196.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9CBB640;
	Thu, 16 Apr 2026 19:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776368222; cv=fail; b=fPQTebypWrG0m66mQ/7NCUJbtLK8/ZdwoK6UdoU6jYhQyJfZdMTthBXizKle4LlP0LtqdnSSjke+afXXcbvwNV9JI5AaynhdJgNjD5LH5ZwJueYNYoL2CiePkd1JDVMuuZAo/4aER/jJJLu4AsSGOAcBmCTfzefIwsWG3DB/390=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776368222; c=relaxed/simple;
	bh=UlX9XFPC+8ntphxizkVHrIRp1Lyg6DOx2IbPUcGAGDg=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lMKr41OKXMxHyNWo5efrcWFdz7ndZ6mz7A1Sse5a+Bbu/SJIn+HjUw3xJBiRfPnwYam4fjuJJ9mkCjmb40sqDL34a/ARziKhT72tGWenH2jXQ9MEN9o8tEpQbpcT9oQRoN57mJbkm5DL3JUU4VFYSro9Xr7NRJOJRAMVKbY5dmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Aj9oho0v; arc=fail smtp.client-ip=40.93.196.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Aj9oho0v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZPBVPMhjWC6YRnjCUC1GpTpoyInBdcCil8VsvsoN4PLiewjYqEgw2k/1UoBbZvG8EmXjBPc2co6zy7VWgcRXzNOnXUQrBuXxDf+LgH9o7TgoXXGzlvONw5jDdFpsJ+dBAHLTBCkHQmZpCKwTVTi6Sxfu/fx2WsdQf+WWikNofZexy2fSjFtmTB1fv0hnx8SwJ0WR2XBkDFegTLfHuMY/WfR8uU35UrG34BeHQwgikbUWftH749qo2eIezDKeT28bj8VtmSzKqkd1qOpkwcBgt9mmAz4bqno9ux2IDEfM6vuvf5pNXlSICJIwFX5Sjg01KnxYw4OgmgU/t3kJgjMhIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R3liAdXdy4hEySCtYVsIqgsTr0xh+S7h2KrasO7gcM0=;
 b=Y56TTpPCQ43jnmjeE6PZilgeyWtKYRbgupfgToPu+/baW0nDvl9CzEdCyUOtMjph63mJoP1aofSIOCBk5a6asN31o9lZJ8TrQ7TNdcnMbFHZ+W6L8OjidsVmifDhByxo1oWhpopxR5hkbFnKh2AV4mJ7qGq8eLVHQIP0VvcDdGv1ex8iJW6uj7vp4R64nFnKzQ5WGJjQ3TX3ZObM401i9sJDdcXFHOpivRDhiL9wc+nHM44SFuXi309Fso14mzUWPS45TKP5YeowQ0WNtT/CcU36kgDIlSPleCI0HKSgQH4n2n4ArriUQ6Dt48W/dl+oKUVEEvxAv1eO2BSR13aHmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R3liAdXdy4hEySCtYVsIqgsTr0xh+S7h2KrasO7gcM0=;
 b=Aj9oho0vt1USn5G8RZ7o/RplDuvYDWUcJpfjFE8SWo2dVUzEujETSCpcCKuE/0GKJgHiKR3gAGfLOLU2K5r38xe2+C+IVTg7bJyPFezHEIuF0isvSpSgppRE0KcHB3kxJi8fZm1LFYIeP0rJvNZH6Who60TjogsvG9xojvGdn4i+hBUutPE6h9oB/9JoEPk59EZWNYT8+oahs9lQwCqT558jh+u0ZJdZqzdBNFdI746/fS52Nm+eBt1x7pvkE1CG4M2Bk7xo1qZpdmECfGZ1hZoR0FZSgUy/X3BC3tw5yravY/JSV82WsWiQK+CiwjOxR1+OCI2v8Cp6bORCg9iYRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY1PR12MB9674.namprd12.prod.outlook.com (2603:10b6:930:106::9)
 by CYXPR12MB9388.namprd12.prod.outlook.com (2603:10b6:930:e8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Thu, 16 Apr
 2026 19:36:57 +0000
Received: from CY1PR12MB9674.namprd12.prod.outlook.com
 ([fe80::4dd6:b793:a9af:5790]) by CY1PR12MB9674.namprd12.prod.outlook.com
 ([fe80::4dd6:b793:a9af:5790%4]) with mapi id 15.20.9818.023; Thu, 16 Apr 2026
 19:36:57 +0000
Message-ID: <c2669823-a057-466b-9e86-114386764f8c@nvidia.com>
Date: Thu, 16 Apr 2026 12:36:55 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "ACPI: CPPC: Fix remaining for_each_possible_cpu()
 to use online CPUs"
To: Jinjie Ruan <ruanjinjie@huawei.com>, "rafael@kernel.org"
 <rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260416085221.3476726-1-ruanjinjie@huawei.com>
Content-Language: en-US
From: Sean Kelley <skelley@nvidia.com>
In-Reply-To: <20260416085221.3476726-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2PR07CA0019.namprd07.prod.outlook.com
 (2603:10b6:a03:505::21) To CY1PR12MB9674.namprd12.prod.outlook.com
 (2603:10b6:930:106::9)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9674:EE_|CYXPR12MB9388:EE_
X-MS-Office365-Filtering-Correlation-Id: 547c0517-ed24-4bea-5380-08de9bef8555
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	R5KvXu8Awp7X5sgROzhZqGjaZI2YCV+1cYoiUUJ1ONzuwc+QerYFLrxti8ua2wHiadYd8qo9GYE/ndMUCMDsrHy+HdIUgvVOYyom/OmL3KMsEbKwhAwjVwp2UYELz4Ycc8iPuyTj9XlUymJLRmtA73IPejJ7kNY6AvGaFFi6JPQLb3cmvofnMeWnsEhmeAxnmzJftRgGYgJpualNT0Vp5dz1jIfOSU3vDbygHp92OssvDLb/Z48qDQuBMkIMK8icGBj64dA14RJi86L1Pni4XbP3uJKrXY2sQat0fhANhtp0aWHO3ZqdK4zvHlN6QqfEoEk/W/GIbSToThEVRepE9SPGPpQd1EhmEgrNl+b6mFIVxL3KwEKTmPDyq3RJWqmr0NoveuLETkbmT53OYtcaTZwHFVedfOg2Ax583zEF7kjN7ukHouOjbPZJyDdH4pBT/9a++YDPK98n+W6wC+s+uJd87yfORmWnS0cmZUezdhFOFf75T7druGMckJv9qmV+ZsqCKmBF/NLuOTA+riOTE+IVUbhzcZDHNLUSIe7lzCzg+jN5JTam+I8+7m6p+qzQj2/Ehb2y/hjsCk1t4VaBXCpqsfXsoxjLuHhOSkdq+RrNy5r2VsIY6ejX7tRUOIb0rgUQUChr1+k+H67tFZrGcTtWUo3gRrLYQPGxaC+ycH/67X4QilexAW5ouLPVawn5vWWTfOAIyV/MIlFY3489wdpnSCVY0XxKtHvMZ5ykM7o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9674.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RGV4ak1udE4ycUZvNERGNFgrT2xBYmJLQlU4Y0pMdktlT05pbjFoSk5HTFgz?=
 =?utf-8?B?Zk9oeWJzZWxRcE1TcWZnSDVRZnY5czdES2cydSt4Vkc1dUtDY3VtaG5Yc1JV?=
 =?utf-8?B?WVd5RVNtL0ZRWkhudjE1OUI0c1YvYm1tTmZQbWJUOUdUYnpDdHNSNllEZ2Z0?=
 =?utf-8?B?Sm5CenVpZmVpN1pWUjZSaGloK2J3OGVrUHVWZXo0T0NuSVh5clhLOS9PSy9w?=
 =?utf-8?B?Z3NIZ2xvWFdlNnlPM1FOdnlRZVJGdlZQbzVFckJiMmt6aGM5SVZsd1Vpc2Vs?=
 =?utf-8?B?MXE0OHJtVGpzS0NJQWxhUy9JL3BJeTJocjN1NDZuQStKZTJCUEs4NmZFaE1D?=
 =?utf-8?B?S05tY1Ftc3orMjl4WkFXNFFVdWphMlZFcFZ3VFZCVm1URWF6cGVDcWxJZm8r?=
 =?utf-8?B?ZWtLQnZ6TVRmcDFjRFY5VjZZSUJvSXBUdm1abDRybXdPd2tWbUZWbmtVdVhp?=
 =?utf-8?B?TkRxaVQ0c3FyMDBoY1M4ZmpBeVh6ZFU2SGZML2dQbTFKYVMvNUIrK3JWYjhQ?=
 =?utf-8?B?dWNjV2lOc2Fwbjh0ZUUyZzFGeU8rSW5pbkRvdEx6cGh3ZlRtaTFxRm5iZVFi?=
 =?utf-8?B?SnRkUHN2U0poRkdQdit2d3Q2WjE5RmorZTlYWEp6MjNUb083WEFySlpSeXBO?=
 =?utf-8?B?TTFVUGRJNTB3cUxvYkRnaWVpV1gvQ0M3cFZpbThUTWVMZGsyem5jMGdvQzNk?=
 =?utf-8?B?WVpUR0NlV21MRndGV3M0d1ZBa001SlE0S1IrUjZpejQ1VFo0RlVoMWVEN1ho?=
 =?utf-8?B?aTJ3Qk1rK2Ntb3hxekY0NTBzU0xJWUFPcXNGT294dnpERlV4YXlkRVB3dXR4?=
 =?utf-8?B?RzAyeWgwL1l6UTU3anBDVWVmaTBDT1V0S3NkVEJORVRuS1VVenc5Si9rZVFx?=
 =?utf-8?B?dnE3UHhrbUhRYzc4cVVhZ3pJUHB3TzlWaERESVBjR1BrMlFNRFlkNzRGUzMr?=
 =?utf-8?B?RWpoRWFDUzFPNGQyVjNkc2FRSitGV2Q5aXZMVVhiUHJ2ekZ6OWZJTVRNaFh2?=
 =?utf-8?B?bkpDUWNBbG5zNVg1S0tJUXF6WEpLeE5xZUNZZUJkRDAyUVhJSml3SEFiOEFQ?=
 =?utf-8?B?akc4UzE1K3kzVTcwRS9OdEt0WTJBc05RNHE1aDVOeGI1RVRFY1FYa3hHVURX?=
 =?utf-8?B?MkNKa1ZXYVFLUlFwSmtjclRVdzF5SkhXYksvR1M4MWJ3cm8wU3pBYkVXdi85?=
 =?utf-8?B?Qzc1dVNJNGduSFRKSmJiWjRlUi9yLytIUER1WThNNGxCRTBiVHVqWmxkNlZl?=
 =?utf-8?B?Yi9Rdll2K3RhWVJpSjU0TXowUk1iQmkxUmhsYWJJSjlWaHRGZW9IQkFaTWQz?=
 =?utf-8?B?cXUxZWNyRkxXL1JaUTRUU0JPazFaMXJ2ZlNTOUo3OHh2L3l0RjRYMGVydGZN?=
 =?utf-8?B?dEczYWVvL2lORFhvSFRrMWxxd1crL3RzeitLVVZhbEFyelNIZjlwTVlDa3Jq?=
 =?utf-8?B?R2ZsS01lWkg4M1FidGplbXdtdFhCYzhvU0R4a0ZSUWpseVdudXpsK2l6VUlF?=
 =?utf-8?B?eFhFTnJzMExZWlNuaUtvM1RBWnNOZHZzdUhyOEJYRlFlN3J3SThlT3RxYkFK?=
 =?utf-8?B?Q0hzVFZQaTUreEpzNU93UTJ6eHRZYkNjbDZVeTdHZ2JocGRoajJETkdqekg4?=
 =?utf-8?B?elo3YlNkM2pJQ096N1hmNkI4R0FoNkpmV1ZIQXVNRHdtNzNxdTQzNzFoUVdM?=
 =?utf-8?B?blhjMk9sbGR1L0JFZFN2NmVSd2VCUXAxdjV5Szl2a0J3a0pGcHMzTlE0eXF0?=
 =?utf-8?B?eklrQXVCRHR4N0l3TEVzcG1MWER5RGdhcHZzcTlsRlhwTGhpSWp1QTZzc1V3?=
 =?utf-8?B?bEIyVHVybzB3OVZKRnBscUdtd2dEeFRBUzBCL3crZVdSVFIxcUdvSFhOSDRM?=
 =?utf-8?B?aHA3VE5qOXcvS2dQZXdXT1FNLzdRRFZ6UlhHT2kzOEphRTd5MW41MUZVc1pX?=
 =?utf-8?B?RVVIQkdrUDZ1QmJqajc4SllSaVNEZkx2cnNHVEV6NVdhQjNzQWJwK0RVdzBi?=
 =?utf-8?B?Wjh0ampNVXFGTmp2Qm9ySWx6cVRod2J3aUZKRXd0d2JsSnlUOVkvUXFpK2pv?=
 =?utf-8?B?a1dUVit1MFFZMENwRW85aFBFSW1ROGtlcll3S0ZBZHZIRFZUcnZWVGhMdDFs?=
 =?utf-8?B?SjV2K2hmdy9sUGJqZUM3U2NGK0R3TTJpRWs2RWtQYXVXWkREeUI2T0Z0dzRM?=
 =?utf-8?B?ZU1xTWdaSS9QRHQzdlVwNUt4S3NNYmIyMnZySG1XbjNLT1gxZ2xkR0J2UlVQ?=
 =?utf-8?B?OGhEek5Zd2VnSm9aaVFKY2wvNnIyRGtINXpueCsrMGcyZHFIQnc1L1pkSkND?=
 =?utf-8?B?Mk1QdmNBUW5uYlFKczBLVnhIOFVoOUxRTFZEclhvU01RazZxVTRmdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 547c0517-ed24-4bea-5380-08de9bef8555
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9674.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 19:36:57.1149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +u2f8I+95VvZH/i4pqDtKJU122EUcuahMXBvJNI060vh44QYIHLD+C96KQqyx9cVrabssqnv7abij2vSr/DJdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9388

On 4/16/26 1:52 AM, Jinjie Ruan wrote:
> This reverts commit 56eb0c0ed345da7815274aa821a8546a073d7e97, because
> this commit cause warning call trace below when concurrently bringing up
> and down two SMT threads of a physical core.
> 
> The issue timeline is as follows:
> 
> 1. when the system starts,
> 	cpufreq: cpu: 220, policy->related_cpus: 220-221, policy->cpus: 220-221
> 
> 2. Offline cpu 220 and cpu 221.
> 
> 3. Online cpu 220
> - cpu 221 is now offline, as acpi_get_psd_map() use for_each_online_cpu(),
>     so the cpu_data->shared_cpu_map, policy->cpus, and related_cpus has only
>     cpu 220.
> 	cpufreq: cpu: 220, related_cpus: 220, cpus: 220
> 
> 4. offline cpu 220
> 
> 5. online cpu 221, the below call trace occurs:
> - Because cpu 220 and cpu 221 share one policy, and policy->related_cpus
>    = 220 after step 3, so cpu 221 is not in policy->related_cpus
>    but per_cpu(cpufreq_cpu_data, cpu221) is not NULL.
> 
> The _PSD (P-State Dependency) defines the hardware-level dependency of
> frequency control across CPU cores. Since this relationship is a physical
> attribute of the hardware topology, it remains constant regardless of the
> online or offline status of the CPUs.
> 
> Using for_each_online_cpu() in acpi_get_psd_map() is problematic. If a
> CPU is offline, it will be excluded from the shared_cpu_map.
> Consequently, if that CPU is brought online later, the kernel will fail to
> recognize it as part of any shared frequency domain.
> 
> Switch back to for_each_possible_cpu() to ensure that all cores defined
> in the ACPI tables are correctly mapped into their respective performance
> domains from the start. This aligns with the logic of policy->related_cpus,
> which must encompass all potentially available cores in the domain to
> prevent logic gaps during CPU hotplug operations.


Yep, agree that using for_each_online_cpu() in acpi_get_psd_map()
drops valid domain members and breaks the hotplug case you described.

But a plain revert also re-exposes the nosmt bug. On systems where a
possible CPU is never probed, per_cpu(cpc_desc_ptr, i) is NULL and
acpi_get_psd_map() currently hits goto err_fault instead of just
skipping that CPU.

So I think the fix is to restore for_each_possible_cpu() for the PSD
map, but change the NULL case to continue:

--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -530,7 +530,7 @@

                 match_cpc_ptr = per_cpu(cpc_desc_ptr, i);
                 if (!match_cpc_ptr)
-                       goto err_fault;
+                       continue;

                 match_pdomain = &(match_cpc_ptr->domain_info);

That way offline CPUs with valid descriptors remain in shared_cpu_map
(fixing the hotplug trace), while never-probed CPUs are skipped
instead of failing map construction.

The send_pcc_cmd() hunk already does if (!desc) continue, so reverting
that loop back to for_each_possible_cpu() looks fine as-is.

Happy to send the continue fix as a patch on top, or please feel free
to fold it into yours if that makes sense.

Sean

> 
> How to reproduce, on arm64 machine with SMT support which use acpi cppc
> cpufreq driver:
> 
> 	bash test.sh 220 & bash test.sh 221 &
> 
> 	The test.sh is as below:
> 		while true
> 			do
> 			echo 0 > /sys/devices/system/cpu/cpu${1}/online
> 			sleep 0.5
> 			cat /sys/devices/system/cpu/cpu${1}/cpufreq/related_cpus
> 			echo 1 >  /sys/devices/system/cpu/cpu${1}/online
> 			cat /sys/devices/system/cpu/cpu${1}/cpufreq/related_cpus
> 		done
> 
> 	CPU: 221 PID: 1119 Comm: cpuhp/221 Kdump: loaded Not tainted 6.6.0debug+ #5
> 	Hardware name: To be filled by O.E.M. S920X20/BC83AMDA01-7270Z, BIOS 20.39 09/04/2024
> 	pstate: a1400009 (NzCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
> 	pc : cpufreq_online+0x8ac/0xa90
> 	lr : cpuhp_cpufreq_online+0x18/0x30
> 	sp : ffff80008739bce0
> 	x29: ffff80008739bce0 x28: 0000000000000000 x27: ffff28400ca32200
> 	x26: 0000000000000000 x25: 0000000000000003 x24: ffffd483503ff000
> 	x23: ffffd483504051a0 x22: ffffd48350024a00 x21: 00000000000000dd
> 	x20: 000000000000001d x19: ffff28400ca32000 x18: 0000000000000000
> 	x17: 0000000000000020 x16: ffffd4834e6a3fc8 x15: 0000000000000020
> 	x14: 0000000000000008 x13: 0000000000000001 x12: 00000000ffffffff
> 	x11: 0000000000000040 x10: ffffd48350430728 x9 : ffffd4834f087c78
> 	x8 : 0000000000000001 x7 : ffff2840092bdf00 x6 : ffffd483504264f0
> 	x5 : ffffd48350405000 x4 : ffff283f7f95cc60 x3 : 0000000000000000
> 	x2 : ffff53bc2f94b000 x1 : 00000000000000dd x0 : 0000000000000000
> 	Call trace:
> 	 cpufreq_online+0x8ac/0xa90
> 	 cpuhp_cpufreq_online+0x18/0x30
> 	 cpuhp_invoke_callback+0x128/0x580
> 	 cpuhp_thread_fun+0x110/0x1b0
> 	 smpboot_thread_fn+0x140/0x190
> 	 kthread+0xec/0x100
> 	 ret_from_fork+0x10/0x20
> 	---[ end trace 0000000000000000 ]---
> 
> Cc: stable@vger.kernel.org
> Fixes: 56eb0c0ed345 ("ACPI: CPPC: Fix remaining for_each_possible_cpu() to use online CPUs")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>   drivers/acpi/cppc_acpi.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index f0e513e9ed5d..9ae29f2c6db8 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -362,7 +362,7 @@ static int send_pcc_cmd(int pcc_ss_id, u16 cmd)
>   end:
>   	if (cmd == CMD_WRITE) {
>   		if (unlikely(ret)) {
> -			for_each_online_cpu(i) {
> +			for_each_possible_cpu(i) {
>   				struct cpc_desc *desc = per_cpu(cpc_desc_ptr, i);
>   
>   				if (!desc)
> @@ -524,7 +524,7 @@ int acpi_get_psd_map(unsigned int cpu, struct cppc_cpudata *cpu_data)
>   	else if (pdomain->coord_type == DOMAIN_COORD_TYPE_SW_ANY)
>   		cpu_data->shared_type = CPUFREQ_SHARED_TYPE_ANY;
>   
> -	for_each_online_cpu(i) {
> +	for_each_possible_cpu(i) {
>   		if (i == cpu)
>   			continue;
>   

