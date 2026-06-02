Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010065.outbound.protection.outlook.com [52.101.201.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D603F7891;
	Tue,  2 Jun 2026 17:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780420828; cv=fail; b=cahFTQm0er2SDxlXN2Lawl8304zDp8ca7R3HGZfM3juLNWR1bK6N23aULHXHjqdxYwkj34RuAP8asR7BfrBycB7rmXp9t4LP5hHTVAeXHHZZNAiU0Qig0EXQTDUhINLrYUHSaEBamGxrS3QVYl+KdZVGwHGeJ2pf6T634WM9PCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780420828; c=relaxed/simple;
	bh=Rlx1mB3tXXR4J4nt6763kiDeTcYywQFQOuxN3gJhN/I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FV72KKF/ptVkhFSSp8f7xYrPishJ0b12iwivbojC/5IMuEdOpMoSXW3oRJ1r92IcIuKz8fcVvwFvVJPQ2LTe7re9jWWu8nAs9uHjh2ZQo+aMqcXLJWmqDlwsgNZGAeDQsK+lzR10PMh5kNre+UmS6teHEvUOuVVkSpctnMyqp0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aswlxezl; arc=fail smtp.client-ip=52.101.201.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aswlxezl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ugszSJdiw23GSpJL9qm0gspXdUONFg5dIBm8I7fXYSnoYJdT6Sc+7Qaa8ex11HiYldcgjpvZK5LBWeliVlv909EDVPNg7ZKy0qFF/Dhb9gXAlMJk/KdFaXlZR8puy+VGiixlnAKkh8WbOfMGZ875XML4kG5nxFm0KY5s3aN04UPVPggKLvbSr7WOdQV/NbPDm+FyFWQ0vnvVcF7O2Nr9OHzoS4Y64UC6vHST8+XcrVe/qHQnOAeZp5gq2MwoDqZ022LEKAuIc2O2Q2GeQUkQyjfz3Mf/jcNXc2k20xG1tYdzSZjnyy1xDHZ5hTIe3LKFB7+QCSLFdsY7cLg4LXgDvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q1g2Xus6Lt0UTqiIt1LF39YnxaxR0Mnzu9AWivQOKN0=;
 b=wqgKFiKdlyuSpS+Gga69acRuQ06zqGFQJcRxNVKTKI2WQD93vPFBNtjtvPH4cJ11U+2pwta7XAtC8U3/IQ4kpJngO1UARy2p+IKTSXxoKYw7z9cNxda8D0WUEYvGPR0NWXmR8DSAVuUgROElJybX3P7P2TyS2jW8DlugyUdKxFhHudhdsaj4oWSDX7CFsILMfdKgbx//HXW9F2mJ02Wedr5zB86V1QlleTyEDtlDo4n34OziZtsFT3SPRKlM91RxHSbM+ah4OpEZLhNH5q3Rl+hVtEh9/XtHXIu/G//3r8MExmSZANk5mC8gT9KwMndRETMNg3Y+CWRwwXwk57MomA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1g2Xus6Lt0UTqiIt1LF39YnxaxR0Mnzu9AWivQOKN0=;
 b=aswlxezlMxxsyBOxiR6h7halV6RLpv4UJ0kNX7QMhQtH3SPKtvMlXoIeNHn1c/of/TgVPQ5b1oRGUMLBK2TYcFLyzvn9HVmy9a0UIzte2mM8gDhn6UhI+tK44EiznkuhZFx9E4H3fELzwCL5/B+oKfWNKMYp64vnamuljISCjHs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by SA3PR12MB8440.namprd12.prod.outlook.com (2603:10b6:806:2f8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Tue, 2 Jun 2026
 17:20:23 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0092.006; Tue, 2 Jun 2026
 17:20:22 +0000
Message-ID: <175a9520-0262-494b-9020-a7fbf35b7a01@amd.com>
Date: Tue, 2 Jun 2026 12:20:20 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] ACPI: threaded SCI handler causes soft lockup in
 kdump capture kernel
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>, Mohan Yelugoti <ymd@arista.com>
Cc: linux-acpi@vger.kernel.org, rafael.j.wysocki@intel.com,
 mika.westerberg@linux.intel.com, linux-kernel@vger.kernel.org
References: <ah3rlJrHviZHFt0+@vm-ymd.sjc.aristanetworks.com>
 <10861813.nUPlyArG6x@rafael.j.wysocki>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <10861813.nUPlyArG6x@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::13) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|SA3PR12MB8440:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e815535-ed58-4027-324c-08dec0cb3a7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|22082099003|4143699003|11063799006|5023799004|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	0RtUGIqNHGNSZNl4VCVdQ7CfsqUTRCyv1MITRYo2GP3RIL4ORtSWpeLS/vHztJmJfEKzU1Ft1QkjOCR5jtUCMP53c6eKdWKT4zlC2Uou6wK+dqtixLmE6Ra7pwKjUj/BO1icDZ9XioEyE4mk0OKpTrxqsZF1+l72FJwexTpAb7pDsxzy2/lpJwiArXNnRmn+twMXLhYYy2zIMpjfuc7lMDFworC8mldPT89QPtu6CvyghvLX0sQjL9qAEVMR4Zd+PCwFD2jH5AUDrmmMNPM9C6AHT3mJwlXY4qmtwwaCFTZ+nqXgTRI6YGkNhiLxzdzzwzOFk59UsUUEMba3syf0gQ2u6sU+1fPlxSH6WagHv4g5Qp9UJB1xFdpAfpphCA54cxeQxWDMXuUJCYDzryb/WUmSlnZK09jExaUMyT4exsrSE6M3q91Z7QMJ0EK7jGwgd4dA8Pt5PujerpU660bGwborAJPSoltizBusJp/YujGZVSRuYPaS8M647auhPZWGocWYoCuUMNjCkqNgCqm9gG2zzCGNOhTHeXxGbriiquaw5LCS56alZUsjkIauaXf8p9OCyzDBvKD4mXMf8tVmCvzxB2IZs8n5y0de3SOWoJioB08GKxlwpeYBVnRkKrDK6VSSoL2F1+s8VsfHUYYoaqjJgPAx3BIBAycekFsq17JKfpvelN8CaDUBm9CRuOgXRNI5x3fpIfKSiEl3v0zN7w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(4143699003)(11063799006)(5023799004)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ymhjanl5RkhqOTZaVWhlWmpEWVlWR0pwMnVpd2pDODQyM3htRHlTZjVQL2Jp?=
 =?utf-8?B?U2tjUURsLzlCMFprZWhpc0RhTlMvV09WQlhLZktPcHFrbnY2UnJPUXBWaHVN?=
 =?utf-8?B?ZUhIcytCNlpFMXhkOHI4cmU3NFpUTUl3YVh4UjBrM3NZV2FNemNwRmxUZTBp?=
 =?utf-8?B?T0oweGFOY3NXRXJmQU5FdU9yVTZuNVFraDEycUdDS1VRR1lPNjJUbHZOQ1Yy?=
 =?utf-8?B?MkdKVFlPaFVWNnRVWTZ0eVplQVpnSEdLdXlPNmVvVjFSNVNmWGFNT2hDMkc1?=
 =?utf-8?B?dXlxaHVUQ0JhTFJ3NDhkQkExVnduSTZzYUcrcHhRdTFKbks4ZmlLcE5TaU15?=
 =?utf-8?B?SGxVeEEzRUM2TmRGWXFheWt3dk50bWROYjVFUkloRlVRUG9MWC9uejVRMGY1?=
 =?utf-8?B?SFFac1Iva2RtMzJxdVF3Vi9XT1Y0Vk5nUk16TDdtSGphZU9hTGcweXpqekFq?=
 =?utf-8?B?V0htMWRMTzJCbksxVzJQUFZqS2lGdGVEZWc4SDBmMHlTdHN4c3RmQXZ3M0xs?=
 =?utf-8?B?cHJYT1RHczhRSzNBR0hZZnJLVzE2UmN1dysrSmJtTUtBSDdFRWFGbXpPN0la?=
 =?utf-8?B?aE1zYWpUaXc5QVVOUlN4RENLU1NJdGltbnI3YnA2VWVONUg2QVpWNnF1ODM2?=
 =?utf-8?B?K2FZeWJ0VVo1TmZ4Mlo5NW1uNjB1WHBSSnFoOCtvTkMyek9xMDZ4WVhqOXAy?=
 =?utf-8?B?RytxM1Ztdzl3UnBUNGZDMnI0WTFWWE51TlgxR3RtT0JTaXZzQ2tKODZ5disv?=
 =?utf-8?B?YkRmaVpKRkVwR0dPd0FYbjNnZjlrUUpRemhacTdvT1ZJdVBxNldxckNKLzF4?=
 =?utf-8?B?MXkydXFzczU1SWpyNEN2Qklka0tlcW4wdFpoV1lQWVZNcitabVZNdlpzTDl2?=
 =?utf-8?B?aTc3MDl1N0VqTXlXdTAybTcyNmJMUkUxZWhOdEQ3eThpeFNoSUVHNXVWMkJM?=
 =?utf-8?B?bHBLWk84R3FIcDJWbjY4NDVBUDE4SVRQTiszU0JpSEZaSTFRSnN4U1Y0Q1BJ?=
 =?utf-8?B?VkVPNXdpcE5WMnBINWVpbUkyeXNMOXR5Q0swYWtCVFlGR0NrT1F1S1hDellH?=
 =?utf-8?B?ai83ajFOaTFjU3IxL2lVY1Q2Qnk4V1J0QlFTN3BSOXRNVjl3bVJFMHhLcWU2?=
 =?utf-8?B?bzhIYmRVbzZ0ek14Tk5vcSsxa2Q0TTlWdkFwdUEwV01qNEIvQUhVS2phbS9m?=
 =?utf-8?B?OUFPeGU0aGd6Wkl5ajJNdlVMemdZaW8ydXJuLzR3QlNTam00eTdnWXNJYlpy?=
 =?utf-8?B?OW1jREk0YkR0R3pNVjNJWUExd1IzMmNHakdaNHRNdUdmY2R3WmpnZWRnUjFG?=
 =?utf-8?B?SUNqZ0tWYllBSFhpNUlBZjBYSEU5TDgxYkVJUHl0RWI3dTdwaGNGeCtjbWZ1?=
 =?utf-8?B?d3hsdmZvSmhwcHZXeW45Q1Z0T3pZQ0w4RVhOYnMwR0p2TC9YdXlOd3R5MDhR?=
 =?utf-8?B?MVp2MjFmYmFCaG5qMEU4YjV5MjJ2RUI3elRXNnJzdkVUUDB5VllHZU9MZmNi?=
 =?utf-8?B?dldDSzhFVjlza1ZaSUNzekJHeHNnVDUvV0lRZDRPcjRqaXNPOEVNdEF3SEtD?=
 =?utf-8?B?QmFFZldBS1d1T0dSZUx2RnJvTCtGcTcrdG9rNVpQYnV2U1h6dXdZaWFDWTdV?=
 =?utf-8?B?c25yUk1kV3JmU29xei9SaVRGeExIMXhFVWZhOGFmYlI0K1puUzhtVnJTY2dG?=
 =?utf-8?B?RzVDUklBQTNrejgyeXpLRTVaamdDRVY2WDhQcS8zU25QVmM2M3lFQjRubWdE?=
 =?utf-8?B?ZysxWWhxUzNZaTRnYzdaWHdmNm85TzlYVEtVUm01dU5CNHJqL3lBeU1lYk9B?=
 =?utf-8?B?RVFJa3YyaXdQMFp5d05TQzhkeXQ0WjJRU1hicjMzK1Z4bitCZnFFbkQwRm0v?=
 =?utf-8?B?QkJiZ3BFRWZEbytJZWp1WUNVNnJlemovL29YV3FmWTJMZXRSUUJzOU1IY2R2?=
 =?utf-8?B?WmNCY0VHYmF0NWtmWmdyWTVQQmxtdUFBUEJKci82Tk1xQVlKMkVYRithTjFo?=
 =?utf-8?B?Y2RENldjcnNwR3o2amFOVXc0MFF4R0xYR0QrcHFESmM2RUg4SnJDbzZaQ0s1?=
 =?utf-8?B?QjF6Mlo4a1gxSUsyYlRIQzlWTVhJbTFHbExMSExlSFNsUERQWkR4WnZUTUY5?=
 =?utf-8?B?UXpGSi80VUs4Y1Fka0M1a0hvaUpTTkc1b3crNXRKVm51YzZSbnN1SmxScGlh?=
 =?utf-8?B?aDhXeWdYUFV3WHZKWS83WTlNc2N3SzdDRERNNHJzNHBWSG0vUHk2RUhTSVMv?=
 =?utf-8?B?RXh0OEZqR0dqYkZ3ZWk1eGRlaEo0alpKL0NidlR4dVJJWHNRc1lsYzZkWjhn?=
 =?utf-8?Q?y1qiVcxYFrPIXhxzJm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e815535-ed58-4027-324c-08dec0cb3a7e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 17:20:22.7527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: clCaGf/q3GIcLm4Xbau1xCdk4UJvrdOfD7VzZpy71CvV59biRSC64rYWz/pQpOudPofS5nYhoTBL+zDqsnEX/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8440



