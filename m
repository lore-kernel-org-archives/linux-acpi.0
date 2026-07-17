Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazolkn19010019.outbound.protection.outlook.com [52.103.20.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FE33FE656;
	Fri, 17 Jul 2026 13:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784294812; cv=fail; b=BwD3Pj/trirhnDZZUg/Q2H6elxahyDXmWKdI1QhUFOQbdMR+QS64GM5McpL0K96N79GwwSsdOZqcfUr7NqBk1pmiEMkkcC5BMUxZTlc+I7kTuBxbHWJ+70iUym+wvfQVpZAdg2WWOBfhjZyL/cxzs3wS0vesBEbTz3ywNqVGa7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784294812; c=relaxed/simple;
	bh=TpV+YIcKEFXj9eBCCZgk9A3304dA5EcltUtcI6NuEII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F11SENE/n2X7fikMu7zAuwLRNmkKESajf0RpOubpIFqJ0T8h1ZwdjX9wQDFR3DORGI8NlJ0k6q2FjOWvRL1v+APAHE8Rsgzw7dE9bOs4r0wQVhgc2/0e12zQZlxZOPbrq0IOTTb1wl8GLgAjQHd05JTDGAiodw2ybQuhaHcDqmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.it; spf=pass smtp.mailfrom=outlook.it; dkim=pass (2048-bit key) header.d=OUTLOOK.IT header.i=@OUTLOOK.IT header.b=uFCUqKcH; arc=fail smtp.client-ip=52.103.20.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=OUTLOOK.IT header.i=@OUTLOOK.IT header.b="uFCUqKcH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c/i+vkwcEdcmuqAez2nkzUpp3BKUbyKX5YaAjGi3ifBIoFqSN2p9rvk+nqEHpp7Pk+lxyuLiBaKlIkhgIFJsG2slQKPHDDZB2af3yA7z/mXgH4isLUIpwfHeBMW5ITp1drmkeW2Nuj406Bajacnbi1l1vwQCOjzbHDJnbn8c6VbcJJfl4P7ng4cN5Of+WBWOFDwrwU4PCLFvRQSfjeTcu3ZarmKOIjXim4UelRX5Cew1cCxgkogUHDii7luIj0vBLyiQrnUoCoqr/u8P9PMinnOHdXFleQyBWaFKdhIBQXhkFTEzLoNl1jDVnMVodo1alwxouBHE2SPZudHLHAPryA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5uAg1hwRZ1raKuSb1XZ7/mOWMZxOt5eusO89QsNdtRo=;
 b=NgrWBRZKEc0CFjkQI4C0ZNbRmTE0nCkIYSMDLpABc2yvZrHCfId0JdDLx02DgucONuXznn3JS+8q4hn58L493Y1qaOrXWLnns8zRw89hlaXlWPhMokpYLrrkh5bPr991JixxviC+L2czhrxri8paEztg0bimgPXqHwbg0foEJLD6sK9m5YEeFHp025ze2bm3xZUAL4bKkLBRThJPe+5sB8D0I3b7tg0zgYNO3HGYMJ3JXXrURt0A/Va5R8zh2nONtqkLCQ9XZ7GTYz/xajG0lPAnFLN2wvnHh8iWv60dVLV47NYEFRFG9BalxnBClCZqyj7flrtV5eVjp+p0iBwuJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.IT;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5uAg1hwRZ1raKuSb1XZ7/mOWMZxOt5eusO89QsNdtRo=;
 b=uFCUqKcH9ETgONawPLu0Kpvim4xsiSE+7UEkClonTmqdEtGTeKCgWA1wDpQZlaslWJBYYLkYJAk5s9mm0YcZ+A3ybUyqg5/AlI7LnCh6RetAbqsvd0HV4NmdvxGsWW96Q3ia74fJ37OQUXTR8PUdnBXm2W5TAMv8kNItMsEUoOg0vWZL1P0MPBuLFunyFBGC34/SkSEPQYrYTZgIvprAj145O5ZrA2Tf9eWaurh4fPUBT4qJPmYJ4YNBiYxPUJjTSquqgS+/zO/qGE/szoyzs0niIU97OqfO46Xg8kwrfAxrBX64L3NjmHkVbNhBlh+ajijBg2n6laKj+TFpsKrM+A==
Received: from DS7PR19MB7724.namprd19.prod.outlook.com (2603:10b6:8:d9::20) by
 IA3PR19MB8637.namprd19.prod.outlook.com (2603:10b6:208:526::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 13:26:46 +0000
Received: from DS7PR19MB7724.namprd19.prod.outlook.com
 ([fe80::70de:3c05:ac62:7f86]) by DS7PR19MB7724.namprd19.prod.outlook.com
 ([fe80::70de:3c05:ac62:7f86%5]) with mapi id 15.21.0223.012; Fri, 17 Jul 2026
 13:26:46 +0000
From: Marco Giunta <marco_giunta@outlook.it>
To: tiwai@suse.com
Cc: perex@perex.cz,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	rafael@kernel.org,
	lenb@kernel.org,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	linux-acpi@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	wangweidong.a@awinic.com,
	nadim@symbolic.software,
	imitoy@imitoy.top,
	munzirtaha@gmail.com,
	yakov.till@gmail.com,
	Marco Giunta <marco_giunta@outlook.it>
Subject: [PATCH 3/8] ASoC: aw88399: add per-instance BSTS status bypass flag
Date: Fri, 17 Jul 2026 15:25:05 +0200
Message-ID:
 <DS7PR19MB77242B8E5BB8BFB5E69816E9FCC62@DS7PR19MB7724.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <DS7PR19MB77247D9AD698CF0FF37DB58BFCC62@DS7PR19MB7724.namprd19.prod.outlook.com>
References: <DS7PR19MB77247D9AD698CF0FF37DB58BFCC62@DS7PR19MB7724.namprd19.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0013.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::18) To DS7PR19MB7724.namprd19.prod.outlook.com
 (2603:10b6:8:d9::20)
X-Microsoft-Original-Message-ID:
 <20260717132509.148321-5-marco_giunta@outlook.it>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB7724:EE_|IA3PR19MB8637:EE_
X-MS-Office365-Filtering-Correlation-Id: f07df0a7-09be-47ce-6e22-08dee4070c07
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|5040399003|5072599009|51005399006|12121999013|19110799012|8060799015|15080799012|24021099003|16051099003|3412199025|19061999003|440099028|40105399003|3430499035|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rOI9Sthqru+BXfEOZB1iHng5IFdriS90RBFim+5ACGiZ0wECSgZqczsDYEuT?=
 =?us-ascii?Q?qv+vwX0Fq29XaPJgmLIVIY/eCMmE8IirophsRXooyqIiC686pbuf9Yty/iXB?=
 =?us-ascii?Q?pJjC97VWYBdricrQDMBVadHAF9jW+e9Yg91DiAPKsEymYAwNA27wC+ysaj7h?=
 =?us-ascii?Q?WQhq+p4529L6NNaCV/G5t/xRi1dMHzrgUIHELIWNn3VCYQKToi2w1rQF3o3T?=
 =?us-ascii?Q?kVXuP4OHdn+S8JHYr54Ixn3bPyLwMpUJ3tz5ksnsXGvH1qXtjk+FeSVfwiyl?=
 =?us-ascii?Q?3Z9lrHx/LxRpcmYxVUubAdfFokYCbZJnrIFc4sNlkn42LE5E/pHMZ7zMhXIb?=
 =?us-ascii?Q?+YD56TSdqYHUV4BOF58D8dp6dlkW9wK/2RcUjHUnE+yIgmzL9CMG8BJnu6ZI?=
 =?us-ascii?Q?tGuKt+zw+ofr2Z3lpfzR0IpYbmOpDlnHgqqOde156gs/hNe30YZvU5DgjmA8?=
 =?us-ascii?Q?Sx48IpFrLMfKmH1FWWRtuumI0DcauBx9J/+bXs9ThpY0FeEjEgycYGHrv1Le?=
 =?us-ascii?Q?m3f30QYXTGWWVvawX5xd/0X9e7rMlc2la61Gr93dyu3Vi0PiFUprz9v23tHM?=
 =?us-ascii?Q?IhIIuMtvEORgelSaEKLf5f6mDLS3jfrbyqIwCkgbYqoYcnuynQl+ZsRSGiCl?=
 =?us-ascii?Q?icQeTjlxkoP8YJ1KL89Y846/4vUEolJ5vSVm99z/eD2D2mi4iiqHN9im/Rso?=
 =?us-ascii?Q?U76h+aUX0zvJThvbPFcTC8y9OUQu3+miurYguwP5Mv5IcLA8bNFG4gCQTfPF?=
 =?us-ascii?Q?aCM8YXThWDV3VCwA0G8H0o3X/mjI+xAp/RjTnffITp5qzG28uLHFchX22Vy7?=
 =?us-ascii?Q?ofaaB/TC82+ly+FV3XVXZZ48CyOL3OEpvk5C7USXxDEFt5HQe9bvioy3aSO9?=
 =?us-ascii?Q?KOZM7HsMKXdef/hP8tLoCi91ssLRfUwgVmdcd+VWIRgF0y/6ZTJCg1uoXO8P?=
 =?us-ascii?Q?2OYDpZbMj/u62BdNnSWQsGLhv/a27u9xEfRyVrx0aw4Ax517j5T8nodEzeWW?=
 =?us-ascii?Q?+hjQcjjoyP3DtY5eKwBF2723cZKgUtEJMEKl40igbkaTcb0TcrzfUw5Ufa35?=
 =?us-ascii?Q?q/Uk04UW?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?urB9ct87PEwGchapY9DaDt1213+iHvuOfDHWLUQ9Bk3KnvIVnGSwWP88MOdN?=
 =?us-ascii?Q?5WX5hYqqFZNebbR9guAbvzB6CxzGeLw+DCoWdeS7pG+aeS87WQMDFUMzCndT?=
 =?us-ascii?Q?5hnCia8V7GxloqrqBlWN9AjegQ98ynZNfno+bdDw3XXeGR90hPNZa/w7o6h5?=
 =?us-ascii?Q?YmMBENTBS8FHFeZXI3GTSBU5hhapnGHU7U5c0FszJx/EV3NyLKVjgm+4E1/v?=
 =?us-ascii?Q?KXXzibmVn+jeSrpcDx8jNvzEIiTi4cbSz7VXReLcs1+k/10welvDPqBa9jye?=
 =?us-ascii?Q?F1ALUFAkuCrEScYdqEj3FB93H+2hC9RELvKuNYNl69ubxQ3h7v22w81qi4CJ?=
 =?us-ascii?Q?UFN9hPYV4MLX9MQ/nQfCfo2R/HYdvM2e1TedEGO8dxlX3BvBXOCzqAytgOnV?=
 =?us-ascii?Q?tiCgUEYBDFZIw5fLmBRwUudGrr8q5SUkTs2sCNk3jgXsbzWHZggiDDdhqEkb?=
 =?us-ascii?Q?8pNeYb0ziTT1l3N3vzAOAF/Uip0OC/d4JmIIu+KKmLrxEgekRXtjh5kjHpRS?=
 =?us-ascii?Q?fKo1YV+Wv/lTXuLYJ9KEAwnnk2WGXhm/gF0NSSap7TGp5OjacSGX5DfpGTU8?=
 =?us-ascii?Q?KCYYei4kMsoeFJjfe9OTb8cmLPKZqxl3soFX0g11DBMC5M67JjEwmoNiQsMh?=
 =?us-ascii?Q?v6LhHYcWgS7SVDdt9+KEtrA0A6gr94/vgZkEW1oSqrpJWHSpu6GNcNAHFuLE?=
 =?us-ascii?Q?kXggAMFgQxrdYy8dlhdRaj235zvaNkFZ6qMC3+Jw4B9ip7XCU+tSzX08sShN?=
 =?us-ascii?Q?C3fepXpARnHUf6CRM0Auyj4ioJ2M+CR3BpAAjQDHKf80v/c/q08SzBP4SoSO?=
 =?us-ascii?Q?cbzIdoyol9WfYNrEZCUVGxvurs7RxwJSv0/8qNYMscclZ6gcFa3FDNji432t?=
 =?us-ascii?Q?0Y8Qqnt3O+5iZSAmZNgaEmJKqrONuTjV5Ee3JgrvudqIKpz4cawYqE10cuVm?=
 =?us-ascii?Q?mf7jMKhAeEzgzovwpcCDyR7PKc0lHeeWlvOIRgDxLRbCT6ibR91AhCOAnR1S?=
 =?us-ascii?Q?NBxYjTxgXF+IlE63wg8iuefzKhx4Frcel9rEybGwuHHEKlSs2vkmIZlRQIke?=
 =?us-ascii?Q?PRqqSWdTP6jrogCKKJy0YGecGYOfa8shl+TLw8e7bIunEzKU+U1B1QEJnVf1?=
 =?us-ascii?Q?WlJ78Qw/0oDh6QDcWm4aLU8uvtvKBNduqmaCKsrurRTiHWk6P1FAQg3eUpUD?=
 =?us-ascii?Q?MDqSRKMA2qsNQ+LUkd9jaD4TTvLQXwAc4+T/g88/0UbgvXtekz7o3Ws3SK0a?=
 =?us-ascii?Q?nZmmO9/EL9iXLNa+XCjJANVPEB+6Sk5fE9oJ0jk/1rdRXrcYfoWl1sd2BgUA?=
 =?us-ascii?Q?ogvaFM/i4/2VVYGPjQLSwm91zYCCta8HsaAmRac6vzbqO0fi5jGbC8OfaE4X?=
 =?us-ascii?Q?xKqTUuDM7JR348wKANZsRCglqKRz?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: f07df0a7-09be-47ce-6e22-08dee4070c07
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB7724.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 13:26:45.8972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR19MB8637

Add a bsts_unreliable flag to struct aw88399 that, when set, causes
the startup status check (aw_dev_check_sysst) to skip the BSTS
(boost startup finished) requirement.

On some hardware, the BSTS bit in the SYSST register (0x01, bit 9)
does not reliably assert even during normal audio playback. Register
inspection on affected Lenovo Legion hardware shows both amplifiers
reporting BSTS=0 on both channels despite clean audio output.

Per the AW88399 datasheet, BSTS indicates boost startup completion.
If BSTS never reliably sets to 1, the chip is never allowed to start
by aw_dev_check_sysst, regardless of whether the boot failure is genuine.

The new flag defaults to false via kzalloc, preserving the original check
behavior for all existing users. No existing code path sets this flag;
it will be set by the forthcoming HDA side codec property driver for
affected hardware.

Tested-by: Nadim Kobeissi <nadim@symbolic.software>
Tested-by: Xia Yun'an <imitoy@imitoy.top>
Tested-by: Munzir Taha <munzirtaha@gmail.com>
Signed-off-by: Marco Giunta <marco_giunta@outlook.it>
---
 include/sound/aw88399.h        |  1 +
 sound/soc/codecs/aw88399-lib.c | 13 +++++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/sound/aw88399.h b/include/sound/aw88399.h
index 3a2153f0ee92..dee91b540b81 100644
--- a/include/sound/aw88399.h
+++ b/include/sound/aw88399.h
@@ -598,6 +598,7 @@ struct aw88399 {
 	unsigned int crc_init_val;
 	unsigned int vcalb_init_val;
 	unsigned int dither_st;
+	bool bsts_unreliable;
 };
 
 int aw_dev_check_syspll(struct aw_device *aw_dev);
diff --git a/sound/soc/codecs/aw88399-lib.c b/sound/soc/codecs/aw88399-lib.c
index b525695c96d1..2045c4171be0 100644
--- a/sound/soc/codecs/aw88399-lib.c
+++ b/sound/soc/codecs/aw88399-lib.c
@@ -167,8 +167,9 @@ int aw_dev_check_syspll(struct aw_device *aw_dev)
 }
 EXPORT_SYMBOL_GPL(aw_dev_check_syspll);
 
