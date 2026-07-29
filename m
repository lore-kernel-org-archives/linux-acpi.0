Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19013082.outbound.protection.outlook.com [52.103.7.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBE6443314;
	Wed, 29 Jul 2026 09:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785317634; cv=fail; b=YLu/i1UaItNfIgfx5MbBnhUJNHD9Y7pI0kwv8JDF3jI3mHORD1C8kTX0Yuwa0OScRbza6rmw0NBtvUw90nzOOZLjdNwFivwEIesmhPGjKvSHrA5ujmYIUHwOl1sgTEusxpralTZk47wwPCdXd9DeKJK+QJkOEaQuXlO4HBZk1nU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785317634; c=relaxed/simple;
	bh=RCmcOx/4wpbwYjVO1jyjc5LcZjHJOuRNND0tgOmpZPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I+CMCJLseavtUyAFlk4Acvl6mHmfoflI9icTuIS+mU+/9Vi80RDRq81AAL+tKmhI+2/sxNkRGIhei22RMD6WbVRy7t3EBTOUECCwXiiKihOgBKL6jSGyumAPJ9Ytf9uyG659nKCxIMZejjntdcEKZLFx92KgymHjr3kBB3pebOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.it; spf=pass smtp.mailfrom=outlook.it; dkim=pass (2048-bit key) header.d=OUTLOOK.IT header.i=@OUTLOOK.IT header.b=jWEyQoIZ; arc=fail smtp.client-ip=52.103.7.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=OUTLOOK.IT header.i=@OUTLOOK.IT header.b="jWEyQoIZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b7gpI5uXjyDKBr1ZeJ+0ymgcUk95qoXHIscuo0e2WxjchL7xbZzbCoERU/dLptNITfmFF44unNWrFxsD3MaKIJGxM4ENYHBBsehh/uKbUARq1KdeGHfpfacyBpu0+yc5THLlm5RkI7/w1jTro49LhH2vZs4oe0Stxz9iYnAc8HXGOHyf1CUOjut32Y5dRJI84Cxs/Fr/VytX+ft+R7CUKvdmzRwJBuVHUQTKaEkxC0dLphg/bMg2lf+lSJeiB/6VbKP1b5g3eBUye/dMR1xyXCbb+sGPUCFFu8bqpG0bZjsry5+jtvevJEW3O2mdZAj/aFh7Yrn/EUaXrQqg2u3/Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m61YcO9mtj215JnupLLNnNvxwji51yXy8p6eGpsbp+Q=;
 b=lPJzKLAxh3W6JVONvlY0qqrtz5oD93xqqOwA4D5H1hsMW7uf9+4Po9vbcNILfXyRlkyBUUVpQqUEi+84xgix7STpo0Jl/DZnogRJiCkioSmbu+nHO4C7kW8ldKrfOUpzX9l/EOXImF7qYHoRy/MuAIDhHKGrYXBFEF28zs1p8xOZ+0pUW9XZJK8rOPQsDHpZNfjSeGOk1mtNGKEaGLlvvcC1YQRtBTvCi+eBod5uwDu9g8ZD4UEua6JPxyld+z0wrvMA6b/QmFg7jGryyy+6B/RxIOptoIn2TFvX6vaxpbQRRm3TI/8JViDnjQ6LpjGjyeD5aIrhOzpTMUqZ5/skhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.IT;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m61YcO9mtj215JnupLLNnNvxwji51yXy8p6eGpsbp+Q=;
 b=jWEyQoIZF1KrFLvnIJCXoqloDzCK//RHehdtufEeyvXJEyfg39SE9a9BMMrwuxPSHT/mOEcyYRPXm6fri8di/yIaYEC2YnQXATI+DxbaopEFoTEtGxTxaelTRwk2AtaqrNkzGcaiKMc9iAxinyu4C33BivMjEIkJSK3ksaWREAvswN6kHaJmx082WX1gtuMzNVKXTMMwMU8onstGBAWZUhOikax13OEQLIsRZ+8YdlGBmzI/R6kflLAr3xqr9snatdQNy3i+EpaDaZTFFd559cPjNQq7wyn8yAr3AdRndTnRZO5Qt0MGPNfzIjna2l27VlSQ4DpxwjGdjykbHkE6PQ==
Received: from DS7PR19MB7724.namprd19.prod.outlook.com (2603:10b6:8:d9::20) by
 DSVPR19MB997523.namprd19.prod.outlook.com (2603:10b6:8:3be::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.13; Wed, 29 Jul
 2026 09:33:50 +0000
Received: from DS7PR19MB7724.namprd19.prod.outlook.com
 ([fe80::70de:3c05:ac62:7f86]) by DS7PR19MB7724.namprd19.prod.outlook.com
 ([fe80::70de:3c05:ac62:7f86%5]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 09:33:50 +0000
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
Subject: [PATCH v2 1/3] ACPI/platform: add AWDZ8399 to serial-multi-instantiate
Date: Wed, 29 Jul 2026 11:33:13 +0200
Message-ID:
 <DS7PR19MB7724431AE60B3D2280E73492FCCA2@DS7PR19MB7724.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <DS7PR19MB7724AB9AA5096BF2F00014B0FCCA2@DS7PR19MB7724.namprd19.prod.outlook.com>
References: <DS7PR19MB7724AB9AA5096BF2F00014B0FCCA2@DS7PR19MB7724.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MI1P293CA0029.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::15) To DS7PR19MB7724.namprd19.prod.outlook.com
 (2603:10b6:8:d9::20)
X-Microsoft-Original-Message-ID:
 <20260729093315.20897-2-marco_giunta@outlook.it>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB7724:EE_|DSVPR19MB997523:EE_
X-MS-Office365-Filtering-Correlation-Id: bfcff71b-a56b-447a-7853-08deed547f6e
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|25010399006|55001999006|24021099003|5072599009|6090799003|51005399006|8060799015|23021999003|19110799012|3412199025|440099028|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OUtILzB3alB0K1cyZTlweGpCdFNTOHBFSzNJbUpxek1XYnRrOHg0eWFQbGpY?=
 =?utf-8?B?MHpKamtuOWRoV01mM1dZTnk0cGprYjZFQm55bTBRVS9BVHlpZ3hsSnhrRUU4?=
 =?utf-8?B?cHhRRTNuQkQ3M2ttUDZkTFdSalJncFJMU1hqR3pVQkQ4NmFLNDZqNG1yOFZk?=
 =?utf-8?B?bWFLdHdxQmtVWGlickxhQlVXWUJpK0MzbEpyL2M3ZjFHNUJOWkFCUFFaenMy?=
 =?utf-8?B?Qi9DM1B4V2JQanR0UEJUd3lSMDAra3NDbmEwNEZXVkYzWU11ZGRna0ozakx1?=
 =?utf-8?B?S3h0UTNqOGErSHhFMEdkUzMvNFZ3RzdLbjBQcjhvSkE1MDRBR2hqOGZDUW1Q?=
 =?utf-8?B?Um1RRHhuZWlWWTVOc0pMby9pZ1IzcWhiR1prT3ZGZzRwTGpOMkJjN2dUNFF6?=
 =?utf-8?B?N3ZyOGZGRUVvUS9GSVZ5Z1QvS1hGanZidjVTZ2tnMUVqMkNNK1NGNGhlZVc1?=
 =?utf-8?B?a2dySWJLTlVLb2xydExTMllpMWRZSmhYdDVkR0ZZci9PSGszOUFTc2xFVWdD?=
 =?utf-8?B?QVkwZ0RCbC9NWTNtUTRQZFl2djI4WnBVRFc3QUFhT3JlQkEyNFR0UzFLWm1s?=
 =?utf-8?B?WXE3MTViV05YcG1hWHltNC84dUJJbmg1VEZ0TCtBTThBZVRQVlpTazhCdjFy?=
 =?utf-8?B?TkZmZWpEdzF5K01rL1B1QitadWdEWkNVMDIyWVN2YndNOUxQRUU4MmxIU3N4?=
 =?utf-8?B?cHprczBpajRlRHZJalFBY2NoeG9XbWpZZmVQL1VTQnZnYVI1Z2RHQjRGTllQ?=
 =?utf-8?B?czBXMCthNDF6QWlTR2pZeTQvT0tkZGpUYzIwMENtc2VlUEV6YTh4amU0cmZl?=
 =?utf-8?B?dXhsWmJRZzFyUXBWbjUvVjhpTWNBNGptOGRXTTE0K0M2WHROWDdMRTVZUkVl?=
 =?utf-8?B?UkVseXhFL0R5a2h0cFB3K3hGRnB1ck9rQk5TdS94Mks3QnVJSmYvT2NyM1hz?=
 =?utf-8?B?emp6S0xZT2lpTDFaWnc3dGxTS2dMTTI0QnRjNGVGSUMxYUZSSXdBM25KN3hk?=
 =?utf-8?B?RHMwbXR6a3JMbHN1NHBTaU1mdWIxbmdHWE8zdStjTlM5RHBjc0lXMGxNRUZq?=
 =?utf-8?B?ZlRKc0ZMTktBZkZTVHd1TDZiMXF2YkVlWGdjQWx5RWIrbDdoT1hiV1IrdE5P?=
 =?utf-8?B?Y1JGRlNFeXlYRVlpZFVUbnRlTnRvdWVvdVR4WTQ2K3BWWEZGczV0WG5SMlhi?=
 =?utf-8?B?MU5KQzl3TEtGNkNwdlRtVTVNTjE2YlNMdzZzVnNDbmhCVVM5aTZ4R3RRcitt?=
 =?utf-8?B?VENIYTRGVjdzNGlUYkR0L1dJbXdDalMxbGY3SXUza0VkK25DcFBFc01yV0t6?=
 =?utf-8?B?ZUpzZGVrYkdyTDRkNHE3MFdpUkNKcEQ0OEoyVGZuR3o0dktrL1BVNkdteXhZ?=
 =?utf-8?B?ckoyUnhXM1hyb0E9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dms2RU9semVzd2pSMmJXNXlIMVJVa1A0eXVJN3VETXNRSUNMTnZVTnllNUc1?=
 =?utf-8?B?SjdQYTA0bExONzdPTEFHU2hWWVY2WXBISjYyZlBsZVl0aERSb3JJUHlDYVJH?=
 =?utf-8?B?VzNyd1lKVGhIMExvbzJieDQrZHhOK1FFeU1ZbWJFVjJXckcwOHpDNW5wN2Fz?=
 =?utf-8?B?bERjUG92Qk9pQU0rckV3RFRPL28vQmtUeTlZOGplUk5xUTBCZlVRUjBHTlg2?=
 =?utf-8?B?ZjVHTWM0RmFSRHdCSlZ1S3BsV3EraDFNUWRzend4TSs1bXFkVWE2cFhTVWNl?=
 =?utf-8?B?RkcvRzd5Z3VJUURPcTNEMXhJNHBWTzdDaUE3K2pIWVBZVWY1U3hSK25sTHhX?=
 =?utf-8?B?Nnp1S1J6dnphejI1a0hjb1lLWFJxZjBGaWlKdmx0eGprN09pVitXaDB0ekg5?=
 =?utf-8?B?c3VJNC9lTE4rNDI0QWpjQnRCb3U3VmpaMWhzVlpFV25HT0hSdTFDZHphblZL?=
 =?utf-8?B?RUFYUFNvSndQbHdpQUxhdm9jNi9IbFZBQ3hFTzh3OWphajU5VFpFMW1oS3Zw?=
 =?utf-8?B?a3pDb2psSFZHamJjQzQ2Vlh2M0RjaGZEby9veGdKYUh1V04wSStQa1RiUjFJ?=
 =?utf-8?B?Sk5vQkx5b2pFNUNCbXBWMnZKUStpNEJHbmJwQXR1UGt2NWZpTFhoLzdOZHlT?=
 =?utf-8?B?S3BCUkJQYXZQL1JOMWZkbEVGRUZON1NSYjZyblhUWXAvMGE3d2JjUkdydjQ2?=
 =?utf-8?B?bFlSOGFadUc2RDAwR3dlNTlBVnc5a1pYZHQ3VXIvQ04xTjlqMkl1SzhQUmZ0?=
 =?utf-8?B?M3NQSGlvMGVxWE1OWEhtbmVkQUxYUldwQlZYNytwbitwMEFhWEtPOWhsZFNy?=
 =?utf-8?B?N3lCNDl3NS9TV2VLUmhKZGJRVm5KZUxVcmxHU0RTbUtIS0tHUmhqdnYzOXdX?=
 =?utf-8?B?amhFVE5xOSsrTS9TQWZnT3hLL3FnK0dyZjNYRHFCQ1ZFVm5RWDk2SzRvKzhY?=
 =?utf-8?B?cU0wWlJDLzZoS21RcUFkNTFMQnRmbGFLOGRqbVpVYkdZOVZFQTQ5ZjZ6ejdS?=
 =?utf-8?B?bUN2VXQ1N0RpbXdETUJsUC93UVhhckZLT2xvMm91WWhzRURrZzVWWS9peUdt?=
 =?utf-8?B?ZmhhSThMNTdTMnFaUGR4MDJYWFNYZVFhYnBXaXFOWXpwb3BBY0VoUTFETjN6?=
 =?utf-8?B?WGxPY3JPQ0pyWGl4T1VGbmNMNzZxT3RHU1A4VXJYY3VNcXVnelBWSW1KNnho?=
 =?utf-8?B?VXNsVzhsalpQY2F5aUJHdVNLbGxkSFZSWE5RWXg4OVA4RjI3SUh0M01RaUh6?=
 =?utf-8?B?NC9QdjQ4djN4TGhZaTE1Q0xhMlhnUkhtNk45NXJWdWkrcVE1UTJpTTFyMlcr?=
 =?utf-8?B?eWhadWJjSXlpYUxNRWZZTmdDT2pOdGVtZG5VWWhYcW1pMkMwRTA4c1dOZmc4?=
 =?utf-8?B?UXJXWmZyb0dGbVpBbDJPbEY1WXp6WEt1Q2h0bExrZkNKd3pBcEx0SmpuVkdn?=
 =?utf-8?B?YjJlOHdCUnlKdEorbGJjdHpCQnRER2pzT1Rwb0t3cmlJS2JyK2UySlVEcGpv?=
 =?utf-8?B?bmJ3OTMwN0FwTHNpbVdpY3UzV2orNmFmd21lNWQ0Q2dYME5pOUIwR3hFZUho?=
 =?utf-8?B?SmFaY0NGTlFWSy9PbHM1NEFqbjllODB4MFo3SEkrSWRpUStOVW5xQVAwckdT?=
 =?utf-8?B?clVjRXZycmNhbGVZdkRwRDRQMTVpay9VRERMbndIcEdzMTdhemRtdW1HbFlr?=
 =?utf-8?B?d3dWQVVqeFR6N0o4Qkh4UVdvOHh4VUVzMU9wZ3REUU9sMmRxdkNZeXJRaFdz?=
 =?utf-8?B?ZEw2WnNUVDdrQ09tZXI2bXBwRDhNSmxhOE5HYzRQSjZzRkJjVUpCbUZLVU1h?=
 =?utf-8?B?VUZpQWx1UHpiUk1tWlYwNnFJaXJZL0c3RFkzSms2K1JEZVNEVk5JRmkyejBJ?=
 =?utf-8?B?YzQwdXpTVjlCbkdKdW81L3RYVXJFcUhtaHhOWEFRcFBoZVdUUk16eUtPQ2R1?=
 =?utf-8?Q?gv+oGatI/C0=3D?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: bfcff71b-a56b-447a-7853-08deed547f6e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB7724.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 09:33:50.7332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR19MB997523

Register the AWINIC AW88399 ACPI hardware ID "AWDZ8399" with the
serial-multi-instantiate driver and add it to the ACPI scan ignore
list so that the two I2C amplifier instances on Lenovo Legion laptops
are enumerated as separate I2C client devices rather than a single
ACPI platform device.

The SMI node creates two instances named "aw88399-hda" with
IRQ_RESOURCE_AUTO, matching the pattern used by CS35L41.

Tested-by: Nadim Kobeissi <nadim@symbolic.software>
Tested-by: Xia Yun'an <imitoy@imitoy.top>
Tested-by: Munzir Taha <munzirtaha@gmail.com>
Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
Acked-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Co-developed-by: Yakov Till <yakov.till@gmail.com>
Signed-off-by: Yakov Till <yakov.till@gmail.com>
Signed-off-by: Marco Giunta <marco_giunta@outlook.it>
---
 drivers/acpi/scan.c                             |  1 +
 drivers/platform/x86/serial-multi-instantiate.c | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 9a7ac2eb9ce0..4f4552b1551b 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1752,6 +1752,7 @@ static bool acpi_device_enumeration_by_parent(struct acpi_device *device)
 	 * by the drivers/platform/x86/serial-multi-instantiate.c driver, which
 	 * knows which client device id to use for each resource.
 	 */
+		{"AWDZ8399", },
 		{"BSG1160", },
 		{"BSG2150", },
 		{"CSC3551", },
diff --git a/drivers/platform/x86/serial-multi-instantiate.c b/drivers/platform/x86/serial-multi-instantiate.c
index 1a369334f9cb..3e89fcdd45f7 100644
--- a/drivers/platform/x86/serial-multi-instantiate.c
+++ b/drivers/platform/x86/serial-multi-instantiate.c
@@ -307,6 +307,15 @@ static void smi_remove(struct platform_device *pdev)
 	smi_devs_unregister(smi);
 }
 
+static const struct smi_node aw88399_hda = {
+	.instances = {
+		{ "aw88399-hda", IRQ_RESOURCE_AUTO, 0 },
+		{ "aw88399-hda", IRQ_RESOURCE_AUTO, 0 },
+		{}
+	},
+	.bus_type = SMI_AUTO_DETECT,
+};
+
 static const struct smi_node bsg1160_data = {
 	.instances = {
 		{ "bmc150_accel", IRQ_RESOURCE_GPIO, 0 },
@@ -405,6 +414,7 @@ static const struct smi_node tas2781_hda = {
  * drivers/acpi/scan.c: acpi_device_enumeration_by_parent().
  */
 static const struct acpi_device_id smi_acpi_ids[] = {
+	{ "AWDZ8399", (unsigned long)&aw88399_hda },
 	{ "BSG1160", (unsigned long)&bsg1160_data },
 	{ "BSG2150", (unsigned long)&bsg2150_data },
 	{ "CSC3551", (unsigned long)&cs35l41_hda },
-- 
2.55.0

