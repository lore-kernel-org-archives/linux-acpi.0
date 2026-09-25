Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013065.outbound.protection.outlook.com [40.93.201.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2703D3C9ED0
	for <linux-acpi@vger.kernel.org>; Fri, 25 Sep 2026 13:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790342465; cv=fail; b=CDhWmfFUcieadXdypL4aFp29NwuWuz3xsifuoh1/jXbJ6U/trT1QIrrvIHART4UXiMfVXkaFUJ5xSdIHLes2KZJgn9rRt9sxXNmPceRXQbueoYpwB71RgKKTwTxwF3Zy6PWZ1uWz+UViELUJtL54XTWgVyRZ57ySe9w7eAHhsJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790342465; c=relaxed/simple;
	bh=WdMN0tRBD6x0tpD0EsKDP0MlWo2ZidwUkekYCpApx2g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IIuXDyqghaSErvwT/ogc10H/B11IOAVc0qNCIV0ssMfx5jHpnmwRdehfOXZzIUSM9rQqp1vtU9yZ7hBoimVvr34zwYhUy/RhL6AKgEB9DAvaz1wHkXg4KvfX7BBQZU8k/ikOrC1qiK0fIt8nb1j+o18Qv6nCEIxnrDI4iyysFIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yPZN8ekN; arc=fail smtp.client-ip=40.93.201.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yPZN8ekN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M2QRTCWEru3KaQlIwcWr/36YCtJWsocvT8cpjQ0IQCD4ASCO6Bgpj2GU6tSUykGP8eM7oFOiiuEUhC6xkNoJiItnvXn/Hq4hLc/ND3EyIWYzQVUQHpAXrALmd0MvQpqGXm45d9ba18JCnZNpQVxFv5TT4phIK+0W/XcRNPO7c5YSFGPhYT1xY4Sqgx2dxBKKeFBy19Z77YeFMpUz2kCzTz84vgfu3lfGzR4HOh0w5HQV1qcF5sz8pfiNJFWo/bdoXjh+YvfgUtqxEBbo3xV8mIMsu0+7/pKJM7A44Pn5bz+0JeT8MVzYIdmlsTGawLSyn1PrrNrEdApJ19Gv4RQzFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qCYILF4d6v980vNW7NeCIDprWMKs+K6vj45GeGBWyyw=;
 b=ZTpEmtqOTVoFS7y0KAGP/aQXIwl3NXtMIopulscEvKC+CYXf1YNcIRYNmKbXuDMqgG0lnTI2YPx1ihafme5nu+Bm+G0tJcjh0HlPsh49V3WLuLyx4ta7IqnJg6Ks7uvoYp8NA/gkG+PZuVA5NOZVDda/J9eE6a2f/QY5fNExVliU4UDGpkYa3guIoDEPv8NLpnES200T80qYYlyRFGFgQ8LaXDNYnzpErTp6Ufcmb7vaWr9WZHsen26sIu3gVjo7/cqk/Dubv7L3xtEfpoSIq5xejUJxACEHgCOzKr/JrefSI1NcXJHH3yL+8gvIf8T3cMHie40lqxtalqh0T8QhIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qCYILF4d6v980vNW7NeCIDprWMKs+K6vj45GeGBWyyw=;
 b=yPZN8ekNtDsMLQoMm3xxCvSi25GqgSmBHijXar7VRk2LOIBctGv+dJ1pMoIG/fODurbofp2rm7IrFJExE9XmoffJ4Pr9Sx1S5advyAcgyIU9HdbLk5VAwX8bt6Qk8AdYkHy0EpYkpj3CQLYIKHxnKFnT9pgN9moIvOBN7cgaBjk=
Received: from BLAPR03CA0053.namprd03.prod.outlook.com (2603:10b6:208:32d::28)
 by SJ1PR12MB6099.namprd12.prod.outlook.com (2603:10b6:a03:45e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.22; Fri, 25 Sep
 2026 13:20:47 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2603:10b6:208:32d:cafe::4b) by BLAPR03CA0053.outlook.office365.com
 (2603:10b6:208:32d::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Fri,
 25 Sep 2026 13:20:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 25 Sep 2026 13:20:47 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 25 Sep 2026 08:20:46 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <rafael@kernel.org>, <lenb@kernel.org>
CC: Mario Limonciello <mario.limonciello@amd.com>, Arnd Bergmann
	<arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi
	<peter.ujfalusi@linux.intel.com>, Bard Liao
	<yung-chuan.liao@linux.intel.com>, Daniel Baluta <daniel.baluta@nxp.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, "Takashi
 Iwai" <tiwai@suse.com>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>, "Kai
 Vehmanen" <kai.vehmanen@linux.intel.com>, Pierre-Louis Bossart
	<pierre-louis.bossart@linux.dev>, <sound-open-firmware@alsa-project.org>,
	<linux-acpi@vger.kernel.org>
Subject: [PATCH] ACPI: Add stub for acpi_find_child_device()
Date: Fri, 25 Sep 2026 08:20:30 -0500
Message-ID: <20260925132031.4073551-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|SJ1PR12MB6099:EE_
X-MS-Office365-Filtering-Correlation-Id: 2706faf3-1d81-4eeb-6e39-08df1b07cfae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|7416014|82310400026|23010399003|13003099007|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	YlCKjg0mfwHHd4Cm9GQt3PZu3ul/PjTXGP7U7Gyz82xGKCghnXmFVeb4yH+oQJep35enQH/lLfN9mmQopYWgteafifitINJMn2WPD1umjlLirKDi3FBdHprnC1Lh4PZ0t6ZvGxYStuolXyvt9DMudZ4BRjeUnQq0LO9vuqOK9xiLE1PF3Nwr4GvHuZzS7tAiJjKeq9aHOJArZSxeWCwpGjHbEqa+lc28FqPiAb8RkASDzKYvRcOpp3vgnATS3vEnd8pESWRwa2M9al+qZ8R1GJdiSh4WsZwJwlxH3cw7cAJhrojPj4x64uAyYcXwN32whBcQlTiw8mYSsOds4PHBvpHzUPeUNCnQYZk/ceAj7Gl+6dKt+bZupttsf/5OKmk/dCsXDqkYkgSf1CQFpFIzlwl0zNACxuaZtz0TyHps6xm9iTettM+fl+MxZ9zmvN/TfW9MY+7/QgDc99Js9RmNyI5t4vzJOSP4qhszKzJnKAyKmXYEh/9R9XqjpVWMyCpO7tGepj/hQGVqKdxX3Y1MKz5dtbzjfKz9+t5Hb+CPspSdDbpaL8mFvHwEQXbv/EsDWAe3zLjKlEB0SIeFlE2uN0IEyBLNz0pZ/LH78jLqd6HEH1A577wy+wh7Dy6yWztlOWQhtS+Z78/2o8xHoLqch3eAsJ7fm2F2i4nWXORH1JA=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(7416014)(82310400026)(23010399003)(13003099007)(10067099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	V0Eryn8MsZ2fQ6jBlr81KT4uhsIQ+PyFal6RPBmPlv6xo786r2fCy3szCr6vrSFJJLmf4nCjluR7R87WDNj0ShHR+I5N1+kTZCeBBIwL7K9tjFsDsyIOGKLIYsaZH7CTUq8C5/eV9PDJixLeLSE96HExLoR3j7Enpz5YQY9M436m+Jpivw800PI+jUA/lfSj1HJVHVPvRKPuWgvNDt8IsXvUGbmXCk+co4/myyrzGNslmXZLNYepu0207nOvXn7eCsLUPnUsxagn53sMLOnhGG2omxxXzFS9xgcX7EscR11MlMeEOWT0Y0/JHAmTvNjXjiv0wnFK2QbboIBl+B5pOBu+5xD0Yxy8216kKKUOPeGLhWiAP6jOfdS0HINfrQbvkAyiUgRmdTPBJ0nNO4iCQKTK8K0RiXuNzxNiqYCTXgJnahTdqLjrjzseQduL3AU9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 13:20:47.2508
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2706faf3-1d81-4eeb-6e39-08df1b07cfae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6099

Provide a NULL-returning stub when CONFIG_ACPI is disabled so callers can
be compiled without ACPI support.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Closes: https://lore.kernel.org/linux-sound/20260925131104.118993-1-arnd@kernel.org/
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Cc: sound-open-firmware@alsa-project.org
---
 include/linux/acpi.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index ddacac8120947..710f38193d44c 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -843,6 +843,7 @@ extern bool cmos_rtc_platform_device_present;
 #define ACPI_COMPANION_SET(dev, adev)	do { } while (0)
 #define ACPI_HANDLE(dev)		(NULL)
 #define ACPI_HANDLE_FWNODE(fwnode)	(NULL)
+#define acpi_find_child_device(...)	(NULL)
 
 /* Get rid of the -Wunused-variable for adev */
 #define acpi_dev_uid_match(adev, uid2)			(adev && false)
-- 
2.43.0

