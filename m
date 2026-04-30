Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D0B3BC665;
	Thu, 30 Apr 2026 23:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777591066; cv=fail; b=budRnVVdMgXDqOsVn6erOWPrxzcy7/zgz7fp7jdNs9zcSGiDnDMbj6x7NCYbTo/1uaanKqSof/jdrObTBRzmdWlWGpM/i2LrKZ4wKaKFsb4D+5b2dgxvSUSS2WOO8hQbzPsA5ZJkjTgmsu24KKimwhePCJ6j066KO/wn/UMQQLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777591066; c=relaxed/simple;
	bh=AP8P3ObqtIqiyWU+YVLMyXwGxUilRFgtIbPwpncurkc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZAzLIuzleC/IVOxTBDhLKFoy6M/JmI5rP/hD6rRgdRbWz8/a8l/PHFCCGMxOCIomGyRbQn7ToDuqcqqpwLiv7r8OhxavoTmeKbPzciq7ECvbcu2k7THS5tr3wXCAvxp70Z6USPhykYzmlVB2czfuz96itSr14f1m2xkPxDiAZxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=frzU2pfa; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="frzU2pfa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777591065; x=1809127065;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AP8P3ObqtIqiyWU+YVLMyXwGxUilRFgtIbPwpncurkc=;
  b=frzU2pfa+B6tOKw3ArmNUeSCJQnVC7f+/Qw+1QA1jjqQuNxTdpEAhgp4
   Q8gv+VRJX7TETT4RukQ26/NAkEKGoo2geZGWVEop+cyfq+6O9gEEAtKjm
   X6j4EcT+wurXHyvQgxA3TeMhk48Hjot9p5lhtZVU8157Oa7HbJsVJzWue
   mpu9lMKXbgXGtDZzMnf6Es0TObX8bEAqEhSbv/Vg/5SM/nBbM7DSDNLmq
   gQgGJPrAuhZxgEONGdag2mBKSfrZulPx/VADMUxGHFBfY53LR+5pHykS5
   DBLBVYmWxJSHJDHXZOWdsHjDLF7iJVr+gF9AxvZVXM2yJdP+1kQP2/eNY
   w==;
X-CSE-ConnectionGUID: ozS1JbViRYyE6mJ6f1Aieg==
X-CSE-MsgGUID: LHYK0aiRSxGU6IxCxNi1kw==
X-IronPort-AV: E=McAfee;i="6800,10657,11772"; a="82415385"
X-IronPort-AV: E=Sophos;i="6.23,209,1770624000"; 
   d="scan'208";a="82415385"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 16:17:40 -0700
X-CSE-ConnectionGUID: 2iiInrf9RVGkgGWsCODtyQ==
X-CSE-MsgGUID: e/DPSI8/THCmuEJw/7owLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,209,1770624000"; 
   d="scan'208";a="258306791"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 16:17:30 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 30 Apr 2026 16:17:29 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 30 Apr 2026 16:17:29 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.23) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 30 Apr 2026 16:17:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=diVfvOSFF2e58dgfzOV1ru6fJbPrLBPk4jzkYv0OaCcpiE2JXwEcK9RgWM2SBtChYYuJVZZHWaYYvUliMA+bsadGGYOVbo4W9BeRyWqKZ0UJfolR+JWhaLZNalLkA4Ue9t/F6ZdPeZvVXsFBG+FS2pwWOx5be4++AofvzSR+sBiyt8DjiioGsgmfn4lDoPQq5UktpExdF3C08RsxvLgIIO8Is0A5UoT37lKnmM7BypC3QO/1fg4Q6HmjUNRKBY7thEvjjf6dS9PU2sLe4T95qqZz2faGTaL5y7fvRfcdFuN0H+V9OMmEYfduxYbrsUBPgFHdpKKuDIutpYk442h3CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cHbdAMpcPvxHDA5AyfTQnnOUu1zLlL50d8q0Znl2S5w=;
 b=eLm2EA+vT2rF1c7hgt3kSF9P0cSP8yQ9YQ4ezUSiAfcEez59v/2HTP1K18iLDENo1x0AKKZXfWzETSlI89gAy0++kjmtpoEn/z30ZgN69dVeYm0MN0cjco4J3jFIKc3H2k1hzIeDNrgo8zHXfxM7MItV+tP4QaKMSYvF2IjUNvSPd1Ou5JcxLEWCLpcBezjQYt00f2Dz5VaBSdSlI87wxZowOGNGJikm+vB+xMPfqNLoxQjvRXpjBZBCEm3OYcMnNHa74tY8E+U/A7sJH+C1rZ7tk5hCkz+VfN/3GLbHpGbe9fcRIxciKgNrHqHYKMxk/9uZpi0ANpmkpbiKN8+Z4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW3PR11MB4651.namprd11.prod.outlook.com (2603:10b6:303:2c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.22; Thu, 30 Apr
 2026 23:17:26 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bfe:4ce1:556:4a9d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bfe:4ce1:556:4a9d%5]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 23:17:25 +0000
