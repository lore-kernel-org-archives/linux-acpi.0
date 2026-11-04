Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793774848;
	b=E44ZREs6X0aKU2E4WnOmgE5+s5PrfgqoTnwtwyfJqqnasZwQ/RoIBXH/YtItfKTrW5g1
	 ojE7rZmwu57WiSYowYh9sVxRsw4RtNRbU+6d3CahHEYpIjrqYnThVo/VDQ/pq7pe9gg7v
	 Lir5mffP18DMHYl/Gl7Vz4GODFOoNgZO4GUSRX5HQ7mo7c2zHimG38xOWnK4uL7+8o1aa
	 vDKkxZyQlscnmHtOWpO4UMasGdi4cCeBi5O94x1UPXSF8/KU6geko3XGPNBUJe+/bvcnl
	 8/lxvzPWdL42d9Bvc4qml5gkE+P9PkodnXdvMSBb7NQoCHZQKnVNEkDF0sp7f7N251g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793774848;
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
	bh=GRCO+vs63OLzR/MNe+FB/Gagy2NFjkhfpTfJAT2A2Y0=;
	b=LYyDjRQ0NBb+cg1Te7oDwX73XnCjVVmKtnUGFRxC0SjpI6EUXpDVhFswYFa03Vwcywqb
	 Rb/sA3G/UTKMR55lUZoS4SeapmyhMJZU7TqmrzHebDM0UGiPMc2CRW/r7PaabhKVRjfsk
	 pZQeiqt6INM8ZUBmZWr58q5Q9xNO2alocVHgCz6avjyOS6jjJ4IR5kor7/fBHP08BWCkf
	 AsAaREMrhclYuQZY0Q7neDVxHsZvcAtMGp9aarNTswZerKV62Agdhmxne71u3Gpo0pwfL
	 2I1rnwjFZQC4l7E2RMUrT3cdnym8bSD6V7RiTXbbNx/BcOzKtaD6KdsDTHV2xoMfrpQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aNkVsQry;
	arc=fail smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C2E606A328;
	Wed,  4 Nov 2026 06:47:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5C2E606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aNkVsQry
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793774847; x=1825310847;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Th8Wh5JHTVdSx7jXYhrafcyDm2rhR144JEieZBdOwRc=;
  b=aNkVsQryTdI7ia6PqWzfJHkF1myp7w6lo5SPcBmI+TPQHU50Swn9dYU7
   T7oV9YI8vj27ghmoUwdkOcPVKDYOE04MCCfJJPNWC/EYGYlQQy9+LrcYo
   HEFbW+NxBBVvFroQ49TdeWK+T6626Zq2Wjdf2ef8m3SLfthJJ0fgZpMZL
   iG7KUTV/PmNzGRDDvCXkeHdJRzIMm4uysLNbZe1/ZFibPqsGEPYOOKW4+
   c789PujWllkiiYYN1iXFC+WmNiypAAtkDQbdWTcfi5DocHWDefmJJxAS+
   K+kue07DkP5ZEav4iO5BfIn2JYDBQDiKLh38ENnZOdM1B6t3aJHl+fBAk
   Q==;
