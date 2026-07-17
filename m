Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazolkn19010019.outbound.protection.outlook.com [52.103.20.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4833FE37A;
	Fri, 17 Jul 2026 13:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784294810; cv=fail; b=rbIydf3G3Uf5LaJsfGZl6hV1CSs8h3LseGY/YAHkntN+XdgblnSNaFYdJG/2o08DxWMvxuLFGPLSK9xwaEoufDVdk/tfYzBqk2lPpP4klDcAizUy50HOwd5B8ARx2I5mS8Lcfr4MCOxIVaXSqwbx6e4ZW+4yHBhsAWePhyC+EyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784294810; c=relaxed/simple;
	bh=vHStzGQGpMxkAuBjM8FZNFDJnqGxtl/nslRF4LNYKKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eGc0wVXlgZTDqBT2TCNRKgtKmeW6h5Bnt8e5tRzhbSNH0SXa3IqnvbfI1vXPAXRvJUPeNESKgaAQNI0CoQ0oKYPSiqC7pYKk14fozi13hkisXWl1m278xg1GNunqvyaqgXE13ASJVEz+vOMTenAV0V7WHuf3igpf81Bxe1aAeBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.it; spf=pass smtp.mailfrom=outlook.it; dkim=pass (2048-bit key) header.d=OUTLOOK.IT header.i=@OUTLOOK.IT header.b=rje5WJa2; arc=fail smtp.client-ip=52.103.20.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=OUTLOOK.IT header.i=@OUTLOOK.IT header.b="rje5WJa2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BdM/RNHspZlkADM+yKJUCJ1Mwu/U6Tr8iDDTK1HyDLhYxrrRpDm73fD7qLh0WUijEPxp02Mg87tI4rANATiDr+Tq/43YOx19BiE4fBQbmUt8mniibe5QqXGPUNMGvaqQHkDkxOADiwGbomrBMHOj/gyG29zZ8nmI8F+aBkc608W1WS4QQ0GdLmOlgzqo/ieD5cQkHdd9ke++UFFrkBlCL+qEFUrQQrPBPrVsgvfA+KdD4rXJCZyGUhK0FGRHeCY+C5F7gvSdU80yorYnRmoe79eJl+F4bHk9rf7mrGlbsLqmm5m4ZNN+zfTzf/Sy91yaxJmI2e6wjJAkZH8AsMtKRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xYa0Nhw7DpvbAnPJXe77IBH+2BeXZP295+j6C2jL6Uw=;
 b=AH2Q4lcTU6R2KhQ0TSHJbzMNV3JVHuDQv5CTXVtAtozli4NweV05gB09CuiBNdP9ejFiORUg3MPK2RhACd3d5KX1q+r9SxEnSTXBmrRsyT9Mv8lbdUbtjn2MLfmbobh2ZWZK/HiUGqsQ4uWbjqutAMVLap9Pr+lsxHDvaPFnrfl2nYVXeBbg7Zw+TeE0h/VdKMR6Argb2WH8y1pdw7dESSPb5Q5iCoX9wW2k3hQVWcXAgceTac6+sOWmXuCrqTs1V5UGdKd5AFCrglqGkG0YWhINPUeYIUnryXDESJ6GKffQ8F/utfKiKNF6iDLR0vhD5OScUfNSCx6m+iluf/mBjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.IT;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xYa0Nhw7DpvbAnPJXe77IBH+2BeXZP295+j6C2jL6Uw=;
 b=rje5WJa2ZASitYgFoxaUFuClXCf3MaacMEH64RnwN7XBIIAl82lXtnrRZTuFEHLr9nZGo3N9v0y0Jwbqc2iV/oOjlj3uhwO9HxAECSHd/uVBp9WS8kPjk1jYO1XAXV2vect41iEzy8XQ1iNr/luy7DCTAklCpp9lqYRtO8B2pHuhllonK+HezupfLKbg/vLljP62ThTepGQPP7gl2pz8oab6LRueNJwEe26T+Mdn+pk9wKS1S6EmWPOf1MHVPZWMMDCvSAUrLjUmEVTT0Rh+M0SM/zzlOo4BqLrevtAEHGKJ/HgqF+pYt1CzEzCHW2DF4ZoPTWDIWSV3amZsIKheCA==
Received: from DS7PR19MB7724.namprd19.prod.outlook.com (2603:10b6:8:d9::20) by
 IA3PR19MB8637.namprd19.prod.outlook.com (2603:10b6:208:526::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 13:26:41 +0000
Received: from DS7PR19MB7724.namprd19.prod.outlook.com
 ([fe80::70de:3c05:ac62:7f86]) by DS7PR19MB7724.namprd19.prod.outlook.com
 ([fe80::70de:3c05:ac62:7f86%5]) with mapi id 15.21.0223.012; Fri, 17 Jul 2026
 13:26:41 +0000
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
Subject: [PATCH 2/8] ASoC: aw88399: derive channel from I2C address on ACPI systems
Date: Fri, 17 Jul 2026 15:25:04 +0200
Message-ID:
 <DS7PR19MB772468BB9F4D6925DC4E8E3EFCC62@DS7PR19MB7724.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <DS7PR19MB77247D9AD698CF0FF37DB58BFCC62@DS7PR19MB7724.namprd19.prod.outlook.com>
References: <DS7PR19MB77247D9AD698CF0FF37DB58BFCC62@DS7PR19MB7724.namprd19.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0013.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::18) To DS7PR19MB7724.namprd19.prod.outlook.com
 (2603:10b6:8:d9::20)
X-Microsoft-Original-Message-ID:
 <20260717132509.148321-4-marco_giunta@outlook.it>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB7724:EE_|IA3PR19MB8637:EE_
X-MS-Office365-Filtering-Correlation-Id: f077a153-c7b0-4f93-7863-08dee407097d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|5040399003|5072599009|51005399006|19110799012|8060799015|41001999006|15080799012|24021099003|16051099003|3412199025|440099028|40105399003|3430499035|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C5pKBRu20D1/5H0FYeJSa0301GM76FhuX5HB5LeZhOhJuq8mx7MKcb2ETwiM?=
 =?us-ascii?Q?3Hx0Kxvs13ELeNd+joSudHvU49ys6x9AyH0FuJU0gguSCVeNhv4mljSroU/+?=
 =?us-ascii?Q?U2x6gQJLtZn4bkVM7Hz63rCFGgSMc0HfkRx6/EgruD4208vvo6eTaXutx/fH?=
 =?us-ascii?Q?X2RleDIKPJL8Jo1uh6b9T3ImANrPAiekVmUh4sl0pNRr7rhgheVUpMiz/N9b?=
 =?us-ascii?Q?Bb7JEt6YMp/U+asLDCgMDV4mHRckw0kuTvRaARD3lGjHyLLX08k4P4JAQuiu?=
 =?us-ascii?Q?tbCLLptEldD5rhW5AOFYHSAa8vgEyJ+tv0C6R9IT77ohpR0ZEoCkQPJVRLqV?=
 =?us-ascii?Q?IlpOf9hphK/7flbOE5bpi0JtcPPlxMBYf9g+vc35WWfA4o6Blmd6Weqkdjqh?=
 =?us-ascii?Q?tghYDGBiP6IbQHdza5evwSp+60xmrvZnxquzeO09Ni+o/+KzyITX6AS/ci+p?=
 =?us-ascii?Q?oG84hl2uvkdwfzM10ixjiRU+R8M8gdtGk0OIIrZNrJ7D2Vb0JABWBmkKMf9+?=
 =?us-ascii?Q?9rU+v8NmcrYuyD7dd3xfxTFSxfSmFFoN6SiZKn3pidGAjJA3MSdws/ZEA2Bz?=
 =?us-ascii?Q?ehwST+XF24uQmbh2yFizYTrkDA3XKxfyDClbXj4xjL/Of8QdlvQRdsfV3VIA?=
 =?us-ascii?Q?UQ0CX/HFj9j7r5RDW5efUk2CjryRbjZZZKLzn6iP7mexyE/v23ETlWj9fymx?=
 =?us-ascii?Q?V8LWgv9f9ybK7gfhnrY6oJl5kOLjtMx9h6p/bwi0KuT2X49bvfZfq+WeQ22p?=
 =?us-ascii?Q?3T+QuYdGegs+aK9oggeRwq0sz5BzLfwFUUXNOc0OWBFPzqDW3RE54m+pphxy?=
 =?us-ascii?Q?WFCrIoFmsgcq4YHaAp+NUcN/Hy3HEiHuXojbtH6T12+eeJGZxVQ3mfUp3rAs?=
 =?us-ascii?Q?UFJFA5O6eHSndfFg5TplEhgnjRTCcYOwyD6j17iRxs+h3YyF03ZYqotIIVZk?=
 =?us-ascii?Q?1YI6K8TITWAxbDVUN8jXisvjLN+VmD4xbDi4dk6qR0JTcxTRA+WfSf3qbqR3?=
 =?us-ascii?Q?doEQJ40hErg9tcHlqeRqZxv5RQ=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ja86yqqcHetzr+om6F7EYBz3sNqwUNhYccQnjB72JKwgXq9++Tz5TC2La8P0?=
 =?us-ascii?Q?Lo2HcMbt6nOy4x3F/b8t9pqcFRJDSankgNNSNhsirrgCWbRsMgUkANe68uFL?=
 =?us-ascii?Q?ZKUtvyvPuDwhyXBmjWqtlwfZ35NRNjNv+Je0cYEG2b93IZTKyIIUJX1Lg0eQ?=
 =?us-ascii?Q?8hl4BLggSzW2bCSgMHkCCikDNFaQGFfxgoAPJjpMWwTOJUaKsV44/14qtblh?=
 =?us-ascii?Q?aH8W7/fqa1KRXyeXov29t8v/ceHlakpqOAnE4FG4boNuQenUjKLhbSA/tupm?=
 =?us-ascii?Q?CBFNYL0M/CR+sDmKJRUT08gMID+a+RLoN0Dxb+Yjz81gtaCrqFbmjy1vPJZP?=
 =?us-ascii?Q?DNRulYlesA+3oOlHCbByFWjOfDE2i5cgElEEi0z1X+2WMbd9EycAboOpPqvJ?=
 =?us-ascii?Q?rZSe8Wr2NLXueNhzmeh9aVKe+T9ZHUUP+/7grb5KdMm+zG6qI5iXwm8fUuHf?=
 =?us-ascii?Q?gY9sL1GUQbrp87xj8KJCec/btWpfGCdGX5dNaZ8+FGUQJ66a52DEI7xzjcK0?=
 =?us-ascii?Q?SoOLPtWz1/fMUHvWaV+iDj9dv2+1kVB9H+hEFr9B1l+IH0O9q/fbFY/AUOCD?=
 =?us-ascii?Q?tJWpQrU4rI2N1jLWne1BcFQCxWr3o1kth0RAWYIpF7yKIv0inNAt0B7Mb8mp?=
 =?us-ascii?Q?46MeQzN3ZMCYWiHB3OI1Y0J6aMj29WUSU/R7mTodYudNnNWvsYWH3L1bDwOr?=
 =?us-ascii?Q?QiddUl6Gp48saPlfMR+u0o5WMGHOBUmIjvx7fhzbt1TR15yAIUWXmwphV8G0?=
 =?us-ascii?Q?slg7e2XiskCk+xUcV5uNJJ7eMqeUNUx9+1TPUb279okIO9XoJqgLzq/lMwF2?=
 =?us-ascii?Q?Y8zL9yjr39MKduAjkyAO4E1IBAiZdh9g6r7YcGm9yu/j3yHiY5LTi7ewqazC?=
 =?us-ascii?Q?er07/9rrEPzLkomxaufsQqiP0fVRbkFHo5Cauh+cjReE3CiBtqRCurnXvhLl?=
 =?us-ascii?Q?1HxYY0jk6IZuIbgvhgpQipVpcxYmiKOjkc66tbYRoPiAjQNIeLCAGiqhwduR?=
 =?us-ascii?Q?SSFbIo1J11PIiIe/Goz4w+CiOy2t9qIBI3ykRRHL9SFyemKulxMhuIalxb7D?=
 =?us-ascii?Q?wH4JgUG0HaBBKWovbuxDauRz+NrrknpNhDGnugwUTctL4KbXHVsRLnGSIFBQ?=
 =?us-ascii?Q?fYQy8yV1Lorf2D/S4tjmYjGJXrSXDiyXaWzvlKnfj9K7ufU9bWVrAXed/K2S?=
 =?us-ascii?Q?AS44l9i9nB1EiDgmHGPifiPlFYeI66H5ReQXBfwfoFiJtktYC6pBY22dFC9w?=
 =?us-ascii?Q?NnG6ZxFJDt0rW5faG544iUpG6T7MWGEjEQQhThQakBkRqQvDk+hd6Ys5owBc?=
 =?us-ascii?Q?OFHCPDfGwv76qMu+tVImLGYDFbW45qEAXPqzY5dIgNPrHjM9BwgKHP+BwXC6?=
 =?us-ascii?Q?9eGBtKrmwi965+JTm915YcA/u2be?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: f077a153-c7b0-4f93-7863-08dee407097d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB7724.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 13:26:41.1909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR19MB8637

Extend aw88399_parse_channel_dt to derive the audio channel from the
I2C address when the Device Tree property "awinic,audio-channel" is
absent.

The original code calls of_property_read_u32 without checking the
return value. On ACPI systems, the DT property is never present,
and channel_value is used uninitialized in the assignment to
aw_dev->channel.

Add a fallback that computes the channel as (i2c_addr - 0x34), where
0x34 is the AW88399's base I2C address per the datasheet (valid range
0x34-0x37). This channel assignment may be subsequently overridden by
the HDA side codec's property driver on systems that require it.

