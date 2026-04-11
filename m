Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939B62144D7;
	Sat, 11 Apr 2026 14:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775917303; cv=fail; b=aqOsrLJuR6ktbCZlWGiLBczGNb9UA1wRYgY0F26MUycC2RuPRlq/YbRoPhnxgf/hMomMFAQJwgA7SyyXqpREw7hxlnpgx/QqwLWCgXb+1WTiIVVh1BIGEYAbZTl4+y2fLBV3bmjp9fyBEFvCYUKNwo6wkdENhqzWmCXmlWLT8KM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775917303; c=relaxed/simple;
	bh=PVPwtKEkrQC7QUhsNnIf53LXnnifQTDwogAyAMdH7FI=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rSVxVkEoxWy6yWM2oz++DA30N3TWBHQGxJ3w9q+Wu7EoPYAOYb0enKhEWjIqUiI/KDBMKZGXuTaBgBaD4KeGz7HXr8I6hj9yILFwVcuAfaKz4HXkyTDXbNlXNQ6sL4UgN5BoOjFIdybFtrV3HsnEuSypmOtlV9I1wX+zI0+QPDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KHN+N1Gt; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KHN+N1Gt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775917301; x=1807453301;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=PVPwtKEkrQC7QUhsNnIf53LXnnifQTDwogAyAMdH7FI=;
  b=KHN+N1Gtv7q2Y8h6udXYgAOZ7PPNLVbk88twOcna2c++Jd52W9krvwn2
   zOx7+AR2H/978U3uScg/3aG89B8nOjwRZsMwawDgj4hcyIGftUpbZS9sB
   w8nzfd1vD368w89cI7FPfm6gO9EeECayMBXsTfjA2T3vXFDR4Cpnjv5Wg
   vjRykYbEJKprwzXDx959AnfMTYqWYauAugzYEc+rH+UrZ9E0OunKTjW1Y
   Y8vYZCW9c9gual6C/Tuxc21uPNHEz/0PKUad0ww5wD/Ekw/fj8XYvps3e
   KSd9ehKZpqnXKhCUvt2SNmS49YV5RxWGHugEwL/PX9ic3v0RP+ebgKb4n
   Q==;
X-CSE-ConnectionGUID: BR/hxtKFQsaTYRk/T/E8WQ==
X-CSE-MsgGUID: ANB5iDYRRRWA1jnkQI0IlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11755"; a="87994929"
X-IronPort-AV: E=Sophos;i="6.23,173,1770624000"; 
   d="scan'208";a="87994929"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2026 07:21:41 -0700
