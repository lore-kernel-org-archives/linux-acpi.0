Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793781637;
	b=4gNS3aaWbrteR+MHxqldPYQUtIJs8ju1RvaNNLtBDqrBiT5KICUhU0PnIpYZ/9DhZPoQ
	 zlhZt22pn3iDulDyP4LMZeNqagSjGUVbTI9Dwe2QpSpSCD9exjEVUvQusjn8RedgDqmvi
	 38aDb3qqlNVFq9EWWNpXE42TSLTpJHKeLGefv2MV01vmB7C6aK905pazBNVO5ItQLOTKv
	 0qG9yZTVu+bReRYD6CW4eZoqKD7V0n9HbT1NZ7U6C0gh20WTcUo9wCNdw7d8p9zBniRmY
	 fpWv3NeV7doU4fPYAvKwGLiFB+gPfmJpOpfsUj3HsXQPmru6jGDAhpyYpneWj62qRsg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793781637;
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
	bh=fzHD0dpSFMkBfHM3oACM60GC0az+FqoHwuhbNHWUDwA=;
	b=vwn5hUK02O4WX89K8rHOf8e1IDnNniQjCS/s9vfqpJpupbHTVafNkDZYUIjo67zL2FRh
	 JJ6GB5Y7qbf2ErwjiSACEgsBT07uk0mJaRr2GDliK4hmzRU/Wub3wgoPR1ES2p+fEcu6h
	 uLDtE7OLAQo4I0UGiK2WY+RZO3ZoydXih3zSjUAJtx+MBSaBNIW7ZF5EMFi0M3Qx6TLMw
	 ivtzRK7g+v25eVFUBS5SVXoNLhVId8v7FVn6q95zw4bIuIsJRwtuRl+l1JMVaBLuFWjjY
	 tbNb99L2wHNtlGxQ073v8R0dcn5oLKeAjZCdZEIJG5ZaNeH58U+aFF2NAMvtZ/t6dCQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=X+rSBSg0;
	arc=fail smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26B4606A326;
	Wed,  4 Nov 2026 08:40:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B26B4606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=X+rSBSg0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793781637; x=1825317637;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=n+0mXl2gY9r6DReVRzsMBYV1gekr031mbSxtQONblZs=;
  b=X+rSBSg0JAmz4TBHiodQgYpurSc37Z/XwOdFUw82aX4vagTh0f28y4sE
   6cJV/YLvyFLklAX7gWeQ44jH9djMGqQlKI/584DaYpcUEzHauPc6aROCS
   iP9/XtPpZGHN4FE+/WUc5I98r/wH1gSSxufNy4wqtLQ6Ycr3rlVEqZy2i
   NrlY3K+1pgshwLoQH1s/sSt/s+bavZsOS0cnocQ9+N1YIQj0xYxfYsIuh
   1cV09XnOb/nq1MiRq+T2GOSVeqvsf2jgPVIhhRETjxeH/YRdzRSXRKatj
   ga6rxsAk+TLf031oDbnFX4CSeDpQrBfB9YCiNb1Dnk6bhvHM/uCqg2gsq
   w==;
