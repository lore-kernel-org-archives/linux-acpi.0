Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F372EE262;
	Thu, 30 Apr 2026 23:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777591219; cv=fail; b=agCPwdOJOCyDX/wSWnF7AFCWnfEjjZzZ80mZmIoPTZWzMGzICLm+IfwAFyeqPUKDFvMrE3oF7RQIIUzK+w/BSnEmlKDsJjavDowi9nOCrPlTje3ep43TxuBP7ElYaWTry2qbKpFaw3g2vKOVtW95jC+Nd/Bi0oSWjbYU1kqJUeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777591219; c=relaxed/simple;
	bh=7wXWVDQ9N7i6TchEUySVJgN4TH/zyGscC9NQWEmhrf8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fEUHV9XXbKI/4KaSqQDcDkyY1/CYykMLnbVOkZpwcOKPyDrhwLobbdfFHHTGLUYrOI2+ZBWalT+lXgBShdW3m9EgWDWnczl4dcseI+sincN+I53RHkekbKJi8jQVls8URnNt+4ZDdaKzxQzhPckF1U6eYvjGVKwa/l1qbmqUXsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mFryQYq9; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mFryQYq9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777591218; x=1809127218;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7wXWVDQ9N7i6TchEUySVJgN4TH/zyGscC9NQWEmhrf8=;
  b=mFryQYq9rzyQQLv5CDE8rqsI+kH6/bWyAaoorQ0ULFC7ossxYbyvNhvb
   RGO58B/QEp+R7C08A4QRCKXd0uIvoq7QRlNH0lErIbZOvtnAk7u4yl3Dc
   sJqihsLKTzD10pvmvq+GIwuIBQWjFT0+FxHUVKy6WCybQfuZBhMxmJMxZ
   FtbczNc1Bn9BgT65GNsl3tyl02GmtIvam9wP/khSNSgdO6L/LeuYc88qv
   qB+z5mXEkb6hIk0qqk1nal/10pDop71T/qEj65n7N7G70nI0pgqOVNdv2
   2G+C7VbgiZAIB88gZ+npY0M00yXo9MPUA7bGyJWx2TuCOHJdkcYn79atU
   Q==;
X-CSE-ConnectionGUID: OjpcwLdNQcGu66O+oXbd8A==
X-CSE-MsgGUID: Amg34R8wTTeX6+uvqksV+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11772"; a="82415849"
X-IronPort-AV: E=Sophos;i="6.23,209,1770624000"; 
   d="scan'208";a="82415849"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 16:20:17 -0700
X-CSE-ConnectionGUID: YjHtSRwgSTOXsPgAudL/RQ==
X-CSE-MsgGUID: vxhOFYYeRkum2Ut1BgQkjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,209,1770624000"; 
   d="scan'208";a="230117894"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 16:20:16 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 30 Apr 2026 16:20:16 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 30 Apr 2026 16:20:16 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.24) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 30 Apr 2026 16:20:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HiCdVSr8qabYQgjJBYKLym/TiYTHS2H+O8ShDi3Vjo5Xum/g/3YVprTxvhRSVdbTBmXBBnLscWkAQS6RQaMeXlZeariZcw3RGNUm1/43s4MASh+s6zcatP2e4tKO7fAIZ36xpoYAZ+5ftmxjNfzYxVsjii3Kvar6bbWEkyjPqIzlLqhzi/n2pno1UpZ2MUJsXJosPI9hBbAXJYBVehhN73H1+Lmya8MqmPIj+b9kixzJM2MqndIOGGB/h1w5AnBk6oVyo9oWJp7Il+FULD6c/x0B6ezzBcnlF2TQ6+1Fa+i8hZNKF6vK0iiGCmTaXpuEdu9M59GzgNo9LpaynJ5czg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vhHQJkuZBx2SWLWAMBfI3BT7aJc78bmkjRiFtFBK2lI=;
 b=NAbOUtenlZopSWo3bCs8XVNnYjBqq3qtEPsUjD7F8r8ITC2cCPDJNDF2oPJOULM7G4PINpu/vVGpxHP4sjlh2TwuPIBCQl86mOKmysTlmThXRnF3hLL9nGDM7sLYOFSnlC1E//n86pganGaOHpCtnPBTitQ1ydgq8q0CjZOiDwLcm6uQSRFOlADQ7GeiobJqESE9nbk4Tj7jOJFXQ6rRAb0itCvjtOCjiMCQ3yAEJrVuGvVi1MUMU35xYfDng/khP4Bwz97IyCjCES/ZQdTIPcuaXRWK2PiFFqKP88w2uDIo4LURBbsQMCIdq6qHs+ZpfrJFGsWZRNw5B4MuAytj1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW3PR11MB4651.namprd11.prod.outlook.com (2603:10b6:303:2c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.22; Thu, 30 Apr
 2026 23:20:13 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bfe:4ce1:556:4a9d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bfe:4ce1:556:4a9d%5]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 23:20:13 +0000
