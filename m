Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865D73976AE;
	Mon,  6 Jul 2026 15:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783351945; cv=fail; b=d5O6UIFME1tbNALsMXzuH2Tx4vLeWjgJ+KGwPqvHiJrS8CYWWHviMvSMVc6HeVqxmiK2AM+fmboDrih2DfnQslAQONQqveEvbKRM6aEf8KKZIoYAcJ15uiJsVPn+tGtZipUk9adnvQ7+unJuWEJJaGCUf/52xoQzpiS5Hmk6Y7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783351945; c=relaxed/simple;
	bh=DgzGNB+TMrEggtLb3ofGEwvJGKlBSKxi4dBNNDPBEH4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LtlF0POHU9rLR7sPMFDbMUBwEri1Cuw3MNCT2FTpCuHJfGpa2T3m5ei2CHq3QSTKPGUjFy6fm5FSpNHTDzALoOChZRi2xFAWpd1NlEDxCNs8V1x8EnU13/NwHlHiJyhiNqgjahX/1HwiU5OdY6vi9wdHspxgW0X75+bloi1jE3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e1wKBci1; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e1wKBci1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783351941; x=1814887941;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DgzGNB+TMrEggtLb3ofGEwvJGKlBSKxi4dBNNDPBEH4=;
  b=e1wKBci1w/KHu52ROieQNMe3hNIDHWJDqSjOq3EXT8YuX48xct6Toebu
   /sBm4UNbwMTAI//CjrzAHAhkV3wWdk6hf4uO0xBLohHLX8HcozAQ1K08E
   yMlL1YGCXhHMoeYQJzSP6Yl127f8Co7wIZNIzjwuzTHi0CKEXGtM4iROi
   ZyhFdsIhWrPdyj7C593OaZdyXC0wmDVr6MfnHd/PxdEbW/PcuDZ6ge5V9
   uxG97dk66mqF+czU7YdeFRdnA5iVkSLum49+iiTF6HvarhxrfPMUnISB2
   pQpkxBIpE0USO+CCxqXZAdWHMQ45+vUgYbREdut+/qcbrNRy9f6swwBrI
   A==;
X-CSE-ConnectionGUID: Y3rN6VfORFuZci6fxWGpQQ==
X-CSE-MsgGUID: oz63Ig1UQVqnW5s1ujwaXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="95501028"
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="95501028"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 08:32:21 -0700
X-CSE-ConnectionGUID: 83gJ98+oTA6BErPNr8NeJg==
X-CSE-MsgGUID: mCL2NBPAQKeKY5cgyApg2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="249757353"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 08:32:21 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 08:32:21 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 6 Jul 2026 08:32:21 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.50) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 08:32:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E6qBdE0Jx7noK6nAreIHWPb7bZha4GBWn5rVFm+dsiIdnIX6zgyqn+Uv2WFO6NGitMyYyyj6s3uZqeIs6bceQ/8n7iEEvdnyju26QuDokS4xYFSWiB3Ax88ERv2g6T72NUfaMDJ2gIkpyp90pK6Gis4jf7nZXY/RHbfjp1+tmMwXyQnfiGRJbOHfyoQcGFBwiMv5QKLdPhj5GEBGaeiZblzWaSAFdaZDCHpyOwd0A1xXDse4Ev7FluNf6tqd2WVewwNq2Q2yZSUyANYOh2vUAs75o1awezWf3giq4hNlc5N4Q9konxA9bRdXRR6zv+/Nm8Canb8OcjiARNw5N7dl0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jmguMrvUbTpnIyG32IRVzy+y1ZJvvtgd2LIk76lS80E=;
 b=jMIuu4KEFTkuG/oNqsr2wleB8mUKcEkcSdY1Bh+dsfF8Y1LR48QSohdwn46Hz7C7fNUQPImOHDCY5lLBtfGPej3pjCmF+Vx9nTN99HCftmvI7dxlx0HRFI/My1RsIyWbwTSgosCWXzRziLdNdWqgTIyfPN9nhTM+TRghPTvFUq4i+YduPRbqudJg0fMQiW+l2SCA05drE/XpNSELkb8oLFsXr+9LtBlMRU2wfgv/52KbWPviYbc48Lyo3GoWIhbnUY6+bRo2RpdOwZMhCoLhy1Q1R0fNCxDmk8BEbKVGeYT/w6nx3BAeTCldB2eLApvabX1gb9wcrcrHrS7jJVg7cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 PH8PR11MB9806.namprd11.prod.outlook.com (2603:10b6:510:3c2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Mon, 6 Jul 2026
 15:32:19 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::3058:1480:e4ac:5765]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::3058:1480:e4ac:5765%4]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 15:32:19 +0000
