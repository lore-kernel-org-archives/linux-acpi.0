Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B1F3D88F6;
	Tue, 21 Apr 2026 15:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776784307; cv=fail; b=Nm2ukwv4/+T3zvuAI7d8cNYDnooKqsjFOG1w2aqEC9lW3Bb9AUtZTVkgkD5L8/vFPyJgQABCzT08sfW8pGsShdus9Wwac16ykRKgzGWRgbLS1ouWfnBjuKM1DcJGkKFLrHnpVzLWIn2SLrIEnYkXX5Z2XmyXbXXm1X7l7jSWm64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776784307; c=relaxed/simple;
	bh=Be9u+c2ARod4ND8H5dQSQ5whp9lvKwkGBjAKq+ysVXk=;
	h=Message-ID:Date:Subject:To:References:CC:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RrL+FA1fLQVI9mPsY/oRLxjmOsnOloNz2MaKNcBKSVtAJrWwMSrYNCxkVeEifU3f8WIKyGnTbqmMKwcxLvVt/LKowpVvPhRbsjG2qk01LlaX/UKskNY9JthZVt5ThNq5yig9MfqCPuQn26vIauRhuGgv+G1HavVIEYYCqydEKM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c66we7EW; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c66we7EW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776784306; x=1808320306;
  h=message-id:date:subject:to:references:cc:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Be9u+c2ARod4ND8H5dQSQ5whp9lvKwkGBjAKq+ysVXk=;
  b=c66we7EWkZJH/OFz237IfRSgMZGJY3sJQyJ8G6pMT+8sG+Sm+v52pixU
   oKQFAv3Qk4Yx6DqIlCS/6GQsBssWXoI1AVSC2szotvW+X89HZJi/mfK3H
   KgkkjRYtAgjSrunXU9HmomxSEeQx/NpqqCCaopqRKXlxDxjTOTB0K4HmF
   8wewt809FXxpSf9VlDN5TPnLzKb+QW4GeZWRNl1/+HbbgCzhNm+/TLuop
   rw4QJZiwDPQfUvUf84pL9MeDfGSs+GiJrdgvgKj3Pj1q2uHjW8W/Nk/QO
   W6uHFtkF+3dJBYraBLOAa9MelXrKM3vBcbGnh93JkgARobHieO01hxOOu
   g==;
X-CSE-ConnectionGUID: vuaLfuluSGW1CJsHd94UOg==
X-CSE-MsgGUID: Opz4iC+pRZyNK6GANSHrYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="103179962"
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; 
   d="scan'208";a="103179962"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 08:11:45 -0700
X-CSE-ConnectionGUID: AVNnk6a1Q0inv2sERF50FQ==
X-CSE-MsgGUID: hfyKyMnvSDmma295UkXeLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; 
   d="scan'208";a="270143398"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 08:11:45 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 21 Apr 2026 08:11:44 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 21 Apr 2026 08:11:44 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.48) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 21 Apr 2026 08:11:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PRDg7czMZOOp37y3U7pk6zXzACNMce8xK5YyOHpicfN6J4IV/lPfqD5f/zTsWoz3qcBzd+jIVS3iZ7BXXpRUE/YmlD1oqm0YlB6S6H0wEAf9f8s5avlToYOFx88MEmzbgYa0X5CYaplQIQE4OLr8rqsYtCOPJ0u690UatJ+zuIn+4G8wHGeIlAL+df17SQmDC/35o8ZoW1rMyblpob2szbUckXblpRhOV9aaLUFKkDIIdDiccinCYkI1N938My7mtE9PTtKGW8X+Qq7YhJApeqySkldV6uAbLfMmPXMktMuAXD3fGYDTOT2I9oVCwMYwV5sBupAeYZSA/Xi3ijLvQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KNz27bwW3QDD6JcckAZ0FLwmcDd5xxnL8c3oPCcVIPw=;
 b=kcRWV7avBHRCqCXv5g+fxvLqzWVykmESk1/vcGOnOCHsTl54yTvRMSC4uVYFORUaFt8WavuwRILTZH817Dxh3XzGNTG7cWrziroO68Gulk+o/q3JwnN2p7sWs6ktd0hV9BwkDWg+c2QYYZyo9NvRzXixzdogCq44VCjmEnOqJcnHn1sXAbjd1kOV6z0/CXLYAv3WjEFh4NpWmU0e/LEDFg0mMRMekCVEr5fi5XR/qwwcLC7TiZiRaOPO4ZiXvpxKaYkTP4MqSCfNvvRUNhOSXdE+PEyoSuC4PKA6CuFXf87oB9c7zGma+s/XmGu0q30dT/NF9Lw6fLcmmNkRMR2wEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27) by PH0PR11MB4806.namprd11.prod.outlook.com
 (2603:10b6:510:31::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.8; Tue, 21 Apr
 2026 15:11:41 +0000
Received: from DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::f30e:2322:8783:964d]) by DM3PPF63A6024A9.namprd11.prod.outlook.com
 ([fe80::f30e:2322:8783:964d%3]) with mapi id 15.20.9769.046; Tue, 21 Apr 2026
 15:11:41 +0000
