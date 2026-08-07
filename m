Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F64B385D98;
	Fri,  7 Aug 2026 16:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786120581; cv=fail; b=vFJlFKsY/MT7lbkVb2TKcXBUKhYby7ZLXG+8CBgbRhO+xOU+15ykaehAe5V6L4vsuxGg5HRWeuXqVX/a1feXQXowBYavYS2P4T1/mdoWMc5yVW3XwqRY79MlIxw4qgCXjbjww7APzBMG3yfHRwCPsKDfs0OBcwUvjiTe1gIZ9ik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786120581; c=relaxed/simple;
	bh=k1CaSvsEAOCAdHesaRe/oF1MZ8IImoV7IMUjfblHHAw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kBOENDxLOmUHqZSvqEkuUA8QECe3s9v0eqH0ZiB4m+k1ajdGDc+MFoAfdtchatuBFq4qvCL6Rykh0mlPbf5KemFFLwMD8eURg0sek7vGUcwb/eZdwvAwLwd0o6fYRCQ2Ny5+jBXe0en32liXOT77kedF5GNTuv5JmFWoMxsv7ms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L0iyVwkH; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L0iyVwkH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786120581; x=1817656581;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=k1CaSvsEAOCAdHesaRe/oF1MZ8IImoV7IMUjfblHHAw=;
  b=L0iyVwkHRYE6lwOODAQNk8GAGGztRGsmuinJ70tFN3nUVb8IML0+WbmF
   pZilJcpF00IRx3TUDP67qYyzVKYrgoqHFXLN+DW/h8+kTkSMVyXHx3xjl
   /KWlo+LxmykS0wnzbsyRU8msoM7IX/dsy4mQ+zBwrBIU0L2JGYFJW1Pm7
   m0LnF0FpmlmTFZUb6jNJrrNJFMqcW51He5jGSmKT2MREtwucUiRfyP029
   iMBggufyZajF9XTZaQTVT0QcJ0CA3eAwIw2hIcfuinJGzTJtEgPqiCC0+
   gW/f04RC540sbx8duvy8O7fQWDeZ9oTvw85QC+FEAmZbHNmgZfIklxMr6
   w==;
X-CSE-ConnectionGUID: Qq4NeG/mShSqBx1qWrBIeQ==
X-CSE-MsgGUID: 1nHV+lGiTxCr++VhiomVXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11868"; a="98097602"
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="98097602"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 09:36:18 -0700
X-CSE-ConnectionGUID: XhQryXOLRh251loMPaGYdQ==
X-CSE-MsgGUID: dmGIAvc6QYOKh16YO5zHXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="260686487"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 09:36:18 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 7 Aug 2026 09:36:17 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 7 Aug 2026 09:36:17 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.63) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 7 Aug 2026 09:36:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=soDtfHSu+LSM4barhgZlPF/WhHqHDe/FJgmm+UvLjES7qi7BLsCDwycsFmaCzDAN+poUTxaSd1y0i7zSA/MGZ20DuHLB4LcEb1ulMBjI8hLysYyJAUGVKZGQHsesa0CokQ0v52GCooZf6qh41WixyhJPcRtt9u0bJD9Vwnt6kf+ZLUROybF3zyG+w7ga4uCMR4ysq7+V2hd27b2PR+7aMdwvOTOq+qRCREYJLCNzfAxCpqGjxiTXjb7hMmYx0NrwzpXVSL+7OkVnM3tOfsPDqc4gHpL/0uTZcYKzIYTF457OIqiXIRFNxrylYy65AzGlD4BqBw5aULfxoODIBgu/lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k1CaSvsEAOCAdHesaRe/oF1MZ8IImoV7IMUjfblHHAw=;
 b=NMfIrvoLGTrLI1l/zDGeYGWb3DOikIKL7NVlus9a+Qq1y6zyZPTw4G9sfAqqBzyTClliDsfetyk/PRXRUA8vJdvKltdMr67wFot++lpKgZCgUDHfKVxiYKvma+kv41788CWXRIyc2frOd7A29I57i5bNpJvIA4XhhUO/zym68qnMp0Coi37O0Vv0IEM2qKZwdOZmoGz4kp+tpGkwOeDV3cxrb5k13S1dxHhY+RXNrkxyymAITxyLkJUcD8NLYg6jMa7VXQUS9KIk6+v9QnkXJlUOHvE1gagoPa3oYAeh3GfU6uLu74xZfx+5nz3/2g0bwishozmsvenL7sefxhhA+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH7PR11MB5795.namprd11.prod.outlook.com (2603:10b6:510:132::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.16; Fri, 7 Aug
 2026 16:36:11 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3454:2577:75f2:60a6]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3454:2577:75f2:60a6%4]) with mapi id 15.21.0292.019; Fri, 7 Aug 2026
 16:36:10 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: hejunhao <hejunhao3@h-partners.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "guohanjun@huawei.com" <guohanjun@huawei.com>,
	"mchehab@kernel.org" <mchehab@kernel.org>, "xueshuai@linux.alibaba.com"
	<xueshuai@linux.alibaba.com>, "jarkko@kernel.org" <jarkko@kernel.org>,
	"yazen.ghannam@amd.com" <yazen.ghannam@amd.com>, "jane.chu@oracle.com"
	<jane.chu@oracle.com>, "lenb@kernel.org" <lenb@kernel.org>,
	"linmiaohe@huawei.com" <linmiaohe@huawei.com>