On 6/2/26 12:17, Rafael J. Wysocki wrote:
> On Monday, June 1, 2026 10:29:08 PM CEST Mohan Yelugoti wrote:
>> Hi,
>>
>> We ship SONiC[0] on top of Debian stable with a small set of patches
>> on top (see [1]). After moving SONiC from Debian bookworm
>> to trixie, we started seeing a regression where the kdump capture
>> kernel hits a soft lockup while collecting the crash dump, so no
>> vmcore is produced.
>>
>> We trigger the original panic in the kernel with:
>>
>>        echo c > /proc/sysrq-trigger
>>
>> The capture kernel then boots and hangs. To capture a usable trace
>> rather than waiting indefinitely, I added the following to the
>> capture-kernel command line so that it panics on soft lockup (and
>> dumps backtraces from all CPUs) when the hang is detected:
>>
>>        debug=1 loglevel=7 softlockup_all_cpu_backtrace=1 softlockup_panic=1
>>
>> With those in place, the capture kernel prints:
>>
>>        watchdog: BUG: soft lockup - CPU#0 stuck for 26s! [irq/9-acpi:39]
>>        CPU: 0 UID: 0 PID: 39 Comm: irq/9-acpi Not tainted
>>          6.12.41+deb13-sonic-amd64 #1 Debian 6.12.41-1
>>        RIP: 0010:acpi_os_read_port+0x30/0xa0
> 
> I have no idea what possibly may lock up in that function, sorry.
> 
> In this particular case it is reading a byte from the I/O space via inb(),
> that's all.
> 
> I'm wondering if it gets interrupted for some reason and then something
> odd happens that prevents it from continuing.
> 
>>        Call Trace:
>>         <TASK>
>>         acpi_hw_gpe_read+0x61/0x80
>>         acpi_ev_detect_gpe+0x74/0x180
>>         acpi_ev_gpe_detect+0xe1/0x130
>>         acpi_ev_sci_xrupt_handler+0x1d/0x40
>>         acpi_irq+0x1c/0x40
>>         irq_thread_fn+0x23/0x60
>>         irq_thread+0x1b3/0x2f0
>>         kthread+0xd2/0x100
>>         ret_from_fork+0x34/0x50
>>         ret_from_fork_asm+0x1a/0x30
>>         </TASK>
>>        Kernel panic - not syncing: softlockup: hung tasks
>>
>> Between the bookworm and trixie kernels, the ACPI SCI handler was
>> moved from a hardirq handler to a threaded handler by:
>>
>>      7a36b901a6eb ("ACPI: OSL: Use a threaded interrupt handler for SCI")
> 
> Maybe it exposed some latent issue.
> 
> It's too late to revert it from the mainline anyway.
> 
>> To confirm this is the trigger, I reverted that commit on top of
>> 6.12.41 and re-ran the same sysrq-trigger reproducer. The capture
>> kernel then completes the crash dump without tripping the soft
>> lockup watchdog.
>>
>> Happy to test patches or gather more data as this is reproducible
>> consistently on our systems.
> 
> Does it always occur at the same spot?  If so, you could try to
> instrument the code around it and look for clues.