Message-ID: <33307e6f-19f6-401c-bd49-725c56596678@intel.com>
Date: Tue, 21 Apr 2026 17:11:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Pressing the power button causes the device to freeze completely
To: Evgeny Sagatov <sagatov@ya.ru>
References: <184091776095270@mail.yandex.ru>
Content-Language: en-US
CC: "regressions@lists.linux.dev" <regressions@lists.linux.dev>, "Rafael J.
 Wysocki" <rafael@kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, Thorsten Leemhuis <regressions@leemhuis.info>,
	LKML <linux-kernel@vger.kernel.org>
From: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
In-Reply-To: <184091776095270@mail.yandex.ru>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU2PR04CA0036.eurprd04.prod.outlook.com
 (2603:10a6:10:234::11) To DM3PPF63A6024A9.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f27)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PPF63A6024A9:EE_|PH0PR11MB4806:EE_
X-MS-Office365-Filtering-Correlation-Id: 54dc2726-2f68-45af-7ae1-08de9fb84ad9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: HtvL5XsT199PaIf/OTwbYdBsys84CAspuqGb1g3FMqsokd4YTJ+Q9nVX8Ki018u2ShNbJuWLng0hL7PGyAkbithaNzghyEKcmu/FGtYr4Ka3gYUF0q28VgSyUye2W1ZsUO+sQ8zD7AGs3AaMYpYPtTCvGM1Dy9WGbsmv+HYyAObKPItXV70BZPNGSOQY3aQAuxkUFlbrblMeRDyo8b3CyY5fFPt9YU/DfrTBL8WY5sAy+XwDrajo+K8y0lxseWacE5OW9kvu22D2hMOdkG4RoxXzoLEONQ+Q0Ch0IKVfYCUBJ6pamv6rMDS6mJzCYI4JsrAyT0VzoLmavKYLlRM7IqcwAm29ujJHlu0tLacXYt/TGwgmGg+YZuKWcNHU76DmYvwsYMdCfj9mCzICeit5VfnnLd7qacNdwCV9c9t1FiGCtxXkq6ZcceV1OFrfDIofzjiyO1VOi5kulRBwUO/zSn4GZD+VnP1I41Wx7xRUfqrOiftxqV94uADPbs1PRamik4JpHIsRZzamvie3nktqaB2oYotl02oLtJaZmAgMmjhOudHyjDNHTEk9K67GJbpaLTuWTtTD9gBs3uBCIl8SBjZgtoHgb9P+8vl7yRJCNu2qKUrlIl847MA9SFHI2okgNfCqlwcuI+VAQmOinFAen8D7wYyYJndDs+4BnM3EC8JYqYqWjla3b2U4lETIG09tz834lKldH+CUIoH/jIPTDg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF63A6024A9.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVI0dzBTNzhXbU43WXROajl3K3Z1cHpDbStJY0lNSm54Sm1VLzQ5SGdzRXdz?=
 =?utf-8?B?K2krN2Q1bURqUkp6VXJBRTFWZG4rM1V5NXJEbjFLa1ZpS2JuVjVGVFI2cCtJ?=
 =?utf-8?B?aklkLzZwZzBtR3BHSndtSUVtUGRGWFAxQ3pyeEVjVXBDQUZjdzhuN011RTlR?=
 =?utf-8?B?VHJmSkNlZ3QyN1QwV3psMzFBYkcyYmxTRDhzRHRhbTBXb2xRVjYyeXVMK3FV?=
 =?utf-8?B?SHlKS2J4bDBWcVNHUWc4bi9iM0tPUjVsNm5UNjg0bHFjMEFZeEN1dWtORTNz?=
 =?utf-8?B?K0J3em9jaitNYnEvNG5VTGhJSmk2cnRJZWFhL2Z6cEh1dmdGMGRkWkJzMStu?=
 =?utf-8?B?a0ViNDAxaFNDT3FZeGozNC96Z1pEeGNDOW0weCs5MFJzM1ZMVnRSZUpPT3lN?=
 =?utf-8?B?TEw2ZFNmbENHUjdRZzNZbkV0aE0ydDJhUFIxeTF2aUIyR3U1WEJDQU9WL2pk?=
 =?utf-8?B?SEF5eG9UZXBCbmp2Vmp3Yk5NOW9OZ0Y4aDErTSt4bEVJTHNGS1U3WFI2Z09o?=
 =?utf-8?B?U3FoYXd4ZHNBU3NGcVFaQlNETjJGNUJBVElzWDh2blpTMTZNZ0NFaEJFQmto?=
 =?utf-8?B?cng5VVR0eXZ5V2RsN3p5S3drdVdNK3JJMUtuV3BCdjd0aEN1dHZUMFMyNTBP?=
 =?utf-8?B?RGJOSEU3R0poSkxSWkthenV1ajJMdS9YWHlzZkJ5MnVRaWtENUtFSVVwbERF?=
 =?utf-8?B?TzUrR3pseWFUMm83WEx4Y1lobTJtdHdaQlNlWW9QbnhMbllsTGc5ZVlrOTlZ?=
 =?utf-8?B?TEZrN2MyZ3hwR3hmRm5GR0N3c25qNGxvSko0THdtWFRQSTcwRGdkeFBxQVpi?=
 =?utf-8?B?ZVBWK1plemlNZG1HcDhmT1k2YlQxVHEyZ0YzVXZhQUo5dFNJdTZFRnVPMGgx?=
 =?utf-8?B?VlFoczN4UkhUdHdTZGhlN043UEkyWWZyejN3NU5nM0RyRDJFNE1ZOWM5U2hS?=
 =?utf-8?B?ZVVpTllmZVhhVWgzeTd4aVhaQ3c3d2M0Y0V3NGRZSUR6S0kwYnlBdk0xcTQx?=
 =?utf-8?B?bVdmR3ltMkdQZUhmY2VnZGJmd0dIQVY5MitGSCt5T3pzd25RbGhYUjM4dkVh?=
 =?utf-8?B?TEdKWEVGSE14OE5SUjdnanFoc0twVVA2RHowZFo1dy9PKzNTRDhiZFRCdElu?=
 =?utf-8?B?b3ozR1A1OEo0cGo1OGJZYytOdUFBVXFSNTM3bGM3Z1RXU1pjOFB0OGRvdmdu?=
 =?utf-8?B?REo5SzlFSlhEM3JYMUVhMkpvUVhXVXdtQnh0NWpYbFIzM1VxT0VSTXI5bkZP?=
 =?utf-8?B?VFo3TE16Yjl5Qk9DMmZyRG9nOGRYSXl3NGwwV0VvTGRXMGJHQXR0M0lodmdF?=
 =?utf-8?B?Z0xxZGZFTW0wbUxyalFYNzVJZmY3MWNxTTg3RGtvNHhUaUl5RnYyM000dFQz?=
 =?utf-8?B?cWFOamFsa2w0Z3pIN3FJZHhrcmlzY0ZHdEZjUklOYUhHK0lOTVRTRFhRNUlj?=
 =?utf-8?B?eXl6NDliU1V1M0pUbFI3REhjTVB5MDlpeTZGeVR5b24zeDN0VmtqdHBzNStx?=
 =?utf-8?B?cFVuaE9mc2dCamI2M0daZ1BwNHpNekhRQTFpZE9UV0R1L0FzUVpXeUd0bDFY?=
 =?utf-8?B?QzN2a0JHWHhxdVd5djFWUDErejE4K2NycVZWM0NsSktVRkNBaFdjT2xFZ3VB?=
 =?utf-8?B?b1VHek1yZEhSekhzZ3kwRk1hSWFCRzIwMFZpUHJ4UVdKNmhObXhLVkJFZXZW?=
 =?utf-8?B?dWgzRmxGUGluR0hSQ3dYdFFHc3VTVDlTdDUyRzJhY2x5UmdaUjV3QmFPbC9J?=
 =?utf-8?B?N0ZiNEt1VVZZZW5wVEZ3UVA2d1NrUjl6VElTSEdwZzViVjdnTFN2ZEpaQTAw?=
 =?utf-8?B?S2VYZjNSbVVBN0NBNnB2QnBxWVRZT3ZjQ3dub2pZc3FBeThhRUIvYXpzM3dP?=
 =?utf-8?B?RkxWeDlTZGs2ZDRGa0xSYTlOYWlHZWszcXlaMmQvdVhoK1duL3VwVi9hZVZy?=
 =?utf-8?B?WXE3bE4xbC9hbVptajQyeHR3WUR2Qjh6QlBnOWtLdDhtQ0E4Z2VxcVNJUWtU?=
 =?utf-8?B?RWRwVXpHUmRhZFRORzYweTRnSzZHbVd1dDNnWnpHazh3MDQ0Qi8xdVc4VUxY?=
 =?utf-8?B?ZEpXMEFHeGkzSFFSdEJhemVieWVPN2ZHeVpjU0E5WHoyVlg0b2xTS3hjY0dS?=
 =?utf-8?B?MHV4UHhGM0JuRmZiQzFaQi9DRG9QdGFHOXdheng0YXNsYU9DYVcvWGduUnFi?=
 =?utf-8?B?V3FCWG5sWktVZlMvYVp6WHpJY1RtRXAvTnlSWjJ0M2t0YjBEVkRCamlTNW9G?=
 =?utf-8?B?ZzFXQzJuU1BkQjZCZ0ZJNHlLdlBkTm52TlNNMmpSN1ZGTjlvUzRFMW5ScmN0?=
 =?utf-8?B?dzlyakk2emFRczFwK1ZVK2w3OFZqNFF0eXJMSVpQRjAwSUxOYzQrdzZkY3h6?=
 =?utf-8?Q?DCqwmTcNX071BAME=3D?=
