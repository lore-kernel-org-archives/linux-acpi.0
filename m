Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazolkn19010021.outbound.protection.outlook.com [52.103.20.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEA7446BF5;
	Wed, 29 Jul 2026 09:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785317641; cv=fail; b=pm0o1F86herekr99UOuVTUzgbgWAseyyf1wm1AvjFxU3KVFkFqKDvQKbs1rqTu3BtcfZgI5FtpyvJG6arw3KeLWdkuWUJQMzMTjg03MJhpxto12z7EpTarHtChjY5EA3+KFNRXB1lX+EOjuNO08gcGKGfbvAvoCxHczFzn0crVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785317641; c=relaxed/simple;
	bh=9H01Q8eJ6xV8OuixAB1FKM2DdVGw1F7yEKH35icfE6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t+h03xa/6gA1YRoDCm/JsvrJajU2vXd141tq6Pad86Z9v3l3rwzezCfoFp8dDyjbe05TW1WhnCyDwpjCTNpenCRgeVXK8tPLIMnBUXUyhmCynNZkfiJ9gTyJxwe0iQItHjml2EorRZf20qKNEPQPFkm72syYgAvds6+WT52fbHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.it; spf=pass smtp.mailfrom=outlook.it; dkim=pass (2048-bit key) header.d=OUTLOOK.IT header.i=@OUTLOOK.IT header.b=dMJ0yXaN; arc=fail smtp.client-ip=52.103.20.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=OUTLOOK.IT header.i=@OUTLOOK.IT header.b="dMJ0yXaN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t/7YBBc1fcCrn3uOWjyasTIfS9STfdssvzq0ID+2JwPXLRwjyO8fcN2f9UIgKKmlhw0duvgtnVBasAUaIGtIRISnGaQXIDiZX7LMSAbtDv5l2GvagBoeveseYlP2p8xdvM/oIRpXWI440vC0SxfTjNFbrTH9p67Yt/gSavdrCfx2ieWrmftFxY+sSAGU1cRPoqzO02L/w0U6fIQX2tqzRL/TsDztOhrt4pX9E5VXNszjOseBjAPCM2+26w0aoZlv41LCC4JzpmZ0Wa/S6Y0D7OqCjD9dndSMivn4s0GlywNB9LsXUHC6AqzctT1uVZZJEfaFGQvhWhQV333Okdl/Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rPrt2u1Lbi8OEHscmjB+u53OKcI3rfLN2qiA2ziaMCQ=;
 b=DRCF45N+5gjx7SyLcPP1vDfrc27iF3rwlZMGtltISPfi72bcIt3lkuQWKxqHNfKip+7ThbTWHeyWxmVF1ncMakPoB6navw7yy7ytScso8OIR/Xzs5icDeaRmaAW+F7lAAhVnbuanh02AGdIKo0yyrZLNGe270IASs5UHXACkJGqUI9XLMC81Lwz6usnFK5r4Sj7v5xnbZ2CNrAs7HS0ciwksIoJF8Ag/5uvLyw/mpgD20EM7KKW6C05XIn2vUiiXPSkIh34JfDBIESDvGASETKAsm+iHRODizgAOEoEubgLxmCgJKY7G3ES9RgbGJdK5/xnCO/g2gndXOrGZ0TVw9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.IT;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPrt2u1Lbi8OEHscmjB+u53OKcI3rfLN2qiA2ziaMCQ=;
 b=dMJ0yXaN+2r0w3uzz2ucUXF86NQjrYtPfByBOHRaSfAuzr7iJAVdl7uyvlwXRneSzCMX31a6B+pdiu6mWLhkLkPAScCxBlmzonmuRS8O4llMaRLeRwxAxv/UkkDTPmA9kr/DpBCVxKQUvJwPoIHsPMOCNKgbsKZznTQ7hArUT7plQtrwliONAOSNzKd6O4feZriGNDGbMMWkpNVAe9Accd40NK27GzcE26OQBCEvMHN8W9yGiu3r3PMEnS6XTh7SVHpTj2eFEeqFIzp1m+tGyh1zu2EWc6thoRWN6yI4pa0vzzOt5U764zYzni4ExqYfK2Se8VHUgVQNTu6ZR6Geig==
Received: from DS7PR19MB7724.namprd19.prod.outlook.com (2603:10b6:8:d9::20) by
 DSVPR19MB997523.namprd19.prod.outlook.com (2603:10b6:8:3be::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.13; Wed, 29 Jul
 2026 09:33:57 +0000
Received: from DS7PR19MB7724.namprd19.prod.outlook.com
 ([fe80::70de:3c05:ac62:7f86]) by DS7PR19MB7724.namprd19.prod.outlook.com
 ([fe80::70de:3c05:ac62:7f86%5]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 09:33:57 +0000
From: Marco Giunta <marco_giunta@outlook.it>
To: Takashi Iwai <tiwai@suse.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-acpi@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Weidong Wang <wangweidong.a@awinic.com>,
	Nadim Kobeissi <nadim@symbolic.software>,
	Xia Yun'an <imitoy@imitoy.top>,
	Munzir Taha <munzirtaha@gmail.com>,
	Yakov Till <yakov.till@gmail.com>,
	Marco Giunta <marco_giunta@outlook.it>
Subject: [PATCH v2 3/3] ALSA: hda/realtek: enable AW88399 on Lenovo Legion Pro
Date: Wed, 29 Jul 2026 11:33:15 +0200
Message-ID:
 <DS7PR19MB7724ACD7C8D1BE71451E1AEEFCCA2@DS7PR19MB7724.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <DS7PR19MB7724AB9AA5096BF2F00014B0FCCA2@DS7PR19MB7724.namprd19.prod.outlook.com>
References: <DS7PR19MB7724AB9AA5096BF2F00014B0FCCA2@DS7PR19MB7724.namprd19.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0029.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::15) To DS7PR19MB7724.namprd19.prod.outlook.com
 (2603:10b6:8:d9::20)
X-Microsoft-Original-Message-ID:
 <20260729093315.20897-4-marco_giunta@outlook.it>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB7724:EE_|DSVPR19MB997523:EE_
X-MS-Office365-Filtering-Correlation-Id: 398a1fc7-604d-4908-8429-08deed548381
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|16051099003|25010399006|55001999006|24021099003|5072599009|51005399006|8060799015|12121999013|23021999003|19110799012|41001999006|3412199025|440099028|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u0HXBTwbQd4RaqZaiNF3d/f1tXe+Rx146Vzr8UzUBHrjCrLxFSmBPvJ17S9g?=
 =?us-ascii?Q?guOCGK6S9RDaVMpDVWP2TtarnuNK647SMoekZ7fwcAE3c950yvTtqSHw1KIU?=
 =?us-ascii?Q?rN5mHND8BhwAUBXBgEoNL6Ab7TkdWl9u1bOxCVNG3MA0ol9NzNLdNvDlqCdD?=
 =?us-ascii?Q?yzFrgWTx06J7Au31J7+wnRlUmmQsTgt+1XTPIASlgMf9/rAV4TRHiobQ4RmH?=
 =?us-ascii?Q?4wfrQXgoBGDJC0ajOtyfq9Te+G5QAVqAMDziJV7VBzhQBEkrToIO5Fwz0kwf?=
 =?us-ascii?Q?KxSnrk5+0FATqbnRFRpOy6oqpaUqCTXN7QVamn93jn4jvWFYkhE7WRlej4sO?=
 =?us-ascii?Q?DdSkms2o4q9AGozvtRZ91wTfS2JDcdVXhMo4eLRReKZ3NlHFk7tpMjPrvu47?=
 =?us-ascii?Q?9uw+nfxSTXWtSv5KiRnQ9BXN4eOmDVNESqCngo5EfMwZfpM3E3u15kTZfdmT?=
 =?us-ascii?Q?cAg4jNJUOTmW06W/9II/PCHOyziqBpj3ELthNJOKKiKGhh8s1l+au0T2BMRO?=
 =?us-ascii?Q?6vmWudwjEiZxZADf9gt8Z5oatRkbwJbU9P4x+0TMfk+SfuHs36d6Ui9aQOxn?=
 =?us-ascii?Q?TpGu1KX9QMBKClyZBzqtgGnLS14/AAbemdk9aMi/yiXzo1zQqTRNJQeZu1Oz?=
 =?us-ascii?Q?HAyZuT7MyCDfz2sCUnvWZfzL+mVQZyAbmDHxmX7VACjOQyiF8cWjEtmL4K0f?=
 =?us-ascii?Q?Q2/lsBNFsuRzejUFNNbiOi3hGHBra6EHVj6oaeGlBNhH+yhv3YTMhpSYEizb?=
 =?us-ascii?Q?u2F22hxHPtWXUVufgR03EQ5pTQ6q3dUu+utjh2xFWlLBcrWyib02rgSS5Rza?=
 =?us-ascii?Q?Yxd7y7+uJFblkik9Z/AQMpSBy+UaAfIya8V0lEXN6ioLjhWJuIRifcc/KC7w?=
 =?us-ascii?Q?vd/AP2PGzNryYmOEZ3uumb66t4b7LjoUM3NAzyVOUF69oIuBbMfATzhY2NCY?=
 =?us-ascii?Q?Zu95YtyuBoOq9S22aVykMWhPL9us2owl8dk65kwDCdfk3QotaHz1WpU8C/jL?=
 =?us-ascii?Q?nhYeMpgDcWk/lcLgsiC+rYyFmA0narKny0+6e+WQNkhQ5UoLvVeQbeHO3meN?=
 =?us-ascii?Q?dhFntIoyCB6aCDLuMzMak97XIYREzQ=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uXWMNtNhptOytrQPOKNAFSc2kKxQq//fKPylQbS/QGnB6qyiI9mp6broSM/L?=
 =?us-ascii?Q?3t46msUC8xdz6iqCmDS7VV6DuF/o7gmr1tqf8+ihDmNiItYACTG36Acyx43e?=
 =?us-ascii?Q?yjmDjJ/y1amw3u8N5sX2HpSLvJs79CMaG/o+fG/CxIda5OV0UrtxR1YmpH1D?=
 =?us-ascii?Q?D6Q2sJHvNI3MCMhZIdaShwe3NHRqAtwZAV3BEIChEFMXdxxrVdqH1vu2BExc?=
 =?us-ascii?Q?w4P+uMBBGG/qmuhU7z39I/o+EdjatVj7GW14L3LxcgwrqQVOkowIPFRqVyjS?=
 =?us-ascii?Q?ByJWiR755lAQJ+enU452lpgDirN61HOBZoZIeXzJkQzGRtXdrqq7VSeONLXg?=
 =?us-ascii?Q?YQdGyKXonnt0Vimqc5BWN/5TrGb/g595E840b7kE9jjSH6n9mSC8QReZw3DY?=
 =?us-ascii?Q?bfUvxytfppoa3rFWDNpjweeVU0Xdec3TYjcuff20SY5Sujp5Ypse/tdissSU?=
 =?us-ascii?Q?bKwvcgbnQA6tpPk5zUJ7an3C5y0yWy075AHZ/8PpJILHkO/8v12023uXBi/I?=
 =?us-ascii?Q?cpyQTx7IIpuaUjBjruUJt9lKugKdaelUs1a0QnJooNp7QZG7qjbZ2Ntr4Ix8?=
 =?us-ascii?Q?Fc78cTxSFVDz8MdrNK88IvyjQvOqrJA3AFKmFyyYVd8XAFYCNmq5858Xd/DL?=
 =?us-ascii?Q?32EXtx45yyS/UlvN86uchOTwYjcDMkCpWCfFcGvtzj2w/d5Jz9suO0Wx1FEb?=
 =?us-ascii?Q?eHPE+WwybOoWomjZZZuzdidJQmV735+w+ta7/h33IfNPD+41BYyW62p9kXus?=
 =?us-ascii?Q?BGZmXuuu/y5h6IbbJV3EfCLCGaE7ppvNXdRXiJgCOS1ZMNH7jBQyrPN49RHr?=
 =?us-ascii?Q?xUS+k6w7Z66uj0TB6ZKxn5FFdo+UobuRnQ5uLAkfQPuZsQ35lEXojzDsDklb?=
 =?us-ascii?Q?taLuYxlgJJGylQM+U+z8iEnQngYVzGNdxzVbhognCzuVZN3Xjqz8rt4NVeyf?=
 =?us-ascii?Q?8ngh8ExVusBvQ36Z/9gx8yQm/GZ3in8SUuEfNoeFnhds9LEER3AyvaxbCIsr?=
 =?us-ascii?Q?T6biCUe9Rj1w2AfS/4AWzFLdXUgyEj4+tc80aDefSMqVgnWw+s/s8AfwYNvH?=
 =?us-ascii?Q?OD+NtWWfkv0o767vBBIhPHpfHihDZkRfRYYB3CCH9tT21rDz0GnOAhkP/KeY?=
 =?us-ascii?Q?6cN/+YKdhCzux8tWnxO2Mt6/fJV0/tep12O9Q4GbiF0ZwYdzkR6EpuA+FfAC?=
 =?us-ascii?Q?Y3ikzh4d9MEhs3s5yHHK5/ImidBeYgcqCTojyXek19mjOzd4E+ICUM1++hUI?=
 =?us-ascii?Q?QziRGXizigwiQimOjV/zZ5Jdd832qsm7VVP/26MvCV1JzyG8X0+l9mtr/d28?=
 =?us-ascii?Q?2wPs0TZ7EvG0PgTuuwnd00zpVqpl/LX5bkywcLVE3f78lSz55qzXsaxLbdp+?=
 =?us-ascii?Q?FCYl/zOPmCbP9yW3GshXQuH4vdPyb9TxPlThep/BwbF7nraRMEcyW/o81GmD?=
 =?us-ascii?Q?hGv6Roj7+0w=3D?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 398a1fc7-604d-4908-8429-08deed548381
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB7724.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 09:33:57.7074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR19MB997523

Enable audio output through the AW88399 woofer amplifiers on Lenovo
Legion laptops by adding the necessary Realtek ALC287 fixups and
AW88399 per-model quirks.

Realtek fixups (alc269.c):

* ALC287_FIXUP_AW88399_I2C_2: registers the AW88399 as a two-instance
  I2C companion codec using comp_generic_fixup, matching ACPI HID
  "AWDZ8399".

* ALC287_FIXUP_LENOVO_LEGION_AW88399: forces DAC 0x02 for the bass
  speaker pin 0x17, as the default DAC 0x06 lacks volume controls.
  Also applies internal microphone boost calibration via
  alc269_fixup_limit_int_mic_boost and disables unused pin 0x1d
  to match the Windows driver's pin configuration.
  Chained to ALC287_FIXUP_AW88399_I2C_2.

Per-model quirks (aw88399_hda.c):

* Channel swap: the I2C wiring on these Legion models is reversed
  (0x34 is physically the right speaker, 0x35 is the left). The
  quirk swaps the channel assignment to correct L/R audio.

* BSTS status bypass: the AW88399's boost-finished status bit (BSTS,
  SYSST register bit 9) does not reliably assert on this hardware.
  Register dumps during normal playback show both amplifiers
  reporting BSTS=0 on both channels despite clean audio output.
  The quirk sets the bsts_unreliable flag, introduced in
  commit b4530a3e4895 ("ASoC: aw88399: add per-instance BSTS status bypass flag"),
  so the startup status check skips the BSTS requirement
  on these devices.

The R9000P ADR10 entries use HDA_CODEC_QUIRK and are placed before
the existing SND_PCI_QUIRK for 17aa:38bb (Yoga S780-14.5 Air) to
ensure the codec SSID match takes priority over the shared PCI SSID,
following the pattern established by e.g.
commit 0f3a822ae225 ("ALSA: hda/realtek: Fix quirk matching for Legion Pro 7"),
commit dd074f04e046 ("ALSA: hda/realtek: Fix Legion 7 16ITHG6 speaker amp binding").
All other entries also use HDA_CODEC_QUIRK for consistency.

Supported models (Lenovo vendor ID 0x17aa):

* 0x3906: Legion Pro 7i 16IAX10H / Y9000P IAX10 (Intel)
* 0x3907: Legion Pro 7i 16IAX10H / Y9000P IAX10 (Intel)
* 0x3927: Legion R9000P ADR10 (AMD)
* 0x3928: Legion R9000P ADR10 (AMD)
* 0x3938: Legion Pro 7 16AFR10H (AMD)
* 0x3939: Legion Pro 7 16AFR10H (AMD)

Tested-by: Nadim Kobeissi <nadim@symbolic.software>
Tested-by: Xia Yun'an <imitoy@imitoy.top>
Tested-by: Munzir Taha <munzirtaha@gmail.com>
Co-developed-by: Yakov Till <yakov.till@gmail.com>
Signed-off-by: Yakov Till <yakov.till@gmail.com>
Signed-off-by: Marco Giunta <marco_giunta@outlook.it>
---
 sound/hda/codecs/realtek/alc269.c          | 50 ++++++++++++++++++++++
 sound/hda/codecs/side-codecs/aw88399_hda.c | 42 ++++++++++++++++++
 2 files changed, 92 insertions(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 6b3c1d529bd1..6384620a2062 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -3262,6 +3262,34 @@ static void find_cirrus_companion_amps(struct hda_codec *cdc)
 	comp_generic_fixup(cdc, HDA_FIXUP_ACT_PRE_PROBE, bus, acpi_ids[i].hid, match, count);
 }
 
+static void aw88399_fixup_i2c_two(struct hda_codec *cdc, const struct hda_fixup *fix, int action)
+{
+	comp_generic_fixup(cdc, action, "i2c", "AWDZ8399", "-%s:00-aw88399-hda.%d", 2);
+}
+
+static void alc287_fixup_legion_16iax10h_aw88399(struct hda_codec *codec,
+						 const struct hda_fixup *fix, int action)
+{
+	static const struct hda_pintbl pincfgs[] = {
+		{ 0x1d, 0x411111f0 }, /* unused bogus pin */
+		{ }
+	};
+
+	/*
+	 * Force DAC 0x02 for the bass speaker 0x17, as the default 0x06 lacks volume controls.
+	 */
+	static const hda_nid_t conn[] = { 0x02 };
+
+	alc269_fixup_limit_int_mic_boost(codec, fix, action);
+
+	switch (action) {
+	case HDA_FIXUP_ACT_PRE_PROBE:
+		snd_hda_apply_pincfgs(codec, pincfgs);
+		snd_hda_override_conn_list(codec, 0x17, ARRAY_SIZE(conn), conn);
+		break;
+	}
+}
+
 static void cs35l41_fixup_i2c_two(struct hda_codec *cdc, const struct hda_fixup *fix, int action)
 {
 	comp_generic_fixup(cdc, action, "i2c", "CSC3551", "-%s:00-cs35l41-hda.%d", 2);
@@ -4231,6 +4259,8 @@ enum {
 	ALC236_FIXUP_DELL_HP_POP_NOISE,
 	ALC274_FIXUP_HP_89E9_GPIO,
 	ALC274_FIXUP_HP_VERBS,
+	ALC287_FIXUP_AW88399_I2C_2,
+	ALC287_FIXUP_LENOVO_LEGION_AW88399,
 };
 
 /* A special fixup for Lenovo C940 and Yoga Duet 7;
@@ -6917,6 +6947,16 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC274_FIXUP_HP_89E9_GPIO,
 	},
+	[ALC287_FIXUP_AW88399_I2C_2] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = aw88399_fixup_i2c_two,
+	},
+	[ALC287_FIXUP_LENOVO_LEGION_AW88399] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc287_fixup_legion_16iax10h_aw88399,
+		.chained = true,
+		.chain_id = ALC287_FIXUP_AW88399_I2C_2,
+	},
 };
 
 static const struct hda_quirk alc269_fixup_tbl[] = {
@@ -7975,6 +8015,11 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x38b8, "Yoga S780-14.5 proX AMD YC Dual", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x38b9, "Yoga S780-14.5 proX AMD LX Dual", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x38ba, "Yoga S780-14.5 Air AMD quad YC", ALC287_FIXUP_TAS2781_I2C),
+	/* Legion R9000P ADR10 shares PCI SSID 17aa:38bb with Yoga S780-14.5 Air AMD quad AAC;
+	 * use codec SSID to distinguish them
+	 */
+	HDA_CODEC_QUIRK(0x17aa, 0x3927, "Legion R9000P ADR10", ALC287_FIXUP_LENOVO_LEGION_AW88399),
+	HDA_CODEC_QUIRK(0x17aa, 0x3928, "Legion R9000P ADR10", ALC287_FIXUP_LENOVO_LEGION_AW88399),
 	SND_PCI_QUIRK(0x17aa, 0x38bb, "Yoga S780-14.5 Air AMD quad AAC", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x38be, "Yoga S980-14.5 proX YC Dual", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x38bf, "Yoga S980-14.5 proX LX Dual", ALC287_FIXUP_TAS2781_I2C),
@@ -8002,6 +8047,8 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x38fc, "Lenovo Yoga Pro 7 15ASH11", ALC287_FIXUP_LENOVO_YOGA_PRO7),
 	SND_PCI_QUIRK(0x17aa, 0x38fd, "ThinkBook plus Gen5 Hybrid", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x3902, "Lenovo E50-80", ALC269_FIXUP_DMIC_THINKPAD_ACPI),
+	HDA_CODEC_QUIRK(0x17aa, 0x3906, "Legion Pro 7i 16IAX10H / Y9000P IAX10", ALC287_FIXUP_LENOVO_LEGION_AW88399),
+	HDA_CODEC_QUIRK(0x17aa, 0x3907, "Legion Pro 7i 16IAX10H / Y9000P IAX10", ALC287_FIXUP_LENOVO_LEGION_AW88399),
 	SND_PCI_QUIRK(0x17aa, 0x390d, "Lenovo Yoga Pro 7 14ASP10", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x3911, "Lenovo Yoga Pro 7 14IAH10", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x3912, "Lenovo Xiaoxin 14 GT", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
@@ -8011,6 +8058,8 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x3920, "Yoga S990-16 pro Quad VECO Quad", ALC287_FIXUP_TXNW2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x3929, "Thinkbook 13x Gen 5", ALC287_FIXUP_MG_RTKC_CSAMP_CS35L41_I2C_THINKPAD),
 	SND_PCI_QUIRK(0x17aa, 0x392b, "Thinkbook 13x Gen 5", ALC287_FIXUP_MG_RTKC_CSAMP_CS35L41_I2C_THINKPAD),
+	HDA_CODEC_QUIRK(0x17aa, 0x3938, "Legion Pro 7 16AFR10H", ALC287_FIXUP_LENOVO_LEGION_AW88399),
+	HDA_CODEC_QUIRK(0x17aa, 0x3939, "Legion Pro 7 16AFR10H", ALC287_FIXUP_LENOVO_LEGION_AW88399),
 	HDA_CODEC_QUIRK(0x17aa, 0x394c, "Lenovo Yoga Slim 7 14AGP11", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x3977, "IdeaPad S210", ALC283_FIXUP_INT_MIC),
 	SND_PCI_QUIRK(0x17aa, 0x3978, "Lenovo B50-70", ALC269_FIXUP_DMIC_THINKPAD_ACPI),
@@ -8314,6 +8363,7 @@ static const struct hda_model_fixup alc269_fixup_models[] = {
 	{.id = ALC2XX_FIXUP_HEADSET_MIC, .name = "alc2xx-fixup-headset-mic"},
 	{.id = ALC245_FIXUP_BASS_HP_DAC, .name = "alc245-fixup-bass-hp-dac"},
 	{.id = ALC256_FIXUP_HONOR_MRB_XXX_M1020_AUDIO, .name = "alc256-honor-mrb-xxx-m1020-audio"},
+	{.id = ALC287_FIXUP_LENOVO_LEGION_AW88399, .name = "alc287-lenovo-legion-aw88399"},
 	{}
 };
 #define ALC225_STANDARD_PINS \
diff --git a/sound/hda/codecs/side-codecs/aw88399_hda.c b/sound/hda/codecs/side-codecs/aw88399_hda.c
index ed57d9a4a39d..42de68faddbc 100644
--- a/sound/hda/codecs/side-codecs/aw88399_hda.c
+++ b/sound/hda/codecs/side-codecs/aw88399_hda.c
@@ -140,12 +140,54 @@ static int aw88399_hda_init(struct aw88399_hda *aw88399)
 	return 0;
 }
 