Especially if it's just a latent exposed issue before spending too much 
time intrumenting it's probably worth cross referencing 7.1-rc6 as well 
to see if the same issue can occur.

> 
>> This issue has been raised in the SONiC project at [2].
>>
>>    Context
>>    -------
>> - Kernel:        6.12.41+deb13-sonic-amd64 (Debian 6.12.41-1);
>> - Last known good: Debian bookworm kernel (6.1.123), predates
>>                       7a36b901a6eb.
>>
>> - Default capture-kernel cmdline (from /etc/default/kdump-tools,
>>    KDUMP_CMDLINE_APPEND):
>>
>>        irqpoll nr_cpus=1 nousb systemd.unit=kdump-tools.service
>>        ata_piix.prefer_ms_hyperv=0 panic=10 debug loglevel=4
>>        hpet=disable pcie_port=compat pci=nommconf
>>
>> For the trace above, loglevel was raised from 4 to 7 and the
>> following were added:
>>
>>       debug=1 softlockup_all_cpu_backtrace=1 softlockup_panic=1
>>
>> [0]: https://github.com/sonic-net
>> [1]: https://github.com/sonic-net/sonic-linux-kernel/tree/master/patches-sonic
>> [2]: https://github.com/sonic-net/sonic-linux-kernel/pull/580
>>
>>
> 
> 
> 
> 