-static int aw_dev_check_sysst(struct aw_device *aw_dev)
+static int aw_dev_check_sysst(struct aw88399 *aw88399)
 {
+	struct aw_device *aw_dev = aw88399->aw_pa;
 	unsigned int check_val;
 	unsigned int reg_val;
 	int ret, i;
@@ -182,6 +183,14 @@ static int aw_dev_check_sysst(struct aw_device *aw_dev)
 	else
 		check_val = AW88399_BIT_SYSST_SWS_CHECK;
 
+	/*
+	 * On some hardware the BSTS (boost-finished) status bit does not
+	 * reliably assert even when audio output is working normally.
+	 * Allow per-instance bypass when flagged by the side-codec driver.
+	 */
+	if (aw88399->bsts_unreliable)
+		check_val &= ~AW88399_BSTS_FINISHED_VALUE;
+
 	for (i = 0; i < AW88399_DEV_SYSST_CHECK_MAX; i++) {
 		ret = regmap_read(aw_dev->regmap, AW88399_SYSST_REG, &reg_val);
 		if (ret)
@@ -710,7 +719,7 @@ static int aw88399_dev_start(struct aw88399 *aw88399)
 	usleep_range(AW88399_1000_US, AW88399_1000_US + 50);
 
 	/* check i2s status */
-	ret = aw_dev_check_sysst(aw_dev);
+	ret = aw_dev_check_sysst(aw88399);
 	if (ret) {
 		dev_err(aw_dev->dev, "sysst check failed");
 		goto sysst_check_fail;
-- 
2.55.0