X-CSE-ConnectionGUID: aR88gfWBS5a+e9v0KW1Vvw==
X-CSE-MsgGUID: ghuLHphQTRO0Z2MPuJPI2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,173,1770624000"; 
   d="scan'208";a="229618997"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2026 07:21:41 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sat, 11 Apr 2026 07:21:40 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sat, 11 Apr 2026 07:21:40 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.67) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sat, 11 Apr 2026 07:21:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BTqUbkzmWiP8RYqQopqct4qQ9WloDD9ipeD0CFPU6NevV9t8L4BOksLlnNiAvR4tjjO+imBrMv6d2U8qlJnbwDTK2NA3/aleWiqQbwdd/l6CBnP9f5rFnEcnjBXfaHfBtfYDKfudtyoWVrzAHBaWXQdKV8tw6KvN6MJpcaypbHmU1lnSgU+K4dEERW/Kcb7IYhj/AYqJ4SrkEcYsLBjS+nQ6iSmq6u12OFoV1s9javCcOrBhkIygvFX/OabfiiBgG0FNcdXYXzXC1KxBnbZAuKV3lILEHG/NEfNojXfHZMlP0BZ2s49Eyc1yW1L+KNr6hwZHXdd9AXby8w3ydul6SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5o6+rrAvesdmFeXss5Nm1jhRizQ4l/RlsbMN/pvix9Q=;
 b=DPizGd9gh2K0HEPDfqTPgGP+WEXcJG+pr8szexma0IxJ0TCsFUKgGNpQDQkLzULUjS7gJWyK0xXEz/g16s+LGwBJQfGbQoOmO+RSx886dz1ZWh4l7/L6TEvfsSAtA1qaqaGJMjwkQqmH0UOvCFDvYt6Cs2Uc4vZAVV214aIJXH9/x0cq7g1/dp4nagNGLLh+uXkimwreVRQTUpNlYY134OT96kiRcQ5irNZZsakunlJmHpLyufzLfuDc90TPoLU5bF2RJbj5rFmO6r7sPDKNJRBhzrRAQxX3AL82MEVi3Mczdp2qkl6+hNdjMqsI94JeIfIZ5hZO4KnQW8jWtvdN6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB2808.namprd11.prod.outlook.com (2603:10b6:a02:c8::26)
 by SN7PR11MB7637.namprd11.prod.outlook.com (2603:10b6:806:340::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Sat, 11 Apr
 2026 14:21:38 +0000
Received: from BYAPR11MB2808.namprd11.prod.outlook.com
 ([fe80::defa:788:da96:2f9a]) by BYAPR11MB2808.namprd11.prod.outlook.com
 ([fe80::defa:788:da96:2f9a%4]) with mapi id 15.20.9769.044; Sat, 11 Apr 2026
 14:21:38 +0000
Date: Sat, 11 Apr 2026 22:21:27 +0800
From: kernel test robot <lkp@intel.com>
To: Huisong Li <lihuisong@huawei.com>, <rafael@kernel.org>, <lenb@kernel.org>
CC: <oe-kbuild-all@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <zhanjie9@hisilicon.com>,
	<zhenglifeng1@huawei.com>, <yubowen8@huawei.com>, <wangzhi12@huawei.com>,
	<zhangpengjie2@huawei.com>, <wanghuiqiang@huawei.com>, <lihuisong@huawei.com>
Subject: Re: [PATCH v2 2/2] ACPI: processor: idle: Fix incorrect power
 management decisions after power notify
Message-ID: <adpY554J/jgYEw4a@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260407081141.2493581-3-lihuisong@huawei.com>
X-ClientProxiedBy: SG2PR04CA0157.apcprd04.prod.outlook.com (2603:1096:4::19)
 To BYAPR11MB2808.namprd11.prod.outlook.com (2603:10b6:a02:c8::26)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB2808:EE_|SN7PR11MB7637:EE_
X-MS-Office365-Filtering-Correlation-Id: 60e6a048-b7ae-4fd3-9bc7-08de97d5a4be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 9DR3n3ScrIlhhDGlG3WpbHh+LluJ9iX/PLrCLAAV90RsoQQHkd2ExRRW1QRzKv77TBe84+tlURmGX0qHB7DtexhEaKMb2+1+j91xmovHdY3oNGFPMdbLy1FVNsilDDCdajO6TVV+1f2XxIYCwTGgeNNPE/3q7CWK5TtSKuFIHOY1/gra3SX9tUlSCjVau9XNLPesqHkJ0BtBXuOnNrEFJ4t79mG9T1ZbpkRXBLswHvlRQi5M7ymUEo99QdKML4WlD9TyI5OCc4oJQf+ujn19Cb2SdMZ9eFgCQmV1sf5+6NNc/E/C2df0VE4QRgeqczFHRSzwz9KPoJ5rSpgju7MgAdJqsjQCl2yvR7F9099DzBJN1MAisqhctbwa4cQYZhr2K1QmvYOctj1IGNJlcBX0ECXPZMmSpuZZGjt0/v8bgEqchsnU5UrAvYWJOgcMlLJVOCsK5Okd4NJgITCzr+9+LiiSENO3UpGfIklZdi0cZTzBdfn99nc1tgRmYxYJKdNo4jDHl0h8Y6CsnTt+3uuK52B2Dw6x1YVWSMVnE5V/JnDLhSlbIzpLMZxlDfIdxKlMe+rXKYzONdCe+UnTG2w91dLtw4Dr4tXBvvgyoX10CQ1LVcBODmUibO+/GsiDGbUtNfG+ItDxOxKgrUUe999WXNSGafc0s3ld9ppf7NiAmw/guxK2hCbcZJDXWfKyoHgcHp3yS4LyjjLBJ1iUOjLkFA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2808.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rChIYUIv6J0MBjC6gJPqpAQ7lmMFW5ixPBRUCyCwTY+YKpnEbiI9bue/LwCH?=
 =?us-ascii?Q?SeUk44oIF2gPpnC5M8Q3wOfwAyNEwTNmeES38s83qCSvqn6d8yf1T8Jt/0HF?=
 =?us-ascii?Q?ya2sEf+0s/eQe2/hQ270YFvDjXpe5ZUJip7x85xwqUSAT5FNCufXy4I6AAEk?=
 =?us-ascii?Q?weD2QO7wB1Kbv++1EowUqfctg/rviebi3YhNb4R9fMXWBL1VNSsCEpAaNMjK?=
 =?us-ascii?Q?lMZOmcNbHlTc0ejtO0KvVhsY1Kj1zhsUCabOq3HhXVZZDFIWKJR0FF1ak8iJ?=
 =?us-ascii?Q?zXVlJfJCJM2spzRI6790+jbEl4xBtOgni/WtXjfinc+/gtwbcQdysB4x1r1p?=
 =?us-ascii?Q?7RnwbNTVs6vxN46vvpW++niTkAmPr8n7//+FhebYftnORYx1Q/EE58H2Oc3p?=
 =?us-ascii?Q?E2GOR3wa/e/UhZw09B6h9/DvZLXnTLWa2V32dMmDqh8Gg7/y028u7/qq9y/b?=
 =?us-ascii?Q?WLY+IZQEACcMlLNSAfotTjWnKv+Dx1i8tLueV0JxVUTg3+v55GAinLyLDnXE?=
 =?us-ascii?Q?vNI37J3PXZWrLitOIU+9ML7ogCwghZvbM7aT5btqE1m4YjR7Kg9sOInSuFEz?=
 =?us-ascii?Q?zYe/HdCbxWLnrKRt/Gcykw5BnFWx9RYteeZw1aa5ziQXrQVhN8BhuRS4hkjR?=
 =?us-ascii?Q?JokixTIaNWc/mC6FtZjHBrzENWE2RCNjZPAncjzEou8CA07T59H22C9guC5w?=
 =?us-ascii?Q?89vmRJE8rNzVlHhuGL4uJPQGrvnG91CZEs8xklot7ob96+aVQ9EvZW58pLhU?=
 =?us-ascii?Q?r+/cJ22BvCiBjR1AS3ZxyGO39CciEvA1KhLxbYj/ZhKZAowOrvwgPSG9bZye?=
 =?us-ascii?Q?mxe9zvLJGEBUuLqv6DNQcnMYTRhF1nZk3eoV2QQB2JqACrL1+AaRqPPhfOOP?=
 =?us-ascii?Q?nJUopm7C04jmBY3DxB2n2/d3g/I+1IaNyeVrkUKwuh775YT5UiWAYy0Xwr8p?=
 =?us-ascii?Q?h87QMm0TL47YJWxyn8NUrB4SzIlzDBY3MefV5wP4+XgsYTcRf9VZj1P/al44?=
 =?us-ascii?Q?J780fuw2ouYiBOIIYvUwMwFOwncNK7jJ7+vAZ8HWrsUMD/Xsarghin4+/IdF?=
 =?us-ascii?Q?PKeNOdUGUI9dES4uWv88u5RdWcOyTpXUea1sEXVhD7QHYuEXEjqOLh9LxaES?=
 =?us-ascii?Q?OLBFPKBhIKzLOZx0twjw0vdudH1ae3MkhbnGq2Udv1kUWd940d9M7o/hsn7R?=
 =?us-ascii?Q?PMIObHhiJ6dnk11iPbyzZW068IpbB8loNz9+Iz5a46/HPH8NcKYh0l6tbbMf?=
 =?us-ascii?Q?eBTBHsQoY2V+uWVNIH+PG5JvvWCMg0xRUAc9Ikq3Ro2EQxyCs3xe+YQqYvh9?=
 =?us-ascii?Q?R5wctfvlLHI6izYbH5l4VxG4M6h6u95AWACgs0KijgU4EcGqwVG9MmYxkUKY?=
 =?us-ascii?Q?f113hlbzxteyLydQJdPcb7tFIHvBTFYbq7s4NzYDueGEqyIUpILb1BYp8l/h?=
 =?us-ascii?Q?zKRmucnr9AtoEb3ge5NjS+MnBcGqhJ/n3mi4iCd9a8Yi59puLhf75DKkL22T?=
 =?us-ascii?Q?ieSnCvy2/utM8Y3TN2kqkAzG4VTf9kQevYFNgRGicz/d8y8CHdLYfOrZGat8?=
 =?us-ascii?Q?baEAJ02Xc6j8pOMXGV8WwXTZKgMz/shjRp5OsY9REjMbTC4cceS10xbb4jNg?=
 =?us-ascii?Q?P8ubnnV/NYhkFtdaRfv65KwgQbtL6rscxK8JmOLh/gLOV5GNzmmaH3+rNiHk?=
 =?us-ascii?Q?vLDelSday8JdH+gJ/biu9O+G2xE/fA1YFRr56kZ2XsIAVvApAG1HcSeOiZIn?=
 =?us-ascii?Q?5hSRJyEHIQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: qThAd8QdFLyLBiDN4jdrX9zjaRYD6o+RjyH51CEgr+8ZQMuIquABbZiOfVeU4+nOm54adtF9qvUD86WRufi6CfGtrCC7Fw13BND7GLLVXMBs2MfTDb6IXWm4z5xBC9noShlzT5fimei93ytevG6Cii3hVlnp04vrWvVuBkK54Cr4zISWOGAqECNM7Uhcu5NhtyWZC3Ij5bpqKRVnAo+0Cgs2T8XzwYjNTq5qVzPiPPEZHNaGmkyoJB1oIBSkGVJvHESBJyD7BOxM9LuAPWsJzGeu3H7uC+IvlaxaetPsf3eWZ9/AYts/lrVwh/GEW8MZG3NfnsGcjNHnCFf8EPefQg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 60e6a048-b7ae-4fd3-9bc7-08de97d5a4be
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2808.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2026 14:21:38.3937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lWmgxKdNhIayixvHH9rcPMLUwNu6WjkG1n3JHxQnCEqm3QpdjJfMsJpKoVIPoTEVy8cLZKQJs0f6nw+yLwSpuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7637
X-OriginatorOrg: intel.com

Hi Huisong,

kernel test robot noticed the following build warnings:

[auto build test WARNING on v7.0-rc7]
[also build test WARNING on linus/master]
[cannot apply to rafael-pm/linux-next rafael-pm/bleeding-edge next-20260410]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Huisong-Li/cpuidle-Extract-and-export-no-lock-variants-of-cpuidle_unregister_device/20260411-041527
base:   v7.0-rc7
patch link:    https://lore.kernel.org/r/20260407081141.2493581-3-lihuisong%40huawei.com
patch subject: [PATCH v2 2/2] ACPI: processor: idle: Fix incorrect power management decisions after power notify
config: s390-allnoconfig-bpf (https://download.01.org/0day-ci/archive/20260411/202604111336.AAgr6FPl-lkp@intel.com/config)
compiler: s390x-linux-gnu-gcc (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260411/202604111336.AAgr6FPl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202604111336.AAgr6FPl-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from kernel/sched/fair.c:42:
>> ./include/linux/cpuidle.h:230:13: warning: 'cpuidle_unregister_device_no_lock' defined but not used [-Wunused-function]
     230 | static void cpuidle_unregister_device_no_lock(struct cpuidle_device *dev) {}
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/cpuidle_unregister_device_no_lock +230 ./include/linux/cpuidle.h

1a022e3f1be117 Boris Ostrovsky   2012-03-13  202  
bf4d1b5ddb78f8 Daniel Lezcano    2012-10-31  203  extern struct cpuidle_driver *cpuidle_get_cpu_driver(struct cpuidle_device *dev);
9bd616e3dbedfc Catalin Marinas   2016-06-01  204  static inline struct cpuidle_device *cpuidle_get_device(void)
9bd616e3dbedfc Catalin Marinas   2016-06-01  205  {return __this_cpu_read(cpuidle_devices); }
4f86d3a8e29720 Len Brown         2007-10-03  206  #else
d91ee5863b71e8 Len Brown         2011-04-01  207  static inline void disable_cpuidle(void) { }
ef2b22ac540c01 Rafael J. Wysocki 2015-03-02  208  static inline bool cpuidle_not_available(struct cpuidle_driver *drv,
ef2b22ac540c01 Rafael J. Wysocki 2015-03-02  209  					 struct cpuidle_device *dev)
ef2b22ac540c01 Rafael J. Wysocki 2015-03-02  210  {return true; }
907e30f1bb4a96 Daniel Lezcano    2014-03-03  211  static inline int cpuidle_select(struct cpuidle_driver *drv,
45f1ff59e27ca5 Rafael J. Wysocki 2018-03-22  212  				 struct cpuidle_device *dev, bool *stop_tick)
907e30f1bb4a96 Daniel Lezcano    2014-03-03  213  {return -ENODEV; }
907e30f1bb4a96 Daniel Lezcano    2014-03-03  214  static inline int cpuidle_enter(struct cpuidle_driver *drv,
907e30f1bb4a96 Daniel Lezcano    2014-03-03  215  				struct cpuidle_device *dev, int index)
907e30f1bb4a96 Daniel Lezcano    2014-03-03  216  {return -ENODEV; }
907e30f1bb4a96 Daniel Lezcano    2014-03-03  217  static inline void cpuidle_reflect(struct cpuidle_device *dev, int index) { }
7dcddef6f769d7 Stephen Rothwell  2019-07-31  218  static inline u64 cpuidle_poll_time(struct cpuidle_driver *drv,
259231a045616c Marcelo Tosatti   2019-07-03  219  			     struct cpuidle_device *dev)
259231a045616c Marcelo Tosatti   2019-07-03  220  {return 0; }
4f86d3a8e29720 Len Brown         2007-10-03  221  static inline int cpuidle_register_driver(struct cpuidle_driver *drv)
6b2c676bf32be9 Len Brown         2010-05-11  222  {return -ENODEV; }
752138df0dc2da Len Brown         2010-05-22  223  static inline struct cpuidle_driver *cpuidle_get_driver(void) {return NULL; }
cbda56d5fefceb Rafael J. Wysocki 2019-11-18  224  static inline void cpuidle_driver_state_disabled(struct cpuidle_driver *drv,
cbda56d5fefceb Rafael J. Wysocki 2019-11-18  225  					       int idx, bool disable) { }
4f86d3a8e29720 Len Brown         2007-10-03  226  static inline void cpuidle_unregister_driver(struct cpuidle_driver *drv) { }
4f86d3a8e29720 Len Brown         2007-10-03  227  static inline int cpuidle_register_device(struct cpuidle_device *dev)
6b2c676bf32be9 Len Brown         2010-05-11  228  {return -ENODEV; }
4f86d3a8e29720 Len Brown         2007-10-03  229  static inline void cpuidle_unregister_device(struct cpuidle_device *dev) { }
163761198da6ad Huisong Li        2026-04-07 @230  static void cpuidle_unregister_device_no_lock(struct cpuidle_device *dev) {}
4c637b2175a0dc Daniel Lezcano    2013-04-23  231  static inline int cpuidle_register(struct cpuidle_driver *drv,
4c637b2175a0dc Daniel Lezcano    2013-04-23  232  				   const struct cpumask *const coupled_cpus)
4c637b2175a0dc Daniel Lezcano    2013-04-23  233  {return -ENODEV; }
4c637b2175a0dc Daniel Lezcano    2013-04-23  234  static inline void cpuidle_unregister(struct cpuidle_driver *drv) { }
4f86d3a8e29720 Len Brown         2007-10-03  235  static inline void cpuidle_pause_and_lock(void) { }
4f86d3a8e29720 Len Brown         2007-10-03  236  static inline void cpuidle_resume_and_unlock(void) { }
8651f97bd951d0 Preeti U Murthy   2012-07-09  237  static inline void cpuidle_pause(void) { }
8651f97bd951d0 Preeti U Murthy   2012-07-09  238  static inline void cpuidle_resume(void) { }
4f86d3a8e29720 Len Brown         2007-10-03  239  static inline int cpuidle_enable_device(struct cpuidle_device *dev)
6b2c676bf32be9 Len Brown         2010-05-11  240  {return -ENODEV; }
4f86d3a8e29720 Len Brown         2007-10-03  241  static inline void cpuidle_disable_device(struct cpuidle_device *dev) { }
1a022e3f1be117 Boris Ostrovsky   2012-03-13  242  static inline int cpuidle_play_dead(void) {return -ENODEV; }
87e9b9f1d86c2e Rafael J. Wysocki 2015-05-16  243  static inline struct cpuidle_driver *cpuidle_get_cpu_driver(
87e9b9f1d86c2e Rafael J. Wysocki 2015-05-16  244  	struct cpuidle_device *dev) {return NULL; }
9bd616e3dbedfc Catalin Marinas   2016-06-01  245  static inline struct cpuidle_device *cpuidle_get_device(void) {return NULL; }
87e9b9f1d86c2e Rafael J. Wysocki 2015-05-16  246  #endif
87e9b9f1d86c2e Rafael J. Wysocki 2015-05-16  247  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

