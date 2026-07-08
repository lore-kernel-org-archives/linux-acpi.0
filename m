Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9BB280CD2;
	Wed,  8 Jul 2026 17:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783530888; cv=fail; b=SWrZwjlo0Terw07YwdADu5PyTVuWRFzk8XV7dvC52FlnLPnP7noR/lCQKob+DM8tgK8pmWF104tNyhKHmPS3i7UT7f20/V0lWpY++shmQzFFrWrMK+eWZXiqjcSDvUJZ+BvFUqCh+dqsuG6wnlLafnEy3cP9LrP+ltOp53S7UOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783530888; c=relaxed/simple;
	bh=M3M1GltE/J1Jn1JDibTVw1so+TgsZq82VLvqHFyopvU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rri60ykCCrhma367ppEhfleIN8FyCe95HvqNdt0irCcM9h/FXT51MNYMqm+K9xbSN8YFcqD4voqZAm6JDsOUua88tdfzKocGl+ypO9v5AO5dhs7VU0QPoBUMLvB+Diha12ZkqtyrZJOrsyxL+Kgb0YWrSKobepW3m/kpm6wv1MI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Aj7T/6um; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Aj7T/6um"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783530886; x=1815066886;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=M3M1GltE/J1Jn1JDibTVw1so+TgsZq82VLvqHFyopvU=;
  b=Aj7T/6umi/qN604xrdfsE1B0m2/pX0hSBZjBOG5f3yqhzw8nbhLzadkI
   LKWdScjay79JeY6WhskIZCizHef59AiZFeUrq6sHtW5DZrc4BKvDgI7uS
   oNDg5Hjd8fClkVQGPdXB7mMm4/VBEms7oM+XaSOLMuQNiqRRC9x284L/G
   udD9OQy4nhXCLS//k0uoqAO48MI5v3ErguWwbIbWjddHTw2WrYkHcJYqp
   skbSnrQptmycDmmB+5BdAzNn+3xUnxhenxJxPngg2/rNqvECAeDV/6/e9
   g4Pdyo2ZZOG0OTXLobqC+cVpIZbGJE7EqQOVrhV3Ec50fTqCSVUY2tRgI
   g==;
X-CSE-ConnectionGUID: XrVu2I5uRGCQ1AqMFwHWyA==
X-CSE-MsgGUID: z6H9xf7bQ/GoTtUpGNHoNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="94848802"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="94848802"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 10:14:45 -0700
X-CSE-ConnectionGUID: WpwKOYGdRD+JYp1cRATL9w==
X-CSE-MsgGUID: cGIHEY1LSYa94Fc1zZBkvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="253262600"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 10:14:45 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 10:14:44 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 8 Jul 2026 10:14:44 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.10) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 10:14:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WfVyg0fAcZ2zHFLjO23sk0VJ2HROk7nEcNnAcl/jprJwTlJP1+POFAjJ19iUWVrMt7YLjEtYmm0A7/kS2iwRhLQund1V3F7W0FEKvAaFg1FxKPW8A3Sps8T1Xll6IqWxls0lXYYX//ggbx6PYMSGeBFxJe7mcfBsdWn26XfwIqu0g91/CnbsJM61aeQs4mcmFLaftxzXRjMbOX4ygHTa+KEWwAocbs9XImyqpMJ3eBS1ssRHVlWPzKgtw7eRYfFKexvG8AI83broXTA4gBretvJT8NZXNlbKEb6NSdTWfzRXixuCS2MSi9RDK59RFGV5sF6kO8Ui6X4GBfKeWxQc5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BV+S9xbrpg55tfs/6yKumY2DEI7TONy2nI9VNXDefz0=;
 b=L7o7VTTzEOaF1TsGdFSDLFFyXrRiV1R3LeCX5zHOJVBr9BW69ix/0QvEmRdpTFu1jhgm0/daV8/9e2egVdj7/xMst3fzB5e3W7eGEhHM+ocTfIxnC2seV71iRM6CThjChvsyxrtkuobHHRk4NLzmJKD21eP34aeUqReHKzoMeBqgeo2mUaZ/c3XBNwMcVwH/BQVYwB5Xmv5Qwz2spcILxWARc4ADLc39Pxkx9yMgFM0zq3F3dqr+mFrqrkFntXdwODOVVMwKkeuCeKUhzcPXtXY8P/uoCcxtYJBnQO9Y8FlGq0RorvjUlKgcfPnVWtUJm2NCys8its3+XU4VsKRiWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CH3PR11MB8658.namprd11.prod.outlook.com (2603:10b6:610:1c5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Wed, 8 Jul
 2026 17:14:42 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3454:2577:75f2:60a6]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3454:2577:75f2:60a6%4]) with mapi id 15.21.0181.008; Wed, 8 Jul 2026
 17:14:41 +0000
