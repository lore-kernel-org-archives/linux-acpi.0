Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022117.outbound.protection.outlook.com [40.93.195.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45A1277818;
	Fri, 26 Jun 2026 14:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782485765; cv=fail; b=DOulSnt+zvwncGkjeXNg+IFRSNXTRAwvUrBDErB1/k3v4XAoXpfqTZTe11jEI9NsL4C4G1pjNNBLNOEEwDn7d0dMm4HJ3C6Heo6ZWHINiVqTalPj5nvQp256IrY9OgY3OjZ5eh0jIgp4ypVl3rahikVGlyDPKhKtd12H8LEMYuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782485765; c=relaxed/simple;
	bh=bg8Hccm+ZRLrYd+8uta7jKla1RJt6dqoshLnu2EWnTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pOuR1F7j0rFggtdJS9+pYUH8KNhcoZwmaYKj1PTAwEX9xMt/+e2F/6t/7E/C72+YCWqRwLxGWlSPv86AeASEMN753rU5HgBRneuHmrtUnw10AJ2d9QnRv/iaLLIh26nFMCzuMrfGKOkTrM8c+cPKJxydaMka5Y4c3aT09SUv06E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=AToGbOYp; arc=fail smtp.client-ip=40.93.195.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="AToGbOYp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XWYWC/UbgOAXMSjhqitN93xOn/iiKJskWkmirZsn9JAjP7wkYBM1If+LaAGmenUV1TiPWTuG55vII0MC/PR+Beo1kXCEKj3HXnk2r0aDcw3fjWnyvUL07KgHdIxleSoBYHUjDTnqW5lE990MamUkt4KW7HDHHaGJ187PaB6ERCiDWWmvqmR0/O6oxHiiCBpM0XT6DqhTJuMAL8nR2xO5AVGXJhVYjWvOHNjYuNwAAbZW2fFxkhDyBA6D2Ol8Zk2U/9aCt/kDhWfXhqBpYfhHTdubdXTFkMFAbmn1aHWuEInTA0Sxt+lL7S0srG9ZqvDriY+CfUdOOIGgGJvoqMAtqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LFj++dbUrbuREZl+EFL12rN4Sm6AKHkjjpuOAJITl9w=;
 b=W6yvPeV2upp0sz3Nh+QsLrbjprmMfhvgnHdhOS1SYCY290fDPSGnqNURZgfLlyCBe2522TbWqM/03LYFQ20fB6CMu1hI1Gqp5XpegWBOjADe6zSwNckmbc733wsRwIutOrWhlDuqfe5KRC982ufYhYp7sKaM0001KZ2CaKTyvMn5ze9vhimK+3LTZ0piIeTZZ/Lm2exfdPJhh55eAHON5Ew/63zWy50rgqmisVLTA68n5kpjuJLpgEok7QEvfKKomptMKnGj6PHmLqjThe+dgPei96xdxiCompJxG3Iw/DUpdfUik1LYYC4FMt3rh0Y2APk8vCDWdoGJ4kwHq7E3lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LFj++dbUrbuREZl+EFL12rN4Sm6AKHkjjpuOAJITl9w=;
 b=AToGbOYpmUZNnMXSm4Pnv0c0DGpzz6wyJ5IifP0mSRj0SZPNq12NwAoqjNciLWH2biSotkZrFTtK9KJvPy3Iod5c49AB4fqlh9WXpIomUaISWEIS2Jl3fuCq5DnMpSVau9ntU+dmLscALM0+3Q56G3tEPmd4biBpL+XZc3SJk80=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DS0PR01MB994109.prod.exchangelabs.com (2603:10b6:8:2f1::9) by
 LVTPR01MB994727.prod.exchangelabs.com (2603:10b6:408:3c7::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.12; Fri, 26 Jun 2026 14:55:59 +0000
Received: from DS0PR01MB994109.prod.exchangelabs.com
 ([fe80::9262:65a4:c559:e413]) by DS0PR01MB994109.prod.exchangelabs.com
 ([fe80::9262:65a4:c559:e413%4]) with mapi id 15.21.0159.007; Fri, 26 Jun 2026
 14:55:59 +0000
Date: Fri, 26 Jun 2026 07:55:56 -0700
From: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
To: Pengjie Zhang <zhangpengjie2@huawei.com>
Cc: Will Deacon <will@kernel.org>, catalin.marinas@arm.com, 
	rafael@kernel.org, lenb@kernel.org, robert.moore@intel.com, beata.michalska@arm.com, 
	zhenglifeng1@huawei.com, zhanjie9@hisilicon.com, sumitg@nvidia.com, 
	cuiyunhui@bytedance.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
	linuxarm@huawei.com, jonathan.cameron@huawei.com, prime.zeng@hisilicon.com, 
	wanghuiqiang@huawei.com, xuwei5@huawei.com, lihuisong@huawei.com, yubowen8@huawei.com, 
	wangzhi12@huawei.com, ionela.voinescu@arm.com, jeremy.linton@arm.com
Subject: Re: [PATCH 0/2] CPPC: reduce FFH feedback-counter sampling skew on
 arm64
Message-ID: <20260625-singing-fair-guillemot-9eb79e-vanshikonda@os.amperecomputing.com>
References: <20260410094145.4132082-1-zhangpengjie2@huawei.com>
 <aa1284c1-ea26-48ca-a7d7-022027c8228a@huawei.com>
 <agw_1IYaY4zeobZE@willie-the-truck>
 <443104e2-ba6e-454e-8469-909f35817a99@huawei.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <443104e2-ba6e-454e-8469-909f35817a99@huawei.com>
X-ClientProxiedBy: MW4PR03CA0055.namprd03.prod.outlook.com
 (2603:10b6:303:8e::30) To DS0PR01MB994109.prod.exchangelabs.com
 (2603:10b6:8:2f1::9)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR01MB994109:EE_|LVTPR01MB994727:EE_
X-MS-Office365-Filtering-Correlation-Id: b607e2d5-0c53-40fc-47e2-08ded3930883
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|23010399003|1800799024|18002099003|22082099003|55112099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	JxhJ0jCOFHCGar0/JWOXWVy5zRDUrrYRMFbZeQu/dWIbi+soJMJhhyNirE1v7G7QIvMzVEBPFwvp1FEVWjN5MdoXOF0aVaGCVGIgslYNp3VuMODKR9M1l6B8xwb1CMw3U9NZyKsK5b6i2/IwAqPMM/IqxlU0fnY8HCKthqkAnN9ojxCTAsL5mZdedBYkjbUO/mf95ry4aqhQVZiN+nfSVYp3NpaN3GmDoKTQXNWqBikbKzFF7QBigyfHxjb4c4Yru+qMR7VDN0uLqHr2P7MH2/rUcxECuY7SADmSteObDoyeAo4mwxp+9+PUykklMB0+o/El0QxiDusTzjTk/RH+/p8RlBr4qu1Rd9qMR8Pe6mcRHdH00Z9TImVaiGdjiNvz0xkEWx99I9SF7DDPZyo7NunFpvwitJuJTn6gAhVf7mABnGUlGuNgv8dNk+GyYbrtjE6T+NJFjikYrwZQ97IzqaHTOiQsyaXq4+s9XbVu+yq66B1na70QGeQGEr3Mmqx1Inon511FzjAhuDTnCy40nkgjOKFY85yTRWjlG9aR7SoREB1xtGlgsofZOb+gzCaoH04AqGBq4LxXoTaUSdzFIcYyKZq3KLYnOqcIF1N5t/LPrSOARrT0Shvvukv5g9qczQs2HUtAVSXdJFWbnYo8DJfPykRH9G2mHz6fNiP0rVg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR01MB994109.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(55112099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sKgeLUrXH/4F7f6dy16SwJih889JJYyYo/HPWxd03izH32+xo2VT9x42bUO0?=
 =?us-ascii?Q?iXW392smiRLfDqhHK3QFin71Yp7Iu5z9ic+aijfoMnITYVZ/xe6u4SOvSpl6?=
 =?us-ascii?Q?UtYiq+ZhB5lNZGXC7CUWV69jz7XQtVwek2FzUNOXVEyRivxkEFmXTuxJ9cM3?=
 =?us-ascii?Q?I/ICscDxNYm3F0/H98Qmih5avF2iIcG16Jq7bcq651mI4I/VnIDvfvzu4Yt0?=
 =?us-ascii?Q?q/XOGLn12WjCMiNgcl3K4NDljFdFYJIdf6LCTpSSahTt1ifNrs23jYCWm82x?=
 =?us-ascii?Q?ykrALR7wEr3dcSREXVS7kGkUSPSevJBWQoTzFFT9LWWYal8PqEkA+3lhBhUJ?=
 =?us-ascii?Q?MucuAiyXrrIEU0rV2KPgifJN5IBuAq+DyRoFY7yGoTaM54DW2z+qYWvHso1z?=
 =?us-ascii?Q?2cuUtc1oIKwtIKa1RGNOFnpuD0ZE10pYpn7NcuClNa7B4joYGQ7czMleWc+a?=
 =?us-ascii?Q?YqYscsq2MFpUGYHmDhnW3H6EN60e8Rg4UnZTVNQRDOMjvACwTMLXynwthUzk?=
 =?us-ascii?Q?69ViTWfHEej6SGODjTb+JP71owW6ZlMQT0UcotGkhwzJKU4MSzVn0klEVZop?=
 =?us-ascii?Q?ECWxjGD8HsFIvbhhR2NiIFQyeleSpDXlBBq6qkF0eMvZAz46Mmhbp7v07vp7?=
 =?us-ascii?Q?ZxzN50vwU5X7k8vX8cMyTdHEx9Q7iuvWMiUPyZp8tiJaecK2xDoLtuCMCCMO?=
 =?us-ascii?Q?NsLBVlpOUjJkMlH1yeAgZ5xNHWptWLIQned5BelE1yg+zi34rl5hZnJP37ls?=
 =?us-ascii?Q?DgaAqwvnX6yH3WAmmvvME0in3Wqyfn8wLFm/I2fpdI9uG7EZD0UmCYQrlEP7?=
 =?us-ascii?Q?0EZejb9qH1HmszTUUT08snIFFBKi2lFo9GU6UJBCyOCX8z3EIYFo7s4RFvKI?=
 =?us-ascii?Q?Izq4sjnZQjgywdrQ6tYOEWf1kS8Ff5cX0tMvKll5GxRdMCOIxcJruWSZ0cMF?=
 =?us-ascii?Q?cM0iLgGr5EsJbdWfy0vKpcA5xgRkU8k5ZohyJobzPqjPrsu3LGwvbjL4FYH3?=
 =?us-ascii?Q?Xut/t9OvNqSjyI3MiiYdoRVDBvzruq4BT7PPX8HBYO79nN4n+A5wg3PXg/rB?=
 =?us-ascii?Q?TKFvgrT7lDmCzHu0hGs3SEiP3ghk2swaf0f2axTnfOpBm3/gquutL7q/l2Fa?=
 =?us-ascii?Q?AVR//yyIC3+cWYc+q86MfiomDsfQn0uwbh8x3nVpc375TSX6YCu/BIzM5cZe?=
 =?us-ascii?Q?ptzTCC3aqCuHxvQQI59KrSbJt6jYV/BjKNH9UIWkpb6Tpwh8waj12IIOGNTR?=
 =?us-ascii?Q?K8nM5JPNf0P1HoIvWDGbM1mvaxgTZL+b2+sa0t7PoTIjkHA8gZz2g3WXTtyt?=
 =?us-ascii?Q?bt73wWtqp3AUJUkOvhhY8bXeH46NY33F+KJd9/jFCqDytZYIqXJajegG19SK?=
 =?us-ascii?Q?jYV0A5ien5b47KHwB3FxLQNQf3WDo7pVIq1heO38QcrtrfBqdNu3s1J/6FF/?=
 =?us-ascii?Q?IHLkCgOpAn0J/TbZJzLHLxGu4sEcYsOw29VALW3VFICODQBTlNPMprHXUrWv?=
 =?us-ascii?Q?XrZsgapF/NyQ9H0T8bwPBvP34zRxwwAboPl2YgZmGPSFPRPUfvBBPhS8bmlq?=
 =?us-ascii?Q?hJdUg+p5oj07s4vbE0ywAsLkEjeUBuINc9W+fzUUBzUttav/46msAubNzNXa?=
 =?us-ascii?Q?gaREpqK12uNjPlpaPKb8FYGtlAp8de4GxT+F5MHZIPbzNylkAc00wm0Nl9sx?=
 =?us-ascii?Q?7uSQsc86DmclhCaQ6M31LRs8bl1Tr2R9d5hwGPjhHFUri8QKenp1vwpr/4Rr?=
 =?us-ascii?Q?Dz/7oaTj0JMWvum7l9aP5c3arx1OMbEj7IqJUVPfLVReteryj0Gg?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b607e2d5-0c53-40fc-47e2-08ded3930883
X-MS-Exchange-CrossTenant-AuthSource: DS0PR01MB994109.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 14:55:59.3925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WLeWepALOaNf8kh/DT+6usD7C1axvaRMxbA0H4tm/0y0xnHU/sJMYOAFsML6xtM7cNc6doDPmyxQMykn/SYQPBNOV28lZtjKpDl/IdWgxAwxlAcLTVXC/N+W6lA+8lJw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVTPR01MB994727

On Wed, May 20, 2026 at 10:55:54AM +0800, Pengjie Zhang wrote:
>
>On 5/19/2026 6:47 PM, Will Deacon wrote:
>>On Thu, Apr 30, 2026 at 06:00:44PM +0800, zhangpengjie (A) wrote:
>>>Hi all,
>>>
>>>Gentle ping on this thread. It has been a while since I posted it.
>>>
>>>Could someone please take a look when you have time? If there is anything
>>>I should revise or any additional information needed, I'd be happy to
>>>update it.
>>It's hard to find active folks who have contributed meaningfully to the
>>cppc_acpi driver... I've added Ionella and Jeremy, in case they can take
>>a look.
>>
>>Will
>Thanks Will, and thanks for adding Ionela and Jeremy.
>
>While waiting for further comments, I would like to add some
>test data to make the effect of this series clearer.
>
>On the test platform, the maximum frequency reported by the platform
>is 2300000. I sampled cpuinfo_cur_freq before and after applying this 
>series.
>
>Before applying the series, the samples showed visible transient outliers.
>??The minimum value was 2154583 and the maximum value was 2491071.
>There were 8 samples above 2400000 and 8 samples below 2200000.
>The largest value exceeded the platform maximum by about 8.3%.
>
>After applying the series, the samples became much more stable.
>The minimum value was 2290243 and the maximum value was 2306310.
>There were no samples above 2400000 and no samples below 2200000.
>The largest value exceeded the platform maximum by only about 0.27%.
>
>A summary of the 96 samples is:
>
>?? ?? ?? ?? ?? ?? ?? ?? ?? ?? before?? ?? ?? ?? ?? after
>min?? ?? ?? ?? ?? ?? ?? 2154583?? ?? ?? ?? ??2290243
>max?? ?? ?? ?? ?? ?? ?? 2491071?? ?? ?? ?? ??2306310
>range?? ?? ?? ?? ?? ?? ??336488?? ?? ?? ?? ?? ??16067
>average?? ?? ?? ?? ?? 2298436.4?? ?? ?? ??2298479.4
>stddev?? ?? ?? ?? ?? ?? ??55184.1?? ?? ?? ?? ?? 2868.2
>samples > 2300000?? 26 / 96?? ?? ?? ?? ??16 / 96
>samples > 2400000?? ??8 / 96?? ?? ?? ?? ?? 0 / 96
>samples < 2200000?? ??8 / 96?? ?? ?? ?? ?? 0 / 96
>
>So this series does not try to clamp the value to the platform maximum.
>??Instead, it reduces the sampling skew between the delivered and reference
>feedback counters. The remaining small deviation around 2300000 is
>??much smaller than the previous transient spikes.
>
>One concern that may come up is that an FFH read may cause an idle
>target CPU to be woken, depending on the platform/vendor implementation.
>However, that behavior is not introduced by this series. It is already part
>of how FFH counter reads are implemented on such platforms. This series
>only changes the sampling form for the FFH feedback counters: when both
>delivered and reference counters are FFH counters, read them together
>instead of issuing two separate FFH reads.
>
>If the target CPU has to be involved for an FFH read, doing one paired
>read should be no worse than doing two separate reads, and it also
>narrows the sampling window between the two counters.
>

I agree with this point. It reduces the number of times the idle CPU
is woken up just to read counters.

>If there is any concern about the generic hook or the arm64 implementation,
>I would be happy to revise it.
>
>The raw data is as follows:
>before:
>2303809 2294827 2300000 2293643 2290740 2300000 2297228 2296082
>2301707 2295354 2296601 2303163 2296766 2296543 2295412 2298394
>2297387 2300000 2308274 2301882 2297752 2418568 2491071 2300000
>2183264 2296238 2434731 2296721 2439777 2302159 2301773 2298226
>2300000 2305936 2301133 2297511 2300000 2300000 2294408 2298494
>2295011 2302721 2295955 2301505 2298064 2297419 2298933 2189595
>2298058 2296046 2300000 2301449 2414908 2296559 2305251 2166666
>2296626 2173303 2300000 2298806 2411389 2301822 2297291 2300000
>2423831 2297902 2300000 2435730 2302433 2295353 2298898 2296043
>2321868 2294907 2300000 2157841 2296052 2206530 2300000 2297811
>2297920 2294382 2297767 2157230 2302564 2298504 2296822 2300000
>2296868 2294866 2154583 2290888 2302542 2292549 2300000 2184259
>
>after:
>2303738 2296153 2298087 2295607 2301373 2298076 2300000 2295081
>2297788 2300000 2300000 2295238 2301449 2300000 2298488 2297911
>2301477 2298507 2294976 2296852 2293689 2294077 2293887 2292619
>2300000 2300000 2298072 2300000 2291943 2300000 2295370 2300000
>2301873 2304645 2300000 2296766 2300000 2300000 2290243 2297954
>2297183 2306310 2300000 2296889 2300000 2303800 2301970 2296888
>2300000 2301354 2300000 2298405 2298202 2296767 2298663 2302522
>2297821 2302471 2300000 2303233 2298226 2298698 2300000 2297291
>2296470 2300000 2298398 2300000 2295681 2300000 2300000 2296344
>2300000 2296008 2302375 2297977 2298447 2296519 2295565 2294866
>2297945 2300000 2294978 2303595 2300000 2300000 2294930 2301096
>2296271 2296086 2294482 2300000 2294843 2300000 2296803 2295708

I tested this series on Ampere AmpereOne A192-32X.

Tested-by: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
Reviewed-by: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>

Regards,
Vanshidhar Konda

>>>On 4/10/2026 5:41 PM, Pengjie Zhang wrote:
>>>>The legacy CPPC feedback-counter path reads the delivered and reference
>>>>performance counters separately.
>>>>
>>>>On arm64 systems using AMU-backed CPPC FFH counters, each FFH read is
>>>>served through a cross-CPU counter read helper. Reading the counters
>>>>separately therefore widens the sampling window between them and can
>>>>skew the delivered/reference ratio used by cpuinfo_cur_freq. Under heavy
>>>>load, the skew is observable as transient values that may exceed the
>>>>platform maximum, as discussed in [1] and [2].
>>>>
>>>>This series adds a small generic hook for architectures that can obtain
>>>>both FFH feedback counters in one operation, while preserving the
>>>>existing per-register read path as the fallback.
>>>>
>>>>Patch 1 adds the generic CPPC hook and uses it from cppc_get_perf_ctrs().
>>>>Patch 2 implements the hook on arm64 by sampling both AMU counters in a
>>>>single operation on the target CPU.
>>>>
>>>>[1] https://lore.kernel.org/all/20231025093847.3740104-4-zengheng4@huawei.com/
>>>>[2] https://lore.kernel.org/all/20231212072617.14756-1-lihuisong@huawei.com/
>>>>
>>>>Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>
>>>>
>>>>Pengjie Zhang (2):
>>>>    ACPI: CPPC: add paired FFH feedback-counter read hook
>>>>    arm64: topology: read CPPC FFH feedback counters in one operation
>>>>
>>>>   arch/arm64/kernel/topology.c | 75 ++++++++++++++++++++++++++++++++----
>>>>   drivers/acpi/cppc_acpi.c     | 58 +++++++++++++++++++++++++---
>>>>   include/acpi/cppc_acpi.h     |  7 ++++
>>>>   3 files changed, 127 insertions(+), 13 deletions(-)
>>>>
