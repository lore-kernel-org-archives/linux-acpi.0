Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.20
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793780827;
	b=XCx/Sm4omot17PNLh+QvXlMtIJItvMcJ5Kay3tXzDGnmQTbSUXnFaExzfjfx+lt1FjVz
	 1J92+SFwwzA38vBN3b0gNF3jsgAm2hEAUq36Z/ihD4pnp0bHMU7zBginF38TnXpCCC0Zl
	 bO7PkKNIyvT/hkzqLlVXDBIUdzEiQrrqTFXSskUc8kDVlu1wQGGqedECl67brwNrhA/fj
	 bcQk6JpSqANjU9hWdtssALzgkvjlkzFm1wVjiPiuYlwoxv9hhUGMtZnbskM4TFEoP7jRU
	 iJR90tS5TSHBwXoFpHDvlKKrkys7q6ZM5N9G27TjWbCk3vJTrahcyAKFXL3nnJAkDzA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793780827;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=o0zZkqa4nB1lXKjdOHwA9wyqJQqdvIZiZT1hqEVQ9cs=;
	b=KVXZDiZ6U0RApjOQ4Tr9lg3lbIbkqVyxGSHxDVUYr7ovhK3bV63Kq5AVUHGWWsq6rv7H
	 s5ncEMlIzM8weyGgndIS4dLIvBQakxHMHQ1lEb1NqYbPCmso0//vjxndpnED3iKcIjsII
	 cMwQ+dLreyY9MrHruXS4MxxCOWqKknpYECVpOAmyH+WTKQpERT2FcAXuXIUGFjyDTjJjT
	 N5QoEKMqILRbIBEL+P5zUjmNXbUjig8ZdiivojrRdU5RAARRcTa8yWTKRAJiJkhG7Fjo/
	 HoIp5E7CM84kXDnkBswjqlvXMMG/ZtUYvntk6By1Pn8R0UFOzQrs1HXZE8hYRcTQYDQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="R/AhEco1";
	arc=fail smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F3A606A31B;
	Wed,  4 Nov 2026 08:27:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27F3A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=R/AhEco1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793780825; x=1825316825;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6CsSMrAq0fvxaMBoalEQuTD9CU2zA7LZYkxGW/dfF6A=;
  b=R/AhEco1RqOj5Ao9+rpZwaS4M2jasIOTfL979kKGaIeM44BMZUPI1kUj
   gjzK5fCTFIg26xO2infL7FeWKVBjE5YcA3pITngfoAZcd5kY8c1z/TOM3
   5ktp9voX4pggGtUb1bMHJVtaPkavdeoO/oO8lvggQmqbE8JEMNvfp+PK2
   beXmea65b4XHbft1B7fd8HFUvPhx/zRb6OMzZ1/DPGIE6BQvbyN9ZL8yW
   vNF1avtNwo1enm09v8R57M4ljEAaaVaFTuTc1ElJ2i4tqlnmHD5ap2iAe
   O+G5IAElC1n6T51LCSO3Znt5oM1a2ENQVM5rj69xgScQ5qo31ADsTkiTz
   Q==;
