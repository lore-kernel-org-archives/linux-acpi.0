Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013053.outbound.protection.outlook.com [40.93.201.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1B648B37D;
	Wed,  3 Jun 2026 14:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780496711; cv=fail; b=gWwtUhrmV+uFoy9VqOpZyTCapNcenvt+m0CPVpy16f1Hf424MbpJBbgLoQ9fNOOifvsZU5m9eol5Wvn/uy8L0fgwH4JCVegU8lNgXjPR8MdmKyEi9UfkLwXwDiZ4lR4wLW7G1RVbvAm/TAY7vSH8cWrLFhMBY+jqc8DbTPPRvbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780496711; c=relaxed/simple;
	bh=AlHaz2AYErjTZd5BW9ZFad5nib6/Q3rCofTkupn98qk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eohj7JjogP64JxdmC277qO6nBIpMFtIvTtpfX2Iy5GqcBe25fDXX9EZl/w+dRRp1L/ZMc9RunU/73pZJ/1ThkBa+4HOlGfEvFrRSeuZEgRzKpw4XLCs/3bPGZ4uoJ5XLQSHmaLUmfzljhUmKJJi+r9/lFDBjxvKkovSSjKc87iw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gvAiSbdd; arc=fail smtp.client-ip=40.93.201.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gvAiSbdd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kvdnHSN9NyYNYmSxeJYXonnPn0UBHwPtYm1Fv+J65zAT+7Qk+17kbInu9R+eCOD75aHhTbP5SCYB834VYRhX2yF2X5QJiM9yN1DnOMWXZgpBdpqpS6difHnQ8M4OMrBx2XjDhsCXxPijbxwME1Op1ghaC5UicrM7AMEgS6BBK+o+oZHIDBUFRNef+Nr5CjCgK3uD7ErsdH1J7LJqAha1jZT8gswIRzwztnh8Zso2hJsibhXv1MFdj+p+FTbSHYQUFkjrgPfOJjIkCumPzOJA659/hkefADCwUjDTZQlWT3R5udeSkQXDw721RVqmwFpBewtKJjW6Va47+2Vl/r/ytQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=06x5xQ/xeHNVpKBbYoBB9EbHC4lTr3UhJp6cnWgJRm8=;
 b=fk2KX3+7ROlORP7/d98Rq0l5qRoisusA69Hrms9sfas3szPRtD0LQcz6dK44tAnTc6Me9BVwyd1Z9qwF7fFJn/ywcRp00HNBveyB7FoeCOKEU5NJ2m3n+YvD7sXD7S1oQuBsfeV5g5jGVnkOEvLVj/W09vFbA5DpL3kIAtQDSEPdHc8bdjtp1T99PILgVAPe9u/vkcnRAK4Ba86qrc7Ok3z1VbjON7AAqRxwNR2e3WBHZBoSs4rWQXGjBoxU2huA/8aHb/HeTXjA/gdywxGw9fsuCV44+HF0e1eOxgIzSJOkUWKZI86lUUPJu3VzxujNVUI5mu4xlppkNIQfbKHR8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=06x5xQ/xeHNVpKBbYoBB9EbHC4lTr3UhJp6cnWgJRm8=;
 b=gvAiSbddELm9EihlTcyPEIUe8V9PJUDGGdas6f79Gum2jlnBrzMoJYoKcuJbKSZATxJjym69UHfWvDi7h8p+WHhXc+aNlduieL0QXC1xYha6QCq9rn8So+JbhVXQf8oWM/sYMtf9+1AS9DFNPYDQernDAfC+o6Uh9/EmOhb3+Ng=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by SA3PR12MB7832.namprd12.prod.outlook.com (2603:10b6:806:31f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 3 Jun 2026
 14:25:04 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 14:25:04 +0000
Message-ID: <308d71e0-2f63-49a6-8a2b-d6a6401b8018@amd.com>
Date: Wed, 3 Jun 2026 09:25:00 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/3] ACPI: PHAT: Add generic helper to parse PHAT
 records
Content-Language: en-US
To: K Prateek Nayak <kprateek.nayak@amd.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Yazen Ghannam <yazen.ghannam@amd.com>,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 acpica-devel@lists.linux.dev
Cc: Vilas Sridharan <Vilas.Sridharan@amd.com>
References: <20260603063317.13665-1-kprateek.nayak@amd.com>
 <20260603063317.13665-3-kprateek.nayak@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260603063317.13665-3-kprateek.nayak@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR19CA0005.namprd19.prod.outlook.com
 (2603:10b6:610:4d::15) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|SA3PR12MB7832:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cba0ab6-9f3c-42ea-caa8-08dec17be6fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|56012099006|4143699003|18002099003|6133799003|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info:
	CvktZ8Ebj5XcgRJJfGG0CwmOdieqlXt+tXc9gc9In0ShgrBld3SfCRNxsLQEVgSGD/K1XH/r1+d7bGCG1eyXPzd2D6/FdUith94TbVMBXoIqxWErygdzZ8lAef/OjAMVZGvT37R4Vr19R/RsmQMKNeKHblnVn6hRoP47W8crOPzxzYg7jwM6hKGoFp5KMls5x4mdRbk63xT15B5+2DlXkT0OTrMPQDXnTsOJ6ViJN5EQPaVs5grLnhZHvr0t35yKd/CqJ+LK8rkjZpnSwgmPfozPeY6XN6qU8sIDuQrvskDDBnPTCV1kEyfuBYRquXZlVutWk1QTjgLUTDiH3vMIhsnO/EuHdHs50UFsFemdC5W3JPTNqGafIfjinyZLvSYHxLJGjcSBVW6Di7aIuosa2Veru6GZ6j7BEdGT6uqb5UnOShvfSp/TA9RVk6WHV9AmtC4lj1fz6M5qPxPs9ryR4Rx3cF5YNY0sg/AEtco1JZ+lUKB9GcDFPQGAErYx9a08OxN2Fv5bMNg2Xc06e8bGbGYFQ8K+0ISAJ3tA78o78dEcSYK2cUNMzG9DdGjW1qJ970jWFQpNu3juRtq6MwJDqIo1Tx1qF6C8LB+qHVYxKGpl2f+HlMVZt1PP3ob8U6vMLePhetMErIqadwMakiEM7A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099006)(4143699003)(18002099003)(6133799003)(11063799006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?djc0L3lEVyt2bitITUtiVHZVclUrUFdYdnl0dFZwT01MZ1VBMmxSM2s1MThz?=
 =?utf-8?B?ak1aeVkvRnVjd2orbDJIbCt1cHdFSS9OeE9SU2ZOM25ka2QrdXhpSG1lSCtv?=
 =?utf-8?B?clBRbjN1Rm5LUXEvY2VQbTNGamlIVncwdUt6d0ZsNmJCbUNDZFhNQ3Y4cGRi?=
 =?utf-8?B?UDhvWjA3QW1GMUZScHQ2UkJoMjVWWldTYTB0YWtMMHRQMG9iVTk5Wkp2eGJm?=
 =?utf-8?B?b2hEbXk2d2pRa3l0ejVQS1VHNzJKdHdjU2ZCTEYzZlRQUjlrN0MvZWRMVWox?=
 =?utf-8?B?OTNDSEtManQzYjhvR1kxU0tmUlROZEtVRVk5d2lnbmw2NHFmUDlIRWxGblVY?=
 =?utf-8?B?b3ZZNEtRcXVVVjVDSDlpS0VHM1kwQmdMOWZkSjNYSkNGd3Avc04rSWJGcHJI?=
 =?utf-8?B?MkZhZStjblh4b2NScHdrR2pCOUZENUNqKzNKNXNrTU1LRHlWUk5JeWVHNUlD?=
 =?utf-8?B?Uy9WcjJ1aDg3OENWS0tjc21yUDl1aXAxbklnQmJlbENod01ielplL2VoSVpL?=
 =?utf-8?B?L2Y4NCs5S1BBanJnUnJFRjllSEtNYXRFVlpxdUpKU3d4UFFSMk1RR1pleWRB?=
 =?utf-8?B?NmRobXlBN3prWG80aWpBdlpYcHY5b3l4bE9GY3Mxbmp5d1ZXQVJNeGw2WThm?=
 =?utf-8?B?WXRXM1llYlRxSkFST2x5VjRiVDdnWVFMNXJhTDNoRlBhV1JJSU5BZ0cwOVR4?=
 =?utf-8?B?bFBFblJaU1U5czMzQklqZ1ZoT0JPdXBmWVdJMDQrREZic2t6UTJGNnM2alhU?=
 =?utf-8?B?RklhZG12Z2dnV3lmYnQxTFRoWmVSMXVqS2ExdXRWSFlCLzNMREtNVFZqTEY3?=
 =?utf-8?B?MElVMVJGc2U4SllCYi8yTUJWdVpmYzdqc0xhaVdnZVF1M0xSM3BhdUFMQ2Za?=
 =?utf-8?B?S2NwbGQxYmdjQ0lzUWlBRmg2K1dIeGU1QUkzNGZSNHBIWk1DM3BDTVFkcW5t?=
 =?utf-8?B?Smp3clFBcUR2eXdCUTU0bG1rbGVtT1JxdVBQaGRjTzFhUHkwa0FyZjlRZE1K?=
 =?utf-8?B?OUNncXhJZDNtNjhxQ1laYjNBRVQ4dmR6c1ZnSUFiMG52ZjQ0V2JqSnF6enFS?=
 =?utf-8?B?MEsveTljSFZQb2cwTkVSY1ZHYVkwTlBYR1NCL25Ca1RML0hLSU5yV2xNZDlP?=
 =?utf-8?B?cmltVmlWMXk1MXI5bkp2UVdUazFzSUZHYXNrWWpPblY5UEp0VDZGMGJyZnFM?=
 =?utf-8?B?V0FXNWZpRjI0QlMxSnJzeVo0Z1c0S2ZLOTB3TmlzTzVkMkxYcW9qNnJ0RG1u?=
 =?utf-8?B?RDNsY3l1aTlGcHVvdDVhV1dBMHhQNHl2THUvQk5KR0doUEpJaFgxZ2ZCSEZr?=
 =?utf-8?B?NWNpSnZZeXJ2TXhBV1lTa3REQ3ZQMkZFdEJ6WGpTc0x0WFpXVVBPdDFlK2V2?=
 =?utf-8?B?eC9MbEpBcTYwU1FWVlRXM3NLaDYyUmxjSGRGOVB5dloyUlZuSFVWOXY4djg5?=
 =?utf-8?B?WEpFVCtSV1RPbjJ1QklVR3Z3dG1ZYkhYN0NXdmxIZUhwOXkrMHZZOFB0UDhT?=
 =?utf-8?B?clFKL21vZzZ3Z0p0YUlRUlQzejRNa05FNFBlaEZjWWN1S1hpelVGVDRJYlpn?=
 =?utf-8?B?U1Z1WDZoSWR3ZmM2MU1IRWZKMXFRc3R0MGh1Z2lGaFRlRGU0SUJpYW1DdENi?=
 =?utf-8?B?TXpiaW5zK0RpeE9kWFVxZzlLN1JaUlVLR0E0cU1zaS80cnVjbVQrY3lYUUVM?=
 =?utf-8?B?ZU9oZ21KMmk3c2oxdlpNNEpRTWZaMm1Fbm5yTE9UeHQrVlU0cDZ4TmdzOXov?=
 =?utf-8?B?TEU1SHl6YlBTTzVCeVAvRzFjTzI3VEZLZ1A1bUZwdjcvdVZSUGU0QUcwRjBV?=
 =?utf-8?B?RzRNeFNzcFIxR3hMb0dlNEFEUUlzbnQyclMrWXIxZ2dBQmE2cjVvc25oNFUy?=
 =?utf-8?B?bUxBRUxBQjh3Qkptb3I1YWxqN0Y2SEhPdXd3U1lxdjg2WTQ5QnNzYktFaGtu?=
 =?utf-8?B?a2dVZ3haYmJBSmdwYWYyZU9TOWZqcHdaTlVJQXZINFNUZTNyMUZKVFZ1ZHVq?=
 =?utf-8?B?dlpKT0RpSWRmUC9XK1A2cUc5SkhsWlFtNFV6eVJaak9yQUJ3d0pKRm1YVHhM?=
 =?utf-8?B?blBTQS80eWJQTGdIZk8zUFpWdVM1UUF4RzRMUWdCQ3poTlFTRlh4bnh2U29F?=
 =?utf-8?B?RDRsUjBUTE9FTWhSM3ROTDZJK21SZTBWcGRDS2dnVXB4bGVuTUE2YmJnemJM?=
 =?utf-8?B?cUZabUR1K202RCtpak1LbEZKV01sK09pd3htdFdMY09uUjlpU0w0TUErZXFB?=
 =?utf-8?B?elh6aXJHNDlvOUxmalFJb2MvWTNwdFg1UlIzTmtxOSs0NlZDYmYxd2NrQWpL?=
 =?utf-8?Q?ApmeW9BLewWMZJ4qVj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cba0ab6-9f3c-42ea-caa8-08dec17be6fb
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 14:25:03.9462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: frnhXUxE0bv6g3qDtPgd6fYSl9C18XCwD/HflTGR7mEtN7qSdpuQL3ks86hsVBWBHnh3GNXH4szjvbXmcrT7lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7832



On 6/3/26 01:33, K Prateek Nayak wrote:
> The ACPI Specification v6.5 [1] under Sec. 5.2.31 "Platform Health
> Assessment Table (PHAT)" provides a well defined data format for reset
> reason records, including the ones that are vendor specific.
> 
> Provide a generic helper to locate the vendor specific records and parse
> them into a buffer that can be consumed by the users.
> 
> The first user for the interface is added in the subsequent commit with
> AMD processors using it to parse the s5_RESET_STATUS from PHAT records.
> 
> Make the Kconfig depend on ACPI && CPU_SUP_AMD to prevent the need for
> unnecessarily compiling in ACPI PHAT support when not needed.
> 
> Link: https://uefi.org/sites/default/files/resources/ACPI_Spec_6_5_Aug29.pdf [1]
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> ---
>   drivers/acpi/Kconfig     |  11 ++++
>   drivers/acpi/Makefile    |   1 +
>   drivers/acpi/acpi_phat.c | 133 +++++++++++++++++++++++++++++++++++++++
>   include/linux/acpi.h     |  14 +++++
>   4 files changed, 159 insertions(+)
>   create mode 100644 drivers/acpi/acpi_phat.c
> 
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index f165d14cf61a..494c757a62d7 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -607,6 +607,17 @@ config ACPI_PRMT
>   	  substantially increase computational overhead related to the
>   	  initialization of some server systems.
>   
> +config ACPI_PHAT
> +	bool "ACPI PHAT Record parsing support"
> +	depends on X86 && ACPI && CPU_SUP_AMD
> +	default y
> +	help
> +	  The Platform Health Assessment Table (PHAT) allows platforms to
> +	  expose read-only data for diagnostics and health assessments.
> +
> +	  Enable this feature to access generic helpers for parsing PHAT
> +	  data records.
> +
>   endif	# ACPI
>   
>   config X86_PM_TIMER
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index d1b0affb844f..d6cf252ca4ea 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -108,6 +108,7 @@ obj-$(CONFIG_ACPI_SPCR_TABLE)	+= spcr.o
>   obj-$(CONFIG_ACPI_DEBUGGER_USER) += acpi_dbg.o
>   obj-$(CONFIG_ACPI_PPTT) 	+= pptt.o
>   obj-$(CONFIG_ACPI_PFRUT)	+= pfr_update.o pfr_telemetry.o
> +obj-$(CONFIG_ACPI_PHAT) 	+= acpi_phat.o
>   
>   # processor has its own "processor." module_param namespace
>   processor-y			:= processor_driver.o processor_thermal.o
> diff --git a/drivers/acpi/acpi_phat.c b/drivers/acpi/acpi_phat.c
> new file mode 100644
> index 000000000000..de612ae018e0
> --- /dev/null
> +++ b/drivers/acpi/acpi_phat.c
> @@ -0,0 +1,133 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Helpers for parsing Platform Health Assessment Table (PHAT) records.
> + */
> +#include <linux/kernel.h>
> +#include <linux/acpi.h>
> +
> +#include <acpi/actbl2.h>
> +
> +/*
> + * __phat_get_firmware_health_data() - Internal helper to locate the
> + * "Reset Reason Health Record" within the Platform Health Assessment
> + * Table (PHAT).
> + *
> + * @table: Pointer to the beginning of PHAT.
> + *
> + * Return: A pointer within the @table if "Reset Reason Health Record"
> + * is found; NULL otherwise.
> + */
> +static struct acpi_phat_health_data *
> +__phat_get_firmware_health_data(struct acpi_table_phat *table)
> +{
> +	unsigned int length = table->header.length;
> +	void *header = table;
> +
> +	/* No records. */
> +	if (length <= sizeof(struct acpi_table_header))
> +		return NULL;
> +
> +	/*
> +	 * Advance to the end of the table header
> +	 * where the first record starts.
> +	 */
> +	header += sizeof(struct acpi_table_header);
> +	length -= sizeof(struct acpi_table_header);
> +
> +	/*
> +	 * Search for PHAT firmware health data record header
> +	 * with type == ACPI_PHAT_TYPE_FW_HEALTH_DATA.
> +	 */
> +	while (length) {
> +		struct acpi_phat_health_data *data = header;
> +
> +		if (data->header.type == ACPI_PHAT_TYPE_FW_HEALTH_DATA)
> +			return header;
> +
> +		/* Move to the next header */
> +		header += data->header.length;
> +		length -= data->header.length;
> +	}
> +
> +	return NULL;
> +}
> +
> +/**
> + * acpi_phat_get_vendor_reset_reason - Find a "Vendor Specific Reset Reason
> + * Entry" with the matching @guid from the "Firmware Health Data Record". If
> + * successfully located, the function will allocate an object of the size
> + * "acpi_phat_vendor_element.length" and return a pointer populated with the
> + * content of the record.
> + *
> + * @guid: The "Vendor Data ID" of the reset reason record.
> + *
> + * Return: A valid pointer to an allocated "acpi_phat_vendor_element" populated
> + * with the data from the record with matching @guid; an ERR_PTR() otherwise if
> + * no matching records were found, or if the element could not be allocated.
> + * If a valid pointer was returned, the user must call
> + * acpi_phat_put_vendor_reset_reason() for the object once done to reclaim the
> + * allocated memory.
> + */
> +struct acpi_phat_vendor_element *acpi_phat_get_vendor_reset_reason(guid_t *guid)
> +{
> +	struct acpi_table_header *phat_tbl __free(acpi_put_table) = NULL;
> +	struct acpi_phat_health_data *fw_health_data;
> +	struct acpi_phat_device_data *dev_data;
> +	acpi_status status;
> +	void *data;
> +	int i;
> +
> +	status = acpi_get_table(ACPI_SIG_PHAT, 0, &phat_tbl);
> +	if (ACPI_FAILURE(status))
> +		return ERR_PTR(-ENODEV);

For some further sanity checking, should you look at the PHAT revision 
here matches 2 as well?  Table 55 in the linked spec.

> +
> +	fw_health_data =
> +		__phat_get_firmware_health_data((struct acpi_table_phat *)phat_tbl);
> +	if (!fw_health_data)
> +		return ERR_PTR(-ENODEV);
> +
> +	/* Check if Device-specific data record is present. */
> +	if (!fw_health_data->device_specific_offset)
> +		return ERR_PTR(-ENODEV);
> +
> +	dev_data = (void *)fw_health_data + fw_health_data->device_specific_offset;
> +	if (!dev_data->vendor_count)
> +		return ERR_PTR(-ENODEV);
> +
> +	/* Vendor data starts after Device-specific data */
> +	data = (void *)dev_data + sizeof(*dev_data);
> +
> +	for (i = 0; i <= dev_data->vendor_count; ++i) {
> +		struct acpi_phat_vendor_element *vendor_data = data;
> +		int length = vendor_data->length;
> +
> +		/*
> +		 * Move to the next Vendor specific entry if
> +		 * the GUID of entry doesn't match.
> +		 */
> +		if (!guid_equal(guid, (guid_t *)vendor_data->vendor_guid)) {
> +			data += vendor_data->length;
> +			continue;
> +		}
> +
> +		vendor_data = kmalloc(length, GFP_KERNEL);
> +		if (!vendor_data)
> +			return ERR_PTR(-ENOMEM);
> +
> +		memcpy(vendor_data, data, length);
> +		return vendor_data;
> +	}
> +
> +	return ERR_PTR(-ENODEV);
> +}
> +
> +/**
> + * acpi_phat_put_vendor_reset_reason - Reclaim the object allocated by
> + * acpi_phat_get_vendor_reset_reason().
> + *
> + * @reason: A valid pointer returned by acpi_phat_get_vendor_reset_reason()
> + */
> +void acpi_phat_put_vendor_reset_reason(struct acpi_phat_vendor_element *reason)
> +{
> +	kfree(reason);
> +}
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 67effb91fa98..daed1d66ca43 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1627,6 +1627,20 @@ extern int acpi_ffh_address_space_arch_handler(acpi_integer *value,
>   static inline void acpi_init_ffh(void) { }
>   #endif
>   
> +#ifdef CONFIG_ACPI_PHAT
> +struct acpi_phat_vendor_element *acpi_phat_get_vendor_reset_reason(guid_t *guid);
> +void acpi_phat_put_vendor_reset_reason(struct acpi_phat_vendor_element *reason);
> +#else
> +static inline struct acpi_phat_vendor_element *
> +acpi_phat_get_vendor_reset_reason(guid_t *guid)
> +{
> +	return ERR_PTR(-ENODEV);
> +}
> +
> +static inline void
> +acpi_phat_put_vendor_reset_reason(struct acpi_phat_vendor_element *reason) { }
> +#endif
> +
>   #ifdef CONFIG_ACPI
>   extern void acpi_device_notify(struct device *dev);
>   extern void acpi_device_notify_remove(struct device *dev);