Message-ID: <9a8860a5-f63f-497c-ade9-6f64286abff0@intel.com>
Date: Thu, 30 Apr 2026 16:20:09 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 06/11] RISC-V: QoS: add resctrl setup and domain
 management
To: Drew Fustini <fustini@kernel.org>, Paul Walmsley <pjw@kernel.org>, "Palmer
 Dabbelt" <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, "Alexandre
 Ghiti" <alex@ghiti.fr>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?=
	<rkrcmar@ventanamicro.com>, Samuel Holland <samuel.holland@sifive.com>,
	Adrien Ricciardi <aricciardi@baylibre.com>, Nicolas Pitre
	<npitre@baylibre.com>, =?UTF-8?Q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>,
	Atish Patra <atish.patra@linux.dev>, Atish Kumar Patra <atishp@rivosinc.com>,
	Vasudevan Srinivasan <vasu@rivosinc.com>, Ved Shanbhogue <ved@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>, yunhui cui
	<cuiyunhui@bytedance.com>, Chen Pei <cp0613@linux.alibaba.com>, Liu Zhiwei
	<zhiwei_liu@linux.alibaba.com>, Weiwei Li <liwei1518@gmail.com>,
	<guo.wenjia23@zte.com.cn>, Gong Shuai <gong.shuai@sanechips.com.cn>, "Gong
 Shuai" <gsh517@gmail.com>, <liu.qingtao2@zte.com.cn>, Tony Luck
	<tony.luck@intel.com>, Babu Moger <babu.moger@amd.com>, Peter Newman
	<peternewman@google.com>, Fenghua Yu <fenghua.yu@intel.com>, James Morse
	<james.morse@arm.com>, Ben Horgan <ben.horgan@arm.com>, Dave Martin
	<Dave.Martin@arm.com>, Rob Herring <robh@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Robert Moore
	<robert.moore@intel.com>, Sunil V L <sunilvl@ventanamicro.com>
CC: <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<x86@kernel.org>, <linux-acpi@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>, <devicetree@vger.kernel.org>, Paul Walmsley
	<paul.walmsley@sifive.com>
References: <20260414-ssqosid-cbqri-rqsc-v7-0-v3-0-b3b2e7e9847a@kernel.org>
 <20260414-ssqosid-cbqri-rqsc-v7-0-v3-6-b3b2e7e9847a@kernel.org>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20260414-ssqosid-cbqri-rqsc-v7-0-v3-6-b3b2e7e9847a@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0088.namprd04.prod.outlook.com
 (2603:10b6:303:6b::33) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW3PR11MB4651:EE_
