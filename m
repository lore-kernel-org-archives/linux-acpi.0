Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013066.outbound.protection.outlook.com [40.93.201.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA7F39E17C;
	Wed, 29 Jul 2026 17:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785347855; cv=fail; b=FadV9q5KjmZMR7vbqsz5UEImlVJ19qZ77yatahXsIR0GEm5uUuQPKRsYYzAxmIMs2UEhcdYcxIVKDH9EUQfr8iG/8IO+dYgzgIYxvzS47s5/TsuIMjEqzsestrzE/R8DroZqTNqw7LkQHF1XwV7zBV/QbTT+ahweZfWBq+CG/tA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785347855; c=relaxed/simple;
	bh=9Tz821zh8PIAU8l18mhg9p3xKS4J87CxyBE8R7a09qo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XDNOGvHPGfzQVYQWK2+BjmJxsFjKLQ3irHc43VKY1JPfb3bRG8w3d6MqqQDZM0T9vgKJugD8K2F5ryPhpilDgk2xwigUM6M9PNagmPuABZSTrSP1LEOFNlwA1+i3NLNirQdbXCYrYbzQRWyW0nEiXOS0tnr9EeRlevS+PwA9RuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mplILG3x; arc=fail smtp.client-ip=40.93.201.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mplILG3x"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TuRrCwm3AwK65Z7IUdH2DPYvzSLOCVKKShDNl+KVGFhH4qPVRhn7DjTB1iqZGYaKXFu9NKzShF2AZLjWJnGTxexPStLzNP2wEldpxrmdZZA6tO/3Vm8exir6cvIRK2Mqd59Rc/5mnM8GHMg0BXWRb9Zmy9AA5Blg30boKZ34xmP8FEVyTKCZpgU/EF6UCxH4E/oFoeAiDWCtecImXSGYmjlPcid+nNxMxM2+2osuIiimZ6hRq/g5aahM9tS6Rl8w3qPsBOLWmJoPMY9/CnOojg8+WBpizhEFr1CbgecB76P18Aau0q3trPbeRCBY+pLnGFRMiF3yB7vJgSUWITKNKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ffY4XuHuUhY6ZWVyWn3L9CPUZFYFuGuYLOP21ZyGAAk=;
 b=MBrkReabsyGW8lqXUneAzkIkIRSGnVY5qBMwxFpUZQJGsx062Pz81TKmT0HKFx4JhAbsMmnUvRnP3b/afBjWo8LE7dMLVVT4BvILtPm3lFbxk1gGbcHZIKov4gHTi+3yEKhwlvTULOyf9fAnftRaT2221w5/OKZOCulploFyL9gjkbGSyco7Uu8v7xomgoFH09w5DgqPkiCKNtVC6ccwo9SWY1sl5fWXSmWdgx1Y5vbFFkiFdVRSs4uoaIq9bY3KoDbkGZiHAnZKsREIQj/J4UV6C0O8GDCgpzELHTMLsQdkXcF2lyX/u/weDhtom2qSPwrtYF4taNMvKpvuZqHvpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffY4XuHuUhY6ZWVyWn3L9CPUZFYFuGuYLOP21ZyGAAk=;
 b=mplILG3x76aoeISmiJEJcaHnqSfiyNlvM9LG072ngqI/vG1MC2AWyO5Tg14eYz8eB6OODojgC1t1lrnzQ/b2kVyBZ+ASKPhogAQfwcp8z+++Nj3DufVu4wxmIYotTFSP48nFmLP/VcwckaDF0+QVor/N2M+5jR8mit4C1Yrj48H2E+NSB8c3niIswsZIpMfFMMkAwoXg1mrqs0ob/9GYOSb9WeaqiD8g+0kjbvBczsKxAzDNFkIvFGtdnevaFObGcC9sJW6c75i2GgmS/5lrjmRTpl0QfzX76UfGTkMDdmfQT+C710BopJJKYn0w7RRbQhF9DDgpv4DymkzjVFeXfw==
Received: from BN9PR03CA0705.namprd03.prod.outlook.com (2603:10b6:408:ef::20)
 by PH0PR12MB7888.namprd12.prod.outlook.com (2603:10b6:510:28b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 17:57:16 +0000
Received: from BN3PEPF0000B372.namprd21.prod.outlook.com
 (2603:10b6:408:ef:cafe::21) by BN9PR03CA0705.outlook.office365.com
 (2603:10b6:408:ef::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend Transport; Wed,
 29 Jul 2026 17:57:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B372.mail.protection.outlook.com (10.167.243.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.1 via Frontend Transport; Wed, 29 Jul 2026 17:57:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Jul
 2026 10:56:51 -0700
Received: from dgx-1v-42.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Jul
 2026 10:56:50 -0700
From: Jamie Nguyen <jamien@nvidia.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
	<guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@kernel.org>, "Catalin
 Marinas" <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, "Rafael J
 . Wysocki" <rafael@kernel.org>
CC: Len Brown <lenb@kernel.org>, Dat Mach <dmach@nvidia.com>,
	<linux-acpi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Jamie Nguyen <jamien@nvidia.com>
Subject: [RFC PATCH 0/3] ACPI: arm64: FFH Operation Region support for FF-A (offset 2)
Date: Wed, 29 Jul 2026 10:56:35 -0700
Message-ID: <20260729175638.3796440-1-jamien@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B372:EE_|PH0PR12MB7888:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cd7bf0c-86e5-4652-1fa8-08deed9ad372
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700016|1800799024|23010399003|13003099007|6133799003|3023799007|56012099006|11063799006|5023799004|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	EzQx/BevV+yGrrHjRVaPaXM/qVJNbN5IrcdDyMe4zi6XrHfYGXyJQSpwFZut8sPsEkpb503HLP6YuLND/BcdMffToUCCB4g6mOG+hS7XX/vHVeKkDlaqo/SH6+VbDOr42LesDlcHkcFIwbGnTtSEBFtd+O0XEFfIJFj66IHwh01cuYf75855W2vzP+68k5wHfoYT/8pNKLwwKTxv2OoAJfNFvr3d0PVh8DrvgssB+Nz+GHICArSGICCHAopClM+two2jTI2YCGjs/ZD/+6Wv971G6L9T3/O2wmkHhgtnSmL56RwLtZdQOxmYdYT1lDmU7TQxCCS8K9ml5LvPQvNGHG87OG6ohIJYgyCkB5TKXDfkkCsrEfwk/cuzZoSw5zPnvHt/XZ0oMvpflVcl0GZYJG3yd7IrgmiAv4fDP5WI0GjDK7nsCX87+UD0kl/6ZF1uqlaMWXFh9bnL8loKnRP7if6LLQdirwkUBnKqdlbKpDqAV6umIfwoqE/ra3j2xgSXDC0x0o7PLO/gEbadV+h9lKIy/4WL21bLennpxbmK4fU7gOQNvFAlZhBNTruFadj0nfHGjFPJPhJwvQI0EzlNqz0MIl0jEjmWSrWIsHIVpo0eoXR2mS01I/wc8rQ6M9w43m1S9J5DibvbArsV/N0oNw3IJACH/Y8YpECPMiijCaNQ1YRVs3Y6MphK3WGnPOh7xW4i6INItZM5VN0aXWDnqg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700016)(1800799024)(23010399003)(13003099007)(6133799003)(3023799007)(56012099006)(11063799006)(5023799004)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CmQYeG/ltAA5ZKDtrPQMDqJImzqPpwtkq3HrwogaCUzoxpcL3uj8EritMEHyAhyGMjbnl0EU2Ok8PRugxsViRHz9kEZgC71RahmoILNZFZMxIysSr+XwJxomCC7XrZOXOXBIMTF7G7S300XXA+Qng2ivIp7SRCJZ1Opo/z1eRFRJ+VY+1KeXfASMjiGF6xcceQaIh06JYugWESMjip7YwVzb1KJxcJVIVr9jTWzTuCG5fXJEM2MgN6lH125E9YPRJpbZdRnu/L/sumS4o/KOiZcQ3iCUUsoVVm6pAslgGrsHp7ViFttMIm/h0b82uIHqyRh8HYxCGYvFsbsVPBBHzYjJ8KjfXZOermAjtpEAqFNsy7H/nTv3F+kEUx1rzFwSFpq3bd5zkk4LOX4j918Qncl3tEAteBaI3rFiIfRb7sAj3RF7sgmDvmGwmv6CPou0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 17:57:15.9476
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cd7bf0c-86e5-4652-1fa8-08deed9ad372
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B372.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7888

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
registers the region implies, succeeding twenty times over. That method
only returns a response when the status field reads back zero, and it
does, so the status, the copied back registers and the payload are all
landing where the firmware expects them.

That firmware always names the receiver endpoint and always sends a well
formed request, so the rest was driven from test SSDTs loaded at runtime
through CONFIG_ACPI_CONFIGFS, against the same partition. Top level AML in
a dynamically loaded table runs at load, so each table is one invocation
with the register contents under test:

  X1 zero, UUID set      endpoint resolved from the UUID, call succeeds
  X1 zero, UUID nil      rejected before any FF-A call
  X1 an unknown endpoint call attempted rather than refused, and the
                         callee's FFA_ERROR reported as FFH_FFA_CALL_FAILED
                         with the FF-A error code in X2 per table 3
  length 0x28, the min   one payload register, call succeeds
  length 0x24, invalid   rejected before any FF-A call

A second server covers FFH_FFA_NOT_SUPPORTED, since its FF-A 1.1 firmware
cannot do FFA_MSG_SEND_DIRECT_REQ2 at all. It doubles as a regression
platform: it declares no FFH Operation Regions, and an offset 2 access
there returns AE_ERROR on a distro kernel, which is what this series
removes. It also has one service UUID per endpoint, where the first
machine has six sharing one, so both partition topologies are covered.

Registration and teardown were exercised with CONFIG_ARM_FFA_TRANSPORT=m.
Nothing autoloads it, so an access before the module is loaded correctly
reports FFH_FFA_NOT_SUPPORTED; loading makes the same access reach the
FF-A driver, unloading returns it to NOT_SUPPORTED, and reloading reaches
it again.

One path is unexercised: nothing I have provokes a response that is
neither FFA_ERROR nor FFA_MSG_SEND_DIRECT_RESP2, so the -EPROTO mapping is
untested. Neither platform has a UUID that resolves to more than one
endpoint either, so the loop comparing endpoint IDs in
ffa_acpi_ffh_partition_id() was exercised instead with a throwaway stub
that makes a UUID filtered probe report two differing IDs. It returns
-ENOTUNIQ, no FF-A call is attempted, and AML reads back
FFH_FFA_INVALID_PARAMETERS. That case does look reachable rather than
theoretical, since ffa_device_match_uuid() already walks the descriptors a
UUID query returns looking for a matching endpoint ID.

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

Jamie Nguyen (3):
  firmware: arm_ffa: Split the response out of
    ffa_msg_send_direct_req2()
  ACPI: arm64: Add support for the FF-A FFH Operation Region (offset 2)
  firmware: arm_ffa: Back the ACPI FF-A FFH Operation Region

 drivers/acpi/arm64/ffh.c          | 185 ++++++++++++++++++++++++++++++
 drivers/firmware/arm_ffa/driver.c | 169 +++++++++++++++++++++++++--
 include/linux/acpi.h              |  41 +++++++
 3 files changed, 386 insertions(+), 9 deletions(-)


base-commit: 3652b49adac266a3d27cb41cdfdb7d8790fc3633
-- 
2.43.0

