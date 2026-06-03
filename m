Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011062.outbound.protection.outlook.com [52.101.62.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C800E31F986;
	Wed,  3 Jun 2026 06:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780468444; cv=fail; b=oAB7LNK8yxkTWVoEQch882XcPXwrZ95HK3t5Q/WpDKtNQBCb8n/RKnqfB7GYrkrUv8jrvZQqDBMebao5nZRuJXEvJjOSJ6VawBpLwUQM+4wklL1QRZfiQcarCaLThr3UrOX7MDK4Kg1raGbMuhpJDSeXlvrqIsM7v5MFEqfheMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780468444; c=relaxed/simple;
	bh=URoVmVOvSe3zuk7cDRzzRYIrgyqzoD7+xZzU52FlUZY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P4UkWOy0xLVYH4lDw0fctZXzK605NmCqZLRsB37+e9aoZdf3LI4Pv0PWQy7uceWegtR62+q2SGyC3GGP2qN8THvoi7NicflKQqEuHrl4unnvJjkOV0Y77upIiekpb1HtPNQB9ctjkt2BLePEJggr1HDrgJNdewky8rxC8jkTE3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NhQpKQyN; arc=fail smtp.client-ip=52.101.62.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NhQpKQyN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GsRqJqpSLA7YUtmhOnbto8N7NYinyeE0/ij7KeqSjr38qylSsFXUWwD/9u2rK8ExLOxV/A6YCxU6EnnOlPtKZ/elyM8SAsoEdbLoHrRQ9YqihdgjB0QvJfvvVAbvPoguwEEzb/OYjiwy7cGDa6BxFtBSSDtUs2PNNiBsC85zxCRhTvAKCS68iK9NOw/oAyiMxElkBDK4a4hWgP3xlxE6sAP9vd6YGP5o87OOwgI2uUciFT6vrD3gACGxIHRawLDa6lLmLaKcQmL/z24zAL6URITHkcuk4IdVfQ3xJuRGXRcb+2lCc1Z4oEK7cdJEsu6c+Dwu/l8J2yNl3XeqvKUfwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S3QSn3EPaX7cOwFrI5f6ihMmUGWNj2gYP1azKpOS2a0=;
 b=ZUQie5lmL87HyAJMNRVeNJmddJPMry6KnlNXSVknGHiZeMl1v5TTCCUo5o21tLpAOJ5jwnGkwMZYyx4qNIbzmKGNtpW0RlHER8M8HEzpByyKk656Ac9WPkwvJDORmpfpi86y2WdyU44O/HN+TmJ+C8UkhdjytI7GvJXCDeQNU5AC9n3bkFQfKxQWG3t2mp6hD5CLD6gPA+iSzJ8mM+h3rN+0sQm1gFUpKIIVJTXGQk+/ygpHJL1FwRe9/bdCUP8E5+4M5S64vDzDyrC/F36N6ZAmevvM/BGOvxNIkvrkzo19zLLdPo6ZblbEpsGu60UDJMBo4PzsigvdYxhbGy7p2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S3QSn3EPaX7cOwFrI5f6ihMmUGWNj2gYP1azKpOS2a0=;
 b=NhQpKQyNeFnRFafUuzpPIaGgMQ1pS4qtHSpsLXlNuVIhfKa0bvXwjW3uBf0Me6YEbkMqsI4lQI0Jkwu08SVX6l5Tr6mZxbTAI5XbZYozwKpzM+nZxd208ntX/5wq85tZ9CWX/wrumIMYHxDAMeo7xTgy3LdHudaiaEJ6YncwJxg=
Received: from BL1PR13CA0212.namprd13.prod.outlook.com (2603:10b6:208:2bf::7)
 by DM4PR12MB7552.namprd12.prod.outlook.com (2603:10b6:8:10c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 06:33:56 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:208:2bf:cafe::a0) by BL1PR13CA0212.outlook.office365.com
 (2603:10b6:208:2bf::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 06:33:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 06:33:55 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 3 Jun
 2026 01:33:50 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Borislav Petkov <bp@alien8.de>, Mario Limonciello
	<mario.limonciello@amd.com>, Yazen Ghannam <yazen.ghannam@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>
CC: Vilas Sridharan <Vilas.Sridharan@amd.com>, K Prateek Nayak
	<kprateek.nayak@amd.com>
Subject: [RFC PATCH 1/3] ACPICA: actbl2.h: ACPI 6.5: PHAT: Add more struct definitions
Date: Wed, 3 Jun 2026 06:33:14 +0000
Message-ID: <20260603063317.13665-2-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603063317.13665-1-kprateek.nayak@amd.com>
References: <20260603063317.13665-1-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|DM4PR12MB7552:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d05c99e-58ea-4134-4fd7-08dec13a1618
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026|13003099007|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	kfFfNIvx3NmeOpbKL7m7Fo2TqumtjgoZHIqx9lDrJukEooO9BtWz37qibpJO33vYg79ciwrrEKQcqztNIspvOonImuPPgFnUJOFnb+JnL654Gt99CkEoYlSwm7f9aj+qUugwrEVXzNlbrNfzw/CgnYVuivXrFOm3xRXhcQjTqYLxtzUxH//57rc/dpEJdPUXjOAQXlAQJOj3FVLwv6+y8DoZdbSNaRNMdBf2E9Uq2eFXquOz5kTVnHGOAsvtYF2wRtPkY8cTuiaMMsMD0h/ghFno07jgyX/iLeZvV/sH/yvrKvNqe3I3RbYakmxPCDmr6s4CJiTUWZvGpeHhDTTGjN0xdjDJAszSe4qolTkugov80Fwp6uuFNO76pgiKec5vWJFgoQyYDMEO075Q9pJyU1oKp9qoYZEO3d7EP2tv+ot7DntTiuQWvEN3o9mFX9e5Oisz58qD65wDgCgGHYfx6YRbjrMHwiBObQhZYmOyLtadRUGG7j9PO96XCj6Nj/mk2Yfrk16xTrWP2qTb2OBw8jXgW73DM/57uoDJt7eRc0WM6p9pORvo5Rmb7wHVDTG+AKcFAWcmFczIUtCdzwXZGQfZ9YFGFE1HGkV1cApVHb2hxH5puYzhwC3CKi6hK5Lwh03WN96DXYX4lIsLGpOjWbgE42ze5TtvQqrgzb247aT9cnx32+DUpBgTAjv6qoBt
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(13003099007)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8fRq6SZu7C2GUtpyRj92Wamg+PClMTvVMVKv+rsWleLy/O6h3BJDCPPUQeOD6wySdOlxznIvkqVKif+IFq3ezjAOFRTXXwP6IIk0+zQoQHzqyWGS31PgFnPiTiPPp0NSQaxxoh5JaUK68E0GxZaMPGdbeC3ZfVEK3mnuPAEQ2oJ6xldRXolq9hrll8xCgDlWgNQfBVGZCIiu0pcHSUR4J3RNb8vnl4Xb0JkF4VXNxP2WKiOlTUTjnHRQz7zBXMgy+pb9SYelK8YiEQw/81Tx51xQI4I/s5g0BOwH5FV6g8QWmoza/E4MMblt4e9uh1jgCoqSZa7wsEiFPt9OKn+YvVW7oFh5kimkUjOYOkzDb5qpYrJQDpRiPjlMpVD+Ho3XBR1gscObixds7tw4uI8UKL6Tq/ZXihtx/OCg+dNujaf99r8GU2+Fd4L/pmt1N93E
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 06:33:55.5715
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d05c99e-58ea-4134-4fd7-08dec13a1618
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7552

The ACPI Specification v6.5 [1] under Sec. 5.2.31 "Platform Health
Assessment Table (PHAT)" listed additional definition for
"Device-specific Data" and "Vendor Specific Reset Reason Entry" in
Table 5.168 "Reset Reason Health Record Structure" and
Table 5.169: "Reset Reason Health Record Vendor Data Entry".

Add these definitions as part actbl2.h. The struct definitions will be
used in the subsequent commit to implement a generic PHAT parser for
vendor entries.

Link: https://uefi.org/sites/default/files/resources/ACPI_Spec_6_5_Aug29.pdf [1]
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 include/acpi/actbl2.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 5c0b55e7b3e4..bff0b92d0c82 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -2844,6 +2844,20 @@ struct acpi_phat_health_data {
 	u32 device_specific_offset;	/* Zero if no Device-specific data */
 };
 
+struct acpi_phat_device_data {
+	u8 supported_sources;
+	u8 source;
+	u8 sub_source;
+	u8 reason;
+	u16 vendor_count;		/* Zero if no Vendor specific data */
+};
+
+struct acpi_phat_vendor_element {
+	u8 vendor_guid[16];
+	u16 length;
+	u16 revision;
+};
+
 /* Values for Health field above */
 
 #define ACPI_PHAT_ERRORS_FOUND          0
-- 
2.34.1