Date: Wed, 8 Jul 2026 10:14:37 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Junhao He <hejunhao3@h-partners.com>
CC: <rafael@kernel.org>, <guohanjun@huawei.com>, <mchehab@kernel.org>,
	<xueshuai@linux.alibaba.com>, <jarkko@kernel.org>, <yazen.ghannam@amd.com>,
	<jane.chu@oracle.com>, <lenb@kernel.org>, <linmiaohe@huawei.com>,
	<bp@alien8.de>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, <tanxiaofei@huawei.com>, <linuxarm@huawei.com>,
	<liuyonglong@huawei.com>, <mawupeng1@huawei.com>
Subject: Re: [PATCH v2] ACPI: APEI: Handle repeated SEA error storms
Message-ID: <ak6FfacJrg8Elnl6@agluck-desk3>
References: <20260527082707.2013499-1-hejunhao3@h-partners.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260527082707.2013499-1-hejunhao3@h-partners.com>
X-ClientProxiedBy: SJ0PR03CA0351.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::26) To SJ1PR11MB6083.namprd11.prod.outlook.com
 (2603:10b6:a03:48a::9)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6083:EE_|CH3PR11MB8658:EE_
X-MS-Office365-Filtering-Correlation-Id: a4cfa30a-b9e2-4b7c-641b-08dedd1464fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|7416014|1800799024|366016|376014|18002099003|22082099003|6133799003|11063799006|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info: VlOVoFs7nNzOMaSIfm4B04/Cwu6ZwyEpuaLmv+R/cMNpGOlmZBfmbvEYFUlDeaEsQVgdXrSikLpgLKrNWwQq3ChJ8el81QTkh3CMg4vTMxtTew1BDRfhLsXoARbyuEKZSveGuXsSg06Gkx6RmD+CWXLWmMnyjzwTEbWXmKCfQmmMHvdDeKm7H4ORT3Z7r8qgHv15SrFnamU5r/xMqAZTG+D+5dD1xRTJPHtugWNMdR4JpqycodPuJZ1rLPRV9rdUSpUEFH/56K7+TqgRDplgxRXpzCDlsS2gMzLn7c1RxsohITQPlJUcyMVRHTf68Snr3kiswRbK4i8iwFtfq6HM43u4VqwgXjBUCWnGo/+uubY6i5Ey/FqwLu/1kc4gGic8sI3IWsl842jtMgIvxgsFz1HCbhdmrx+rUQRat8k3aPt3PJP8J1t5Hh27BZg63IONF8gACrKAN3++HzF/iP2r2Q2RMHqOG2FHTe45SMTxLtuos2nUFDUWL8z0GjBLpyHiJraF8w+bUve6U39g9ZJWVmTuxKbggSlOaLlh/Lxf5/phHEf0YqCtTfdqVVA+LbqUEQv4YQl/DlH5zelhAIfE7Dcx9wxlBHw/O+6YPePOnwCXJFhz3pNCW9CLcBxTvpCArkuuwhhfK9PriT27KTZRp/m2x28r8GtyUpIKMX0ueVg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(1800799024)(366016)(376014)(18002099003)(22082099003)(6133799003)(11063799006)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v01RMKAw+s/qa93HYt2jipBQRb0BmciZilOwS6LGRJ95CYcYC1dx9yE5ieWR?=
 =?us-ascii?Q?jSqkRWCxm5h/bIKXR0a1/kQz9BV4x0rMPHWmyhNn4RdHcJcx2c+Fx+BJzAll?=
 =?us-ascii?Q?nBP6w2WNaa+TgjiPhzl9GD9j1bIDX8L5JTO9mi358+NimnTlXO6TfTUUtdbf?=
 =?us-ascii?Q?21WsGmhmLhz6D/5PA4E9sufJdYIvLwT/3AJh/h9kaCtg545cZtQPj8671msX?=
 =?us-ascii?Q?0BYJud5e0wGUonwvjRaO55+wl0MvDTXTPGhQECeI2TB95d18S6DBHQH37l32?=
 =?us-ascii?Q?ZpP/d5vxlxKYN3QT5dXNCjt8OttXcyYwXpc+UmfqNTvMXaUCV3rV6s1s3D7z?=
 =?us-ascii?Q?8C5eJd0bgaZArKaL1iETNYZkoVmua8MS94lJmshU0ouINFNzU0O1MHJ4/4h2?=
 =?us-ascii?Q?PomkJ7NwNOkvFrkTqx3KStG66OneeyxMj9GyyTQ+KNqtiZe3qWLY4vEYGnxA?=
 =?us-ascii?Q?wp93F2Eeh77dhW2QK3Pp1dQyALy6FkBR8appL2D7YgIMMJsltOfz8RrRXLy+?=
 =?us-ascii?Q?MVKpB0kEKOTyZ8Fw5XGHLwFuDAk5L3fvQooy+uUQJ8e6tVK/NyN5AxtoDUQg?=
 =?us-ascii?Q?tOg5L8BnLZ5eS7N+MWRkBPS8Xnpo3zk552um1fqGTOMNxgIsq7blYTcIYu9g?=
 =?us-ascii?Q?C2wBh9lHgTwcpBNcQh+4pKnjEWlFU0MbQ8wCPno+QRyRN3KXxNnz3ER3Wygk?=
 =?us-ascii?Q?XMBzi26eAe+ftcIVSM4omI/ap4VaxiTdGXBW9rihp+WhWw+VKTpmBDsyrlyj?=
 =?us-ascii?Q?hxE5vByigZFu5/89jUwnTkhnYpv3TkySMJTT2axFnDbea4+iHdX6lTr9s0Vr?=
 =?us-ascii?Q?1B2/vyDmhAuVyAKxCO9PJ9Dxsi/Kw0QNAoow0khZfQmuDelXHBXozBEPDEhj?=
 =?us-ascii?Q?80afOI4AeWqpV/EtB2TvQWuRAvPozRuPp1iz7XFESSOQBegsc8kVlJRlwB26?=
 =?us-ascii?Q?51L5oGYmSoGKBg5vhByLidOLK/VGD+JJGToAaIEDMNmzPW/psiRZuEPsplKI?=
 =?us-ascii?Q?vtl0NNBMJYm8xQmf+oMaNjYDP/Xi/qakoZm3P/dL4kNBHgSw3OhIqAaf0DdD?=
 =?us-ascii?Q?sKhVh+xphAwBwX410g7mQS54dC5m2HD5ZZc+VXE6M9aTytdAnoLXv9xv/fXW?=
 =?us-ascii?Q?NkPAECtPcOE+U2l2xdBcwPubj0YYEluqJD2busaoh9RCBpTfYVsdyeIYDeEu?=
 =?us-ascii?Q?VFYgC9sLI6yrGI4PIMPNTjYTioBJVKX7JgO9NX6aRLBrNqo+a/CZGTCM8S+J?=
 =?us-ascii?Q?7+lGnPbpOO0z3d+NKsGc9s1JhQb93vxZQMP/BwMc0ZIUwTsXmfJI/WiTtdUb?=
 =?us-ascii?Q?edfxB32VLIWbopLmIdiV8X7xM/eKGql7g5St+uhL5mMLoGyNirHnGX23vC3k?=
 =?us-ascii?Q?o5Y40eV27KQEE7ocfSve3SCyUVRAm0mZ4a9ZkvjAzopq18iRV8ZtAxiUFbEs?=
 =?us-ascii?Q?Y2VV2VlGd6zd87lNDroz6xPgLHFtId9Lc4HQdpIIOE5BNXKh46PTqnYzmQz8?=
 =?us-ascii?Q?FsGLNFYWcfN3+ADMLDC6ukb2+CIDBrIdmcA3SvzyvP053ufzCIF4KWsseq7D?=
 =?us-ascii?Q?5jzWEfdYEzO8K1/A6pKUOfpDj5psr2kMvEnVUr7hkOAh69aJyT5ig3UwPbiF?=
 =?us-ascii?Q?6pGUjT5QGJzvilzTZSUygP8TWBxyYbfzbazor8inwXtr3zaP2eVau8JNS4R+?=
 =?us-ascii?Q?XFHFb2wCJKUzj0/PmYmfaoZH+QGggfHNaDNaUABxIViZScheZ8RmpBlFk7wM?=
 =?us-ascii?Q?ulaQK8OAaw=3D=3D?=