Message-ID: <03085c36-315a-47c8-85aa-f3de88fa43bd@intel.com>
Date: Thu, 30 Apr 2026 16:17:22 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 05/11] RISC-V: QoS: add resctrl arch callbacks for
 CBQRI controllers
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
 <20260414-ssqosid-cbqri-rqsc-v7-0-v3-5-b3b2e7e9847a@kernel.org>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20260414-ssqosid-cbqri-rqsc-v7-0-v3-5-b3b2e7e9847a@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0235.namprd03.prod.outlook.com
 (2603:10b6:303:b9::30) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW3PR11MB4651:EE_
X-MS-Office365-Filtering-Correlation-Id: c4a772f4-fa84-475a-23e5-08dea70ea407
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|22082099003|18002099003|56012099003|921020;
X-Microsoft-Antispam-Message-Info: X1NFGiGoCvZkSAQymGhqMBP2+8p4ohSeaR6xhi9VraTNed+FPPx5B2P9CED5s1RkWEqoaRRADMNOQXCsC9t8Ide5Lk3UosqedAsOVjlKFjwIJKoydKBGtCr19qgBk+Z3FWZ5ELIYilhkNW9WMUn0dvZsSUecJCl1xz80gQbbPQyF32VFDgON0wcgOyGYySUvSYV4GdHIcN3iM3d5AtXuFl3oLZ5Pg9OSlsihQnULdM1BlUZSXxAMN/Kht21vj1yH9NgmmKWTx9B4+PzNpA0f54SNpIFfjr3Ce7eEEraFUwqAqcvWJ8jpYVGoeYmJDROKhStQQCGJyj+7lkfnm1PqVLRv7t6Iv2MDd2GrCIA2gnus389F7C9i9TcAjsslumngrQ5rcywi0DHq7RGpEGl/jpDrdFzLTFh+2h4a6p9U5LDXfV7tLe3tRqibKG998ovf9ClD6ukaJeqVR7KCyVlycJfBxEn55zlB1lU+wg5nzBfTo9FyMFHaHZQXi1vpvUtwMQB1n0ox3hV7Fuj8A8dzhyiab1F5kG9kx36Wrb2/VKx0KLct4jIFe8JYWlx6qj+/UAVkj+Ck/Ob48BUShf57DwuVkfdADPCMK/e2du15UxjqE2UEajpohiZlvIyhIEiQumJTe/d5+OFdtZzpYXFqnlLQWt7VdAGLbEEzWCcdmv6yis73IDs3tyo0eVS9LU9a
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(22082099003)(18002099003)(56012099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTg4ZmprL2cyR2t1c29rcEl4SjN1MHpKZG5IUWpUUE5aSDNvTHQyaFNUY0Z6?=
 =?utf-8?B?YkFmaUZYV1A3OHNjWmVOWHB4N2UvUXhGZytkc2ltU0lFNWhwcjY2YlEyd0Mw?=
 =?utf-8?B?SVFkb28wVzRMaDBBTGNuNFpCMjg5QjQrdVBSQ1BWSDliTmlucktCTDY3V01D?=
 =?utf-8?B?cnNiRGhCa1NIM2s1Wmk3NmplU1k5KzMzVE5qL3hSODZaVG1xMkhybXMyMHNK?=
 =?utf-8?B?b09oSTdvWDZ5SXQ2WEdWZ1Y2c1ZWZ0dzK0hodDQ3YUZmY2ozR3JSS3JMZWw1?=
 =?utf-8?B?V2tYRVFGYmJ1Z3laWGlkcXZFTHF3a29hdTJtaldiNWZMTHNmb2lPMFlkVDBQ?=
 =?utf-8?B?Zm9ndWxjbHBIeEZiNnh0MkRxUXdwUzJ2ZEd2a1I5SE1zUVlYc3pCSFZmSUU4?=
 =?utf-8?B?NXY5RE9QR01HOUlrRjJaTHdsNGl3dVZwZ2FENnZObXYyYmRiVWZuaFpwS0JJ?=
 =?utf-8?B?RHJyV1pQa1VQZHdWeUdmZGErVVl0R0JuU2o2VzFLNytuQzZjUUgrVWZnem5N?=
 =?utf-8?B?NENiNVNiNHhzS05MTzkyZWFvNTJ3MDhlWjk2K0lqQWl2aTJkaklsTm51YWpi?=
 =?utf-8?B?dmRJTUFSU1cxbzlqSnU0MjJJaG84czFxSFN4akNteVRqallXVzBxdWxNcTRi?=
 =?utf-8?B?aVJHZ1hsckF6OE9UWnB4OHE0enVSYnZpQVBuSUpSUThZSDdBWkdsaFA4ME1q?=
 =?utf-8?B?NkhwSzN1UExTbXBuVERnOXhqVUVMZHcwWFRZSHNCVHg3elRDNVMwaGNwU1Rl?=
 =?utf-8?B?STdhbTI4QS9ZVjYra2RDQzVqYlRSYU1XdVdTdS93S1c5VGRZTlJLWEpQVzg4?=
 =?utf-8?B?NmRWN0V5VHlZOFBlWHEzbjFuRzlCSDk3VWRCcVdSeUxGZ3p2OXhIRXFHTWdC?=
 =?utf-8?B?YW42RTNuRWRFVi9RM0h2UHgrbjFvbXZrb0hQaUhpVTF6KzB2ZkthTXg3TEFm?=
 =?utf-8?B?VU1QUlZxbHh2cHVWL0ZRTWI2cWZRM1ljQ3R5SGJGZFNKb1cwWDRxWFl4c0hz?=
 =?utf-8?B?TWFYMjM0REdjMDMveEJLSTVYcXk3RjVFcGlqZEg1cTRKWkF6QzB6NlJvaDZI?=
 =?utf-8?B?NytUNWhGejJibWo3SFQrb29laGVvc3Q3MGJRWnFLeCs2eGdrQVdWdzdUeWhq?=
 =?utf-8?B?a0JEaERvZExrQkdhK1B3ZkRMcUdFNFRGSnhyYjRLZHVFc0JlZlhnelJmOWlt?=
 =?utf-8?B?cG5uY3NWV1lycVh3NU9YMWx1RTJvcWpRQXhqbE9zZDhFcm5ZNGpZSjN4bm9x?=
 =?utf-8?B?c0RlMjZISC90andrK29vTmlLQklxUWNMQU5MUFFUa1RpMkpvTUlQaldHQUVy?=
 =?utf-8?B?emhMcGFIOFRuR1htd2VtazE4a2d3YWZwQkZGeXF2QmpCYmdrazl3VDRUYVJT?=
 =?utf-8?B?WEFHOWxkVS9TaTZsR0svZGsybmZjV3NKeXVmdHdoeWp4M1ZYVGxlc1F4OU15?=
 =?utf-8?B?NGMwUDVCQjBsMXZXaE9ac1NBOUFuTGtFYk5QbXhDNXNHOEcvdXluTUR2L0tO?=
 =?utf-8?B?Y0g1SHEwZ2hSUENzaEpFbzJZbWF0VHZLcEFNbDdERWk4eFBVQjJwSEtJVyth?=
 =?utf-8?B?bUt3dms1bVZiQ3VCR0FDRUxXTWJleWZHUUhNc3RuSG1CVis4QkNXMytiWWJy?=
 =?utf-8?B?WmV6Z0l6bUdIZkRZMHduaUxvYzJVa1Bkbi93bWNHTElIbi9uQXJRSmQ5RDRn?=
 =?utf-8?B?bmFwcHoxak42ajg3RnltTWxkRkdFQ0pWeWNYZkoxeUJCdWowbExlbnJOd1RR?=
 =?utf-8?B?V0FhaWthelZqejl5SFk4SjQyaFpja2JlaEdqK09qTnZKUmVxYnRpZllXMjMw?=
 =?utf-8?B?MDFpRHVTM2ZoVzY4OUtMTVNGRlVJV0s5RUVDbmkycVV2SW9LeXZ0ZWZHQWFp?=
 =?utf-8?B?ZFZuam5wNFBoWDNGTTJkT0twTHQzN2lsUFNsaWxtMTM4eTNib0tZOERocGNY?=
 =?utf-8?B?V2N2VzB0ZFFaN2ZwTTN0R1lLdTRHeEVGZFBBNDh1cTQ0LzJ1T0pMRTQrdkd4?=
 =?utf-8?B?NkM5U0FQV21qR21EdHJ0bWxYQTdvT1hXZDVLM0R5VkVLYXRvUURHTzd2SEZs?=
 =?utf-8?B?c00vc3VpRjh0V2t3SmFGTXNYZGFuQ1FBbFU0VXdYb29JL0N2UmFNckkxdUUw?=
 =?utf-8?B?TnJyaHkxajBUU2QrN3B1NFA2dHArTW1CUXZRdVd5UWJ5ZGpZOXpFbG1jMHVU?=
 =?utf-8?B?MjFiRFIzNW5FVXd3Z04rY3BqdW1TaEI3MTF4cnljekdFelhKUm9wNUVGK0VG?=
 =?utf-8?B?OHJ5aFVRZ0VIelJucDI1SkVkajdtQVFGZVdNNDlmVjhaYjM1ZlYraVE0U3Zn?=
 =?utf-8?B?N2VjampzeW41dGZMUEIzREhJMDNIcFZ4S0tKZnNlbDRJOExDQjRxOS90Q3Vi?=
 =?utf-8?Q?NxfXQFmeKeaQmXUA=3D?=
X-Exchange-RoutingPolicyChecked: bgsWMneygGqZ+yN+ONtTav2SSvqVVetLg7UVVyAV+J9XMX0AQY8RVKq5IfTnOFoB8eB2XUgMYCJl7lES6Tzh6+rvT/lXd/7xZrmoM56NCOzQ6ODrfkTMp1bMQ4C5fW6TA8u2FqD5eDyFAp26mgMwHF5AkhnFdUEebr3fUTbuHIVIZ976entbYHq62IeitA5LAfK4+2IptRjEQdpwHBhG/YQFiT78E8xJ96zj2KfA+o9KwhMtnFwSjGKboDfee3Iz7CaPgS4Itu0WU3wnCnbi1znLxqZ4q8tLQ94Rmw2+T3mTNWkP+AjRHfe6t6EfUDs/azt2Si4tHzEd+gxep7Sa/w==
X-MS-Exchange-CrossTenant-Network-Message-Id: c4a772f4-fa84-475a-23e5-08dea70ea407
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 23:17:25.8781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j52rJX9ueWixIczmco/ssgTFw03tHJZYFM0filIERLmAErxn197EG6BO47w61RWIEX2IYqEx15jUwoa0RDSexyFDg/p5lt3IeBDCiYFHQNM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4651
X-OriginatorOrg: intel.com

Hi Drew,

On 4/14/26 6:53 PM, Drew Fustini wrote:

> +int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_ctrl_domain *d,
> +			    u32 closid, enum resctrl_conf_type t, u32 cfg_val)
> +{
> +	struct cbqri_controller *ctrl;
> +	struct cbqri_resctrl_dom *dom;
> +	struct cbqri_config cfg;
> +	int err = 0;
> +
> +	dom = container_of(d, struct cbqri_resctrl_dom, resctrl_ctrl_dom);
> +	ctrl = dom->hw_ctrl;
> +
> +	if (!r->alloc_capable)
> +		return -EINVAL;
> +
> +	switch (r->rid) {
> +	case RDT_RESOURCE_L2:
> +	case RDT_RESOURCE_L3:
> +		cfg.cbm = cfg_val;
> +		err = cbqri_apply_cache_config(dom, closid, t, &cfg);
> +		break;
> +	case RDT_RESOURCE_MBA:
> +		/* convert from percentage to bandwidth blocks */
> +		cfg.rbwb = cfg_val * ctrl->bc.nbwblks / 100;
> +		cfg.rbwb = min_t(u64, cfg.rbwb, ctrl->bc.mrbwb);
> +		err = cbqri_apply_bw_config(dom, closid, t, &cfg);

(Earlier comment wondered about whether rbwb cannot just be provided
directly to cbqri_apply_bw_config().)

Apart from that it looks like this can benefit from "emulated controls"
that we mused about at https://lore.kernel.org/lkml/e788ca62-ec63-4552-978b-9569f369afd5@intel.com/

At this time this MBA resource is constrained by the 1% steps that the
default MB control supports and clearly it is emulated with a control that
can support finer granularities. I am currently working on a PoC of the
base schema descriptions on which the support for emulated controls can
be built that should be able to expose full hardware capability.

Reinette
