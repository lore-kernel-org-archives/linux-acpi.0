Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793725569;
	b=p8Jxp1R6HactHs5FP7/4k31EA6JX0BAvnl7aAF9BiRjLrugVFzZn5IaqMH6L7qbPIVYS
	 3/kkqXa0ICY1BbLCDSRyagf61rCebmyWxzUPR41dhM2me6ZLROp/2f0AWJ+AVrPcIDQbI
	 HgarU0zanOGzECKjoY4dTNRIZ6otpRZuOtWxS4phiohL+Zl0/lXfyPAzoCaz2nCloNLmx
	 JUr2RkSbCPHhy3ptrTbezlO0JdxuDzC1ZV3uliaW7ntom3YE6LKoFjaJFNVsqcQc15r4B
	 YdCyZKl/DGX0VlX7jMHgX5gq0I37E9oIEuNsZIcx7Mkn5x+JGWkBszF0g46xIQbEoJQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793725569;
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
	bh=l873VninDBUiKeh1WHAl+Vibl6xopVLfKVt0iMRQubw=;
	b=GbtB1DIRkCXFVMcKR4abWcm8Pz8sNv9Yw9NMFgDGRB1/BfMfi1tSAwYTl9IP7wtNQNOU
	 9dD3swLuWCY+ZbenWwefxhVG5rasFmqx0lXIh1tnlTIC+tj7mb+vhaNFABUFxBVp0MNoo
	 mrb3EcK1aYw2CHnzfU4E4WLN28WpxBTNUau1Y1TFJNaruCrJRDGgYqEKogLOeRsVnom9J
	 wRQWGG60mYhteBc2Q4664baLx9AmNqZNrN35sRaQstQpKj4I33j1HWAaxAk1Rw9tWpFW8
	 mm+Vm94OWX7kQs0AI3/TQM7r+eM4SlXOCmJ/XQSTxVxQdRcC38AFplGdOwKzY49q2dw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Bt1mctYa;
	arc=fail smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF0F606A324;
	Tue,  3 Nov 2026 17:06:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFF0F606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Bt1mctYa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793725567; x=1825261567;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Ppz/73dqWgbClPw7a/kwE9g5IzvJiy8nr36629DoINE=;
  b=Bt1mctYateBbD+++u8Mi0iVvWvCkPBOVOFjwipH9QJ2YON/sc0tEqYWy
   qvVxHp03c0BsFRWsC3eYbatWqlHjweOzkhMA8RRWe1ylAXGN0c/yT2/9J
   gYuka8nCsfjErJRbtNnLjd7VS6Buv/xTq6PHW7C7U+hkZOMxI6JF9o2Q5
   b3ybnfrf/ljLTxQ8O/5jhNP+KN7ygTr+1cuh5T7zK1BGI5eNjediG5mNi
   5n5WZ9JZN/6NZdXwkBAGg3sBtInyjwMRWUh4wl2KSa+COeyt3zXU/xSyX
   yI4IBCt/T6jfRq0EeZvyZLO7Oewozp96HjNoRV/7SBIaK5V24728Z+UPE
   w==;
X-CSE-ConnectionGUID: H2lMBep0SXeCMWT2RK+qhA==
X-CSE-MsgGUID: ipklqMNKTaazPiLGKUlCvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2467471"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2467471"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 09:05:38 -0800
X-CSE-ConnectionGUID: 2KvPU0AhSSOFvD3xopmgpA==
X-CSE-MsgGUID: R8UiEvPcTOSpx03goyodVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="8324892"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 09:05:37 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 09:05:36 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 3 Nov 2026 09:05:36 -0800
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.18) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 09:05:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TZoWKJc3h1p95p1ickBPGrSqamAUED1ujQEBSk3xGefd3qXETWuvl4E2FPHCtJlc+wvgpUjTHhEJOT32T/Z81+9STILR8kXXoxywXcgl26UUMHFdytttyyy3qm9XXtjJEmKAQnPmQWoSvxMjFOb+fHA/MtZBpVe3VpuC9UfpV0EuJfxFesV4oJtW6NnNOsgRgbGHxYKA/IAKaXLIZ3HkezoMicQTt6eqm/bEVDriv6+txhwM1X1avFrhdZ6NZhdP7bJ0S4YsfihezaX/tst27eQQdM+fUZmpAyxVErm5QQOWKw8LIiOBRLtK+rUB2Gvvcc+p51K/HAupgPK0TXTjyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l873VninDBUiKeh1WHAl+Vibl6xopVLfKVt0iMRQubw=;
 b=BnS96dOkPHkSgnRpyAwoePrxIjP92XBZ4iPyRBxsALW/okgiPewuCWrjrmov/GohooGBLIwbkamMQzIiXQtKeaAJ/ZCGi7lIVQbNvxOVZaXN/3qFFFfdwffN1nsYExUvujcrwhRqPKGCTJWzlib5LbTXb2fBEJ2Nt66KF5uCPt03EG+VybToLL/7Avg1omSQaBr4LhtNKAnYT7Kjzgf9nzphSLXpoIe021nXlHoC3RhX8/ox51MD/aJ87L3VErVdIbitavdnsfU9wKipEs7y2P5oKhhBSKG4tzvvKiJ29A5tGtYiKBn9xnPVajV8wlAndOau2yIVgnH4abHulRRMag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH8PR11MB403433.namprd11.prod.outlook.com
 (2603:10b6:610:32f::10) by DS4PPFE70B31BEF.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::5a) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 17:05:28 +0000
