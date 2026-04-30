Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203CD3D902C;
	Thu, 30 Apr 2026 23:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777593144; cv=fail; b=OSYnCcgzyx+t+Omivc1tdEqdz3zoUctVNTeULnNjQ7Y2kOl2Hv2AncJ5xC4q/JzylaP8FgNtsf1x6xbP4vtQz3gi48xzHhKkSA4pOkQtR/KAO6R9XU0AncrrpZOxf58nORKd0eHEyYfDCpjs04nnLJe1viEiokYbLh9O8plh6os=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777593144; c=relaxed/simple;
	bh=Nr1pZK6L9ewdRVP4FZat+YI77SNs2AaSf0jdhOTA2Xg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OHodDJDDFL3Zbk8LoygJ7GhiemvVtzzTvX9JVYeGkgzeEA//PLof6yZt9k6lgMObZbpnOg3ZhhSsk8Dm65z6+APQat+QaYCucem5+dxPQzNeUjWJbFsj+ZmpinVOEKmsviYkdY9Kb+0UQuRrD+6achHZP9pDD0F6CWNkkIZYVjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UGPPyE0d; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UGPPyE0d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777593142; x=1809129142;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Nr1pZK6L9ewdRVP4FZat+YI77SNs2AaSf0jdhOTA2Xg=;
  b=UGPPyE0dvTSAadQF+X/KFxulP3cwOx55sGNGsGG3Fp1CKpXVuG5piy0M
   mzu/zS7S44LZ08hwOqm/e0srhheXdXbsM9UzPgNE+M7RZn3dPDHi+JByg
   qLiZzaRw9rGFBJKsm4jFNaFN14Q3hXQn5y7nzvOEm+lBxPFEmFCJ/oeB4
   XNL/wvfJFTw9DERYdvSFGOrUNXzzYNdA3XKwO/0oP2x8ofeShlqpGW8Cc
   dJP4/6aHcuxVN0ceo0XvoOOLPHdiE8PmnUuTmpYAmBxeoFL0FqR84Auct
   XxMEuoTZ1B7PfQgM9CXcgtAVkD+CBAhXEbbsSFFSd+YNU2cWbxga/rBqb
   w==;
X-CSE-ConnectionGUID: RplB7XDVTs+LnnElBMmfjw==
X-CSE-MsgGUID: oR7NkFhVT5OiXSnDnxzN9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11772"; a="101227716"
X-IronPort-AV: E=Sophos;i="6.23,209,1770624000"; 
   d="scan'208";a="101227716"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 16:52:20 -0700
X-CSE-ConnectionGUID: IgEO2u5iQ7OJcTmZv3E0HA==
X-CSE-MsgGUID: bD4cyQ+ZSYm5ByhN0oPweg==
X-ExtLoop1: 1
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 16:52:19 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 30 Apr 2026 16:52:18 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 30 Apr 2026 16:52:18 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.27) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 30 Apr 2026 16:52:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y+edqTKdnR11UXk6POWADTSRLO7RUCMBN3O3Kpu/T/cIQejdmxLybk4l78jZH+IRZKiUM06XTvBA50WljkbhY+Kno1P39yNkrdawucDfKjET1+LStCmDTuMJCBlj65ky1RTQCFIkpoMHXqyrn+vVo+N/UOavC+YpDwo7Z7z0IAPVJaKRyL0Tw+s+Rb0yPLizaXUJijeDKyxI8caiAJ0oQCP38iMKCmtApWARqCBqLr/MOyf2Nw5jJ4spJ6aZnsOzUfkNQD7kOwm5qfRd9I1cuH+owABLh74IRogohXH/+tI+fAMvPLs1xTvpngkL6FPnnkJnfVdfFaKIo7ThFARrLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N/PIkss/QgdG4nlPdN9/LaI4TZfXLYDG3UxC0uw+yIE=;
 b=Qgot6NksU75uR4rOWUuOEQHM1aZcj2OugfqxWW/0MDHu3erBA8a6Kb3QgvrZaw8fBkYLj1agCURF3utisRcN0XKb0eX5bME9SyY30WWoW9BiFSMSqCfdU5koTMRXpgqjthzoavxuJefS7OMukbPWzOYjiVhNfxFMZ6LPBGw/ewxUOyOo/pCSqd+rPocHZ0u1g2w364MDSnaTx9GPizwrAOeBSLL7U6z77YuSUeg0VGMrzUiy8It4pSwD+S9whP2Qv+Y0BFk/n+7CbVsCCgWEaM1duWN/u09Azc0JTEkfNDXe5wIcOyzzNNkHHB+N+diV2/0s7s1TrfhMk0SosVUbaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SN7PR11MB7468.namprd11.prod.outlook.com (2603:10b6:806:329::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Thu, 30 Apr
 2026 23:52:08 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bfe:4ce1:556:4a9d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bfe:4ce1:556:4a9d%5]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 23:52:08 +0000