+static int aw88399_swap_channels(struct aw88399_hda *aw88399)
+{
+	/*
+	 * Certain Lenovo Legion laptops have their
+	 * I2C wiring reversed: 0x34 is physically the right speaker,
+	 * 0x35 is the left. Swap channels to correct L/R assignment.
+	 * This is a model-specific hardware wiring issue, not a driver bug.
+	 */
+	aw88399->channel = 1 - aw88399->channel;
+	dev_dbg(aw88399->dev,
+		"Channel swap applied: index %d -> channel %d\n",
+		aw88399->index, aw88399->channel);
+	return 0;
+}
+
+static int aw88399_skip_bsts_check(struct aw88399_hda *aw88399)
+{
+	/*
+	 * BSTS (boost-finished) status bit does not reliably report on
+	 * some hardware. On certain Lenovo Legion laptops, both amps
+	 * report BSTS=0 (boost not finished) during normal playback
+	 * despite clean audio output. Skip BSTS in the startup status
+	 * check to avoid false init failures.
+	 */
+	aw88399->bsts_unreliable = true;
+	dev_dbg(aw88399->dev, "BSTS status check disabled\n");
+	return 0;
+}
+
+static int aw88399_apply_legion_quirks(struct aw88399_hda *aw88399)
+{
+	aw88399_swap_channels(aw88399);
+	aw88399_skip_bsts_check(aw88399);
+	return 0;
+}
+
 struct aw88399_prop_model {
 	const char *ssid;
 	int (*apply_prop)(struct aw88399_hda *aw88399);
 };
 
 static const struct aw88399_prop_model aw88399_prop_model_table[] = {
+	{ "17AA3906", aw88399_apply_legion_quirks },
+	{ "17AA3907", aw88399_apply_legion_quirks },
+	{ "17AA3927", aw88399_apply_legion_quirks },
+	{ "17AA3928", aw88399_apply_legion_quirks },
+	{ "17AA3938", aw88399_apply_legion_quirks },
+	{ "17AA3939", aw88399_apply_legion_quirks },
 	{ }
 };
 
-- 
2.55.0