X-Exchange-RoutingPolicyChecked: fel20MfmiseXncA7Rcsec2Ask8VIO6VA0KK8LF0JC1Vfoc/sAe2GfVsiFESKmZzuwGPW58nfSKlV2jkQgQqYvKLTo4KLK5RbRRTbieg7NBQ+mio44T0WtPR2nCTMRK5GZPZ2PxBGGuKugfuy6xU7mJWg7J5Uc7aPm476Fb072Meepp2WBrVDT0Vl4UOO7YlhL5Xc+43Ej9ewhcIjHu83GUaVp3X3FoRKejJt56wEQimrKxgu6Iy63TJ1/h6BrjbTgbcFNX/ZFC6cPEHElSp7nsZBJAR/hX9x5S/3bnBOKMdAwHW7red6mbimiir0D+0FQWNjNlWZdUBIADdsUzt+BQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 54dc2726-2f68-45af-7ae1-08de9fb84ad9
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF63A6024A9.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 15:11:41.4187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hcxYpUcHHJbmlg3gnz40TxofFHwXav4uGOQWg94a89cTqRwoVJxLXahLwClwPYgRmXL0tp0ACsFcCjYLmzfUEM5ReE+4OERllxupJdClKNk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4806
X-OriginatorOrg: intel.com

