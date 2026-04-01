Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022143.outbound.protection.outlook.com [40.107.200.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64A32AEE4;
	Wed,  1 Apr 2026 01:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775006052; cv=fail; b=KVwIAoNcXEtK094PCLgByndgl8JM+mkIu5cik2R30wYEr0gAlr4+ugcQ9bMQMz7o3X5eWrfs/xIRPkeZCUqc/hfYfLALLQaLI2gLTCVpq8L68WxIzJzTf7JWsOzAF/wtk1uAsRmF2JYaXoV6N9vUtchaCcGLHuXbSPjcWZbNYGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775006052; c=relaxed/simple;
	bh=ZQ7DnsXrnJfjQAE1SQQdm7/pupJzNYiqP3z5e/v72fE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=SCgqKIhKUe+eJdsNQPY5p33KWj92+oNqABH2uppg8gsQiXhQmjliP8TKPaL09qrtt7wTiTeDFwui5Q2wSnygnRKvOWTk7DoQT1YM1WL0l5hnO2SK86nktmnMrUSLaQf8q8ICmcDcM4jhzxmUpnJMYisXleRVo+iyNWGWMpU0ruc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=TdfjkAQv; arc=fail smtp.client-ip=40.107.200.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="TdfjkAQv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B4Fub6323nnU5/fkUWCGp8nUQDwQlrOFpiRF2oGmjdaITwPzGnu7XyTqpkLGml0POwctIsM7ajv3oJzDbP3mRjHLIL1GlvfsSHtgs/k0HEgwgjdn5ioxycvqr2pwWVeS2llDFupZfgMHT1lCTbb4GQErQRk/FioY2w2pXAhz6AN91Ogbi45F6WPaMfUEVD0n2oIVgnnsByy85JPYEGsqAfWgx8V936TMr441TX6LIZkvBu/qXTFVOTk+GqkO/Y9jZKqU+thCmvgBFDwZdhI5U2KsIvLe4KsD0u2VkoK/d9Aqp1x1MFwey48R4jvdT1lkINy8mg35znDlZEOpCtPPzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=37OdAUVThfrWd+qXZfpdfyKW3bXln746w3B2aKSv620=;
 b=khpUzKelQaSiICL/4T2Y8pePMQXQGkL3FMhdEedAOUJ/FY6/3LD3u5GfYrxZUrFU4YZiEuUNu0RrEDCqscvQknzqhv7C5UbS3e/5uTHmpgT0uyyTr7j9FXUNAJiHBCjBG38roZgJFl0eU+kvU8kAQ/XDXIEzDLqP5aR8ZHFaRgte3bNlMF+m6mMtG8s3ikMFYQ8v2DWmU/dl6wWB0DJE9tcQD/TjC3XoeQcQPdmNP4A5Q6nVRUmvhcGL5J4plYWxHoI6yZWWDlmVVPHjXVUIwTFzqRKAcWTv/sLJs9ruK1ffXj+HhESHzvTqAOogYcaHIVXxyAES1OXp1sbED4dJkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37OdAUVThfrWd+qXZfpdfyKW3bXln746w3B2aKSv620=;
 b=TdfjkAQv3AQYLoDwatjBF8CmlgvyMwDrATo6nFCM+TKFvR+ZQh+Od1vOsXghhmix1jGcq7jP0Hjoyt0cl3ee9DzRc12Pju3qtBqlN+GxFNze7NXFO1mPA3Y/XYMRoYlfYDT+NraZzhumGgQheJoEsEiV/dsByOQfvXPJ9ET37lE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MN2PR01MB5615.prod.exchangelabs.com (2603:10b6:208:11c::29) by
 CH0PR01MB7033.prod.exchangelabs.com (2603:10b6:610:107::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.16; Wed, 1 Apr 2026 01:14:03 +0000
Received: from MN2PR01MB5615.prod.exchangelabs.com
 ([fe80::996f:e4f2:dbd8:120e]) by MN2PR01MB5615.prod.exchangelabs.com
 ([fe80::996f:e4f2:dbd8:120e%4]) with mapi id 15.20.9769.015; Wed, 1 Apr 2026
 01:14:03 +0000
Date: Tue, 31 Mar 2026 18:13:58 -0700 (PDT)
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Haoyu Lu <hechushiguitu666@gmail.com>
cc: "Rafael J . Wysocki" <rafael@kernel.org>, 
    Lorenzo Pieralisi <lpieralisi@kernel.org>, 
    Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@kernel.org>, 
    Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
    Len Brown <lenb@kernel.org>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
    Russell King <rmk+kernel@armlinux.org.uk>, linux-acpi@vger.kernel.org, 
    linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] acpi: arm64: agdi: fix missing newline in error
 message
In-Reply-To: <20260331025257.463-1-hechushiguitu666@gmail.com>
Message-ID: <5b7727e1-45d1-7f5e-97da-43d3af905f40@os.amperecomputing.com>
References: <20260331025257.463-1-hechushiguitu666@gmail.com>
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-ClientProxiedBy: MW4PR04CA0248.namprd04.prod.outlook.com
 (2603:10b6:303:88::13) To MN2PR01MB5615.prod.exchangelabs.com
 (2603:10b6:208:11c::29)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR01MB5615:EE_|CH0PR01MB7033:EE_
X-MS-Office365-Filtering-Correlation-Id: 0db10516-1a78-4440-11c1-08de8f8bf681
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|55112099003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	pPcKweZT6hlvMsKx5TBWtV/DewLDxdlXOeMMs96/stubBFHs4LOoq8Ljaq92DrMYNx27G8GnSYeJBBYrOW7y9NB8V1FxDL1yxf54fiQWm+vkBkHWI9LSLSoPI0TKZSyCUkMC4vhFrd/DfVNGesjPl0PftcW4QlpphsFGvYRFvyqdbuWJpISfG20PZ2fr8InP9ox5aYjEZf8Egy1WoZBZAnkZF0THF+9m4wwfTiti2b2YxEFlcGzYS6BvCpLl4dfr5/zszEyMQEgejkDv7tczq+w4RRjvhO9/MMYJdkQUUbgBSLVo6I0JjWrGj13wnk5TtTEvDVtd8z/3kUcdoZJH+m9ugD+iNYsPPzYD6a002/52J0kzwP9ccIZR1M61er1vnWgWcuhwYhrHntJDs03T/XVL7Oc8iD7CnkV1wKZhK2vKigDy8KwIfR8cPQ2Y+fUJmfeTr+Vtizz0orKu+rGNJBG1zoozJ3JN+RxeBjK4RSYk6OU9O/2ldVO0Xn4Ksk13hV/8vRpLWhd2yPUJjHEdauT56P0AxfHEGEGhzQotOD2ssVCq6AJ23mYXiRb8iVmGkdUQ1zxywDhDQ1lCmZnPA0wfZwVNsGDmy1/PXPYgRavy5NJVVnpJHoYwRDMJROwwUGko+woC6KOx+e9/1WLpd5YmZyfLnelGlw0IzmVRh43jlXstBoOOTAwdQKXDveXSXW1Hj8H5BgKWwgjMyOpfec62vKcrccQxHUkEW4fjrBY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR01MB5615.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(55112099003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5Iz/S/l/wj2MBsMheOvD1JNT5WZ5wBWb/pcH2kltcgHiQ7vqnYng709hZEov?=
 =?us-ascii?Q?TN75F7VIc5LBhoYKYJFX95mztyAa1Zm5WhbFlttx6XydFXXLmhSzlTnuZLAP?=
 =?us-ascii?Q?DlYF+mUOQZ8LdW6K6I9L8DIEjSuXg8FxLPJ+3Ub9MoZEXIAOCCxcAdWS8j2F?=
 =?us-ascii?Q?dyQN4B09R9dMByymCpF2lEEtxXImnVCPKK76sG/oNn7cg6BLlZiBQWkkbm3I?=
 =?us-ascii?Q?fwFVMNduTDfDo0Lew1mxE5pXgT+tUEUm6m50ZB+vsxJzi1FsPRLz9OSNk7fp?=
 =?us-ascii?Q?udD+0MV/Wr/FA+comTth0ZO7nLIrZk429sP5aPAWjkIvZh479u38N+rk0ZOg?=
 =?us-ascii?Q?8D2/dVqVdrZZvc6qcu/7cRDD72cbom18O+qXgIz8QCQbK/E6UVVMIxNVekx/?=
 =?us-ascii?Q?nOTMTus6S38zlLA5jcsUhIHWUzObvbqc5FeABG0HeR6XEPGfb9r2+x3IBaEk?=
 =?us-ascii?Q?y1zf/UauWSxmiA3qAJH+8nvls9kPM2MFLDUXZ/Y46iZguugonwPoPnyfmjDp?=
 =?us-ascii?Q?37mOqjc43CNjmyO48UVrkckRy9zOx/DwcJDLARPe8Ou8ABzyP0o4s2fQThHF?=
 =?us-ascii?Q?cLwvKq5RQID2imDgPd55ZEEM8ZcGosLSPugzZ9hz+AG6eEwSleAZ5RFCcX/b?=
 =?us-ascii?Q?uz4KD1b1DYZ8KWefOSrGJk559v+5Bw01qHOFcJWj1BLz2zE4HdEG2awrj4z+?=
 =?us-ascii?Q?3Ze9xrwFCNzNAecFxjLNnNMIvFK8Ymw4O3JyPfBVlft84zDFruSP0VY8ExO2?=
 =?us-ascii?Q?k1gdRPyLBY5ao9VHKIcHWVjbRnQ5/fzNc+okBzoEd/fIMxKf+VAcoccm62Lb?=
 =?us-ascii?Q?XZe/Yzmqp8m4LhOSbauXItkLjCp8KgVqwRbudr/fc9M0KVXe8dMJ35jf9R15?=
 =?us-ascii?Q?YOWIJ4BXZgRuW1eRwjih4moTBa+D5et5t+fpdaBRMaSpW2h961yi7olDDXiE?=
 =?us-ascii?Q?9s02jlR1lLQN/njYrArYOt/PTwsKsvAtIyIFJ3+A7Fds2WjFc7/53lOq3iL4?=
 =?us-ascii?Q?YOICtHYbyXDW1gdYq+lsQ6Ie/s0ArMT97q8zcF6n+axduO9p7TgSIVa4A6Cn?=
 =?us-ascii?Q?/IGrCZRjsf3ZPsX+tYJCnatOU87CgNAyPmuW1aTA1XE3aSCl1Rp/y9mQiIIA?=
 =?us-ascii?Q?Dg9+BCCUctYNVdXf/LJQ0Dm9whnxRFGou3HXxltDNWRzH2qQj+xQI6FWOv1C?=
 =?us-ascii?Q?YC0GdlML+cLl/JPRuyqjmhcP/0xfYqj1oWYXk4Raaq9xfbEYdpQ+DiSGSGvj?=
 =?us-ascii?Q?6gnKiE25Y5PTwGBu6ul/06cnUHG9tEXFyDX1arzYZ+6WB+SggWXrgbor7ZDp?=
 =?us-ascii?Q?9t3IfH6eEw9p/4hlK+dCZRBlP9/cWuEb5U9A1KLIkuHeSEu0i4E3pIBXyLa/?=
 =?us-ascii?Q?ubIX6Zldp/XHzZFt7H+7rsbEXa0fZ/CYhM4mSp0450EEO70AMEvUZD24E3Mx?=
 =?us-ascii?Q?jq3KMCluCnVw5CqNdfmcx/9WBPecAVZM7a3K2NsmLdWGS4z41C/E+Sl0i8m0?=
 =?us-ascii?Q?7VJz85G2IMJQNBEz6F4/BZK3q1O0xYkpE76UF6Y5Xnpg54xS/j2kPPJPiVgd?=
 =?us-ascii?Q?MnuTl9AQdjDkMc9/6mWycfDxyj69ThRh3T/iOWiyj262SznZFfwRBkFtek8B?=
 =?us-ascii?Q?1SKFu7hLgWt4fV7OPnW+23MfSgkWmVbuxQRl/X9g37ecSlRExBwzqtiKiclr?=
 =?us-ascii?Q?8tpd8RHC+ud6xOrzuWZsnGZwMDB7Tv4ZurIiiy5ftRYvXYTLj2Tmihlzi67r?=
 =?us-ascii?Q?x5J137pB6zeCCUddsaeiUfkvgMeK230=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0db10516-1a78-4440-11c1-08de8f8bf681
X-MS-Exchange-CrossTenant-AuthSource: MN2PR01MB5615.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 01:14:03.6441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Ho9zcDvq11XLAZlW4Qx9x/90lYrY74CPcgVrFOhtREeGTMkG49yNF3Sj3hfM8FywEd0+O4fVtvcFfEK0eL8rRRnfKt3wSMDUcxoKRZkrT5OV3DDf2iuAqyBPC4NRcB1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB7033


On Tue, 31 Mar 2026, Haoyu Lu wrote:
> Add the missing trailing newline to the dev_err() message
> printed when SDEI event registration fails.
>
> This keeps the error output as a properly terminated log line.
>
> Fixes: a2a591fb76e6f5461dfd04715b69c317e50c43a5 ("ACPI: AGDI: Add driver for Arm Generic Diagnostic Dump and Reset device")
> Signed-off-by: Haoyu Lu <hechushiguitu666@gmail.com>

Thanks for the patch.

Would you mind changing the prefix on the subject line to match the 
previous patches? That is, change it to "ACPI: AGDI: ....".

With that change

 	Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>

Cheers, Ilkka


> ---
> drivers/acpi/arm64/agdi.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/arm64/agdi.c b/drivers/acpi/arm64/agdi.c
> index feb4b2cb4618..0c2d9d6c160b 100644
> --- a/drivers/acpi/arm64/agdi.c
> +++ b/drivers/acpi/arm64/agdi.c
> @@ -36,7 +36,7 @@ static int agdi_sdei_probe(struct platform_device *pdev,
>
> 	err = sdei_event_register(adata->sdei_event, agdi_sdei_handler, pdev);
> 	if (err) {
> -		dev_err(&pdev->dev, "Failed to register for SDEI event %d",
> +		dev_err(&pdev->dev, "Failed to register for SDEI event %d\n",
> 			adata->sdei_event);
> 		return err;
> 	}
> -- 
> 2.17.1
>
>