X-CSE-ConnectionGUID: pf6ydq6nS4GLAg6DCckjuw==
X-CSE-MsgGUID: 6dBOo0tNSdiMgEbaaKfGlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2556929"
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="2556929"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 00:27:04 -0800
X-CSE-ConnectionGUID: eoIoyRT9Q/iEAk+FqY0pIA==
X-CSE-MsgGUID: JMRlQdskQtSpxl+QwxJ8Pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="7046604"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 00:27:04 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 00:27:03 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 4 Nov 2026 00:27:03 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.11) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 00:27:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yq1I9Mih07EeqtqVesS3ZUdlyXwmiXQAGInoy+cC7shcJanMa+yqomaDm8j28GIGjGY6gvEv8VieQoriVVsFza74DEHLUGhdWobO+mfFKhY3zTVx/Qf7w9zG9X1or6j3AAUBDKsczurDWfq686AphSqh2K62eX3igkkPLzyjw8gzehYrQhg6v/lwzCzILdpXq7sRMmGA5nQ+s6AN+jTT3K8ZoUDFfBIYHai7j0xhOUSdDrIZiwNIElY4L5r7rrtYAPEtycz79XYlh9N1fRjcawuwZ0x1nWeXwu5tNYlscuyw3RLPnNgJ4pyoB7Cv2+V6i8veHvatnyaAbeg9Ae9paw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0zZkqa4nB1lXKjdOHwA9wyqJQqdvIZiZT1hqEVQ9cs=;
 b=aM7m7s3EHKh67CC4+6UBEcdLxPJ31qwT0eM0CTuKsV7cu10fhCQH5wKuowJoL/D/xeyLkSv7cTKTjBAR8kVAh69MRaHA3xubdReT5SShP38J5en9lFgYIcvenjs6luwUP5s1TCu2tLmpU+4DfHzFy/VYiTGm6nBL4FIugxi/hHfZSnqUA59E89Dj3g1l2oYEmY5Af6qOq/XuBwYfAsSYZj5FPdvtGFRGy1QiErSF6aamm1qRKyqamzclOaDVfGK/Mh0yBJfzV94Xj4mh5HxHxLoDCr0OgHYw8cHzkxSW2LePktmaEnrip77yJfW7A/woTV37ADzXTgQB7mGy30+cSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6974.namprd11.prod.outlook.com (2603:10b6:510:225::16)
 by CH3PR11MB8519.namprd11.prod.outlook.com (2603:10b6:610:1ba::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 08:27:01 +0000
Received: from PH8PR11MB6974.namprd11.prod.outlook.com
 ([fe80::44a4:1ecf:f303:d08f]) by PH8PR11MB6974.namprd11.prod.outlook.com
 ([fe80::44a4:1ecf:f303:d08f%5]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 08:27:01 +0000
Date: Wed, 4 Nov 2026 13:56:50 +0530
From: "Vivekanandan, Balasubramani" <balasubramani.vivekanandan@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Daniel Scally
	<djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>, Bartosz Golaszewski
	<brgl@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael
 J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, "Johan
 Hovold" <johan@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	<linux-acpi@vger.kernel.org>, <driver-core@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] software node: only let the owner release a managed node
Message-ID: <aursSlF3yRXrBPjH@bvivekan-mobl1>
References: <20261102-swnode-only-owner-release-v1-1-ee4c9022a629@oss.qualcomm.com>
 <aurU5Z1CNl87uMrU@bvivekan-mobl1>
 <aurqev-AgiGYo5DT@ashevche-desk.local>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <aurqev-AgiGYo5DT@ashevche-desk.local>
X-ClientProxiedBy: MA5P287CA0147.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d7::9) To PH8PR11MB6974.namprd11.prod.outlook.com
 (2603:10b6:510:225::16)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6974:EE_|CH3PR11MB8519:EE_
X-MS-Office365-Filtering-Correlation-Id: adc2b6f9-2285-48b0-4383-08df3a4d6611
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|11063799006|4143699003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: TZaP/WK0fVjHzBKBYC8djxlrOWYEteWg2h7MK3Fw4xWU24PhbKCLOXp4eoiq5afSGNrnD1j/SrtFIeVBv5sk9gF2ZXxUt1Ejt0wsj6R+yjMaTpGIrhM8TmA/Kx6qpBIQZcKDdp2tuQVO9uVMTsixK2vY4BcNvUZC4d9bbSOLBc2OE6kP5L5PZTxInKRtSd1rkD7zAYQts6W9SGre2/CZSqeo5ZtjFK216sUbqVnLMaQA1BTsBVi6cPXjkUeqK0qlzK+srEWNYdZldPKjks2ggQWIBCfHPkhUhxH9ORraS66wi1cIWFu6xZl8D7UWyODGcpeFETvlRuOY8NQ8PhzUmJcsr5pDDr3jm4k4UFPhkpgss6XDN2IF9EvpeXFXI9N5blkb5k5qf2y11CasKimpG8yxboalPCRSEUVKOKMHAfEHgBW4t5igV8ZEpJuqk89SzEWBhYyT+mcGuUZeuXTdUKw8v1vhnG3hkX/gOu3XABZKybxgjyiPBUAaAFDmVaD8OxauFRxrVUxo7b9rhMMYQfjpLFOvaZuKRCu7XlWKGYyiwKQOafVYNISWzeopQjNU0gE/XLaOHLgKRad/LraTwngzQLe0+eSQ0bu256/I1KGsTtYAKT94h7fEtbgpj2mz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6974.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(11063799006)(4143699003)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWdyOThBdFEySDBSWXVkQ3YwMWJEMUJTZ1VyOWFoM1BMSkxzUTJHajNQQ3h5?=
 =?utf-8?B?WjhSTFpHWk5PZVlpalQvaWtMVFhsd3ZRRGFvUEhLeGhaWXJVYmZSLzRZb0VP?=
 =?utf-8?B?azY2RUtpc2lWNFlobUhscW1ZRmRvc3FPOUJLN0w4V3VHVlh6QjJuK29YWW0y?=
 =?utf-8?B?TW1oOE1ON2pQM3k0VzFxTURadUZ0ZFcwalQyMEpRNVErRVYyNlV4ZytodldI?=
 =?utf-8?B?NFpJZFBLQVd1R2xrNlBZRkR6MDhmc2hTZFErVnVjNmFmcTN3bnZScU9QdlJE?=
 =?utf-8?B?QTJadExZMDB5eUUxVUhJa29uS1o5VWVsWm55ais0NHp5Smd2dTRSakpTNjNW?=
 =?utf-8?B?YktsTVpwcnFzZnFNVEVBR1lra0lGR2oyMUpNZFR2RHM5RzhFdG96eWpudnhB?=
 =?utf-8?B?dm96M1h6cGtXSktKVU9ZekdGQThrNjJBSEp1c204cUQzb09oZ1B4Ukx6WFFL?=
 =?utf-8?B?RzI5NXNzOEdqM1dja2N2MkxtYzF1dTNTSk1md05paGl3WW5WY2NaSFZHZ3VG?=
 =?utf-8?B?THNNQXM2N3pMTVVXYy9QN3VjQTJLcHFXUHdJRGJUS2U1enV5ekpDbDB2YWQ1?=
 =?utf-8?B?N25qTEZUbnpSRDF1VzlzamNwMGpBaVVJSHFJSjFVUnZTZStiNVZOZHJrbWt3?=
 =?utf-8?B?VHNDbHBhTGxUTjluZFdYTVY2U3c5NmJzWlZRQjhlTTl1clQ4ZFZrdlkveEFt?=
 =?utf-8?B?dXA4MXR4NElRbzcvNDBxVnFlRlBjc3oxWmxXcGlHMjFZZERIVVA2U0ZlYmIz?=
 =?utf-8?B?RTFlMUpqcUt5OTFoMGp1WmZLNkhFSzRKQ1U5Rk90dnllMG1oNWh5djFWekhB?=
 =?utf-8?B?ak9SdC9FV3Z5Zjl3enNPcEFDbFdRVVlybnppMXVsRmdqLzBKZkdCSEJSeVRV?=
 =?utf-8?B?WWZqNGU2L1g4Z0gzdmJDYWdRTVFLeW1uQnpROXZiY2MxUHBZVkVrRndKeGhx?=
 =?utf-8?B?TTZzNmp5UXlDeVE4dmVzUGxKM2lYZDErSjVXNHFVTitUaVh3d3VuOUJ5MTRs?=
 =?utf-8?B?MDllK2NaRHlWU2sweFBwR0V0blFXSXZldVhqaytDVitNaXdscnNnOTFGVW1w?=
 =?utf-8?B?emJHZTZBdy8rdXVPcFpLZDlxTkxTVmx4dmRnM09zTXA4R1JQc1NEVVBLZDYv?=
 =?utf-8?B?Znd2ellmMnZ6djJ3Q1lFQkZBQzJmdTBmZHo5Q21FaUhRVm9ZK25qYnJIWE5i?=
 =?utf-8?B?OUllVzJwUmVTQ0ZLTkE3VTlXd0J3THNEVFUrTlFKSWVQSi9UKzhsQ1p1bHNL?=
 =?utf-8?B?OTg5WWhjdUZvVTlNb205bFVrcHJWR0JJcVFGZkVEemRaUTdFWS9QL01mSWpH?=
 =?utf-8?B?VTFXOWVvcEdyc1J4VDZIbVpxRWpHY254d21mUzNoSHdqcjFyMEY1aGxwVVlk?=
 =?utf-8?B?RHQwNW9adytrSDk2WTBHV1YrcTZqNWlMM2dXdXlvcmZidHYwOTQ0dHhTeGYr?=
 =?utf-8?B?SW1peEJ2SHVudTdMU0NEamVOSkhwMlh0QlRlSUoxWFlWMVdwMWx0NEJpeUx2?=
 =?utf-8?B?c1NqZGlBUG9oaUgzL3VEVFdLOVhrTmF6R3JPV0NqWFpuMEI4aEp3MlZxSFhk?=
 =?utf-8?B?eDNKVnk1TGFTK0FFbG42WGI5eG5tSSs1dEN0YzJ0R1NPY0RiL0tyby9QaHoy?=
 =?utf-8?B?YmcwQk1FMlRNcU5QVURpdENzRG9ML0llMTMxYm9WckloYlQzNDU1RWx2RHRV?=
 =?utf-8?B?K05wci9JNU9TekFKc3N6VTcwVzVFZFhZNkhhM0U5elVJdmE0OTdMZGZvZk5p?=
 =?utf-8?B?b2pyLzdRSXl0dDV0UkpjVjhIbVA1ZGlOY2lxMTVZckFiQjBMT3VXYUFaSjY5?=
 =?utf-8?B?ZVFIbUJTcHdGRkloRm1YOERiQUdRc0RWcUpjQTRROEREVEJnbmlRaEExRDJi?=
 =?utf-8?B?SFFaM3BpdWlwYktpbk15WEdTNExwQ0RrL3ZwdUZwdkdLZzN4MG9SbUpQWThm?=
 =?utf-8?B?K2FwQmpLdHVlellwUVpab2hxS0RxL0VVa1dOeWJzVk5aTjVSY3NLbzh0c1Bw?=
 =?utf-8?B?UXZsUWJzbHlUdW9uMS91cGJYZXJGMGFJdjV1Wk1BdHRUVnd5a1h6TlhTcklX?=
 =?utf-8?B?MjdDWklMeEhMU2dhY0JiTmo4aDV0U3BtNWVza1lLVG04WG5DS25vYlZrMFpE?=
 =?utf-8?B?UkY1UGl4bnZhaGVweDJPZGk2RDhmZm5LeFZXY0lyMjJ6aEhQYXJhVStmVGdk?=
 =?utf-8?B?MXhjUjlySjNWNUIxc2ZkNUZneFVjN01WTlZ2RkJCQytWcDQ5aVorOCtzOE9E?=
 =?utf-8?B?a3pLdjNNQTRWbnMvb1FXV29xRSt6UUdad2FKNFlDTXRpWlQzQnVzSFBGQ2Rr?=
 =?utf-8?B?cEt3SDN5dzRFWUxSNXVNcGdoejRwbzg1MkxwSEtPZkJWMVhvbGJHSjVDeXZa?=
 =?utf-8?Q?hUZ0SIe5PIovLqBd7iSJqZQaXVmiW35cudWC3?=
X-Exchange-RoutingPolicyChecked: JFaCoIpo9SFM6e3M5Plk3GLJbUOhsXG1ftHC4gbwIKUdakAQNn6DL9LXT2BdJlv7uRhf42mUC5dwl9Xi9Cs+e2XvrONQMgCLtcf+iAWnK4MlqlD2S31JUKCD2WfS0s32h6YK7V/1OrhEv+WMuVzWp22iRD7CpXHQkwvY99/mn6MRhS1eY497TZcAk7twRlgM14uNTx4zTKmp4m+NnLujIJSqm4zX06CgHk7w0iDBMCxKfe2LRddp4d++Lgcc0OYyIwQmPSe0XZ9aim8FARr+mP95Xh0K49fPqy1E6cDV7Nkb3VCWkLpQN2SE2rHOBk9mi0rN7w3fUaKSN2TUPN1Hgw==
X-MS-Exchange-CrossTenant-Network-Message-Id: adc2b6f9-2285-48b0-4383-08df3a4d6611
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6974.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 08:27:01.0080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /WYNBNUx4HXTTNruIW2/LBoixSqSUEAoRObKxqIFFwTD8KXnVaMpUnUI7D9AbfUfEg2y0Ilvab+dzDNB+XClukdR4TLa+ucbg5JkchHMJw5WCeHwz6w7ieKMLYHlNJQR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8519
X-OriginatorOrg: intel.com

On 04.11.2026 10:19, Andy Shevchenko wrote:
> On Wed, Nov 04, 2026 at 12:17:01PM +0530, Vivekanandan, Balasubramani wrote:
> > On 02.11.2026 16:25, Bartosz Golaszewski wrote:
> 
> ...
> 
> > > Reported-by: Balasubramani Vivekanandan <balasubramani.vivekanandan@intel.com>
> > > Closes: https://lore.kernel.org/all/20261009164241.923756-2-balasubramani.vivekanandan@intel.com/
> 
> > > ---
> > > This is my approach at addressing the bug reported by Vivekanandan
> > > directly in driver core. Please test it if you can.
> > > ---
> 
> > Reviewed-by: Balasubramani Vivekanandan <balasubramani.vivekanandan@intel.com>
> 
> Thanks, would it be possible to test this?

Tested it already. Kernel crash is fixed.

Regards,
Bala

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
