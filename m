Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011026.outbound.protection.outlook.com [52.101.57.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D103C73C0;
	Thu, 19 Mar 2026 11:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773918809; cv=fail; b=FoYjZULqRONsXGEdcZPkpV9HVXgGmRGICr4qioqMyavBrgJNKv/Bos2QAqT6Nc6A6golUzFb9dmktuVYms61+K/Q6au/mS9QBIVosT8M0VDCMcAkhrBhqBKpMsNJKr9jiB5Ch4hUIAX/ZiLlzoYQhPRjtxXIBnmtMjCNCRqFRw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773918809; c=relaxed/simple;
	bh=kLHnklQZLmNCArgBixWWKjY19NPG9BVtIiDB6dfhxPI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=QNNPV9+7IVTGMkfkYEUFbDk8rzg/GyP3xuK0QyByxNczHrDv1eIt4GKJNlF2ieyiXdxAVYQfhfAt212zdQoPpGT1L0dTiLee97FGA6S+IFJxmBBaxDYbvbKIzSm/g3/xVd6SIDbT2sgQ7qqPEOT3gKxgZB7p8iuR8W97ZIOyKcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gw56TaUs; arc=fail smtp.client-ip=52.101.57.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gw56TaUs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JFxUCv1i/T792mgdpsCw0lhMqrYcoPyD4CWVo8wvIrtwV5TT0aEmgvz+IcEjpZ7Bq5djz5NKsRAGeKjZ2b/tW4ZalSubnEysJxYtnkTlgm0x0qMocNKTndRjr0eqFkz4EgtS/pzgFta/n8h24O5N+8086OHu63M29RCjU60KaVKeTagUHPiZd5ooIthsFojbM/LpszICI8p34bYPTnFiz+YG6ManLwFJifz9HFk64Ow2EWrCTpBRiKTAsrEi3WXtJxk1iZRi74cDhByK6GrFTIkT0U376WXlHwD8h8LdNEUu42XB8qIKjKIHmbDxtaY4I3r1uWRVlQ2NBq59E3NpUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EB4TxZIaIialocZq6a4B4PIbXZZT3MujWTrlaSFA6lQ=;
 b=eRHWhfFyiZVd4pUuYsm1OFJv/X+aidB17Ev0TkIrTwzliV6kuvjpRQ3dNPgCxUK2hNCBlXsSr78R9c0vvkaqOyuISZ5yQMc3wPk0t6OAJDDnNxZwF56uN1r4DNZuqNyfVYTh7eIBUrDT+WnAjUIFqh37V8SEG323PNzdJKwA45I5wMy0/e24JxS7EhxMCDBk4XssYai310ezrVJqud/2hYqnpsqoIXs6H9kEbuxJQesXuYvorj2bbE4WsTO8AwZ5sEb1zMZXAuKT3syUY1jz2uM+jTpADyIguFZsdTHyZ212a4np5/xuIlO0DcSDi0iGW2M7m3yqiVAMaTJxWyloIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EB4TxZIaIialocZq6a4B4PIbXZZT3MujWTrlaSFA6lQ=;
 b=gw56TaUsHIPvB+km8iww+6FYc1+BLs8cBmadBtmGagJPL3WcqBFR3EOAGkSr/L62bijVn6F6rNGiCFdUZZ9bX4GQz7KV78rJ6GpaEih5zFFWUDel2tqxPEBAwXlB6Pmkhsj0OFeHnXNif8vt+6Q+KS8x4qw0ctC8KzuruKudm58kcb1dEXVUUOcyH0sCxCQGmgqp0dd4ErkmEqgq2rSGRonmUBhg7gYR6msEJVsx3sfEVmp0s1KuHmHdg0QzIB8o3C2GSwU/pUXXer3UbPbn6+K8tXTVOGn5o/Rs1OLuhbq5vXVTv3/r7RcbYYuDfeWTYwmTpp323EsEx6Fn8NthcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB7914.namprd12.prod.outlook.com (2603:10b6:510:27d::13)
 by DS4PR12MB9817.namprd12.prod.outlook.com (2603:10b6:8:2ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 11:13:20 +0000
Received: from PH7PR12MB7914.namprd12.prod.outlook.com
 ([fe80::d390:582:5536:40ad]) by PH7PR12MB7914.namprd12.prod.outlook.com
 ([fe80::d390:582:5536:40ad%5]) with mapi id 15.20.9723.013; Thu, 19 Mar 2026
 11:13:20 +0000
From: Kai-Heng Feng <kaihengf@nvidia.com>
To: rafael@kernel.org
Cc: Kai-Heng Feng <kaihengf@nvidia.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Len Brown <lenb@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Jason Tian <jason@os.amperecomputing.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH v2 1/3] acpi/apei: Add devm_ghes_register_vendor_record_notifier()
Date: Thu, 19 Mar 2026 19:13:07 +0800
Message-ID: <20260319111315.87624-1-kaihengf@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0049.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::20) To PH7PR12MB7914.namprd12.prod.outlook.com
 (2603:10b6:510:27d::13)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7914:EE_|DS4PR12MB9817:EE_