Message-ID: <3b6f86ef-c00b-4d7d-96e2-b57fd4231e0d@intel.com>
Date: Thu, 30 Apr 2026 16:52:05 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 05/11] RISC-V: QoS: add resctrl arch callbacks for
 CBQRI controllers
To: Drew Fustini <fustini@kernel.org>
CC: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	=?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>, Samuel Holland
	<samuel.holland@sifive.com>, Adrien Ricciardi <aricciardi@baylibre.com>,
	Nicolas Pitre <npitre@baylibre.com>, =?UTF-8?Q?Kornel_Dul=C4=99ba?=
	<mindal@semihalf.com>, Atish Patra <atish.patra@linux.dev>, Atish Kumar Patra
	<atishp@rivosinc.com>, Vasudevan Srinivasan <vasu@rivosinc.com>, "Ved
 Shanbhogue" <ved@rivosinc.com>, Conor Dooley <conor.dooley@microchip.com>,
	yunhui cui <cuiyunhui@bytedance.com>, Chen Pei <cp0613@linux.alibaba.com>,
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Weiwei Li <liwei1518@gmail.com>,
	<guo.wenjia23@zte.com.cn>, Gong Shuai <gong.shuai@sanechips.com.cn>, "Gong
 Shuai" <gsh517@gmail.com>, <liu.qingtao2@zte.com.cn>, Tony Luck
	<tony.luck@intel.com>, Babu Moger <babu.moger@amd.com>, Peter Newman
	<peternewman@google.com>, Fenghua Yu <fenghua.yu@intel.com>, James Morse
	<james.morse@arm.com>, Ben Horgan <ben.horgan@arm.com>, Dave Martin
	<Dave.Martin@arm.com>, Rob Herring <robh@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Robert Moore
	<robert.moore@intel.com>, Sunil V L <sunilvl@ventanamicro.com>,
	<linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<x86@kernel.org>, <linux-acpi@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>, <devicetree@vger.kernel.org>, Paul Walmsley
	<paul.walmsley@sifive.com>
References: <20260414-ssqosid-cbqri-rqsc-v7-0-v3-0-b3b2e7e9847a@kernel.org>
 <20260414-ssqosid-cbqri-rqsc-v7-0-v3-5-b3b2e7e9847a@kernel.org>
 <03085c36-315a-47c8-85aa-f3de88fa43bd@intel.com> <afPnrjAseS00a8k9@x1>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <afPnrjAseS00a8k9@x1>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0104.namprd03.prod.outlook.com
 (2603:10b6:303:b7::19) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SN7PR11MB7468:EE_