Hi,

On 4/13/2026 6:46 PM, Evgeny Sagatov wrote:
> Hello,
> I have a PC with a motherboard GA-EP45T-UD3LR (Rev. 1.0) 
> <https://www.gigabyte.com/Motherboard/GA-EP45T-UD3LR-rev-10> and 
> processor Intel Core 2 Quad Q9550.
> Previously, I had Debian 12 with kernel 6.1 installed, and pressing 
> the power button would shut down the PC as usual.
> I updated to Debian 13 with kernel 6.12.74, and now pressing the power 
> button causes the PC to freeze completely.
> I see that systemd doesn't even begin to shut down. It freezes 
> immediately after pressing the button. There's no error message in 
> console. There's no error message in the logs either. Netconsole 
> doesn't report any errors, and the kernel doesn't panic. It just 
> freezes completely.

It looks like the ACPI button notify handler crashes on your system for 
some obscure reason.

It should be possible to get to the bottom of it, but it will require 
some investigation if you have the motivation and time to run debug patches.


> I checked that Live CD with Debian 12 continue to shut down normally, 
> but Live CD with Debian 13 freeze.
> I tried updating and resetting the BIOS. I tried various kernel 
> parameters related to ACPI settings. I also tried kernels 6.18 and 
> 6.19. Nothing fixed the problem.
> If I unload the "button" module, the system doesn't freeze, but it 
> also doesn't shut down.

This is a useful data point, thanks!


> I built "button" module by rolling back its version to commit 1a20d40 
> <https://github.com/torvalds/linux/commit/1a20d409c874255086e2f42a729826d490294c91>, 
> which corresponds to kernel version 6.1. This module does not freeze, 
> but does not turn off the PC either.
> I've found that the freezes have been occurring since commit 0d51157 
> <https://github.com/torvalds/linux/commit/0d51157dfaac05ea66616d8a250dce04bef49a4f>.

The main difference made by it is the fixed events handling and if there 
is a problem with that, a few debug patches should suffice to find out 
what's going on.  I'll send you one to try shortly.

Thanks, Rafael


