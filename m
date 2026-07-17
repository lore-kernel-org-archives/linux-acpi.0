Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazolkn19010019.outbound.protection.outlook.com [52.103.20.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946C33FE37A;
	Fri, 17 Jul 2026 13:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784294823; cv=fail; b=hWAdMT352IZdaGAaCuHAWwsPxn0PeyJ6oFGv3+Ae3uQrchfySFd2G5uSipgGJOBS5X3LK3OhQDAKm9uoB/oO9gllLSpJSjujZrMAcK/wqAvc82XBmiML27VUn/Vx36/NNxWJiNPG1W20DUu46kayh8w7HS837RaKMkbBPwz4Uo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784294823; c=relaxed/simple;
	bh=CZBjfm/Uo+tVFR8obqNLeTvMPi4TaAY535O3x2IVoio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N7OMnGAqYzizsVy2655ACNoFm9SpJF5fnmjvEJNLNzUfVE/ziK5G6xxjpMU6xg/bebcv6bcvfiLfo1ndID/MIpHrlJEiidCYT+ASCchxJpR5VtiGFiRb+H7FPpF7cCWat4djBkgBjRjka8Du4sEAwvFYijCmvnDev+OV2F2xAeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.it; spf=pass smtp.mailfrom=outlook.it; dkim=pass (2048-bit key) header.d=OUTLOOK.IT header.i=@OUTLOOK.IT header.b=ie3prHNO; arc=fail smtp.client-ip=52.103.20.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=OUTLOOK.IT header.i=@OUTLOOK.IT header.b="ie3prHNO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DwhRmpyPN9P2pC3I72JuI78LWsmnbZVNT8jiII7IBStvjQo5mjIeT2+anVXDHjL8gZOjcXPqINz3Qhjd5nfN/skWdzzCBg/Rii2J1cQ/KNbCNxpzpejgmoUqsp3GHecyO+tsCgBJXSZeCI4wDH62E4BhIZXKXOQTQMgIKo6FV6xEkIG/flIchcYm4g968mUGGxdCIfllTkGymHxdObrZ8jedoMjin4X3QwGZcl8HZB7YF2FqIaITY7fFjZQR4W1nTXPZAkaPyCJrlWu7X3EIBWuUx8+a/U8FDP38eq3vMXKoOoKD7gJuNuITRGuxPe1v4dYAlAKAVm8Pggd/sAgQCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JOFKRQIL2h68Xm19JG0blDtt7uspQumm9tbTaHH27YE=;
 b=D6dhaD4N801/8yBFD0bPDliyJhKjpPJb/Iv0+WEnck0NIEMAqf2M7Gjp3MP5Zb/x3NwUE4ksotFG1x9oX8qmA5iH4IVOUvj/3J2WE+ZRTjn5i4+QHJBQsRErWv2mhQuTXmM9N7nwrOfpmxQHGUe03vKrTemqu4ZyTIiPdx5xWwnx67Ie4iQXSalnQl4alN4Hr/9Za7K2nJSkYWvIRt/PK461ubFVqpQOBBLjKfnwCo6GOg8JTL7aIi2z8HESBzYYZT05wihZGURpTHdWPrzi3X0yfdzgmoQKwkAM1h/7XHrrr6e6vaC4oSWIsiC1bkYUeIqsP6nUc3hXRV4gPttw9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.IT;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JOFKRQIL2h68Xm19JG0blDtt7uspQumm9tbTaHH27YE=;
 b=ie3prHNOnXFu7ocReLIIj7PxhA1/z9+cvyTXqNMEVZ9BmswtoH61ov1rq+YcBIjqcHWSsYtzn973SN7TqgX5dGXbXrW7xbphR5fG6cYcCzlG3vs23D4ZuF2x3ARQqsJVLUzhAkEjyJTyQCgcbyegiGVFTDXc6dL+Umjdhm8O9+d/o17iVJeQ3quYVVt5o41syMd1eOIXqEpmp15XDTlbwBiG7geGSPTXb132CaGPgrRx/WxZOIebc7GZMUl5Q6WKlX3vCwLAHmFlUuTWg2rOYwmdenf1U84DGwDdZn+bn9Fe6y3XsbGc5iNP6uJ/zNQtTKRSe/Twk3AYtsnSEVRJcw==
Received: from DS7PR19MB7724.namprd19.prod.outlook.com (2603:10b6:8:d9::20) by
 IA3PR19MB8637.namprd19.prod.outlook.com (2603:10b6:208:526::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 13:26:54 +0000
Received: from DS7PR19MB7724.namprd19.prod.outlook.com
 ([fe80::70de:3c05:ac62:7f86]) by DS7PR19MB7724.namprd19.prod.outlook.com
 ([fe80::70de:3c05:ac62:7f86%5]) with mapi id 15.21.0223.012; Fri, 17 Jul 2026
 13:26:54 +0000
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
Subject: [PATCH 5/8] ASoC: aw88399: add channel setter for HDA side codec
Date: Fri, 17 Jul 2026 15:25:07 +0200
Message-ID:
 <DS7PR19MB7724E8A1AD36D1E623FA2A0AFCC62@DS7PR19MB7724.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <DS7PR19MB77247D9AD698CF0FF37DB58BFCC62@DS7PR19MB7724.namprd19.prod.outlook.com>
References: <DS7PR19MB77247D9AD698CF0FF37DB58BFCC62@DS7PR19MB7724.namprd19.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0013.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::18) To DS7PR19MB7724.namprd19.prod.outlook.com
 (2603:10b6:8:d9::20)
X-Microsoft-Original-Message-ID:
 <20260717132509.148321-7-marco_giunta@outlook.it>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB7724:EE_|IA3PR19MB8637:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f92e04e-6244-43f0-2391-08dee4071149
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|2604032031799003|5040399003|5072599009|51005399006|19110799012|8060799015|704163111799003|55001999006|15080799012|24021099003|16051099003|3412199025|440099028|40105399003|3430499035|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3b/PMjVP8Ksg39TqD4a8fXziCwSCq0ETHWTFOw7FwxULPpjdZuZeveHdMtm7?=
 =?us-ascii?Q?UXXf7MY4s4F1cxdWsYAM90sbOJJforEA1k+ij1C829uJCd6dumO/FIXQoZLT?=
 =?us-ascii?Q?ie4wUjS8GWF+xwe///ONaA57M4wGTyeZSYwTGwTRnLOK/7Rim1ySdkynjwK5?=
 =?us-ascii?Q?Q8dJ4xFHHxOGrLkAJ7MYm5oSpaZL/4St7+bps9X7AKPqJRaMF4pvwqSvt0Ii?=
 =?us-ascii?Q?3p3uPGMcVobV71Ffq9T66YtUktdQfwkGiLa8D8cl00FkZgQz4pycCLaJZuVu?=
 =?us-ascii?Q?v4+zcnK0i8T8vVdlPzLt3uMzgUcGc39/5Y0PYap2B1I7/NHy1/bujLwtBVAG?=
 =?us-ascii?Q?R1kmctEP6iUVMaHZSHM82V28+o//2Bq6mFHfG/0XNcP9gG/Cu3J84J1eEypJ?=
 =?us-ascii?Q?aED6JhOi1cnOhwUR/sT2pU8Dw/McfiU5WlQPmB+zGviSayhhLQ95Xf7Een54?=
 =?us-ascii?Q?1pMvX3Pesu6HZ8jYE1h0JzY76PP3ZpjwOq/HdubFF7DGt/LdnDIXSKNqL5cP?=
 =?us-ascii?Q?H7m7jedn64+k596ErhmfbpsTvU9hu9dlO6961DBnUpAE6d9UlkbPaA7L2S7E?=
 =?us-ascii?Q?m0SpgQ3nQDSw1z72aJIpH/fz4kRveXnrfMmtrRvOFkthxOWRz22eXnXezg49?=
 =?us-ascii?Q?nENGVFXeRYOG/GfK8Uh2oSPd3nuLs2+0g+uUHbu/KXMG4wXkYJaCxgSg/0mO?=
 =?us-ascii?Q?XYi4t3j+t+MKNgF5j/OJ9QBoFWbgb/uDkCwNQdBlvQ4UKawOo/5xWAIx+xUW?=
 =?us-ascii?Q?N3bDYfxAtdnC7ZWzcnj/2Ipw4jQfTQwrqBuk+7dhCLQuuGjrXm0HIE/q9CgC?=
 =?us-ascii?Q?RjliK5CjdA2x8NGiJhoZ94BSupvBScuymKYhChmTnJWVVt2h8mbRiNihiOVV?=
 =?us-ascii?Q?jjRTdZNo/43gpTfEiewnVOhLWR+bioMS4SKIG05OPmvYbrwMxlpi9YCmtD9P?=
 =?us-ascii?Q?h3dJ/6uZjljL50dSDb50uXibar89UXs4tlQCiL065H5e2m83AkioEUHR9F4l?=
 =?us-ascii?Q?gSm79VrYzXDX9cXCQhZozSD/baRa2F3mvClvPOvVpg09DH2YXmAEq8myF41B?=
 =?us-ascii?Q?vqx4qsBEZnXGVmiulH/uhZRNTiY7B4/fyD2kGn4KqCv8QlHqHGkQGD1eKF2/?=
 =?us-ascii?Q?7N/sL/FLvkNr?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/hJ0H0wE7dp+hlljid0zXeMCek/l/lRVKUm1K/vVkRwErsB8Fo5wvl1bXrN0?=
 =?us-ascii?Q?KBp0l7N4QJD6r+5zbMoNkiHgCTbFzh+qOhY0IiJNCPvi/2sm9oD7L8ny51ND?=
 =?us-ascii?Q?G7qY5Ocr7LN9ekzIP+KKHPRaMbZVKybQSBgsWqatNIhNOaHmLZW8ra/gASpw?=
 =?us-ascii?Q?uODdklIm5JzHn2HTKkeIXVD0lXlcTzWpwDZ4YUGp4FCrPmTqNC62HCJIUFsJ?=
 =?us-ascii?Q?4GNKWqm6PxO6nS2rrAmlIoZqzhAgV8+y1NO3/pyNRnxvaY0/dknOg7hcsWxp?=
 =?us-ascii?Q?CwuUMRg2pggTie0ZwjWQmLE7jReeQOmy9M7HGpYTlb1bMdpGYgKF7pJAqzKI?=
 =?us-ascii?Q?SEQIV0mCbfJ2dfterYGLsTRXjMumk6+RWc1u6VTcuqzOdkgeUeRatX5cBECb?=
 =?us-ascii?Q?qo2C0lk3Qk6ri+14KLO36RyaanIWaUy4y/HlzDcq8gmR82CD+n4AVarWl6rW?=
 =?us-ascii?Q?dsiLtmvaIeJMMJbyUMA6n9ruueZwrWae5NBZdeETL9qVI1AhBaqQaU+DC6XR?=
 =?us-ascii?Q?n3xfEfM4Jm3f0W1t66WaFOzvJS8SuuDtmu1lma54ebBu+F8bs4NlFKTRkIcJ?=
 =?us-ascii?Q?5w2SP/oes3GziKZbBmi24BPDMn5RZIhqvTpjFoC7kGi3vUcZS5STj2b0uvz7?=
 =?us-ascii?Q?jZL8L56XT9CJpAiZidnh2Gw1UxNlqR9JaXp2uz9sLIdkOYJxNjc8uu04J6Al?=
 =?us-ascii?Q?FlACQo94sUA7XPBlX+LFYO5PIUCEN33gxeFNZvWHEyNDJMgkwTc6LBqjP02c?=
 =?us-ascii?Q?/YkECI7QOVOCWr8n1W9OIj73sxMU2fNDsR6iw/SE39ZWSY+Tid03jILSuvTl?=
 =?us-ascii?Q?IDc0HUJt1gUSyPI6zjN15G/yKk6gdYh2S53uSv3bY4HkDK2ABzGn25hk54GM?=
 =?us-ascii?Q?SMyBCEupuYtPeW7LbvrpMlN8jD2Up4rnMwxGsBImaKpXnisCjr2QdbXZLxvL?=
 =?us-ascii?Q?IU3FcMclfJ6oqhixYrQYcEssFG98/nj1b0tat7tT5ui23Zg8yNbaWQEHnWm2?=
 =?us-ascii?Q?Nxn55OPH8S6WhjgxamBiiBsTA9TQvYYdPsj/fptVPAtC3GeqqB6UkjVPzIeM?=
 =?us-ascii?Q?R7+yH9S79G2fL56/PP3isJwLlxEJuCDsIWA7Z74M4uCcW/kXqcW1K+ZcejWs?=
 =?us-ascii?Q?pgeLw98o5pw/AmUgNzbWiAOpYntuBsrHdC7We+i8AqxY9Nh9nHNZ7pDwjH0T?=
 =?us-ascii?Q?Z7ANHraN54praqy/oXkXsf/BtTofu1nUO/uhTKPpllQY7XnH7YyGPn2FeEjH?=
 =?us-ascii?Q?EiGiyzmKdJzlXIAm+je7f+ymSy5TInenYQKFEHDkscYfvcZHNW3pD98iUe4l?=
 =?us-ascii?Q?a1QxMImKn8oKT9AIMsqTxKfFW6abgZJEnQYKUl5xUdxvYvYgp94wLpNdJSWU?=
 =?us-ascii?Q?H7VeVSV3+FESd4ZrkCt/ThX0CjtN?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f92e04e-6244-43f0-2391-08dee4071149
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB7724.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 13:26:54.1791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR19MB8637

Add aw88399_dev_set_channel() to the shared library so that the HDA side
codec driver can set the amplifier's channel assignment without
including the aw88395 device header directly.

The AW88399's struct aw_device is defined in aw88395_device.h, which
lives under sound/soc/codecs/aw88395/. Without this accessor, the
HDA driver would need a cross-subsystem relative include path to
access the channel field. Providing a setter in the library keeps the
interface clean and avoids coupling the HDA driver to ASoC-internal
headers.

Tested-by: Nadim Kobeissi <nadim@symbolic.software>
Tested-by: Xia Yun'an <imitoy@imitoy.top>
Tested-by: Munzir Taha <munzirtaha@gmail.com>
Signed-off-by: Marco Giunta <marco_giunta@outlook.it>
---
 include/sound/aw88399.h        | 1 +
 sound/soc/codecs/aw88399-lib.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/include/sound/aw88399.h b/include/sound/aw88399.h
index 3dbc37dc13d1..a1e0de6be8ea 100644
--- a/include/sound/aw88399.h
+++ b/include/sound/aw88399.h
@@ -609,6 +609,7 @@ int aw_dev_set_volume(struct aw_device *aw_dev, unsigned int value);
 int aw_dev_update_cali_re(struct aw_cali_desc *cali_desc);
 int aw88399_dev_get_prof_name(struct aw_device *aw_dev, int index, char **prof_name);
 void aw88399_dev_mute(struct aw_device *aw_dev, bool is_mute);
+void aw88399_dev_set_channel(struct aw88399 *aw88399, int channel);
 void aw88399_hw_reset(struct aw88399 *aw88399);
 int aw88399_init(struct aw88399 *aw88399, struct i2c_client *i2c, struct regmap *regmap);
 extern const struct regmap_config aw88399_remap_config;
diff --git a/sound/soc/codecs/aw88399-lib.c b/sound/soc/codecs/aw88399-lib.c
index 094a37b66fb5..5c7982891def 100644
--- a/sound/soc/codecs/aw88399-lib.c
+++ b/sound/soc/codecs/aw88399-lib.c
@@ -1401,5 +1401,11 @@ int aw88399_init(struct aw88399 *aw88399, struct i2c_client *i2c, struct regmap
 }
 EXPORT_SYMBOL_GPL(aw88399_init);
 
+void aw88399_dev_set_channel(struct aw88399 *aw88399, int channel)
+{
+	aw88399->aw_pa->channel = channel;
+}
+EXPORT_SYMBOL_GPL(aw88399_dev_set_channel);
+
 MODULE_DESCRIPTION("AW88399 common device library");
 MODULE_LICENSE("GPL");
-- 
2.55.0