X-MS-Office365-Filtering-Correlation-Id: 73258154-043f-4a96-4efe-08dea7137d9b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: LG+68nMKMMLR1FBDoWK7mNlGhBwV2oB+pb2lTDrjZZBzFft1OhH417ct9g96UWhfk7iZmhOMsVUIN+UtXyz+SiMwyJ2Z2S3QBfGpfvQFgDTyWNiS0sMr4WzZLTMFciy0ZrxL+roFQuvmoAEzgi+l9tPqRoZZVky4jZS5I2U6FGiA90zBgAnXGgXB8WK29Uf8oeFQonKJElaz22g/XnZCI2gtNDcTugEVnujAWmFcKTx0FdEU5ZDrmnR8fOiqV54AxabEC7UBIm2TwQvCb4JWuHr+SeNMd1upUgfyV11X2sN+TqTGJoZJEqZQVIxWwN7l29j4N7PFQEuey6zL2ToCjqJK2P9CCaLR5SVn7blyRiV8j6moMbd22wpT9rirA+BWLw7IqyfZab0PYaX2Ro63xMY7W/9PpSzMDP4MT1slNsn+9BfVyOX/CuwL/MsVwoinWraz+cmvoeGacQy2c+cGFL6LVt8/UXPaAvqVkKyiziPKe2u0u/B7D7T1jKsOB8Q96pv5IpfejGjvG9ea1e/YxUE/QmTIIYsDXtbiY2Sr2SnLfq9KUAo6cfToeNrf2GjDgAz9okwzarGwIPdolwhXZ8bD1Z7RFL4Q+jg9EOXPZWqtKKXKjeCyFu5IwPQLz+rra6JpxZ8gqtrKM56CUMGf0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3FaaHg2Z0J2dW1tV29GN2o3SE5EaloxVHViTzgxMHpRVkoweWtoT3ZUdE5G?=
 =?utf-8?B?akUxSXFiTzdGSFNvV0pxaTJtS3k2ZmV0WkRtaGlZWU16REkzTWtMeU9KUjdW?=
 =?utf-8?B?NG5iYXluTSt5cG5EZXlhRlAxOHJudjViUkpxTjFLaTJ0R0xhQVFVRXJQaFFj?=
 =?utf-8?B?MUxkZURnUmVaeHNEcDdGL1BQb3YyYWFWQlhNWXh2dnZzdnBXTExneEN1eGlZ?=
 =?utf-8?B?c0pQVnVRTDFNdEZrcDA4T0lOOThMREJjQURpcTBHWHBkN2o5N0pGekNzekJG?=
 =?utf-8?B?UCtLUGU4VmNqcXQ4UC9EUnROYnlhTDRWTldWRU96TVFFMldsUnRzdTBaK1RQ?=
 =?utf-8?B?b2ZUTWdHVytaT0w5WEJIV3FDU2g5aklMNUFaVzRSTk1VaHV5RHRSY3o0d0Ft?=
 =?utf-8?B?VGJ1U0JGKzZtOWJYTDQzZjJwaDEvMGJXN2F6cU40bEY5a3BEeDFLazQraC9E?=
 =?utf-8?B?UjRCSk5OcTI0bWd5TmpHRS9zaDVSVkUzOGZkM3JhdWNrUTdvMTExbXhyLzlB?=
 =?utf-8?B?MVliUmlzOGM4Mit3Mm53K2FBUmh2RUVUVk9WdFZvWXlucGpBVFBFQm9PN0VY?=
 =?utf-8?B?N2Vhc2dRTU42TFNpS05oSFI0Z1FnNEJWOWFGWlcvQnV2V3NCM2lnVUpWQjdL?=
 =?utf-8?B?anNybXd0S3pYcUxlUUFJYmhjbThTVU82akgxTGhtNFY4a0t2R2lRdXd0WmRU?=
 =?utf-8?B?dWloVHVDY3A0aDhidjBRWkF3MFdtQzZUL2VkM2xkMzZtOWtLRWEwK2UzN1ZG?=
 =?utf-8?B?UndtbXV6NkdMd0RHcSthR0hicEdzRFdBYVU4S3BVSHlBc1pZaFB4MWUwMDJL?=
 =?utf-8?B?ZVM0SUFKMDdEYzYzOVhrczRnQjBNUFFmSE5ubEowT0tYUVZubzlHWXRkSlBT?=
 =?utf-8?B?dHEzYkMyZmFQTXhIV3JlQjVOR0Z5MWRFeU5obUZ3a2dYcXdudVI4bUFicld2?=
 =?utf-8?B?TFdrbFYwRzM4eGR6QllKQjZJY2pBREZMODRWZjh4L2lXYXE5MVlPby8yRkth?=
 =?utf-8?B?dFBiZk14akxRSW5Vcjh0UDBnSEd0eExHaE9YSk1EdVRNUFp4eXd2VEFaSC9S?=
 =?utf-8?B?b1VvRys4aG03SERTYzNpOFpwNTRMNlcrakpTbVQvT1NwWlNQMmtzUGZOZE5R?=
 =?utf-8?B?a3BMQWZyVTVLMmpPeVQ5RkNNNjNjL1ZtMkFqNGtuZStGYWR4bkNHb0VJbWdI?=
 =?utf-8?B?aG9kSG92L1V4eFNWZnU0ZjVvc2NWVG5pY2svNzFJcExjOFBiaUgrSVd6QzVQ?=
 =?utf-8?B?b1IwamJUV05ReGR0QWl6TjR0VWhBb3FnVjZCWGZRcU1HOTZTQTIxVTNNOXFU?=
 =?utf-8?B?dk95TkIvWlMycE41blpSVml6QUF5TEgxbmdBaWx4K2RKbitmSzc1N0RKT2g1?=
 =?utf-8?B?aW1MQVBTVmlLUXNvRUhzeTBxd1BVZUFBZFdQRFhLTm5lWmJYNXV5Qk0yYlFm?=
 =?utf-8?B?c0F2Q2pzSVRrT2xCS2NlZkhKSDU2b3gxSThGWURNWkhaUHIra2luZUFKVzQ0?=
 =?utf-8?B?dU0rNEJCcWluaFcrd3FrV3c3RGQ0VGw2VG9EWS9UdmN5M0x5WERFUXRQSEZW?=
 =?utf-8?B?K2JjWjBPRnNXWk56RDlBWldzWVM0L3BzT1VZQUpTTlJKU2FpRW0vS25Rd1dt?=
 =?utf-8?B?QmFIcGduMDZ0cGV3b3VtTHA0TGZ2UEk3M3lXY3YwdU01TlgvT29JdWRiMnlq?=
 =?utf-8?B?VHl2dzIvSzlZMmkvb3plaGdtZE5Pdzc0TkpHSS9Va29yMVBsRjZLVkhGOCtC?=
 =?utf-8?B?end6ZnRWMURqTzliTjJTNUVXeDU2cVUrVEYxQzhIV0FUbGpYVDFVTU44VnFB?=
 =?utf-8?B?MW9hK203UUREc0VCaklNdmZXSk5ESU1KcHFKdHdnR3h0UDh0Z01qamJRak5Z?=
 =?utf-8?B?UWd6eXRVUVlKQmxuSExkbFpIOEtqaW5kajdsakU4ZDFQVXRVZzNna084L0l2?=
 =?utf-8?B?cllhdFRkcTk0R2JlVVZuWG5qbndZOWxIN0FBKzBWTlZXczN0UTU5RG00S0hO?=
 =?utf-8?B?RFFaWVFLTUJEZFY4QXMrWnBkOENiYWRDWWt3eWV0L1dxQ2xnL28vR0YwY3FZ?=
 =?utf-8?B?cFR5TkdvZjJpV1RxN1hHWGQvajAvV3p4MXA2a0NCcTZiZTZ2Tmd1VnIvdFpF?=
 =?utf-8?B?emVNSzF4SG5GeHdnYUVxK2tCQWRlWTVWdHh1ZWtvMS9wT01EVUlyZUdJRmJh?=
 =?utf-8?B?WmJzUzM2K2lmd08vS2Y2bFpYUTAzNFZLb0VRYjRVMTdDQzJaTTUyMmJPQ3Jo?=
 =?utf-8?B?MHFjVVhXaDNtcHdKTGJyUFpvemJGYWo2VlN0K2dhTUJiZXEyaml1SDdGQ000?=
 =?utf-8?B?VUJ0VGNpZHFmTXpWdmNJRy9QdXZocWRscmVnTnA0TVhPZHR2ODYxTXNWUVhj?=
 =?utf-8?Q?EkWGFERW6FMOGqtA=3D?=