Message-ID: <e23b39d1-e305-4ef9-b35d-29d9d1019835@intel.com>
Date: Mon, 6 Jul 2026 23:32:11 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] platform/surface: surfacepro3_button: Stop setting
 acpi_device_name()
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Hans de Goede
	<hansg@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, Maximilian Luz <luzmaximilian@gmail.com>,
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<platform-driver-x86@vger.kernel.org>, "chen.yu@linux.dev"
	<chen.yu@linux.dev>
References: <6036011.DvuYhMxLoT@rafael.j.wysocki>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <6036011.DvuYhMxLoT@rafael.j.wysocki>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0026.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:5::7)
 To DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|PH8PR11MB9806:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f5db01f-b594-4c13-1747-08dedb73c445
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|56012099006|11063799006|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: rscFcauDOe6h9TzCzRIMmNqZCwskt+HaG203fsrryKCRKC8q2m8IGJllbb4NeoE6URLR+ptjIgOYZx16n3pEmT1+xB0O8MMmj4O+9aREuXLGQJ5GBUPONmTHsST41gyvEJqt92j/R/XEpZckgkLK5e5XEMwXP4iEhmb9fhD9txYkmVSJFRVBRAEAkdczCr+jcYqC5P0m49verf0uf4VRlYBT+P0eIl/vgOBsXfwFV4LmuDxpMFAE+5LucQOv25z4Am92pPe7gfTRdZzRNacCLHaxC2jxX4PCq7x/mDKmHTNBmTfnUhdGxRb9aDYTNuWYaAy2jp0odReOAU4NB2eZiEytekPJznABfDfM83n86Myf1w6rUUvHl6MEtlCgDHTF6qFOkx4f7xsB24X/HCqsqgkj/IHy61bGFHdAMApXhxKpYkNhcA1FqpdJdiWOCf0/mPSlwsGvs2ZihX3sL/1WTvG0C06gIaHvDQaM8ivLaQpmC8CgC/4e8QfiOtBUBapYa+AHc03lD2RBDE8ztNYvQ5+5nF078F7v45acgcOM1Qles4IfpSkwlZhcYE2zSj2HkibaRpsBb5NNv76YJjRVzQ86Nv5cFX5DIFNkvNLVh+4kNRncQJkINoXC816GjkkdL3cG5D4wGqIMiv41C78kXHj5QHefBVX5Sv2d1/NJ+VY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(56012099006)(11063799006)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWxYREc5N1NZdTMzOVROa01iT1BTOEhJQk1zempuWGlBRjUwTWFpeVRNelh6?=
 =?utf-8?B?eFVzUDZBd1VEVG92RWFtZXRPNTNSNVNaK3c2alF4K3haU0N0WjhBYjlDcmhC?=
 =?utf-8?B?WmREbkltUHdJUWxqTXkwK1Yyc1NoRWtJN1R0OHFmTjM3akFCSlJOUDB0RnJu?=
 =?utf-8?B?UjVQM244MEQvQkhiNUlhVzZFTWZpWXBTajFic1dJdEFINkFiUnU3aGJmbVYw?=
 =?utf-8?B?eHNyWUYvcW14c1g5azlpWk5IbWhyZ3UvMEFuSVNqOW5ScUlaQnZ6VStTeXdk?=
 =?utf-8?B?dExuandkekVzTTdJQXNEODBaL1o2bmk0U2F4Q1RJSy9LbXFxcWNvamN2a25h?=
 =?utf-8?B?S1FCWlYwSnpDZUpYaHFScGZvSUxBNUJUWjI2ckFKSTc4cmdicXB1N1o5L1pq?=
 =?utf-8?B?QUI0MUJFeGRWOVNYWE5SM3FQOStsYlVMcXFYOVFGWmZUQngzUE1PTlBkZHNt?=
 =?utf-8?B?TEM4UWkyNHJZblN5RkJJRnd1b2xoRURaNmM4T2Y5T3R5b05QNWNhZy9UaDYy?=
 =?utf-8?B?NVdGVzFWaE14TmZVMjBkM1MrVThqSWNPWlhzaFNHS1kvcXAvVE1GUUtmUTgw?=
 =?utf-8?B?ZjBrNXNLK1NHYkgwNVlEdWcvejRKWXBSbzEydU5nZC9BeVBrdVhyUHhSWGVu?=
 =?utf-8?B?bEhjOHVaVW9nVkE3T2YyaWV2c3hpaHlvUlZyb1pEbXZDWDV5MU9iejVyMzlj?=
 =?utf-8?B?Z1BYb2UyNStFRCtoRlIvSVByNUxwaXMxWmZFTCtuTmZLcHVVelZLOGFVbWh0?=
 =?utf-8?B?NTNjVngrMkNDc2FDd0J5cVNZTTBRN0FxdkVBUTNRZkVJb3ZPRTl6Q2UrOVlP?=
 =?utf-8?B?eEYzdVZYTFpXNW5JTi9iMHFvZzZKV1grYVErUTRjT0tjUXRFdklYU3FQQmp0?=
 =?utf-8?B?Q2kvMVU1YUVGbjlWYkMyRWxNOXMwclRpZVRqblJhVVU0UUlPeXl5SU5PMXA0?=
 =?utf-8?B?UGQ5TEQyRUhSNnVvcEs2OVJLa2UxQlkzU0dNZFdtRkdCSk1zSURNZUNpUUFU?=
 =?utf-8?B?L2Q3Ym03K2VOeHBEYmtTUHZoRmphOTRmeU5nM2dFd2VxNXBLcVN5c2Rudy84?=
 =?utf-8?B?M1ZRUVFjTDB1a3JHRVFtTEFLajYrSjh3em9laVNlSU9tMDc5UW55V0JVdEk1?=
 =?utf-8?B?cm5aVUorZ0poRXI0WEtLNkU3YnRiaUR3WWJOUFd2TTk3a1JNNC9VdWM1VzJ3?=
 =?utf-8?B?MVA5d0srQXlnUDZsK01Uc2RLenpnNlFBQTJqTVdTRjJZbXBqc1hVS0drdzNM?=
 =?utf-8?B?aG55ZnVzRUhqekNzdXdkQ1NDMjFGTFZQQVg2RWYzYlUrUUtuS2xQRjFZa2Fo?=
 =?utf-8?B?UWUvNGMzcXRYc1VHZFFhV0dzbjdiWFV2R2NHZXQ1U1BrbUlqd01NNllxOU9Y?=
 =?utf-8?B?T1FEVHBGc3B5TlNZaWJPamJEUjM4Zi8xck5KbkpmaEpjR0pGbWd5c1lkWGZ6?=
 =?utf-8?B?enh3czBuQkZhWXhPdzJPNmVVYStmTytUU3YxSHdKZEJOZXFSb1JxcHMxbEFZ?=
 =?utf-8?B?ZHBCeFJTTmMwSlJXanpkVE5iOGhDd29ER3hsTmY0ZVU1ODJaWVVCOVJKVFFl?=
 =?utf-8?B?QyttOTlHR3FSVzQ5TWVKbU9pSVFMUndTZTZ2dGVZb0FOS0RsSE51VW9VQmVI?=
 =?utf-8?B?eHB2eVJXOUE5a3hOcnVYMGQzbEtsOEpCblNuTzFxUC9xdWlUZmxLaHNWL25Z?=
 =?utf-8?B?QWVkdnhLU3BEME91VHFCcUc4NVhTQWQ1anRNb2xvdVF1c0tSSzZ1STM4WlVu?=
 =?utf-8?B?YVg3THpJMDdjL3NjTXR6MFh6STk4ZXRBblRkN2NvUWdNb3VqakZOWUtQZmYr?=
 =?utf-8?B?RFhMb2tvK09LR1RGZ3JrZW1Vck1sbGw2MktpNGJtVjVUVUNBWDY1OWJtNUxG?=
 =?utf-8?B?OXBIT0Q4NDhON0dFZjJHYnk4YldHZUwvdGtERDZUSGdTNEVobytaaDVDZE95?=
 =?utf-8?B?T3pNV2hxK3lraUVuRDdXQ2NyQlVZWTNKWDlxT3M2Y3JQQjdTcHpNWXNaSEZo?=
 =?utf-8?B?Rmc3dnNoVDcxZHB4Zmt3aDlwa3Y2QXJ2M2lVZ2RmeGN4SklWc2hqaDZYaXFM?=
 =?utf-8?B?QXZZb2M1enNFL3F4WE1yeWV1dVdienRZdWVxZEduOFppY0E4WXZUMUEybDJ2?=
 =?utf-8?B?YkJCK3VqalVlZWdjQ3YvdThxZFQrMDUvdVJSZ1JRem5PUzlqbTdzNzdUR21y?=
 =?utf-8?B?UGhvNUo1cUZGUkRGS1F4NkIrN1E4SlpQeWJ5dXVQbVQ5SjQ3OEZ0SW1XZkx4?=
 =?utf-8?B?STYyRUNDa2xCaVpSc0w0NVd4ZkRBdm9HMHVRbjVKcHVUZ0RzSDhsekkxM0k5?=
 =?utf-8?B?Y2F1VnhiemtTeGx1ZGdqbWJBem1kTkEzaDhqazA4eHNybTBMRmVBUT09?=
