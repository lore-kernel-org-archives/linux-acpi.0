Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43EA25C804;
	Fri, 15 May 2026 03:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778815648; cv=fail; b=LMUhnObRCCTXy1V4CwBCCMzR2XvGJD6B2V6s+3hulHYBUDKY5NUfe+NZyRDmEHKQgmY9Ugu7dY3hX8w2jehN/69hoBKDBt0oh6ShekxVFSXXDAS/b3RCPM+HMXVxHNFKJ679YCw+spsNLq57XUdiFp9PPmhQgboa8Pa1Ps0P0f0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778815648; c=relaxed/simple;
	bh=xZlu8ilr5WmL1vA1KLW7U/cyzhUVsCiF+T9WYxOWGS8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jVI2bO3r2m1iFFos0Py7nAR61t4ytGGNGFfPy1p8CxM6DiTTKFlgE9jHurZvK3pdpbaRXkxUoKOU9M2MahBG69fLcf+3VuNBsyPC/6Zd/IOtzZ+a7dff59u7VfNQstm5KP0NEvvF9fJ2AdcuGmqaQezzCZ/JkLCR/dxTNMeQYxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nvTRP0EV; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nvTRP0EV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778815647; x=1810351647;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xZlu8ilr5WmL1vA1KLW7U/cyzhUVsCiF+T9WYxOWGS8=;
  b=nvTRP0EV+ZbkdnoptfS3Ot61uvEa5+jJo89rq8d5TSU2UeZKwKr4wf8u
   Kizs8i5malu6iNujnPWLHomjhcL7Hdn9/ojgMv9OoiZJkil/03R8nQ3MQ
   8Tk5brAnJike4PTrGCuYsGYNpUTt4LksM7hm9O3vbcMVoH8MkZs7P6iTn
   oyRWL2jns0E9Pdlble1POCaDs31aDjHvlSgahu0TiWr/s0d1Nav4L+swh
   S5qxYubY6Egx8P7WwciDrOde25FPddop0uLFOkND42KrM+t6MDQunG+iG
   5C/IdTv254RmOtJT/x112eAXNDLIWtCL51DJg4unUOm2v64R5W1JMxoXh
   w==;
X-CSE-ConnectionGUID: BbDJXE9zQKSHJQlNiLiLxA==
X-CSE-MsgGUID: QmnbS74xQke3tNO0ed2Icw==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="79750840"
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="79750840"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 20:27:26 -0700
X-CSE-ConnectionGUID: gE7yXNOOTYaOV86/pz21xQ==
X-CSE-MsgGUID: 6W+TmYt1Sui5QaawWerAfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="242914597"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 20:27:26 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 14 May 2026 20:27:25 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 14 May 2026 20:27:25 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.44) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 14 May 2026 20:27:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LTm2cCklFwCfLwCXDLQuWZPdUCUqyfsINxzghvkXU1/92yv/QFewSI6ytvuRo5uPjcErvAjciZqg6mcInxjop8uSdUt/hhHJA5o4vTEqHXVOqETCvqLHgGMLWiy15YdUnBiheqAttlDTUl0dkUFB5N0B6ynedadrzxHZnkM+9b+ST7njEx6BoC2Sok/c8dSkd720CvOz+/3Fw9+qbaO2xgzH42SyGVUFNEtPmAqwiet9TOPFBgJ6C2DT7Cuhkc/r4e6OQXGWaK2wYvliNLxJENYKpnzzJ1TsrggqQAYAGXVRDJgaGSiZ+dEVQPaFj8j/hekQTsuJa9mkw79IyMYYBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U2oFCoNvZeh4JOuqikt1/VD4jOlm23jd6QfHBVuEEeU=;
 b=n6aZ5vzfSMBChbFRRzyJc++3VYJu87GOjTn+WAjegAd2ohvUKNz71feTUEEDxYipX6eJAWKWf70V7IbEcn9KK1y9UEHhW05WQTM3R4aZw0KKujw+fZf+VKqdtDgB+Ag+y1FTh7VB01SELY4UH03wOuu8JiYKeiB4ETVbOzVypfdiKi4ZL9zY+rmWlG7HefDLpl09jEd1HR6lVXa85tEo2hWGFLWHBqw7XUStbfYS8UySv6kwg9NgEfOC7LNWeqf94GJsO4pJ3yBKKERU/ZB075/JQ5PYL/kdIdQopv49M+hBgU6OjdulhI1qIRdYqqLarOVQK8OPRdJtnOmzEUxoCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 MW4PR11MB6810.namprd11.prod.outlook.com (2603:10b6:303:207::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9913.11; Fri, 15 May 2026 03:27:22 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::3058:1480:e4ac:5765]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::3058:1480:e4ac:5765%6]) with mapi id 15.20.9913.009; Fri, 15 May 2026
 03:27:21 +0000