No change on Device Tree systems where the property is present.

Tested-by: Nadim Kobeissi <nadim@symbolic.software>
Tested-by: Xia Yun'an <imitoy@imitoy.top>
Tested-by: Munzir Taha <munzirtaha@gmail.com>
Co-developed-by: Yakov Till <yakov.till@gmail.com>
Signed-off-by: Yakov Till <yakov.till@gmail.com>
Signed-off-by: Marco Giunta <marco_giunta@outlook.it>
---
 sound/soc/codecs/aw88399-lib.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/aw88399-lib.c b/sound/soc/codecs/aw88399-lib.c
index 258d6efbf590..b525695c96d1 100644
--- a/sound/soc/codecs/aw88399-lib.c
+++ b/sound/soc/codecs/aw88399-lib.c
@@ -1328,8 +1328,20 @@ static void aw88399_parse_channel_dt(struct aw_device *aw_dev)
 {
 	struct device_node *np = aw_dev->dev->of_node;
 	u32 channel_value;
+	int ret;
 
-	of_property_read_u32(np, "awinic,audio-channel", &channel_value);
+	ret = of_property_read_u32(np, "awinic,audio-channel", &channel_value);
+	if (ret) {
+		/*
+		 * On ACPI systems, DT properties don't exist. Derive channel
+		 * from I2C address: 0x34 -> channel 0 (left), 0x35 -> channel 1 (right)
+		 */
+		aw_dev->channel = aw_dev->i2c->addr - 0x34;
+		dev_dbg(aw_dev->dev,
+			"DT channel property not found, using I2C address-based channel %d (addr 0x%02x)\n",
+			aw_dev->channel, aw_dev->i2c->addr);
+		return;
+	}
 	aw_dev->channel = channel_value;
 }
 
-- 
2.55.0