X-Exchange-RoutingPolicyChecked: je+O739geI7JEPy6cq1Hb8TGuqspuWDuQwjD6GCS6isAlHvWc7WxUTyVX9LmqBhO07eK+hMstL9KAUDVBOwduYAiwkNlfTMVJe2heE8a0O0yZEoQzHCtuo1OvZ7A4nksYWzDshhthmBhR/91n9VqwYBeVJV2zHCXS56YhUHNR43R8XA/Ors5PExN9wXVXxLEx7WC++MO6wxY8s60WlkgwW8ftuExnzjTyCZhWvAVndB5kEnvXVVmU5bjjy1VN1PxsiADns70ustqLUP/7J03hjN0n49T3q9N1eq7olLD10dEs7naEfaNaRB+s6WLVa/qNVRC++iCITkZtHWUF+/tSw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f5db01f-b594-4c13-1747-08dedb73c445
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 15:32:19.5512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1NhsZjB1tD/H3C238JG4pVqhuCAlXsnRA1D53KKfsscaT1WdTk0aNfX8ToynyDQ6AV2HOf6ZWhW94YPFhL7tMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB9806
X-OriginatorOrg: intel.com

On 7/6/2026 8:28 PM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Since acpi_device_name() set by the driver is only used for input
> class device name initialization and printing a message on probe
> success, and SURFACE_BUTTON_DEVICE_NAME can be used instead of it
> directly in both cases, make the driver do so and stop setting
> acpi_device_name().
> 
> No intentional functional impact.
> 
> This will facilitate the removal of device_name from struct
> acpi_device_pnp in the future.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

I have not noticed any issues,
(sashiko reported an invalid and unrelated to this patch race of UAF,
which should be gated by evdev->mutex)

Reviewed-by: Chen Yu <yu.c.chen@intel.com>

thanks,
Chenyu
