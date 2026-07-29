Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19013082.outbound.protection.outlook.com [52.103.7.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7364E443313;
	Wed, 29 Jul 2026 09:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785317632; cv=fail; b=Bnge6s0azs+3+4vET/dJZ4Oq9wR04B8X4JYcJPa+vS+HnAVFCRj7vJyYU937TQSuOqaiJwUNUIunuqGM5Hw8dr6cenkGuONqy7wuKfpsTLv8+vlo1IDSKopEdd6yQUW0YfW6RxwTai7Vou4B6U6MM5DNbob/+CgYyDW/49/KueQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785317632; c=relaxed/simple;
	bh=pOXHTz/ofpZLXxK0qi7aHCSmt0b1ExFHqXHeb1ZfFZc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=PHW1ppaC93e3i8qZ4FHtfOuEnV0q26XWcdOm+ezPXMCUC0yBD2xS/BR7cWHIIMRsvW06WT3vQhS02Put04vZwjzc8raBdWL1yF1zXbZbdTqc5GCWUr6UlGmS7Z0mbB1lQPoJwLw0RI6aaZAb8aTy7RYneKE8vipVlmEii00TdN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.it; spf=pass smtp.mailfrom=outlook.it; dkim=pass (2048-bit key) header.d=OUTLOOK.IT header.i=@OUTLOOK.IT header.b=E6i4VVcC; arc=fail smtp.client-ip=52.103.7.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=OUTLOOK.IT header.i=@OUTLOOK.IT header.b="E6i4VVcC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jqi4Rvyzt35mxr7vkZfUS4UkvSLfq8lFjLDU85x5wM47wJUMJBu3uPIlsxexGfj3SNHUwc2/vZzHYBKSqLOpljkB6zl4MzF7LBFHdZvCjciuIeV09tiiYsiGba7BEkwlRwUoW6wXvOfb2j6Cb3fL/WJLhNlvozw7abxfompb4M9s+PCCSulhf0HmvOb0Noo/IKPEYMG+PUnVQSLbkPTO6zWvdFkhng9Gr73uZsPbyqwiySgrl4nLxzDNVDEkZl/69y9AIA+DdGFhuoPPRUrfz3WQGDX/Js3+pKE/E2clqAXG1EJUYk+PZvEyTiPvTMD58xXBPDxtp5LSrg3xxH6yZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=te+hafZWuWKOaoJIOCew/9dnd61LgulmERtpZVLPmLs=;
 b=m8acMNqYjEtGUzcOsV6liWyliyBu/I41G+qeJJYJOzwlg349qFoG+eQFHs4dG2WuhD1jcDJNzjv99hTEDt0+ON7vWKPB1vcVhU6tuvN63JCr6maKXWg6IvNFfoayB49lsHIxRHcnSQE4en6343S2lkauRrx2bTPTsGRrGl0feMH//QAfXmt5EXEmsaFAPHWS+4EkjsFZPFK7G8g2Lp5g4VbPpkIRubevw1DDssMTxtohhJeCJxeeqjfEVdhikI0m0DnALtss4Rehp7U4Jdj33ZigxneZnweRJkxt9zQXlzGd289Gr8B4R5mz1NHYTNGm+fdIc0inHlNMTsXhg724YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.IT;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=te+hafZWuWKOaoJIOCew/9dnd61LgulmERtpZVLPmLs=;
 b=E6i4VVcC6bp/ScEY2YzEsE0FXDKjGIOc8T0Z34lW1zOWDES/t29riXnOjFdeu0pVkZI83erPiPdh6tDJ4l5g5XS/PrNYQ1Ft5Bpm6qUUhHZb4Tw2K3XS6+fnglySS/BtMIPieApz04BpFvIMwxYXOf83M2uyafCKZ+gfyfG8K7Yhiex0EdNn429T5+KnjRz2R0nHc9S6p073Xpo1DtP4nZbp6rbTTq858FnhIIHcMWSR9ON2yBBRQFJB3IGu0yxGltT4cxaY7NTHozd4hcYuO1cWZUFlaO4fXxHHA0/lqnE/2Jx8vAegN/IpIESY8qscLgxaVZTbsjTulNqug+0rjA==
Received: from DS7PR19MB7724.namprd19.prod.outlook.com (2603:10b6:8:d9::20) by
 DSVPR19MB997523.namprd19.prod.outlook.com (2603:10b6:8:3be::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.13; Wed, 29 Jul
 2026 09:33:47 +0000
Received: from DS7PR19MB7724.namprd19.prod.outlook.com
 ([fe80::70de:3c05:ac62:7f86]) by DS7PR19MB7724.namprd19.prod.outlook.com
 ([fe80::70de:3c05:ac62:7f86%5]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 09:33:47 +0000
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
Subject: [PATCH v2 0/3] ALSA: hda: Add AW88399 HDA side codec driver for Lenovo Legion
Date: Wed, 29 Jul 2026 11:33:12 +0200
Message-ID:
 <DS7PR19MB7724AB9AA5096BF2F00014B0FCCA2@DS7PR19MB7724.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.55.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MI1P293CA0029.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::15) To DS7PR19MB7724.namprd19.prod.outlook.com
 (2603:10b6:8:d9::20)
X-Microsoft-Original-Message-ID:
 <20260729093315.20897-1-marco_giunta@outlook.it>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB7724:EE_|DSVPR19MB997523:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e0daf38-e651-4591-2baa-08deed547ccd
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|25010399006|55001999006|24021099003|5072599009|6090799003|51005399006|8060799015|5062599005|23021999003|19110799012|4302099013|3412199025|440099028|40105399003|10035399007|1602099012|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eldZTlJ6bHZMckpsMXUvcXdVVnoxSzdlRGZVT05VUnAvbDVoamN5VGYvMURZ?=
 =?utf-8?B?Ky9ERDA2UHFiYmR1RGxhY29KRHhXZ1NEYnBtVFlJMFZ3WDZsUGliTlh2QndN?=
 =?utf-8?B?N2dVT0JnM3htRWFQYnI1TWtUQkI2MW9Ccm14NWNXdHltaXRmQ241QnNKUkta?=
 =?utf-8?B?bkpQTit3Ukt5c04vU1A0UTZ5cE9PY05pZ1VYKzJJZ1ByZ2R1UnIzWEltdFIr?=
 =?utf-8?B?ZkRnL3djWStiM1N5cVUwZVBWRlZxVXEwRE94Vm9EVnErM1VSQWRUbE43RzA5?=
 =?utf-8?B?VDNScFB3YVNpc2ZyVWtqcmY2ckpVVDcxUDl3MGI3V3VpdDJrQkpJVWwvdU5z?=
 =?utf-8?B?dHIwQUpSeVh0UlcvVzJqeERlZ2p0UVR1TTlzMG1uaWlxdzBkS3hEa29LZXJh?=
 =?utf-8?B?eFZ3R2xNZGhZNmFKK1FiWmM0aHMzWDFhSEdFUC9EY3pkL1VCNTAxdkh3cUl3?=
 =?utf-8?B?bEFOWkxsdnJWK0NxQTFkeGFMOElzcnBBV2h4OU5Za1JrV0QyemhKeVFCUlVZ?=
 =?utf-8?B?cUt1bWJLdHNDQkM2dmRXRkV0cElKamlWQW9FVllnTnZuMkZ4UEp2UjF5enZZ?=
 =?utf-8?B?S2dyZjd5SXBJWFBtc1R2bDlFSG4yMlZsRGxDY2NGTFBtTmltQ3lRRzZ0WmFh?=
 =?utf-8?B?dkhYUHlHQ2pPOFdVT0Nac21INVpLbUFVTWxhaVN3bkQyNURxZFZBcExxdmJT?=
 =?utf-8?B?UEZGL3dsN0ZVRFZtK3d4SUdhalBBcHlsVVdrSzN6QXlqbE83VEt3WFBiWHVr?=
 =?utf-8?B?Q2lyZmRqbDYxM3NLd0U1eWJSbVlqV3VBa21XZGZEWVJmbGFUTk9FQnZiMGNS?=
 =?utf-8?B?UjVsUFFiVlNFU1h2UHRlaGpveUtMcmROK3kxSm1aNDVacDdVMWQwTVJENUVV?=
 =?utf-8?B?MUNJSDdUWi81MkM4SnBPdTV5MHhFbzN0NkRxc1lYdE9XS3FOZXBJbDB3ek5j?=
 =?utf-8?B?WnZPQ2g2dHNTU3VGS2NQMFJxQ1k5ZHk2Ym5kY0hZSzU0U0RVMi9FTGRVR3J0?=
 =?utf-8?B?d1BOdVBRR2sxSW5BNzNoOVhzN2pPUE1aZElqOU9DaEpzTzN1MU4zSXJHeW1L?=
 =?utf-8?B?QzBjcEFlMjhyOFZPRzBrZFJONWdOVDRPMHIvT1oxSUVjc3VMT0lFY1NjdUMx?=
 =?utf-8?B?U05XRVV6aG03SWlPRWk1YmV5UjhYN3JoSStibkJYeU9ZVnBtR1F3bFQ4SDEw?=
 =?utf-8?B?SGlaY0g3TURoMXJ1c1l6WGsvb0hXUmtmc2pJazVYemJKdmNzY2JhMDU0cC9T?=
 =?utf-8?B?amJuWGQrMmJTd0lDWUNTVmVHOFMxT2J5WHhSRUx5SzArQm5XclE2aWdHeG42?=
 =?utf-8?B?bkJjSUYrK2pzZnpjOWZyT0hHMlo4MlpEYUxJZjJ1Q3pNTUQ2eHFpcHlRdVo0?=
 =?utf-8?B?MmZTc1BRM3RhMDhrZ0w4V3dzRmpnTnZXZFVHc21yOGk1NW4weXJMV1o5Z2Fq?=
 =?utf-8?B?SkRScGJiQzc4d2docXdZa3kzR2kxUkwrU1UzTEF3PT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N2pXMi9OUkJ1UE42c2hpTnRObkJleHpIMTl0VzU0alZiL2t3cmo4VVNucmhk?=
 =?utf-8?B?MkRhaHlDZytUV1gzN2VneFdWb01kUkpkRDlXNFNqNkduaFNmUVhLcXlBN2h4?=
 =?utf-8?B?ZGcxR3Q1T0JibGZBZVErbDlNWlZTUUxzK3BMeE5vdVFaWTJZeUtFTk1HS2VM?=
 =?utf-8?B?M0JKekdzYS8xQzQ1UTNQVWhLSkFoOVBDNi9KM0lQMklHTVBJTjkydXVBZTA5?=
 =?utf-8?B?cURkamNpYStFckoyT0RLREVkQUJ4ZTFBTTRsaThmTU1WMi9Xd01ENWJ5elk2?=
 =?utf-8?B?SkNNRzZSWlBQUysyNHRJTXF5NllNMTBiVXM1N21YeS9FYTI5cExiRGY4VlBE?=
 =?utf-8?B?NGhQanpYZGo5Q1N6eFZyNzVWVUd2WmV2RjNkdTlJNFJhSzVHdjN6RmpxMy9E?=
 =?utf-8?B?YVZ4UUdDcVc4cjhMN1NzQWM4UXBJaUJ0SmQvazRwQVAydFhXb0ZtYUJ5dHZJ?=
 =?utf-8?B?QWhOVWRXRlNQOFkrcTFOanhyOWx6ZVJZTUFkaCtNU2g4ZlZsQW9KUnc2SzJj?=
 =?utf-8?B?UW52VExxS3ZSTjYyaXVOMFZZWHljMllnbDBDRjJSeVgrdDZtQUViQXJGNzQ2?=
 =?utf-8?B?R2J5aUFqZmdMUW1iZDJ1SHZxUTVsbGo0SW16YW5uTzJYNStNVUoxWXFUSCtC?=
 =?utf-8?B?c09TVkd5dmk5Wi91K2pyRkwwTkxRT2xQN2lNMXdoTm11TGVrZDNGWHBMdk5Z?=
 =?utf-8?B?S0J4ZDJ4M2piOXAwRWVIOWNYSFdtU0w5RC9seURQMFY5MkQ4aXFuWXd3eE1v?=
 =?utf-8?B?RnBGMFZNOFhySlBJdE5TQXRPR0JqVmRVUVF1MDdKNWdKaGcwRGl1YmRscWJ6?=
 =?utf-8?B?WGpEdjdzek9nUUoyRTRRSjczaE1rTEgxZVdJYkhwamJxdWNvdWpFa0VCV0E1?=
 =?utf-8?B?Q0pCbHVnMllUSUVMQnZwN2FybDNnMUViOFEzeEp4NzN3ZU9kelZMWjRmNzN5?=
 =?utf-8?B?dEtsaER3ZU9QRGx2NTdtcVBMUFBJOWR6MzhIT2ExYmpOVmorWU40VkE4OVV0?=
 =?utf-8?B?VjMzamErcTJmN0lvNUdxUWNZREFoNWNoU29KSW1QWHNFalJVQWhnbnFSMjV5?=
 =?utf-8?B?cXdXTnlvbmNBbHlPUEFGY3phZm5WMTNiQ0JaRXJVWlhKM3EzY29KTjdHSWNM?=
 =?utf-8?B?TWQ0OGxDc3MxMWR6aUQrUkcwLzIyU2lBZWdGMDhQWmxVNk1VcWlZNFBFUy9H?=
 =?utf-8?B?UVIxRUt4SitFTWFUdmtCemtmZTlXMTFzN1V6dmJwQ1Z2a0xDdGlVTmY4Qyto?=
 =?utf-8?B?ekpOaGJycmZJSnNWcDZjNWR4a3o2SlBJeFF3dkNuNVlCQitadlMwL1FidUlT?=
 =?utf-8?B?dk4raTBrVkwvdzdreENVWVpuVzlxUG9LT3VTNCt0Qi9Ic2h4MkEza09QaW5s?=
 =?utf-8?B?ak8yQXVRTFY1ekc4YWx3UTZCTUYrM3JhRVMwK01iM2RKOXFrL3BYSUxXU0ZP?=
 =?utf-8?B?VzZ1SWo0UWFqOG00Rm5LLzhaMERBRWZDT1c0SFRaU1VNbDlCR0lDeVU5ZGhl?=
 =?utf-8?B?UkdaME0yNnhYTkFDSVRDTkdZRzNRZkpGc2V3RHc3S3hvNG1rM1JadTBvUlVi?=
 =?utf-8?B?R21uY1BqTjA4cHdpMEFYVmFKV2w3czNxUUpZM1ZjeVhpdDRWSTk1clVpV2xV?=
 =?utf-8?B?QzdDWDBCdWorU1FJR25RWWxkUDh6b3h4dTRFemN1TXhVbDRnSkRPN3M5blcr?=
 =?utf-8?B?TXlNM0VpNFVSTjNLWHN2WHRYS2lmblZBOW16cFBROG43ZzBlaDNRUkR1QU9Y?=
 =?utf-8?B?T3dtdXFnaW5FOEloRmlreUNZWTE1blFaR3Iwc3NSRFFPZHJBVDEwcnFaRkJk?=
 =?utf-8?B?WTZhMzdRRXhMOHo4ZnNDWG9yTmdBSnp5V0libUJVNWp5RVJHQmZ6MFA0dkNw?=
 =?utf-8?B?UWh4Z3FKTmlEQjVYQnExbVFHTUdXYis4NGpWdkdJSEF1ZEcrbGkycUhjdHlq?=
 =?utf-8?Q?BMzBRpscs4Q=3D?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e0daf38-e651-4591-2baa-08deed547ccd
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB7724.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 09:33:46.7046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR19MB997523

This is v2 of the AW88399 HDA side codec driver series. Patches 1-5
from v1 (ASoC library preparation) were applied by Mark Brown and
merged into tiwai/sound via broonie/sound. This series contains the
remaining three patches.

Changes since v1:
* Fixed memory leak of acpi_subsystem_id string on probe error paths
  by switching to devm_kstrdup (bug reported by Sashiko, confirmed
  by Takashi Iwai)
* Added Acked-by tags from Rafael J. Wysocki and Ilpo Järvinen
  for the ACPI/platform changes

Patch 1 registers the AWINIC ACPI HID "AWDZ8399" with the ACPI
scan ignore list and the serial-multi-instantiate driver.

Patch 2 adds the HDA side codec driver: I2C bus driver and core
driver with HDA component binding, playback hooks, power management,
and per-model quirk matching.

Patch 3 enables the driver on Lenovo Legion Pro models with Realtek
ALC287 fixups and AW88399 per-model quirks.

Link to v1: https://lore.kernel.org/linux-sound/DS7PR19MB77247D9AD698CF0FF37DB58BFCC62@DS7PR19MB7724.namprd19.prod.outlook.com/T/#t

Marco Giunta (3):
  ACPI/platform: add AWDZ8399 to serial-multi-instantiate
  ALSA: hda/scodec: add AW88399 HDA side codec driver
  ALSA: hda/realtek: enable AW88399 on Lenovo Legion Pro

 drivers/acpi/scan.c                           |   1 +
 .../platform/x86/serial-multi-instantiate.c   |  10 +
 sound/hda/codecs/realtek/alc269.c             |  50 +++
 sound/hda/codecs/side-codecs/Kconfig          |  18 +
 sound/hda/codecs/side-codecs/Makefile         |   4 +
 sound/hda/codecs/side-codecs/aw88399_hda.c    | 372 ++++++++++++++++++
 sound/hda/codecs/side-codecs/aw88399_hda.h    |  36 ++
 .../hda/codecs/side-codecs/aw88399_hda_i2c.c  |  54 +++
 8 files changed, 545 insertions(+)
 create mode 100644 sound/hda/codecs/side-codecs/aw88399_hda.c
 create mode 100644 sound/hda/codecs/side-codecs/aw88399_hda.h
 create mode 100644 sound/hda/codecs/side-codecs/aw88399_hda_i2c.c


base-commit: 882fbdfafa8a373c1b544db6a9839c5c8a0d7780
-- 
2.55.0