X-CSE-ConnectionGUID: 2ENfuwGFTP28arIxwX3JaA==
X-CSE-MsgGUID: CJY6f1z7QwilV1v2u9blVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2531503"
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="2531503"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 22:47:20 -0800
X-CSE-ConnectionGUID: 05qvr+CQSoOL3r0N/VBVGQ==
X-CSE-MsgGUID: sQm2nLQzSeOTjr8TbvMPlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="8512611"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 22:47:20 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 22:47:19 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 3 Nov 2026 22:47:19 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.40) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 22:47:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f3NU2f3JKneBrPKFrvQHBkl+UXnsKS82780Y5Jy9p/bTT+ucRJ7DNOLB+tAfGusP1svgeRKPEj+5ekI+hJQmTdopDTbL0s8jzcjWsdMlqGT9QwP0eNq7+910g27mnmZURNssMomuWRM8I0H4lClpZ0Yv1SCfXL3fkGpctk2aTybsOzAboJwxMsgt8a/8nKuu5l6MstZXxd7FVyRmYuRy6Zs4FpkCuljoBFrEMyxg9j+Jak/0AYffKXjYPj+tmsacNQJnBPlHObLdWAbLTG9qpvz1q4mUyRw65Zwhs6S5mDwjBjujDeB6Xbd2Xx0xiBpE8y/87JdQJ+bywsab1V9r3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GRCO+vs63OLzR/MNe+FB/Gagy2NFjkhfpTfJAT2A2Y0=;
 b=D9TXNXTj3bOYq9k7U8YJjmxtibMeJ3SJp+zBmogBcpgPOhiiCVQS/Qn+yAbBgTfTbFAoXDwz2SQ1GUhBHcEApehI9JOShNsiycXj4tPAmJF7Nf+4VkosK0eQ3dstJR5eVbNlIsnqoif0zWT5JwEfwgQ/PSSTN2CmcnPDFseRXugq1UKBZ7xuMqReNcMvcAy+rPziH9XU68/cFIvu/dr04M5TvTFouK5TaXyCgLrlbi7yELG41aHh0jyE71pcbtrN7qyDkFbaPOtPRrKJaFeWJAo5UJJO6opTxgvDiYwzWTJM0AWfPuFlw9aG44Hvk77hK9UiEJlxXeG4xIMsoRDSZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6974.namprd11.prod.outlook.com (2603:10b6:510:225::16)
 by SA3PR11MB8022.namprd11.prod.outlook.com (2603:10b6:806:2fe::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Wed, 4 Nov
 2026 06:47:12 +0000
Received: from PH8PR11MB6974.namprd11.prod.outlook.com
 ([fe80::44a4:1ecf:f303:d08f]) by PH8PR11MB6974.namprd11.prod.outlook.com
 ([fe80::44a4:1ecf:f303:d08f%5]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 06:47:11 +0000
Date: Wed, 4 Nov 2026 12:17:01 +0530
From: "Vivekanandan, Balasubramani" <balasubramani.vivekanandan@intel.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>, Daniel Scally
	<djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>, Bartosz Golaszewski
	<brgl@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael
 J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, "Johan
 Hovold" <johan@kernel.org>
CC: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	<linux-acpi@vger.kernel.org>, <driver-core@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] software node: only let the owner release a managed node
Message-ID: <aurU5Z1CNl87uMrU@bvivekan-mobl1>
References: <20261102-swnode-only-owner-release-v1-1-ee4c9022a629@oss.qualcomm.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20261102-swnode-only-owner-release-v1-1-ee4c9022a629@oss.qualcomm.com>
X-ClientProxiedBy: MA5P287CA0240.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b1::6) To PH8PR11MB6974.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PH8PR11MB6974:EE_|SA3PR11MB8022:EE_
X-MS-Office365-Filtering-Correlation-Id: 326c0996-f853-44a7-ddab-08df3a3f740c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|261021121427099003|261021123027099003|261009223027099003|921020|261026121527099003|11063799006|260925022911599003|260925021911599003|260925021311599003|18002099003|22082099003|261102123227099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: t8TaYPSLMmMOdD2NE+1ivRQjN7GpCeOQZWN/iIM2UttwXbQ9BLpQUnkbEoz/XpLhDAgoJ9g02tfBrZ14TTY3TpkOr3+vgOooQ1lJscUxdqaWb6/LrF0X6ywUs+xlUA3rf41pFIIJjQBpcRnK4vciXn2d8yNAYxWF8u20SsYxE+1z+qwSksFPVxgKhyPRpK8/BsRySgssKQxVoZuATNHMwK9v9mfSOnb/cIdiD2qicqUzXv1p32jJw3QZYVjmKu90oAhZ+NCx2OV1qRDliF+MRlV/577wGj+vzC9nfootHFjN3Bx7M8BqoNrDy0FBTQMKXXjoIUhM7QHuI5PSYF9iGmIiAV6b7sp8bL8Unvqcx/0JqOeVElIsZNltF0JZdh/4cxp54Teqe46u7vpa2B5S5PSTo/r/LWpE/g9Ip/MkM922voTBpHUJ/zSzPIrtGFq+JuMY+8/IaKCH6gqov3ExACAWway1e29W3D8JmxTrvC+2S+mA9K/qKGAj+UvsPgXW8gq7e5P1KUwyA+zdEZnbmblrVcYwMJ1MJe7lJvJn0IMmoTNvoCtnmgJE/82BUdo0rsIUePtVv+8EgRGmNWA0ozERQ5XEuiIkahVvWSHngu9+YpDS8vLm20kBGyDVgQWin4l/A+OWZYyw/haWCYlUbIcBO56U4CuPzcDJFCi33aY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6974.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(261021121427099003)(261021123027099003)(261009223027099003)(921020)(261026121527099003)(11063799006)(260925022911599003)(260925021911599003)(260925021311599003)(18002099003)(22082099003)(261102123227099003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajAwbTBtNnFHUWhDaWVIa0xNRk5HaTFOQ2xCaTZOVUR5eUYyQkowelhYcWo0?=
 =?utf-8?B?RmRwajZNNlJQcS9EaGFHYzN2Z0lrdHI3ajA4WkM0cXRsWU1ub0N4VzFDcFF2?=
 =?utf-8?B?dTdGTkFXM2NKdnUrbDFnSTdlUVM4MjFvdXdWZVYyZ0xKSkVKb215WFhnaGVL?=
 =?utf-8?B?WlU1RjkwalhMbGFaUC94em9ycjZhUElSWnU1dVNtM3k3Y3U2SDhPc2hHRXl5?=
 =?utf-8?B?ODV0UkE5WEc2cEtJMHF4K0I4ejRIK2ZJVDg4dzJnT2JtSStrU0hIa2hONm5C?=
 =?utf-8?B?d3FEY0Jrb24vRFBqTWVzd200eGp5ck1pM2xCeVlWbzJQelpMckFCNENFYkNi?=
 =?utf-8?B?dHlVbFo0dVUyelNtY0ljU3dQM1BzMit2eXJlaG91NHFycTJ6SXBRVStaT3g0?=
 =?utf-8?B?aE43THNxTzE5NW5RdzhTODlIK3BrUjFac2dEQkNaVmorazBTcTNDN2FjY2tv?=
 =?utf-8?B?OTZhYVRHaXR6S0tRMWUyaEF2RWszUVRPUnRoRlB6dHhuN2RKQnZEVkxyQUxI?=
 =?utf-8?B?VEwxMlpCdW02Mjdmb1NOQU9XUTR2SDE4YkphVEtPaldPYTJTUWlTQTZVRjJG?=
 =?utf-8?B?Zk1paW9FL2JFU2phOHpkSmRRUkt4dWVCaUR4S095aWlVekJhYU8reEN0TFk4?=
 =?utf-8?B?Wnc2TnBQTkpjK3F2ZGRHbHNzdDgwRkp2STZhMU9JUTNkaisvekwrNTIvRk1x?=
 =?utf-8?B?cmRoTUxRZmNMeVU2ME9XTHRCbEd1WUFHc0FZSzRNT0Y4RS8rakQ1eTh2Q25B?=
 =?utf-8?B?c1N6bGFQZGRrRDgxcWxaSGZvVnZiQWFPMEZaUXNPeXpxT2tlTE9SZ2hTOTBG?=
 =?utf-8?B?bFJpbmRSWDhkYk9GbFJMbUR4TmZpUndMcDczaERTQ1dGZnh6eDdhdGZScWYv?=
 =?utf-8?B?Mkk2Yk00OHNJdC8vaUxLUEVOQ1ZIREhLYXNPTnVwWEhRSnFrbEdLaUtSTmlF?=
 =?utf-8?B?bHVjd01NVzRjNlRwVElENnVJRHlLNXFLdWgyamQ0eHl5eDZGdkNabXkxRkho?=
 =?utf-8?B?UW5ybFRJaktobVJsV0VseS95UWxDWnVJZk0zM3Vzcm9XRnpOQzArQnZoUllM?=
 =?utf-8?B?cW1IQ2l0WmR5S01QbkdxNkNJRnlUZy9UajdnVFZWbHRwRjREY3BiWndTcTds?=
 =?utf-8?B?d0c4TU0zUk5TZDJnM09ja3JjSzJ2Ymh2ZHZwNTEwVGxaV3dIWWhNVW50RDFY?=
 =?utf-8?B?Qlo0YTJ4bU9XVWgxT2tlUGFCU3B6Mkt3UU5UMkpNQkVIQ2lvcjVjVkpkdCtT?=
 =?utf-8?B?UGRtTEp2RUdRT3dRdGVOTUlYL29JcUNha1hOaXhoYXhrWCtWQVJCeXVmTEVH?=
 =?utf-8?B?M1ZDa2lncVNYWlhnSjZ1akZ0SU5vRUxTcUc3VDYyVHNWV2w0UXRqOGJtL1pT?=
 =?utf-8?B?RHIveWZlbU5tcWpDTkErcWpxUlFRUm1BaFpqb1VYOWRnSkM3S3MxWHF2TFMy?=
 =?utf-8?B?RXJITktDaGJwcG5KU3ZrOE1qRHZUbFhuRGVkdE8wODVNazNGdEl0bWYxaUFF?=
 =?utf-8?B?YklUSW5sSXY5Z2RHOVljK25TaUdNL2d2WUtuUDRYSWViOWIzdVhaRHhSQ3ZS?=
 =?utf-8?B?emlLWHJtM2hFbjNqR1JRR2VwajhjM3FRMmpzc0NETjYvZUJ5MGRhZ3dISjJX?=
 =?utf-8?B?d25FNlJXeFo3OVdNU0hTYVdGQTZwRDBTSDhzeUxkakF0QVdGRm5wV2JSUlRy?=
 =?utf-8?B?aFBHMVVzeEZvRU1CQnQrdTNkN0I2aENkNUo3WHR5aUphRWJRanZwMVBpOHVt?=
 =?utf-8?B?ellUTzB2MkNpc2JwRkQ5VmVtRkNkZmowWE5xRlJVOWkyVWd5WkFXUkR5a0dI?=
 =?utf-8?B?V1J4RHh3bktFaGtTMFpTNEoyR0NFd2Y4aWcvbG8weTZJMEt1NGJZOXhZbXVu?=
 =?utf-8?B?WENodWpnY0dzRWc1NldFYiswVFB4dXZ5RjBIaXVLYlIvZzZGNVlmY3NyUGRq?=
 =?utf-8?B?UDNBbXV4QUhja1RER2ttZWhDdW9kS0tQMUVOQzZmbE1JTks0Sk5IMlljZVp6?=
 =?utf-8?B?NXZvRUQ5NTN5S3ZQdlAvaE5nVTYxWHFsb2VtOUtSS0VxMHJnOWpFYS9WSS9a?=
 =?utf-8?B?WDE1bzJvejRnbDBuSUtSWCtEQ0JoNTZHTko1dHFrY1Uybi9UbkQvR2txMnkx?=
 =?utf-8?B?UElwWUN1Z3VvWHBaUVAyZThQajA3ZTh5d3ZDa2Jkb1RUaTBuMWhvTnExaVZo?=
 =?utf-8?B?L0Y3UHQ1a2RGTDhVU2x0RVlxTjQ1djh2ZmZyajBSQkp1ZWs5aFBQLzlwVFIz?=
 =?utf-8?B?SjJVdzh1ZHJ1WHNPYkRVYklFNGs2Q0xKNjVibFRvdm4zTkwxclNtTC8renVu?=
 =?utf-8?B?MkpGN0pCMUdVeWxqdTRNWHRGQ1NXdXlWYlhBc0RNSGZSREROKzJzTFZodmxx?=
 =?utf-8?Q?9gew1cOSHixrf9r5ndEdlPx9FjmwRRpmVYkUR?=
X-Exchange-RoutingPolicyChecked: Cr53cY1b5DIMSCFz7qcztIRlneaDphk1zAHCvh+XUSp0UKoK6OmSrBC8UKM+0FJCkSQqqaqkMem6bEUEZPIZNRotE05DS1fjolEhnU9UAKKQA80/XU6U+lTK5c4F2xAczoNL2EPjfR0pl0HoG5VWPp7edjO0tKuK6Dd6skSQdy3kQsN6JmMGfUwvXnkNmwhGcL31gcKgOtRwrg1fVhUu99TyFNkswjJA2fLwVEO46uGm/mRZfMffQnim1229WlmGI2r5WshRqzrzvELOFVtdsJHYsGu/i3yDFOlp5EolRp+0qDBIy5sciV5GEYtuzhNKL0mxW8fq7VC/VWuDavdmSA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 326c0996-f853-44a7-ddab-08df3a3f740c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6974.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 06:47:11.5287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BCfGLs6x025SM/c8QKSX1knhS1PztRxKJ3p8NQjbU6Lc7GiIm67Hk2MRlCoS1VgF6JDaRKMWlOXP4a6KbW3GXnozp5Cxxid9WtplTeAb3OCtTju7lrfrYSItZq5YTkNP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8022
X-OriginatorOrg: intel.com

On 02.11.2026 16:25, Bartosz Golaszewski wrote:
> device_create_managed_software_node() creates a node whose lifetime is
> tied to the device it was created for. software_node_notify_remove() is
> called for every device that has the node as its fwnode (primary OR
> secondary) and, if the node is managed, unconditionally detaches it from
> that device and drops the creation reference.
> 
> This breaks when the node is shared with another device. Example: the
> i2c-designware copies the parent's fwnode to the adapter's struct device.
> When the adapter is deleted, it releases the reference that belongs to
> the owner and the latter ends up with a dangling pointer.
> 
> Record the device's "manager" and only perform the actual release when
> notify is called for that "owner" device.
> 
> Reported-by: Balasubramani Vivekanandan <balasubramani.vivekanandan@intel.com>
> Closes: https://lore.kernel.org/all/20261009164241.923756-2-balasubramani.vivekanandan@intel.com/
> Fixes: 151f6ff78cdf ("software node: Provide replacement for device_add_properties()")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
> Hi!
> 
> This is my approach at addressing the bug reported by Vivekanandan
> directly in driver core. Please test it if you can.
> 
> Thanks,
> Bartosz
> ---
>  drivers/base/swnode.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)

