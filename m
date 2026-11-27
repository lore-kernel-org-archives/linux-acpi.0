Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795765779;
	b=Xcqc2Gbn4UoOJFNIz0J5LGjR4/mvOgvtTiOX1LZclf/vwa6KehSkmAGs8DE3fU7qDmME
	 4Q2Ly2Nx8Z82w4VlsXRsISPDn/4dsdG8Y310PKh1hbtJW0OQ08GgCbmd1q7Aee0tRwkk9
	 DanNQgt1obBD/q+YKukH1KVRLh0xhVINGtgRmanGMPoIk4Q4degC7+hsZePMc1/Tdq/xm
	 pRoP8jcd5IYFWCa+bPSBO/k+PL2iVvKVG0NIe80MFwFbGTIogM/Xw70uupoaLKmdD+E4Q
	 UR4ayXU5Udiu70Bv3E+dlSsiIcnhrA1p06kIvehq2UogUu70cLOBk8L3jT2mVY7iPAw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795765779;
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
	bh=UEKxlS6/oT2uNpF+IKw0xvgs65mtA225F3VobhYGtI8=;
	b=OvW+ioSe4UX1A3cN9Am4D775j2/Wsgurst8IEPEJ2bGwog5CQMqMtAqIiLk7vj2n2yND
	 nFXzWdBadICdXuqywtAHiEITsvvKpgXSeqBN4Y6B5PtuHjYWNqgJsAcpJAK4RPZvJyOnm
	 GkgjneN1JAhdHav551VaEGFUHpJuE5jBoFC4kS6qU6hBuHvaxqB6JOQqgHOU8eziZ5eCD
	 wwheVFwQF1nOhV2deWiR7xrKNbUl2AhcBvq6Sf8HAXjCWlRNAivdXi9RtIzwJ5M5bSorE
	 t9JO1Ew3kd2H2Jg4o0804gCNssesiIIwM1/P5eO/zucSNwDSAa3RlznFe1+BHbIB+jg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=HLVFm9wA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.19
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012019.outbound.protection.outlook.com [40.107.209.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133DB606A324;
	Fri, 27 Nov 2026 07:49:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 133DB606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=HLVFm9wA
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PxlFfst9gUvpw/YZ5l/hyB38KmBiya6hXYIdO7i0LFu9JBsg9qM2wXa0vrCDm8kYxQ/xu8vl+KAY+upFAsv0lxdgLZ3d0iKgtm0Mmk6IBBOKc4qvcDkGHsRSKLzd3sAqbu6zgxLCU/qjOTf7V0ZHvJSwMw79X8awWmtfAvA/zdXKQKEs5hQZgevlaC1UbGueAhwPorZAe6iL0DLBJo2N9EXyTIy6tWnZO+ovjdjILnBT/xYWkEzyMlzEGLKA6O+JFcepTQibTd2J2KcbXve6+vYd4c3iDBAFmvjRuYKodoYBGX//nwWszbqsHEDEfJu294EcPDD0dC6BM9ByCusubQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UEKxlS6/oT2uNpF+IKw0xvgs65mtA225F3VobhYGtI8=;
 b=u4DD5dbMD/sMZXF20FZFzjUrrLhnaLxZfhwqJy2/DRqlKV0YZGcz1f7KeMuPc/w2LSXIkUaOw1hW3p4vqqWWDHA1xL5j8XDwaO/+iGT2anfx+O6+ZL5SqJON6OuYtX7d+dQhQmQkGTUUMP526FgLx6Cwj5U/LUOoE0VBGGMVGWoxf/wddmNUswO5V+2mpDNzFRHbDcW5MtbSc83YgZtWZ68PcjFFEifh8hjkbruIUD72vUISUto+FFIFsLhlXMBsEYs/EynF+ZtSc4aXnHeG3ivN3b9+XvabvBoBC2J0Gw7GjAf7xdbHuhlPZk7ie9SImtWixaj2LwVrSRJseL+8kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UEKxlS6/oT2uNpF+IKw0xvgs65mtA225F3VobhYGtI8=;
 b=HLVFm9wAUfQhmIjBZbOMbePI6TXgy5EBHbhC4NF8PtwXkkyz7DjzV8dKS+2Q3sk06WR6siUjvXXaM11RvzHeqt3RI63OONBD+TgHR0owHi3RtxiBXggV8tDstSN5MtQsjW3me3x3H0MTPK5H+UxJF+qWvOSmDz4ipbr9qGoxIhahw3Aw4gpRAqGGbKeuzt8CXAnw7aILWxnb2zZBrPG9JFS9ZdnKuKWCGn+tZ6zyoRuQwGTGDo19O3Vz0CHrTTDr6JP4803s6V98bGDo63pOUJwXM0+mM/jTez4Ngq8mfnrZr/vx5Mhl26ie7W+0IS2hBIW0t/ubNP/QKjYJoYdJBQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by PH9PR12MB409658.namprd12.prod.outlook.com (2603:10b6:510:412::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.10; Fri, 27 Nov
 2026 07:49:37 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0662.004; Fri, 27 Nov 2026
 07:49:37 +0000
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] gpiolib: release the chip's own lines before numbing it on removal
Date: Fri, 27 Nov 2026 09:49:26 +0200
Message-ID: <20261127-gpiolib-ownlines-v2-2-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261127-gpiolib-ownlines-v2-0-aambrozewicz@nvidia.com>
References: <20261127-gpiolib-ownlines-v2-0-aambrozewicz@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL0P290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::12) To PH7PR12MB5974.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 6193b237-d897-4f56-9571-08df4c5afc04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|6133799003|18002099003|22082099003|5023799004|11063799006|10067099003|56012099006|261026121527099003|261026140227099003|261028144727099003|261102123227099003|261022075727099003|261022105027099003|261021123027099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	GBHVqRxx3vK6zljbys7SuRu2Ff6GpskDGZqF6z2LgEP028GRVWsoAcx9xUDWU6ESLqRgPobL+DEdZMM+0jYhL0xIsvAt6d67nhY8E/EZEDJ8L4ZZkr5labDVsvnOVl5vGra9j4j7ijJF20t/QXiB5POzj6+95zP0oQHm6DPq6BaAh5wAdXtN/uQ7TM3UO5mmpbz1H+IjsWtsVn4homaBvrt7KWFDCxJEEzPqoJ09TNGzR0rf4y1dYMU5Y/UqfzB8IhQJxPAIaMJqbteQaM5r09c5ZMqmnygpmXG+LaN4YDn13aXmSTZr87nOjMMmPKZgRxlT1UAIWAShuSv5dPnh//StaSOVM89wyPvgLy6lyA+Qh8xddmErqfuaE3cx/vl27NWyuCgDpl+b9D3cD/5G/8m0qvc+KksHneT8RH8jwLfKdNtVpIkSeQM5ge2PqyCJATE+JYABmP1lSYtRugr36riAYFeGmdLxaz7Wy67s2uv5DrCC746/3m3TOc/jl7ge8+nbJtjRi5KRjYcc9ecXnxSm2qmrhR43eO8JqPsavb6vdWOJRzdOygs2wcjKJ6x9o6Rpg75iQULQnEBZBvfIzWOxph4u7ERk62dWAuZjDkga9m6JV23Gnb1DRSzRSr7Z9UFqkMjR3MjIqAQhZx2DP6XyRTlGJ7sK566jUo/SPd4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(6133799003)(18002099003)(22082099003)(5023799004)(11063799006)(10067099003)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(261022075727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zYBfw/OmtWotHbN1VJdN44oXv8/spAznoAmylDF4m+EtDOidpmp8ozSQbVEd?=
 =?us-ascii?Q?Yf1+2uQgv5api0Fkpl/cMlbvoEki3u3l0hYQkmidJlVhI5+qg52dt6MAzm29?=
 =?us-ascii?Q?lnmhps7Fx4ffUr8bus7vwGKoUa21E3bLqtyi9QbXJfJXIDatBjD76F/F/vxb?=
 =?us-ascii?Q?BtGsWk1JUbIYzfueZYPhUWtCOvndF9WXDrvGdl8egSlwDni49lXXunWpYHuF?=
 =?us-ascii?Q?DEUmi1jNXsIhKuUVlwdOniVbJKvy1dktwBxji5I0ug3JjwAt6ojG25QFCh5p?=
 =?us-ascii?Q?yCgp8z1BTJVEOlZWYSEnvmKMyWOIsnodghFCNhAGoDxYFeBs2jjaDYp0ffVu?=
 =?us-ascii?Q?vTP1L8ccwZiEoDygS18im7hvcr+x/BuHlRhS3/jGzEQwEhT3F+5uyfTk3A7i?=
 =?us-ascii?Q?uYN73zwYjzj4GwWLuTxbhZiu7vL73KYG+oKtoo3+AhoI92bHqYTemMHAJiAA?=
 =?us-ascii?Q?SLG5OGgdTXc7e+CBWilp5A1VmcPmPv0TEmwSQVnDGb/DN3xqnZegtkDxjBmQ?=
 =?us-ascii?Q?rG4lry/CkV/UAFXzlfPXxGJaxgmS54Vd4VcXia8dpoZBUoiIUJts0uQIXhOr?=
 =?us-ascii?Q?rQ4ORUF3mhN+G7bUbC8/XMdwUZMTF4kM6a4YYk37hn6Ckezf3P0cuMWugZlG?=
 =?us-ascii?Q?oggz0eWQNdItin8VVB3RYHaspCK/b+CPvbOu+xT1y1Ld3vzAAvBoEdYWREru?=
 =?us-ascii?Q?JKfteNltrtg++LiY8K28GAf9RubzvzJoZsE0LHpEXIgLAnyJ4gu5f2MzzkbZ?=
 =?us-ascii?Q?dWCWNpJgnopO/lE+rgbMj5zYxqF5uFh6BnSpA5hdIbJzydst/3A9A9wlGdsp?=
 =?us-ascii?Q?wLtkqvIbIFUxEYcQp6v+KZBvuITVrT2QvyKiD2zlQYvfGupicR7Dm/dWAb8g?=
 =?us-ascii?Q?kuR1q1xuaaaLKVA9IwB2mhmiz1IRyjHJXpSoWM76AQG+bQ07OVin2HTk5Eib?=
 =?us-ascii?Q?/ia+FKbavCYlRj9Sf3voti/icc+QrZnqzrfSy0lTwljUlgYDlppDms3GXo/O?=
 =?us-ascii?Q?Ya2Z93j6olMhHlzHcOgd1Iq28tXu0MF9z65HT/R3Imz2VmscvNntK8uRdNN0?=
 =?us-ascii?Q?mGfADe6dZuaTAfrrK4HcdQoD+IZ/gQUYf+IPqcOcbhVy+u3FHZaqnl2S1xZM?=
 =?us-ascii?Q?r/ZmdDAj0xfDXlX0i6I8LSJkeiTkrTHilt44SM0gMgK+IH6N2PznBYzfTSqm?=
 =?us-ascii?Q?ltUhPc2uJ4awC0gn48cZMCSd/guGogmSkLWiwpeVfjqsMA6eu/dze9TFWXin?=
 =?us-ascii?Q?2caeA4ndR7I/vi65jOL+mnLCYOH8TmpQMqNoogeIsyKEk7RMWyEO7QeLZKZr?=
 =?us-ascii?Q?2WhbzskWcFgie4aIjS5p5FfD845vdFBiFguCMRX4jQiy7jjBHcuL2m5X14lu?=
 =?us-ascii?Q?GODh+wV7tbA8b/GIRsarUOW30tlWiiitbGzc6FbjJW1K5lAPbUNEH0R7U02n?=
 =?us-ascii?Q?7c/u4vmDsGQB7RB5qnxCcKhCqcRz9NLhefRhlebRbsXa6bCelSvD95OD99Sb?=
 =?us-ascii?Q?FHbgBFH3HdlMdyQzZT04Lq7w1mQAW8PtFmNCGox7lnw1Z4ICbzZzOjDZA/5h?=
 =?us-ascii?Q?CDl/Q6Njr0CEGeqUDLkOHiNn+iqVo4n0GoGgr0b7F7mU1etr+y6cweF6pSbG?=
 =?us-ascii?Q?UE6j9LzVODwayi1u41K6DOSUig+Sv1HUSNuDby50m+e+f1ntrKlqlhLLs5uq?=
 =?us-ascii?Q?s97ZomFKe3RXERfwMDDQIsujZ7IFL/xQvGo4zJfyDCE46522WncMNXnZ8Uhq?=
 =?us-ascii?Q?YyWaOC+L+Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6193b237-d897-4f56-9571-08df4c5afc04
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 07:49:37.1401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mqw2u+jyMCcajSgsUTNDTcaIvId+Pv3koCRFGnUxTCJcSh4WH0fTNx+JPq1NUwsagpsUGKhMsCZSj3Bu1JotXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH9PR12MB409658