X-MS-Office365-Filtering-Correlation-Id: dc8037e6-392d-4583-dfdc-08dea70f07a3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|22082099003|18002099003|56012099003|921020;
X-Microsoft-Antispam-Message-Info: 88aXl1goIFttfd7WUi76pLIiEl77ZdXXDmuZAPIAbb3GBZ2d/K6mWqrVPUGlH9woHBYaIl8EF10ztgKAWJ6Elcsd1sXV5EHMrl5lnpltht9NW2K36czywqbW8injpTPBrInvFtQZkOQnAPix8GVwpB6l4p1eAmVfC4eXYkxE/1xWngnUBFG3vifSdhtAi3tWU15xqvc33tNJpQnlR0g71j4mmMj8b6Zl0rQEmuIeE0bqqhWuG9vWIoYLH3X8P4/latR8VikSmRxpIh7OzB1trCo0P3g79IWYPJG+deABkeHACR1xML75Z4WnjiCGvLTY5nBHkUhmRSrgRplmYTrly4YogWBaGK3Mau9mH+HIjjWbTQEkthIIamZpVayxRhfPn9+0BBO9euxrxXkHocnyI/O3nPH9Gh8rXXAbLrh8+qks9lRC60Oyo4k3ikaKnENkL7xAZe8/6pDds8Dutut27a9QR27IAu6DGywq5EwtRegrpl8QOmjUATL422w5nQjHsmE7BXIHzhFtxcNb62teFcNnUb4pL4za4iaOIZdXFtjhSabeiBR28lje74K+hG0V+nxL1jVNwzfwOVDYwyosHddXNXtP5erYLRcCxwK5niIGDs2/77ZIA+0/xTRhK0w3Mi/pK0Mfj0MlmuTSXMXbVQh1WZ2jfcCyp7savm/HdTMpJ3ecWuyR28oFqJigw4lybZo6vh63a3fHoaOqALZbGTuDKHvHSNW8DILKvK+SA/M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(22082099003)(18002099003)(56012099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1YzZzEwNWgzbmJWbEJla0d5L0x1b3VJSU1Nang4ZHU0VHlzWXBJNUt3c2sy?=
 =?utf-8?B?UEZHUFR1WFRpNFIyT3g1U3loRFpsQzh2YlFyWUJGWXdrUDVtVVpjRmtiVkJI?=
 =?utf-8?B?Y08rOHpKT3Y4QXI1L1o5TWhCNktWRFMvQ1ZUc29sWWc4Y3poNHpwbE5ITnRq?=
 =?utf-8?B?ckYvK09sUlhYeGZHNkNud21nbTB4WEFVTndDTVpzOUZVbUZoNWNaUXpRR25r?=
 =?utf-8?B?SUxLQ3NHWlM2NW5NNlpDdEtDU3NCQnhqdkZnajN3dURERTdGemxsZ3gwZXVI?=
 =?utf-8?B?SUt2ZlRLUVlvbkx4WTRhM2l4bld1VzFQT01kQVJPQ3o2d3FodEl6Ym1sOEpF?=
 =?utf-8?B?dWNxV3EvYk5zY3JsU2lFQTEwZitmM1lLNGU5RmxxcEV5aGRzQkkzQjdnY3Bk?=
 =?utf-8?B?bldqZDNOWDNyNjNTVy9iMC9PellCZVdRYU9DL3ZMdENsU2g0Wk9jVUJJTU9N?=
 =?utf-8?B?RnBkN1crQ3BIQ2dJd3BHM0RJTHJmYjJhMjFMbFM1Z3BZdXR2QUlWM3lnYmJl?=
 =?utf-8?B?ZnFpOWpuZ0xtYVJZbXoxcWNJc3RubE1pMlNtMWJuektXVXRVemQzTitqSzJZ?=
 =?utf-8?B?enJxWitYOXhlNkJSUkh0eThQbEpoRktzRzMrVXl0MnZDcy83NGIzNU1XVy9M?=
 =?utf-8?B?czlpMS83cSswSXhvbThVNWxjQWF6aXIwbHFBNHpFQXNpZmx4UTVCckZhSWM4?=
 =?utf-8?B?OTlaRDQ1OGc4Z2pXSG5OVmhMNGNWNkE1dEwzWS93S0ErUTd2ckttVlhvQ290?=
 =?utf-8?B?ZVFrNDRGenBWZDNOUVN5dHVpdUVtNmU0M01JQXV0L2VYcVlkeWVnS0pkelU1?=
 =?utf-8?B?K1pTck1pMUFBclV3REpxN0dJcE94dDVobUFLYXNkaVpXYjVoeC9NZ21jMkYr?=
 =?utf-8?B?bGVHdHk1Vjh5WTU3dTg0M0EvK1ErRTJUcCthYjgxakdFaC9lbW1zL29taUdv?=
 =?utf-8?B?UnplSFh4MU12eW03SVliNHJBNHFzVk80dEFENkhZQ3VRRzIwVmhpSWNKZjdp?=
 =?utf-8?B?ckdPUmNNUFhLYTl4YVg5Vi9pTDBqNFZNUlBTeENXYjlvOTFJK2FzRHc5WkJG?=
 =?utf-8?B?NHBsZnRmSENGSTM1b3VGNExHNFZzZjI0QmU0eGR4aUQ3WDdRTXVFbFNzQnYr?=
 =?utf-8?B?alk3bE5IcDRwUG1EZHRGci9TRW1nZy9uZE10ZWxPTHBlbkQ2SDZ4UFhhbSsz?=
 =?utf-8?B?OUF2UnZJeWl4N0c0cjJQWDhicVdWaCtzS0VPR0ZnY1F3WVFnM3BCWllUU1lF?=
 =?utf-8?B?ZGE1N1dNdWdocDJabTNLcjFXbVNmWGY0TXE3ZG16NG1qeEsyYUlralBCV1JD?=
 =?utf-8?B?R0ljOEYzNk52dlA4T3V1clBrdkZSN0tCTUp2dEhTT0paSWVNaTBzaTMwTjEr?=
 =?utf-8?B?dFhTNEVJcjRhWVZxRzJEb3BSS25nakd2Qm1aTytIOENQVUFIZWQ2eERsUm5m?=
 =?utf-8?B?aUttcE95ZEJycGVJUkdadDkzWGdnMko4b0t0TFdNTk9wNUtHRnBrdEZMRnQ3?=
 =?utf-8?B?a2lmL2lqSnVKUlhPSW9hL1NWT2ovWE5VYVMyRjlSMC9mc2lQVDVHdXFwSHNn?=
 =?utf-8?B?cmRlVTNZZnZFZHVJRnJqQjZ0djM4dUJFbGhVc1V6UFNlY0FHSzZaMUlBb05X?=
 =?utf-8?B?YWprdkZtOXA4aXNwckY3Zmo3QkNBYSsrUG9wM0hXbGZlWGpQNGRLVnRLSGFZ?=
 =?utf-8?B?SlVoOW5mQjlZZFZDWTVTUXE3UVdGY3YxZUZ6YWRjcDJCSkVuS1pkR1lTeTFJ?=
 =?utf-8?B?c3diM0t4eC9qRUQvejZUN2xVdWVOdFQrZXhNM2poaXArSXVnZkxJcmczcUox?=
 =?utf-8?B?ZWJZdTllL09MRExRaXFsZVFhUm9hUzdVT1BWTWd4dyt1S2NNTjdQbHc0TCth?=
 =?utf-8?B?VDUxRjVmU09LaFB6MEkwZnQrNXRETGUvZmRHMHFaUXNIdi8zQ0xxOWNjaWly?=
 =?utf-8?B?am1DU0pOVDBBUW5NcERZSllLeVZEbWIrOFd5d21hSmVrVC9sdGo5YUJxYklC?=
 =?utf-8?B?VFI4SmpxSHIxb3hXc1FaR2JGTEI2cW9zbXJiSythL3cyZXFqTTRrK0tUZkVZ?=
 =?utf-8?B?NSt2eEIyVDFHVU5kOHk3bFpodDJDei96Z0RWRVJ4aDdNaXhleVFpTmRDQ1ls?=
 =?utf-8?B?QUxUL0tRNlJZblhKZHFDdkowUU8zMlVMdGw0UlhpZ1grbFc5QSt1VE95WEU0?=
 =?utf-8?B?emM2cW9pQ2ZJaHg1OEtYa1R4cUlIK0IvNEpMYkVNT1U5bjM4TzYzVnVCRzg2?=
 =?utf-8?B?WnVVMURWREViS09adVkyQlV4SGp5UjU0Z1hzWG90dElBbm8zNndxUzFjTkJC?=
 =?utf-8?B?YVRhY0RzZFY0MGNkVXpJM0NPS1kxYkk3aWlXQUdya2lmMmZZLzFEU1UrVklX?=
 =?utf-8?Q?8xvXbCtsVh9+ozJ0=3D?=
X-Exchange-RoutingPolicyChecked: K0jlHY6LyXThc4oXlTjU14WcLcJ9zUOkaGKXwULCPoi8PTA4V+mzN/IiElMf5SHDanO62S6N+rLyiE2hIEoa+Hxj6b/YGLjcSxSnZUK9osg4gwrWSoyWrJUZjnUUDrZBvl7sDqw8lzvFefMpP4cEruUU/XH9Ep06qtMHXBBRBFHNeH1fPWy145ysXDFmFEvzADfhxtbtdxLh9pZaM0y3lO2wUCplO+2vkFLtx+tG/uPjy1GR6UDCtPl6/HlfWwSoAb3nQFA3DW6//RM2vUHGNPC7g/4i+L6J87abuBZUVfFthkv4rI1f37t1gADaepchhtqUZFUpvO2NEHXomvR1ew==
X-MS-Exchange-CrossTenant-Network-Message-Id: dc8037e6-392d-4583-dfdc-08dea70f07a3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 23:20:12.9286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2KBtgm423FUm3UINvj5uqhdvfg8jSWdlCh5o9HP5jkwmwoKVhyL+luRjDSxkOWZ7KAQfFVuQUdeuwZRunAS5ccY1R8WS2hLswG93WYnJupc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4651
X-OriginatorOrg: intel.com

Hi Drew,

On 4/14/26 6:54 PM, Drew Fustini wrote:
> +
> +static int qos_resctrl_add_controller_domain(struct cbqri_controller *ctrl)
> +{
> +	struct rdt_ctrl_domain *domain;
> +	struct cbqri_resctrl_res *cbqri_res = NULL;
> +	struct rdt_resource *res = NULL;
> +	struct list_head *pos = NULL;
> +	int err;
> +
> +	domain = qos_new_domain(ctrl);
> +	if (!domain)
> +		return -ENOSPC;
> +
> +	switch (ctrl->type) {
> +	case CBQRI_CONTROLLER_TYPE_CAPACITY:
> +		cpumask_copy(&domain->hdr.cpu_mask, &ctrl->cache.cpu_mask);

Looking at patch #10 ctrl->cache.cpu_mask contains all CPUs associated with cache
even if they are offline. This is not what resctrl expects. Instead the expectation is
that a domain exists and is online (hence "resctrl_online_ctrl_domain()") if at least one CPU
belonging to that domain is online and domain->hdr.cpu_mask lists all the *online* CPUs
associated with that domain.
This is why resctrl always takes the CPU hotplug lock when traversing the domain
lists.

I thus expected this initialization to be split between an early initialization of
resource capabilities and then domain initialization as part of the CPU online/offline
handlers.

> +		domain->hdr.id = ctrl->cache.cache_id;
> +
> +		if (ctrl->cache.cache_level == 2) {
> +			cbqri_res = &cbqri_resctrl_resources[RDT_RESOURCE_L2];
> +			err = qos_init_cache_resource(ctrl, cbqri_res,
> +						      RDT_RESOURCE_L2, "L2",
> +						      RESCTRL_L2_CACHE);
> +		} else if (ctrl->cache.cache_level == 3) {
> +			cbqri_res = &cbqri_resctrl_resources[RDT_RESOURCE_L3];
> +			err = qos_init_cache_resource(ctrl, cbqri_res,
> +						      RDT_RESOURCE_L3, "L3",
> +						      RESCTRL_L3_CACHE);
> +		} else {
> +			pr_err("unknown cache level %d\n", ctrl->cache.cache_level);
> +			err = -ENODEV;
> +		}
> +		if (err)
> +			goto err_free_domain;
> +		res = &cbqri_res->resctrl_res;
> +		break;
> +
> +	case CBQRI_CONTROLLER_TYPE_BANDWIDTH:
> +		cpumask_copy(&domain->hdr.cpu_mask, &ctrl->mem.cpu_mask);
> +		domain->hdr.id = ctrl->mem.prox_dom;
> +		if (ctrl->alloc_capable) {
> +			cbqri_res = &cbqri_resctrl_resources[RDT_RESOURCE_MBA];
> +			err = qos_init_membw_resource(ctrl, cbqri_res);
> +			if (err)
> +				goto err_free_domain;
> +			res = &cbqri_res->resctrl_res;
> +		}
> +		break;
> +
> +	default:
> +		pr_err("unknown controller type %d\n", ctrl->type);
> +		err = -ENODEV;
> +		goto err_free_domain;
> +	}
> +
> +	if (!res)
> +		goto out;
> +
> +	err = qos_init_domain_ctrlval(res, domain);
> +	if (err)
> +		goto err_free_domain;
> +
> +	if (resctrl_find_domain(&res->ctrl_domains, domain->hdr.id, &pos)) {
> +		pr_err("duplicate domain id %d for resource %s\n",
> +		       domain->hdr.id, res->name);
> +		err = -EEXIST;
> +		goto err_free_domain;
> +	}
> +	if (pos)
> +		list_add_tail(&domain->hdr.list, pos);
> +	else
> +		list_add_tail(&domain->hdr.list, &res->ctrl_domains);

resctrl_find_domain() returns NULL if it cannot find an existing domain, in that
case it initializes "pos" to support adding a new domain in a sorted list.
Expectation is that domains are managed as part of CPU hotplug handlers. When
a CPU comes online then handler can check if the domain it belongs to already exists,
if it does then the CPU can just be added to that domain's cpu_mask, if it does
not then a new domain is created and added in the the appropriate spot in the
sorted list (based on domain ID) of domains. 


> +
> +	err = resctrl_online_ctrl_domain(res, domain);
> +	if (err) {
> +		pr_err("failed to online domain %d\n", domain->hdr.id);
> +		list_del(&domain->hdr.list);
> +		goto err_free_domain;
> +	}
> +
> +out:
> +	return 0;
> +
> +err_free_domain:
> +	kfree(container_of(domain, struct cbqri_resctrl_dom, resctrl_ctrl_dom));
> +	return err;
> +}
> +
> +int qos_resctrl_setup(void)
> +{
> +	struct rdt_ctrl_domain *domain, *domain_temp;
> +	struct cbqri_controller *ctrl;
> +	struct cbqri_resctrl_res *res;
> +	int err = 0;
> +	int i = 0;
> +
> +	max_rmid = U32_MAX;
> +
> +	for (i = 0; i < RDT_NUM_RESOURCES; i++) {
> +		res = &cbqri_resctrl_resources[i];
> +		INIT_LIST_HEAD(&res->resctrl_res.ctrl_domains);
> +		INIT_LIST_HEAD(&res->resctrl_res.mon_domains);
> +		res->resctrl_res.rid = i;
> +	}
> +
> +	list_for_each_entry(ctrl, &cbqri_controllers, list) {
> +		err = cbqri_probe_controller(ctrl);
> +		if (err) {
> +			pr_err("%s(): failed (%d)\n", __func__, err);
> +			goto err_free_controllers_list;
> +		}
> +
> +		err = qos_resctrl_add_controller_domain(ctrl);
> +		if (err) {
> +			pr_err("%s(): failed to add controller domain (%d)\n", __func__, err);
> +			goto err_free_controllers_list;
> +		}
> +
> +		/*
> +		 * CDP (code data prioritization) on x86 is similar to
> +		 * the AT (access type) field in CBQRI. CDP only supports
> +		 * caches so this must be a CBQRI capacity controller.
> +		 */
> +		if (ctrl->type == CBQRI_CONTROLLER_TYPE_CAPACITY &&
> +		    ctrl->cc.supports_alloc_at_code) {
> +			if (ctrl->cache.cache_level == 2)
> +				exposed_cdp_l2_capable = true;
> +			else
> +				exposed_cdp_l3_capable = true;
> +		}
> +	}
> +	pr_debug("alloc=%d cdp_l2=%d cdp_l3=%d\n",
> +		 exposed_alloc_capable,
> +		 exposed_cdp_l2_capable, exposed_cdp_l3_capable);
> +
> +	err = resctrl_init();
> +	if (err)
> +		goto err_free_controllers_list;
> +
> +	return 0;
> +
> +err_free_controllers_list:
> +	for (i = 0; i < RDT_NUM_RESOURCES; i++) {
> +		res = &cbqri_resctrl_resources[i];
> +		list_for_each_entry_safe(domain, domain_temp, &res->resctrl_res.ctrl_domains,
> +					 hdr.list) {
> +			resctrl_offline_ctrl_domain(&res->resctrl_res, domain);
> +			list_del(&domain->hdr.list);
> +			kfree(container_of(domain, struct cbqri_resctrl_dom, resctrl_ctrl_dom));
> +		}
> +	}
> +
> +	list_for_each_entry(ctrl, &cbqri_controllers, list) {
> +		if (!ctrl->base)
> +			break;
> +		iounmap(ctrl->base);
> +		ctrl->base = NULL;
> +		release_mem_region(ctrl->addr, ctrl->size);
> +	}
> +
> +	return err;
> +}
> +
> +int qos_resctrl_online_cpu(unsigned int cpu)
> +{
> +	resctrl_online_cpu(cpu);

This is where a domain is expected to be added when its first CPU comes online.

> +	return 0;
> +}
> +
> +int qos_resctrl_offline_cpu(unsigned int cpu)
> +{
> +	resctrl_offline_cpu(cpu);

This is where a domain is expected to be removed when its last CPU goes offline.

> +	return 0;
> +}
> 

Reinette
