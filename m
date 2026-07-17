Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazolkn19010019.outbound.protection.outlook.com [52.103.20.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE4F3FDC14;
	Fri, 17 Jul 2026 13:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784294802; cv=fail; b=Rv78xXrzO5B8x4alkrIBTQi96pLD+K9G50/HSvR/qqrbjFsHQncoRxy7S2eGMCDmNHpFGYGFfv4rkK7bWYpZAVim68Qq4rUuB8yu/gjDIPbHMRoUnTjUFj40RxZAMVwoOU0txVMIkjZoItolNlBB7boc4FWDx4tDqbhyO0lGvuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784294802; c=relaxed/simple;
	bh=h0Y38/ZqTCH0LLdrkmV/MOUlAnMGujtGGcUDOELq4vI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=TwN41G9VbAshWHYJeOv2U1COZJR6JwbWFHXtwUz4cDbGN2BzKEC1xGwzRGtFHyHpxzqEnVMBlgDhOrgtCs57wQN2OPoeCP+AJEUSABunxTcHUB+bbytNaLUFnx0H43/uwPdWuyMKyCv65+mdYHA2UHJvBWkx7oKY7Uu5tR8TkVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.it; spf=pass smtp.mailfrom=outlook.it; dkim=pass (2048-bit key) header.d=OUTLOOK.IT header.i=@OUTLOOK.IT header.b=nOMcguKe; arc=fail smtp.client-ip=52.103.20.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=OUTLOOK.IT header.i=@OUTLOOK.IT header.b="nOMcguKe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UYxrgAqGE4PgnxLDB8IbBEdOtWCG9wUk5J3cqHciL09IJuOvqlnyLivFVTRtbfXu3aVEv+kcVOX7ijxQxkk27NE+KyMgkwN/yNbBMw2PHLuNySxglfP4EoJKYYknaTTceEF16ESMLbn15Bdjm9HT7lFd+9kuBhQppK7iB7uZ1V0AMyF3GOmD+HEEzdoYdzete6IqjqBN07+KUNlIAXzQxI746nrYlobdjfXJjvubMGm7OvP6adzLo8R+bqtJ+OMQ+t2ed0BGsiRi1TBHyavjIsylTkJUIG1phtWjWu833A5fQDItjFln86ssuhuOnP2Da4XF+t2Er3HOxsuk1UTNjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zBcMDsGdn4wHwM+I31CYIl1xBdmF7IJMrtSTLDUVFfU=;
 b=zCl9eZkVoBssUhvrOFJor+tmUS10TnVNDwzuzEHEFNi10fTNuKsIo9DnWg4Km4t6UMG1JeLG0CYzpregHTH723MF7K2d5CvPLp0sfi0Y+KRFE9aQPdIFACRynnAsgTQAgHR6StYX2whBjtItC7YvcHB2QoGYPCmqZ2xnQhOlhAhFVAg2fmbv6ztPwbvnDSQN6mxSE1OlRm/ORmc3lmOYodFGYoIuimchA42YNKTdsosD7BKjFgfdeEEiAnxlLkd5WB4FHmutu+C0/HEQKnA2Z2voNNVIpl7sVE+0r8UBctjKbAwci5zMaMZ/OaFEBNGiuJsKt10QQTG7hC1c+Y9Rjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.IT;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zBcMDsGdn4wHwM+I31CYIl1xBdmF7IJMrtSTLDUVFfU=;
 b=nOMcguKe/0DFqpffnl1vXYRGPcSuUEOaFXLz9pU0mLKDgQ5iQMAubPrXDTkAZYKNghYcpely2DcRDu/u7FjIPsxYdhCrVeTm5Ujm2kwZyA0ftoh67MMrAwlWSZEJMSQLK7ELKpf/qYVO+dEUdm7PNcYsA/i+Sxybuto6KyEy0PCpIAVEiiGHBvJtiPIs5fgX+JjKKFQkMomEpme8nNjzMgsscgxLdnmuFz47ZKPa74aLowhiP0Oc0J/7FkFFhsggQApfWG7mHNA/Ggr+Z46SPLPpRUvHrX6rZhrDpDi8wpCXnjG2GcqwBomtkMQtqBi8G4NlG1FLzIe5bD0Q3VW2mw==
Received: from DS7PR19MB7724.namprd19.prod.outlook.com (2603:10b6:8:d9::20) by
 IA3PR19MB8637.namprd19.prod.outlook.com (2603:10b6:208:526::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 13:26:34 +0000
Received: from DS7PR19MB7724.namprd19.prod.outlook.com
 ([fe80::70de:3c05:ac62:7f86]) by DS7PR19MB7724.namprd19.prod.outlook.com
 ([fe80::70de:3c05:ac62:7f86%5]) with mapi id 15.21.0223.012; Fri, 17 Jul 2026
 13:26:34 +0000
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
Subject: [PATCH 0/8] ALSA: hda: Add AW88399 HDA side codec driver for Lenovo Legion
Date: Fri, 17 Jul 2026 15:25:02 +0200
Message-ID:
 <DS7PR19MB77247D9AD698CF0FF37DB58BFCC62@DS7PR19MB7724.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0013.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::18) To DS7PR19MB7724.namprd19.prod.outlook.com
 (2603:10b6:8:d9::20)
X-Microsoft-Original-Message-ID:
 <20260717132509.148321-2-marco_giunta@outlook.it>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB7724:EE_|IA3PR19MB8637:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b762871-ba4e-428e-8d24-08dee4070537
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|39105399006|5040399003|5072599009|4140399003|12121999013|19110799012|22121099003|8060799015|41001999006|15080799012|24021099003|3412199025|440099028|4302099013|10035399007|41105399003|40105399003|3430499035|1602099012|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b/mSWUZ4Wbx9RnGsrvfUxwaK+Bp79jVmXjyJ9Pm59ThMsmrcdSYlCwKxV4wg?=
 =?us-ascii?Q?oVU4hC5uD24MbqtTsmDCfcFd0no+jjxajwowxGejmJr0/gS0ucMIFKii7SeO?=
 =?us-ascii?Q?tT7asS+Tsssx6bM1a1Sc/mcE+F8KyHNhupAur1CJJbbglIyFINBnIgkjVuX0?=
 =?us-ascii?Q?woiOJOww6SLN7/TIVm9q0+nA5SJ+fLZ1q3d9MR3Mg6gZls00jBO6QbOhweo9?=
 =?us-ascii?Q?OaUUetV3zdgCPec76pZsVIkdPoDh+1eMfCsOzLK9fknEIaFV1Be1XM8URGAH?=
 =?us-ascii?Q?/pPGW2xege27qhL+QwqqtxyaXlvkGgGgEhVw+Ticvu/FFAoCX5Y5ZcW52DDu?=
 =?us-ascii?Q?XexolMRXywP+OTfTXl+Rc9PlfcKjfDXAvv01ahTb7XoIDzsRCa7yTX5D+3zO?=
 =?us-ascii?Q?Ljwwgrme138W6hfozRzzhJ+CtkOJOgODQXl9gNSIjc1D5l0Ozgz27qJmpCO6?=
 =?us-ascii?Q?+FdbdlVidmIIYxRsDtDi7YqCRbjPApgsyhLeqES4iSGYI249QB9RikkTs2ps?=
 =?us-ascii?Q?GiupS+Y5TeimjrYfRxydkEe9wDSTSML7StWavAl8R3cb3vuNM+ksqkKKMuyX?=
 =?us-ascii?Q?SMcDhGdX7nqzYdkWld20caMcmWt7OnjkqRdZQ1WrBd4ETQ1GWc9Gmu3FnIKm?=
 =?us-ascii?Q?xmjDOklPNaUQ3RaSH7fNvpPQdLqxvQW56qmnD51Okq+I15tfxdS+t64Brzhg?=
 =?us-ascii?Q?qo8Nuvgx/r5ZDN5cNT8C8ZtPRFhmVBZ64R8ZNnj+Ero50qOF1tgsgs1JU3kD?=
 =?us-ascii?Q?l4l5wNZaPRZ/VA5XdEpXYiFR8I5ZzFIFMs3DpHlczyffK6Atcj3viqaWyQzl?=
 =?us-ascii?Q?peRuYCjn3Gu8tD48uZhJ8MJ98CyYMpwIFYhBLd+dtsLz7R4QO6xY+i6MTNGm?=
 =?us-ascii?Q?vkQNPdBlLmv6BNK/BEbB8/pBEYUot6iRtd29ZPSKPTFBuUhzKfneHQ2ckv3h?=
 =?us-ascii?Q?XQlu0WOPsKpFKJDlw9bPMQ/MOSRLYoVEcVxjDYsxtQz+JA6HnbPWu6wsY7cV?=
 =?us-ascii?Q?bnK9aQfJjAReVdMMSHMeWczFp4ArFdhAlY8wbLFyuWXa4gZJmE1uSW0w16RS?=
 =?us-ascii?Q?Hkxi7KVc/85+fprZAhFyDtuSP/GN2AafJNtxibfX+JSaMtYS+ZeTjKS+56XN?=
 =?us-ascii?Q?GRuvGKEOylh2CchYV+o8YuizkeyK3kWsbZWefQXlCFpjgUsZjl8f0fsSFo3w?=
 =?us-ascii?Q?B92oGR8euOBpzB1n?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wItUPYKbREH6g5vd0CBt/qc82JRbtdehsCo4M62huWiQEoyYPMLCyQC7d6/w?=
 =?us-ascii?Q?HyuNJfYk0D4G7FnGwgzlqyHv8kWLO6Gf29ma5pxTaxeJbO2QuD9iZmwmlfE8?=
 =?us-ascii?Q?ylHIzEdgI8MLpC6hbk2uC6RbNxyIJ9Y5Z32cnocRDhiXoZY0eV2l2fW6duWl?=
 =?us-ascii?Q?xrN2fcugLwk1gdrRmgH5KKWWNteh4A7v5415k7h2VdbTEs91YiHwo8yCqMrA?=
 =?us-ascii?Q?KDQNbEe0iz/0LcWkzuPtGCl4JB74nVWGrZxcalsnMZcYJI+G07upIJ73wFap?=
 =?us-ascii?Q?ZCZvT9/NEK3jWXGbWk+6FyGqiH1ddAeNKgn07b/BjfI7QL17aphpnjl+ZMnd?=
 =?us-ascii?Q?bl8HJH5PHx6vA825BW0s3HyLXIN3xChG/0dduB7jFP95eVDHFbJP8wg0UKdE?=
 =?us-ascii?Q?kfMJ3BmI91VKJ34jLxOkmOw21zMbVGBysN73NSneQ1lzBTX3Ws/cxsXzgB/e?=
 =?us-ascii?Q?zKvHnhTxodJlhCThdIK/xQr+od1dILQuisXj4x9eiFzT9jSG7ICxNHGd8aKU?=
 =?us-ascii?Q?Hyptkf90Vxsn971gSjVYmSp8ibuzE4MBQsDl9Krfu97vx71LcxljjSfuo95J?=
 =?us-ascii?Q?xrw/XJu3lri+vt5FUPUbRPyaAu2rDACajgeuHwiKEXAg9xZhfMv3RtaX554l?=
 =?us-ascii?Q?RIK0WPTA7Df4yMqxf+ZhWICKHSRIcuy0yB1RNwrUX02jslab+6+INxvP1O6p?=
 =?us-ascii?Q?djKCCfET8J9oJ478RLp86NF0zFO8iO+CN1uOeqQZknBpDDzrSAtPgP45e2iS?=
 =?us-ascii?Q?2fJ8yjQRp/Cb++9QknQF5Nfbpj1CIGiwspGsEWV/G7FNJVNjd2qSgOThbzvN?=
 =?us-ascii?Q?eEsv2d6q7l/QOcvqypadEQY2sexT1GZY0ASFS46UVKXugSXuzWlsdjn9OSv9?=
 =?us-ascii?Q?nJoIO+NuCcu3a5iSRg0tCKXsypSfG1l1odytbhZaBw+IzScYdGLjRxmtcKzP?=
 =?us-ascii?Q?94iV+QVW3KBEoZQ1BtNlggv90Ldaa4eMgmsoJekH7xcCzsntiBZJTgRQaGGK?=
 =?us-ascii?Q?bHuB2IihxHrWarCbgAaw9YiqSkcWL1cS13Fy04bLxF4jElID2kc0Ec41zv3l?=
 =?us-ascii?Q?MmKxlSf6XBHJkyXkzPac9HGkb1FQSbUGKPQaYz8hhiZpKxKd5jcmaPPWPum2?=
 =?us-ascii?Q?sshX5SS4O+LmkeuitcMYpQsW4A2QhFjgq4SxOlFFdl7mklsSkqyf3IrVI85r?=
 =?us-ascii?Q?3kHZQB1B5choiyiFo6TJsi0jE1btJfjUv7UI1X/Fa0x/rDOcz3DSuoL6N9L7?=
 =?us-ascii?Q?lUmEiF77oAvOvg0GzT4J8SUgFujjiDOe/Pdg5GB34kESa8l12zuhfX9HnkT/?=
 =?us-ascii?Q?GdInGXMDlFdDLqABIGykkDIbmVeA4NtLPDuhJtnU4mJf812zFFH4jten1bF5?=
 =?us-ascii?Q?ADMEUMe0Dwo9vb5e3iQTEsswZtah?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b762871-ba4e-428e-8d24-08dee4070537
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB7724.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 13:26:33.9659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR19MB8637

Several Lenovo Legion laptops (Pro 7i 16IAX10H, Y9000P IAX10,
Pro 7 16AFR10H, R9000P ADR10) use AWINIC AW88399 smart amplifiers
to drive their bass woofers, connected via I2C as side codecs
to a Realtek ALC287 HDA codec.

Without a driver for these amplifiers, only the tweeters produce
sound, resulting in quiet and tinny audio.

An ASoC driver for the AW88399 already exists in-tree
(sound/soc/codecs/aw88399.c), contributed by AWINIC, but it targets
ASoC topologies and cannot drive the chip when it sits behind an
HDA controller. This series adds a proper HDA side codec driver,
following the established pattern used by the CS35L41, CS35L56,
and TAS2781 drivers.

Patch 1 extracts the device-level functions from the existing ASoC
driver into a shared library module (SND_SOC_AW88399_LIB) with a
shared header at include/sound/aw88399.h, following the CS35L41
precedent (SND_SOC_CS35L41_LIB / include/sound/cs35l41.h). This
avoids a build-time dependency on the full ASoC codec module and
ensures clean separation between the ASoC and HDA drivers.

Patches 2 through 5 prepare the shared library for use on ACPI-based
HDA systems: patch 2 extends channel assignment to work without
Device Tree properties, patch 3 adds a per-instance flag to bypass
an unreliable hardware status bit on certain boards, patch 4 adds
a firmware reload flag so that the HDA driver can signal that DSP
firmware needs to be re-uploaded after system sleep, and patch 5
adds a channel setter so that the HDA driver can configure the
amplifier without depending on ASoC-internal device headers.

Patch 6 registers the AWINIC ACPI HID "AWDZ8399" with the ACPI scan
ignore list and the serial-multi-instantiate driver for correct
enumeration of the two amplifier instances.

Patch 7 adds the HDA side codec driver itself, structured after the
CS35L41 HDA driver: an I2C bus driver, and a core driver implementing
HDA component binding, playback hooks, power management, and per-model
quirk matching using ACPI subsystem ID.

Patch 8 enables the driver on Lenovo Legion Pro models by adding
the necessary Realtek ALC287 fixups (DAC rerouting for bass speaker
volume control, internal microphone calibration) and AW88399 per-model
quirks (I2C channel swap correction, BSTS status check bypass).

NOTE ON FIRMWARE: This driver requires the firmware file
aw88399_acf.bin, which uses the same format and request path as the
existing ASoC driver. This firmware is not yet available in the
linux-firmware repository. We intend to coordinate with the AWINIC
maintainers (CC'd) to arrange its inclusion. In the meantime, users
can extract the firmware from the Windows driver and place it in
/lib/firmware/.

This work builds on the initial driver development by Yakov Till
("Lyapsus") and the bounty effort organized by Nadim Kobeissi:
https://github.com/nadimkobeissi/16iax10h-linux-sound-saga

Marco Giunta (8):
  ASoC: aw88399: extract shared device library
  ASoC: aw88399: derive channel from I2C address on ACPI systems
  ASoC: aw88399: add per-instance BSTS status bypass flag
  ASoC: aw88399: add firmware reload flag for resume
  ASoC: aw88399: add channel setter for HDA side codec
  ACPI/platform: add AWDZ8399 to serial-multi-instantiate
  ALSA: hda/scodec: add AW88399 HDA side codec driver
  ALSA: hda/realtek: enable AW88399 on Lenovo Legion Pro

 drivers/acpi/scan.c                           |    1 +
 .../platform/x86/serial-multi-instantiate.c   |   10 +
 include/sound/aw88399.h                       |  621 ++++++++
 sound/hda/codecs/realtek/alc269.c             |   50 +
 sound/hda/codecs/side-codecs/Kconfig          |   18 +
 sound/hda/codecs/side-codecs/Makefile         |    4 +
 sound/hda/codecs/side-codecs/aw88399_hda.c    |  371 +++++
 sound/hda/codecs/side-codecs/aw88399_hda.h    |   36 +
 .../hda/codecs/side-codecs/aw88399_hda_i2c.c  |   54 +
 sound/soc/codecs/Kconfig                      |    5 +
 sound/soc/codecs/Makefile                     |    2 +
 sound/soc/codecs/aw88399-lib.c                | 1411 +++++++++++++++++
 sound/soc/codecs/aw88399.c                    | 1349 ----------------
 sound/soc/codecs/aw88399.h                    |  582 +------
 14 files changed, 2585 insertions(+), 1929 deletions(-)
 create mode 100644 include/sound/aw88399.h
 create mode 100644 sound/hda/codecs/side-codecs/aw88399_hda.c
 create mode 100644 sound/hda/codecs/side-codecs/aw88399_hda.h
 create mode 100644 sound/hda/codecs/side-codecs/aw88399_hda_i2c.c
 create mode 100644 sound/soc/codecs/aw88399-lib.c


base-commit: f9be704f58bde47c5ea841d5e4a6e9a7459c1578
-- 
2.55.0