Commit 5018ada69a04 ("gpio: Move freeing of GPIO hogs before numbing of
the device") made gpiochip_remove() free the hogs before it clears
gdev->chip, so that gpiod_free_commit() still calls ->free() for them.
ACPI event lines, ACPI OpRegion connections and shared lines are still
released after that: ->free() is skipped for them, and the ACPI event
IRQs, already freed by gpiochip_free_remaining_irqs(), are freed again.

Release all lines the chip requested for itself, the hogs included,
after the chip has left the device list, so no new lookup finds the
chip, and before the numbing. Move the numbing into a helper for the
next patch.

Reproduced with a test-only ACPI-style event on gpio-sim ("Trying to
free already-free IRQ" on removal) and a shared gpio-sim line on arm64
(->free() skipped); with this change, neither.

This depends on "gpiolib: shared: remove the proxies before releasing
the shared line".

Fixes: fdeb8e1547cb ("gpio: reflect base and ngpio into gpio_device")
Fixes: ec8b6f55b981 ("gpio: free irqs that are still requested when the chip is being removed")
Fixes: 4918cc05137c ("gpio: shared: propagate configuration to pinctrl")
Signed-off-by: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
---
 drivers/gpio/gpiolib.c | 49 +++++++++++++++++++++++++++++-------------
 1 file changed, 34 insertions(+), 15 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 57024a1b042b..1b92ace14a5a 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -904,6 +904,35 @@ static void gpiochip_free_remaining_irqs(struct gpio_chip *gc)
 		gpiod_free_irqs(gc, desc);
 }
 
+/*
+ * Release the lines the chip requested for itself: hogs, ACPI events and
+ * OpRegion connections, shared lines. gpiod_free_commit() calls ->free()
+ * only while the chip is there, so this goes before the numbing.
+ */
+static void gpiochip_free_own_lines(struct gpio_chip *gc)
+{
+	gpiochip_free_hogs(gc);
+	acpi_gpiochip_free_interrupts(gc);
+	acpi_gpiochip_remove(gc);
+	gpio_device_teardown_shared(gc->gpiodev);
+}
+
+static void gpiochip_numb_device(struct gpio_chip *gc)
+{
+	struct gpio_device *gdev = gc->gpiodev;
+
+	/* Numb the device, cancelling all outstanding operations */
+	rcu_assign_pointer(gdev->chip, NULL);
+	synchronize_srcu(&gdev->srcu);
+
+	/*
+	 * No new interrupts can be requested through the character device now.
+	 * Have it free the ones it holds before forcibly freeing the rest.
+	 */
+	blocking_notifier_call_chain(&gdev->device_notifier, 0, NULL);
+	gpiochip_free_remaining_irqs(gc);
+}
+
 static void gpiodev_release(struct device *dev)
 {
 	struct gpio_device *gdev = to_gpio_device(dev);
@@ -1449,26 +1478,15 @@ void gpiochip_remove(struct gpio_chip *gc)
 
 	/* FIXME: should the legacy sysfs handling be moved to gpio_device? */
 	gpiochip_sysfs_unregister(gc);
-	gpiochip_free_hogs(gc);
 
 	scoped_guard(mutex, &gpio_devices_lock)
 		list_del_rcu(&gdev->list);
 	synchronize_srcu(&gpio_devices_srcu);
 
-	/* Numb the device, cancelling all outstanding operations */
-	rcu_assign_pointer(gdev->chip, NULL);
-	synchronize_srcu(&gdev->srcu);
-
-	/*
-	 * No new interrupts can be requested through the character device now.
-	 * Have it free the ones it holds, also on the shared proxies, before
-	 * forcibly freeing the rest and removing the irqchip.
-	 */
-	blocking_notifier_call_chain(&gdev->device_notifier, 0, NULL);
-	gpio_device_teardown_shared(gdev);
-	gpiochip_free_remaining_irqs(gc);
+	/* No lookup finds the chip now, and it can still free its lines. */
+	gpiochip_free_own_lines(gc);
+	gpiochip_numb_device(gc);
 	gpiochip_irqchip_remove(gc);
-	acpi_gpiochip_remove(gc);
 	of_gpiochip_remove(gc);
 	gpiochip_remove_pin_ranges(gc);
 	gpiochip_free_valid_mask(gc);
@@ -2335,7 +2353,8 @@ static int gpiochip_add_irqchip(struct gpio_chip *gc,
  * gpiochip_irqchip_remove() - removes an irqchip added to a gpiochip
  * @gc: the gpiochip to remove the irqchip from
  *
- * This is called only from gpiochip_remove()
+ * acpi_gpiochip_free_interrupts() below finds nothing once
+ * gpiochip_free_own_lines() has run; it is for the error paths before that.
  */
 static void gpiochip_irqchip_remove(struct gpio_chip *gc)
 {
-- 
2.43.0

