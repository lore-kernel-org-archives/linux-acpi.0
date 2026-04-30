Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40DF3B38A0;
	Thu, 30 Apr 2026 23:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777590922; cv=fail; b=imY5dFZa9DsrE5m32+5uZjeIJyQ2ay6k+Q/9zG0fz4KzDVvqoGzbJNxwaAeOUva+rgk1awCHK3f+fnV/r+VrlvnCT1HPMU74F+s3jlm+BmMWhVhsoJl7JxU5mm4h+1Fu5aG4S+y77/b0v+mgo+JvZ4R869+bDz62aRtDVMBrBEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777590922; c=relaxed/simple;
	bh=65gEOG6Lqz7U9cethDAoa2DqjAgXkSZuhmepeuSEEfw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W5OatTyTWnV2n/DURHdPTDyMkdzTPUBBLE+CL3PF49vJe1tDSn2skyttE/c/hVHpw/ZPgpGELmF1t4+algPCJZUdfGjd/JE6GnyubZ8Zx19LlulO/FyXBaBc+Obey0AUnpgiLlinwqScm2Mrq/gCQN8j4TnTxjA2F/lJJurMYek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bhl8yw1B; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bhl8yw1B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777590919; x=1809126919;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=65gEOG6Lqz7U9cethDAoa2DqjAgXkSZuhmepeuSEEfw=;
  b=Bhl8yw1BhbmnP98IoG5DX6GuqT/un0vwZl5r5oHzkhXHFMgrX3YFZw7c
   eTs2U21TM1bbq9J86tABxYTNSAOSf9p9PpYDISXRm1QJBz4MUsx578UCg
   ykxehQs7T9FH2I6K0otDDiQ0ZqEnN4+0qSnIQ3hYIcTARExP5lcOW5qYR
   cd5GBddF3PxSPuIcLeJGYfhcT9Mo9IOtnSe5bJu7hL84PNUejVd1kOR+n
   cFhElwqe8m4MRIA7B7viI5VQZdkeMz8pVewWFWMFetrNF8pT8A1r9PLPQ
   xVNygusDvqRUmrDsItwLdjpIeyzkeKkoVGe/zJGtAuDfzOgCBTqdSMmIP
   w==;
X-CSE-ConnectionGUID: xHYfkkb7T5mrhv1sK23Pbw==
X-CSE-MsgGUID: UnmsXJZYTZqQwq2BMXAeXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11772"; a="78662399"
X-IronPort-AV: E=Sophos;i="6.23,209,1770624000"; 
   d="scan'208";a="78662399"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 16:15:18 -0700
X-CSE-ConnectionGUID: umoqGcWAQp+yh1GuJLj/Mg==
X-CSE-MsgGUID: kyFPOolTQDq2scThGi+9ZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,209,1770624000"; 
   d="scan'208";a="230370902"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 16:15:18 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 30 Apr 2026 16:15:17 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 30 Apr 2026 16:15:17 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.55) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 30 Apr 2026 16:15:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GO/7yL+N5f+ffewkXTsuCacMCwI1Z3WHE9I59Rx067yOs9Ul5nR4WqMzTlKAEfi3FZFn7vV8D11uqHgr+4zynjIkYrcGGuvvrFhR9T0A4/ja5bNmThJq8CohkWNaI0uxAnEVXHSJuWwMGbAL6Das63RqGPFqa2/y23SZhApL1H5hv+/tRnXRvosZqztRh/rUMhBI/BGwJt0urkcaSDCIGuop6CNAVA1TTKgcL7g1blA1ud0v5gxZDd/n7nWOf+3xrOAA/ikV/eA5IRfKzX8+yjGxTCk2ZARRAw2069DXXqJ+tbKaECWmM8e2ZDHSkS3IsGuQTTDPiN5MRObHk2CrKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bTM7GAb5qt0fAtYW31XKOoZRhH29UdkgJHcr+enR1N8=;
 b=btnfknuMSUBkaYR+mXfZEgs06BjCayyZ0YQ8yw/UXm9EGOi0aPk2MIW7ltDmptFcKj6sBiu+FsGgl29C5c5gjRVBEg96b0GrLgAQVKTsyxRIw5LzBw9K4/SRySoNKuY5TwNbyfv+JI/TQgGQ5dhAx+iiKa2HMNyKZ/l09C4k/3vHabb1dO4a+rzHBco+laqHB3HN6rM9TZg7iMFE6sIF9UTdAW8oNiWkjS5bd2Vk6lRVHpg2PF0i/IwEGb3eN85o+K+CMxFUUtpRT30CpmTsiZKBSaEwtk5mhRf6eM+gLK3oH/42M8FpcPgR3oubJ5IE0w7Bc3Mu/tCt/EHcT2uJ+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW3PR11MB4651.namprd11.prod.outlook.com (2603:10b6:303:2c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.22; Thu, 30 Apr
 2026 23:15:09 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bfe:4ce1:556:4a9d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bfe:4ce1:556:4a9d%5]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 23:15:08 +0000