Received: from CH8PR11MB403433.namprd11.prod.outlook.com
 ([fe80::b087:96e4:50ea:b5de]) by CH8PR11MB403433.namprd11.prod.outlook.com
 ([fe80::b087:96e4:50ea:b5de%4]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 17:05:28 +0000
Date: Tue, 3 Nov 2026 09:05:26 -0800
From: "Luck, Tony" <tony.luck@intel.com>
To: Kang Chen <k.chen@smail.nju.edu.cn>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Borislav Petkov <bp@suse.de>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ACPI: ADXL: verify component name types
Message-ID: <auoUVk7-jBYwmvvB@agluck-desk3>
References: <20261103114149.76010-1-k.chen@smail.nju.edu.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261103114149.76010-1-k.chen@smail.nju.edu.cn>
X-ClientProxiedBy: SJ0PR03CA0082.namprd03.prod.outlook.com
 (2603:10b6:a03:331::27) To CH8PR11MB403433.namprd11.prod.outlook.com
 (2603:10b6:610:32f::10)
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
X-MS-TrafficTypeDiagnostic: CH8PR11MB403433:EE_|DS4PPFE70B31BEF:EE_
X-MS-Office365-Filtering-Correlation-Id: 819ee725-6f94-4fd3-5f20-08df39cca926
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|18002099003|10067099003|56012099006|22082099003|261009223027099003|261022075727099003|261022105027099003|261021123027099003|261021121427099003|261102123227099003|11063799006|261028144727099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: hEh6yOX2iNKgOSDfoLsOyR0qjbpwR+yoxpP62l7R1JsMkTyyC0TPIrujwPhMgz8ko7+tucIF/cxVzlruMdfjRNpq1MYm1+NS34g6yqNAhSJcrkiqah7DdTLv6R8h8GMIFX7syDoySkUvWw4ZylNAGM+t5Sm9UySWKynOwdRQAm42E4xyoefZEG01+onEaxXOOzbkAAiwql4Y2pYJR2ulJmrJViH7Pfm2fMbLOtCNmSmdaB+MwPgSScm6nwBrnR+CFV5+gFjA2IgVhAAdCp33dcmqeoClexAqA5wLhINKSplPvaJTwDBKf9SsKq11D9EWUR5y2Hjiq/L0OboZ+TOoAdkLEhKpfydvQdIONj1Evd1Kbvq2fGgg53XIhi2thyBMlhjpaAL8BiiWz6gMYHnhMHOHLU32LYMaZkiINRn8R2O2/FdM6WRFq/F3riOwXbt8iNTPs1qkwbHMUAot8gNfeijuFEJ6fuxIYbCgvhMqsVY8RyocBu7pNlbkdkVTaq1fcQ45SvygjupnMnvYEw92qiQOQ96NmjUQjhOJoCXxyeZ7bCjzMvR1/rL3t+csHNHyPXm0XVY71nHB7Kv9RVDsd8WgWZMHcad6DEoEfWTdIpw+GmM6APt8S4NTqUtUhWRmVOGdm6WMYhOfUYTAVQLJfThnVd+02nw2r+MWuQ/5c3w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR11MB403433.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(10067099003)(56012099006)(22082099003)(261009223027099003)(261022075727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261102123227099003)(11063799006)(261028144727099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nfAxd1BI0P1p7n8FFJoMHTrGmEEn8wTyETCZy8aPDxO7CoN1SDisHSNFGXIQ?=
 =?us-ascii?Q?MZ0Vyc7MP8BEXWNAhE+TnNZ92S7WJXgT3H3gFVpapfWgLuzeyuJiFwyuwMvi?=
 =?us-ascii?Q?+opXv/Zk/hR6KOZqj9H/JcnCY8p+1XxcQYQnFf5T0wm0wUU6A8ySA7OfByoT?=
 =?us-ascii?Q?CXhK2vwwmTSnWI31rQfsj8yiPfL6PA1GzrNBcrMLoP4WPsXTd7HIoAd7aF99?=
 =?us-ascii?Q?rVe2O9nChEB2/I+U2E2TAGhNciS6TtYeAFwOv9OPGTqPwEcWKsv3ehLrVbHG?=
 =?us-ascii?Q?6/L7RqHjmtFHNkTHgCanaiwLGUS1ZG6scAOVRPWA5z17f/gYJr7zdJWvaWQu?=
 =?us-ascii?Q?QVWRNWhMj730Ts+OXlkMI5fpVM/FbaEkWGLP++RQ2LH6JwzXLuOLUaVMgbpT?=
 =?us-ascii?Q?McIsutRyY11oQZ8OdBxiHQvSCiL+uXi2YINZkMHr84nwKz91IzoUVoDpqJU3?=
 =?us-ascii?Q?hTRrvbosZWuX4yfmCcW8uxZ+ipi6lAuvCgH0NC40vNXwqG8ETGHaKOWJwN4i?=
 =?us-ascii?Q?QGnbGnOvknbQa/znX9Lo+Sn91Cp9ngneShDmTaWLzF0kPD1LtBErvqRreVjR?=
 =?us-ascii?Q?IY5J/sVgfTGqIYo6OyxIB0M2XsXIRrWgdT8zN3ozDnW+62F4/vsUnikakkC3?=
 =?us-ascii?Q?Y7DzUXVKkTxm8RME/6s/n7xPX8vodbCDqgqfutVkskd3dA1XURbabseeylec?=
 =?us-ascii?Q?7/elZsZ+4Dw9C6EvVvuTyCzvEyese2NAPfutefy6wqqrgn7zkcEgTr/+bFD1?=
 =?us-ascii?Q?pHPwrpfMQ06u/sh95gxps2vDW8Di7TDHKD+QWDCpSofTwfRsD/l2K9WQJ0NK?=
 =?us-ascii?Q?h8QdiOBjtupSMgobepFNKA0uh5JhlsEjcIwW3Tw41UB8mQL0lYY2n7Fo71ET?=
 =?us-ascii?Q?EYKHNvfbr0+4hROB/THE8xv6Q+HFxS+wLQ/WncZ49yTiie8kCCxyC+uhYbWu?=
 =?us-ascii?Q?+dq0sm4Me0vH6a2BwaUjZTYs6ww9/YPe3dR6z3uQrsUA+B9xnco00F6VHIAV?=
 =?us-ascii?Q?QBZnh6A6Kpp12GQEsXQYspho8di67R7RwotGL3Z0Zj2LL8LoC5l8+Fvn7NwJ?=
 =?us-ascii?Q?Ta7VoBRzmCVyLylSCpGelGf3jLIc2TZW8umXR5EFywps4NBNbbOFzK0/bLYL?=
 =?us-ascii?Q?qty8vCINDN2xOWSHsLe3Hh89/VaAw3fLK+IaANDyrrXinfKPXJqG9BANq69k?=
 =?us-ascii?Q?cbnE6ykD0UIJmjbEqC5fqlYTNePmBteuHjFFHAczKlrqIJcnfVjQBKh6cvpt?=
 =?us-ascii?Q?/CHMIdPOmkjkE+4L1YUpLDefbW/wWxsrqgSDC5rrYwX2qbSpzz9XFtdlJnZa?=
 =?us-ascii?Q?vG6JKQxivmr9Ym1Wta6Aqde8Yhzj2qjsXDR0ZvMf4t6P8P/rSAoSsylhZzSP?=
 =?us-ascii?Q?Zp+Xctl+ts3HhEzQPaW9zkP3zFHexAK9ce7TbKJRd4WYOBeUe8Omzd22sHvB?=
 =?us-ascii?Q?PzumuB0YSZ9sKAPFivrHZiaJmhS5qasVLFXl158D+B+93L3Avl86qyZ8V74X?=
 =?us-ascii?Q?alND/Sc66FyRGB70GeObR7uErs5DbJ+mgltagZx7B57vb5pLLsXUzcGXtadd?=
 =?us-ascii?Q?NHs+LCdExpnlIEs7dyMtQaE48WXp1K26Fu2fOAGjdPLm/90GYAQ2HZXfqpv6?=
 =?us-ascii?Q?QUYvuLVcze/SSQsJmlJm+QYAKBzAO5JkVQwolT/MwMuz9RXSAjLyMJAU5OU0?=
 =?us-ascii?Q?xK/wvzq4KfC91l/gW1Y8YnyyFpTmK4hnWKAQpS7sO3IVVDFz11CXIfnrFxqF?=
 =?us-ascii?Q?o1v7iUKm6Q=3D=3D?=
X-Exchange-RoutingPolicyChecked: VkJ7yhy80l3o/KQCnXP3KicFYqCPOSFYFaTBZKy2SDyh5S1KCUKkMCtU0x0+Ur6zwoQkvlhf4DVHNhP1XGDAPnIuZKWklmi+bfVc2aoxakGGekmB7jb5IC7EfaArvOPNS1b6Afud9D8qKX83zVjLQQgL49pq6pAqxs/ZMmEeWqFLj5q0gTSiLM3Yywe1XHq0eBtyaB9yJMjtQr5n59zzZKAmoQm3d8BZ9mtobOV/ES+DEpo13cH7Yr9IozGpqDB29s+3mFntzNSMpqjpEU7Ns8gXN4AH/jfD1z0goGF5H7qcyDoJu0bPia2ml2a8tyl1kEej60q8KgeIJ4LdRS7LSA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 819ee725-6f94-4fd3-5f20-08df39cca926
X-MS-Exchange-CrossTenant-AuthSource: CH8PR11MB403433.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 17:05:28.4663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1GmF69ZnnQECEP2tMw7jt1OkXR/wxzvyygMwXUygSvDwwXRTk7/QO/3oezoDYxUptVUYqmFrLMFHKN9bHvLuKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFE70B31BEF
X-OriginatorOrg: intel.com

On Tue, Nov 03, 2026 at 07:41:49PM +0800, Kang Chen wrote:
> adxl_init() stores p[i].string.pointer for every component name
> without checking that the element is a string.  An integer element
> makes the pointer the integer value, which adxl_decode() consumers
> dereference with strcmp() and %s, causing a wild read during boot on
> machines with an ADXL object.
> 
> Reject the interface if any component name is not a string.

Has this ever happened on a real system? Or is this just an:

	"AI told me there was a *potential* bug" 

issue?


> 
> Fixes: 4cf841e39850 ("ACPI/ADXL: Add address translation interface using an ACPI DSM")
> Signed-off-by: Kang Chen <k.chen@smail.nju.edu.cn>
> ---
>  drivers/acpi/acpi_adxl.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/acpi_adxl.c b/drivers/acpi/acpi_adxl.c
> index 13c8f7b50c46..de646b312eba 100644
> --- a/drivers/acpi/acpi_adxl.c
> +++ b/drivers/acpi/acpi_adxl.c
> @@ -184,8 +184,17 @@ static int __init adxl_init(void)
>  		return -ENOMEM;
>  	}
>  
> -	for (i = 0; i < adxl_count; i++)
> +	for (i = 0; i < adxl_count; i++) {
> +		if (p[i].type != ACPI_TYPE_STRING) {
> +			pr_info("Bad component name type %d\n", p[i].type);

If this really happens, then Linux has a way to point a finger at the
source of the problem:

			pr_info(FW_BUG "Bad component name type %d\n", p[i].type);

> +			kfree(adxl_component_names);
> +			adxl_component_names = NULL;
> +			ACPI_FREE(params);
> +			params = NULL;
> +			return -ENODEV;
> +		}
>  		adxl_component_names[i] = p[i].string.pointer;
> +	}
>  
>  	return 0;
>  }
> -- 
> 2.34.1
> 
-Tony