Message-ID: <97113390-2343-4b51-bd2b-31ef310aa32c@intel.com>
Date: Fri, 15 May 2026 11:27:15 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] platform/surface: surfacepro3_button: Check
 ACPI_COMPANION()
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Hans de Goede <hansg@kernel.org>, <platform-driver-x86@vger.kernel.org>,
	Maximilian Luz <luzmaximilian@gmail.com>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
	<ilpo.jarvinen@linux.intel.com>
References: <23119222.EfDdHjke4D@rafael.j.wysocki>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <23119222.EfDdHjke4D@rafael.j.wysocki>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0051.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::10) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|MW4PR11MB6810:EE_
X-MS-Office365-Filtering-Correlation-Id: d33ec36a-f61c-4963-6423-08deb231e015
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|18002099003|56012099003|11063799003|3023799003;
X-Microsoft-Antispam-Message-Info: zFcQcwogtseTkjFy90c5bXLto1HNM3tw7H17RHpRwrWUJy4rAAGeD3kL9hwIhtEefoF+4eMCjCxtkthKfg1YxCBqJ1CyfuukCWRRg/lCxklWPiK6TRPCZCck+PGNpBnwZ+wSpxN/BucA85xyUsdGcdNLAVM+46u2ArlgwbJn1YUm5thhQNFuUwlV1Ll3A5GQ+OTnPjh/SVO7TpTRtUIWoWIuTioKeC8naIbDvEmQjsz5OqSfErWSUJYBfuQrijzd7mOr3zGeaDAh73d+oKPT1eTZ4vYmbHBOr9KqjahAT8WIGOBh+4cMzv54jxVpdfWJrNPWM1DV8iX2DWwm36xVuEXtxzsgSrlvOAtMHLMKO7gKNCSkQmGaCnonlh4I2+POcjoOd3U+QE+cROmLbiTRjIVFCGKUSe3pbkKff1EVvnSnIf7z7Rl3A5JYfSIUmfyA9j1hlqV2aY0pi2vO+pD2yQvlC/v0DnplwzFSjCQrmPxTZNgTR6aafOLHH3kejlJI/kaUnrHaQ/mK/GLLbnUpCdyE2NQz7NXkyRlz9DUL1tpB73Rcz6zzUZZjhRBnSmpp4TrBfSXKGpA2ucF0zoiL0dzie2cAJqa/mBWQa/EFK8VYwF1zSYNNL2+cizQdgWspazyrtw1oxLnTtPiutAkt5d1utQxuKQ/rJ2wNK00valSUuGrbNk1aBBeTDUvkWXSr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003)(11063799003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnMvd0M2RWZORnlnWVNyL3dPaXV5WmRGTUZnTmh2U3ZSMGtFK0ZNWjkydDhQ?=
 =?utf-8?B?bmFBMFByam5EOWozOE9ja2tCbTRpNkJFZ1hBUS9scy9HY3dzOTFCVzg5cTR4?=
 =?utf-8?B?MmNtbWJ1YTlxVURUbnp5WHZ5cGRiQ1hMMzdpbGpIVkk0K3lMSDM0eDMzU0Fy?=
 =?utf-8?B?VVBDWEptUUlYOGpDOWRORUZTU1J5b3ZVdmdqbDF6aGFhLzNZMVQ4Mi9wR09P?=
 =?utf-8?B?RGxpZDB3WmxOYWdKZkk4eWNHK3dOWSs2RW13c3kxdEx3Y2prMlNwT2pBTWlh?=
 =?utf-8?B?OC9VZVBBYzJwbFQzUHl6WDc5VCs2cC9SQW4xRUxLM25NaEE3SVhaaDZiM1Vx?=
 =?utf-8?B?STNHT1p5WlFLN2xRK2JsdnlSRHpmdE1QbUk4OWhXOHdOdlVTbklwMFBYMEg1?=
 =?utf-8?B?a1BqWUNCdzlxNlhCc1ZXcXNvVElNcmQ4UXVjejRvWUhmdXlPRmQvK0x3NlV4?=
 =?utf-8?B?TnM1dG5yOGZzWHVSdEdQampscWZ4N05QdWdXYVY2eEVmNmVkc3p5bWpPRFNP?=
 =?utf-8?B?aC9JUzg3dFlzTU1Ic2srUnVmdXhpM2RSelpwcDhZTUdPZ2pBbWhFWmMwUzdp?=
 =?utf-8?B?a3NnVlUycitvWG83N2orREdmWStVRThxMFB0SUZTL0l3QzJiUm9zZGI0UXZE?=
 =?utf-8?B?ZWxYM0VmMkZRTEJ1dVFONC9neGgybDhLTG1zZ1ZENnFkMkkrc2ZkekxpMHcx?=
 =?utf-8?B?aUdLN1V6d05ybTZoTTVvS2tTLzVNWjVhcTZEbHhlRHlOWXRUcDVlTGVUemlT?=
 =?utf-8?B?L2JtMno3MGdaZjluOVAvblZKcnczdWtQMkkrSlVNTW5qcmE1elBDT21rQkVh?=
 =?utf-8?B?eDhNUkY1WkdERDhvZ0Y4ZisrcDYzSllCWHY4VEhJTnowRlU5WHA4RUY3bVpF?=
 =?utf-8?B?aWs4eU5iNXpvYjBJVkNvcFloMGVjaDh0b2ZKZDZpOG1lbjNOWG52ZDhTeUc2?=
 =?utf-8?B?UGtEZzc3YWtDVk0wajhnWXVuaitJZXNzTVlkaE1IaUp4YjRZQTNkNTNmK2Za?=
 =?utf-8?B?K1duVEZzN2NaRkVsSC9KR2hvRmRMd0hsYmpDY2Z1eHpCS1U5eDhyR0NxRVo1?=
 =?utf-8?B?MytPK3B3TXM5d0NQOFc1YnlEenR1dk5GRElLMXdVZHdDSmJhYW9Da1ZYbnc0?=
 =?utf-8?B?TlV5ZnJJWWRRblFHU3FCOWxtZytxTU94ZXRrMkdQcEx1eFRLWDZMSjVwU0xV?=
 =?utf-8?B?RWx3UzZPT0JabkVTb0xncjZWTjZwR0tWYzBDZlhpcDJab1EzSktiNGt3em03?=
 =?utf-8?B?elBtR0c3aUMyR0Q2NmdKeHdVNFZCTXpvK3pGeThrS21zbVNXbVRMdFl0VXF5?=
 =?utf-8?B?LzlodUVOMWRyZTVVeE1xR2xTQzVJY0xOVXRwVmpHTVBicGg2clZIT1JIWkQ2?=
 =?utf-8?B?MUIzTU5QY2xNZlU3TkpQamF2RWZjb3dmOWZpRCttc0duSWJlYlhKazVzakFH?=
 =?utf-8?B?bEIxOWx6QktYN2hMUHpiNXlhUnRkY1F0ZUlhcHI4V0pLOEh3R3Z4YlM4ZTVo?=
 =?utf-8?B?VHMwaDZUdHdtMU5ZcjVFUnR2Smc1NGNNTjlRNDllUW9WVWxwSTNUOHRmc0g2?=
 =?utf-8?B?WTF0OEtTK0hudE9XMDlhbXNXTWlicFRncmZZaFhwQVZwTjg1ZVBDaDY5VS81?=
 =?utf-8?B?WUtWQXJMNzJ0NkRzM2dLZVVNYnFhTGxub3VMNTRFZHJCT1dZeUJ0UDRvRVMz?=
 =?utf-8?B?N0FUMUs1bmhweERkMi9MWXk0bGhybEdmRE1OOGdLZmI2cm9vamNUNjdzSzBJ?=
 =?utf-8?B?bnJkMDgzK1VDa1lHOXBXeHl6dFpYSXdtWHdqcTN1NDVYNUNhUGVkWG9FcERo?=
 =?utf-8?B?dUR1NVdBS2FsNG5xMVZiaGJNcSs0RTByUDlWQXJRSlpMQmlZemZYbUhLY0lX?=
 =?utf-8?B?cHJ0OW5FR0UxZzF0OTdNOThDT2FlNnRNaWpGNVovS2FLN2VtM2tpckxTTU1S?=
 =?utf-8?B?Smt6bzZIZ0R3NVZLQXFPaStJV3U2Wnh1MkJ3ZkEyZS8ranJ6djRyRTlXTW1Z?=
 =?utf-8?B?aGR4RVJoR3M2ZjQwMWRVdVI1dk1JM09NMm5sOVliOEh5M2hwUEQzZVJUK0Iv?=
 =?utf-8?B?VjRIVVZCK1lRdmc0U3BZVlBLQXJSVXk2WkhNdXhCbDBxK3liR3ZUaHI5RTFs?=
 =?utf-8?B?OEM5UEw0Zmg2TE9DMEU4SkR6RHA5c3NjdFllK2U3TWN3eDhLMVVOTDVGS1Bt?=
 =?utf-8?B?MjlCemhmK0dubWtWU3k0WjFKRkxZdHFHSjhmdERFUi9pNW9XSVFObDc3WVYr?=
 =?utf-8?B?a0ZQODREd0ROVWJsREhNOHYwbzVySi9TSUVNTHBCRGI4NVNMTWs4WGJsenpx?=
 =?utf-8?B?bnVGVXFKV1RyUWpmckN5dkJDOXdZSThndmdtSUY3OVBkejlyeGFWQT09?=
X-Exchange-RoutingPolicyChecked: MB03Pvk3N9OTFlAzpW7FFJKYT7FVKa9yoqeAzoFg2nN59wzyoYug1o0glF4zvEXrPK+65xrLB9IJoXaS5Xe+oeZZLsqw25xYc+XLoMQHjfrV7UNygRls9pBQNckqKuaTAOq6wGNxzSxuzP5OJlYaJyzJx7X/VqHQe8kpegXcmTk1QXiDksUtgmWfnYU39w2g29O0bJOiZ9ElsCZp2VqEpfv9A2OMJfQPwhTZk25oKLaUTFuuXxm8fv/GMgyF6Z3Hf4/sLyYezktK6U0vYn55BKprVv982PVnzEWpZI0SOIRNooC3fHXxWuCV4Yz+hv7WYgPMTVkxghPYKcuWmSqXqA==
X-MS-Exchange-CrossTenant-Network-Message-Id: d33ec36a-f61c-4963-6423-08deb231e015
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 03:27:21.9430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5h7PUzAV0+zaBsP51W63bV7j7PPaKgJZ8oTzDULPg6DP4cKM/FdK8BZgAo25qhRQzJu0YHsOkmVDecgP9a1fnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6810
X-OriginatorOrg: intel.com

On 5/13/2026 12:30 AM, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> Every platform driver can be forced to match a device that doesn't match
> its list of device IDs because of device_match_driver_override(), so
> platform drivers that rely on the existence of a device's ACPI companion
> object need to verify its presence.
> 
> Accordingly, add a requisite ACPI_COMPANION() check against NULL to the
> surfacepro3_button driver.
> 
> Fixes: d913a5a12b40 ("platform/surface: surfacepro3_button: Convert to a platform driver")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thanks for the fix, also learned that an override triggers a force attach.

Reviewed-by: Chen Yu <yu.c.chen@intel.com>

thanks,
Chenyu