Message-ID: <eeecb5df-64ee-46ef-b4a8-0f0cdc88f0ae@intel.com>
Date: Thu, 30 Apr 2026 16:15:05 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 04/11] RISC-V: QoS: add CBQRI hardware interface
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
 <20260414-ssqosid-cbqri-rqsc-v7-0-v3-4-b3b2e7e9847a@kernel.org>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20260414-ssqosid-cbqri-rqsc-v7-0-v3-4-b3b2e7e9847a@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0228.namprd03.prod.outlook.com
 (2603:10b6:303:b9::23) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW3PR11MB4651:EE_
X-MS-Office365-Filtering-Correlation-Id: d50ac75f-b76b-4413-9c10-08dea70e526e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|22082099003|18002099003|56012099003|921020;
X-Microsoft-Antispam-Message-Info: CrWICR5v3nIgf/TYJcfuI1BPOWlB6wyFBtem/2vWo8ffZYq0+rWkZkTgxHRjIXES0+Hz4KqEenHkFDZ4o/n5qCVNUSpDtDkJZXU9SAaT662LsWBl1b2QezYzuR6hC+ySrN05JTA5iXovmyMEQrw+MPmzDa/aijbLku4Dku7FUT4rbBMvNhd+k/tZrLikHIRCj6UQTLroOgtrHQRyRMygC+EVImYZoVXHteBxEgtFg3t2FtjVV1HpZFNyzIFurV5g/H8wRVzYVa4NhN+YbO3cUmaEtH3Z6I9EQ/DwNO1p1ax+DvvvOxR4JdAch4ETK144r+oR57TamkyAHGqF0zs4kKmGqm9uBv5K272KVnC2dkBQ4rKqhq0S+5mFYBXg6F2SkO08kHFnUcRLvTnnOh5F7nEbQCBNFkYA6P1HPHHkKi/cIN2VztB0mqzFJRIRuflBmIWATAz0jC6hW1mxTGPw+8IXEN3I625BeAbFM/sgTQADgVK3mZ9Yij/ik8VcJ1EQcpKuWhoEA3kxfo6XasS+fsTbh9+621mjUYiOzDv0/azy9L6rlzswmczue/Bq25/NSJrcyMeKCfE+RonaQMLb1jZMD+UcpagNHo0wlehR+eolFl4Y+7rm0hVGHkoQ0v236PA4eWfVXyddIT+QxRLj0O2lxkEl98U/HMCmhpOLiMZnXfy/sAigymtLd7t22ro7TOQGavMz65MyEcV475bKHBG8oSpp5RJxUdmZDgWWd/8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(22082099003)(18002099003)(56012099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2JySUV3WnJtR21FMnNuUTNKNFRVcm5YOGF4U1FTT1h4VkR5RHVKNjBqelRh?=
 =?utf-8?B?aTZYdTEzcHE5NDhQdi91cFprYWV4SE9lTGZiNkhKc3pGODNvVHdYaTJFQlly?=
 =?utf-8?B?eVNBaE04ZFFyNmc5YVI0UldUVTVHMkJiR3FMTW4zcXhWeHpmVGZvR25TakV2?=
 =?utf-8?B?QTlueXdZQWNCdGtwcHU4eVo2MUttZHM4L2VFbTNSSjV4bEtzbTY3dzU2clhJ?=
 =?utf-8?B?UHlURFFkQldOVWtYZUxrWHBubEM0VlpPY1dxRUFvblk5bTBoNEtPMSt1cVBy?=
 =?utf-8?B?dnVwK0JMRXM0bmxFMnVDVGllZ1Q0ajI2K0ViSlVQaG9mTUxkSkZDc2pjeHpn?=
 =?utf-8?B?MGQ3OG5HYldrN0g2eTMxK1orcjZtcnRqNm4xR3hzUXFvQ3d5RjRqRWJET1V5?=
 =?utf-8?B?SWRjT0UyN0owQTB4TUhGWHJwSCtmbWIxOWdRWUFQaVFiRU4wN1RZVlY3azVW?=
 =?utf-8?B?S1NnRG4ybWZXblgyUVN5VlF1K2pZSWp6azFGdTRKSER3dUlvcnYyYkxxNS82?=
 =?utf-8?B?WW9uK3o0N21VTHJBUWJrYldUM3ZuWlJubzVyTWh3UEN4WVk2V3piT3RqTlZR?=
 =?utf-8?B?Qm1qMDhLZ3lIZk54cnFyODhFNTQ2MnY2cnpxa0FEb05MUWNxVzhvVVJqOXZr?=
 =?utf-8?B?dlo4WFNaZndsNUtxZW5zTi8ra3UwSWdILzFMMDFpMnFDSHFQZVgyK0pDdzlw?=
 =?utf-8?B?K0xYbzFhMVRSWjYvN3JPQmJTdCtZVm50Q2lVSE5qc0JmWmM2TEVjYTFJVEhQ?=
 =?utf-8?B?b1NmcnJjeEJjV0l6YnZSVlh5NWFkZ3VrWTBTU2x1blM5TWdoeThZNjZPR1VS?=
 =?utf-8?B?T2s2MHQrZ1VxM3BlUmFiSjk3ZGpwVittMmk4Qm1QM3pFVVBMcEU3ZThNR3Rm?=
 =?utf-8?B?UGlLcnk0aGxMUFZ5TkhlaGVJNE1rT0NDaVoyK3ZtWktydVliRGlEbFhVRTRo?=
 =?utf-8?B?d2lsOEMwMkJuaVMyZVVKMFFINFlCSmo1K0RsYUdLRk10OU5rdVR4QWhwTm5U?=
 =?utf-8?B?TDlldmNrcmU4S0tRbEMvanZoNkkreGUvWG5DRXB6b2x6amJVdXdpcm1vNVJv?=
 =?utf-8?B?QTRsNUVUV3JLY2hjcitHdkNpejBEcDM0M1hwVEJkSE8zTmVRWksxUEVVWnJB?=
 =?utf-8?B?ZVpUdnFuM3V4N2JNai95aFY4TmI3dS9iQmtLUVZ1bFB0YkQvaWkxZHhiRzRM?=
 =?utf-8?B?V3BEdHZaSi9JMTZlUjRYRGp4b2d2WXhOYUdDeWNqUjVvcjdFSEdDRmtMNlVK?=
 =?utf-8?B?c0FZTU40UndOYkYwQU9RVGw5WkJjKzdoeEdVU2R0UHNpbExqUnVMTDdnMnBu?=
 =?utf-8?B?c1NoRjZySmFlbXE0amgvbXdlVWNvUldmdG0wSEZuejNoWXlGREZyNFlDa2tC?=
 =?utf-8?B?cE9GVXV2dEV2TXdHL2ExcjJmKzBFend1WllWRklKckJGaUJaaFM2aUxxd3ZW?=
 =?utf-8?B?UWtFeERaajIycSs0eUx4ZkEwcVJzK3RqRkx5SksrZ3VVdFIreFdIZ0NHMzJz?=
 =?utf-8?B?UHdEUWhsYWNlM3BDZnIzbE9PU2FjOG1vMlU2bFJkVmZvdXo3TnNsSmFLVEsz?=
 =?utf-8?B?RUp5T3ZDMWpyNlVsYitQb3E4bG16MTV2THhxano4Y1VmV1ZZMzlRR3VTQnhz?=
 =?utf-8?B?SVlLVis4TGNmdGlMTzFaS0luWmtIWm9hVXJmblZxb0lnc2psVk5WQk5QYXY2?=
 =?utf-8?B?b1hDTGRtYXZjQ2hIbUpBV3BQMHlkeXpRQlNwRXpsaUhsaFhMMkJ6YXVIQ3RN?=
 =?utf-8?B?YmpXMzY5SGUxR0YrZkpXcVpKZE1pNFloVlVuQ3hKWnQwNy8yd0V2YzJMZlBz?=
 =?utf-8?B?V0lYcC8vLzN1K3l6ajIrc3RIc2dSdVVmemNrQ3gvaUxEcDVPSC9tdTR5dGFS?=
 =?utf-8?B?QjdIV3hKb3hXZkJ2SlhSeDZDdTVxWjE1T1ZETGJmam1ITmJoMmErWHIvbk5J?=
 =?utf-8?B?S0hISlBxRG5iNlkwcm9KNzlxTjgyUW1iM0RuemtGcnBnZWxRNkMrUVZtVzRL?=
 =?utf-8?B?YlF0SHF4YlN2S1N0QStiV1poQ1dyZlZhcW1hZURXV2RrNFozN0xCck9aYlUz?=
 =?utf-8?B?OWNjeGN1N0Z6OFVlM254ZXZsNDA3VjIwRjA0aUZmanBSakxEb2dEem50aTF5?=
 =?utf-8?B?YWdKa0IvcjV2cjcrYXlwcXBXR2k2R21tZHlGRG4rbE1uTXY3UHFocldlSWJi?=
 =?utf-8?B?Wk1YQ3cwYk5zSEpLeDBEZ29mNmJ4VktNNHpmd1lJNkdBVW5WUDJkemJMTWVJ?=
 =?utf-8?B?aEpaTGUvY01nMldwbUdGMlNtZitRY1dUbHNRcjFHbllkVDJDcWdVRDVicUkz?=
 =?utf-8?B?bEJjcnBXVm1hYk9zaElpbzZFQmNyVlY4cFUvNisrRjgxRTVwdW5hZDFBRmo3?=
 =?utf-8?Q?O92JX0qlkbs+fpR0=3D?=
X-Exchange-RoutingPolicyChecked: vduWlyMgAsPFyocrqBHKADvgytaz/V6HaARZRx5uL1weBMOlcGphGi4ScES+eLRbOGxYqdoTLdrzdRQ8A6EZGm/gtsRG3o9DH16dMnKVhY2HyB2yMv+9zFR1/CuD/wuSOXzuoPzvHD/RwTVPsMjac702Q/g/GVaoTiTmFN0kUb1lK+EBrvYngwURfWSynl+dF27ZsEDk/GErhbDeHOOnUmjNRQ9rOx5izKf7liMTZHeBrifxBaGbAecWI4SiIzMpB2O9N7Wv9HVTZO0TMpbmn1FeZc5oHEEWnO3Dvf2VSdnggAPO+mY72+Jp4nxFKC3iPruPwzsKK4ninJe7KCQnCg==
X-MS-Exchange-CrossTenant-Network-Message-Id: d50ac75f-b76b-4413-9c10-08dea70e526e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 23:15:08.8878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xQHrWf+2r+uIm4dFPO13/EliNk3ajxEqlETycNyNCEnSBgzfMgWDP7BpK9uqfNYhF4YYio5xlItXcq7bGM6lMPm2YqzYWnq5zBe5TbgLd0M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4651
X-OriginatorOrg: intel.com

Hi Drew,

On 4/14/26 6:53 PM, Drew Fustini wrote:
> diff --git a/arch/riscv/kernel/qos/internal.h b/arch/riscv/kernel/qos/internal.h
> new file mode 100644
> index 000000000000..edbcbd9471b1
> --- /dev/null
> +++ b/arch/riscv/kernel/qos/internal.h

...

> +
> +struct cbqri_config {
> +	u64 cbm; /* capacity block mask */
> +	u64 rbwb; /* reserved bandwidth blocks */
> +};

Is this struct necessary? From what I can tell it is used to pass a parameter to
cbqri_apply_cache_config() and cbqri_apply_bw_config() where each just picks the
one member of interest. Could parameter of interest just be provided directly to
cbqri_apply_cache_config() and cbqri_apply_bw_config() without bouncing it
through this struct first?

> +
> +#endif /* _ASM_RISCV_QOS_INTERNAL_H */
> diff --git a/arch/riscv/kernel/qos/qos_resctrl.c b/arch/riscv/kernel/qos/qos_resctrl.c
> new file mode 100644
> index 000000000000..6d294f2f2504
> --- /dev/null
> +++ b/arch/riscv/kernel/qos/qos_resctrl.c
> @@ -0,0 +1,432 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#define pr_fmt(fmt) "qos: resctrl: " fmt
> +
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/io-64-nonatomic-lo-hi.h>
> +#include <linux/iopoll.h>
> +#include <linux/ioport.h>
> +#include <linux/resctrl.h>
> +#include <linux/riscv_qos.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
> +#include <asm/csr.h>
> +#include <asm/qos.h>
> +#include "internal.h"
> +
> +static struct cbqri_resctrl_res cbqri_resctrl_resources[RDT_NUM_RESOURCES];
> +
> +static bool exposed_alloc_capable;
> +/* CDP (code data prioritization) on x86 is AT (access type) on RISC-V */
> +static bool exposed_cdp_l2_capable;
> +static bool exposed_cdp_l3_capable;
> +static bool is_cdp_l2_enabled;
> +static bool is_cdp_l3_enabled;

These CDP values could also be handled as part of struct cbqri_resctrl_res, similar
to how CDP is managed with struct rdt_hw_resource. There does seem to be a hidden
assumption in this implementation that if *any* cache controller at particular level
supports CDP (which will cause global exposed_cdp_l{2,3}_capable to be true) then all cache
controllers at that level are assumed to support CDP even though this property is
enumerated separately for every cache controller making it possible for this
support to not be uniform.

...

> +/* Perform capacity allocation control operation on capacity controller */
> +static int cbqri_cc_alloc_op(struct cbqri_controller *ctrl, int operation, int rcid,
> +			     enum resctrl_conf_type type)
> +{
> +	int reg_offset = CBQRI_CC_ALLOC_CTL_OFF;
> +	int status;
> +	u64 reg;
> +
> +	reg = ioread64(ctrl->base + reg_offset);
> +	reg &= ~CBQRI_CONTROL_REGISTERS_OP_MASK;
> +	reg |= FIELD_PREP(CBQRI_CONTROL_REGISTERS_OP_MASK, operation);
> +	reg &= ~CBQRI_CONTROL_REGISTERS_RCID_MASK;
> +	reg |= FIELD_PREP(CBQRI_CONTROL_REGISTERS_RCID_MASK, rcid);
> +
> +	/* CBQRI capacity AT is only supported on L2 and L3 caches for now */
> +	if (ctrl->type == CBQRI_CONTROLLER_TYPE_CAPACITY &&
> +	    ((ctrl->cache.cache_level == 2 && is_cdp_l2_enabled) ||
> +	    (ctrl->cache.cache_level == 3 && is_cdp_l3_enabled))) {
> +		reg &= ~CBQRI_CONTROL_REGISTERS_AT_MASK;
> +		switch (type) {
> +		case CDP_CODE:
> +			reg |= FIELD_PREP(CBQRI_CONTROL_REGISTERS_AT_MASK,
> +					  CBQRI_CONTROL_REGISTERS_AT_CODE);
> +			break;
> +		case CDP_DATA:
> +		default:
> +			reg |= FIELD_PREP(CBQRI_CONTROL_REGISTERS_AT_MASK,
> +					  CBQRI_CONTROL_REGISTERS_AT_DATA);
> +			break;
> +		}
> +	}

There does not seem to be any special enabling when resctrl enables CDP via
resctrl_arch_set_cdp_enabled() so I assume CDP is always enabled? Does that mean
that when CDP is disabled from resctrl perspective (thus, both is_cdp_l2_enabled
and is_cdp_l3_enabled are false, but exposed_cdp_l2_capable and exposed_cdp_l3_capable
are true) then the default behavior is that allocation applies to both code and data
and it is not necessary to set both CBQRI_CONTROL_REGISTERS_AT_CODE and
CBQRI_CONTROL_REGISTERS_AT_DATA?


...

> +static int cbqri_probe_controller(struct cbqri_controller *ctrl)
> +{
> +	int err;
> +
> +	pr_debug("controller info: type=%d addr=%pa size=%pa max-rcid=%u max-mcid=%u\n",
> +		 ctrl->type, &ctrl->addr, &ctrl->size,
> +		 ctrl->rcid_count, ctrl->mcid_count);
> +
> +	if (!ctrl->addr) {
> +		pr_warn("%s(): controller has invalid addr=0x0, skipping\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	if (!request_mem_region(ctrl->addr, ctrl->size, "cbqri_controller")) {
> +		pr_err("%s(): request_mem_region failed for %pa\n",
> +		       __func__, &ctrl->addr);
> +		return -EBUSY;
> +	}
> +
> +	ctrl->base = ioremap(ctrl->addr, ctrl->size);
> +	if (!ctrl->base) {
> +		pr_err("%s(): ioremap failed for %pa\n", __func__, &ctrl->addr);
> +		err = -ENOMEM;
> +		goto err_release;
> +	}
> +
> +	spin_lock_init(&ctrl->lock);
> +
> +	switch (ctrl->type) {
> +	case CBQRI_CONTROLLER_TYPE_CAPACITY:
> +		err = cbqri_probe_cc(ctrl);
> +		break;
> +	case CBQRI_CONTROLLER_TYPE_BANDWIDTH:
> +		err = cbqri_probe_bc(ctrl);
> +		break;
> +	default:
> +		pr_err("unknown controller type %d\n", ctrl->type);
> +		err = -ENODEV;
> +		break;
> +	}
> +
> +	if (err)
> +		goto err_iounmap;
> +
> +	/*
> +	 * max_rmid is used by resctrl_arch_system_num_rmid_idx()
> +	 * Find the smallest mcid_count amongst all controllers.
> +	 */
> +	max_rmid = min(max_rmid, ctrl->mcid_count);

This computation appears to include all controllers, whether they support monitoring or not.
What will ctrl->mcid_count be on a controller that does not support monitoring?

> +
> +	return 0;
> +
> +err_iounmap:
> +	iounmap(ctrl->base);
> +	ctrl->base = NULL;
> +err_release:
> +	release_mem_region(ctrl->addr, ctrl->size);
> +	return err;
> +}

Reinette

