Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.3
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795533276;
	b=jBCjlp6m772JGnMGrJma03nCNlHN0myaweFBQT0L4wxhzcL34KUJuF5yoBch9PXbMxQp
	 vFRlTHSDXR18M8NoQN8/bSUYq57FVNr5qzf51Ga5KOsCRF87RGQdApVFjH3XXHRAna9Dp
	 75GJGjZSqdnPFDI2oNQIVDXP4FQzGdV2OI6M+/OS/a8jYA8P1yR+vVZ5D7v/cdINVOGZ1
	 SgUKEZ/onOHnEFSnxMtkM4sXOFTteS0sE3DbWuhoi8uEdjeGLwkIM/XuzmRP5pwtqdaXs
	 GOVkgZ2ptqZI1UklML4ajYGw+Fehsesdtcp5fg6XQh/MCRJMU8n2aHJjpYLpFSaKO0A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795533276;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=03V5GD7kQqoVsq4w6sMK3MOuCKEqC8dnZKsmD1OJjs0=;
	b=NR8LKaK2F44JC/WCs43Dm52xPWm89I2glS/DNprHXVi/QHi22yvjXT/JFTXXlNvoLYOA
	 ZIwV7G8ISgzn/pwXjlBtccvnXtY/iuRTiJmi1/MbAh8NbSd4lCctbXhH+WqjTpn5x9CgI
	 K3N+paitadUBpeTDmeJp6iLdi3fPsCf9BWKKnapuD/XmWp/fTsxGBawGAvXHyndyGV1WW
	 kbT8nEQHaD9iJ/YFPLC6D2hdyIcPB6fR1Z8MIThnrgbZRghKNDPTPmRmKy4iF1txARxj1
	 2Xl5qopMWL9mg2okwoKzBbmW/FIY4Gb08WEgHoXV1rYM1tdNcAzEtf1ERvJ1QYnkqMA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=LVKeRohz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.3
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013003.outbound.protection.outlook.com [40.107.201.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE86E606A321;
	Tue, 24 Nov 2026 15:14:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE86E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=LVKeRohz
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yfs/hPFc0igRsKz0kSaZM54txeEov+bHy++CCQnqArZY14Ex++j2uR3WupXMfoXXrsZov2jmXxrQm3ei5ub3ROyuyJ7Hy3XUnc2KhPpFVAK6cuzvYAr2EOpGTzjGZfnur0a1l6yxIAWfPBv3qSFACGPUb/KZ0Yg0+GfadGQJxJvsQb6yM5yVTUr0SliuC/+E1BtrsUKS2wU+Lts1UiEuKEezH4qRyoLyShgP+kkaaaY9Uj1n8NacA6Yngrxhyo195AuW3AOdJtdmFPDDWMoFBVItHkv8W+xcjjptj0mZWJKc70S0BEyTVI5poCSvIHGiKRDb9LaRTxG4eATnquL2mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=03V5GD7kQqoVsq4w6sMK3MOuCKEqC8dnZKsmD1OJjs0=;
 b=bq602sVbCBDUKAQXeiG4u2cCD7DYL/dTjygD0pTCPjFklvUTT9aT3eO7W1dFLDxEmDGfROCNMFQ+H5loLIEQZ/eyfXwc+2j4sagjES6u9dXYGvHUiNmXhF36c4CdACi79hVermySHMYhLqQtNYERmDCQrx80O8unzJ1cwdrIyCS/8CBf0N1jtbiLDJYJ1DcYLsInitpB8WDbOlz3aHbJUtjfnoetAfqzRQXEWUCJLw8KVkORBtQ1JkA9qRRWNKDY7l+zPDUP7pj5gzB0o1I34ILltdTilSB33MpoChW44pQwALnvNOynr3ffsQucKiOJUNc98HO3FA6oqr3/dvhIuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=03V5GD7kQqoVsq4w6sMK3MOuCKEqC8dnZKsmD1OJjs0=;
 b=LVKeRohzVPcFG9hzROoTvRN88ZhAJJVTBLWYcsiVcxHUyYsf9uuJYE5NqbTZ9EuI6ZtYKK/AJma83vhkMRo7c4FT6TECyzJ+sEvBCfABymMp2cOvD3pbar3wmDJfs0S6AG6DSTshKwWVhGaVPZok2y/29zK3xFersRkCOiBPsmw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from EAYPR12MB923140.namprd12.prod.outlook.com
 (2603:10b6:303:2fd::15) by CH0PR12MB8461.namprd12.prod.outlook.com
 (2603:10b6:610:183::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 15:14:28 +0000
Received: from EAYPR12MB923140.namprd12.prod.outlook.com
 ([fe80::b986:8b81:beda:c167]) by EAYPR12MB923140.namprd12.prod.outlook.com
 ([fe80::b986:8b81:beda:c167%4]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 15:14:28 +0000
Date: Tue, 24 Nov 2026 10:14:17 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, Ashok Raj <ashok.raj@oss.qualcomm.com>,
	James Morse <james.morse@arm.com>, Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>, Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Dave Jiang <dave.jiang@intel.com>, Breno Leitao <leitao@debian.org>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>, Dan Williams <djbw@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Morduan Zang <zhangdandan@uniontech.com>,
	linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: Re: [PATCH v4 00/12] CPER: Add Memory Error Section 2 support
Message-ID: <20261124151417.GB2156781@yaz-khff2.amd.com>
References: <20261113132600.3355836-1-pierre.gondois@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261113132600.3355836-1-pierre.gondois@arm.com>
X-ClientProxiedBy: BN9PR03CA0265.namprd03.prod.outlook.com
 (2603:10b6:408:ff::30) To EAYPR12MB923140.namprd12.prod.outlook.com
 (2603:10b6:303:2fd::15)
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
X-MS-TrafficTypeDiagnostic: EAYPR12MB923140:EE_|CH0PR12MB8461:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d1925c3-4b63-4484-8f21-08df4a3da1e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|6133799003|22082099003|18002099003|5023799004|56012099006|11063799006|261026121527099003|261026140227099003|261028144727099003|261102123227099003|261009223027099003|261022105027099003|261021121427099003|261022075727099003|261022113327099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	roxdVM3BNy8qe/9mA3evyX3BcxEiV1sjJ+aj4bxk21ynJaAB7AUHmEA2S1rXYtHbah4gnCNSheJccDVbCOn20j+K/cN1aP5h5q3k5XQESukvn8YYTdyZry8eXoa1nF7GGsEyNLnEN8XtIz8860VUs3S+jPPO+fQ5k0ZsHazysipHu99kFu4adHeEgg8foZKujeQv+qdn5GHq5zZVKtJ77f1/pqXao5Rdcr2iBTFOo9qhMSqngZdiXa8qgXkl6u5PAZs1H5S0r93U4pvmSbxdjywRJ+VefEOv1Mk38r8QJj1wOS4DP/z02TRC1X78u+ZcvhiNgkl6qJ9ppQZ24JyoqB0J+o9I3Pw2P6oSu02fNULvgKAlaHbtkec6Qw0jiDq9CitASBrrKS2vEZOSxhKTsE/9h5esIQe+Ggk4v0SCe01sXGBwrC40TbfA/a6o3fPHsdZPQUyQ8mbaP7orvcShlVPABt3aeMUQdMgRN1GqN/ZCthiTvK/TIz9W9NPoxcqyu18ZW3UA1lf/QuIZ8LGBX/nB19e/WQwHxP2KfnYat6v5a8t/G/j9qiKT6xQfhBqO8c1UGjMUx5RMfgi7sk+0D6XM1FiElQ1T/P+RAcr4zS16VWMtChL1DjpoQU69rYQ/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:EAYPR12MB923140.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(6133799003)(22082099003)(18002099003)(5023799004)(56012099006)(11063799006)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(261009223027099003)(261022105027099003)(261021121427099003)(261022075727099003)(261022113327099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r56CIbc2E4hdJuR7Nh2EqUUbQWPr2/v4kFLficVjJXVg+6wx5dtaGz+CtAvd?=
 =?us-ascii?Q?8j+ZfoECX9MVI2uF6t59O2JlgpMwhEtfN/Vsh0FLQR5ObTzp/rpg1C14lE1c?=
 =?us-ascii?Q?iasZ8nNQNtBjruPGuzSJTd6L2qH+uMyaXOM97tX99zwoU08MmnvUc0M+bF5F?=
 =?us-ascii?Q?G1eSFt/9+WDMUf6qsV7Dt3bhxsQMMirEodk18Iyz2HcmuXnX8MdXr23/d7dE?=
 =?us-ascii?Q?JU/CFaxxx786VPN3hEc/oiL41Kx6QOyFS0Q17pmYoCVJL3Qi27w/+93eSPE5?=
 =?us-ascii?Q?ZfElWWfX5Evsotcm4b+4G/sMNo9s8LgDkZOWjdqYBQz1dbRKlvuehuRwdLZP?=
 =?us-ascii?Q?W3T/2o8nGMvCC7F0mma6pw3qcC25TmJ6uHYWZhvPuKkIKuELqnXuv1bGISim?=
 =?us-ascii?Q?U5N1uxSU55gGYGGNEfg/a6VNGVX5XXTPTt7gSk7j2MdNrzhDNRrTvqhlVImc?=
 =?us-ascii?Q?LgLvIv9Xdg/e6sBW8QiVsOc6Z/T2UGNDpUNjgsxKbPrPbwK5tR5Sk8uzsCzg?=
 =?us-ascii?Q?7qi1Lsy00yirumFzysL3IYHUoyElI5PW+8s4TZ3cRL0GpE5q55sszyjrJoRO?=
 =?us-ascii?Q?VIiCUA1m7xBvcJ9i42F0ZmuImbsywgCuAJAsYK43lEQHKGQQfcAlszyFinTO?=
 =?us-ascii?Q?WgDQedDL2wzFuWmGHOjtiiu+EK8vL9NhYtMvG/VN8Ty5j5DW97dTVh+G8zNm?=
 =?us-ascii?Q?iT8eNiB4PuuKBwgzjU5QTvg1DZR+52jGYxsPioPU++P8svLXN1bXgKzVXr98?=
 =?us-ascii?Q?P4U1saivJBw50p1NPjlC+Gkf3D/oFs945+WoZdOxrktWm7aBEDERGYuKSzgq?=
 =?us-ascii?Q?3n+Bv+1eGO5zfYpZ//XgSEEAyl6DBiM/JMtmCtFgbu2gsrwf545wrm5fucCB?=
 =?us-ascii?Q?4eUwUw0colto6mjTodkTy7L3B2JaHhVXPN/9XADMe/kQubkzv3QVlR4VpgHk?=
 =?us-ascii?Q?ACr80Ov11kAleTQn4lKGFb0n9ezuQmAWm3hiE+EDhXDrb9oJGBMvOWY9/kkl?=
 =?us-ascii?Q?gy1dbntfaeT2MXgOLtJ8eqGEQemEfi6uggxpj5vtEg144ANowAG5Akd0QtOp?=
 =?us-ascii?Q?0YzbItzUnIihghBBCrbOy/gPmNwGQGFfVFGrqSCtFTArhG5W5v+PT8UaxMtL?=
 =?us-ascii?Q?pgaXVFdOU0OYunu108Eym/al7naSK7dsQ/8XoAiFKduoeN+QOdT1YtBFXztG?=
 =?us-ascii?Q?iazTbvV06LWDFLb2Nw7LCPpdokndxXJEeYizRraCYC+m9Gw+kcKNouUwfDJi?=
 =?us-ascii?Q?LICJgV5NhfSsw4GcbmRe88GZcjVWEQZfNVKFypX6+HuFkBg/zMk0iw8y7F0D?=
 =?us-ascii?Q?dm/6Tq6wiPEGKyVi86R3+jmzT0FN/siebyMuOcYkaq51p0iF5SZBZGifU0xx?=
 =?us-ascii?Q?5E7ddVym/gc8+ikq9XkJKawt+V0is2drvJFDlU4E8IoRNUlHF+j6hnQVRWvb?=
 =?us-ascii?Q?wwpsOlPPIgyrpoeX4iGF1A9sznUsPiXwypRrW0ATuDyw4LHLnqageQBSkPeI?=
 =?us-ascii?Q?bnqh4FPcuwHYSANqGGziiDgHminWpcPk3OoiH//Lx+/Bw9inhztewmtzZg+z?=
 =?us-ascii?Q?Gq34dk3EGsojXwQnSIMZ9GJxJlwRiLOSuMwUTdjROE9gi64PGLPzz+nRd97p?=
 =?us-ascii?Q?W3en2g7KbrxYavBHZiu+x/Y0g9ndoS/thVPSHv9yi9MP2CoFc7wGb7evZEa5?=
 =?us-ascii?Q?fZ20qK8fBsNoo1x5vpNWZm2S3dYOUYoXNezdiMCV5/Sk0znE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d1925c3-4b63-4484-8f21-08df4a3da1e7
X-MS-Exchange-CrossTenant-AuthSource: EAYPR12MB923140.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 15:14:28.1587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6TthTKe1vUYCRNQM/odLNrSQuNPLO/F7xRqmAsIU9Ri6gNmPuBs4k6UrpML0t8iUbJKgLnlOvg5ilearX6kFoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8461

On Fri, Nov 13, 2026 at 02:24:42PM +0100, Pierre Gondois wrote:
> The support is mostly duplicated from Memory Error Section handling.
> Other than differences coming from the content of  Memory Error
> Section 1 and 2, differences in the support are:
> 
> - v2 do not rely on a compact "struct cper_mem_err_compact" struct.
> This structure was used to support older versions of the Memory
> Error Section (1). This is not needed for the new structure.
> 
> - The compact version is also used by the tracing framework.
> To avoid relying and propagating a non-standard record format,
> through trace event (cf. extlog_mem event) the new trace event
> prints each field individually.
> 
> The last patch of the serie was only build-tested due to the
> absence of relevant hardware. apei_mce_report_mem_error() and
> arch_apei_report_mem_error() implementations were also removed since
> last version.
> 
> It will also require a proper handling from the rasdaemon. Applying
> this last patch without rasdaemon support will silent the reports of
> Memory Error Section 2 error, cf. ras_userspace_consumers() check.
> 
> Future:
> - _OSC support (if agreed)
> - Addition of arm64 tracepoints
> https://lore.kernel.org/lkml/20261023170405.000060b8@oss.qualcomm.com/
> - Emission of lossy CPER Mem error v1 tracepoints for legacy userspace
>   tools
> https://lore.kernel.org/lkml/at0rs4parlHFGI7k@hu-ashoraj-lv.qualcomm.com/
> 
> 
> RFC: https://lore.kernel.org/all/20260929074659.2587216-1-pierre.gondois@arm.com/#t
> V1:  https://lore.kernel.org/all/20261019145643.1877246-1-pierre.gondois@arm.com/
> - Corrections from Jonathan's review
> - New patch:
>     [PATCH v2 4/6] EDAC/ghes: Extract error report initialization
> - Last patch not in RFC as it has been reviewed by Jonathan@
>     [PATCH v2 6/6] ACPI: extlog: add Memory Error Section 2 trace event
> V2:
> - Updated ghes_edac_init_error() to ghes_edac_init_error_desc(),
>   which now only acts on the input "struct edac_raw_error_desc"
>   + added lockdep_assert_held() to ghes_edac_init_error_desc()
> - Accumulate failures with "queued |=" in ghes_do_proc()
> - New PATCH:
>   [PATCH v3 5/7] ACPI: APEI: Extract common memory failure handling
> 
> V3:
> - Added <linux/bits.h> include
> - Used pr_warn_rate_limited()
> - Removed one warn for smbios handle overflow
> - Replaced __string() -> __string_len() in trace event
> 
> Added patch to us scnprintf():
> - cper: Return actual bytes written by DIMM location helpers
> Added patches to increase buffer size and prevent overflows:
> - EDAC/ghes: Small buffer fixes for mem other_detail helpers
> - efi/cper: Pass buffer length to memory location helpers
> - efi/cper: Pass buffer length to DIMM location helpers
> 
> Pierre Gondois (12):
>   cper: use BIT_ULL() for processor and memory validation bits
>   cper: add Memory Error Section 2 structures
>   cper: add helpers to handle Memory Error Section 2
>   cper: Return actual bytes written by DIMM location helpers

Why not use 'efi/cper' for these ^^^ ?


>   EDAC/ghes: Extract error report initialization
>   ACPI: APEI: Extract common memory failure handling
>   ACPI: APEI: add separate Memory Error Section 2 handlers
>   ACPI: extlog: add Memory Error Section 2 trace event
>   efi/cper: Pass buffer length to DIMM location helpers
>   efi/cper: Pass buffer length to memory location helpers
>   EDAC/ghes: Small buffer fixes for mem other_detail helpers
>   efi/cper: Increase memory error location and detail buffer sizes
> 

Boris already mentioned having fixes go first. I think the common
convention is to have "fixes > refactoring > new feature" order. I asked
an LLM assistant to propose a new patch order (copied at the end). Some
patches would need to be split/reworked, so it's not a strict 1-to-1
reordering. I hope this helps.

Thanks,
Yazen

=== PROPOSED PATCH ORDER ===
A. Fixes and cleanups to the existing Section 1 code (could be sent
   first or as a separate small series)
 A1 efi/cper: Bound the DIMM location to the remaining buffer
    (Section 1 parts of v4 4 and 9: scnprintf, a len parameter, the
    ghes_edac caller passing len - (p - e->location), and stripping
    the trailing char only if it is a space).
    Fixes: ed27b5df3877
 A2 efi/cper: Pass buffer length to cper_mem_err_location()
    (Section 1 part of v4 10, API consistency, not a fix)
 A3 EDAC/ghes: Clean up print_mem_error_other_detail() buffer handling
    (Section 1 part of v4 11, cleanup)
B. Prep with no behavior change
 B1 efi/cper: Use BIT_ULL() for processor and memory validation bits (v4 1)
 B2 EDAC/ghes: Extract error report initialization (v4 5)
 B3 ACPI: APEI: GHES: Extract common memory failure handling (v4 6)
C. Memory Error Section 2
 C1 efi/cper: Add Memory Error Section 2 structures (v4 2)
 C2 efi/cper: Increase CPER_REC_LEN for Memory Error Section 2
    (cper.h part of v4 12)
 C3 efi/cper: Add helpers to handle Memory Error Section 2
    (v4 3 plus the Section 2 parts of 4 and 10: scnprintf and len from
    the start)
 C4 ACPI: APEI: GHES: Add a Memory Error Section 2 handler
    (ghes.c/ghes.h part of v4 7)
 C5 EDAC: Increase LOCATION_SIZE (edac.h part of v4 12)
 C6 EDAC/ghes: Report Memory Error Section 2 errors
    (ghes_edac.c part of v4 7 plus the Section 2 parts of 9 and 11, and
    OTHER_DETAIL_LEN)
 C7 ACPI: extlog: Add a Memory Error Section 2 trace event (v4 8)

Why:
- No bisect gap. Buffer sizes (C2, C5) and length arguments (C3, C6)
  land no later than the code that needs them.
- No API changes after the fact. The Section 2 helpers are added once,
  in final form, instead of changing in v4 4, 9 and 10.
- A1 doesn't depend on Section 2. It can carry Fixes:/Cc: stable and be
  merged while Section 2 is still under discussion (Boris's question,
  _OSC, rasdaemon).
- One maintainer tree per patch (v4 7 and 12 each mix trees).
- Consistent prefixes: efi/cper:, ACPI: APEI: GHES:, EDAC/ghes:, EDAC:.

Caveat: C4 takes Section 2 out of the log_non_standard_event() path.
Nothing else emits a tracepoint for these records until C6, and nothing
ever does without ghes_edac. If C4 keeps calling log_non_standard_event()
(the patch 7 inline question), the order doesn't matter for userspace.
Otherwise squash C4 and C6, or keep them adjacent in the same pull.
