Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.70
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795765776;
	b=kkGUYpvsA5MVB5VNZydJ7KruCLKfWDZHhup/H36PHGJHWEYx8RwSSCjGStxBTGUirPP/
	 iwy/Nh+MKp0ZDffBjhIig+7SdPtViwMndZ62PRA3JiOS4Xzt+aDUEjlgZTNm5G9bbbzRA
	 F6RpRkh+DF3YGuZn7jKBgI98UCRIcUOzj4Jgx8AveFECve/j+c3i+jO1lCgbAJLwdYHPr
	 aQVWTAsK7PZA3/PTZNtZ1ccpdhfrPli4nbHDydpRHmhr03j8lRYkAlk3JMasKvUusyYUK
	 TZnqx4hte5Ilv3eE01+DYZHRw3HrU3rCDRpJQcQTGYGFhuvQiuGoircGdXSX/wgD/Dg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795765776;
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
	bh=7qBhK70ubI9a0CC2ltzlzDYUvfeOceDQUXtrbQ9aBTI=;
	b=MPOcfI3ZW+9M/kGzRrs9tgAL/z6sCPXTICaS0+lCs14N9NDNHsN4C4U+fEEzGVz2W82A
	 L7X8UtKNGcLb6+0uLJljkcGb9ehBAox/qlOEeeCNnvYxUC2kMu8Pi9uLN3besIHgBBIRC
	 bjVWavh3aBY4X2zQOodaZoWxAK0R81smt1jxIVF5zwhsBO58Covto3YTmK/RgijbsVz51
	 CIDSs7ArqQCkGdJXB/uEQzPFdAS4uleIGDkR/lRRQz1GuAxgTn+remn65GtDnuTDOmHfL
	 mN7yxWaD8hyHsYbFGCN2E4n1G6TaeqnxbOaQyEXKu2VH51wYitbJxUZQUJN3bqHeYeQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ev7VeRN4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.70
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013070.outbound.protection.outlook.com [40.93.196.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAD3606A32C;
	Fri, 27 Nov 2026 07:49:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDAD3606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ev7VeRN4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Icg/wROQ+6clca/ox61gIlP+WUomOH2FCdwCdwyzyQZXeyHugeZifcsgk4OJKw2RznMNDNw1rNkBXnfGA+obTJ+QMKkWKlb5+TNo0VYoCdxqEuCOrsW5qUz76Ide7G34T3gvKQUqSeCuh6Nget2UwMzOEZNqUm/rNOLY7jAVbhqz2G1OTOte4jnjCxHfCy8XhE2e0aDadZvFeHViFHDUk8JQY1lZ8KM/9QEput8917SsaTSLkUIkuSXQdqrybLzmpqgs8wD9N0v6gInYxpRqKCqNKGpXaJnPtGVf5d/A9Gij7mJCrfg6MyZXPKC/TiNMPqnvgOWvr6fTvkD0+dyy6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7qBhK70ubI9a0CC2ltzlzDYUvfeOceDQUXtrbQ9aBTI=;
 b=t6e88OAN8SxaBnScd6FdPx0bTZhZDdaaC22DPF4Tj41E3boD/4NAVepPteICOD4LBffjMq4xXxMo8aBONVS0aG6ifl8xgXw7uUSUQbpe9TzYoxOVTnIVHXe4lbpaOYEbelwqgKMn0KPOtOMTc3eEk0VZ+7VKEKDflvr1SC645GGGcFTJ8tCW8TeeoQ0/zvALPjzaXrUJ3fF1HtDbAv8jZ1/SnxCrl3xwI172HDs5zuwaUHfdqPy92Q7ZMdmaKzr7BQmEGGgmh0nnRfMoQeFNXpiM/nTXnT/kFjmgXA+xTEyVI31oCcVA6Mk0PE40XphMJqOZKDD18OmO9PjBTuPLEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qBhK70ubI9a0CC2ltzlzDYUvfeOceDQUXtrbQ9aBTI=;
 b=ev7VeRN4eBA47KcuhzwjdUsN9dWThTnAux/cZmbBN2FNL9NZexf70X4UDTjzxEaXMklMDQzEGNVlIPQ454kMEk/4B81Dwtp30QM1vlfKH3tDRnVSgfjo8gvX9ILG6kM00bpnm73p/WdGAS6cNnBDUxcob1ZO6tZBmBoHsjNoYYrsURNCHa2XWIuzUFJb8IiNnZHQ4izDXkDrt4KK4x/fefqZ6coxG3DsyIKe3ZA6P8J8n4S3F0CNoddFcBHUMqd8PtIoQ6sgUuuxAuDuH8FxkwvfqM6B+ejVjFoU1NyxIzdUiOMlwR9cfuAcaVcrOGrP3YlZmfvGstDX1tiZpiNA+A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by PH9PR12MB409658.namprd12.prod.outlook.com (2603:10b6:510:412::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.10; Fri, 27 Nov
 2026 07:49:33 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0662.004; Fri, 27 Nov 2026
 07:49:33 +0000
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
Subject: [PATCH v2 1/3] gpiolib: shared: remove the proxies before releasing the shared line
Date: Fri, 27 Nov 2026 09:49:25 +0200
Message-ID: <20261127-gpiolib-ownlines-v2-1-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261127-gpiolib-ownlines-v2-0-aambrozewicz@nvidia.com>
References: <20261127-gpiolib-ownlines-v2-0-aambrozewicz@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TLZP290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::15) To PH7PR12MB5974.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 62c1a940-1b34-42a8-c8e1-08df4c5af9d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|6133799003|18002099003|22082099003|11063799006|10067099003|56012099006|261026121527099003|261026140227099003|261028144727099003|261102123227099003|261022075727099003|261022105027099003|261021123027099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	dInyfjvAMeHyTPiE7cOUYxwkJEChJaQYlEU/MfHgMiy9aSJDOXh4C+j3RvLRUavnLkFCpLpj0fH6iS2GVKQ27tO2XM3CGfm6UbfrAinEQ6liPDcs8f7Q1tHJYzvCo0X3iziluWXTSp89WpPp3Jfu167CYV2aWLPAZyLGlxOrLz0md6E2rvC5DB1knfJEDLPADvwYE+R1sKWIf2Rp/8eZcLRoo49L4OUquaNoZiYSj7YKg8deuj/1IJ4lGt8H8o63tiSG/zqCcAcp6F5AlPBFaHqOG+6uHPqNPdxxQfEgKnfgjEXAY6kDLrmjlNLtvJZOPEVcRwJmuH4tlj05W7PP0PlormFvOxYeRYQJtxDxgBoluu+UWKTcp692Exy72W6nOChZbAESIUeJx+beMr26z9Xj04isglbteHgCcfxmG/AwWM0A2rF1eWL9V7E0DZDwojQtAq1iDBshGv52yiGPyjKeeCOV9vhoCIHGakeAI2lgTN53al3N9OL0mdDJxAwm3Vw/k33qJUq2mxWYNM4C0p7bNE2Dhz49CiPdSsr66ifmJBnmOPGflsCVetv+2jarb6895LK2l8Y0/6rQAoz9LwqgHpEsaYUEQ8xsLyVG7gh+/FSVhCXXTtdpGhvtwDW9cp4t+e44pgDlFppJzOpBv21G9TrVfwJrmvrgvXuf9Vw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(6133799003)(18002099003)(22082099003)(11063799006)(10067099003)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(261022075727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BL391xAy8qSu9D0sJKu/wArNoEtHa6FP7cvG6mEW/5AQYqCa7vnZI9qe5ccL?=
 =?us-ascii?Q?bU+XLdZ/U7z112abTlPjEzbh0u2D7/f/EuIAny4QyI+x1byuCr2gRreGf5d+?=
 =?us-ascii?Q?HKuGL8khQ7yX3fOvV/2U0qnJcunBqjMxezgwagjXnoV83a6n2NeKXVevTmlj?=
 =?us-ascii?Q?V+sLVmmuTpv3IwQqdzMfzb2JhUrzDAfEMyi5iuPl7eyW8Vn2Zjx5qoU02qZI?=
 =?us-ascii?Q?I8Q+Ce7LNNve+8pdttdlhRsLNdETrL0AWXF4qlbXIffnVi+JM8NLTYSas8rt?=
 =?us-ascii?Q?/Z3y4O09DgAsB2bxLBElbuOG74861fEwPmYTyvuhBJ2bVmD7jUvDBaJCMMTS?=
 =?us-ascii?Q?XWb+GmI+psmGQnflfYa/l7x9PR9nV6+cmZpTdP7vQquRDzkX/UXiQ3YUuuyw?=
 =?us-ascii?Q?VY02Z9ro1gFQQyx72U6B91L47K6MJDYfUL+wKZtnZCWU+8pc2+KiZYs0Qll4?=
 =?us-ascii?Q?RKEuYdcB1CJmYjDn+Q9d05Y3dzlVqsrlAxQvxQfd+Qe/oQnl8yQPPHbCgJwf?=
 =?us-ascii?Q?Lc9bk2xx4QiSSu4YMRIpDPOhRoXdYn3Qh6LEyqPWE8qvjnfFaFKx1o2egya6?=
 =?us-ascii?Q?X//ZoKIoNSnz/VlcxzFSqpUpkdCrlTqnnZs9l3h94ztSmP4F4T8Ie5XS3kr9?=
 =?us-ascii?Q?Npx2E5JGPMo/ypswt8RsdEpXH4x3vG9nL1J71Nn6JjVprfX3KQbUXzB3VfWs?=
 =?us-ascii?Q?bMgxGvYOdlHbeiVCEKaQwvCwIReuZ6L6M9NZTQgyh283gQtmASUePpREdGZM?=
 =?us-ascii?Q?Axe2mA2VuOvrxMY3G1zNDZpzUcoHXiId0d74ACnWsw8hpH8pz+hJg6TyYvcP?=
 =?us-ascii?Q?UxwfsHmYYjPkerzVBMCkIjNxyqsrpbi7mfVLMyJ6wXo6XP0L843UgE8bRlrX?=
 =?us-ascii?Q?1DV36KsI1DnYu1bQPfNVQ4ZTC9OnouUehs6IAeCtyn7vfjb6oitIBLcx9zqw?=
 =?us-ascii?Q?akc84f5aJaywVb/2JfHtCxAhPDhjxJuO0w7cazB34SW4CQiHQFsxvc8XUALd?=
 =?us-ascii?Q?oXwR6uGS2XIV7KnJoqQu86E2OSIRidyDDN45zVuI/IOHlspX8eSeKhmHJCmO?=
 =?us-ascii?Q?IFy66WiBMTaLTXAZmYYZzRuqdcSfCgagdju/h7kyk3o6IcqZ/Fo2JUiNLvny?=
 =?us-ascii?Q?PD6B4dCHJWcFzqOBttFJLBmP2KUYrisjMuDlzEkzzGq6YBejZ1Tpb/C1C71e?=
 =?us-ascii?Q?kTCP6wrmpIf6tFu+qKqvSlGsb3ihgIImxguR+GiBTsogIEOyCO51ZChjNCC5?=
 =?us-ascii?Q?XDlb9sySUlJhmeiCfh3vNy9sl4dbigpPSnbLTcsWoyQlY4RDrYIS0Pgv9ERE?=
 =?us-ascii?Q?eiFd74NY3RjEsgZA9d98Zk1HQdZEMJpv29TxRbDJp7gXfZoPPjmCsbllFpvQ?=
 =?us-ascii?Q?2bLwrMHlA5+VR7IrXYYZa50zfp8dTzdK3xehhQHGWHdcO7u5d0Y0QPp7AzQJ?=
 =?us-ascii?Q?ovz5myktZRO/oMo3bxGB+ZpwRx/GoK/HtyoeZYTh2Ze1dfj+EuCHZanASWkg?=
 =?us-ascii?Q?K7AwV6Dm/IE0SMelyvL6itgbI3LxoVBLcjCwz79eWrOYmZ0DIVBoLKsag+zN?=
 =?us-ascii?Q?ev5+GOQN1c/DmIz0urWej2reNUABIBzjOur2c8I3Osqw6LpOq5JoZgB0D5vn?=
 =?us-ascii?Q?INvjYW8yJjVT3mATvYiemqlmkM/avCyo+Oo5RhXgmOyQ/try+4YBSICGConB?=
 =?us-ascii?Q?RTCFfyvtwB7k64Qfrrbskow40n3gNk5P0u+ecpO88erxSt6JsgPbQMSZGlgQ?=
 =?us-ascii?Q?5QJX02/d7w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62c1a940-1b34-42a8-c8e1-08df4c5af9d6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 07:49:33.5326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lYfywgaf3AOZZEM2z0HDVtQ8DD6uNY1WJIzQZIC08tZbEoVbET4bWa495E5jY0PKn2B0P5EMTBvWvlk2kW7FZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH9PR12MB409658

Since commit 4918cc05137c ("gpio: shared: propagate configuration to
pinctrl"), gpio_device_teardown_shared() releases the shared line with
gpiod_free_commit() and only then removes the proxy devices. Until a
proxy is gone, its consumers can still drive the line through the
parent chip. The late error path of gpiochip_add_data_with_key()
calls gpio_device_teardown_shared() with the chip live, so there they
can. gpiochip_remove() calls it after numbing the chip, so those calls
fail until "gpiolib: release the chip's own lines before numbing it on
removal" moves the call ahead of the numbing.

Remove the proxies first, then release the line.

With that patch and without this one, a test-only log on a shared
gpio-sim line showed both proxies still bound when the line was
released; with this one, none.

Fixes: 4918cc05137c ("gpio: shared: propagate configuration to pinctrl")
Signed-off-by: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
---
 drivers/gpio/gpiolib-shared.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpiolib-shared.c b/drivers/gpio/gpiolib-shared.c
index f34315a2059a..c1e346a56177 100644
--- a/drivers/gpio/gpiolib-shared.c
+++ b/drivers/gpio/gpiolib-shared.c
@@ -611,9 +611,6 @@ void gpio_device_teardown_shared(struct gpio_device *gdev)
 		if (!device_match_fwnode(&gdev->dev, entry->fwnode))
 			continue;
 
-		scoped_guard(mutex, &entry->lock)
-			gpiod_free_commit(&gdev->descs[entry->offset]);
-
 		list_for_each_entry(ref, &entry->refs, list) {
 			if (ref->lookup) {
 				gpiod_remove_lookup_table(ref->lookup);
@@ -625,6 +622,10 @@ void gpio_device_teardown_shared(struct gpio_device *gdev)
 
 			gpio_shared_remove_adev(&ref->adev);
 		}
+
+		/* Release the line only once no proxy can drive it. */
+		scoped_guard(mutex, &entry->lock)
+			gpiod_free_commit(&gdev->descs[entry->offset]);
 	}
 }
 
-- 
2.43.0

