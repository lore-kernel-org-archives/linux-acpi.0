Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A3A397E8E;
	Wed, 12 Aug 2026 18:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786558223; cv=fail; b=hzXNJ8KcLODnpby+K312yYutxFZZTVqgqp3ZkdmXUNmH5BtaJu51R513aQsZZDVUm59UcxgTguNjsKYBbaYdmEQceC+y8GnlsoS4SQs+DEf0+Ya+RlB2ub/dtegKBJazY0CAsDtKigbuSRWvpJB5ScBYhkhWh8I6cRvgODnZhWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786558223; c=relaxed/simple;
	bh=zLxUV1vWelfx/ZlqzLkYVu8iJaKq7KbNEJQ+BXuxoWk=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LmqZp3nLXtG3qOHXJupLqnATwn/Fg5h2O+pq5Iz3QnfWqA17AKvbs3zJguCtZSTrX2fZ+pgDCALkn5nnbBjkwPTgYtgnt+DNN+pFZ/7ykGI00OkJj9XZi65v6YZ1wKRQrKLrZWVq9N56PMYwxKLaCcpN0RLDkg2P/+GT4keRvJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BXNpQg9z; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BXNpQg9z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786558223; x=1818094223;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=zLxUV1vWelfx/ZlqzLkYVu8iJaKq7KbNEJQ+BXuxoWk=;
  b=BXNpQg9zMEtZyNSJOuvC7FZGe7MI3Ho6OCHwkbs9Pa+1JZC3V0cfhf9t
   x645SXmdWzP7XDTd7SdLnP434yqK3djtDq6Kx+Ieu9RM8V1ls1wOmapuV
   QoeTA1VmLhATv6n+a8m6QeuwXau4F14jAjMOg6GTCf1XPKsZxLeKM5ZN5
   LNmCsytrXwkqGWspx7+0a2TrFnC9VDpM5zhcpqgZWxq/JJjTS6swiETL4
   Aic0wCUGFdbkaqev9sU6/tpzxmnJHiqNSor9ngvarcfsPSfA0bC+oShiP
   xky9mYAiG3ZadMhIgiSgNm053m629MqFVnhQN04rz2NLSNSJRtDNkGsbX
   Q==;
X-CSE-ConnectionGUID: /jdNNAuiQv6jhdhgPVkVdw==
X-CSE-MsgGUID: tBr5C6MWQ8+lidky2cdMjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="87137925"
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="87137925"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 11:10:23 -0700
X-CSE-ConnectionGUID: we6s4G1EQCabBZz5BmVi9g==
X-CSE-MsgGUID: cl87Ptg3TqamxEkAVVi45w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="257512341"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 11:10:22 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 11:10:21 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 12 Aug 2026 11:10:21 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.47) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 11:10:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=drZbZmB/zSdFKp37FTtzCe1eu1cOLY2y8JGnI3p5uee4damEEPVQtRZ+8oZgwPNt0Tr4IAhpwoHv4beRoMsZtlRjUzFVeL8wBRJYhsv8C71vZtXjFURwZeePtBmh5TZoIF+L7TgwlcvX+T82WCBHupqX5LnYEmhu7C5s5z3Zi4UgEeGqx2tHLtpfJERBgdVLjOrogIiCMPv9yUm0gAaZzvVPQL2yGD8kS3YTPHJJobZam958meP2zM6dFVLlzwyG7QIaskixIKxPyiGrcGy6eh8kOYTxy+dhKvo/0JUVMqdv/jgCDM3Wfu4SIzX5RJ2uHCehArdsIBYlLy36hCVI8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=whThSop6c1ZY6HYCzrTCuHCywwBjn/t+85iwVBxHTBA=;
 b=nOva0Pp7OAPxrUcjXoIoFzRtQra1XA+aBSoyZ2EXbUGTqzrbToKBbSsN1l9uyJDZY6GeMTlvtLTUqUhHwzfh/TYS95/kZcxpAvyPjuf+gJsYZ1Sh50CVnCiHXxj5yCNQk7J/ON7MPyATNFCPmGTkQ/SGaY0VXPMO2Rnzalw2YKGRt0GC3Gn869CAmVT4oXbTzFhKGoDyLwo4h2fIE+wLPFMSalW8WHayVsmx1ubCddUNPLuTbJkZ83nEsK2pL5w4IVXcHjopCPDxnRYiiltd8uR1WW9ey0Y+ytGLKj9JURbaOcH2yjRAS+XjVaRl1RUltmATNvXLiSvj6hv9jqBkIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by PH7PR11MB5818.namprd11.prod.outlook.com
 (2603:10b6:510:132::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Wed, 12 Aug
 2026 18:10:17 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::ed8b:1455:8b29:144c]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::ed8b:1455:8b29:144c%7]) with mapi id 15.21.0315.012; Wed, 12 Aug 2026
 18:10:16 +0000
