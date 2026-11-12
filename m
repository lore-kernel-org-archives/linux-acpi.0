Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794482067;
	b=QWFBfiXqfEq/yQ3FGEn7nra18VmfQz1hdeEp8kVF37CQtYyWMuPc/t58ANT1AdtBe/7A
	 By5IcfYsCD6HGbzq8D2xlH9cneT60/6nO8jBU28WYWmqbfjBPW9JxAG52ef5BUi0WhbBW
	 SNCY3utUkOGcXjHqcQMMNOCF/RE0L+RAmrddglIT1EtMyQuYB/uj7J9uUSy2TAJW3lqxc
	 QMWgYpknjHPtgwtZzyX/jvdBTCMNEr9cErU2RlkDCsoLqAAgm8vFrD0VihHPWrXMQbwcM
	 Pye7dRpgM7Ks8kbl0M7t7HibwbeXATJdwMfaGpqLkv4vcERAmbgr3Mk6xjHh+RUsIBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794482067;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer;
	bh=93RGI69NSf32DDKl2tRa+oQKvQ+ls7qrUjHeMl+sVOo=;
	b=h4OahM9WbgqXbe8P/Oh5qgOSvHv8ksmm3Vv7kvSkNfaxRFIwZ+I+s2p0gkErdFeS3Hf+
	 PuBSMYrCK4kefUSS9isz0Uwy61q2lHViQwO08EytU7YYaG8O6WxEpsfhYIM09RNY5jG9J
	 i5zndAc8OA27KSnasCFT9+cwbrFlBzuaFN8JfZ0rf7qtCmxpsc6Kg/wCqxd/ZpVBT8O3d
	 xMF3ku0uAJs2nu89WoS0/KxGP3z79xIewitUQTrzznSsw3ALFDiE2gQ3+bJjoPnXm+Kuc
	 J2JCUNL5Nem7RKvs64TqWsnRivRoDLrPq0sWICtMvRBvLNQKM7ulK/NLbIXvWLt/2dA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="PXQi/ghY";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DCE606A323
	for <linux-acpi@vger.kernel.org>; Thu, 12 Nov 2026 11:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PXQi/ghY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E73F1F00A06;
	Thu, 12 Nov 2026 11:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794482066;
	bh=93RGI69NSf32DDKl2tRa+oQKvQ+ls7qrUjHeMl+sVOo=;
	h=From:Subject:Date:To:Cc;
	b=PXQi/ghYHsB42zvaMfIYelcUUkC6pDhmx+0pXUDcmByTsQj+5qlCiHMB1TqBZybkn
	 Lkfk25UHBU+Nt7YVaJtqltuzKyzzsYMbLe1MWg5pRHZg2APHzFScDqnfzLj6Z+8j50
	 ws6zDlDJb9CvIO8rPxr4njQccjKin4oS6RPgXd1CLWJJbwxaPIonS24g6edrLskxyo
	 OhuE7WVeUbVHjmmV+B2ZPo7LWXIHTbNE0SCgnr1k0nmCXHGHzxWsiJs7ax/divQ0QY
	 sIKI3y65lvKfot6qgJNlGc8IKPv2u+UWMZa9HBrNUO00FE0Lk+37Qbxn4Lhmirz486
	 /blr/WNBW5jwQ==
From: Sudeep Holla <sudeep.holla@kernel.org>
Subject: [PATCH v2 0/3] ACPI: Arm FFH: Add support for OpRegion Offset 2
 (FF-A DIRECT_REQ2)
Date: Thu, 12 Nov 2026 11:14:05 +0000
Message-Id: <20261112-acpi_ffh_ffa-v2-0-575a9dbed22b@kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH+f9WoC/zWNwQ6CMBBEf4Xs2ZIuIFhP/ochpsBCVwklLRAN4
 d8tGA9zeMnMmxU8OSYP12gFRwt7tkOA5BRBbfTQkeAmMCQyyRFlJnQ98qNtTYgWmFVU5UiNkmc
 Ik9FRy+9Ddy9/7OfqSfW0O/aGYT9Z9zn+Ftx7f3WKRapkEaNSAS8ChZ8bojE2tu/17UVuoD62r
 oNy27Yvg6WsubkAAAA=
