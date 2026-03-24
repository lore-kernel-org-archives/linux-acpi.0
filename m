Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010021.outbound.protection.outlook.com [52.101.61.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B62B296BB6;
	Tue, 24 Mar 2026 10:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774347266; cv=fail; b=bw5tR0VkCLOGFyzgqk579/392p0nPVbAxpe6SaMgcCpMVnbHebIqPAASfi3kvN5PH7W+a88u3pnEsmZc0kVKTjYKRZdI8aaHpDTHRgjfKptYNC16Kn0JNRvwRwK6sX6iIeWO10rz9HPKz4JS2hWFy0NZzmPjiDMp7TSwnjhPAjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774347266; c=relaxed/simple;
	bh=3dNaxcQf/QINHlqErzj8xbGPvxI5UF9cpwV1pUI6HnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=et7RT/60hzYBTMs8D9f3dbB1Q74UqJtjS4z1lRs9hXhU3hvDd80X6+nOxA9PKTyJpO7+KGORP248tOw+uUIKSD2xphZRNAjQiOCYl2zsxFvAlodWlQXE3cN9LZbCC+uQHPfHrm6DPDWe19YKpTXG296hdgo8gKlHXwOMdu5i+7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GBdDrWu1; arc=fail smtp.client-ip=52.101.61.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GBdDrWu1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RRlMvD5g2iE1SXBl6E5qldScPXUw0mn90gLXAIKfNwXfxys2nhLKgSxWZsPn2vOdJTAJcBl/PFOtOk7x/SAX6tCS5qYQ74WiwS/VCsjpASXevZPsQ2QZ93hTiKL4/nfh+8hSQ5bdrl8wHcAyPVKeu5isMjRl1YqLXZY4/h6Ep9S4wdM0ZGX6RWfP8wcyW2LrAOOgR35zMScJ33S1NYR9kIPEhE9QtPnG6vu5U2dXl+NZPvN/gScp0c8rzVzLAW8IWhAijz5JvsQxorJ2Yq1o443/X8pFDiUQ+pAavvVJ+tFzi7soQHCazwz3zZCYRIsujd3TxNYKG8ijomx0cWcZPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xdErQsdc4hBRlmBXO3EGMJTk6PtuXRXaJvouXCrkIDk=;
 b=h+0uJPNOi3UX8cRXj3paaKBPkjIoilGguQJIrDfr/BOVFzzVdSCRFtuq4X1JqtXx0PJCrDF0m0by8SOBMXCGBp6ZPBcrEEvtW2fUYBtk1wfq9YJ4poDrSG4XoBBjZT1zkoTSoN7tDvT0M4HG+7OLAA4wK2Kth+VWJNp/b6O1LuTTfI0iPrL2rha2+Zopk6DwZ5tpsDM5DZ6jGDodcvcup53+cb2LWDU2Ee9Me9knZnOXe0JjoRPRrURCmZYDYMvJQrPaN9RUmubLUf8/9j5xWMHp+At99rwBVxwZtz4MREs8rNUM/6PHUKKYxlHsdTkOL5lqSbY0QkFM/8EfF6dexw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xdErQsdc4hBRlmBXO3EGMJTk6PtuXRXaJvouXCrkIDk=;
 b=GBdDrWu1qjKKDR4UgqaKeONxHLpGUs2RClelxCc9SGHWN1sB9eN23X32qAbNcuVYIe0G2JB1MC0xBUwwLNP8OXMgA4zRu6MChl3Pkgmj/AdP0qKz58LreS1aGf/QmO5LXj5rEUg9VWc4HD/fW4gNAwZBgzlJoPh+k9VYiPoMRYSsPDVg7+f/qeYNFBCNRS0z5ki+uGmdBCa6Cb1DD+VuI6IxX7QHR1XJ3dY8Uo8hJdPuyP6kmbztXZwkBdyPdMF7W3VyY2BB8PQi7R5k57AFO9eGYLNt3o0ljbyqQgkheScXWYZi7uPmCovPMDVwM/isp0vXR3/md9zyUJQyKPGO3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB7914.namprd12.prod.outlook.com (2603:10b6:510:27d::13)
 by IA1PR12MB8223.namprd12.prod.outlook.com (2603:10b6:208:3f3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 10:14:21 +0000
Received: from PH7PR12MB7914.namprd12.prod.outlook.com
 ([fe80::d390:582:5536:40ad]) by PH7PR12MB7914.namprd12.prod.outlook.com
 ([fe80::d390:582:5536:40ad%5]) with mapi id 15.20.9723.013; Tue, 24 Mar 2026
 10:14:17 +0000
Date: Tue, 24 Mar 2026 18:14:09 +0800
From: Kai-Heng Feng <kaihengf@nvidia.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: rafael@kernel.org, Tony Luck <tony.luck@intel.com>, 
	Borislav Petkov <bp@alien8.de>, Hanjun Guo <guohanjun@huawei.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Shuai Xue <xueshuai@linux.alibaba.com>, 
	Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Breno Leitao <leitao@debian.org>, 
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>, Jason Tian <jason@os.amperecomputing.com>, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [PATCH v2 1/3] acpi/apei: Add
 devm_ghes_register_vendor_record_notifier()
Message-ID: <acJctweJv0kdABgV@M5403NF6WD>
References: <20260319111315.87624-1-kaihengf@nvidia.com>
 <20260320095513.00007636@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320095513.00007636@huawei.com>
X-ClientProxiedBy: SG2P153CA0029.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::16)
 To PH7PR12MB7914.namprd12.prod.outlook.com (2603:10b6:510:27d::13)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7914:EE_|IA1PR12MB8223:EE_
X-MS-Office365-Filtering-Correlation-Id: c25a2488-52e0-4584-1b7d-08de898e1ba1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|22082099003|56012099003|7053199007|18002099003;
X-Microsoft-Antispam-Message-Info:
	xqyhH7YamsBHdQ1cKEMg1F/478jxhIafNG98ole5nTgrwmLa5TZRAoJL5SuZSWKoKSedFjBZI0uFoPuXibajg1ZXR5ykCCNZx/cOtLGeH9HRwsM9zdfINt6T+rHJGaCAWZLK5fAw4TplYSSCzQyLvOCxRfUtgSW95XXpzJYRIOVSttSH3t+Pgjc1RmW35i3NOJt0RE6l3wPQhEmRHXMT1hbV7/YqDBIivhBOSPxCKXw/o54H87AEZQv2EV3eyR7JdYAAPuBjqDn0DL+8uCKv5ezNohGYiAd7zRenhf0aT9TkwIfrk/LeGSOykjIfx/s7KL62UbNKU8Y3aVBT5q2n0KHtTrbf3b3ribMbBk9gXCR70hTgzrf5DQCzlzURnc2P1OwlkRdbFEHALPivaV7/RVCbY58kfQXCJ1uC6xNzks8gP8h2duKAEXdJRDqDu/swS3+H+A2qPXyYHo4R7vbbbQXrgDMk+YpwlULXYopFoon4N0V7A21NSETiesqY3NNM95+nONf7n+IfVSA4AxGbhH0bGCptqK/VMLF52NcqPmz/C7K1jza7BqTU8JscBaza8b6jiWAOHLW1hG2UGGgos9yhcZhGUpzuplT07g5/FSPCUEIDex50u+CtzJX1vMCgxYP2CzVl+eawIY15BfBh9bwRKANWx2FdhlNTmVmg++h4c+lwlBps3JFo+uApXve+AiXSVGXZfFOTBSUqvV9f/s4fi3gXpFV8Lp6LGhM2pdk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB7914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(22082099003)(56012099003)(7053199007)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Oj67fQWpyZuQq8FvlgQVnuY7dljD1WVSm9wSApdV0fk3WMGdd5dfImvB00Ez?=
 =?us-ascii?Q?T6bCVZlgWDZJixigUqNLUsSGgapd5lB765/YFLLLgPAg7ZMhlLpip7On/b0k?=
 =?us-ascii?Q?G8wbhe3OymZlrcSn4eFQCwgCVIObtzkkNtJqQ4lHtW182b615Mhc5uQYfSm3?=
 =?us-ascii?Q?PENql4NwAwb6yJiZNL0j+7EgxPlnfNnyoeTeEbX1jtMqYetR9dm+F5x8YP8O?=
 =?us-ascii?Q?RLdPuagggko1ljQavCEK+zE0+hUcJfxI77uIyyzSSs1BfoYkAJlxgh6IHUgK?=
 =?us-ascii?Q?Mu6vuW9gqJg83C6gp5/XCQbamA45VsJT19fzLqVD+/YSL+GzN7h1BDb/psbl?=
 =?us-ascii?Q?DR9qhCgEsNKqbMJGsoSBZtPRELBYjDLbn35KxUX3imgCd7lZ026gZCPe4LDV?=
 =?us-ascii?Q?k/+OoreoV4A54r+eBhUAX69Ug8IBSLVxRYkkTb+3yT6F0Ic+ySol3UZJYj6p?=
 =?us-ascii?Q?4IvIL+bHPkQ8DFYoyHIQrpVJ8nneLnfRMba/XJPRzobM0hZZBrFBKjuFX0xx?=
 =?us-ascii?Q?GsNOPkZl8fh94Qp9Ss6YYPXQ8D3QVHDd6Fwpe7RW2Bdj7siUFPiIo1kgmCtx?=
 =?us-ascii?Q?kK+2air5okIiC66BThyZT6KBjPz/NuPhtOqXj5Y6bBu4k7hf08ofjxkqAFVu?=
 =?us-ascii?Q?2MHcQoJNUbzVZ3Ix1Xwhf5TUCDmwto/a9Vfe+EGq/lH+edpCB7d2bXCZR0a1?=
 =?us-ascii?Q?W8Cly39U0GvrVJQDCOqAb8cOhgQpYVpuTkE2O95ZZMK7p3JCe9klITPWvdpe?=
 =?us-ascii?Q?nHw/J33+cpVPETXKHBzyv6HnEPIPqVhUCu1gRYOVHZ2/37RsFDjbaZQ4R/45?=
 =?us-ascii?Q?2B5Y5WTfiNmdHlElrSx76jARJ/mdUP52/0T7IRKjASoYIqmqJ5O85Ve8+ZFB?=
 =?us-ascii?Q?4OpqcoMHiWsy/5uCpxyMqcwvsE3J5NiyIg8waryjTs7l3hgtDZUkUuu9Krhy?=
 =?us-ascii?Q?mzyVPtYg9Iv9BRT3wxuQDuvUE1DaXyXQyTC/Y8fhMnrHdv3dMa8ADYe4nnNR?=
 =?us-ascii?Q?l0P2fd1ghKeCgrW99Vyo/BlxzeA8FY4XsggHO/w2HkTqe+De5/FruWHUZZfn?=
 =?us-ascii?Q?EawEcgmNgEvO/licS8SLj3NR9tqtpo4Lx0OPKS2r8rMIVkcsl8iKbnNlVbF2?=
 =?us-ascii?Q?8F/u+JaMuWFiam+xlBbJICmxjYBm/X+Kz+6UY5Ef1Nx48V9scdIjxy4SIzQ+?=
 =?us-ascii?Q?z1YgP885tyG9Yg1/jVma52Tmbe36z3xWRCgVJMj/YF4GRikjF4mOdeH+qVo0?=
 =?us-ascii?Q?RjEV4Ar44Kx7eBQvgoafFhDoBiSFdkuZgYXmVWCkETnxF1W/K8gaspcc00bG?=
 =?us-ascii?Q?lhGNyg3DatR2ebmgP+yTey0UL+xeUk6iS+UOz6K/7WAV2spdl+7r3zwdPrDn?=
 =?us-ascii?Q?2aktsXmUr7IoGVWEoJD1ci5uuSTCr8aqyNcd4czqbWpKhcLtS72aOpU7DwBf?=
 =?us-ascii?Q?eD2oqEnVelcYzinPavLggc5c76SNVU4TE9ID5UFNaYsp3sruDcvAYKoq9GKz?=
 =?us-ascii?Q?vMh9gxWFTXQ62sl6RLvEFyTEqPRMo/zyRBz36POXPz7RzjpCf1GnsfwNGmlC?=
 =?us-ascii?Q?m80302b8zctvLlev/XzP5O2qoJ9fmFN3jhFmlQizGMJdf6VYWPQtSSXeHkQh?=
 =?us-ascii?Q?LS41nw+4onTGZHBB5sUn7Y+Be1Y3aMxiUbfaxNKOcIOBKUYbFj5Si7zEDSE5?=
 =?us-ascii?Q?vufV26miB6TrRqZSBUPJDK3/lgWk/XGV03ZI0sXIl+UvTedFMmd0b93Xp8ua?=
 =?us-ascii?Q?hrojnn06Zg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c25a2488-52e0-4584-1b7d-08de898e1ba1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 10:14:17.8120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PZXPu60or0sWzvr6VXtP8Fb4BQkPiR9xcJ3572muJsJtdc5KVNm5Qdy8OZYNffW9Q3GQfUrL0ul5/FU/y75ttw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8223

On 2026-03-20 09:55, Jonathan Cameron wrote:
> External email: Use caution opening links or attachments
>
>
> On Thu, 19 Mar 2026 19:13:07 +0800
> Kai-Heng Feng <kaihengf@nvidia.com> wrote:
>
> > Add a device-managed wrapper around ghes_register_vendor_record_notifier()
> > so drivers can avoid manual cleanup on device removal or probe failure.
> >
> > Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> > Signed-off-by: Kai-Heng Feng <kaihengf@nvidia.com>
> Hi,
>
> My only comment is about following local style. I think that
> means moving the docs to the header.  Unfortunately whether things
> are in the header or the c file is a subsystem specific thing.
>
> My preference is in the c file, but local style overrides that!
> Better to have all the docs in the same place.

You are right, I didn't notice it.

>
> Jonathan
>
> > ---
> > v2:
> >  - New patch.
> >
> >  drivers/acpi/apei/ghes.c | 25 +++++++++++++++++++++++++
> >  include/acpi/ghes.h      |  3 +++
> >  2 files changed, 28 insertions(+)
> >
> > diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> > index 8acd2742bb27..d31a70a05538 100644
> > --- a/drivers/acpi/apei/ghes.c
> > +++ b/
> > @@ -689,6 +689,31 @@ void ghes_unregister_vendor_record_notifier(struct notifier_block *nb)
> >  }
> >  EXPORT_SYMBOL_GPL(ghes_unregister_vendor_record_notifier);
> >
> > +static void ghes_vendor_record_notifier_destroy(void *nb)
> > +{
> > +     ghes_unregister_vendor_record_notifier(nb);
> > +}
> > +
> > +/**
> > + * devm_ghes_register_vendor_record_notifier - device-managed vendor record notifier registration
>
> There is also quite a bit of kernel doc in header.  So I guess
> local convention is put it there not in the C code?
>
> Hence I would move the docs there.

Sure, will do in next version.

>
>
> > + * @dev: device that owns the notifier lifetime
> > + * @nb: pointer to the notifier_block structure of the vendor record handler
> > + *
> > + * Return: 0 on success, negative errno on failure.
> > + */
> > +int devm_ghes_register_vendor_record_notifier(struct device *ev,
> > +                                           struct notifier_block *nb)
> > +{
> > +     int ret;
> > +
> > +     ret = ghes_register_vendor_record_notifier(nb);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return devm_add_action_or_reset(dev, ghes_vendor_record_notifier_destroy, nb);
> > +}
> > +EXPORT_SYMBOL_GPL(devm_ghes_register_vendor_record_notifier);
> > +
> >  static void ghes_vendor_record_work_func(struct work_struct *work)
> >  {
> >       struct ghes_vendor_record_entry *entry;
> > diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
> > index 7bea522c0657..ca3ace828c1c 100644
> > --- a/include/acpi/ghes.h
> > +++ b/include/acpi/ghes.h
> > @@ -71,6 +71,9 @@ int ghes_register_vendor_record_notifier(struct notifier_block *nb);
> >   */
> >  void ghes_unregister_vendor_record_notifier(struct notifier_block *nb);
> >
> > +int devm_ghes_register_vendor_record_notifier(struct device *dev,
> > +                                           struct notifier_block *nb);
> > +
> >  struct list_head *ghes_get_devices(void);
> >
> >  void ghes_estatus_pool_region_free(unsigned long addr, u32 size);
>
