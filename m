Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795765783;
	b=iGlhEflS4m8MNN+CXvG3Oxyq6T/bgvBaA8fNDaUZbQkeztlX08JUUeXnOr8PvdX/2EFD
	 XTc4+of7wsSRVqSkS9bIzFEZl7tt511pLBCBx+8viNqalm5zwSueQUDJ3QRSgF0yquvSp
	 a4n6w2IZ9esLK7yrJx+3SEzZ5HFjLzP+vVjfP2KnKEPDT0usN/lioWsXqdxUmmUV8tKqH
	 9J8M7h8fyx+r+qmeLVVzdqB5TwFjpaG4FOGqKZu9PB5SrkD/+y6sx2sAfLFhi685J8ezd
	 vaeXBGJ3P0zlp2ndlDnN1ndX/JeylNb5IQF8sTzDAVMHN8YdNxZBPpAp6raO3xj5y1Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795765783;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=1kwJ5ZjMPGAIDm+BCPHeJSFwfUycDdBE9ib4U/cnNNU=;
	b=xgJheYml/9TZsRGvxGwVOPFEf2NHP+Xvsczc5dTMSmlCGMGBPooW4/QSS7mjvyXTDfxN
	 zLkm2pBNPwHyOmiPz+97PmC8Z1NBAt2FiBe+yv15NzhDtCEdx6QBRlZUU3eS4UxLE6jsC
	 3Hp6cd6vRqRrCijmnOHtpSNQFT+Dq68NcaD+jvk0i8et6RuQtPUDGpe009ME60FzKTyaK
	 QFpiAWdb6bDBWuLMOE7rpRjUiLolKKyzZ+0y+ozzcvkM7igFX8pB+Y5hyZOQOwNCkpyAV
	 Dmv4XZAzzXZR0pd+zdvTP7GNPWquvNzyaheoIlmmGwU0f0A9pQTaQNyrQW/aXTRLS7A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=sC4yw7Nb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.16
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013016.outbound.protection.outlook.com [40.93.196.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95174606A327;
	Fri, 27 Nov 2026 07:49:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95174606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=sC4yw7Nb
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bepZym7dbwjGaVn5sRDCJlZ3PG9rE2ZBlG92vafhBHgj8X5dwaMo2o10XIpK4amhyRkdmlEcAqqwYS4mlbMO0IMOZUldLs0VFtoNJb9YbP6d5zaxuZdT+Y23xHFfheMklK/8ECp8Q7j3iDUTGfKreq+rrLwyUUxPYWYw/1sBTscX8QCeK6lGa2WYKRW7wj/5YgyDf+C4gDqPy7+UdnxLmorE9v7QrqxW/JbARZISF+akYSuJT2fU04ZHQAxx9BfjwNQfp73eEUX/rGFLKDyko48vaqXUL70ZHePbnSGBk2ewSUuGUket2pBi/Wz/1VmO1dwkZjap+6SDdCWwWTfkYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1kwJ5ZjMPGAIDm+BCPHeJSFwfUycDdBE9ib4U/cnNNU=;
 b=T0vtvIIVfpeVk5xYiUby1bse9FhstRIoWjVaZiGUaOO8GPGqVwl0GsC9XBUqQuQ0GzMsacsG1ZpXgTXgV7usEU3iEZwddY5ShXe/HlvOB7g+G0BQJXBtemzURQKYKCPQbvyjadABbin8Nzk1O3tE6G2v+5jkek/RJJPTOfjszzNSGMzA9iQAWLLpjVA9toQ2molsmDqugpthdWrIohOOIU7ahkuB8Y00RJ0D4J4lNSuWcWfKRWuB6xLHUdkwLmDv32fl8rj5Lo3MegUPaBi15oUct1CwFbKl2+Y4mtVCgjHqfGbE+IaaZxj6XcTgjmMePynEuQU3JPzU4WRj+65bAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1kwJ5ZjMPGAIDm+BCPHeJSFwfUycDdBE9ib4U/cnNNU=;
 b=sC4yw7NbTwje9haiYYSR1fiSCVVnZ+CKD85E5rEs9BCAhG9w5wu+naoIBunh1XIHHyoAzdXimdytFUaFJC0T5iZ6GYJDJW3iwVs+dnWPI7SsCTGk4SjioiQnrN+zewnoOke41K+97wRyxJBpNJYaFN3y9+FjxOIKPJuXmm4Vy1OMEOUKimH82lzHSS4Fl5pyzsuzQHnwj78QVev2KZDNLbzDm8rFX1yYYQijzOea5f2zPxaI7daLvq7fcFm47PwuOo0c+WJdlPsCtW4jG9dHODzIZ66gAppoJlmta9iKdoqzMFOECM9PuRAPkPm/CEKfGRSybWPQMVnCRdQ6gGeg8A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by PH9PR12MB409658.namprd12.prod.outlook.com (2603:10b6:510:412::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.10; Fri, 27 Nov
 2026 07:49:40 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0662.004; Fri, 27 Nov 2026
 07:49:40 +0000
From: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
	Linus Walleij <linusw@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Kent Gibson <warthog618@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mika Westerberg <westeri@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v2 3/3] gpiolib: release user space's lines when adding the chip fails late
Date: Fri, 27 Nov 2026 09:49:27 +0200
Message-ID: <20261127-gpiolib-ownlines-v2-3-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261127-gpiolib-ownlines-v2-0-aambrozewicz@nvidia.com>
References: <20261127-gpiolib-ownlines-v2-0-aambrozewicz@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TLZP290CA0009.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::18) To PH7PR12MB5974.namprd12.prod.outlook.com
 (2603:10b6:510:1d9::19)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5974:EE_|PH9PR12MB409658:EE_