X-CSE-ConnectionGUID: U3RO3iZrSwWEs+JiSuoNcw==
X-CSE-MsgGUID: TBt+Z1BaS9i13W3VRn9daA==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2541944"
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="2541944"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 00:40:36 -0800
X-CSE-ConnectionGUID: 6uzvXt/HSHW8aUeGQyO17w==
X-CSE-MsgGUID: kPGD+25yTSSaucbUk/avjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="6670360"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 00:40:36 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 00:40:35 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 4 Nov 2026 00:40:35 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.55) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 00:40:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T58+JFhb1zlbnz0eV229cwq9Xh3Gps+gOj5FZsqPJ85PAhcTVK38PFfD0TilwcNa7kmd5OM+ywjSuwD34PP1jXrVxIvqvA/JAjpmQ6ZhhXozn2BwGvqcp41bEokCmeuKdhOiHlfOxweu15HpIgzV1f1TAJHqFNgoi/mK7cL7Mn++z90NSxmNYnSp2SXJA6TJJEm9Uxe0V9lb+PzMmhtSjt9qdni/2E0kCoAj9CLOKcM64B4P3kf2AXvSZzWvt0MFAnXHifke0aT8QiRHvlqy6OiI/zG0l+LNs3klA5sRLmWOLQf3DyBWnptreOPP+fr2UmxjeHYWzplIwpm7dmpHQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fzHD0dpSFMkBfHM3oACM60GC0az+FqoHwuhbNHWUDwA=;
 b=ZnrivCpsKpcyzSIgr3DV41Rxqr3UeVswMiT3+oJOu1CCK21H8SOEpjHaQGANGxtjUDeU2gL6p2YPIP6Jn82KK1eNyPOylY9ME0+7alBuIQxYbn+7fpaUY4/GsKMG5qKogBvTX5bqrz7jTNphD8AjbwIUjMYtOmPJOpQCLQKFLNSJt7L3G6+Jcr/vtckDmy72GvNAK8AP1oI5hshpoxBKLpgJPDlFOsWeoFfic2U7NPH9OzxCN4ttoB7ESX5Xy7lKnWg5GeIJvOrobAXGYh+p1zE8MMBdRX5n0Gg+dA0mzsPp7qkKMvCg9xI7wfPzwIQBGRr93e4KDZsDRkdK+0Mauw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6974.namprd11.prod.outlook.com (2603:10b6:510:225::16)
 by SN7PR11MB6993.namprd11.prod.outlook.com (2603:10b6:806:2ac::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Wed, 4 Nov
 2026 08:40:28 +0000
Received: from PH8PR11MB6974.namprd11.prod.outlook.com
 ([fe80::44a4:1ecf:f303:d08f]) by PH8PR11MB6974.namprd11.prod.outlook.com
 ([fe80::44a4:1ecf:f303:d08f%5]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 08:40:27 +0000
Date: Wed, 4 Nov 2026 14:10:17 +0530
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
Message-ID: <aurvccqaLOoewUP0@bvivekan-mobl1>
References: <20261102-swnode-only-owner-release-v1-1-ee4c9022a629@oss.qualcomm.com>
 <aurU5Z1CNl87uMrU@bvivekan-mobl1>
 <aurqev-AgiGYo5DT@ashevche-desk.local>
 <aursSlF3yRXrBPjH@bvivekan-mobl1>
 <auruXXGTDMU1wcwU@ashevche-desk.local>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <auruXXGTDMU1wcwU@ashevche-desk.local>
X-ClientProxiedBy: MA1PR01CA0183.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::6) To PH8PR11MB6974.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PH8PR11MB6974:EE_|SN7PR11MB6993:EE_
X-MS-Office365-Filtering-Correlation-Id: b57db658-7c62-4e96-3e19-08df3a4f46e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|22082099003|18002099003|4143699003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: 4fwRaUCXGs6gSqopbQty275TcEHBLQxdGa05AVtGOWfzH20UNR+mZzmZoCQmlhlRHjLNDpQgAU5wb25I4kmLPmVk4Qi656gVxl4+26PY35ZNEAK8JXkHsWhKH1sGi1nOyQaUo8WA0YKlp3rAche70dqtjLTr6hrHiq7rvJI6Aiz4nZ8caLM3tNSODpX6bQ0qXigb3f9UlYvZycSDSxWekYNf02LlDprn+QClW7tm6mQxTMuMN4xXcgVhDbL0S+KCSdIqLlQZEtwyC7GDJcH6xdZXaNaihzBsywh4N1tPDXq+qVZsBDlLMM7bE9wjY/me1ENG4yTi0fN67H0Y3DpCgHqKybPsNNbUHhauivb12JM91ndhFEGjBPSKBYdi8f3wJarwZPSrfHrsnzV9EDx/Yz7tleSG7O/bWzBdDuC5TLYke4T4uqar7U4IARt6gz0bkMczu1czjSX7dUChisNfBrfpvuM63RwUEBcDnZlkqFKl9JscuehL6R3zpUKZJyvwn6fGUaR2cfRrsDtXTE/vv9zCZjjrFJttwk6m5YyTxZvxOgjo7FBGRHbtN0nkhknSbiuu377NL6VumXwUIQRzi3Iv7fD2pIA+FNzSbcN1cvwDhB3ldUZfVZai3wSN4+D+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6974.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkJGY2JqUkNNRXdQR29Ca00zdFBQdUxxSnFkWFVTaTFhNXVBNGNiOTlqMG9M?=
 =?utf-8?B?bm1zVGpBTmtyOFkrWmJXYmorcmRoT0RQbTA5Q0JEdmt2K25JTFJmRjFFM2xW?=
 =?utf-8?B?VG1VTXVlWGdxNmdaVkFzdzFRM3N4blFlWVpDZElDcUdMNjMyZU5BclY4blZn?=
 =?utf-8?B?ZGlPZWx4akswZFc5RmNuM2kwRGJIMWJwakZocXQ2Q2daOWg3bWgzVy9iNFFB?=
 =?utf-8?B?UzJYVWRxRGtCdWd2a2dxNXVUVDVHYVdPdnZkMEliOEdNbzRDTmxic01XcUdn?=
 =?utf-8?B?TEdDNmQ3WTFxQjR0dHFaRHJPcVd0Y2c0dHA0RjhvSlN3SGsxQm00L0RNMWoz?=
 =?utf-8?B?Zk9ndmdoMzcwd2x2MUNpNWYrNWxmUUFtSEVaU1BYdnQ3V29TOXVmUHdweXVS?=
 =?utf-8?B?aDJ4RjdsOXc2eVp4dWNqU1FSZXpvY1ltaVU2ZHZOOUNDOVlMMERyTk5haTR1?=
 =?utf-8?B?eUVPbFhZeGZWak10eUdpQUJxL1RhMGxERUljNVVYRnhCeWg3RENkZktJZXZa?=
 =?utf-8?B?SGozUTdURTRUYm9wOHRWTGZhb05ib0xpa1BJU0hLTUVRR1NVWlhDYWZ4cW5t?=
 =?utf-8?B?SzEvU0Jjby9zdS9vNldSTGRyS3lXdEdTaDJiK05lNUs1cHI3Vk9jMDdXR1NK?=
 =?utf-8?B?MjRLeFpueCtWK2dFYTNhaHk0M1RPeUdDQnNzWEQ4VDZLdVRMcVRpM3AvcnRn?=
 =?utf-8?B?SmpadjJhNEtjYzFnTnZJSGZoUi9LOVpNR3dPZEhnYWRKSVZ5MVhQcmhPRmN1?=
 =?utf-8?B?VXg3UHl3VnJIVWpFMXlKa25Sa0NDVHcvTmlJdWxqaG9TV1BpN3RkMERaN1ZP?=
 =?utf-8?B?ZGV3S0FYb3dzeUNBRmhGSUJmUFVWUGNvNnFRT0JtOG81SDZqU1cxNWRpSlN0?=
 =?utf-8?B?dFhNUVBPekkzeXdJTUJ2dFZSUGh2c1cwQXp6ditZZ0lLOUVnbTdPSDVJVjBR?=
 =?utf-8?B?UUJJRFZvMHlaT1VhOUxsVkZrL1BCSkFIT3pxb0ZHMERCMWh3SmxlcnRGREpD?=
 =?utf-8?B?dE9MV2hFNW5vRHlUTFFGcFlNcDNDZ2pVUWMyQ0dLMTdOTVRGU2xvMEVzY0li?=
 =?utf-8?B?TGJLNVNRNytTS3pqZm5IWGhPSmZST1ZrdGZKSEhDVnZLREJGUWkxcGFPbDhY?=
 =?utf-8?B?ZXk0QlpRQ1BNb3IxNml5T01UV3hGOTltajZjSlR6bXk3emdRWmU1b3dKdU1z?=
 =?utf-8?B?S3J0R20zcGFNdGl6LzV4dVErWWRJTGxMWXU5bjVHMTFPMW5LSkd4U3EyWVY0?=
 =?utf-8?B?UE41T1cwY2NlYlFPSDBQSlpXOFRpYUcyVjF2K1A3SzcySE42K2x5R2kvT1NC?=
 =?utf-8?B?MEwvZnVWMDA1ajQyd2FkaTdySnA0RDQxRnYxWUFGcUtSTWowRGxKeDZybTZa?=
 =?utf-8?B?ZlIwaGd0aUxXbHlKbzBOTFFLNFlMM1J6dVAzbS84K1dYc3NuaFJuaDNDRWZv?=
 =?utf-8?B?aTl0TGIrU0J3Wms3dGVoSmoxd29lZWx6VmNQcDgwelE2YTNlSnRsYVFXTmdN?=
 =?utf-8?B?Ump5UlFyalZQbDdpampselo1WFJSbXgxamFFTUxhdlpzOHdzeWJSMXVodGVF?=
 =?utf-8?B?M3NQanc5OXZmTS9MYTRick1kTVB1TDNBQWlIYTJ1ZlVvOUdBcktBVFhzSEZZ?=
 =?utf-8?B?N01GK2E3Ymo0RVJXWDVHeXBzSHN2ZjFlTnI1MEFxZnVrUG5CNXJSUXJjbUxy?=
 =?utf-8?B?WjJOblo2SzRIU3NjRTZNd2dVZHYyWHJiRGJEUzVmcjNWemJSOUpWNHFHWGVp?=
 =?utf-8?B?UDFtNkFLaWZWU3RzSXpnUWlGZkxvUXlVSUUxM3pBazNZcDQwYkhBMzAvSkl3?=
 =?utf-8?B?ZmVuZEg4LzJxT3NQSDJaTVVQVjBkbFVvV0hBTUU0UlZmUTlDZ21FTm43ZnhK?=
 =?utf-8?B?bkt6SUdpS0FGUVZ5d3ZiQTBoM0k3MEdYdHRKV2FUbzVCUnB6OVAwTmI1eGs3?=
 =?utf-8?B?bUEyQkJKVWhBM2hLOXpQdWJyeFMvNENLTm1LSllZK1dCcWNPVXhoaDh4Sk1u?=
 =?utf-8?B?eHppMkhyZ1AxUktycHkyaUovUkFXa1BFbDVSV200K0ZlWlVqUEsrdUR1RVB0?=
 =?utf-8?B?cmZ3REJ0bU1yZ0dndzM0MFdvNnI1NHpRR0hOYlgwOVdYN01tbE5GbWIvRmVa?=
 =?utf-8?B?bnZhcGd2NzF3ZFlBMzhnZEl4L0wrNm5jcW05aldQR1g0ejA3c2hLKzN1THcx?=
 =?utf-8?B?MmFzb1liaUxWZS96anFjT0ZWTnJkb21aY2NwT01OaWkvUkNMU0Mzd2FQSkNS?=
 =?utf-8?B?NWVpRmxPTERqMFhCb3NRdVNodUx2L3ZWQzhKM1pYOW5sWmtESksybk90Vzlm?=
 =?utf-8?B?MGFkOGwzK2F4R0pFOUVpMWRzeEE5ckZ3SmticWpHMmpLbHVQWkpMT1NHTGgz?=
 =?utf-8?Q?ZmwTuboDuDoLDfwq1Ms+Ml6U4dPXnG+HHiRX2?=
X-Exchange-RoutingPolicyChecked: revJkJ76bydiLmHAZYafq9loT/eg/pG9TMMea1lld07Coataw9pI+C3l39HlRe7cwKiCJiLuFri/5fDpDDicMQrESnbsxRdzA7I2qFX+QQzu95vWaxtXmrcqJagK4Js3AA+u16z919/pfPTuWwnZaQW0EF7L26/wYiN5AUfWPD900Jy8G+aELBwtV/D9djyznhteabcWXGhEuqcWnnYV1mjFu03W7yEKSR3YiwNY6O1MmhyQucf/FKHgkJRIlbPV55b+xmUliBjFVVCln/JksZ7wbnhJUuFzvb3dy3SVkH8y+ysqcm8KRoQbNBXJzzp6+Fp9+dbDgfzvIqEb2M0Xpg==
X-MS-Exchange-CrossTenant-Network-Message-Id: b57db658-7c62-4e96-3e19-08df3a4f46e2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6974.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 08:40:27.6856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rBHGr94mfZ0dmupWsvhPDlaNEfklAWlbpu+GE02Yh8SfdA3KUpRV76qGA6unKMrZAmhgfMqm9yyIRCVOWfH9/+nk7H8I5UoIxeCac/MpxnfCx5/wQQwGGVN5fK0mVoOC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6993
X-OriginatorOrg: intel.com

On 04.11.2026 10:35, Andy Shevchenko wrote:
> On Wed, Nov 04, 2026 at 01:56:50PM +0530, Vivekanandan, Balasubramani wrote:
> > On 04.11.2026 10:19, Andy Shevchenko wrote:
> > > On Wed, Nov 04, 2026 at 12:17:01PM +0530, Vivekanandan, Balasubramani wrote:
> > > > On 02.11.2026 16:25, Bartosz Golaszewski wrote:
> 
> ...
> 
> > > > > Reported-by: Balasubramani Vivekanandan <balasubramani.vivekanandan@intel.com>
> > > > > Closes: https://lore.kernel.org/all/20261009164241.923756-2-balasubramani.vivekanandan@intel.com/
> > > 
> > > > > ---
> > > > > This is my approach at addressing the bug reported by Vivekanandan
> > > > > directly in driver core. Please test it if you can.
> > > > > ---
> > > 
> > > > Reviewed-by: Balasubramani Vivekanandan <balasubramani.vivekanandan@intel.com>
> > > 
> > > Thanks, would it be possible to test this?
> > 
> > Tested it already. Kernel crash is fixed.
> 
> Thanks, but we expect a formal Tested-by tag. Reviewed-by is only about how
> we read the code.

Sure.

Tested-by: Balasubramani Vivekanandan <balasubramani.vivekanandan@intel.com>

Regards,
Bala

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
