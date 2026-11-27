Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.22
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795783480;
	b=JLDL/B3htQEjNUkv9AHMmWsFhB7CgvQe8F3h57r/JMmmUWefIWV7Q41R2jQJJYH+1HW0
	 xaa1xoC9XNT++A1NwCsdZIecY9+qXYPl0BeijNC+jjBaAjSgSWX7HVDDNTSWFEeNNoNMD
	 W3TRgONF6/TeCxTpGEEQ4oEd1CHdKxt+Taew+ZqVwawetbsQWc09U0ethbwEznvgh9E9M
	 QZbZQzxgjzqV6xqB6ImyqE5Suac1z2nOeyweRfYEXzuNxqGqywAuYxSqD1rvy8RqmWEMI
	 4Xm1iqC3CJ6hWYn8bobQCHZks0AN5W4ffs7OeDAsl4qEAEPXi+/H/vOiPq5yR+CjLrw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795783480;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=lv4q6JSdbhWBG+OdfXXyNHjNN35P2owBKVVrbkNJhiA=;
	b=z+awZz6YAn191o42ra3BUiOmhTs/jW4Uq1yyTwxU05g3O0gdB3zOrm1kGHUWwSXlX7ri
	 8l4EWw3eKnqutGOAyav64KH/R6rWtARMD2hBiQzhKYYuzEAE73mmlueCjxqOIUzSo9OTD
	 EDFKipGl8ALqzGlqay7SH5339hdcQieYUKjzfKEDaL9lYSi3IFgPT65aC1hZPo8yaHTIg
	 YbNj4AKk8YBTLCNNrW+Y/l1Ih69iQ3RzeKGBg+JlzF3BAb1msyVuFRPNjPRMiDaKLlIYR
	 cYq2H2GIpLtfVC9swDcyR8McpztkK3xXwq6xQHj407OdowT8XnB4bcwzAQrnQ1EYmHw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=m7Msd2Zo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.22
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013022.outbound.protection.outlook.com [40.93.201.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B71606A31F;
	Fri, 27 Nov 2026 12:44:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2B71606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=m7Msd2Zo
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a5WH+mWXM9ynXDQBkA1UB86Q2uyE6yEWNoD2nhyzVMvSdeR1xbTRiiIl7THLFMPCgRzIJIJ0T6vC8bXs3GL7VMalIE2V04CbaGcP2xzgApg9NRA9g2DMNHaH6ayeE1XpRiz1lm6N/fJl8UN5rYawcWNzC+k/Y5Q3I+r5zRjadJCfnHxk6y0ZWYUpvmb9y3mLKGI3WE6CIOS64s+JS68qKv7ptbXiROLMM+X5QGqZh0KWK4AlL4grJXFWPPIVkdvtSP+7IWH+9qQ1bIEwkDWhfmFUaRQiCpimK/WdRZxV5jvhEk2NWFBPoveX7XhLeNYdRzRgbKnEYp5xaDqXWoaz9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lv4q6JSdbhWBG+OdfXXyNHjNN35P2owBKVVrbkNJhiA=;
 b=sAV8M+8sCYkL0zu6FOUACjeXgEt5TXyZ88ppCFEKqWkLcFth3P4jD6MrKn/lvYy1LhZ9q1vV0GUxuTfaJuhJWGNR8EAztwrc37osU99S+22wF0IyjiM4TUlAmk7vwC0tgpwjwoXjhr7YLTKSk5niGIPPUGsH5GSLLpKBX7qSR7l3wlFv9iN71m4WtDPTxzwEFoRccSOVGe8iC+AZ9q9vgBIjLFi43KPj6Byk1gIWuZYsww05iJwknwrClp6c+bu8mLoZffGnvoaFlRLle2jJ0rimpJCOVv6xw+vu/VAbc73AnvvZs+dqS3NgHLmxyvsb8bbjaTQ4CmAluqFA/GLgww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lv4q6JSdbhWBG+OdfXXyNHjNN35P2owBKVVrbkNJhiA=;
 b=m7Msd2ZosilcjxMjK1BdGi5r11HB+v4aB9gEnDBfXVKKmPPGiIjPNqeGTSfmTrwpvy8je/7eo0Zo1dIpSuzG61U/gJ34rP5Yhmo0S/ez7X+l64NS8bXC2fjW4lfjGBc5tlkyR9YgAN02FyAxXDSM7NW9RBHEHQQ5F8317RxeyzLcJP7vOdaMVeudZsGy3NjFfy/4ENGHJ2gQVUnUrqHxuWsNqwKHtr2CxMuylXYXTwyO3807IywgvuaQgfIFhJma29FByfiQRae6Z0ADdMqTQJ5KemlpX8HIgC+TWy8FnVK7gY7rj9aiRakKmFYMOqtJKyXz1QB2oDiyEeurZD8lJQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by SA3PR12MB7975.namprd12.prod.outlook.com (2603:10b6:806:320::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Fri, 27 Nov
 2026 12:44:33 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 12:44:33 +0000
From: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Kent Gibson <warthog618@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] gpiolib: release the chip's own lines before numbing it on removal
Date: Fri, 27 Nov 2026 14:44:30 +0200
Message-ID: <20261127124429.3423977-2-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <awltlfkwFWv8O4pG@ashevche-desk.local>
References: <20261127-gpiolib-ownlines-v2-0-aambrozewicz@nvidia.com> <20261127-gpiolib-ownlines-v2-2-aambrozewicz@nvidia.com> <awltlfkwFWv8O4pG@ashevche-desk.local>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0030.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::16) To PH7PR12MB5974.namprd12.prod.outlook.com
 (2603:10b6:510:1d9::19)
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
X-MS-TrafficTypeDiagnostic: PH7PR12MB5974:EE_|SA3PR12MB7975:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f0f312f-c307-43b6-bb67-08df4c842ffb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|23010399003|10067099003|56012099006|261026121527099003|261026140227099003|261028144727099003|261022105027099003|261022075727099003|261021121427099003|261102123227099003|261009223027099003|5023799004|22082099003|18002099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	XX4lFKHiEllR58A11jOlOLDM4h3+1SlTQ1FChHk00463OrkKzcvhtNU0Ydw0oD7VsGek0Bn1ng4I1NcZbTsYg0+3Kb46UNwBAOG2w/2VAWQwEHNsipoVL3DAecYuEPOAaXQU/F9h4Wbqe9FGBYFssGZFnI/JEfuE9pU0IPg8s539kITgrdI/59yV6DgwZTnu8g0vDUaaZZEAHFmDBos8Ha5Nnkvx2eaM8uVUDbSpUzLh4MvqVcj43L/LTKhDH9ROHr7Z6UAdMYAAsE+x8hST4s598W3o1i/sMT//1vwZC+Wa38IKNHoNFIYJ1nihTXZZBG+/ciQyomf/PzbUFw6n0r2pxkUmbb74bUEpQu5jzFjV6LRNkN7s1aJatLnJvJE+C63GNDs2W5K3/27Aou1aLoETDUWefadvmF75V9Xou0BXO3aqXsEB/38BY4QGAKnXCTh71/FL+nI17sG/JqKr71QkL+qTVbKrON4Sakx59ikzY7QX6gjMCBDbk91rt5X7Ph7xsmf2OmUaozPsODMHBBdgQyFDpxhyOBSp9PCseiBLotrzqkIW59wPXb06pWEmtd1W7TlhDVAh4mJSD5g6CH5pVAsziUQhfDtb/5lscso/nkVHNayFNK2TmgF1e5YAuPEPoVjB1I4Z0eNQkEN3iw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(23010399003)(10067099003)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261022105027099003)(261022075727099003)(261021121427099003)(261102123227099003)(261009223027099003)(5023799004)(22082099003)(18002099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H9il2LS/alBv1P/5F0xMa3BE9pdwuS8E2oJdXYgir2gjAig1KlLjfPPMKTcZ?=
 =?us-ascii?Q?6ns+U6+58xduWHj5Au+XEvOvKWOgxc2tRgDoYqtd9d8gpGeRSI6hTBwfI1XE?=
 =?us-ascii?Q?fp3RLHpNoF0r9XZhvf4wleQk96Bpg+UTKhtRa/5EAGA1X0WOMacxerGtFe0m?=
 =?us-ascii?Q?C4tF4fgwrNtXHbg/XBF1fAbEwEXrSwvHETeigRbLiUOsugRihvhZnf7gh5up?=
 =?us-ascii?Q?geMnGVaYoPB+8MWWc9yZkCZ9Fi/equSDoSOOSPnzOJruK3md5ZdASmn8YkNF?=
 =?us-ascii?Q?6sAdf4LvjbjlRb8rxGYRWbaqc6sWeHoyUmAhEsp3ltAG81+1fEQx2ZeK3azV?=
 =?us-ascii?Q?XFMZ1mNh3aH2hM7lOqzR2ylRmru0h8ZF/eFzw2fuKUo0eJnmYMZSgftzjZd6?=
 =?us-ascii?Q?UrDlg573XWwPiKrcB2MN9Plj2Hezm6JNn3RU5RSNBrcmOeVKWjWpH5dlU01P?=
 =?us-ascii?Q?wDU9cJRdfFDco/cC22VjdIsysZ3QJ6UvoaGtPSwNQxwC9vMoFP6cusvPmSPD?=
 =?us-ascii?Q?t7APj/BXuC91bzSS4kKPTCXEBFPNJYa5vAwZtnxk+6nVLOCkPTIq7/BlE1Zj?=
 =?us-ascii?Q?pB8XNIQTQxBDotRkhACBLc27J/5K3tSXE/D/SxOsT8/cskVAaI7UA1d1VA/U?=
 =?us-ascii?Q?NBqjYBSvhrJb+zqTmAlzy3ghKluoo6E400wUzgt8P/9FyKjKh206iyijlLLG?=
 =?us-ascii?Q?3IgxIVISygMgTM9Pbt8uUb3M0MPwiVF+vxzZB+y8oUA4qlHIKDrHVBD54S+7?=
 =?us-ascii?Q?dteqVU4inYCfmeoifBgBtpsEbagwtdsTZlrIbIh67e4xVW49PCNK2rsM+oF3?=
 =?us-ascii?Q?FQ6U1wypzkP9r5MJpcPNMq1Ca9vO1+kF5+ihI5pIWUluX/ipukcynogwf3D6?=
 =?us-ascii?Q?rJmZMdamYmNQML0DMTimDoqbsQ/+tpDHZBcsLcHZgvrCwfqV6AW/nalsqOFj?=
 =?us-ascii?Q?AQCg+1t3Mnhan3KUU40l+OWLS+WqOadhryV+XWddZznan7VOeYOZequUNCyj?=
 =?us-ascii?Q?severVn2n0IsBhyJWBW6H4xtwZmsw8ZUjfFJ7Ke1EUmmSQPzjBbgKJNHHqh2?=
 =?us-ascii?Q?stJzAlTZyQpUq0GPQnHVKTSZEDMJgf3+0htR/irvsX31g2iACMZsc6FVR+kG?=
 =?us-ascii?Q?kZLNghwFfqx1AlzU2/vUSkVXo2BqSSbOQ75M+Iad5k9ZFzVwkITCmW4zWiNz?=
 =?us-ascii?Q?nG1wkzcGmVW6TNPbmZkdzzyp6wmEXpN2vmGbifYIs+kNkYeZDcomon3U1bqA?=
 =?us-ascii?Q?M0XmyaWSjyIyCcNhUtHOgOmzehbMGGS+GsFSTMt57+JAn0ZIeaghwtD6NUyl?=
 =?us-ascii?Q?eoqdk67Q5WeXC6OIbBnRzwr+zc3YWKS7u7wrSkaXJ8onR9veTqhri/ze0VuT?=
 =?us-ascii?Q?S+HFks2gAd5CYDWTvIH31mUK6RO4WWYuz/fbs6VCKoUswbUFsB3+kKdWc2F8?=
 =?us-ascii?Q?Ny+KGQXDofvXTDe4HP3qickN714tPVUaG0i2QQUtAJ0j/rcwhbZe+f07ytXQ?=
 =?us-ascii?Q?fQpw5As7QNLiBKrbXT4VJCSKHfoyshaVtaMSbxiD3TJ05v+9DQAmS/jR7oke?=
 =?us-ascii?Q?B5ykujS9bwirCXyiwMzg32PwHhtAw5VSKnFE6RdxiOk0WpKmcXFj1BKWakQP?=
 =?us-ascii?Q?i5kFExDOIEPXL6UJz0SjRb/WmoqBL7ssL6R1kA0EWvSJF2v/kGBGdrlPCD10?=
 =?us-ascii?Q?AkgbjLIi3qhD869TIkEcm6+i/XKOJMmC/nYqZQUUK4JiEbwvV0Og0ON+l3W5?=
 =?us-ascii?Q?yUf3LIfKHw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f0f312f-c307-43b6-bb67-08df4c842ffb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 12:44:33.7274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0S8GNAzUtnVBEaMk17QAfACg7zg3pE4StqkRIEjK/CWBoly6vwTfWyzJlLFISLuWD9ULowgog06f7BdkUdA+1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7975