CC: "bp@alien8.de" <bp@alien8.de>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "tanxiaofei@huawei.com"
	<tanxiaofei@huawei.com>, "linuxarm@huawei.com" <linuxarm@huawei.com>,
	"liuyonglong@huawei.com" <liuyonglong@huawei.com>, "mawupeng1@huawei.com"
	<mawupeng1@huawei.com>
Subject: RE: [PATCH v2] ACPI: APEI: Handle repeated SEA error storms
Thread-Topic: [PATCH v2] ACPI: APEI: Handle repeated SEA error storms
Thread-Index: AQHc7bKsYF+ogNgHiEe8sf9US2lOurZkHxyAgBcA9gCAF4uUAIAAjiJw
Date: Fri, 7 Aug 2026 16:36:10 +0000
Message-ID: <SJ1PR11MB6083D39FF213C8A03F4D3C42FCD12@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20260527082707.2013499-1-hejunhao3@h-partners.com>
 <ak6FfacJrg8Elnl6@agluck-desk3>
 <3a6e3281-de8a-ae5c-249c-316eaa886636@h-partners.com>
 <107cccd7-a5ab-bd4f-c907-dc204d44cc30@h-partners.com>
In-Reply-To: <107cccd7-a5ab-bd4f-c907-dc204d44cc30@h-partners.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|PH7PR11MB5795:EE_
x-ms-office365-filtering-correlation-id: 0edf882b-9fea-4b10-79d2-08def4a1fd1a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|22082099003|921020|38070700021|56012099006|11063799006|4143699003|10067099003|6133799003|18002099003;
x-microsoft-antispam-message-info: pTMK/PXQKUNqrRVMq1ncaZTc/JLpTRHkr04NyI+VAc8GAh/xh0U6+yb7kQwI+rKCaAb+qYgaZxxhz4obcjl0jF0Mw8FhwjQ1nbfkW2N80yk7M7X9V+/MM1RMJmCFcuT1ovROzaU5zjnNzuZyVpgy/r8+jOBDdXxyP6yNtYg+xm/lULEbbxtQBl4KpUza8otVtgZbcxnhSDRtMFjRYRa+8JM5iKoxensR9Pe40KV/Sec4GzF/NBAv+GyV+ghzEgwau160PJm9jzuYIm1YLnYJyN3MA1ShSnLD92z3z/PfibICL+Xc8MW0JENCueTrCTSEpytnzDzWGiiN5fOq3kCu4Xf03DyuJHqfddnf3EyEhntNuXnfVcuO55y61WLAV/YjgpXR9QPeohg0J3KpbAZD/CgdehD2PiN4iLm9Uv1KJNE+WBZYhI8YUXpozHa/ooMGq7Mjg0iyxOOYfB/0SGTsM81r5+gXKE131ICMe8j4GRiKZxNxhtOSrzdRt6gCDPUwWwzQjbWKX0yu4H8D+8ypE9MMTqQbqTOXF2Pdwv7B8+EORyWscJ9ZZmXFgFs6BmOaRzgmqQe1WnXcP6HBC1WTMcTkFDQH4m2LiZ68LANDyrEf8YL1VMgQRfobKWUaFjz8CH5hJnLHxzRZmHYDNwh7psyUB0lx8wKY4AzKuzNu1WFPsrvuDB8yBYvlgG8+IjjBcKhhJyd7q5DaM9Yl7/TQ8EDTaAmmtKNRo9sbHfqS7tUdsiU+npFZAYZ47bnvEApZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(22082099003)(921020)(38070700021)(56012099006)(11063799006)(4143699003)(10067099003)(6133799003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OGVqa0kvc1JBNGJWdk40dUo1RnhsTnVGd3BwWHl1TUl2UEI4bUM3Q2MvS1dB?=
 =?utf-8?B?THJZNjhSY0VBMTRJSkQycEJrNk0zazVRQmdCMlc4MVoyNldhVHJtcm0yTVRM?=
 =?utf-8?B?Nnd4RG05UjRlRVBvUUE2L3cxdDVJeUZTYVdKc0NzSmJVSGUzYTJlT0xuMUgz?=
 =?utf-8?B?Q1AwR0l1azF4MHFGT0REMUpyU3lOYnFDVnVxbU91MHdOTTBNVS95azdsaGU0?=
 =?utf-8?B?S1U3eWs3VjRJd1QrMUlMNFpIYUNiZzk4aWoxQWhPSmNmc3BIUjg3YTM1RSs0?=
 =?utf-8?B?WjgwTnBEeFlENnlsamlqVHI0Mkp2UlhNQUppSHZHVC9Sc2EzVzdBVnl0d0xS?=
 =?utf-8?B?K2Zta2VpVE8xdWxBdk1YMmNtbDVGSGNrNkM4SUp5cnk3bHJJSGNOVEFZT1gz?=
 =?utf-8?B?WndVdi9YZU5ITVNyMkZOODY4N2UvN05Qd2JZZ0R5b2ZYd1RVc1RaK3hCanA4?=
 =?utf-8?B?ai9BcXVQOHV3TlMrMnlyOTkrcG5zdXpXZUc0L3lyY0pHNFArY0VsQlYrb0pU?=
 =?utf-8?B?V2lLMnRWaUVkM2hHSmswNU4xTEVxdmZTejltRDQ3aHRXWXRjUDVkUDE3L3FH?=
 =?utf-8?B?R0w0QUI5QVJWdUgzMld6UE9tbUV6WXZvMkdFTFVjQ1lYWjBxSlkzUVNCaGdK?=
 =?utf-8?B?STNZd3I4ekRwQWlYUSs3bXhYRCtkbi9kalE2VkRDU1RWZzRkVzBhMFRld2Vm?=
 =?utf-8?B?QnZoUFd1cGYrc3dyTmFxMmxIdlphYVZwa0ZHTWxsK0NqL3k0TzBCVEw0a2tm?=
 =?utf-8?B?SExnQWxWUCtYUDZyelN6QlBTeEJObTdka1p2ekxUdGdsdDlJbmJxOFBhY0E2?=
 =?utf-8?B?aGxDWTRBTXNZcExFb2MrZ0t5cVpyMW5reU9ZZHVGVk1hR29EUTZLd2kxdkQ1?=
 =?utf-8?B?ZnJPckF2MkVZWVZGc2tENWVhZ2xMMFpKU2ZhcUJtRHJGWjZwdDREK0dPeS9M?=
 =?utf-8?B?Y0dxVVRVNWpLeW1pQjhoTjM2Q1NIMERmMWNEYjFOWkM3T2w5bXJKL2NkK2cv?=
 =?utf-8?B?bndjR1cwYmkzODQ0OFl0VEdoanlZb2xldS92cDJNcEs4M3JUSkNTS1JGemQ3?=
 =?utf-8?B?bFJNeWFpcm5hRWFPenhQMW5jUmFOM2RoNnVZYjdQdWdpQmo5bUJhaURhMUdv?=
 =?utf-8?B?M2IvVjN4akR0dkVSdHFJeFVsMUdINVVGazdPRnNha0JyT21QcHFVRzZESzlN?=
 =?utf-8?B?QzdIZmhzKzk4SUV6YXFmclhIa1dVMzBmcXRFOTMxM21nMW9XVjlVTjQ2Z2I4?=
 =?utf-8?B?bkhncHIxdjg5QlBDZFhicWIwQ3B3ODdTdnk0VDZZOE81amRrdHo4RnptUCt6?=
 =?utf-8?B?V2JHcjdYMVVQdDVDc3hONWl2eWdzaDRaNWtOeE83Tjc2RUpPNnk2OVNPYm9Q?=
 =?utf-8?B?TmxSZTkrVFgyRzRlTDJZVDlvNGdxY1NVSzhwVGxUYlJsSjFnVWhUWFJDdHIy?=
 =?utf-8?B?WGROdmdUaGozUXQ3K0pnZjdqT0h4eXQzcVptMHhiTk1QQU5OcElKb0tBdHV2?=
 =?utf-8?B?QkxWQXR0N0dYK3l6S1ZoRWs3LzlpWlRyRVcydERSc3VYN1hzblJ4YlF5TGlX?=
 =?utf-8?B?aW5RTnVMeTQyNk5kc3ROdXdDU1locVpFcUVOOW0xdDJpOXB5TzliOHNjMS9E?=
 =?utf-8?B?Rlg1U3M5Q014bTdsb3Vodmw1dHRvNXpETEZzVHMrMUhMSHZacHZGVXpZdEdw?=
 =?utf-8?B?Z3ZBWG1nMC84Sytxb2dndXhhUjV4RDA5cEpIZWh5RERBYk5tQVVtcWt1Q2Fu?=
 =?utf-8?B?STBPWmdUQ1o4bEVwT0FpeExMMSt4SXlXVXJ2OXpCRWl3V1V2RHpYNVRSdTVR?=
 =?utf-8?B?c21RUnRkdnpWK3h6SHZKcGNmc0t3a0VLN25PMHRUWHZBSEdtNmhiZU1nYndp?=
 =?utf-8?B?TWgzb0tCdDduakRCNXR0YTRWUE5CaGpyc2QvRGp4bDJZZW5VMzBiMW9KOFVR?=
 =?utf-8?B?WkE5dnBuRzhRclliRElBc1RYME55a0FETzJNd3ZyRkt5dWJtd3FITmdmVWNy?=
 =?utf-8?B?dVZCbUNGM21ub2xEYnVlUmNvUU4wVDBnejFjUEVZcXRGeHRkd2hVTnRhemhG?=
 =?utf-8?B?ZHMvQk5xTWt3aW54Y3RUZmJmNGNWSlBkMGNkc3cvN1NNRVIwQWRxb0JkekJX?=
 =?utf-8?B?QlpKdmRoakxSYTN5TWhlaHRFMGFDVjF1dUFuZkZvNHJXU3kxdzNPSHFJOFhO?=
 =?utf-8?B?eW02OEZpWlcvOVBOU2tReDZhWUVKVXBpZ005aGtkOWpQMXRWNDZDRElHNVNB?=
 =?utf-8?B?OG1VNjdzU3pHb2xUazg1MzBVRVRJZGFqN3c4TlBvc1Izb3FyZGVmYkkwb1Bo?=
 =?utf-8?Q?7UD5VCwCgYddVFmIJB?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: pEbleSh1I7/yyiNL+9xsmz26K2rP4KQSAOJYA6DGcenDHjmDi2arW92DQRy6zcvQE+vDjOFjswVpUQ6R/TAwKkaHOtRLV8PAzZgYU8rQJBZlMzrOcGpMAcADOaXyX6ctdopoWVkoQkKDWbA1UsPiqTLl77Qw68ns7hndvpsjJJmwQXV068KGpPtdxws6bWbmE62N3ypIjrmF7uTkg6j91ohUfgiimf6gvm5VpZ7zShyswNifMDLJDL/H0JUF2JnfMTJmBE2VfgDGdCD4U5roQnVqYjBYuU/7VaijbMmyqfgUrvsXZUzWlLAlOP2FDDgRgl1RqIzT/Iku5LKXBDpWxQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0edf882b-9fea-4b10-79d2-08def4a1fd1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2026 16:36:10.6191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AxzMQU1C+MQSqzKM4GpJVJ1+0a/NeJ6X4LImywoQXstxQulC2vVhOdZxPNndvoV4m8wuNewVIzi0kW4zMMUa6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5795
X-OriginatorOrg: intel.com

PiBhIGdlbnRsZSBwaW5nIG9uIHRoaXMuDQo+IEFsbCBjb21tZW50cyBhcmUgd2VsY29tZWQhDQoN
Cj4+IEkgdGhpbmssIGJ1dCBJJ20gbm90IHN1cmUsIHRoYXQgeW91IGFyZSBhZGRyZXNzaW5nIGNh
bGwgZnJvbSBoZXJlLiBCeQ0KPj4gcmV0dXJuaW5nIC1FQ0FOQ0VMTEVEIHRoaXMgY29kZSBza2lw
cyB0aGUgaXJxX3dvcmtfcXVldWUoKSBjYWxsIGFuZA0KPj4gcmV0dXJucyAtRU5PRU5UIChpbnN0
ZWFkIG9mIHplcm8pLg0KPj4NCj4+IGdoZXNfaW5fbm1pX3Nwb29sX2Zyb21fbGlzdCgpDQo+Pg0K
Pj4gRWZmZWN0IGhlcmUgaXMgbW9yZSBjb21wbGV4LiBEZXBlbmRzIG9uIHdoZXRoZXIgdGhlcmUg
YXJlIG11bHRpcGxlDQo+PiBnaGVzIGVudHJpZXMgb24gdGhlIHJjdV9saXN0LiBJZiB0aGVyZSB3
YXMganVzdCBvbmUsIGFuZCB5b3UgcmV0dXJuDQo+PiAtRUNBTkNFTExFRCwgdGhlbiBpcnFfd29y
a19xdWV1ZSgpIGlzIHNraXBwZWQuIEJ1dCBpZiB0aGVyZSBhcmUgbXVsdGlwbGUNCj4+IGVudHJp
ZXMgb24gdGhlIGxpc3QgYW5kIGF0IGxlYXN0IG9uZSBvZiB0aGVtIGdldHMgYSB6ZXJvIHJldHVy
biBmcm9tDQo+PiBnaGVzX2luX25taV9xdWV1ZV9vbmVfZW50cnkoKSB0aGVuIGlycV93b3JrX3F1
ZXVlKCkgaXMgY2FsbGVkLg0KPiBIaSBMdWNrIFRvbnksDQo+DQo+IFRoYW5rcyBmb3IgdGhlIGNv
bW1lbnRzLg0KPg0KPiBUaGlzIGZpeCBpcyBvbmx5IGZvciB0aGUgY2FsbCB0byBnaGVzX2luX25t
aV9zcG9vbF9mcm9tX2xpc3QoKSBmcm9tIGdoZXNfbm90aWZ5X3NlYSgpIG9uDQo+IEFSTSBwbGF0
Zm9ybXMgKEFDUElfSEVTVF9OT1RJRllfU0VBKTsgb3RoZXIgcGF0aHMgYXJlIHVuY2hhbmdlZC4N
Cj4NCj4gSWYgbXVsdGlwbGUgU0VBIGVycm9ycyBvY2N1ciBzaW11bHRhbmVvdXNseSwgbXVsdGlw
bGUgZW50cmllcyBpbiBnaGVzX3NlYSBhcmUgYWN0aXZlDQo+IGFuZCBvbmUgb2YgdGhlbSByZXR1
cm5zIDAsIHRoZW4gLUVDQU5DRUxFRCBpcyBkaXNjYXJkZWQsIGJ1dCB0aGUgdW5oYW5kbGVkDQo+
IFNFQSB3aWxsIHNpbXBseSB0cmlnZ2VyIGFnYWluIGFuZCByZS1lbnRlciB0aGUgU0VBIGhhbmRs
ZXIgdG8gYmUgcHJvY2Vzc2VkLg0KPg0KPiBUaGUgd29yc3QgY2FzZSBpcyB3aGVuIG11bHRpcGxl
IHZhbGlkIFNFQSBlbnRyaWVzIHBlcnNpc3Qgd2l0aGluIHRoZSAxMC1zZWNvbmQNCj4gZ2hlc19l
c3RhdHVzX2NhY2hlZCgpIHdpbmRvdyDigJQgdGhlIGZhY3QgaXMgdGhhdCBhIGdyZWF0IG1hbnkg
U0VBIGVycm9ycyBhcmUNCj4gcHJvZHVjZWQsIHdoaWNoIGFjdHVhbGx5IGNvbnN0aXR1dGVzIGEg
cmVhbCBTRUEgc3Rvcm0sIG5vdCBvbmUgdHJpZ2dlcmVkIGJ5IGEgc2luZ2xlDQo+IFNFQSwgYW5k
IGluIHRoaXMgc2l0dWF0aW9uIG5vdCBkZWxpdmVyaW5nIFNJR0JVUyBpbiB0aW1lIHRvIGtpbGwg
dGhlIHByb2Nlc3MgaXMgYWNjZXB0YWJsZS4NCg0KSSB0aGluayB0aGlzIGlzIE9LLg0KDQpSZXZp
ZXdlZC1ieTogVG9ueSBMdWNrIDx0b255Lmx1Y2tAaW50ZWwuY29tPg0KDQotVG9ueQ0K