Message-ID: <57f89d3a-e2ab-4a79-9bfb-719678671b9a@intel.com>
Date: Wed, 12 Aug 2026 20:10:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: Add ACPI_COMPANION() NULL check in
 topstar_acpi_probe
To: Xueqin Luo <luoxueqin@kylinos.cn>, <herton@canonical.com>,
	<hansg@kernel.org>, <ilpo.jarvinen@linux.intel.com>,
	<platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
References: <20260811022115.338595-1-luoxueqin@kylinos.cn>
Content-Language: en-US
From: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
In-Reply-To: <20260811022115.338595-1-luoxueqin@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0001.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::13) To DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PPF63A6024A9:EE_|PH7PR11MB5818:EE_
X-MS-Office365-Filtering-Correlation-Id: 9189f89b-df97-47d5-9c0a-08def89cf67d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|56012099006|3023799007|11063799006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: V8/frfb3Jny6GcmEl6JyuLmL6WwQLbwMSRDirsZZCDJEu8uJpn7Xkt5JncP8waisrgCKnpL/2Vk2vjtjz0m8AjGPN3EYKOZwpHzK32cxQQP3ELMmYpDwvPvhSeWTfWZ6l5LC0KvPvlpH6q8apKvcr4yfTpWp8FIJy/buBB58DSKitEdnxX1VRq6/iHuIwII99mr87TCXuapdnCK+WQBEECPrK8KYa3pqJzHiv+C9lwEG6mhBbUf59FgQjV1J2xD2HLXJsSjqCuX2gjlXpLyE0IFjd9jTVOKL3ZgAMDLrD2/R93IE8prHRtqQJPaxQqYP+xReIBQY7qUvgECn/EGj2Mlcrc4BTWiiYb1yi1QaUTnUoNqATy1BrwaDKBYRXwT3jl+ZgSLAmhtMTl8LF+FVLHWmfmWPC8rhQsAcqvYyfcKtSRpgsQk62z+R80v3KTGuX/3xbzWvPCOAP+VKX6kl5uHBVYf45l4+IXopVq3Q4yuGwGQRb7KJJAL+H5BuTTCAoIsm1T98oSgC/sPzOrVdVaxMCBZYSrPWOEHEWCRGXjEr0vcVabaFPW0vOD7qvR25kDm6fxOgINDYbuPF5D6PO/CYSEwe0usTmw3lgEiOE/hgYC46Lo6WOpUBzsRClevPKAQDR47h2I/3W/0fhnEAgfCTIVtItEBNeBeF/tzsjpA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF63A6024A9.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(56012099006)(3023799007)(11063799006)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHFJdThucms0WVlrRCtJdUx3WWQ5SlJYMjFGVEhJbVl0WkxxTGY5ajJLRHZh?=
 =?utf-8?B?UjY2dXBURXJVNEQ4N1hlTld0SWt1Qm03UHpYbjN5TlpWTHRkeFhPT0dMdTJx?=
 =?utf-8?B?N3ZxUXFpL2hUSjQveTFKMHIraGpuVlgwZDhNcm5jOWdKUERyUjhLdzc2S3I1?=
 =?utf-8?B?VGJ4dFlsOGJHa29IUzNPaHBCZ1JiV2tJU1lKbmhFRWtvdnlSZG1PQkJSTTFh?=
 =?utf-8?B?ajZ4NUp1bVJoMW1wZ09wZk9tQTZlSnpkd0U4MkIzQ0dBem14RC9UQ3VtSzNu?=
 =?utf-8?B?Rnc2d1lEdmJCcUFTS2RtMVpIWDZOZDZpYVR3SnRTVnNCSVJwNkxjMjNWdDNX?=
 =?utf-8?B?QXdEYng4aDl0aXk1UmdGZ1dIZ3VyRkZTa1dyRjdSSVUzUjhZeXlJRnQzeXg3?=
 =?utf-8?B?ZkpDNTBsam93TUN1bXhnQkFTd1pmSk9JTXRDSGg1QVc0OUZEYXhoVEk4Yzl3?=
 =?utf-8?B?Zmd4aUlHNWREMi9uYS93WWtMdUpmTTRnZUxoRnlZanM0dnluZDl6WEIyYWR3?=
 =?utf-8?B?bWY5c1hJZzFNZUZnUXVqNzZoeGtFYmFMWjJnczRjdUQ0WDMzNTJELy84ZEV2?=
 =?utf-8?B?RVUzY29uUVZrTXBZdzNXN3NHMzJ5N3BzbE0xQXR1b3ZqSXJ0L1JuMmNhekIx?=
 =?utf-8?B?T3BzdTc2KzUrN0g5QXREbmFZYVhoblpSV1hCTlN2Q0JKME9RQ3NmTVM0VW5O?=
 =?utf-8?B?SHppMWsvNVJlby9VUmV5VE5VSE5UUVh3UlNCbGJ2TTE4VTdoT2ZML3l0SjhI?=
 =?utf-8?B?N3BHOGdQd2RaS0R3eUpCS3MzaXAwSGdnTTJ4eHZiTkhRajliM2N2QnI1YWNu?=
 =?utf-8?B?aFFmSmQwdFp3cXA3dVBJbjBkN002Tkx0ZmdCZUJ6VjNNUklNaXhXakMva2VF?=
 =?utf-8?B?L00ySXhoUCtOY2YvUW5MTHhHNHg3VHZhY09paGVXOWRQZFpiM3hTNzVGYith?=
 =?utf-8?B?SmNTOVpiaU1iNzZHQi9JMjNBRHNncnRZaHBKTTM5TzZ3aHh5YjBBa2w4Qk85?=
 =?utf-8?B?MGlla0cvRFY3UFZGTy9qaW5oY3JwVmljL2xBb3ArM2FjN0UyMGU0SVNhVE5D?=
 =?utf-8?B?aWZxZU1VMnhhZ2JFYXM3M29KRmtISDVGOE9KOTUwckQvcVhLc2RiL2hGUUd2?=
 =?utf-8?B?eXZNbHpyUE4zdkVEeHh2QjUwMHAyaEEvWmlmTmdZSU90b1pLK0ljZ01nRDI0?=
 =?utf-8?B?Y05pQkhDdG9ZSlNETnBSeDFXdEdUZ3dJaGNiZmNTOGFmN2hzYmhKMGlyZXJu?=
 =?utf-8?B?UjhFMGRVWlZnRlhvSjNIcWxiVk1Tb1BodFQ0OU9VekhmUDFSMHVqREsyVm1x?=
 =?utf-8?B?MWtHaXZ0VHlFa0gwOTNWdVBXOTdJWUxzUGJJYUxVYUwybjNQZS9lb3JiVU5L?=
 =?utf-8?B?YmpNKzNLSnFGWXdESlNNcDM2Rm5vWkpGN3BYeVYxTXE1a0tFZFltVlphSW9L?=
 =?utf-8?B?NlpQV2orSGp6aXBwZnFmbFp2Q1V2eXF4cDd4MS9ncnBleVNER1ZJeWFrbzZq?=
 =?utf-8?B?cVF6VEdXQ2RGSFVHN2R1Rm9rZnlTci9kTzBwTmdZOXBDOXprYVYwNEhoWUUw?=
 =?utf-8?B?cHhNUkVCZ3ZVSWEwQjg4cUVEYWQyN1hGVzBpajkwRXI5ZFYvZDQ5THV0UmdW?=
 =?utf-8?B?QUJObTVOenpRQnJIVUk1QXNzS094Z0Y3M21KTGJ0cWYzT25vOFNxNkx0VzY5?=
 =?utf-8?B?TDFkTzJJbXhvT291cjgwUDJQMW1RS0kwRGZrdVY2enRHUlB1RE9UM3QzdnJv?=
 =?utf-8?B?SWpsT0kyMmJ2cHRGb3ZMUyt4eE9GTnBob2RFb25aNGVTSHdYaXJlenA1UUlS?=
 =?utf-8?B?bW5Id09wUHFvdlIxUlhodHdFRTFSaTVtdnhQMlg5bVZ6YVhuVGtrNTNSS2RB?=
 =?utf-8?B?Sm1BWXRaS0tZaW1yT2xRUFdPTjZtd1VlbXVyVEVYbjdGK09VaEdqQXNVQVFi?=
 =?utf-8?B?RDFIM0NLZzRyYVdOMEt1T1dYcCtVQjhLU3RJTmRqZUs2VG5oRW10c0lGUG12?=
 =?utf-8?B?ZnE3RUw5STZUblZzZzBNaG5NMnU3dTlZMzY2T2FJL0tPUXVuUytpRlc1M1BT?=
 =?utf-8?B?OUhEeU5FZkZ4azlBQkplbEFkbldzbUtkQ3ZnOTR6N05nbVUyWEh6a1NXam1B?=
 =?utf-8?B?ZXAzN3ltK3l3ZGN3RFpyUzNLL1VJTkdrTk1pOER4cFRRbHNDZHp0VDQwT1lE?=
 =?utf-8?B?THpDbEh3czJoVXByQ2RuL0lvWGNRNHhRS0k2b2FBTmRyZkd2Y1Q3Ukg4V3pn?=
 =?utf-8?B?QkNBVGFwZHd4MWdkYk9xbWxBR3FJb1RrL2tBc3B6MGJoeXBkVEZod1JFTnln?=
 =?utf-8?B?OWIvaFF0dzJObWtRMUpNaWRYWXl1U2FXbkh5eFNVUVNRRjJBeGsrME50QXVm?=
 =?utf-8?Q?h32I+4hj1jzns9Lg=3D?=
