Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazolkn19012073.outbound.protection.outlook.com [52.103.11.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047224968E2;
	Thu, 23 Jul 2026 12:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.11.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784810263; cv=fail; b=jVTMbFsEU7zy5PkTHlhqcqefpqIR72uxXhA/+ikX+uq4fgiydci+Jt7B26Vbaqc5xOi7EQVlNJMD8hfY4A/RgdgWKoVqPL/2wbUw342YLz/I5AX6ufrTBLKVc+JPw84306j/GwSDOSWyfb3mZJAqGnowZ4gvd9ncajLocyH86pU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784810263; c=relaxed/simple;
	bh=Br179hQBCC+sa8q/nsDtPen6q5tkK8Txe3gvJceOT38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IXN2egVc0a83ruY3XkkNp2q9tCKYOHTNTKwJ7OefH32smFPoPedJxzLPTLkVBRwkvgA+vs1Uw9b9tmFrtwg3j8FBO2Y4zNhg12S4XWK4LwuwVq3bqW9gT9rxj6cB3MyopobQWHLkrom38IIUkq3nkN/Ril4HUArWFVQ1/xJ4n/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.it; spf=pass smtp.mailfrom=outlook.it; dkim=pass (2048-bit key) header.d=OUTLOOK.IT header.i=@OUTLOOK.IT header.b=f1iu+d2F; arc=fail smtp.client-ip=52.103.11.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=OUTLOOK.IT header.i=@OUTLOOK.IT header.b="f1iu+d2F"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KHQQ4M9tvGDeY6S4sKNJmYhqt9i3iQJAAwtiZb3MZHUks7KYBNgkZPtp3nzqctGHUFy2jpB6n7RPEaED7rr0qfYT7Sh1KYx5FWX5mLu2GPEwKf2B1wv6gYbt2HW5FQLzwxZNNdhqzZtD3tiOVQc1Rw5iNyySVUK9Nhg3W5FkkkXVKPC9K5gvyPFVUmULPjCIleCVWh04f62wUggr3FpT3VYCgwKneIDaP7etD0PJ9e/uOZRDZTUUZarn4Kg/AFepSacgfF323jvzeZOmCSdk+ZK0mDAkSSz4H/wTdMqzWRbl+kvR6TEbj+sOpH81AIjZTNlfCRu5P5a7gPOo2AkoUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Br179hQBCC+sa8q/nsDtPen6q5tkK8Txe3gvJceOT38=;
 b=PeTQbp6bUFAwAh0qrFoocsRX3ePcxav9OJ12IP5INffCDB4Os97ylLzBm3U5Q5RTMPTGzpTtQ8FN8xUmfkVdeb7vAbgLEBP7xLPH7WvUK6qvAb7cJIDxE9ReMXhwjzTOU6sa9o3OP4KxM7rS54oHWVmdt68baij/CpbvzDkx1yElepBn+D1zbhayc23Al7wgBRMxspeCnWSofMp5h0nYZxRWcGEHN2lnE9Ca/qszyX0i8BIwKTI2EW0Gda8fULKsl3+ZX+1wUUCCLbmjtJwJFxXmCZ9JtArx7kSer7YhCkZ9pezoOzlmPXLw1rK2pdvQwTVXuJGfK+PXAtPfP4L2gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.IT;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Br179hQBCC+sa8q/nsDtPen6q5tkK8Txe3gvJceOT38=;
 b=f1iu+d2FoH1w/JimA2NIk6nJBZD3eHx0LgYzoeprACyoeTjkXyXnyMyC0LALrqlKXq9jIW/DJRtlmGC+iVfq7HpIXAOx0CQNEqdDCcAeCdjubdyRPkegtmo1gXArX18gRa+QuiWUpCHhW8T6IzzsbrAL6X1rihBOFtOUh2eCozR70/9PHMCUCZtPcoH0Tj/WQkOBIMqMZVOKFrHElOxMkaCAX7dnSU2lvvbHFJbFenAZj3I3/4bi0U7rvRPeoqvn9rag+UnUYrlwWg/lrbdbPnczgPK6pvtQNCM2EDUH8m5JxUgHzCu9OlgRflHHWF/gnAIsVTgDFTKpLcY8bQ+F1g==
Received: from IA1PR19MB7712.namprd19.prod.outlook.com (2603:10b6:208:3db::7)
 by EAYPR19MB991545.namprd19.prod.outlook.com (2603:10b6:303:2db::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 12:37:23 +0000
Received: from IA1PR19MB7712.namprd19.prod.outlook.com
 ([fe80::3e3c:51e1:5e00:be4b]) by IA1PR19MB7712.namprd19.prod.outlook.com
 ([fe80::3e3c:51e1:5e00:be4b%5]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 12:37:23 +0000
From: Marco Giunta <marco_giunta@outlook.it>
To: tiwai@suse.de
Cc: broonie@kernel.org,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	imitoy@imitoy.top,
	lenb@kernel.org,
	lgirdwood@gmail.com,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	marco_giunta@outlook.it,
	munzirtaha@gmail.com,
	nadim@symbolic.software,
	perex@perex.cz,
	platform-driver-x86@vger.kernel.org,
	rafael@kernel.org,
	tiwai@suse.com,
	wangweidong.a@awinic.com,
	yakov.till@gmail.com
Subject: Re: [PATCH 0/8] ALSA: hda: Add AW88399 HDA side codec driver for Lenovo Legion
Date: Thu, 23 Jul 2026 14:37:09 +0200
Message-ID:
 <DS7PR19MB7724E1F838E331DDE7A99E5CFCC02@DS7PR19MB7724.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <87h5lsinn2.wl-tiwai@suse.de>
References: <87h5lsinn2.wl-tiwai@suse.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR3P191CA0047.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:102:55::22) To DS7PR19MB7724.namprd19.prod.outlook.com
 (2603:10b6:8:d9::20)
X-Microsoft-Original-Message-ID:
 <20260723123709.9627-1-marco_giunta@outlook.it>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR19MB7712:EE_|EAYPR19MB991545:EE_
X-MS-Office365-Filtering-Correlation-Id: 77b1f534-f6ef-49cf-fd17-08dee8b72330
X-MS-Exchange-SLBlob-MailProps:
	30ekHghIwFoGqEgxaY/OAvK55SjXyV7lF7RCmZPL9CcWTDlbfy/loETB2/yzLsqJofIDIDSgCxFFdWycOyl0vKs0w/JNvbArKcLzZKtpH013Mkv2dmNje0pLAPv6WqhSNXQWxQ7QjrFu5OW5bQDhPwDIQ5nhZAANbuZPx6CKmxYex20kfvbH+NMpgBDiyRqYaWNGtyE/tUuV4DyX5nftpQ9QDOkokF3y9AL4FoZemgqvVpvCft2ohHBKqTYawHqJHVMEUqSP9g/qFVUt6EOKhzSsvjFzTrrooMOM6SdiRwyYI/lm1rh1pAZ32DyqK2W0HVpe/kk4C/KeZe91AOUjYc3BMOb2jYgKYSwmz6sFpUyxwB3zLP8jL2y8P/SFgZUQiJNVu0zyq18GovYcb4ubZnztbdxj7tadH7icvsaIO86SrQgpBxQo5F7+dgMoFXCL/hiC5+dzv+EVNhFjvCcMuxhhuJASNlZNJ5ql4qBjX6TaGzST43AsJxyMn50A8olZrsoVkLkzfZTTYGAaTcO607KqthDt2nWhhuqPXWVOYteCzeRm7e+5P9TqrKUJ+9X9CTP3dJV7iN3YO9BNcQagmstYl7EF0I8LmTjQl7QI2H5CBl0P6BRUqmTF5A+F990nddGWkhJ0NJLD+ByO/GSLcD6j5Nr87PTv40tW5FPsGk2hGTfXHwAlEujZUFMvryh1xDHw2ukEkUMVGVgndIHjbvWBv57RfCyresmMA1gin8zI//WSoK4+NgRnN0qRRUkT
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24021099003|55001999006|23021999003|15080799012|5072599009|25010399006|4140399003|51005399006|8060799015|19110799012|3412199025|440099028|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QYyaUgg6PyfA84BeG3HxO/TFhCR4YblXPtehj1LFqVhsmNR5y91EtGcWNDes?=
 =?us-ascii?Q?Cnfuku1f/4JXsw6xAGQoi7RugvUTQU/5X3r/60mG6Ge1CbZ4x+EZ+Lbf1hBQ?=
 =?us-ascii?Q?sMHja+2w1ytuYB+9Etf+lCzJqygPSSZ3NEw1FO2jfao6k4B3MP0R8sWEg/sA?=
 =?us-ascii?Q?LkBqp77MCcSvE5TolgRPxzi+7LYH7V8J2rQMBnu2aINy3j0C9mhjKRHPAjlO?=
 =?us-ascii?Q?i0KqMDp3rx2Ge3f9v9vRysczojwL0x3hbczOMb5up96i+SCR/t7agVX0tqgO?=
 =?us-ascii?Q?NJdKpyoLr3dUT5rcO5U88fU7o3QcEfYLTnGsA51nqFlu6R/8UxSBuOT3ncGm?=
 =?us-ascii?Q?wp5ZA//J+DEt9JiEHwXjZNDmSRZtPjTOreXlVe6WA8LUUGvu+FVjDaHmM5s6?=
 =?us-ascii?Q?lpN4f9iqbkvKouwCqFvsWl0y3nbifYZ+MZ+HIOCgOXfHqI+SlrPAtX/93uKt?=
 =?us-ascii?Q?CCWx2mjoNQi/VnQqKLLpGIkS41ITdrHrBDxxID+QekZKD8+Rlrz0guJCqTV7?=
 =?us-ascii?Q?r4PzNg2uFj3UIAqaBUNaSZLXwjLFHX1heeBTJEP63dPPzJVfsj+8mjKPYfjV?=
 =?us-ascii?Q?0NmhWFAlJKfkbdrfkyMvTcg07fb6uqL3V4E72Jt7+KoSt2WMVpaBkVUC95LW?=
 =?us-ascii?Q?wvzsj34S40Z1etWExawp+1U29c4RE3UKN40SJbFVTL7mmUuKWB5yYhjs2vz8?=
 =?us-ascii?Q?vESW0LOAps2/Gv6PkGsDWuLn2OKz1fZRg0jjyUpTVkkzCp2/Te7eKVnZpjgV?=
 =?us-ascii?Q?aLFlJF8n325mnyTtLqiJjvD9R4q9t3ywG5w3QRGWPHXz6ySEW3/+skPju0+n?=
 =?us-ascii?Q?CMgT3lmPyZELGNCM8uRpVRM9RtUMUqNHt5CfohKXPFdWq1it4dPa98hTbfe/?=
 =?us-ascii?Q?Uzt3gQMaEmsgeyQSRuKSKn1kmRPhtDNNsm069mCZCC0kOSF4oESfG8++kfST?=
 =?us-ascii?Q?xsSx/T8SxFPjipTRPpAsnQZHG1neZyN9NKz/GsrJVO0FC+3IFRF0s+iCVyCd?=
 =?us-ascii?Q?bKMo?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?01IYWN+fVYFwTz2VjPmJjSmWxJaGncpYkciR0N+gYEU7r4afXJnCrEgoQOaf?=
 =?us-ascii?Q?NMDCIk22ymSZ1eYJ6+3Hz96s8fCD4gi2LkSpOi1yAcq6XWp0MOm/5xexWHoY?=
 =?us-ascii?Q?aYgmGif6JviamkEcWtNJiwshyHtPZKUm4t2Yr67TOx9Y5mPaJOmT7N2vJrkO?=
 =?us-ascii?Q?OaVMddBz6myWimk6PGFRHvQ4WdFPG+d2HxCTXKDC15e2BgugBErXerX/boax?=
 =?us-ascii?Q?iR/NPV+6rqlZSKi5Nj9p0mxyZcHRFrDHilgpjKqLE96rQbloIn1KtidjgZU2?=
 =?us-ascii?Q?h8FQMuB0Il2ThB2s+2NwArySpRHVcpVl1lnE5hyd3cXlGNaXmzaQFAyv8ors?=
 =?us-ascii?Q?MrHPi/totKOwk05MAvAYAi+ZAYJN+gcLsB4tKuWfzq4zrs3onBzCoUeCPms0?=
 =?us-ascii?Q?9Pp/vQcjacTj3qmTM1zLhLMV6kZMvzNIRTd14RwiEcZZzbtemQzghwTKbmhN?=
 =?us-ascii?Q?Cq91mGpg7XhNWaxgYu3io2D58ye8xs0Jvm/vFJB1L75CAX9rJot4YahEd5GH?=
 =?us-ascii?Q?s9/BD6873AyVcel2w7JZzfG2lMe3UNBc4w4Wl8xLKSb0Wj5iG+nzv+pU6Twx?=
 =?us-ascii?Q?VOaAQ1qVwleI4fzslUH7cu3C+OHKPzX86QgopUYkZb0cObGDdV9fDl8cMXNa?=
 =?us-ascii?Q?4+Xl4FdaRas49IUmdg7rhLXgBSzf27QgSchQJkVLjD2M+eFxkFmUmmBtLMIu?=
 =?us-ascii?Q?ZWM+6ibxH/Ogx8kiGe/+I2Rx4eBfzddYWGq2kjkLRBiFa2MNwtWEs2TcyNDP?=
 =?us-ascii?Q?O+OC8X6DLXQgF/JNSxSpXCg8TX8xE/7p+1qGCFuYLRmRbYQMnxojtHLr2vA1?=
 =?us-ascii?Q?m3/LZRHNxB5kLfuIKeeFGaeEn/QVZ5YzHPb5yNl2Ijvsot99zjS43xWefyHB?=
 =?us-ascii?Q?4btj4DVT648dKn5AU4G2UtEn7Dg8r6cuWLIoZCaAbZDuRu8Nxe6L5glTPuLz?=
 =?us-ascii?Q?5XCQpF8A1EYYj+4rNwJGXgkxSNIyLF++0wQDTIj6wJVwr25+wPWAd8eZzRi6?=
 =?us-ascii?Q?C2YR0jySDadrDdOS+aUlAUlSIubhE5dMOAP7u6eyeFDdepW6sLplbSKYHpyS?=
 =?us-ascii?Q?HKDseX08IE/h47cEvUfQ8FSkWJl/P+YRo4zi3s26mWI8XS1RTOHtzc3d91bj?=
 =?us-ascii?Q?p3xgNjnn9DLKj4+cKjjcWQmDvurheLgxoXRj1w71NHa1we28Rf3Jt1175xEi?=
 =?us-ascii?Q?hV9cJSmtmLwrJWBeCthsXeUPMRANOrGKN/QyObvNzaQ4lDY7NWhS68pMsUlN?=
 =?us-ascii?Q?GM0J+UOBU8VMYNOCR674cjMic0DokQ5GezOrZ/axiQFI8rbm5bdUfNINbumG?=
 =?us-ascii?Q?m0sT4fktqwNp9RTV+nSPNuJiMHZo4PCKN1qu6fR2eBQ88iur6AjDwDKAglUt?=
 =?us-ascii?Q?43QIXc0Add00LNb3/1qZzEgIYMC2?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 77b1f534-f6ef-49cf-fd17-08dee8b72330
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB7724.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 12:37:23.3579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR19MB991545

Hi Takashi,

Thanks for your useful feedback.

> Through a quick glance, the code changes look mostly OK.
> But I believe the potential memory leak Sashiko suggested in the patch
> 7 is a real issue, and it should be fixed.

I agree with this point. I will prepare a v2 and send it in a few days.

> In anyway, as this series spans over different areas, we'd need proper
> ACK's from ASoC, ACPI and platform people in order to get those merged
> to the upstream.

Since Mark has already applied patches 1-5 (ASoC library changes)
to broonie/sound for-7.3, should I rebase the remaining 3 patches
(ACPI/platform, HDA driver, realtek fixups) on his tree and send
a v2 just for those? Or would you prefer I do something different?

Patch 6 (ACPI/platform) already has Acked-by tags from Rafael and Ilpo.

Best regards,
Marco