On Fri, Nov 27, 2026 at 01:46:29PM +0200, Andy Shevchenko wrote:
> On Fri, Nov 27, 2026 at 09:49:26AM +0200, Adrian Ambrozewicz wrote:
> >  	gpiochip_irqchip_remove(gc);
> > -	acpi_gpiochip_remove(gc);
> >  	of_gpiochip_remove(gc);
>
> I need to look closer for ACPI bits, but above doesn't sound right. Why
> of_gpiochip_remove() is not associated with ACPI counterpart? Wouldn't it bring
> a completely different experience on the same platform depending on the
> firmware in use (DT or ACPI)?

Thanks for the review. acpi_gpiochip_remove() releases the OpRegion
connections with gpiochip_free_own_desc(), which skips ->free() once
the chip is numbed. of_gpiochip_remove() releases no lines; the DT hogs
are freed by gpiochip_free_hogs(), which commit 5018ada69a04 ("gpio:
Move freeing of GPIO hogs before numbing of the device") already moved
ahead of the numbing. So both now free their lines before it.

To keep the two calls paired, for v3 I plan to split the OpRegion
release out of acpi_gpiochip_remove() and move only that ahead of the
numbing. Would that work for you?

> > - * This is called only from gpiochip_remove()
> > + * acpi_gpiochip_free_interrupts() below finds nothing once
> > + * gpiochip_free_own_lines() has run; it is for the error paths before that.
>
> This doesn't sound right either. Why the common method of freeing ACPI event
> interrupts can't be shut down here and this one called when we need to remove
> the IRQ chip altogether?

The event IRQs cannot wait for the irqchip removal: the numbing ends
with gpiochip_free_remaining_irqs(), which frees them, and
acpi_gpiochip_free_interrupts() then frees them again ("Trying to free
already-free IRQ"). The irqchip cannot go before the numbing either:
the character device frees its IRQs only after it.

So for v3 I plan to drop acpi_gpiochip_free_interrupts() and this
comment from gpiochip_irqchip_remove(), and call it from
gpiochip_remove() and the error paths instead. Is that what you had in
mind?

Adrian
