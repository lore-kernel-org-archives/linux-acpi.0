Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795765771;
	b=gAxtjG5qcRVUR0Q1MgTsflI5s2Ln0T8hSSuJC3CiLD6MLlxlv9luGaRbS1TJtXmF24OW
	 YFdtQutmtHfDz2M6AoO2aW0LKbn2eW8AhGHAHCznl2b1KNWgLcmtA6IALaXsVqgMxuJ6R
	 uwCfRpmHG6BWnHNGLQqANly61DtNojy2HJ5UJ3DySGedfzJ0ro09R3o/uG47OLP8FKtBl
	 iVHpUj+W03DFfqAuTq7++xZGwGW34X8UX0yIAVtPNJeKrjaOPV7zaEtegYPmFKMSpDkYH
	 Wt2G2p/61KcjbN0NTVZ5liIidhcGZdOmJmRz/9CqgFSBGQ6q6Ucq6XLaXXj33sk/7TQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795765771;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
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
	bh=N1AZ4Stw/++FYmHABX7iIuZxVSFnSM4i7C8W4oB0Qpg=;
	b=3UvsayN+Hwo//Cw8vZNUI7yrOvZx8xXzqHoaLx2Ia+EIAfmDP7lXCz1MXYHlau+7paDK
	 rPTRS2jlABYHFXLJhXhexSvsgfZAGZDnHbJlHi+M1jnmxSJNkE+s9sP+XxujzLDHPYAHd
	 ZaOjSYqEUcBNgu4sHdXKQ7WwDr0RZXK5s9Ok0YTvvwVLwQvrRC1LCe2iLLZy01gTzgg2Y
	 5lOtquL0iCjRYOH3BchN6NnQbiOK5+8dROQ39Munw/tf0C7GxiR3dXP048YHZZGCFAEA0
	 jWLj39EUvIgV/ccM8HskOol8wriaAMll7XA2T4DPka6lVU41PhuWG8FQZd428eIt0zw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=nHM6oAKG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.11
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010011.outbound.protection.outlook.com [52.101.85.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17621606A321;
	Fri, 27 Nov 2026 07:49:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17621606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=nHM6oAKG
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jXmsV0A3d5F6iTcYPY5lCz6xmAxMyMBXtL4vdgeUXKuUfz3kFoiuAcjrc4VgVNuOkLwtW4gnc/SxkXF6e3cBIpVSCcIJlixAG/9Dvw+ZDkwyiEDRL9IWJ70Iwq4kAzcFYgRjQxW+/6Mcwqv91CM2Cf4Rm0HUEfFTQoCYIzBWgcvYldMw3TQDP4SHKp7kgUwC7JHa+2Atcq0Kq1T44EtpOt4e9Mn1MUT/gjwRmRWvQYKcf/p8mJD9QxTEZnAeKvbWqleaON6Hx4sXo8JsZ37dY3+Zxcc9ufSz2hGHc8pXs00WhTMGM4rWKJs2mQFU6+EcgzdUinK01i++zSMeXl8Kvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N1AZ4Stw/++FYmHABX7iIuZxVSFnSM4i7C8W4oB0Qpg=;
 b=nsKco593HXVx5/ck43HVpiFnwTU6ra10DcX879O7lQvRUbrlh0Y+foPU41dwM3haZ9LB/LCY2Iw4LersjjzyAAdFKudju7AYfUwJVWrTICwOWUhxT27dy8p0Ivt6iWmo9ILvE/9gUssbqOP19zBhL7ntlJfIGQQOv1V5IffaqMCfG3bgp5/PvtdB8JjJbOcyNWpUdyzQf4sg5oH623b+xiGWTBv4ZhOmkHYr5+sEhmeD09ZWgpDMgkbU7ts1fCAlOKEXgXDUDT+2aFGD4pdNKywPjgNtVPMb5wfE6K2d/L3a6aBgfyImV60MWA0l5tU12j8XVVLIHBWvmZ/j6tRqwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N1AZ4Stw/++FYmHABX7iIuZxVSFnSM4i7C8W4oB0Qpg=;
 b=nHM6oAKGJhHW/6QnIPe2bwOQO8h/bxzkkI/AtDAO/zM71zr0sFXG2ZQ2jylULkIi7wyAaDhfzhvPbj0ZpuaqGi0h0VUhELO/xlzZsw8lN5tx0gh8TvG0sI1Ds9LKOiGGz6sj1rOo7T+VOpFkDKmcAgP5E30+Lqnd37FILFopd1o22bMa/lm0FvetBZQV0/sGBJ6+pv9idTtM0vUFKpRKRmgF5cOs2VaWNUZ1lXKToA8kgLEtDSXlsZDqr+8eGuuJtqYs0sluSbXVaf+hq2ERpKr3pXJ6v4l++KOOBt/2EOw+FetqdmmWHfUNj4jkpK1AuxXuNjmMZUwpJjIGLFqA7w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by PH9PR12MB409658.namprd12.prod.outlook.com (2603:10b6:510:412::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.10; Fri, 27 Nov
 2026 07:49:29 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0662.004; Fri, 27 Nov 2026
 07:49:28 +0000
From: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
	Linus Walleij <linusw@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Kent Gibson <warthog618@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mika Westerberg <westeri@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] gpiolib: free the lines a chip owns before numbing it
Date: Fri, 27 Nov 2026 09:49:24 +0200
Message-ID: <20261127-gpiolib-ownlines-v2-0-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TLZP290CA0009.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::18) To PH7PR12MB5974.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PH7PR12MB5974:EE_|PH9PR12MB409658:EE_
X-MS-Office365-Filtering-Correlation-Id: 11474ec7-51f6-45c5-2fc8-08df4c5af711
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|18002099003|11063799006|10067099003|56012099006|261026121527099003|261026140227099003|261028144727099003|261102123227099003|261022075727099003|261022105027099003|261021123027099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	A0Ti5LMjoiPdPGBideiIsB99dpQmtcl+XOCgNrU03WfHLgwJbP9dzSYylwjJnaW2g4Mat8ACyfE4ALpfgRuE3PeT5H6lTRr0dkGzzlwvcNAiWC5H2Lq3Nn3u8lLel+WDJn8ux2BGSd4YtOSI7h9r3lKGzcE6TBhBVnysFNXHbjYsVIwPKxUQsj2MAzVmvPWcHETb3jb9QHb70XrBtg4u4R5rD8DQhcyZVzD6IWEg74wFl3Xecki/8i7iD4tCHy8KbU6ghyx1oL2WBP/tpezzXW/8Ton6HaSQbmYi4XmTNrv6+APOqYyisgHtaMgoqGzeEXiUPUs7v9Mlb9QMvdk+zWqMosqsLX5OSIovjzXwPWYg/7or3RI/4GmbMfX2Q2hG5AGGaUuC6MXBTt4jfzftvgWtO4cVX70yNm0r3y84Up4K6FuRUVoxhlRwVoZjBt19n8go/hlqLH5ipP2/cf2iO3Lb5kARKkH0BDVleloEuzOYzdaMKnkwlq1yMeVkvT1DwsdK2cSFkg6KYt92Pd5ejmbTGMNSWdHaWhXH/9ZdcnhM14Mu1plXO0ilmQpbYtSjzC6EDjYL/M+wecbffRnnLYGo7PCHL8PPMB+5iE/CepUAudPgaQvtkixKD68dWF+bdWhaJc96dPxSQ4aDGOkIjD7qAcHPwPdGONVduYk/dt8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(18002099003)(11063799006)(10067099003)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(261022075727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0ORfTKT29gBzruYFycCAyXpmnWBWP9I+oHQths/qvuNgCC/+MmxPZGCaZerw?=
 =?us-ascii?Q?NKTIxj9duFOgLicw3+s0AEd6CDLc/P5UIfaGPw+0eEaVv0M+3letvh76NsX/?=
 =?us-ascii?Q?kZUPS7JCPOfXCWATvUK+pdUMzdRNOm2JcH+lbQPqmVbEq7j/kP7hDZi5h4rV?=
 =?us-ascii?Q?UQnElglCCkTwTaeSC2ABVtUHyXzVA1GL5fd65KhgGTSx6Cl4wLd3qyx0VgQy?=
 =?us-ascii?Q?DEdDHt4B71cwIw5Sx6J3Z9Gy2e3NoTvGoJKflMiBjTACnmX01UvC6mbzQT7G?=
 =?us-ascii?Q?WXHO+8pbwEwsZlbciLgAItQ6e266tcVEJEpSBjrdSBQi7GlZsH19v1ni7WXP?=
 =?us-ascii?Q?9TCWD6fGOYQ+ZOTuW0YFuZt0LRTQfvTi0VaN9y/5xOFXb3uI1r27au41xgiP?=
 =?us-ascii?Q?hT/4dqrLx1agNOl/hKf3m8J5R3d5Cq7a1y4KiSwBmsg6ReUvLHBeP98JBSuB?=
 =?us-ascii?Q?JdoE2jyn+ro4RudWLh4ihio7GcuDl+q6GxovichHy7TzYC2e+VghgiivFfuV?=
 =?us-ascii?Q?iL58tPR202vIZSzqtLGKzkOVfdJajhkZWR0xyYk2Zr5kSn4gMyPOjv959DqK?=
 =?us-ascii?Q?hocyyUlj5i/mtmJ+DiIuf2WgjgEZFqbiCmotJ7MALQseN+9xYvDnVyGw+5fi?=
 =?us-ascii?Q?61NBFthScDkAFjsvQMHlQkZvqLKadnTmP73vrwPqHDpEBpgzLRmr64yJ11TT?=
 =?us-ascii?Q?c+u/3LuqSuADhfMVKuecMh0llIRhK8zXqK/e/MMWW1TPp1VjlVHiAWcn8Mz4?=
 =?us-ascii?Q?UfxUJpl4PqgvWqOIgXQxR/6YuVjz+x1X2tCp5GwcLhnp6iwP0YQQcnTJvv6d?=
 =?us-ascii?Q?Blc52joMCcPC5vFXzSAv3IvCUJkCEvED3S1c3sXWLXq6zhKhPg/ePXgZeyEe?=
 =?us-ascii?Q?bU7Kf3LljEzxFxY2q0ERUiXT1s2HBKQZRPj7aArNsDI0+SfK73J8fN/T3jbN?=
 =?us-ascii?Q?da8QHvH37w/jOpf2nGKlABTOKQ4YSORJ/hXNItdsmUJ8inaqG6opJ7+Kmb8o?=
 =?us-ascii?Q?38uIUV7dFtpbpUwWu5uchkiT3ToDmdfOZlQfU1wS5wXDs3Sv6Q70Z8CyFFUc?=
 =?us-ascii?Q?hqh5458a2S4g+rxtf9drQbbHGByXxIrUML++1rt6bIY5bSJUu5z932y7ali3?=
 =?us-ascii?Q?Plt6cpF0KbP46sb5EL3voCCG5FPa+EiiAQkGvrRtgfhRhhPTBQccZ+kJtvVF?=
 =?us-ascii?Q?G5LGilmtE65qqQd8wecOP+Hd+HPBdqis++dvZm7Leozmf6Y91mojHs1W048/?=
 =?us-ascii?Q?l0ETMSiCBLM9gZ6V5DPc99LkDU3rJPbGjbm/drDq368/c5rWhwURacW/meWx?=
 =?us-ascii?Q?f6jhxdoiccjZYb3H0AGvARVUiaIcb6u/1Bu80IPrUMgGwRQySiqPQY8A9kqf?=
 =?us-ascii?Q?Z4VMZ2UWB37SBhv3mO11azCUYjkk1kDnGXzZ9SySSKEwCWk47wBTIo8iL93Q?=
 =?us-ascii?Q?wTSgfTueJ/DHxLkWxqXhXTT5cRgycc1ZI96v2PuEhvcG45yE/84fG7TORfDq?=
 =?us-ascii?Q?E3q7n8E8J6riN5kQqbgSqe4RQtaLr+s3GMlOkrCl5b7EUfzDTPw1CaK03dvK?=
 =?us-ascii?Q?Ax4uzrABvqTd7vEXuYdbXnT5XbZssarmiZYiEY3N4wRv0d7l6JRN+9QxEWQu?=
 =?us-ascii?Q?jIUvH/YY8dJTk59LGlHsvZxudhbxc23TZB23NrtZNZu6Y9Tf/BwRajcsbeSd?=
 =?us-ascii?Q?Xa//2Dwu4V57Gocq+RBDoN885uT6/+v81Erc39GSkmWXsINWg633ybEV7BNw?=
 =?us-ascii?Q?SqnEOtPIPw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11474ec7-51f6-45c5-2fc8-08df4c5af711
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 07:49:28.7345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w4z5OPhIwYY/REq+qACp1gF21oW+5bGT4aeuThEpR2LfplZjL97gNu/35L3g4oiOqdeqKOYNTMZBNR7Hmrfp+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH9PR12MB409658

When a GPIO chip goes away, gpiolib has to release the lines the chip
requested for itself (hogs, ACPI event and OpRegion lines, shared lines)
before it numbs the chip: gpiod_free_commit() calls ->free() only while
the chip is there. Commit 5018ada69a04 ("gpio: Move freeing of GPIO
hogs before numbing of the device") did that for hogs only.
gpiochip_remove() still releases ACPI and shared lines after the
numbing: their ->free() is skipped, and the ACPI event IRQs are freed
twice.

v1 was a single patch for the late error path of
gpiochip_add_data_with_key(), which leaves user space calling into a
freed chip. It copied gpiochip_remove()'s order into that path and with
it introduced both defects there, as Sashiko reported. v2 fixes the
order once and uses it on both paths:

- patch 1 removes the shared proxies before releasing their line;
- patch 2 releases the chip's own lines after it leaves the device
  list and before the numbing, on removal;
- patch 3 is v1's fix, using patch 2's helpers.

Each patch needs the one before it. Based on gpio/for-current: patches 2
and 3 need "gpiolib: let the character device free its IRQs first on
chip removal" and "gpiolib: remove the shared GPIO proxies before
freeing the remaining IRQs". No Cc: stable; please decide whether any of
it should go there.

Tested under QEMU with KASAN, lockdep and kmemleak on gpio-sim, with
test-only fakes of an ACPI event and an OpRegion connection (x86_64) and
a shared line (arm64): late setup failures with uAPI v1 and v2 requests,
a line info watch and a hog; removals; a failing chardev registration;
and the race reproducer of "gpiolib: remove the shared GPIO proxies
before freeing the remaining IRQs". Without the series, KASAN reports
the use-after-free, the double IRQ free warns and the shared line's
->free() is skipped; with it, no reports.

Prepared with Claude, which helped analyse the bugs, write the
reproducers and draft the patches; I reviewed and tested every change.

Changes in v2:
- Patches 1 and 2 new; patch 3 uses patch 2's order (Sashiko on v1).
- Link to v1: https://lore.kernel.org/r/20261125-gpiolib-setupdev-v1-1-aambrozewicz@nvidia.com

Adrian Ambrozewicz (3):
  gpiolib: shared: remove the proxies before releasing the shared line
  gpiolib: release the chip's own lines before numbing it on removal
  gpiolib: release user space's lines when adding the chip fails late

 drivers/gpio/gpiolib-shared.c |  7 ++--
 drivers/gpio/gpiolib.c        | 61 ++++++++++++++++++++++++-----------
 2 files changed, 47 insertions(+), 21 deletions(-)


base-commit: 1f7d535465a5568187cbdfec3beb734bfb5e5015
-- 
2.43.0