X-Exchange-RoutingPolicyChecked: iiQ5ft95QGRKR/sH1cNuHNc9hCwpa/c+RFH1NL3sJsxAtn5S4m9I/u1XPV2POAkTpBcDjIDFD3lAvPL2z2GlfgsRi6Su7YLM/BVKrZRbEWidMJvNUtq/WaRfREAYWKap2iUGa0RJWgxIxhTcpWhSn2cpFVa97ZvSmslhLkEezUia0HyV4gPYd4yLHR414HSohrTojcvFDobIN/RLvmayQhevwYXj85sctfJ1uIO71o0D7fOuFPgh3Nx6ey7XacNQycnR8q9QvRWKTcuOWllLQ+21RL9KaCHs+lL62cnq2F+UEns/dQL1+tMrf+lKo26+PTN1QuPHUGokR0FRvcRkZg==
X-MS-Exchange-CrossTenant-Network-Message-Id: a4cfa30a-b9e2-4b7c-641b-08dedd1464fa
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 17:14:40.6854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +bhSKAgHpgdQqT6ardMVRse1I8Bqlut2S/kAFh3GDn/to3iyCjeIkWjntKgZW/QUzzP2BSpQOoeFGdu3VOn2WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8658
X-OriginatorOrg: intel.com

On Wed, May 27, 2026 at 04:27:07PM +0800, Junhao He wrote:
> When hardware memory corruption occurs and a user process accesses the
> corrupted page, the CPU triggers a Synchronous External Abort (SEA).
> The kernel invokes do_sea() to handle the exception, which calls
> memory_failure() to handle the faulty page.
> 
> Scenario 1: Memory Error Interrupt First, then SEA
> The page is already poisoned by the memory error interrupt path. The
> subsequent SEA handler sends a SIGBUS to the task, which accesses the
> poisoned page. This flow is correct.
> 
> Scenario 2: SEA first, then memory error interrupt (problematic scenario)
> If a user task directly accesses corrupted memory through a PFNMAP-style
> mapping (e.g., devmem), the page may still be in the free-buddy state when
> SEA is handled. In this case, memory_failure() will poison the page without
> invoking kill_accessing_process(), and then takes the free-buddy recovery
> path.
> 
> After the CPU returns to the task context, the task re-enters the SEA
> handler due to the same access. However, ghes_estatus_cached() suppresses
> all subsequent entries during the 10-second window, preventing
> ghes_do_proc() from being called. This suppression blocks the
> MF_ACTION_REQUIRED-based SIGBUS delivery, causing the kernel to fail to
> kill the task immediately. Consequently, the process keeps re-entering
> the SEA handler, leading to an SEA storm. Later, the memory error
> interrupt path also cannot kill the task, leaving the system stuck in
> this repeated loop.
> 
> The following error logs are explained using the devmem process:
>   NOTICE:  SEA Handle
>   [Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 9
>   [Hardware Error]: event severity: recoverable
>   [Hardware Error]:   section_type: ARM processor error
>   [Hardware Error]:    physical fault address: 0x0000001000093c00
>   [T54990] Memory failure: 0x1000093: recovery action for free buddy page: Recovered
>   [ T9955] EDAC MC0: 1 UE Multi-bit ECC on unknown memory
>            (page:0x1000093 offset:0xc00 grain:1 - APEI location: ...)
>   NOTICE:  SEA Handle
>   NOTICE:  SEA Handle
>   ...
>   ...        ---> SEA storm
>   ...
>   NOTICE:  SEA Handle
>   [ T9955] Memory failure: 0x1000093: already hardware poisoned
>   ghes_print_estatus: 1 callbacks suppressed
>   [Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 9
>   [Hardware Error]: event severity: recoverable
>   [Hardware Error]:   section_type: ARM processor error
>   [Hardware Error]:    physical fault address: 0x0000001000093c00
>   [T54990] Memory failure: 0x1000093: already hardware poisoned
>   [T54990] 0x1000093: Sending SIGBUS to devmem:54990 due to hardware memory corruption
> 
> To resolve this, return an error when encountering the same SEA again.
> The subsequent SEA handler invocation uses arm64_notify_die() to send a
> SIGBUS signal to the task, which terminates the process and prevents it
> from re-entering the handler loop.
> 
> Signed-off-by: Junhao He <hejunhao3@h-partners.com>
> ---
>  drivers/acpi/apei/ghes.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> Changes in V2:
> 1. update the commit message per suggestion from Xueshuai
> 2. Add a check to only return failure on the ghes_notify_sea() path,
>    avoiding impact on other NMI-type GHES handlers.
> Link to V1 - https://lore.kernel.org/all/20251030071321.2763224-1-hejunhao3@h-partners.com/
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 3236a3ce79d6..787664740150 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -1383,8 +1383,16 @@ static int ghes_in_nmi_queue_one_entry(struct ghes *ghes,

ghes_in_nmi_queue_one_entry() is called from two places:

__ghes_sdei_callback()

I think, but I'm not sure, that you are addressing call from here. By
returning -ECANCELLED this code skips the irq_work_queue() call and
returns -ENOENT (instead of zero).

ghes_in_nmi_spool_from_list()

Effect here is more complex. Depends on whether there are multiple
ghes entries on the rcu_list. If there was just one, and you return
-ECANCELLED, then irq_work_queue() is skipped. But if there are multiple
entries on the list and at least one of them gets a zero return from
ghes_in_nmi_queue_one_entry() then irq_work_queue() is called.



So which of these callers is the one that needs this fix? And is the
other called OK with getting -ECANCELLED error?



>  	ghes_clear_estatus(ghes, &tmp_header, buf_paddr, fixmap_idx);
>  
>  	/* This error has been reported before, don't process it again. */
> -	if (ghes_estatus_cached(estatus))
> +	if (ghes_estatus_cached(estatus)) {
> +		/*
> +		 * Return failure on duplicate SEA entries so that the
> +		 * subsequent SEA handler invocation sends a SIGBUS signal to
> +		 * the task to prevent it from re-entering the handler loop.
> +		 */
> +		if (is_hest_sync_notify(ghes))
> +			rc = -ECANCELED;
>  		goto no_work;
> +	}
>  
>  	llist_add(&estatus_node->llnode, &ghes_estatus_llist);
>  
> -- 
> 2.33.0
> 

-Tony