X-Exchange-RoutingPolicyChecked: YY5S1/m/WCPVCPPxn4jMpuROReLyEvbsKyU5fzDwp6AV+nAz1bhx7XDbb3oW/htL4OW1YCO547qtQRl+h0XzKJi0qbkF4OJ9nz7OpgD8FsvRQkVPThgexq/Ap9MxafwlvxrQzu6KACb+F3WvHq++RIMw2o+S2jFUgEYFYzJpXvOBZru80ULs2yUtOTRlk1AlYHG9LOGOo/ez/FGNrbPD2wlQMwp2mz81eiJhWJlGrwTdGffEYWmcr2RO81kleUCiWsA1fOveyS6G0qW4o4qU4edEo0LbaALLZ05p7DdjITwyRQ7icKJ+GmY5sKeRTNYqGjjGvl2IG6qA/8aSX8kwcA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 73258154-043f-4a96-4efe-08dea7137d9b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 23:52:08.7646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E4uWMejWQzInRtzUg558NwJYglnBrErgWdcsRkM0t0KO0vqUoYMLRArNxT7tkLvBzbdCbi9WOOLichz7KXhLKVaAhGwKl6CHiFY40IWDLWk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7468
X-OriginatorOrg: intel.com

Hi Drew,

On 4/30/26 4:37 PM, Drew Fustini wrote:
> On Thu, Apr 30, 2026 at 04:17:22PM -0700, Reinette Chatre wrote:
>> Hi Drew,
>>
>> On 4/14/26 6:53 PM, Drew Fustini wrote:
>>
>>> +int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_ctrl_domain *d,
>>> +			    u32 closid, enum resctrl_conf_type t, u32 cfg_val)
>>> +{
>>> +	struct cbqri_controller *ctrl;
>>> +	struct cbqri_resctrl_dom *dom;
>>> +	struct cbqri_config cfg;
>>> +	int err = 0;
>>> +
>>> +	dom = container_of(d, struct cbqri_resctrl_dom, resctrl_ctrl_dom);
>>> +	ctrl = dom->hw_ctrl;
>>> +
>>> +	if (!r->alloc_capable)
>>> +		return -EINVAL;
>>> +
>>> +	switch (r->rid) {
>>> +	case RDT_RESOURCE_L2:
>>> +	case RDT_RESOURCE_L3:
>>> +		cfg.cbm = cfg_val;
>>> +		err = cbqri_apply_cache_config(dom, closid, t, &cfg);
>>> +		break;
>>> +	case RDT_RESOURCE_MBA:
>>> +		/* convert from percentage to bandwidth blocks */
>>> +		cfg.rbwb = cfg_val * ctrl->bc.nbwblks / 100;
>>> +		cfg.rbwb = min_t(u64, cfg.rbwb, ctrl->bc.mrbwb);
>>> +		err = cbqri_apply_bw_config(dom, closid, t, &cfg);
>>
>> (Earlier comment wondered about whether rbwb cannot just be provided
>> directly to cbqri_apply_bw_config().)
>>
>> Apart from that it looks like this can benefit from "emulated controls"
>> that we mused about at https://lore.kernel.org/lkml/e788ca62-ec63-4552-978b-9569f369afd5@intel.com/
>>
>> At this time this MBA resource is constrained by the 1% steps that the
>> default MB control supports and clearly it is emulated with a control that
>> can support finer granularities. I am currently working on a PoC of the
>> base schema descriptions on which the support for emulated controls can
>> be built that should be able to expose full hardware capability.
>>
>> Reinette
> 
> Thank you for your review. I have been working on a large overhaul to
> the series in v4 and was about to send it. I finally realized the
> sematic mismatch between resctl MB resource and what the RISC-V CBQRI
> spec offers. I decided to create MB_MIN for reserved bandwidth and
> MB_WGHT (weight) for shared bandwidth porpotional weight.
> 
> I didn't expect adding two new resources to be the best solution but I
> wanted to offer something tangible to move the discussion forward. I
> look forward to your proof of concept as I expect I can then build
> proper support CBQRI bandwidth allocation (reservation and proportional
> share) on top of that.

Creating multiple resources to support discussion seems reasonable.
Part of what my PoC introduces is that a single resource can have multiple
controls. This sounds relevant here. 
My initial PoC ended up giving the architecture too much control over
the user interface in deciding how these controls are presented to the user.
Things like this have been ok so far with the architectures behaving well (for
example, all architectures making sure to name their cache resources
"L2" and "L3" to have these appear identical to user space), but resctrl fs
can make this simpler. This does mean that resctrl fs would need to be "taught"
about new controls like "WGHT"/weight. I am reworking the series as we speak
so that we can use it to discuss more.

Reinette