X-Exchange-RoutingPolicyChecked: r/Jmoh/x5PVFU7qOH7WXsp8dVAuIKeXxvMRKkaV0Ck7lMdNj4CkPoLanUCbvRnceRZpTC1x80OHZKdLJD50Owxq2/7IWSTECzAH9hiG8+40vid2nTsUcKxQM5EHPsjAll5pjGx2zpW8jwEiWSP0roWmKtncIYWlSJZKCEpuq9cljb4/OHFL6Q20WLiuQa680FYZECnosBlZldknm0BdQogL7jQePJoBU2g3myjQ7w1N3a25i/UpppbisCI8TfKxdMyK+Ydd90b7sVo0xI3760uYCc545GB1prvXAvaonhl06rP7q4w86T1C5tWoQPe/O3h1GfpljANE4ib5/evEjCQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9189f89b-df97-47d5-9c0a-08def89cf67d
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF63A6024A9.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 18:10:16.8335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +lTeAe1x7YK1oxQFOx8Kg4TwMZvTT2LoyUaqvpx1RgKxCEqHKC0RNo8i9FXgfpoE5bR5Lsi1uBRqTBUJw79jaTVpw0w0JUkwTHUt02IZH8Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5818
X-OriginatorOrg: intel.com


On 8/11/2026 4:21 AM, Xueqin Luo wrote:
> Add NULL check for ACPI_COMPANION() in topstar_acpi_probe() to prevent
> NULL pointer dereference when driver_override matches a device without
> ACPI companion.
>
> Fixes: 3471415c8186 ("platform/x86: topstar-laptop: Convert ACPI driver to a platform one")
> Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>

I'm not sure why I haven't sent a patch to address this, so

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>


> ---
>   drivers/platform/x86/topstar-laptop.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/platform/x86/topstar-laptop.c b/drivers/platform/x86/topstar-laptop.c
> index 0e842c55dcc5..730a599abf0f 100644
> --- a/drivers/platform/x86/topstar-laptop.c
> +++ b/drivers/platform/x86/topstar-laptop.c
> @@ -287,10 +287,14 @@ static const struct dmi_system_id topstar_dmi_ids[] = {
>   
>   static int topstar_acpi_probe(struct platform_device *pdev)
>   {
> -	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
> +	struct acpi_device *device;
>   	struct topstar_laptop *topstar;
>   	int err;
>   
> +	device = ACPI_COMPANION(&pdev->dev);
> +	if (!device)
> +		return -ENODEV;
> +
>   	dmi_check_system(topstar_dmi_ids);
>   
>   	topstar = kzalloc_obj(struct topstar_laptop);