X-MS-Office365-Filtering-Correlation-Id: bff1d7a5-5ebb-4fee-0d17-08de85a8871c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	GUVFHfRg+wo46dVDOC+K5a93+Re/2tIdrH5KDP8GNTkvOTfg8d2cQvyHK4w0r9LTcVJvlUAPCkdTadlaEOoKcIaALKRqZ1dJttQu/XVG0QOUHxMbYFZ/O1bYixJUdrp56pnvQAM8BFv1NjT50qmbutzCK79WhMg2DGG1rkMit7gyN2CCE+0ohBw3WrhSZgVicwkRi229n3Jdzj3EcTMfJVkBcDKadEkyFUUDFecX4QSjquGOhlI6fdkq5F8JpqiVACdWaiFHzGJQ0aVacrFdUb3wlNEeQdJziTnTnATTZwG/ejQNuDpW+9DscG8Vkq3yrVMGSojipa2mfTgK0Tu6enOpSbGZpeglEh/CbYr56Fw32fYkeDs3LBdCc0iVMtXocgWeJqpL+9B9hYNaCYYDX+tlMi7lG7pDBUjnurAK068aM5UTAEFCxmXU1bQbC3iptUFQYLnU9ypDUIQa91P/LNDCr682FobHr7WAjCySnw//AcYciMnKJHeJe7LTIkmS1v3WY38zt/r9z4c2CtVXIkFH8r19Orrn0S5MVGbdM02Tx5i+t/JKai5uYeHR7Z65Mg9uD8g5GndfDppjmCVV9qw9MXpHXcwsqg+T7AkM1bqr3pM6LB5VQPmZrPP4lY89sLPJ+VHx4zs9ohAIqodc3aUbm150ZCkH850Di+hzkJ4K8KBwBI5GzeBAo+Pno3ZRXOjWsEeamwcn4EaVxJJBAPz3h1vy4gK+TrwLzpkeymU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB7914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HB6//9I4vFfbZGatKvs/HOKQK5FPXhGS3Fk9nk1ei9uUb0t0OfTQDT6+aHdd?=
 =?us-ascii?Q?D2XzwAxbhuLxSQGTVEhfkku3Yhoq2ql4vXdu9oRbKw/KBvrIKwMGdy0dmrTr?=
 =?us-ascii?Q?izrCXbuPcf1whBOYzmLGPjfo0YCdGhSdNsFbu19CUQog/EY5HwTzBf6aWzLS?=
 =?us-ascii?Q?JP06B2SBH0SkX0mWK6IkRixW4W2SxrAenDtrLmKwLbi+wsgKACCVjhGjtP1A?=
 =?us-ascii?Q?gXr6krntpnbmWiZ9KGIZzJEN4zfZttZhEelhXKrOJP3++LPdAowL8EyBiABs?=
 =?us-ascii?Q?Hr/WWt/dAY8CTjckgjoMh8mV94QxbpUZ8O/zYPqKNbZqiG7zX0yqG2HZA16J?=
 =?us-ascii?Q?HUPOe4x+TeOzYk0fi91lfVdSs4muLiR0DlK2rQxJGafFfDYMV2NL0RXwobLw?=
 =?us-ascii?Q?9mheX0PMIBkWvSyuHrbjICX3CBFmG5FNM9cxfBCLBrONEMz3hhDBM0NEe509?=
 =?us-ascii?Q?4XI1aS0BlSmos0Zr+PjzdloSw7zvfli80Pnkt2A+5/UsYJpTsUql6bLXBFK+?=
 =?us-ascii?Q?oZ7pMayCUAuzsaEZEKbaJML5i7Ju6igJYriPB2ApIcY4C5cjqqSu7hl/G0of?=
 =?us-ascii?Q?whT6dmJqiFZO+bHBQF8+Q7wt2kBKlpLl6gkHtTRvCa4VhMuU5Cj96/Hb9Ys+?=
 =?us-ascii?Q?KVnFJKRSMcY/kVnrSSSBQ+jScNMI07jqPYmsXHXUlHHXU3FCefVgHh37EgS9?=
 =?us-ascii?Q?tyMZPhrXjy0FOVk9PwYsSf39xKGMPfyoEkZkIMO/Kt5Z1HB0Ch0W1maXsNmT?=
 =?us-ascii?Q?1TCS0eRcwJFYBFS/uqVeV/eie9+Onif02bKkymjAF2U4F0GPhmeEWGnnc+oZ?=
 =?us-ascii?Q?aQ7PZadJOS4UboOziqlNHEGJ8KnRPSFKIXTLfqUxbUxGXz/u/xPNa/jrxCTV?=
 =?us-ascii?Q?svUE9C+vAT79DBtIcxwALu73HPkxrUfyhWifVu0+uFJtiCEhy0fRuowz8DYR?=
 =?us-ascii?Q?MjYDpGWoY0+ccyxs7h+KFrVA2oKeR7Gil+cmbkwVN1WXNKaP0QG2TzXhFl83?=
 =?us-ascii?Q?qZhh+n7mXA6yNk4MLu2sajsML8vbZSd3UbRpR47ZNGGYkFU8oqzbwCyuQMCK?=
 =?us-ascii?Q?NzIb7OXch6iCMCucXxLonHzINzx/CS8I6EpaVS8qFMya9aM1BFhGJ2uP4+rj?=
 =?us-ascii?Q?TCc3fca2L9y6X2vNvea030F0t4gzn69kjzF3RVOEGskCu/FfSYJ3+VehvG1d?=
 =?us-ascii?Q?ds6p+/MsXAZhp78VauJkYEKvZdJjDkMMZ+KUWTmYqJxbfjcfZQ2OhyXmPkz8?=
 =?us-ascii?Q?kJsi51WWCK5Iyq2PiIn8W+cGGES5qIafN5SuBnLf4OngZtnhBmsc/ALapj9V?=
 =?us-ascii?Q?gUlrDxf7GSKbhAwenr5eomzLIA+3krUCufxgCmIBTWUpVaZO0roxFixRP9tp?=
 =?us-ascii?Q?7dw0EFt0xMJhzT93JLmKjH8y+P51Vykzu/Yw8rZOuDxDI+uGoEMu2F6gI9gk?=
 =?us-ascii?Q?+Qgpz6pQOgurACJy/+8F9y2UaLtENQmvsQYxxE1pTLAQ9LuA7n4E4EUPt8bT?=
 =?us-ascii?Q?tKYExpTAjku4Qsnd1iGduFgm2dPZOUbuRTuGnsxvwRR7mfpwbIyfwsnU1BMN?=
 =?us-ascii?Q?IVgFKHVFVMa6nFEbOwvw8zJ7mXYjrJ2c20IjwitpaMM7vZVQ0mqTcIdAS7B2?=
 =?us-ascii?Q?XWk0SfaiZ1mXxUOmpl1flUQ98ZB+Rp2lftPoHIGN+NM8vr0uYU5PnI/eD/HI?=
 =?us-ascii?Q?1YGacHATwS/eNNMvW/ae20jjw6l2/4ugXMMroC4EHpFQoFgT4/m5eVu7HaXK?=
 =?us-ascii?Q?xJC1z6MLnQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bff1d7a5-5ebb-4fee-0d17-08de85a8871c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 11:13:20.3710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YiVBVNSvmsapJ1hN3qkozroPPfMFno7D0YYt6NHrG+5T27Y6OL1uIEi9pMe67qSMzlRXOiRtX2VHNuptL152Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9817