Do you want to update the comment above
device_create_managed_software_node() which says reusing or sharing of
software nodes created by the function is restricted?

Reviewed-by: Balasubramani Vivekanandan <balasubramani.vivekanandan@intel.com>

Regards,
Bala

> 
> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> index 84a77ffa3dc4bbcca62bbe67c3390693500b01ea..abb6d6d59d59cb4e605fc31cc7e89f92e9f900a6 100644
> --- a/drivers/base/swnode.c
> +++ b/drivers/base/swnode.c
> @@ -29,6 +29,8 @@ struct swnode {
>  	struct fwnode_handle fwnode;
>  	const struct software_node *node;
>  	int id;
> +	/* Device the managed node's lifetime is tied to. */
> +	struct device *owner;
>  
>  	/* hierarchy */
>  	struct ida child_ids;
> @@ -37,7 +39,6 @@ struct swnode {
>  	struct swnode *parent;
>  
>  	unsigned int allocated:1;
> -	unsigned int managed:1;
>  };
>  
>  static DEFINE_IDA(swnode_root_ids);
> @@ -1145,7 +1146,7 @@ int device_create_managed_software_node(struct device *dev,
>  	if (IS_ERR(fwnode))
>  		return PTR_ERR(fwnode);
>  
> -	to_swnode(fwnode)->managed = true;
> +	to_swnode(fwnode)->owner = dev;
>  	set_secondary_fwnode(dev, fwnode);
>  
>  	if (device_is_registered(dev))
> @@ -1190,6 +1191,7 @@ void software_node_notify(struct device *dev)
>  void software_node_notify_remove(struct device *dev)
>  {
>  	struct swnode *swnode;
> +	bool is_owner;
>  
>  	swnode = dev_to_swnode(dev);
>  	if (!swnode)
> @@ -1206,9 +1208,13 @@ void software_node_notify_remove(struct device *dev)
>  	if (!device_match_fwnode(dev, &swnode->fwnode) && swnode->fwnode.dev == dev)
>  		swnode->fwnode.dev = NULL;
>  
> +	is_owner = swnode->owner && swnode->owner == dev;
> +	if (is_owner)
> +		swnode->owner = NULL;
> +
>  	swnode_put(swnode);
>  
> -	if (swnode->managed) {
> +	if (is_owner) {
>  		set_secondary_fwnode(dev, NULL);
>  		swnode_put(swnode);
>  	}
> 
> ---
> base-commit: 7649ba73f9e7e1e04d0b46213e39c79ae09dd55c
> change-id: 20261102-swnode-only-owner-release-45efdc7123e1
> 
> Best regards,
> -- 
> Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> 
