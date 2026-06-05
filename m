Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011017.outbound.protection.outlook.com [52.101.70.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE0F3F86E0;
	Fri,  5 Jun 2026 10:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780655311; cv=fail; b=qL6ETb1YvKgblv0bPleNXJM3a3n7HmcFGNBkCkMVzcJK0aku9QLV4SZvSJJFL7klaqUlLodi1+aa9JeKs1x1rd5IDMmpzRELsiREJZzDJXXUB/Cs7hhNH6K4AiHi14ayZ903AJdZA39Vp3o3qpcg4NBivCnJo0byur3Vzm6F1D8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780655311; c=relaxed/simple;
	bh=Ume6RmZ1vpqRdnEY+vl36jIqeAgrtYHu2Lw3PAk1MdI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=KrV9y7Y2xnQFqSs7bH9XRdPAtdZVXhToZh5h6Zrt/81XFwnL/0y5pIaVp/zLpuhdEWr8jL4D4vYqQZT+u8CPtzzc/2OVN3DY4XJ/KotUMfElESkDOhkA//y/Wa/hW7Xml++pM9pWxt1lgyFo/X3rtdpCJ6bp4sLO4gsMwItU6SA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=MbNAMwZq; arc=fail smtp.client-ip=52.101.70.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="MbNAMwZq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UB8B8PLmqzObxs1+/O4g4l6olt+clsbzo262ZZUjlc33178RCyKpdsxwTnxdYbpKQOpvmbLxryLLm+iZWnGWCAFVQu7Q2MbP+uKJZkuFCUTfbBVWn7hdWbRZk02gm3G2PoXwALxgJFh/jLaux8EfQTUZGomCOsH3X175blxkVtJpjkyZMKJD3RlKiznYyLidk69q8NNBPq4iyAp6RJOqQ4RayjBTqRrpoQLH57+UZFQt4nZ+dufB9Jgijyvxj+pu4LE/maYQVo3h+SVaPdt3Q7kccRE+nMxHu8kd+mnRZoK7iB0a6GKl+Fe78GBFStIzs1u23LINs5RLZSQd6aoKLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mmp9DWMVVvWO3Zf673XJZ6lB3h3n3LY1cXSdPMEKl/4=;
 b=jbqH+Ky05QC0OcLxsbeErZXc2i4S5cWoiHCzpdzh13UM3o24Rb6blTk9DwwvxZ/ZFlHeSba6I7TDofb8yAuH7PvsjKN1auulUIaE9CKJwrksUs3bmTur4kbK1mEKr8ACIAhAHr732ijdLqCFoLSBptgCBAJJv5Rb3dOU/QDAycbjNwAuyTdAwK0FzxyJR0lDsGe59x3NSILk07NyEvN4gzSlGf3XKf9NCS1kDLLl05eYQPDB72Olv/9u8FmSN4kbOA4CymDv3dQYBPdTa3UrSJ8qWFa+z85lPYK5Vn81AzyfqBc1cNXXMX5aBwStA+Mcdn+RZpDi5MyxbtuEj+vBkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mmp9DWMVVvWO3Zf673XJZ6lB3h3n3LY1cXSdPMEKl/4=;
 b=MbNAMwZqyiinwWvo6rkRGIqpN/77nj18qHpaNPJ7D183bxCVj9Ho9hcMnCUj1HvHCWY2QQjNMQvnT+E2ftRqarQS/gEUWb3d8r9vpYkB08faD5a19Iipu19IcM12tG3YhQyQdSV5c+vhC2IXowyEcCS2JAH/i/Ta7UKDxQpiE0Edhr7brnpIT+rO4WKHv77j+iFOy0NCZrhcDpoxqNOSWgSxJnJgc5RbjerK1NMeoh3T9WgZ7oeDCDR8cMU/R+zDGk3aWuviGbVnCdqnrEP3paLffZDsbOgRjw9qG96sPCERwNMkJg8+JGL/bBLy9cRm8O2Bgv8YBGhib026Ne7cOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9422.eurprd04.prod.outlook.com (2603:10a6:102:2b4::21)
 by VE1PR04MB7471.eurprd04.prod.outlook.com (2603:10a6:800:1a7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 10:28:26 +0000
Received: from PAXPR04MB9422.eurprd04.prod.outlook.com
 ([fe80::54e:28bf:aa85:d25d]) by PAXPR04MB9422.eurprd04.prod.outlook.com
 ([fe80::54e:28bf:aa85:d25d%4]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 10:28:26 +0000
From: Xu Yang <xu.yang_2@oss.nxp.com>
Date: Fri, 05 Jun 2026 18:31:18 +0800
Subject: [PATCH v3 2/2] drivers: base: test: add test cases for
 fwnode_for_each_child_node()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-fixes_fwnode_iteration-v3-2-44c18472e1d1@nxp.com>
References: <20260605-fixes_fwnode_iteration-v3-0-44c18472e1d1@nxp.com>
In-Reply-To: <20260605-fixes_fwnode_iteration-v3-0-44c18472e1d1@nxp.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@kernel.org>, 
 Xu Yang <xu.yang_2@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780655483; l=6135;
 i=xu.yang_2@nxp.com; s=20250815; h=from:subject:message-id;
 bh=h0IIgxUxdUYLoaLPYAuZAqxZuTWJUgYUKrk6ccCC3BM=;
 b=xbLRtG1A1s9XJGNLDXgNsIslDZ2xYrdYQ9sPkYPEychHvlxv4yto7/u7ThDjTYfeL4CjE1zuK
 sdVY2xptm+jCCN5LPX27BTerkrqg2ouaV9Y5NJWHCAYQVO2deYgziGX
X-Developer-Key: i=xu.yang_2@nxp.com; a=ed25519;
 pk=5c2HwftfKxFlMJboUe40+xawMtfnp5F8iEiv5CiKS+4=
X-ClientProxiedBy: MA5P287CA0232.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b1::16) To PAXPR04MB9422.eurprd04.prod.outlook.com
 (2603:10a6:102:2b4::21)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9422:EE_|VE1PR04MB7471:EE_
X-MS-Office365-Filtering-Correlation-Id: a3afa3d4-5ebc-404d-e98a-08dec2ed2dc4
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|19092799006|1800799024|3023799007|6133799003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 uiuw0cN0eqZtI6xkJHaXc/QR81icjnDpLNYnqHZICFb7Dol2qNtSDFmuQlmr9Kx68a0kr8fCEG0XmPLEg51Rc5t9Jj7l1DbhrSVyoOTIBdrmlfWoSGVVeNnawnXJNYw9DjGiaHE1QD67gR2E6NclICfL5e3HRx5zB+9w1TZLJFM45W0srQMEWiGz3ITgPz0c0uOU1ehVEXOn7U/HrQbmm2IMS3OnSDUYGZbDsGiPguxWDdbYhJp8erU4NozrzNOQvrGG6t3zXaEO39WopA3iKZd0yOtRmkc7zBWHmSmVntX+nCLrUfjMNKo4y66GlpWzhf7YIK+MHkdLB6HDDB4jGGG35aIV3A7cpYyBfAie4lUn4vjjrdub1kuDGuajt0TlCNMBd+g+LrmFBJ+Ah4xfLqKZiYz3bjWKS2D7QQLAEQgw6Q+9oRLU0D4VqE6H5lHLnlTQ84lTL0xKCv/4co7oUYXMwkrvOSv95pT1GrPqlskgGeWvT5VOuGtyFwOcTI0/mj5GVZdVL+pm9jNFCMSF4UNVG+o7mh8ERhXdMuGaCNSHgVEdbpezcI1akPCdfpmYK3Qje5VZtq0VowjRUXQ7jx8AivaNS/qTFwVLmDjSUCLmoU5TOAfFQHUj8YLskpqO8wEkhLHSwafFuupwGAy8UR8YzuXvsVVb7AAbS7wAHE07n3EnzQRt2iJi7kI8hH3N
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9422.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(19092799006)(1800799024)(3023799007)(6133799003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?dktWQUtYOE1KN3c0Tm9xQjBTY01BbG45VVFmbko1aFgvQmF3ckxjYlNUS0g3?=
 =?utf-8?B?SytlOTB6eGRTUlcrdGVGRE5qUk8rWlRabWJEcit2YzhncHFOYlhTakVQTlVv?=
 =?utf-8?B?NTJ3Vmg5TWgvZWhxMFBVQ24wYWROYTRTblRXbEozeXFzaVRxTlBDajlVMmNt?=
 =?utf-8?B?RFhZUys2MHFtUjRpWGJ1c2UrWVFNcjZzbU1ZUzYvS2lLTklpTzdvQjQxMlF2?=
 =?utf-8?B?bERIdU5QLzUreiszeGpjYzNTR2FvUDZBQnpyQWt6cW9BUlJMU0lYQjNjTHhS?=
 =?utf-8?B?Y2tVUjdxRzROMnRNWTQ1dkcwdVJ6YVRpdytoWmhUMFpxVitQMThTL0hjQS9r?=
 =?utf-8?B?dUxkQmNGYTZOTmg3ckRTcmxSSzQ4RTc4L1lnV3JnQmdnbGtUZnd6NDkwUmZr?=
 =?utf-8?B?Wnh1R05lWTJDU0RMMnNZME5uVU5tYjFWcDgwUGJpR2hSeFBzSXNaOFZRdDZW?=
 =?utf-8?B?QUpONTFLYldpemZCZG5YTEIzUWc3U2wyMW94N0h0RElaY1NEbmhPcXBiVmdR?=
 =?utf-8?B?MHNRaXJ0Q0p2c0xHU1hxdzFjMUYyNUNlNUxSRS82Qm53WkNVSUE5Y0xVVzBY?=
 =?utf-8?B?MFdHWnFOVHQ5cGtGT21ERGRabGt5b1hpMS8za1hqL0lvTXBFalU5OUFEaUNQ?=
 =?utf-8?B?MFpNd09PdDgyZEI4d0VUSGROLzdXVHg3dE9OcHlBOVM5RjcwbGp1UjFzWlFx?=
 =?utf-8?B?Sm9nQnNVVk9MQ0FMNko0MVFZOFFTT3ZPbVR2UWtSN3B0T1ZjeSsvVFFaYncx?=
 =?utf-8?B?WDdhSTN1dk12Tm9GcStnRytBeWVyZHNXLzRhVzVmTTJWZGVkVlY2THA0ZGhy?=
 =?utf-8?B?WHM2SFlwVjgvRVdQWWZrM2N4MHNabnNkMEJKMUIwV1dsY1RDSnhzZW5ocUZp?=
 =?utf-8?B?MUcwZFIxMWdsWGNOSXVCa0xvRUIrY2xWUlpGQUhhYjhXYmxZSlZhYmhQVzdw?=
 =?utf-8?B?TUNFMW9rYk1zV2hmR0RMaCtXNnFUK043aXg2T1RrWFE2eVBSK09waEJ1QWVo?=
 =?utf-8?B?OFF6TThXalNJUlZUeERkMEZXbUJiZ1dmK0lubFcxb1VSSzJQQkF4QmdxWW1L?=
 =?utf-8?B?VzlqNG1vUjYyT0ZQdXQrNzlMVkhtYWVSN2dNdjJpc0NIR0hLbnNmdjJFd2hB?=
 =?utf-8?B?UmNDNk9yekhSd1EwVWsvYzZRZEtURjYvZ0xmeXZYNTNBSk91NUErMFBwZHlv?=
 =?utf-8?B?bEIyVjBXOE1LSWZYbG9ud1RhK3BycGFxc1RaanRUZnVuL2VtdWZGOXhDcTdE?=
 =?utf-8?B?NGw0eUZ2cnFzUTBWZ2dzVlFyTC9pM3UxUzdaV3d1QVNaeFVHT21qYW1xb3c0?=
 =?utf-8?B?dUswVGZBNGhLNEt3TzFRWDBZYjFaVjFETFlGdU9lU2Q1Wnlid0dhcEphUVox?=
 =?utf-8?B?RGFYK1NIY2JxRnlTUUVVeUFwOWl2a3RqN0pCUXZFOHprVnZQZkxLY04vZnBV?=
 =?utf-8?B?b0dIa25yUFlpRUcxT25UNllQcEpDTS85NE5mUS92NkFOV1BIVkUzY0o5cDhq?=
 =?utf-8?B?YkVMRG0wblgwM0N5MWlBVkw0Q2dmOFN4MnllNGtSSm5hcC9tUnFZV3pwZ0h0?=
 =?utf-8?B?RjE2UTBGNTBPdDF2U1liQW1NbXBlZTRodFlFU211NTAwcFIwcGVaZlFacHFR?=
 =?utf-8?B?OVp1YnFnemJjaTh5dld2WWxmMWxtd1kyZGlsNGU5YkJvZmZLTTBEVi9rVEJn?=
 =?utf-8?B?aTF5WVhtcDZHSm1HN25NQWJ2YVVGOVpwMGl3L3ZyZ0p1dnpQLzhLT3FrTkFr?=
 =?utf-8?B?bi84ZVV1Z1NuOXJ3SnRCUWJIWkVxRjRibEhTV0N2RWZuOFZmNElRQk5zV3Zq?=
 =?utf-8?B?WXRyQ0lrL1pSdWlMMExCZWljUmUraHc4K0gyUFFuMzFiYnkyWVlOMVduV1Nn?=
 =?utf-8?B?Tjl1ZTAzbEsvc0E3YXp2R0MvL2xpaUxuVWtTUTNWd2J2RllVcVgzZmJXMkVL?=
 =?utf-8?B?bzBjS1J0RTBkeEg1L3NnR2M1TWVtbmpTdWd3eFNZTDU3ckxYVmUzTVFVMkZa?=
 =?utf-8?B?dkJRQ1pGaWg5bWZzWldJVjVFeXB2MU9MOFovSWNCU0VWQUs2MnNFbkxkN3lw?=
 =?utf-8?B?RGVNMTJ2RitQdVpjdVpGbHRsQUJXcjBVazc3M0hncW80UHc0UFhaM1ViQ1Vh?=
 =?utf-8?B?LzVVTXBHdytLc3JSVWRydE9BMG5EaGhhb1k1MEZMR2V2amwvdUNPVWVwM1Vo?=
 =?utf-8?B?ckVmbVNtcFlyQ2s5QWNWZTZ6bUdwdUZ6aDVrWWVQZzdjWmt2eVA2WUpCcTRV?=
 =?utf-8?B?MnBUODc5bmt5NG5GR2JjUlRKeG1pR3BhckJPNU9tZHJySEM5NUc4dnZRdi95?=
 =?utf-8?B?QjdIOG9HckIyYkU3TWZaK3E1RFVxaENBbmt3Y3VFS3h5dnBEb2hWMHdKc3FT?=
 =?utf-8?Q?ifTP4EFZugrt4wV8K6WsgTVJVSTIryicE3ipi?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3afa3d4-5ebc-404d-e98a-08dec2ed2dc4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9422.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 10:28:26.6512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jZAadIXTMCUpo6Nj9+F27XrGcY+AcnlI+AIX+VLEfQDsAibxpoI2O/9IJVCgleflIMsiWl/pKdjryIPARy8xtPaXGqZOUH/EJo0nhBDW59ruBPTiVCDlwgE5kDm+qzw+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7471

From: Xu Yang <xu.yang_2@nxp.com>

Add test cases for fwnode_for_each_child_node() API.

Test command:
$ ./tools/testing/kunit/kunit.py run property-entry

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v3:
 - new patch
---
 drivers/base/test/Kconfig               |   1 +
 drivers/base/test/property-entry-test.c | 136 ++++++++++++++++++++++++++++++++
 2 files changed, 137 insertions(+)

diff --git a/drivers/base/test/Kconfig b/drivers/base/test/Kconfig
index 2756870615cc..95fc42e91564 100644
--- a/drivers/base/test/Kconfig
+++ b/drivers/base/test/Kconfig
@@ -17,4 +17,5 @@ config DM_KUNIT_TEST
 config DRIVER_PE_KUNIT_TEST
 	tristate "KUnit Tests for property entry API" if !KUNIT_ALL_TESTS
 	depends on KUNIT
+	select OF
 	default KUNIT_ALL_TESTS
diff --git a/drivers/base/test/property-entry-test.c b/drivers/base/test/property-entry-test.c
index a8657eb06f94..d100cd6c17e8 100644
--- a/drivers/base/test/property-entry-test.c
+++ b/drivers/base/test/property-entry-test.c
@@ -6,6 +6,7 @@
 #include <kunit/test.h>
 #include <linux/property.h>
 #include <linux/types.h>
+#include <linux/of.h>
 
 static void pe_test_uints(struct kunit *test)
 {
@@ -489,6 +490,140 @@ static void pe_test_reference(struct kunit *test)
 	software_node_unregister_node_group(group);
 }
 
+static struct fwnode_handle *create_device_node(struct kunit *test,
+						const char *name,
+						const char *full_name,
+						struct device_node *parent)
+{
+	struct device_node *node;
+
+	node = kunit_kzalloc(test, sizeof(*node), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, node);
+
+	node->name = kunit_kstrdup(test, name, GFP_KERNEL);
+	node->full_name = kunit_kstrdup(test, full_name, GFP_KERNEL);
+
+	if (parent) {
+		node->sibling = parent->child;
+		/* set the node as the first child of the parent */
+		parent->child = node;
+		node->parent = parent;
+	}
+
+	of_node_init(node);
+	return of_fwnode_handle(node);
+}
+
+/* Verifies that fwnode_for_each_child_node() can output correct children */
+static void pe_test_child_iteration(struct kunit *test)
+{
+	struct fwnode_handle *of_node, *of_node1;
+	struct fwnode_handle *sw_node, *sw_node1;
+	struct fwnode_handle *child;
+	int error, i, num;
+
+	static const struct software_node node = { .name = "sw" };
+	static const struct software_node node1 = { .name = "sw-1", .parent = &node};
+	static const struct software_node node2 = { .name = "sw-2", .parent = &node};
+	static const struct software_node node3 = { .name = "sw-3", .parent = &node};
+	static const struct software_node *group[] = { &node, &node1, &node2, &node3, NULL };
+
+	static const char * const of_child_array[] = { "of-1", "of-2", "of-3" };
+	static const char * const sw_child_array[] = { "sw-1", "sw-2", "sw-3" };
+	static const char * const of_sw_child_array[] = { "of-1", "of-2", "of-3",
+							  "sw-1", "sw-2", "sw-3" };
+	static const char * const sw_of_child_array[] = { "sw-1", "sw-2", "sw-3",
+							  "of-1", "of-2", "of-3" };
+
+	/* 1. Test OF node child iteration */
+
+	of_node = create_device_node(test, "of", "of", NULL);
+	create_device_node(test, "of", "of-3", to_of_node(of_node));
+	create_device_node(test, "of", "of-2", to_of_node(of_node));
+	of_node1 = create_device_node(test, "of", "of-1", to_of_node(of_node));
+
+	i = 0;
+	num = ARRAY_SIZE(of_child_array);
+	fwnode_for_each_child_node(of_node, child) {
+		KUNIT_ASSERT_LT(test, i, num);
+		KUNIT_EXPECT_STREQ(test, of_child_array[i++], fwnode_get_name(child));
+	}
+	KUNIT_EXPECT_PTR_EQ(test, child, NULL);
+
+	/* 2. Test SW node child iteration */
+
+	error = software_node_register_node_group(group);
+	KUNIT_ASSERT_EQ(test, error, 0);
+
+	sw_node = software_node_fwnode(&node);
+
+	i = 0;
+	num = ARRAY_SIZE(sw_child_array);
+	fwnode_for_each_child_node(sw_node, child) {
+		KUNIT_ASSERT_LT(test, i, num);
+		KUNIT_EXPECT_STREQ(test, sw_child_array[i++], fwnode_get_name(child));
+	}
+	KUNIT_EXPECT_PTR_EQ(test, child, NULL);
+
+	/* 3. Test OF (primary) + SW (secondary) node child iteration */
+
+	of_node->secondary = sw_node;
+
+	i = 0;
+	num = ARRAY_SIZE(of_sw_child_array);
+	fwnode_for_each_child_node(of_node, child) {
+		KUNIT_ASSERT_LT(test, i, num);
+		KUNIT_EXPECT_STREQ(test, of_sw_child_array[i++], fwnode_get_name(child));
+	}
+	KUNIT_EXPECT_PTR_EQ(test, child, NULL);
+
+	of_node->secondary = NULL;
+
+	/* 4. Test SW (primary) + OF (secondary) node child iteration */
+
+	sw_node->secondary = of_node;
+
+	i = 0;
+	num = ARRAY_SIZE(sw_of_child_array);
+	fwnode_for_each_child_node(sw_node, child) {
+		KUNIT_ASSERT_LT(test, i, num);
+		KUNIT_EXPECT_STREQ(test, sw_of_child_array[i++], fwnode_get_name(child));
+	}
+	KUNIT_EXPECT_PTR_EQ(test, child, NULL);
+
+	sw_node->secondary = NULL;
+
+	/* 5. Test OF (primary) + SW (secondary, but no children) node child iteration */
+
+	sw_node1 = software_node_fwnode(&node1);
+	of_node->secondary = sw_node1;
+
+	i = 0;
+	num = ARRAY_SIZE(of_child_array);
+	fwnode_for_each_child_node(of_node, child) {
+		KUNIT_ASSERT_LT(test, i, num);
+		KUNIT_EXPECT_STREQ(test, of_child_array[i++], fwnode_get_name(child));
+	}
+	KUNIT_EXPECT_PTR_EQ(test, child, NULL);
+
+	of_node->secondary = NULL;
+
+	/* 6. Test SW (primary) + OF (secondary, but no children) node child iteration */
+
+	sw_node->secondary = of_node1;
+
+	i = 0;
+	num = ARRAY_SIZE(sw_child_array);
+	fwnode_for_each_child_node(sw_node, child) {
+		KUNIT_ASSERT_LT(test, i, num);
+		KUNIT_EXPECT_STREQ(test, sw_child_array[i++], fwnode_get_name(child));
+	}
+	KUNIT_EXPECT_PTR_EQ(test, child, NULL);
+
+	sw_node->secondary = NULL;
+	software_node_unregister_node_group(group);
+}
+
 static struct kunit_case property_entry_test_cases[] = {
 	KUNIT_CASE(pe_test_uints),
 	KUNIT_CASE(pe_test_uint_arrays),
@@ -497,6 +632,7 @@ static struct kunit_case property_entry_test_cases[] = {
 	KUNIT_CASE(pe_test_move_inline_u8),
 	KUNIT_CASE(pe_test_move_inline_str),
 	KUNIT_CASE(pe_test_reference),
+	KUNIT_CASE(pe_test_child_iteration),
 	{ }
 };
 

-- 
2.34.1

