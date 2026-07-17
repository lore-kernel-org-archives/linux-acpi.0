Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazolkn19010019.outbound.protection.outlook.com [52.103.20.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7643FE653;
	Fri, 17 Jul 2026 13:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784294830; cv=fail; b=sJJIqx8ye/r61ypz7MScCiGlotRnuDex+aXmIUbY7/WPXxgAJ+EvmPL5jEkTWow1tx2CH+apG44tvdLI+IALaxmNPerA4K3uK/FCZ4LHEq0wp79dM5bYArrpHMiACK02sfoK9H+mwwuggHfTAcxZ+2r8bbfxkW3czW4oZO+pRIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784294830; c=relaxed/simple;
	bh=/XCol3kYhvOBwlCEHip5f728dSGbqNs9Yghk/IOp9Ig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qbdGdt5Hktll1wpM54IEX0+DsTVF82A2uFVCQFvr0051yYSbQC1jByEmiJW72oJxX7gJGaqxDqLheQZcMBxTT8DbBGyWLP/5ydDUAG9/kGxqJio/513PqLIJ0AYcl6zfBEwQQ21jrfDcpfBqgyK8j1OalW9KHFHPTUSm47W+QZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.it; spf=pass smtp.mailfrom=outlook.it; dkim=pass (2048-bit key) header.d=OUTLOOK.IT header.i=@OUTLOOK.IT header.b=cc+j7rKR; arc=fail smtp.client-ip=52.103.20.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=OUTLOOK.IT header.i=@OUTLOOK.IT header.b="cc+j7rKR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=onmaKBouaBJy7mSSA+TRtnFGh6UOE8XhTFINiEttnbUb9AukPdDuLNxH0tBcnfldpXT3WAx3m8G9C4p7rHoyV++efUmGeiEzif4VPJDgqvZ/TwE7IvKok1WNLyShFHKbbsJ9GVPGVN2vR9X7eEE6u5gK2o7rkKn4x5bPsaF1AaQeTrEuigLtEPqwNYfYmw7TEuQuUnX/9BHjBHvE/x3cvgIIjqEL5YnSf8+yzzCMgDFKj5/FM9M4SIm2dYsmzin92cpbGzlLvRgW0pR3oqz95rKP/Pis7C7I1lP1/TFUcnV0Rl/GE1eCr4v7g5Ky3V6BSwaDyLjm9J6sHjtkZmeFuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zvw4Tax1hVpugaAKfGSMjH7ROqpN7g2Cb1P6cdgoE/s=;
 b=Xrl7yk/2w11y8WWcIRzdXC2aAO0mhSuY6143fmu6ztWod9e2aelYeOLclOwzKfBDX8VUsyl4UtmkNs7H+XmcDsU+pNSIpmbPK/9a+SBoAj38zfYJ7znkqjFLUL4NlcA1CTexerGxH3pb3QXYiDYGsehTFoElkGzZngJ9+VWQH76RK5lCx7ZFOxEaMoT3VqXWXwo1Jb/d5IdG1oEjyw6pNGyKNGqTlqudoNIaM83iiN/enNiT20UnERhWK5pWJt/eT6wmG3u0Xf2lz9BaZdoH2WLpAV12VpPYtYLBfXGJ6p2e46xuLq05a9rJ7pTLpG/fPxL0HDjiSLfmGWAeed64kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.IT;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zvw4Tax1hVpugaAKfGSMjH7ROqpN7g2Cb1P6cdgoE/s=;
 b=cc+j7rKRAe8KueEVTi8m7aqb4gJxmMGL5P9fukotY8E2EU8ILGyx2soXOfxs1+D9EIqm63hcpqdWfhBC7H59fFg9oAZYa6Pn3vJg3FI8Wv+06uGypuTJsGusnlCUx0oN9FSoUuTui6yGTvW1TEdRHaXOwqfZVZ96YHnOngWJlfsEym9CofagfRUIiJDOpfEFuJJoay9SKxsOYsVuD2cz0Oe7aWghBXSq8RPxx++OadA4f0is3F8tvUrLYVuRz9HMJnC1DLj8/nIrlg1rih6vRQda19S78ImFTYDms8vllRtVe35p4dczIw4WbHjPP0WReBvUNkWxljrOoS83ZO+ydQ==
Received: from DS7PR19MB7724.namprd19.prod.outlook.com (2603:10b6:8:d9::20) by
 IA3PR19MB8637.namprd19.prod.outlook.com (2603:10b6:208:526::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 13:27:01 +0000
Received: from DS7PR19MB7724.namprd19.prod.outlook.com
 ([fe80::70de:3c05:ac62:7f86]) by DS7PR19MB7724.namprd19.prod.outlook.com
 ([fe80::70de:3c05:ac62:7f86%5]) with mapi id 15.21.0223.012; Fri, 17 Jul 2026
 13:27:01 +0000
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
Subject: [PATCH 7/8] ALSA: hda/scodec: add AW88399 HDA side codec driver
Date: Fri, 17 Jul 2026 15:25:09 +0200
Message-ID:
 <DS7PR19MB77244BAAA53D29C3B5991A04FCC62@DS7PR19MB7724.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <DS7PR19MB77247D9AD698CF0FF37DB58BFCC62@DS7PR19MB7724.namprd19.prod.outlook.com>
References: <DS7PR19MB77247D9AD698CF0FF37DB58BFCC62@DS7PR19MB7724.namprd19.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0013.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::18) To DS7PR19MB7724.namprd19.prod.outlook.com
 (2603:10b6:8:d9::20)
X-Microsoft-Original-Message-ID:
 <20260717132509.148321-9-marco_giunta@outlook.it>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB7724:EE_|IA3PR19MB8637:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e959b3e-2dbd-4241-265c-08dee407155e
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|2604032031799003|5040399003|5072599009|51005399006|19110799012|8060799015|41001999006|704163111799003|55001999006|15080799012|24021099003|16051099003|3412199025|440099028|40105399003|3430499035|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MGA5LcxiN01hOqTdTWNGrPIE1F976IeZP2rf/lRj2WcnbqGfc9dMyxr+DK1B?=
 =?us-ascii?Q?SgthK0eNj85E4XynNjwOF3EyB1CQ126F5ObxDBrlo4Uelu/+eAU1IRfDI7bu?=
 =?us-ascii?Q?1REl9yXjp4tVJeoCTZLsl96kZhxEYfFZe7kLfh7A2mHvNCcCHHweE+5GeUbd?=
 =?us-ascii?Q?P9PQOOZUBZGLIG2Kxo+30uum2GEGvWYbzdNzdJF2FewDf2DeLKI8C/IhsMFD?=
 =?us-ascii?Q?jXhgxqq9uCeqqiWWIyxWQcZbzSi2sqRJ76Zp43X57eqe1N9YoCL/SyAt1iN9?=
 =?us-ascii?Q?+5xUYxpVkWj+cKWRoemVGG4tX3rfsWs6NLWsKNuncPxNjX+JUKzJz0KORC9g?=
 =?us-ascii?Q?Qk07bD4sMkJSlkdbkfzq9bEoi+R5t3g179lFeEf9bssgQbosaWMocR/0YXBs?=
 =?us-ascii?Q?K4qx8jtSpIlwgRbml8mViB/AAhyXgt1ZwQab7k7acVeR6VTMgijKJ5WF9Fdc?=
 =?us-ascii?Q?F9tK0ioyyt0W/pTKIIFdJpOl1Pf6+OfZwox30z8eh0uuzptB2RFEoNqLy4tL?=
 =?us-ascii?Q?GNo/thxJJiLA6ir9oXDvYhjafCdeuH9aQIfZCRH21U4LKTQRXsBxAgaE6bHq?=
 =?us-ascii?Q?cGSfqzIq9avIcSpyzhEXw1sw/dGxDs4iMFN3L9osKBsVp0+JY5OAdiOyPWG5?=
 =?us-ascii?Q?V/aqiPg8XbGGzvEsU5tuxuzVjHiFYGuePKc8V3bJkD02GaKIGKNjOanbzDcu?=
 =?us-ascii?Q?wIX2moB+r+V/5fN1elb06QvN/TFgn/mKdQX+sz7pvLr/xi9gkaRzHThEg4H8?=
 =?us-ascii?Q?F4Ew+e3HQvYR22dbxVAx60+WzLl6YVN6mB0QWcZrX55mi0urbLhekIrxv9F7?=
 =?us-ascii?Q?P0u5fBXFU5pnXxEJXYmwUXkNygGmTuTESaE4JDdMd4UmD7uJYBcbj4udAX8t?=
 =?us-ascii?Q?dRnnB7gyiCaj45tGNTB8sigK7I6dSkCYx22+0eh6fTfDcGjFqO8+7PjyFbfw?=
 =?us-ascii?Q?ruoLpYUod3HBEnV0A5YdoeENeEzAUJvVTvJW5X9FwRpbBkZAqtAnyE6CLfQX?=
 =?us-ascii?Q?IFOMcUhj7lLn6GmwHqLxMiusdWqG3y+tLXr6s7LnQAcoOBkrNm/S8ahRQBdU?=
 =?us-ascii?Q?iw/B2B4z2WnKtvmncoxTOgoWmbMJyfi5661/734uSqlSAMjtNx01rD2+0oUf?=
 =?us-ascii?Q?kbLHd8FzrV2sWWcCMZnOwpus6/F2B3qNEg=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1nc9lFefLxYo1P6rjZhm6sruDCQfB7C6wCQ5viSKThyl3Vp25BGLnhdoXB4l?=
 =?us-ascii?Q?Thaa4FlNZT0kk4xydSqGF8tJHteEcK4mcxAcC4R4imR+SO2boSO5dZbsFyrN?=
 =?us-ascii?Q?8uB2i31TFVKM7grB0K3MXLXebSNBAXFMmk1UDqJxPvc6n7o7ZYzIv2hyFVii?=
 =?us-ascii?Q?0XUBJT4Aq8Xu4JSpeHMZm3WPxwahihQh4T9za1ulZoxVbVlgaPQszRUBB1py?=
 =?us-ascii?Q?BcvlfofVlHCRzGu600jWBWoc4kk6/y5gcKT45SxSuS7ukNxg6PPNXnF50gNL?=
 =?us-ascii?Q?hPquzP9LJzSeKmgOKIPXRBG3NlQ8/TWfzHLj7lM+VP1aefiwUVkEYb8+oFZd?=
 =?us-ascii?Q?pocp2a6TXI7wn1szZq4P0YEpWwT+vIB3qaFzcfqAH1ScpK+ki1EkirK9F/RL?=
 =?us-ascii?Q?qGPeT0OZ9NRrqLH/puqOeBhX3XuIeiiiCP4RigDnV19PqzTF2zcRC32t4J7A?=
 =?us-ascii?Q?bDt/fvooJQsoYDk9gMX8Ahbtf9N9AB4UqfNY0U/LFXQY846Vu3mRrEisgot4?=
 =?us-ascii?Q?GCT8iVY8kFpdQPCejfyce6mgzrr5NpqDkYRHKCQV8akk2IR+0Q5kF864qLT1?=
 =?us-ascii?Q?bI3al6Q/Oh+1XXTX/e9nQuP6KtCoCYRvGAUZ7DIlMtzmH5cpyaP3DwVlDz12?=
 =?us-ascii?Q?SWftpxdNA+dOB0Cu7V639ZG70kJOzcUDyVCpJbBQjdS9sVPNGUdWB33j93X6?=
 =?us-ascii?Q?NTPUWFfkCzg35bKjjY52Lrt26zBSu1qV9zBPvixTDSWCi0k53SWBYuV1wjq+?=
 =?us-ascii?Q?kXeTtYc5/eEqafmfGYKXO5wKR3s4lY9Wv9wS4ucJZEfhkkBUMzzvyK5ImBfj?=
 =?us-ascii?Q?hLi1rzVPoJ+dFXi+ktTjCG//S0OYiLQBx1y7zZCgpk0iVCbAokS8JDd3iNpr?=
 =?us-ascii?Q?lVyUEjQrE7638V34wh8Cz2hSB1nt/FTOmL3f4vKJCKWBzkHCa6GmZ68ARpyN?=
 =?us-ascii?Q?VvV64YT9R8BHxc2Loj7zrCjtEAlyra4XWoBhEa99W0D2JSQJ61JykGhHE59F?=
 =?us-ascii?Q?xdgq/HcJGqIW2aLnpEXlDEL93yWk/1oc+CprhCxnGnqKLTrPWIa0RjzHoK/9?=
 =?us-ascii?Q?0Pze9SdWZydAiq3Xe0v4iLnEknxy8Pk8pmxHrRFQ/RgeIbWtUqJq1e8o56Bk?=
 =?us-ascii?Q?hDrGCiSFMexJU3h0Fql1MW0CR7XTtwpv0hcWKht4XAc1YuWsT2Yg5jVG7ejF?=
 =?us-ascii?Q?mkXE5pnerfzS89C2+u3ldLSRSewZi2eDe4WaxD/StLU2lleBZ0NCVMc4vtFU?=
 =?us-ascii?Q?YYh/jAnAC+S5El1r2J/973K4ajxIs7SVviu+FNH7TYKN2XZ1IWNOLZJhMAqG?=
 =?us-ascii?Q?kODa6I3MboO7ZNZ1OtzL4C9l8PmrcB7iu95T0pj38iRlAo9xpJfztXznsdEK?=
 =?us-ascii?Q?W+tsnsqNn3WMDVMftxOa7CzmkAw8?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e959b3e-2dbd-4241-265c-08dee407155e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB7724.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 13:27:01.2090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR19MB8637

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
 sound/hda/codecs/side-codecs/aw88399_hda.c    | 329 ++++++++++++++++++
 sound/hda/codecs/side-codecs/aw88399_hda.h    |  36 ++
 .../hda/codecs/side-codecs/aw88399_hda_i2c.c  |  54 +++
 5 files changed, 441 insertions(+)
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
index 000000000000..9f6f4cbcf641
--- /dev/null
+++ b/sound/hda/codecs/side-codecs/aw88399_hda.c
@@ -0,0 +1,329 @@
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
+
+	if (!adev) {
+		dev_err(aw88399->dev, "Failed to find an ACPI device for AWDZ8399\n");
+		return -ENODEV;
+	}
+
+	physdev = get_device(acpi_get_first_physical_node(adev));
+	acpi_dev_put(adev);
+
+	if (!physdev)
+		return -ENODEV;
+
+	sub = acpi_get_subsystem_id(ACPI_HANDLE(physdev));
+	put_device(physdev);
+	if (!IS_ERR_OR_NULL(sub))
+		aw88399->acpi_subsystem_id = sub;
+
+	if (aw88399->acpi_subsystem_id) {
+		for (model = aw88399_prop_model_table; model->ssid; model++) {
+			if (!strcasecmp(model->ssid, aw88399->acpi_subsystem_id)) {
+				dev_info(aw88399->dev,
+					 "Applying properties for SSID %s\n",
+					 aw88399->acpi_subsystem_id);
+				return model->apply_prop(aw88399);
+			}
+		}
+	}
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
+	kfree(aw88399->acpi_subsystem_id);
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