X-Change-ID: 20261104-acpi_ffh_ffa-14beb61ed905
To: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Sudeep Holla <sudeep.holla@kernel.org>, 
 Jamie Nguyen <jamien@nvidia.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Hanjun Guo <guohanjun@huawei.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Dat Mach <dmach@nvidia.com>
X-Mailer: b4 0.16.0

Hi,

This patch series extends the existing Linux kernel ACPI Functional Fixed
Hardware (FFH) Operation Region support to accommodate FFH Operation Region
Offset 2, as introduced in the Arm Functional Fixed Hardware Specification
v1.3.

Background
----------

The Arm FFH Specification v1.3 adds support for FFH Operation Region Offset 2.
An OpRegion declared with an offset of 2 triggers an FFA_MSG_SEND_DIRECT_REQ2
call instead of using legacy SMC/HVC or standard DIRECT_REQ variants.
This mechanism allows the platform's ACPI firmware to interact directly
with secure partitions by evaluating a service UUID.

Implementation
--------------
- Upgrades the arm64 low-level FFH handler beyond generic SMCCC calls to
  natively support the FF-A protocol. It negotiates FF-A v1.2, identifies
  sender endpoints via FFA_ID_GET, translates ACPI ToUUID properties to
  register formats, handles interrupted/yielded calls via FFA_RUN, and
  returns standard FFH status codes to AML.
- Leverages register-based endpoint discovery (FFA_PARTITION_INFO_GET_REGS)
  to resolve unique receivers from service UUIDs. This approach completely
  avoids RX/TX memory buffer ownership complexities, keeping the low-level
  ACPI FFH subsystem cleanly decoupled from the main Arm FF-A transport
  driver.

Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>
---
Changes in v2:
- Share FF-A version negotiation between ACPI FF-A and FF-A driver. I am
  keeping it seperate intentionally as I haven't analysed how this would
  change and work with FF-A v1.3
- Adopted guard(mutex) framework from <linux/cleanup.h> to manage
  acpi_ffh_ffa_lock, ensuring automatic lock release, eliminating
  error-exit labels (goto out) and replacing goto jumps with direct
  return statements.
- Simplified state tracking by removing the redundant
  acpi_ffh_ffa_version_negotiated global tracking flag.
- Introduced acpi_ffh_ffa_partition_info_regs static boolean to
  track partition information register support.
- Fixed a raw pointer offset in acpi_ffh_ffa_direct_req2() by switching
  the memcpy destination from an address-of-member expression (&args.a4)
  to an explicit offsetof(struct arm_smccc_1_2_regs, a4) calculation.
- Link to v1: https://patch.msgid.link/20261103173907.1996118-1-sudeep.holla@kernel.org

---
Sudeep Holla (3):
      firmware: arm_ffa: Share FF-A register field definitions
      ACPI: FFH: Support FF-A direct request 2 calls
      firmware: arm_ffa: Share FF-A version negotiation

 drivers/acpi/arm64/ffh.c           | 218 +++++++++++++++++++++++++++++++++++++
 drivers/firmware/arm_ffa/Kconfig   |   5 +
 drivers/firmware/arm_ffa/Makefile  |   3 +-
 drivers/firmware/arm_ffa/driver.c  |  79 ++++++--------
 drivers/firmware/arm_ffa/version.c |  39 +++++++
 include/linux/arm_ffa.h            |  31 ++++++
 6 files changed, 329 insertions(+), 46 deletions(-)
---
base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
change-id: 20261104-acpi_ffh_ffa-14beb61ed905


-- 
Regards,
Sudeep

