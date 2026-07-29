Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazolkn19010007.outbound.protection.outlook.com [52.103.2.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F0740D575;
	Wed, 29 Jul 2026 09:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785317637; cv=fail; b=nGRzRKvKXD0G+vwV4stBBtYjmN9N/e75qaYUydvQPA+rI5ySOajJH6GO7L6sMhuTPzVMEAALwJlnh8LLG2JdVCYvS1zmyrAsHBUjSDFZi364Y2Bep/vof51EFMN0H9Ba1vKpk8hiIHiJxXmSxaBnT0g/hh3sXhYQ8Tg6hA2Dp2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785317637; c=relaxed/simple;
	bh=CnWVWxhhN55uKWxnI2RrjoWj8Vj80ciu2DAL9mTjt8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GacD6eRs9QnN+1Tp9v+i5LpIrUSn5nGuzj3c/IGgiwqLZMR5KXZvaJ4EHlj9xJVBGqIKYLRqLv1SkjYasrmAuIA9E5Jtp5MY/DbZV/hDPlNsqbmLeS8qq2Bx+ZjUz4ekZxJYMt2B8gNVpwykhhtoLR8AlNO/NfjMZmmxPXgu6V0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.it; spf=pass smtp.mailfrom=outlook.it; dkim=pass (2048-bit key) header.d=OUTLOOK.IT header.i=@OUTLOOK.IT header.b=UxlW4j89; arc=fail smtp.client-ip=52.103.2.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=OUTLOOK.IT header.i=@OUTLOOK.IT header.b="UxlW4j89"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AxzzrCDEFxhY0W5w0mMBpgENlD2djWUGq+2HYvZqcN1WW0yYcT1ei5JcN4r5rvBbgaUYzCwYMfV9to+DMAyqALtCXB5h655AU2KTxRLcX08l2iXQNvIMhFvv3I62hqC0tr8bWuj3ex7j/jsCv1JxQJ7OxawAHV1s77AydJLszhRnLzI1vg/jEELbr2vX3nh0xUGg3PeSpcsx4INZafOsP5sdWhYddnoC34KeBoK59LY3mfQhF1lguiQehda6VMez1PrwGZ3yb4hoWCdCS1/LKs2BOUR5WZXu3PWWBHBB04g0rII+O6HJdSKXwbafECJ7uVjzyHJHmiLpLx7xAAkVMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n449ISJXlvYdMQff2/g3X/qEK0HIIeNXGKhaFL4bZ3g=;
 b=jzwljiU3Q4pRWv3vIxCtSaur34uVIh7ldbJccjulZLIyDWi4lLk5Rguo1n8rhDDlS9AU30wXbSPZ2ckDyhYRNGIhczzNKr7bD/Vtfcr0arpLlKNVRD0KN2MJspecwXo6X8S7cpNXSp2YCsv6+/2R/PXm/rpLXqH0u1dfVLHtlcb4tCRJSZTNTzjxpka+unBqF2rm+j61sBT9YDiplfF6dgugR6lR3aJIrtvzKZR6F0aSGbCslqdU2vg3Kpir4kljUb6gPyn5Kb97dwDSrjlCFhfyNAr9mxzNqXs2qxl5fMluD56vfDRUJc1dycdUcNr2i7lJ2tanKHqE3OMij8P6uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.IT;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n449ISJXlvYdMQff2/g3X/qEK0HIIeNXGKhaFL4bZ3g=;
 b=UxlW4j89WcWXv9AAlIYdGfzT8lulEFfsSwccojcTlDo+3ZGAIqvQE1WZ4Vm0oRCizKyG7LsyuDsNfFc/dcLYGjyRfyPOgnz56oLRJwDOw3k1kIv8ihJlfaOIykm9a71H6e4Zo4rk2g+AGDxZVQdiVxrnmKY4J4q6kBbm95CTJ7LQ/bpB4gldOeq8p4SuQUInOdLvZhocWlKuE8F1KnlYdYnaDfqXaZSQjV0EqdgSy1Kfmt+QW+FlkGtfnub1KdQeu/XV2EuBq8yHyVxOwbcOJXCuH0UJN5EgDPAGJrQMqgvQW71d0tbnq+m2Vinljfk10R1WjCCsoQozcehqoZntLQ==
Received: from DS7PR19MB7724.namprd19.prod.outlook.com (2603:10b6:8:d9::20) by
 DSVPR19MB997523.namprd19.prod.outlook.com (2603:10b6:8:3be::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.13; Wed, 29 Jul
 2026 09:33:54 +0000
Received: from DS7PR19MB7724.namprd19.prod.outlook.com
 ([fe80::70de:3c05:ac62:7f86]) by DS7PR19MB7724.namprd19.prod.outlook.com
 ([fe80::70de:3c05:ac62:7f86%5]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 09:33:54 +0000
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
Subject: [PATCH v2 2/3] ALSA: hda/scodec: add AW88399 HDA side codec driver
Date: Wed, 29 Jul 2026 11:33:14 +0200
Message-ID:
 <DS7PR19MB77247D67E739956AA4611ACEFCCA2@DS7PR19MB7724.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <DS7PR19MB7724AB9AA5096BF2F00014B0FCCA2@DS7PR19MB7724.namprd19.prod.outlook.com>
References: <DS7PR19MB7724AB9AA5096BF2F00014B0FCCA2@DS7PR19MB7724.namprd19.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0029.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::15) To DS7PR19MB7724.namprd19.prod.outlook.com
 (2603:10b6:8:d9::20)
X-Microsoft-Original-Message-ID:
 <20260729093315.20897-3-marco_giunta@outlook.it>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB7724:EE_|DSVPR19MB997523:EE_
X-MS-Office365-Filtering-Correlation-Id: 5217efbc-91b5-4f16-789f-08deed54816d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|25010399006|55001999006|24021099003|5072599009|51005399006|8060799015|23021999003|19110799012|41001999006|3412199025|440099028|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NbaOUK+xOiPetApRs7kYV+sGFGoaLOO8MxVkrS3tIyqx5wrYK4knGjMbauW7?=
 =?us-ascii?Q?lmTbQqoPgv2WxYXPt7WlB4CklHLOiXZDChB0kn+xP+nsSmkngVQMl4UrK+GB?=
 =?us-ascii?Q?+45JsM0ovdJBBBmin3XgQvhFtyvZs9RpGEVEDL23nMaIihKYJVKHHmIf6Zqi?=
 =?us-ascii?Q?MbCf1e7nn8KzotJRTcQH55/qlUxb3z9sF1r+Yba/STVjvid09avewXbxyiMx?=
 =?us-ascii?Q?uc7ukNai+V1Vv6rz1SrIQgCos9mtFG2RgNbk/rQNyyyBdoMNX3aqJz/kJVQo?=
 =?us-ascii?Q?FZkZVNCtEOs1pAjLuaGM4dWo0r7QG2SxjwORTpgec5N3hseaE3XNSQhTA/4V?=
 =?us-ascii?Q?V0lXsXzmPb9+YjKQzgJ4p2cKHCVUz3ndqrU7gKjgac8nt9dBknO1zUm5jT5s?=
 =?us-ascii?Q?X6QfhuQIqLQC/s/LzFhP5ghmD4AslHmt1t5RF/DNQaN2xarIidy1RnVZxv7+?=
 =?us-ascii?Q?3keHKlaai9u1T4XKZIln1XvAGnaJb4w5sbZp60rN03pw5HghMqNMFhHNjUWc?=
 =?us-ascii?Q?rQ6xbqLd88iynz/5GNJJz7y8IOj7SrKKcDbWem9tLAPC/ngxKisFWUoUGM8O?=
 =?us-ascii?Q?I7QjEYuN6XdXLrZ+0bIsCsWe1eBTDOhbslBkZhxqjh5+nohEJn1oW+kA9XGY?=
 =?us-ascii?Q?7fGduc8ZOcRIzTouqj2NvI/l1EAQvyRR+9SoiTPYdFssAlobWCnhADWdKpi0?=
 =?us-ascii?Q?1RMkNVWHG5XFjVE8xttuFN1dEHyzTx9xM4oUZIzJHICvIse3qpDDG+y9AWv5?=
 =?us-ascii?Q?aMLK/HXac84DGQTw2hgtzfl2GxUA1OyJm5whPr6UVs9tt/iGbRLRCRhpD4FH?=
 =?us-ascii?Q?//YkDp8OcqduDUZfRaKuOcqIGV293/kAXVwiQiDadEQ7CjYkWLqkuoeE1icT?=
 =?us-ascii?Q?dUrpbYN34lBtYrvok3sgaboE+akYrGKGLBAJ3wRGgRgOPBtuRpAGVtc/y3Fh?=
 =?us-ascii?Q?qo5zUBh8zRH8TC428Q55b2kIAda6sy++9fnnbgUIUYK5XpWr67ye8ggTlqcT?=
 =?us-ascii?Q?6bviQBOCmWewZemWvl84hnA6Ow=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U3X2nIMAZODouu1w2AHOtooav3kQ68bawO+I1azit7ESgpOe6EweWqcAxruq?=
 =?us-ascii?Q?dxTl34h//NmQJx1okMidz5bLwsmrzXaOUU/8t5YX7Mbvn/Qzmdh2laVtOBtE?=
 =?us-ascii?Q?WSz/6gCttmY9oQbXNFIZwIEn+ccbp0jXE02kvnOdRXZYFO4h2Dp6dzLin72h?=
 =?us-ascii?Q?v3pPf5b4RoUdBe8J/dIOIJw0/UGFDwNNKhw3m1FJppfIQdtPis48MDt7qM7d?=
 =?us-ascii?Q?Y6V3YoJIS+Pv1FObqlFA/bReRkU8rTWGfBZ/V+tEMZqt2K/5aoweS0NJLHDY?=
 =?us-ascii?Q?fIy872yxVV8aToIips71tPuAcrPvJYh8dgmlyUiu4FSTPKuXvLwCGQfuvses?=
 =?us-ascii?Q?oRWYngWfjtkiwhtWK2cckfP8+ml48gzh57loJwMwFG3/c8+NY+QBtd04+ODr?=
 =?us-ascii?Q?g00PNMGGk04Jlvhlfy6+oqTlq8ws60vMWdYGybH1YfX345VNGVx37SFzAcrK?=
 =?us-ascii?Q?PyeGOQL/oBY7SaQTCn/xDxHFyoePsIAWS8RjzQlmeYqbBZnfG0ZmcinKONqP?=
 =?us-ascii?Q?vdt+Bx6sfIydT+gUAt6TDeoTJg58MLgxBViLTGMQnzXwfkbGJs72Le1eCONd?=
 =?us-ascii?Q?ElYlHyoYXGpPAbPWFHWHdjrSNuBjig1DP5octbeJo+oHZOhDUsZoqgpM94yK?=
 =?us-ascii?Q?NcqSEHj0xAFa5U41KNjWDt6hCqNPstQe6sjgleskSHm8e+TDAHfgwEv/9aJg?=
 =?us-ascii?Q?CbeNRLWE3npu+r2wgGT2sKcLXaDOcOfpvW6jYp2ytPyO5LsGhu+KCdHzqCkI?=
 =?us-ascii?Q?7GxnZQUt0PmyZEw6/77Y8rZ6jGPyY0TdF/4pXw2r6kjRpVgYQi0uqYZ3SRdd?=
 =?us-ascii?Q?hU5tGzcdy2EopoVdywWFccnyjnQK+rsKu0uNGJkbHdoQ/hjSzNWEP5acypYl?=
 =?us-ascii?Q?NlXBQU1JazQixEBQPxP6qWL1NIFJpDBk0vGKI43yKmhZgL1QrjBdp1YXULSO?=
 =?us-ascii?Q?qLmFx3OJBIP7+S/eSJ0cCzRLLd32/SWSIm4JQ0+GZ0Iwv3wvS+/u5C4QsFQM?=
 =?us-ascii?Q?LVS5sAOcbaf36mJPCSP6nCexFb8zBhPKlMJu+xzRVzdwpNzhslJulNQWfbNl?=
 =?us-ascii?Q?l5osdEXRug1WeTZTjiYHloPhj59MMB1smq88x8FmsO1gDnSedB4WqqEbD03q?=
 =?us-ascii?Q?MSgWIu2cS0ZIja8mMIkN9ZGvEPPureSThPDnwVn8tCdIE0n6+nDIGg2potzZ?=
 =?us-ascii?Q?Qxw822aO0niICUehYtFB9WpCRYV50rA++s0op1JUrydIwem1UvttxY1+Qswx?=
 =?us-ascii?Q?Cln8fL7hOKNzoCOFwSgXcZcdBqRW+f1YpqPmlgo/3XUBhZSWn5abxf083kXN?=
 =?us-ascii?Q?/WbAOEqKxDybel4EP/fLVzfiiLERpJVovUM+oKsr9J1ZG3VR0y3nw0/WUJE+?=
 =?us-ascii?Q?eVY4Kelx0eEL27dLiMzgwS8lf6bCYTOEzXS7zkYjS+g90PEZbXo0WQmJkzrk?=
 =?us-ascii?Q?fR9tdRBjHlM=3D?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 5217efbc-91b5-4f16-789f-08deed54816d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB7724.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 09:33:54.1622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR19MB997523

Add an HDA side codec driver for the AWINIC AW88399 smart amplifier,
enabling its use as a companion amplifier on HDA systems where the
chip is connected via I2C to the host and driven alongside a primary
HDA codec (such as Realtek ALC287).

The driver is structured after the existing side codec drivers:

* aw88399_hda_i2c.c: I2C bus driver matching ACPI HID "AWDZ8399" and
  serial-multi-instantiate device name "aw88399-hda".
  Creates the regmap and passes it to the shared probe function,
  following the CS35L41/CS35L56/TAS2781 pattern.

* aw88399_hda.c: Core driver implementing HDA component binding,
  playback hooks (using the shared library's start/stop functions),
  ACPI subsystem ID retrieval, and runtime/system power management.
  Includes per-model quirk infrastructure using ACPI subsystem ID
  matching; the quirk table is empty in this patch and populated in
  the next patch along with the corresponding Realtek fixups that
  activate the driver.

The driver includes <sound/aw88399.h> for shared definitions and
depends on SND_SOC_AW88399_LIB for chip initialization, firmware
loading, and playback control, avoiding any dependency on the full
ASoC codec module.

Tested-by: Nadim Kobeissi <nadim@symbolic.software>
Tested-by: Xia Yun'an <imitoy@imitoy.top>
Tested-by: Munzir Taha <munzirtaha@gmail.com>
Co-developed-by: Yakov Till <yakov.till@gmail.com>
Signed-off-by: Yakov Till <yakov.till@gmail.com>
Signed-off-by: Marco Giunta <marco_giunta@outlook.it>
---
 sound/hda/codecs/side-codecs/Kconfig          |  18 +
 sound/hda/codecs/side-codecs/Makefile         |   4 +
 sound/hda/codecs/side-codecs/aw88399_hda.c    | 330 ++++++++++++++++++
 sound/hda/codecs/side-codecs/aw88399_hda.h    |  36 ++
 .../hda/codecs/side-codecs/aw88399_hda_i2c.c  |  54 +++
 5 files changed, 442 insertions(+)
 create mode 100644 sound/hda/codecs/side-codecs/aw88399_hda.c
 create mode 100644 sound/hda/codecs/side-codecs/aw88399_hda.h
 create mode 100644 sound/hda/codecs/side-codecs/aw88399_hda_i2c.c

diff --git a/sound/hda/codecs/side-codecs/Kconfig b/sound/hda/codecs/side-codecs/Kconfig
index 1cfd83e251e4..f90f1dfcec68 100644
--- a/sound/hda/codecs/side-codecs/Kconfig
+++ b/sound/hda/codecs/side-codecs/Kconfig
@@ -13,6 +13,24 @@ config SND_HDA_CIRRUS_SCODEC_KUNIT_TEST
 	  Documentation/dev-tools/kunit/.
 	  If in doubt, say "N".
 
+config SND_HDA_SCODEC_AW88399
+	tristate
+	select SND_HDA_GENERIC
+
+config SND_HDA_SCODEC_AW88399_I2C
+	tristate "Build AW88399 HD-audio side codec support for I2C Bus"
+	depends on I2C
+	depends on ACPI
+	depends on SND_SOC
+	select SND_HDA_SCODEC_AW88399
+	select SND_SOC_AW88399_LIB
+	help
+	  Say Y or M here to include AW88399 I2C HD-audio side codec support
+	  in snd-hda-intel driver, such as ALC287.
+
+comment "Set to Y if you want auto-loading the side codec driver"
+	depends on SND_HDA=y && SND_HDA_SCODEC_AW88399_I2C=m
+
 config SND_HDA_SCODEC_CS35L41
 	tristate
 	select SND_HDA_GENERIC
diff --git a/sound/hda/codecs/side-codecs/Makefile b/sound/hda/codecs/side-codecs/Makefile
index 245e84f6a121..7dd010c68f78 100644
--- a/sound/hda/codecs/side-codecs/Makefile
+++ b/sound/hda/codecs/side-codecs/Makefile
@@ -3,6 +3,8 @@ subdir-ccflags-y += -I$(src)/../../common
 
 snd-hda-cirrus-scodec-y :=	cirrus_scodec.o
 snd-hda-cirrus-scodec-test-y :=	cirrus_scodec_test.o
+snd-hda-scodec-aw88399-y :=	aw88399_hda.o
+snd-hda-scodec-aw88399-i2c-y :=	aw88399_hda_i2c.o
 snd-hda-scodec-cs35l41-y :=	cs35l41_hda.o cs35l41_hda_property.o
 snd-hda-scodec-cs35l41-i2c-y :=	cs35l41_hda_i2c.o
 snd-hda-scodec-cs35l41-spi-y :=	cs35l41_hda_spi.o
@@ -16,6 +18,8 @@ snd-hda-scodec-tas2781-spi-y :=	tas2781_hda_spi.o
 
 obj-$(CONFIG_SND_HDA_CIRRUS_SCODEC) += snd-hda-cirrus-scodec.o
 obj-$(CONFIG_SND_HDA_CIRRUS_SCODEC_KUNIT_TEST) += snd-hda-cirrus-scodec-test.o
+obj-$(CONFIG_SND_HDA_SCODEC_AW88399) += snd-hda-scodec-aw88399.o
+obj-$(CONFIG_SND_HDA_SCODEC_AW88399_I2C) += snd-hda-scodec-aw88399-i2c.o
 obj-$(CONFIG_SND_HDA_SCODEC_CS35L41) += snd-hda-scodec-cs35l41.o
 obj-$(CONFIG_SND_HDA_SCODEC_CS35L41_I2C) += snd-hda-scodec-cs35l41-i2c.o
 obj-$(CONFIG_SND_HDA_SCODEC_CS35L41_SPI) += snd-hda-scodec-cs35l41-spi.o
diff --git a/sound/hda/codecs/side-codecs/aw88399_hda.c b/sound/hda/codecs/side-codecs/aw88399_hda.c
new file mode 100644
index 000000000000..ed57d9a4a39d
--- /dev/null
+++ b/sound/hda/codecs/side-codecs/aw88399_hda.c
@@ -0,0 +1,330 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// AW88399 HDA side codec driver
+//
+// Based on cs35l41_hda.c and aw88399.c
+//
+
+#include <linux/acpi.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/pm_runtime.h>
+#include <linux/string.h>
+#include <sound/hda_codec.h>
+#include "../generic.h"
+#include "hda_component.h"
+#include "aw88399_hda.h"
+
+#define AW88399_HDA_I2C_BASE_ADDR	0x34
+
+static void aw88399_hda_playback_hook(struct device *dev, int action)
+{
+	struct aw88399_hda *aw88399 = dev_get_drvdata(dev);
+	struct aw88399 *core = aw88399->core;
+	int ret = 0;
+
+	dev_dbg(aw88399->dev, "Playback action: %d\n", action);
+
+	switch (action) {
+	case HDA_GEN_PCM_ACT_OPEN:
+		pm_runtime_get_sync(dev);
+		aw88399->playing = true;
+		break;
+	case HDA_GEN_PCM_ACT_PREPARE:
+		if (core)
+			aw88399_start(core, AW88399_SYNC_START);
+		break;
+	case HDA_GEN_PCM_ACT_CLEANUP:
+		if (aw88399->aw_dev)
+			ret = aw88399_stop(aw88399->aw_dev);
+		if (ret)
+			dev_err(aw88399->dev, "Failed to stop amplifier: %d\n", ret);
+		break;
+	case HDA_GEN_PCM_ACT_CLOSE:
+		if (aw88399->aw_dev)
+			aw88399_stop(aw88399->aw_dev);
+		aw88399->playing = false;
+		pm_runtime_mark_last_busy(dev);
+		pm_runtime_put_autosuspend(dev);
+		break;
+	default:
+		dev_warn(aw88399->dev, "Unsupported action: %d\n", action);
+		break;
+	}
+}
+
+static int aw88399_hda_bind(struct device *dev, struct device *master, void *master_data)
+{
+	struct aw88399_hda *aw88399 = dev_get_drvdata(dev);
+	struct hda_component_parent *parent = master_data;
+	struct hda_component *comp;
+
+	comp = hda_component_from_index(parent, aw88399->index);
+	if (!comp)
+		return -EINVAL;
+
+	if (comp->dev)
+		return -EBUSY;
+
+	comp->dev = dev;
+
+	strscpy(comp->name, dev_name(dev), sizeof(comp->name));
+
+	comp->playback_hook = aw88399_hda_playback_hook;
+
+	dev_info(aw88399->dev,
+		 "AW88399 Bound - SSID: %s, channel: %d\n",
+		 aw88399->acpi_subsystem_id, aw88399->channel);
+
+	return 0;
+}
+
+static void aw88399_hda_unbind(struct device *dev, struct device *master, void *master_data)
+{
+	struct aw88399_hda *aw88399 = dev_get_drvdata(dev);
+	struct hda_component_parent *parent = master_data;
+	struct hda_component *comp;
+
+	comp = hda_component_from_index(parent, aw88399->index);
+	if (comp && (comp->dev == dev))
+		memset(comp, 0, sizeof(*comp));
+
+	dev_dbg(aw88399->dev, "Unbound from HDA codec\n");
+}
+
+static const struct component_ops aw88399_hda_comp_ops = {
+	.bind = aw88399_hda_bind,
+	.unbind = aw88399_hda_unbind,
+};
+
+static int aw88399_hda_index_from_i2c(struct aw88399_hda *aw88399)
+{
+	return to_i2c_client(aw88399->dev)->addr - AW88399_HDA_I2C_BASE_ADDR;
+}
+
+static int aw88399_hda_init(struct aw88399_hda *aw88399)
+{
+	struct device *dev = aw88399->dev;
+	struct i2c_client *i2c = to_i2c_client(dev);
+	struct aw88399 *core;
+	int ret;
+
+	core = devm_kzalloc(dev, sizeof(*core), GFP_KERNEL);
+	if (!core)
+		return -ENOMEM;
+
+	mutex_init(&core->lock);
+	core->reset_gpio = aw88399->reset_gpio;
+	core->regmap = aw88399->regmap;
+	core->bsts_unreliable = aw88399->bsts_unreliable;
+
+	aw88399_hw_reset(core);
+
+	ret = aw88399_init(core, i2c, aw88399->regmap);
+	if (ret)
+		return ret;
+
+	/* Set channel BEFORE loading firmware so ACF parser sees correct value */
+	if (core->aw_pa)
+		aw88399_dev_set_channel(core, aw88399->channel);
+
+	ret = aw88399_request_firmware_file(core);
+	if (ret)
+		return ret;
+
+	aw88399->core = core;
+	aw88399->aw_dev = core->aw_pa;
+
+	return 0;
+}
+
+struct aw88399_prop_model {
+	const char *ssid;
+	int (*apply_prop)(struct aw88399_hda *aw88399);
+};
+
+static const struct aw88399_prop_model aw88399_prop_model_table[] = {
+	{ }
+};
+
+static int aw88399_hda_acpi_probe(struct aw88399_hda *aw88399)
+{
+	struct acpi_device *adev;
+	struct device *physdev;
+	const char *sub;
+	const struct aw88399_prop_model *model;
+
+	aw88399->index = aw88399_hda_index_from_i2c(aw88399);
+	aw88399->channel = aw88399->index;
+	aw88399->acpi_subsystem_id = NULL;
+
+	adev = acpi_dev_get_first_match_dev("AWDZ8399", NULL, -1);
+	if (!adev) {
+		dev_err(aw88399->dev, "Failed to find an ACPI device for AWDZ8399\n");
+		return -ENODEV;
+	}
+
+	physdev = get_device(acpi_get_first_physical_node(adev));
+	acpi_dev_put(adev);
+	if (!physdev)
+		return -ENODEV;
+
+	sub = acpi_get_subsystem_id(ACPI_HANDLE(physdev));
+	put_device(physdev);
+	if (IS_ERR_OR_NULL(sub))
+		return 0;
+
+	aw88399->acpi_subsystem_id = devm_kstrdup(aw88399->dev, sub, GFP_KERNEL);
+	kfree(sub);
+	if (!aw88399->acpi_subsystem_id)
+		return -ENOMEM;
+
+	for (model = aw88399_prop_model_table; model->ssid; model++) {
+		if (!strcasecmp(model->ssid, aw88399->acpi_subsystem_id)) {
+			dev_info(aw88399->dev,
+				 "Applying properties for SSID %s\n",
+				 aw88399->acpi_subsystem_id);
+			return model->apply_prop(aw88399);
+		}
+	}
+
+	return 0;
+}
+
+int aw88399_hda_probe(struct device *dev, struct regmap *regmap)
+{
+	struct aw88399_hda *aw88399;
+	int ret;
+
+	aw88399 = devm_kzalloc(dev, sizeof(*aw88399), GFP_KERNEL);
+	if (!aw88399)
+		return -ENOMEM;
+
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap), "Failed to obtain regmap\n");
+
+	aw88399->dev = dev;
+	aw88399->regmap = regmap;
+	dev_set_drvdata(dev, aw88399);
+
+	aw88399->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(aw88399->reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(aw88399->reset_gpio),
+				     "Failed to get reset GPIO\n");
+
+	ret = aw88399_hda_acpi_probe(aw88399);
+	if (ret)
+		return dev_err_probe(dev, ret, "ACPI probe failed\n");
+
+	ret = aw88399_hda_init(aw88399);
+	if (ret)
+		return dev_err_probe(dev, ret, "Chip initialization failed\n");
+
+	/* Enable runtime PM */
+	pm_runtime_set_autosuspend_delay(dev, 3000);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+
+	ret = component_add(dev, &aw88399_hda_comp_ops);
+	if (ret) {
+		pm_runtime_disable(dev);
+		return dev_err_probe(dev, ret, "Failed to register component\n");
+	}
+
+	dev_info(dev, "AW88399 HDA side codec registered successfully\n");
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(aw88399_hda_probe, "SND_HDA_SCODEC_AW88399");
+
+void aw88399_hda_remove(struct device *dev)
+{
+	struct aw88399_hda *aw88399 = dev_get_drvdata(dev);
+
+	pm_runtime_disable(dev);
+
+	if (aw88399->aw_dev)
+		aw88399_stop(aw88399->aw_dev);
+
+	component_del(dev, &aw88399_hda_comp_ops);
+
+	dev_dbg(aw88399->dev, "AW88399 HDA side codec removed\n");
+}
+EXPORT_SYMBOL_NS_GPL(aw88399_hda_remove, "SND_HDA_SCODEC_AW88399");
+
+static int aw88399_hda_runtime_suspend(struct device *dev)
+{
+	struct aw88399_hda *aw88399 = dev_get_drvdata(dev);
+
+	dev_dbg(aw88399->dev, "Runtime suspend\n");
+
+	if (aw88399->aw_dev && aw88399->playing)
+		aw88399_stop(aw88399->aw_dev);
+
+	return 0;
+}
+
+static int aw88399_hda_runtime_resume(struct device *dev)
+{
+	struct aw88399_hda *aw88399 = dev_get_drvdata(dev);
+
+	dev_dbg(aw88399->dev, "Runtime resume\n");
+
+	if (aw88399->core && aw88399->aw_dev && aw88399->playing)
+		aw88399_start(aw88399->core, AW88399_SYNC_START);
+
+	return 0;
+}
+
+static int aw88399_hda_system_suspend(struct device *dev)
+{
+	struct aw88399_hda *aw88399 = dev_get_drvdata(dev);
+	int ret;
+
+	dev_dbg(aw88399->dev, "System suspend\n");
+
+	if (aw88399->aw_dev && aw88399->playing)
+		aw88399_stop(aw88399->aw_dev);
+
+	if (aw88399->core)
+		aw88399->core->fw_needs_reload = true;
+
+	ret = pm_runtime_force_suspend(dev);
+	if (ret)
+		dev_err(aw88399->dev, "Runtime force suspend failed: %d\n", ret);
+
+	return ret;
+}
+
+static int aw88399_hda_system_resume(struct device *dev)
+{
+	struct aw88399_hda *aw88399 = dev_get_drvdata(dev);
+	int ret;
+
+	dev_dbg(aw88399->dev, "System resume\n");
+
+	if (aw88399->aw_dev)
+		aw88399_hw_reset(aw88399->core);
+
+	ret = pm_runtime_force_resume(dev);
+	if (ret)
+		dev_err(aw88399->dev, "Runtime force resume failed: %d\n", ret);
+
+	return ret;
+}
+
+const struct dev_pm_ops aw88399_hda_pm_ops = {
+	RUNTIME_PM_OPS(aw88399_hda_runtime_suspend, aw88399_hda_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(aw88399_hda_system_suspend, aw88399_hda_system_resume)
+};
+EXPORT_SYMBOL_NS_GPL(aw88399_hda_pm_ops, "SND_HDA_SCODEC_AW88399");
+
+MODULE_DESCRIPTION("AW88399 HDA driver");
+MODULE_AUTHOR("Yakov Till <yakov.till@gmail.com>");
+MODULE_AUTHOR("Marco Giunta <marco_giunta@outlook.it>");
+MODULE_LICENSE("GPL");
+MODULE_FIRMWARE("aw88399_acf.bin");
diff --git a/sound/hda/codecs/side-codecs/aw88399_hda.h b/sound/hda/codecs/side-codecs/aw88399_hda.h
new file mode 100644
index 000000000000..ca0aa5279298
--- /dev/null
+++ b/sound/hda/codecs/side-codecs/aw88399_hda.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
+ * AW88399 HDA side codec driver
+ */
+
+#ifndef __AW88399_HDA_H__
+#define __AW88399_HDA_H__
+
+#include <linux/device.h>
+#include <linux/gpio/consumer.h>
+#include <sound/aw88399.h>
+
+struct aw88399;
+struct aw_device;
+
+struct aw88399_hda {
+	struct device *dev;
+	struct regmap *regmap;
+	struct gpio_desc *reset_gpio;
+	struct aw_device *aw_dev;
+	struct aw88399 *core;
+	bool bsts_unreliable;
+
+	const char *acpi_subsystem_id;
+	int index;
+	int channel;
+
+	bool playing;
+};
+
+int aw88399_hda_probe(struct device *dev, struct regmap *regmap);
+void aw88399_hda_remove(struct device *dev);
+
+extern const struct dev_pm_ops aw88399_hda_pm_ops;
+
+#endif /* __AW88399_HDA_H__ */
diff --git a/sound/hda/codecs/side-codecs/aw88399_hda_i2c.c b/sound/hda/codecs/side-codecs/aw88399_hda_i2c.c
new file mode 100644
index 000000000000..186e13adbc6c
--- /dev/null
+++ b/sound/hda/codecs/side-codecs/aw88399_hda_i2c.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// AW88399 HDA I2C driver
+//
+// Based on cs35l41_hda_i2c.c
+//
+
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+
+#include "aw88399_hda.h"
+
+static int aw88399_hda_i2c_probe(struct i2c_client *clt)
+{
+	if (!strstr(dev_name(&clt->dev), "AWDZ8399"))
+		return -ENODEV;
+
+	return aw88399_hda_probe(&clt->dev,
+				 devm_regmap_init_i2c(clt, &aw88399_remap_config));
+}
+
+static void aw88399_hda_i2c_remove(struct i2c_client *clt)
+{
+	aw88399_hda_remove(&clt->dev);
+}
+
+static const struct i2c_device_id aw88399_hda_i2c_id[] = {
+	{ .name = "aw88399-hda" },
+	{ }
+};
+
+static const struct acpi_device_id aw88399_acpi_hda_match[] = {
+	{ "AWDZ8399", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, aw88399_acpi_hda_match);
+
+static struct i2c_driver aw88399_hda_i2c_driver = {
+	.driver = {
+		.name		= "aw88399-hda",
+		.acpi_match_table = aw88399_acpi_hda_match,
+		.pm		= &aw88399_hda_pm_ops,
+	},
+	.probe		= aw88399_hda_i2c_probe,
+	.remove		= aw88399_hda_i2c_remove,
+	.id_table	= aw88399_hda_i2c_id,
+};
+module_i2c_driver(aw88399_hda_i2c_driver);
+
+MODULE_DESCRIPTION("HDA AW88399 I2C driver");
+MODULE_IMPORT_NS("SND_HDA_SCODEC_AW88399");
+MODULE_AUTHOR("Yakov Till <yakov.till@gmail.com>");
+MODULE_LICENSE("GPL");
-- 
2.55.0