Add a device-managed wrapper around ghes_register_vendor_record_notifier()
so drivers can avoid manual cleanup on device removal or probe failure.

Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Kai-Heng Feng <kaihengf@nvidia.com>
---
v2:
 - New patch.

 drivers/acpi/apei/ghes.c | 25 +++++++++++++++++++++++++
 include/acpi/ghes.h      |  3 +++
 2 files changed, 28 insertions(+)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 8acd2742bb27..d31a70a05538 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -689,6 +689,31 @@ void ghes_unregister_vendor_record_notifier(struct notifier_block *nb)
 }
 EXPORT_SYMBOL_GPL(ghes_unregister_vendor_record_notifier);
 
+static void ghes_vendor_record_notifier_destroy(void *nb)
+{
+	ghes_unregister_vendor_record_notifier(nb);
+}
+
+/**
+ * devm_ghes_register_vendor_record_notifier - device-managed vendor record notifier registration
+ * @dev: device that owns the notifier lifetime
+ * @nb: pointer to the notifier_block structure of the vendor record handler
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int devm_ghes_register_vendor_record_notifier(struct device *dev,
+					      struct notifier_block *nb)
+{
+	int ret;
+
+	ret = ghes_register_vendor_record_notifier(nb);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(dev, ghes_vendor_record_notifier_destroy, nb);
+}
+EXPORT_SYMBOL_GPL(devm_ghes_register_vendor_record_notifier);
+
 static void ghes_vendor_record_work_func(struct work_struct *work)
 {
 	struct ghes_vendor_record_entry *entry;
diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
index 7bea522c0657..ca3ace828c1c 100644
--- a/include/acpi/ghes.h
+++ b/include/acpi/ghes.h
@@ -71,6 +71,9 @@ int ghes_register_vendor_record_notifier(struct notifier_block *nb);
  */
 void ghes_unregister_vendor_record_notifier(struct notifier_block *nb);
 
+int devm_ghes_register_vendor_record_notifier(struct device *dev,
+					      struct notifier_block *nb);
+
 struct list_head *ghes_get_devices(void);
 
 void ghes_estatus_pool_region_free(unsigned long addr, u32 size);
-- 
2.50.1 (Apple Git-155)

