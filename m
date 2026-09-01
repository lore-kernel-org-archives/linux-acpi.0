Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010003.outbound.protection.outlook.com [52.101.201.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2512A49DBA1;
	Tue,  1 Sep 2026 19:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788290995; cv=fail; b=RWcnGxvy3IhYvrt5F8SBfABXYmAtFozNuisOxZgzApZqLYKwSK10X7q6sgAtyW0hsKuvBgeuQ+zJgyRLEg2+zPxaduj9lqwW+4FBazsdYQUEU9PUVUJSNB5QRlcS5FE9+y9V46vmFSDEdgdOFkpzrB9nZ9XfZfweNzlbKqb0FWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788290995; c=relaxed/simple;
	bh=bswFVxKyX44ut6WvOIQ3be01BGjQS5Pyn43HOtIr2cQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qV5s40tr9zdziF29hXHLWRewNMm7u4qzyUpqo4hjiCeDppO12lrdY0r5NWBOtgbTU9r/ZcXlcfrH5YMpxHjprt3ifNwcJywMQx7PvfwhHJsgImRquE2xS5auXUyJpJMGoyqPgRlINtsa+Ur3hjh1eX22ArTmWVcqJjdNPQQ49WM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OH1ue0gX; arc=fail smtp.client-ip=52.101.201.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OH1ue0gX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IUnHdXlp2zv3vShKgE59FcEmY8tFlHRoG0nyeZKB7tTaUpTw4/q0M0hMnZAcaWn+w+XG1UUt3An9kIQXQqNNGEXRa4eaCl3i8NEsIjhaK2IsZcG70Yh/FM3uWpDaFed1j2BhPmuoEMqY3y8zUvEYLG7A+4Wcac6DYQ2n9NN2p8PQfyziJtRvCOme9Ka4eUkOCxI5a+ajOMKX4jspxzpAXozMlBnLn1HW1FMYJJFZQ7MQgctGE/0YyGtL9ovfYw60JYwspL1aPD1wfgm//yXFchTNohSv0+LvtiBmRe9bDO4izC63ZKLXdT5TwKhNNaTBHTXFe/AFLrGhJ50f/HShYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dxZTshZEgZXGhYfLsiriVMJwDUBLldarkYtDi6rdzOY=;
 b=KXWsrcL4aVt7wCk2zPFbY28VEnxATm0p9lNzASkqhYrWprveRLcDfZFFGQtZpmysrTaEM0u/5uL6OTMhkSF96yOlM8VOI7Q8ZYaxkycDFdlnwDlwpZaxxMNZ4KLy5ROXXYqfS5/zAm5l6gYOXpym91LglKFRaftuMc8JE6Z+YY3ew63yBzXAfov+wFbtUK2XB7m5Oc4M7TVj41tkl2q7N/AjfllCMHO/skHftfmVJNAiclfKb00uS2OKrXXgI1eR10Efjv6Vsk2NQCWT5JbKWj+WZ+/wZ1YA57Mxq4iSfOIG9CSA5nyyw2rN9yB9A0hkAWzBID8rwqzxQppcSZorjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dxZTshZEgZXGhYfLsiriVMJwDUBLldarkYtDi6rdzOY=;
 b=OH1ue0gXt5BYnu9ZFeFqHKctFIkj7O2iu1lbR6L0zxyIq6zsg9F6Nra2neRN65zhoWn3w4B5RW6RPCqpmqsxplTKIwnFUbJhX5G0+Eknd6Qa0cyiO8h3qQyOX1XAYIVHpCK2Zz0RRZYx1C3MYxR67jfWvkr1D+eyidgP1KjTgA9d8WviEE1qmkj6EJrIhxCMUiINx/ZZCcNwdu36dz1MXIwGB4EuwwCiGcq+/cyudIykMuXwjP76TWWNp4o6fZ145WfqfFoUnAhBAex454CMvI+5fZpCOFTc+i0f64r9FHyonNL91/3r5X287oPMOf2wp86PeDv1swSVj9R0ag7x+Q==
Received: from CH0PR03CA0018.namprd03.prod.outlook.com (2603:10b6:610:b0::23)
 by PH8PR12MB7110.namprd12.prod.outlook.com (2603:10b6:510:22e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 19:29:46 +0000
Received: from BN3PEPF00022BBE.namprd04.prod.outlook.com
 (2603:10b6:610:b0:cafe::1b) by CH0PR03CA0018.outlook.office365.com
 (2603:10b6:610:b0::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Tue, 1
 Sep 2026 19:29:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF00022BBE.mail.protection.outlook.com (10.167.248.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 19:29:45 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 12:29:13 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 12:29:13 -0700
Received: from dgx-1v-42.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46 via Frontend
 Transport; Tue, 1 Sep 2026 12:29:12 -0700
From: Jamie Nguyen <jamien@nvidia.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
	<guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@kernel.org>, "Catalin
 Marinas" <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, "Rafael J
 . Wysocki" <rafael@kernel.org>
CC: Len Brown <lenb@kernel.org>, Dat Mach <dmach@nvidia.com>,
	<linux-acpi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Jamie Nguyen <jamien@nvidia.com>
Subject: [PATCH v2 0/3] ACPI: arm64: FFH Operation Region support for FF-A (offset 2)
Date: Tue, 1 Sep 2026 12:29:03 -0700
Message-ID: <20260901192906.133670-1-jamien@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BBE:EE_|PH8PR12MB7110:EE_
X-MS-Office365-Filtering-Correlation-Id: e3a09347-fa15-46fb-1e23-08df085f616f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|36860700016|376014|1800799024|7416014|10067099003|6133799003|3023799007|56012099006|5023799004|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	YSh2Zct/Avw/KKAODZ6ilG0iZWH/8tJIygTyPBf8thLWZtE/zQqBo5g6frfIv432BAVSlAXv4xbR3cyc6gjNmgFmYWbBxbtWPgqXUtamx/n327OAoBUja/kxHyuFarzHDSP4SBd88uYhHp/1ZxUn7wTJnM/0u5Lg2LYj6G4fLgAKrN4VrQsy2FUMNCI0ElZAKP5oyay5Ut1E2Y8f4ElRTkkvOjwqJT12uxjmc3aGURwIhY/aLsjM1SjBC5fBMv/7+B19wMVi5beigY3ZwWfoIRMaeU2V53r8XyXyYtjLDvxIUM/8WhiUn/nVWbAgcWp3hK8bnxZAz8ak4x6YGAQklkaFxfHPjwY/ur8Ww5+kvTxxrIuMUwdmpE3XSunt0TIACWM3descEgPuqp3NkzMnQKguiLQwEt/XDWoM6aJI10i/6GgS0qp4Q6v3hiCZ36wASGPOa0wI/guhXvSmf0eQnmPftDtnZsTLXP0qtrSIzS794y6Qqdv2pYQGiFs9r6kMhvsFQatFW2mvWPidMcriw8xDqSfj1sGEnbD1ENEGA9kbVZbrErtw+A5p9LhQhbtG+EpqmLfI7PnAZrn3rmJhLwOW24xItASHwFarRU7B5GDuFAEjf1tA2Kjh5trPNOGuquU3GDO1iwXaCIJmyjlZIq7g2RkXAKwNFUTlvct55nDqkg6FnFXK1eU1g7mLUoUqd2EWJpIj3kQ8FPGQV7v3kg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(1800799024)(7416014)(10067099003)(6133799003)(3023799007)(56012099006)(5023799004)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sn2RfXyUEVB3OVq3DCJh7u5HMsjyw4u3duLRGp5u/CKLQnxqtFPgXD+N7Jue3+WHGRcce3mJRPq0H0ZnAf4gZTQ+ndhadaetVENDenvYNCG+vBbWb7OzVx3noI5K3XmPhx8yiU88m3YXgsNnW/4qNTvH8bpOESoQ2OK0Fqtpkb/2xaD7fdCtW8JsKEPZDU/abkJwnUwwRexA0XR9LY+TEQLhd9KxKjTLwXijTwBGSvFuwSv1J7X3ziWroskC03mfuzFTOesYAwI+H/+4fs80qnDq5uLwGGhwz5QH3YITWz5POBR/ODtdr4JZrwLfaYsvDVlX5hBtB56vHfil3DMPgDcfkWlojCuNi7Ud5OFzxb+cpJrDZU70XntbDKrOna543XzAtc3foWSJ4IKf6atIylNgmzH+y2maEMYh5c6Hw67s33cBx0FwCCA0FR2GYx9K
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 19:29:45.7607
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3a09347-fa15-46fb-1e23-08df085f616f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BBE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7110

Arm DEN0048D (Functional Fixed Hardware Specification v1.3), published in
March 2026, adds a third FFH Operation Region flavour:

  https://developer.arm.com/documentation/den0048/latest/

An Operation Region declared with an Offset of 0x2 triggers an
FFA_MSG_SEND_DIRECT_REQ2 call instead of a bare SMC or HVC:

  OperationRegion (AFFH, FFixedHW, 2, 40)
  Field (AFFH, BufferAcc, NoLock, Preserve) { FFAD, 320 }

Each 64-bit field is one register, ordered from X0. X0 carries the call
status on return, X1[15:0] the receiver endpoint ID (or zero, which asks
OSPM to resolve it from the UUID), X2-X3 the service UUID written with
ToUUID(), and X4-X17 the payload. The region Length is 32 + 8 * N bytes
with 1 <= N <= 14, so X0-X4 at minimum and X0-X17 at most.

The spec recommends offset 0x2 for new platforms on the grounds that not
every OSPM implements offsets 0x0 and 0x1. Linux has had both since v6.2
but nothing for 0x2, so AML using the recommended encoding currently gets
AE_ERROR back.

These patches implement it. I could not find any prior posting of this on
linux-acpi or linux-arm-kernel, so apologies if I have missed one and
duplicated someone's work.

All three patches are co-developed with Dat Mach.

Design
------

drivers/acpi/arm64/ffh.c holds the DEN0048D side: region length
validation, the X0-X17 layout, the ToUUID() to FF-A UUID byte order
conversion, and the table 3 status codes. drivers/firmware/arm_ffa/ holds
the FF-A side: resolving a service UUID to an endpoint, and the call
itself, including the FFA_YIELD and FFA_INTERRUPT re-invocation DEN0048D
asks for.

The two talk through an ops structure the FF-A driver registers rather
than a direct call, because ffh.c is built in under a bool Kconfig symbol
while CONFIG_ARM_FFA_TRANSPORT is a tristate. Unregistration takes the
rwsem for writing, so it cannot race with an access already in flight.

None of what the handler needs was reachable through the existing
ffa_device interface. ffa_sync_send_receive2() always addresses
dev->vm_id, so a receiver endpoint ID supplied by AML cannot be honoured.
UUID to endpoint resolution had no in-kernel user at all. And
ffa_msg_send_direct_req2() throws away the response registers DEN0048D
wants copied back to AML. Patch 1 splits those out, leaving what existing
callers see unchanged.

Testing
-------

Built on arm64 with CONFIG_ACPI_FFH=y and CONFIG_ARM_FFA_TRANSPORT both =y
and =m, and with CONFIG_ACPI_FFH=n, W=1 clean. Every patch builds on its
own.

Runtime tested on an Arm server whose firmware reports FF-A 1.3 and picks
offset 2 in its TPM Physical Presence Interface method. Reading
/sys/class/tpm/tpm0/ppi/response drives it; kprobes show the call reaching
ffa_acpi_ffh_direct_req2() with the endpoint and the fourteen payload
registers the region implies. That method only returns a response when the
status field reads back zero, and it does.

That firmware only ever sends well formed requests naming the endpoint, so
the rest was driven from test SSDTs loaded through CONFIG_ACPI_CONFIGFS
against the same partition, one invocation per table:

  X1 zero, UUID set      endpoint resolved from the UUID, call succeeds
  X1 zero, UUID nil      rejected before any FF-A call
  X1 an unknown endpoint call attempted rather than refused, and the
                         callee's FFA_ERROR reported as FFH_FFA_CALL_FAILED
                         with the FF-A error code in X2 per table 3
  length 0x28, the min   one payload register, call succeeds
  length 0x24, invalid   rejected before any FF-A call

A second server, whose FF-A 1.1 firmware cannot do
FFA_MSG_SEND_DIRECT_REQ2, covers FFH_FFA_NOT_SUPPORTED and regressions: it
declares no FFH Operation Regions, and an offset 2 access there returns
AE_ERROR without this series. It has one service UUID per endpoint where
the first machine has six sharing one, covering both topologies.

With CONFIG_ARM_FFA_TRANSPORT=m, which nothing autoloads, an access before
the module is loaded reports FFH_FFA_NOT_SUPPORTED, loading makes it reach
the FF-A driver, unloading returns it to NOT_SUPPORTED, and reloading
reaches it again.

One path is unexercised: nothing provokes a response that is neither
FFA_ERROR nor FFA_MSG_SEND_DIRECT_RESP2, so the -EPROTO mapping is
untested. Neither platform has a UUID resolving to more than one endpoint,
so the endpoint ID comparison in ffa_acpi_ffh_partition_id() was exercised
with a throwaway stub reporting two differing IDs: it returns -ENOTUNIQ,
no FF-A call is attempted, and AML reads back FFH_FFA_INVALID_PARAMETERS.
ffa_device_match_uuid() already walks the descriptors a UUID query
returns, so that case looks reachable rather than theoretical.

Open question
-------------

1. ffa_msg_send_wait_for_completion() loops on FFA_YIELD and FFA_INTERRUPT
   with no bound, sleeping 1 ms per FFA_YIELD round. The loop predates this
   series and DEN0048D does require the reinvocation, but until now it was
   only reachable from in-kernel FF-A drivers. This series opens it up to
   any control method that writes the Operation Region, including at
   enumeration time, so a partition that keeps yielding would stall an AML
   thread indefinitely.

   Bounding it would affect the existing FF-A callers too, and table 3 has
   no status code for a call that was abandoned, so it may be out of scope
   for this series unless you disagree.

v1: https://lore.kernel.org/all/20260729175638.3796440-1-jamien@nvidia.com/

Changes since v1:
 - Rebased onto v7.3-rc1. The code is byte for byte identical to v1; only
   the base moved, and it applies to current linux-next as well.
 - The testing above was repeated on v7.3-rc1: the build matrix
   (CONFIG_ACPI_FFH=y and =n, CONFIG_ARM_FFA_TRANSPORT=y and =m, W=1 over
   both directories, and each patch on its own), and the runtime testing on
   both machines. On the FF-A 1.1 machine a diff against an unpatched
   v7.3-rc1 shows FF-A bringup, partitions, driver bindings and the whole
   dmesg error set unchanged, with the offset 2 access moving from AE_ERROR
   to FFH_FFA_NOT_SUPPORTED.
 - Not repeated on rc1: the throwaway stub for the endpoint ID comparison,
   and the CONFIG_ARM_FFA_TRANSPORT=m load and unload cycle. Both were run
   on the v1 base.
 - No review comments were received on v1.

Jamie Nguyen (3):
  firmware: arm_ffa: Split the response out of
    ffa_msg_send_direct_req2()
  ACPI: arm64: Add support for the FF-A FFH Operation Region (offset 2)
  firmware: arm_ffa: Back the ACPI FF-A FFH Operation Region

 drivers/acpi/arm64/ffh.c          | 185 ++++++++++++++++++++++++++++++
 drivers/firmware/arm_ffa/driver.c | 169 +++++++++++++++++++++++++--
 include/linux/acpi.h              |  41 +++++++
 3 files changed, 386 insertions(+), 9 deletions(-)


base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
-- 
2.43.0

