Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795625905;
	b=rIdB9Q01L9Kb1HsgCCt48sxmpJPbzKuLf3TdvSpSt7zp0tGRJdhrdnWYtXnngRBofYKE
	 36yPcZ9SwcTDqkBkQR6nJR34Y5ZNaBjZukBmkdngA5xzccI1vOy0uFm9PChK4tGAZIGno
	 fSfC5tFm1DI5v2GON6t79hBlF5EaC5yzUz5yFKzLGgds78zJZddSXkeqTfiIUVLc0VmX4
	 +RvrqEWKjt09ncX6U/XQmzZ+/YIEn8QrSbck35CiDyZpSPgELZPf2rITKvLac27kbZhbo
	 YwJ4WYayIy2JXy9dZEwsfkinCTUlC+bOTqcfeGm7UDYiJDGulFJe0QAT6vbChI2rCgg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795625905;
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
	bh=yw8X0xsCD/nVoc0Ako6fX3haYJYsGyI1Pr+OPG88vnY=;
	b=uVQDaoZ4n/fk03pUcPW+O2znZbs+ytdKvfqdaGKVgh8zNiHyL385zfxVvMzKQ+we1SBp
	 /ny2nJp61t1NPD0CdKNBy2ZuT7209RCGTfc4sDzDSLRAA+VHXFqTjuT9oHsbCljqKEz15
	 I1oaaPCgwTThGov6viQEWYWH9/nmipQZks3FWZg5jAIhidJFdVK76Uousy7+r9Bl0RKok
	 JjCipepCIjzpFTH2Vt3yoWVd1C7bZHXc62+yuq0tBGS9LVtQ9+JbXgLWqqTUoNdh1PS2u
	 QvLaMrlF/WMm8c5unv6b4z/m7WrHFyBfI9DhVD8V++wYpNdmddvYDDzSatU2U4TYiAg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=KOf4iWaY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.9
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012009.outbound.protection.outlook.com [52.101.53.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF57606A323;
	Wed, 25 Nov 2026 16:58:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCF57606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=KOf4iWaY
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZNxmbn2qc3WARXrWf48qmJZzKzg2pyQhxpcTGsddbwDxATC/bRYe+T3qdZAtddqWcQkZeHwUcSdg/ubwtdQQwVuJxmNvhgMIQnvi7c2Ls02YUpXCr3BCkEkL5Qi6rXlCTXbl56hW56FsFlNTU2/KMgyMBy6hu330dl+mDIHPJrEZPP2ViZtBCmTf40WSor8R4+iiupVMtaz9AXFcymfiRKECM+/TOFL2we169e2DfMC/9Mg5kwKbVgy2mIfK+M51lQvFcrz7CLyfv6W/o+S1KdunelIO50mEtcNaP9m4pJDmLlOH3xLdhq0w2ILDpgY+YEvOrG7OmEqIr+Lee9WyiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yw8X0xsCD/nVoc0Ako6fX3haYJYsGyI1Pr+OPG88vnY=;
 b=ydckxXz6h8vT8/qkdM/dc4mb9p8s8NzNg0+WgUYJqXdNot7f4oMUCK77RcIuVTSsSqSouyVP0Q8W1FW3vrZLyLHvg9gSaurvmqDiPefbhD/X1sx8DPMFd6GQM2to+vX+JE8NhcvwR6CpGEnFYITMaEhhFW+F3kMu+GTy3lyK78xVhRMc8Lje5gJoBKXcXE0o7Xo7ChmQKdr75zyMZ18Ks5T8l9FwnVa6qwVDxIHokuFX2tR4qMykYdipVdTJMnwdMZ4T43ZDoq7IygryHL8qXnhgvX8TD+/O53kyiFf8sIuEYvrnQhoSsXO+gC+LW8zERnR0k8zvF9CMuVAkrOdtAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yw8X0xsCD/nVoc0Ako6fX3haYJYsGyI1Pr+OPG88vnY=;
 b=KOf4iWaYiXdkeGDnDbV2dSUCfuoxEvxWgDL78/YO3nvfUnXkNvHw28R5076pAtwJ9qljXbj7b+sKLQehkeji4fB4uf/Nzw6ix8ibGEnbyJ+1FKAOS8j1cbkEPJ93/x4xhO/eF47l6RZ+vuk0pm437Xog9Ni29aqRIjCFycBOLcc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from EAYPR12MB923140.namprd12.prod.outlook.com
 (2603:10b6:303:2fd::15) by CH3PR12MB9218.namprd12.prod.outlook.com
 (2603:10b6:610:19f::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 16:58:12 +0000
Received: from EAYPR12MB923140.namprd12.prod.outlook.com
 ([fe80::b986:8b81:beda:c167]) by EAYPR12MB923140.namprd12.prod.outlook.com
 ([fe80::b986:8b81:beda:c167%4]) with mapi id 15.21.0639.012; Wed, 25 Nov 2026
 16:58:12 +0000
Date: Wed, 25 Nov 2026 11:58:06 -0500
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
Message-ID: <20261125165806.GJ2156781@yaz-khff2.amd.com>
References: <20261113132600.3355836-1-pierre.gondois@arm.com>
 <20261124151417.GB2156781@yaz-khff2.amd.com>
 <7288ecda-6a1b-4b3d-9e2f-8bdbf935efc4@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7288ecda-6a1b-4b3d-9e2f-8bdbf935efc4@arm.com>
X-ClientProxiedBy: BN0PR10CA0013.namprd10.prod.outlook.com
 (2603:10b6:408:143::17) To EAYPR12MB923140.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: EAYPR12MB923140:EE_|CH3PR12MB9218:EE_
X-MS-Office365-Filtering-Correlation-Id: dfeae5b3-76c0-47dc-2508-08df4b154a83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|18002099003|22082099003|56012099006|4143699003|11063799006|5023799004|261009223027099003|261102123227099003|261021121427099003|261022113327099003|10067099003|261026140227099003|261022105027099003|261022075727099003|261026121527099003|261028144727099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	DHUKXZwYfUzeIKMGvzX09LlbzDpp+0ctV3VkXVfsffNZB2vn3gftTulZsy0xkHCbAiU1KR5IRKz3Md8UeLNaU4fxRQ44AFYEEQbmjMp0scCIu27NNzTPveDhGDy7aOyTXOgxEIpiS0yZpCX6NpqQvrjqejI0UHCkQZ266KN/TaqevLidZxV8jKJndj3zGeiCAeaDHPGe3iKGleU3ou81awNb/LKvJ5RV7ZhPyJngyr/s0w5Lj4Bv6w4t7x1PyXq3KHjNWkW8WjSMvyDaos+ei3bEEev+mShKQ4okgR2PkyWxtGj2MireddnsovjErMws+cP/h4n3e3kyQ/Rlvnn3PFKZemUsY3qfeMAZV+a+2lMe1YDYFtUCZvIcPlf0Ghafko5tTuvqeObfYl9rq0QzJ1uTdyT0te5Fm4k6OGA642P1zx1ImaIZ9dvfPybJPcJpWF4M3Y/nRnrO3t+3CqRC+8j/rtqHAFn0GnocOJPLNKH2TQHcYzTt3BNKgWSwoWmcmit4v8XFZ/W1uHXtSW1JcdGmGJ6sRXaCek2kymWbOYjZJWyEqmIlGn+XjRXiT6zoSUmSWpg+OT3ktnrHy8lCSEyrist/uJxYC7zHFTvdOyv1pMlft5+g5Zk9zzYYY0KN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:EAYPR12MB923140.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(5023799004)(261009223027099003)(261102123227099003)(261021121427099003)(261022113327099003)(10067099003)(261026140227099003)(261022105027099003)(261022075727099003)(261026121527099003)(261028144727099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ltH/hjZ/azNPVNtyyl8B7Oj/zCfcPSVn/vrtY935MCPjzPCj7Y0xj5Gkihr/?=
 =?us-ascii?Q?cpdVJlhjAWsNaqMWSPiJDNT6prklwX8tHg42kNYZa0S02n3S4HBvfxB0ERvZ?=
 =?us-ascii?Q?vFx1JL52jUNNDvUmjAjJpk97MWkqSoglC4I+URhVtiSVHuWOtw6ytttCQywg?=
 =?us-ascii?Q?FrBqFzeRUpnUXMjsXpHsa/n1sQfF9Tho9P3zKAPGAjM1MwlohUHm3cNCIcaS?=
 =?us-ascii?Q?TowooUvXf//F+IagZMrTP5KmmKjJhdCW1S4Qg4bUKPnUT2wpe2q75EHZsTBc?=
 =?us-ascii?Q?kzyia9FLLace7aoF0uLKp9T1dSBBSaQxoncDr2GdIWm7WIT1d4m0n2W+CbRb?=
 =?us-ascii?Q?0RGcnOyr0FM2Y02R6/MxP2lBgMyCCDtyBgta3JJAwCTqs8kEFvsvaZtfZfuN?=
 =?us-ascii?Q?XQri8AWwk0/AsexVh7CT8HIJGicD6TfEgLWGZyRBhSTuB9sTZgynkh6EExYe?=
 =?us-ascii?Q?+d9rd8wqEdPNFrXcA29Q5gO0cCCkQPRkURrZUr0YqNFGLZwevfhDbR7E8SrZ?=
 =?us-ascii?Q?IrvDXpMIdZNgUVhyjrUrz2d7sCZoZI0Ec8bejqDduhXKPOBnq5uj9KO90N4i?=
 =?us-ascii?Q?RsJoBzVeYKHCkKUZvOyHQ2n+wPz/hUqH0ycC8VhtI4cLwp0KBr0QCRv0nzxn?=
 =?us-ascii?Q?LMIumvA3TtEvNvMrrjjlHX5aZJObymJsKcjDR6w9mSOYqjpvq2wJw5id8/hf?=
 =?us-ascii?Q?BpcMNogTdOk1ES/H442sAc32USv9r3mAZwacKy1XmmFyQ1CM2dxRFl3HRtUi?=
 =?us-ascii?Q?uoH1JwGGFxTIuoDtOvjTHJGb9eaylSuE7ddjkhuSs1XEAFbV5mFxc9SaX3UE?=
 =?us-ascii?Q?nvdemN+ZbzQUs2A8K2pSXnTHjJN3QaDQEfKhCMNfkSAaHINoglVsIJbEBAXO?=
 =?us-ascii?Q?JA2Qp4+Nw0qNQyavxgtpEOwCmLcPssoiD+3OGECkOkvx9FeLosdXJ/IbujYC?=
 =?us-ascii?Q?ork24jGITjMe6CLFDMMPPW1XPb6dQpg7BNSlo2QVX/dvlZmM5wY731ERsiCM?=
 =?us-ascii?Q?OlLad2ZVKXI+dCsY9RJPt4XCkZgayXf18RWrFwmNusiYi0XQvqJRlT6gD1lb?=
 =?us-ascii?Q?57O+bkHRGpeUZtoZf9GsSdkNXTHcem5EX9vAhidkJ4CYOTtIMMFe3orIT68A?=
 =?us-ascii?Q?paIhf4HKPsOzKa6SuWg9Q2f/rvAaRk5PHFzeAfQyFI24nM/zxEJPHo74kvjU?=
 =?us-ascii?Q?rbSBVLW6HOAh+EH+fU8hA//Z6dEuTZAUa3oP/EGvHVVX0lt6YFt46oOGbvtg?=
 =?us-ascii?Q?3JqxBpxujmxIjxEOxrRO2oKcGl51cOiQCPMn+qrIAoHNg00U2Af86/Y53aMy?=
 =?us-ascii?Q?WJabg1FtvuWIzrdC7LVYb2XQiFGNxyKtmitavsduKS9kTJaDl0sIl9YzBnKq?=
 =?us-ascii?Q?N6iJkz1kFVdLqg8YJDT5vIXEmGlt4WLShf6SRxsW0u7gMuvg0VxT7z6EOzgo?=
 =?us-ascii?Q?xNmS110BpG1T3lkqPI9/WTwnfWRyN69mUcY36LilaKbKuJgcUrE2Ov/Ilrnb?=
 =?us-ascii?Q?BAJlc7oNze6yZpqoW5KWK8dpygCCnr5yVKzJVWo7DHivQ5l8ihWUrb2gYCUJ?=
 =?us-ascii?Q?bV0CvrZdJPVmd1Pc2j3kBUjI92ujx1zQSTuGOSl3hhRx4irnGm9FIUm+JkCf?=
 =?us-ascii?Q?3hXJ2fUR9KTpPuIa4VQEFlOuKIjz9RP2S+D+rUwvIlEEpoQXuWv9etZ/RsIH?=
 =?us-ascii?Q?sCIrlSa7ZqFt2NI/B/7wdmi1gyq8MBMPJ178w4Uq+0r/f+wl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfeae5b3-76c0-47dc-2508-08df4b154a83
X-MS-Exchange-CrossTenant-AuthSource: EAYPR12MB923140.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 16:58:12.7539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +XDODMetp/BOOJp05rW/5MgrsymLYk2TTOErJEQXPXFAqvIXl/qP+Z7hYJKwrAPSfxnbeTSW6A9ykv/a0+MG2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9218

On Wed, Nov 25, 2026 at 05:30:18PM +0100, Pierre Gondois wrote:
> Hello Yazen,
> 
> On 11/24/26 16:14, Yazen Ghannam wrote:
> > On Fri, Nov 13, 2026 at 02:24:42PM +0100, Pierre Gondois wrote:
> > > The support is mostly duplicated from Memory Error Section handling.
> > > Other than differences coming from the content of  Memory Error
> > > Section 1 and 2, differences in the support are:
> > > 
> > > - v2 do not rely on a compact "struct cper_mem_err_compact" struct.
> > > This structure was used to support older versions of the Memory
> > > Error Section (1). This is not needed for the new structure.
> > > 
> > > - The compact version is also used by the tracing framework.
> > > To avoid relying and propagating a non-standard record format,
> > > through trace event (cf. extlog_mem event) the new trace event
> > > prints each field individually.
> > > 
> > > The last patch of the serie was only build-tested due to the
> > > absence of relevant hardware. apei_mce_report_mem_error() and
> > > arch_apei_report_mem_error() implementations were also removed since
> > > last version.
> > > 
> > > It will also require a proper handling from the rasdaemon. Applying
> > > this last patch without rasdaemon support will silent the reports of
> > > Memory Error Section 2 error, cf. ras_userspace_consumers() check.
> > > 
> > > Future:
> > > - _OSC support (if agreed)
> > > - Addition of arm64 tracepoints
> > > https://lore.kernel.org/lkml/20261023170405.000060b8@oss.qualcomm.com/
> > > - Emission of lossy CPER Mem error v1 tracepoints for legacy userspace
> > >    tools
> > > https://lore.kernel.org/lkml/at0rs4parlHFGI7k@hu-ashoraj-lv.qualcomm.com/
> > > 
> > > 
> > > RFC:https://lore.kernel.org/all/20260929074659.2587216-1-pierre.gondois@arm.com/#t
> > > V1:https://lore.kernel.org/all/20261019145643.1877246-1-pierre.gondois@arm.com/
> > > - Corrections from Jonathan's review
> > > - New patch:
> > >      [PATCH v2 4/6] EDAC/ghes: Extract error report initialization
> > > - Last patch not in RFC as it has been reviewed by Jonathan@
> > >      [PATCH v2 6/6] ACPI: extlog: add Memory Error Section 2 trace event
> > > V2:
> > > - Updated ghes_edac_init_error() to ghes_edac_init_error_desc(),
> > >    which now only acts on the input "struct edac_raw_error_desc"
> > >    + added lockdep_assert_held() to ghes_edac_init_error_desc()
> > > - Accumulate failures with "queued |=" in ghes_do_proc()
> > > - New PATCH:
> > >    [PATCH v3 5/7] ACPI: APEI: Extract common memory failure handling
> > > 
> > > V3:
> > > - Added <linux/bits.h> include
> > > - Used pr_warn_rate_limited()
> > > - Removed one warn for smbios handle overflow
> > > - Replaced __string() -> __string_len() in trace event
> > > 
> > > Added patch to us scnprintf():
> > > - cper: Return actual bytes written by DIMM location helpers
> > > Added patches to increase buffer size and prevent overflows:
> > > - EDAC/ghes: Small buffer fixes for mem other_detail helpers
> > > - efi/cper: Pass buffer length to memory location helpers
> > > - efi/cper: Pass buffer length to DIMM location helpers
> > > 
> > > Pierre Gondois (12):
> > >    cper: use BIT_ULL() for processor and memory validation bits
> > >    cper: add Memory Error Section 2 structures
> > >    cper: add helpers to handle Memory Error Section 2
> > >    cper: Return actual bytes written by DIMM location helpers
> > Why not use 'efi/cper' for these ^^^ ?
> > 
> Right, I'll update it
> 
> 
> > >    EDAC/ghes: Extract error report initialization
> > >    ACPI: APEI: Extract common memory failure handling
> > >    ACPI: APEI: add separate Memory Error Section 2 handlers
> > >    ACPI: extlog: add Memory Error Section 2 trace event
> > >    efi/cper: Pass buffer length to DIMM location helpers
> > >    efi/cper: Pass buffer length to memory location helpers
> > >    EDAC/ghes: Small buffer fixes for mem other_detail helpers
> > >    efi/cper: Increase memory error location and detail buffer sizes
> > > 
> > Boris already mentioned having fixes go first. I think the common
> > convention is to have "fixes > refactoring > new feature" order. I asked
> > an LLM assistant to propose a new patch order (copied at the end). Some
> > patches would need to be split/reworked, so it's not a strict 1-to-1
> > reordering. I hope this helps.
> 
> I thought sending fixes/refactor/new features separately would
> make it more difficult to understand where the patchset wanted
> to go, as the refactoring part is usually preparing for the new
> feature. E.g. B2 +B3 only make sense if v4.7 ("ACPI: APEI: add separate
> Memory Error Section 2 handlers") is applied.
> 
> But if you both prefer it in split series I can do it sure.
> 

I didn't mean to split the series necessarily. Though you could do that.
That may make more sense for any independent fixes.

I meant that some of the individual patches may need to be broken up and
rearranged into new patches.

Thanks,
Yazen
