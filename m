Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013013.outbound.protection.outlook.com [40.107.201.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE403C8C46;
	Mon, 12 Oct 2026 23:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791846440; cv=fail; b=hUXo0D/LADcmtnygprNbgPLrYMN4kBOqC61mGOXtR4E3ZaZmuEkLGL/pKXlpFlLot972W2C/+1qCz14+/oUdg3E3zFdNT20GrHbVCIDHxIbUIjL6ma+FiP7CLdEWW8gfnrtU4Yvslcn00Xky3uRn/bPqsHge2OwvI+ATMZYXA4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791846440; c=relaxed/simple;
	bh=vH6ig0D8KtzeL+T1IRLnLgE93rxAmXJVqIMgDxmNHJw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KEMedvDHJadXoDWM6Vqt2+13zAUlJoSp5M0T1d6OEkn3lfwnacYpRSW0NaWCqdM5tu76y/gt1LqLcRp0svH+sJ89XOt12BEQ6SBBxx/3VRkCuCcPfGOu4YEMWjkUjM+0hrTsdJy1ZWp0tQpXW0aWHwCyMlZ936Lb7uCC6Op3d0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UwgeUYLK; arc=fail smtp.client-ip=40.107.201.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UwgeUYLK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iSXUEiHSi85t0OeaEwlKSuPZXh3i+5kKI77wQfVJMBb60miWscNF7o0S1QhYwSXvJeu1rmeYKtVx6ew++uNFqq0+zJINRbC0tiD4GGYYOR8vbTPuENx7wu435vmek5jXSjTNDPL+SzGqCV+prqpUcKpjnB6gMcXGwNv4uHUIxiciKqRs72ODWlOgU0MBlfejQ6nXYiIHiiAJ7iZi2qlte3IOiWSLl6YHRz67yOLlo1nnphYImQQI0fS7nK5BkEnmGcSp4SJrJk6L9Ye8QxlC7gBiyyvN+UjOj7Sxez7viR6MHhylrsmNeQQWqgdSE2sq3siwAg9qRVi5gaLIlfUtSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1a6C48+tTiqvpilv9zvXHpSU8cZu5pjliq3edDL1Hj8=;
 b=PLt4yHMXiPqPqQT3sO9dsQGkNRYPlFcb2reZMxU5vWISbyZDDSxgYUHtT6Ldevqx4DzytVmoPJHShS0Dvckyjw8/nzssNZynNFGQ5i68qWahe/WtNHB50VJImBZifOrcurZ+kzDbemEZJEV1qpZA+u8y6Kn7Jh2tZICAgVljvoI8BuznRo5BqbalrpvunIi2sII7ArUO9iDNDTsnYRq9+UteAaTGsRGv9pRhdpnchkOOTPCx3pNKUBtRTT+izhKVr5RBjJxwlGPaIqUN040vcq5A29fciGxLotWuEV9DvcqYOPDOMbvQOKJIo4Af1brAnP5e1EfiyATatNltQx66kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1a6C48+tTiqvpilv9zvXHpSU8cZu5pjliq3edDL1Hj8=;
 b=UwgeUYLKgE5EIop4TmVTR8gW9uKAYRZJUSXOt5JI8J3qsxezLbGnOC9GIsljLeqtTAYREoFBCTiM53hbkIzq7m6Q28JrcPxLdYvvCiqRfz25N1jsE46pCYSmx4NTDJPlrPIeRpOtL0Gk/IvAR+bMO5VSwGN8jpHnSReuijIdhmCochOIv/DjBWUWRNqsWa4hU8h4Q6Wxf3OXuDqNMGHF4mEx7+A2kYqc8mLKVHQs9KDhp6BEpM11YUJGWTDjtbkXD0dMSRs6MniUn3ToSmtvtqM6f+7IY7ryRSzkzYDUJO0BxrxZElpqyP/qKWVRkPvkQnvxPpeiW2xdSN8b1N0SgA==
Received: from SJ0PR03CA0334.namprd03.prod.outlook.com (2603:10b6:a03:39c::9)
 by SA3PR12MB7858.namprd12.prod.outlook.com (2603:10b6:806:306::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Mon, 12 Oct
 2026 23:07:13 +0000
Received: from MW2PEPF00014675.namprd04.prod.outlook.com
 (2603:10b6:a03:39c:cafe::3c) by SJ0PR03CA0334.outlook.office365.com
 (2603:10b6:a03:39c::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Mon, 12
 Oct 2026 23:07:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MW2PEPF00014675.mail.protection.outlook.com (10.167.249.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 12 Oct 2026 23:07:06 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 12 Oct
 2026 16:06:32 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 12 Oct
 2026 16:06:32 -0700
Received: from dgx-1v-42.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Mon, 12 Oct 2026 16:06:32 -0700
From: Jamie Nguyen <jamien@nvidia.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, "Punit
 Agrawal" <punitagrawal@gmail.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/2] ACPI: sysfs: Expose BDAT data region
Date: Mon, 12 Oct 2026 16:06:30 -0700
Message-ID: <20261012230632.3574987-1-jamien@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PEPF00014675:EE_|SA3PR12MB7858:EE_
X-MS-Office365-Filtering-Correlation-Id: cfb93bd9-bf65-4507-cf45-08df28b5895c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|82310400026|36860700016|261009223027099003|56012099006|11063799006|10067099003|18002099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	azbPIDZdXCZV5U9oRqgxoLElgCUK0KRxU4mjoZAGbiDzSfu4dJiT3jr4wi+Vlph0yA5G6AtMAndn/OHViMeNLe8/YLk6SrlfdJTqkzP9r1qKfbreaAlS+DRrJzhy4iUcjLiiXNtYkyD8x7bMNev/98WPthVQHdxNK0gjZStB7vqGD2BArFcRa8uQL1/0JQnz+Gi4l6fox5Ueb8cFV5/8WShemdq74T82zUTIkauw+zCVKFuWQzDB/Vfpq1J/Yov+acVzQMZFCYgk9yuydjClGbSgkHhGW29L2c7EkrhnumVjFGmQONGFcCCF7GB7sP0PlNZ9K2VpDUFdnQVkNjsmK0GuR5geMfRtaEVTGFwNNXxQhbSsZ5BKSRJSDbsi02d0jsb/PkpLh+WK+57oVf0WoyQg2x6yXgbS19rAvAAeQZZiRjRHJURFzCgOzDusdazOffXsBUATdjsDaejmTEOhx8+RFegW4wRIrmPVWUPlVcZr0GfJra0dxGZ11k5PByE/UbyB+5ZeJZMHImkdxkA2ySOa0fIYXiopkwGbJFle+vdswgmpXFhBENpOwJirmfjgCqWePQZIYVWc9FzcPjYCbCTserNXBOuZsWP463AhCMkJORCFBN6tkixp+Oi9cWIRpFvHrLuPu3zccNU8etm3Xz85G6O+pbAi2FxEZpvrvJbqb9LYgkfioHZt4s3vgeaOh3pYo4eueJBcFN3htZiRWg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(261009223027099003)(56012099006)(11063799006)(10067099003)(18002099003)(6133799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7ErAPgAe/OOpeH59FMuLJ71kalEok/6LqW8K5lzdb3uzgOQv6uGANgLpQ61EXshbIkymGdzItMGwvFhRqn4u7m6kmGXK9IYShjVunDlLHfw+YGRKwe1j15qIUkcMnF/hOVcZtjc8t5p4GWI0SbSH5NgOVavbnoaxrdVwHDoyCj2q2TLknVsouE3yINrLIatKYWGhUEuFhgCFiWZFXcaO/jf/c9Uh0RkiOAlfQCrihXDOYjekWkURFdRwrzvFQenWAUbEdaWgsNkaKQGJFfyuk9DlQNvpZfeyyIcdkgfpWjQDzy+zb+NQg8+nS/z6/HkvEuh5p9aJT3L3p3GvmF0poNYw2cpDZaqdbZfHaXLxG+8UnYIUp7qqxlVyW7NhpO6HlRJK2JUB7DnOS+IPF2QK9ubpbgenTCKqkTeaMrNfXrPEi8DLcKtaak8/6ieXAhpl
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 23:07:06.7150
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfb93bd9-bf65-4507-cf45-08df28b5895c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW2PEPF00014675.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7858

The BIOS Data ACPI Table (BDAT) points to a firmware data structure that
carries memory training results and other boot-time data. Patch 2 exposes
that data as /sys/firmware/acpi/tables/data/BDAT, like the existing BERT
and CCEL data files.

Patch 1 fixes a leak in the existing data file code, where data_attr is
not freed if sysfs_create_bin_file() fails. It moves the file creation and
the cleanup into acpi_table_data_init(), and patch 2 builds on that.

Changes in v2:
- New patch 1, fixing the data_attr leak for BERT and CCEL as well.
- Patch 2: the BDAT callback only checks the table and sets the address
  and size of the data, and returns -ENOMEM if mapping the header fails.

v1: https://lore.kernel.org/r/20261009232955.866131-1-jamien@nvidia.com

Tested on an arm64 server (64K pages):

- The file matches a /dev/mem dump of the data region taken in the same
  boot, byte for byte, and decodes with valid CRCs.
- With lockdown=integrity, /dev/mem is refused and the file still reads.
- Malformed BDAT tables loaded via initrd table upgrade (test-only change
  adding BDAT to table_sigs[]) are rejected without creating a file: no
  "BDATHEAD" signature, size below the header, non-memory address space,
  zero address, and a table shorter than struct acpi_table_bdat.
- With a test-only change that makes sysfs_create_bin_file() fail with
  -EEXIST for one BDAT table, kmemleak reports its data_attr as leaked
  without patch 1, and the data_attr is freed with patch 1 applied.

Jamie Nguyen (2):
  ACPI: sysfs: Fix data_attr leak when creating a data file fails
  ACPI: sysfs: Expose BDAT data region

 Documentation/ABI/testing/sysfs-firmware-acpi | 12 ++++
 drivers/acpi/sysfs.c                          | 69 ++++++++++++++++---
 2 files changed, 71 insertions(+), 10 deletions(-)


base-commit: af32da41b0327b9c6a37856ba82b6760d6c8d10e
-- 
2.43.0