X-MS-Office365-Filtering-Correlation-Id: 310716d3-c9ec-48f8-a503-08df4c5afdfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|18002099003|22082099003|11063799006|10067099003|56012099006|261026121527099003|261026140227099003|261028144727099003|261102123227099003|261022075727099003|261022105027099003|261021123027099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	0bhTvk6FcBDW8ZZ4qMDwaWcTtPrXRuyW8m7GOgr5D5znCDLtwcRiVhbSFDGib7fMLGdwrIRpaNfeOCs0RiN1fNWHkS9m+g0VJ1tR2UsV6Cd53TaTlk+gk7Z7mPCgQr5llFXNYvLlqdyUAfEQ40NiEa9/EG+/0cpkTPGaW/VVUF6sJRg6cvh4Y0z2CZRg3yXQJQ8RUqv+K69zffBjlmu3dFTs6c8jHy4Wt2IkKGAvl6oBXZJWO5hIlQOHglxJ1QBf8KpoVvIOOHAGpsFvWZr6YqLNLUDZGkFzrk2kNCWd3iMs5DqvKrEbCY/WfyFblNZMH/sTZcP2nJw1XheIzFNV08YODZLfTjWO+0KqJOH14kj4Lhn5u7US6+qEofepa9H3/qG5ZJFPFkNz0NGZgVpQCUdHWcaytDeNLB6fwIBHDKzsSbLFoUaJZT4CvKAmuXbACagQ8W+KxE9gqhxym20EIjLg5VnH2vOuGo2Xi1fc/ABcABIyVfeZoykIqbBF70zkhdruECC6/KkQHy+2/gnnsI1Z46w93eskV0NB+VzdOA2zF0gqyp5/iXMTqILdm6gS3VjzJWFkIQxUCRLfmIGbG+epnjuM8c/7z+jrxqBzM3BngAmbC77B3CZ3pNbqdcXyflqWHyfEdFlWKEOHkfIqFNZt08uMoPiSfeQKQhgSAyc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(18002099003)(22082099003)(11063799006)(10067099003)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(261022075727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gjgYzeXIUTKuADs1LH5rzRJ/2hUEzE08Q2RgXRXhjXziI9Xr5rkQna4TYK9p?=
 =?us-ascii?Q?k0S8M0Tu+QbRpSbMMX5Baagv+cBXSTkC/lVjsXTTz657Z2juqKPM47kDfSqy?=
 =?us-ascii?Q?hea1GhYKM5T78zr0F67X6z/FyE44u+wqjusR4OAOCgTiIL4+V92U2vO3suY0?=
 =?us-ascii?Q?OhvxWxPmbL0C9c39QivNMdqbdhZWmGyE9jcUX6CZYSrv6OzW0v01Hg8l3fMW?=
 =?us-ascii?Q?8zixF0zc5ozQSS4W0vFkdBW797/EPuFEICMeyO9ZjK9phY+L4RboD4yrF3QD?=
 =?us-ascii?Q?OUsDFW0nJQgrWKpK7PbXf7gAayWa17FAF0MJx6ifNd/1X5DJ5bZuL4iwyNV6?=
 =?us-ascii?Q?7343yV6FLQEk5OMHL0/hW/aPtbBAjZSNiHu7PKy6equQnq3Hdlw1HvxgRN4z?=
 =?us-ascii?Q?nzwk6EhYX3EQXeSAKPweFjVOrFCgN2xzXiB5LuOWPdVVit31QSDhr66gOWxx?=
 =?us-ascii?Q?5ygOkKjwufuwWW8+uTkyH207rNPiW1lu0TwXiGc6898NZHuxq4OtgXhOdOlW?=
 =?us-ascii?Q?2Spsr4TzXNmQnXZ4kyrcnNB8T24EbUJ0VMBGEIlZubnVZtjtAf3C+IGH65/R?=
 =?us-ascii?Q?XjEK7xP4um/5GfXy+Izoi7q1Cud1W0dU4x70p2MkT1qFe94lZUir0tuNOkO0?=
 =?us-ascii?Q?9pZKMDaVdSTb25aVE+zX1/JQch+Lq7niVRrP9m4ehpPL7PZIXcg7/FWGytbs?=
 =?us-ascii?Q?AWkLTtSsKOzzzefLsQkA3tri1dbLugr2hieB1ZdIKw2oPG2oUE7DeFnQ24Gc?=
 =?us-ascii?Q?k5bh5PgzVp4xUUlDUIktZq3vhe5yJ06jVN6YAm0PEu+QEt9SLh8Klfa96y7x?=
 =?us-ascii?Q?SzyaBzGbx6txriaf1h52ZiDB16fXe8O5CV7FLko9YaYcx1rwtp2t3zwqCUA4?=
 =?us-ascii?Q?uP5mu0JOd8W4LZbNfeEXZt/4jTZXursHPgB5pE4Tc1czveTlXy0/VisXXuTg?=
 =?us-ascii?Q?VQ4UldirsQm6mgvteSDQczf7B5WBsn+XLC+Cwd0t39tPRBARN7QEAywU4Z5d?=
 =?us-ascii?Q?OtqDUaj0ADCw5NXbm9QIj+yuK+dFisAXhaFwUzk7n2uAubDUxGbSj53BWusZ?=
 =?us-ascii?Q?+PhF/JpSHjIkL2mX/U860vfCcmXU5dhTvVGNepYX3Ru7EIa0aHqUeNoaCUzq?=
 =?us-ascii?Q?ImuKC/mD2ORvlECifZqwjKVkLZMy5TStp3gOpefsW6AlALtr69sH06X/XNKU?=
 =?us-ascii?Q?SPys0myXblYfTKi03UTsvPvhXn4BKiOYKzvNhYwJl9Wau+ER0b2Eayu9lEM/?=
 =?us-ascii?Q?luGaMjKRiHPZ1tPweFaY9bBEhh+94rgzfSYqTVJYP90L8brFj2mrZDee42Ku?=
 =?us-ascii?Q?p5XbrmuxsAFjXDD3h7kFP+kSAE8lHGjuD8/4JFr1FBLA7cnjlJrAUTDqIO47?=
 =?us-ascii?Q?p9rJaxdVqnerxQBM2io4TFuhtGTCnQAXCmKA1zZEiB1GXr2D3waocLF/VdBP?=
 =?us-ascii?Q?NztaPVw7pU31e/SYr0AolKPdtNe2uvTT4gI32c4ZH88iVd5YRwBlQgO/1Ecj?=
 =?us-ascii?Q?mRSqRkiFMvX31r6hO8Iwbd6YTRr+nacPo+C0PNILMmLxeF2iUBqnNNREdZCz?=
 =?us-ascii?Q?VtGr/RXVSoaVSccbXyIRUTpYPI6GBOV0jEg6VVl2yfBn/Ztunk3S5nnTOAEc?=
 =?us-ascii?Q?inlb5GvWGh3+UGmM9krXI4mBTA1D+zgwPQLqMMsweFJ6JBWM0uoekMWgHISU?=
 =?us-ascii?Q?A2NhbJSqRgvyDG3AWyg/KQabwLFtee5zJpb0YOlxU991k+8dP/jP6ptn0U/6?=
 =?us-ascii?Q?+isDaBPFuw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 310716d3-c9ec-48f8-a503-08df4c5afdfc
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 07:49:40.4381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HV4lYScotVb7nkyWnJV3zwTpvUPqpuHm2rYNqvkMjSbhUhfMqTI/cvf/yLxUUH64btxRr97uulLHlmavGHw5ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH9PR12MB409658

gpiochip_setup_dev() registers the character device and then the sysfs
interface. If the latter fails, the error path removes the irqchip and
returns, but user space may already hold a line request with edge
detection. Unlike gpiochip_remove(), the error path neither clears
gdev->chip nor has the character device free its IRQs, so the request
keeps calling into a chip the driver may already have freed, and its
IRQ outlives the irqchip.

Unwind as gpiochip_remove() does: release the lines the chip owns,
numb the device and free what user space left.

Reproduced with a test-only gpio-sim setup failure after the chardev is
added: reading a line requested then hit a KASAN use-after-free in
gpiod_get_array_value_complex(); with this change, reads return -ENODEV.

This depends on "gpiolib: release the chip's own lines before numbing
it on removal".

Fixes: d7c51b47ac11 ("gpio: userspace ABI for reading/writing GPIO lines")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20261016-gpiolib-chip-removal-v2-0-aambrozewicz@nvidia.com?part=6
Signed-off-by: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
---
A backport of this patch to 6.12.y or 6.18.y also needs 16fdabe143fc
("gpio: Fix resource leaks on errors in gpiochip_add_data_with_key()"),
which is in 6.12.95 and 6.18.22.

 drivers/gpio/gpiolib.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 1b92ace14a5a..6d3531f5833e 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1419,13 +1419,19 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	if (gpiolib_initialized) {
 		ret = gpiochip_setup_dev(gc);
 		if (ret)
-			goto err_teardown_shared;
+			goto err_release_lines;
 	}
 
 	return 0;
 
-err_teardown_shared:
-	gpio_device_teardown_shared(gdev);
+err_release_lines:
+	/* The character device may have been live: user space may hold lines. */
+	gpiochip_free_own_lines(gc);
+	gpiochip_numb_device(gc);
+	gpiochip_irqchip_remove(gc);
+	gpiochip_remove_pin_ranges(gc);
+	/* What the labels down to err_remove_of_chip undo is done above. */
+	goto err_remove_of_chip;
 err_remove_irqchip:
 	gpiochip_irqchip_remove(gc);
 err_remove_irqchip_mask:
-- 
2.43.0

