Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01683346E43;
	Fri, 20 Feb 2026 13:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771594975; cv=none; b=s3dBzCpBzZSi9E8CLLYINoaG/ZD5eDsPYJifOqjikdCYRI9OjETl03Sr8vZwW3QvJcC+OFUHcNZsztro18MNaOQsu1b3V9HTyr2JxvtKDzJF3c2bjteubUeXGM3AcU81B6FJZR9kLcPcJxWF9jPxmaoxbfTCW+KHplqoNsoKgKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771594975; c=relaxed/simple;
	bh=982hEo3jsh9UnLCSzsX35G+l2P3VUEY+ReOy8VBkpNY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=B0pLDshMK83QyplTmKu0cKZkm8qitxCvSTKBnKdI20uDtDMZzIh4OHKxa0P5+EV9fa4JqC+dT2lS3vMmE/pkiEha7Eb7LKAj3mEyhCTIW1PnpVOsDIVPJwgiHzBGHpjLZDrVYAWQufEN4c9RzCca0WwJJR4clba8+hRD1My8xfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0B01339;
	Fri, 20 Feb 2026 05:42:45 -0800 (PST)
Received: from e134710.arm.com (e134710.arm.com [10.33.10.82])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 35F8A3F7D8;
	Fri, 20 Feb 2026 05:42:50 -0800 (PST)
From: Ahmed Tiba <ahmed.tiba@arm.com>
Subject: [PATCH v2 00/11] ACPI: APEI: share GHES CPER helpers and add DT
 FFH provider
Date: Fri, 20 Feb 2026 13:42:18 +0000
Message-Id: <20260220-topics-ahmtib01-ras_ffh_arm_internal_review-v2-0-347fa2d7351b@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALpkmGkC/x3NSw6DIBSF4a0YxsVwiVbbUffRGII8yk0qGCC2j
 XHvBYf/GZxvJ8lENIncm51Es2HC4EvwS0OUk/5lKOrShDN+ZZwzmsOKKlHplowzAxplEtY6IeM
 i0GcTvXyL+mQ+dLZaq8GqQcmZlMc1GovfU3tOpR2mHOLvxDeoa3V64DAA8LHrWxihA7hRqKDRb
 THlo1CtCguZjuP4A6lGMrbBAAAA
To: devicetree@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: Ahmed Tiba <ahmed.tiba@arm.com>, Dmitry.Lamerov@arm.com, 
 catalin.marinas@arm.com, bp@alien8.de, robh@kernel.org, rafael@kernel.org, 
 will@kernel.org, conor@kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-doc@vger.kernel.org, krzk+dt@kernel.org, Michael.Zhao2@arm.com, 
 tony.luck@intel.com
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771594970; l=2888;
 i=ahmed.tiba@arm.com; s=20260219; h=from:subject:message-id;
 bh=982hEo3jsh9UnLCSzsX35G+l2P3VUEY+ReOy8VBkpNY=;
 b=cLJYGPUzLiW1gXsUelnqwCZMg4kD59OC630t667vlkxrKGG4uv/t6ou1g1meUp+dyy9N4go6C
 ZKzNSrjg4ZNB2Ox3i8urPqYhkfTwgB0fltGYDiGtN7TSDXwFzgWmNhl
X-Developer-Key: i=ahmed.tiba@arm.com; a=ed25519;
 pk=xVOtd+Qklh/4tuM3tB+BEZD4jj5a6W59C3KCNX6v7OE=

This is v2 of the GHES refactor series. The goal is to reuse existing
GHES CPER handling for non-ACPI platforms without changing the GHES
flow or naming, and add a DT firmware-first CPER provider, while
keeping the changes mechanical and reviewable.

Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>
---
Changes in v2:
- Dropped the proposed "estatus core" and kept GHES naming/flow intact
  (per Borislav Petkov).
- Re-sliced the series into smaller mechanical steps (per Mauro Carvalho Chehab).
- Minor DT binding fixes based on Krzysztof Kozlowski's feedback.
- Removed fixmap slot usage from the DT FFH driver (per Will Deacon).

Series structure:
- Patches 1-8 are mechanical moves only and do not change behavior.
- Patch 9 wires the shared helpers back into GHES.
- The DT firmware-first CPER buffer provider is added in the final patches.
- "ACPI: APEI: introduce GHES helper" is internal build glue only
  and does not introduce a new user-visible configuration option.

- Link to v1: https://lore.kernel.org/r/20251217112845.1814119-1-ahmed.tiba@arm.com

---
Ahmed Tiba (11):
      ACPI: APEI: GHES: share macros via a private header
      ACPI: APEI: GHES: add ghes_cper.o stub
      ACPI: APEI: GHES: move CPER read helpers
      ACPI: APEI: GHES: move GHESv2 ack and alloc helpers
      ACPI: APEI: GHES: move estatus cache helpers
      ACPI: APEI: GHES: move vendor record helpers
      ACPI: APEI: GHES: move CXL CPER helpers
      ACPI: APEI: introduce GHES helper
      ACPI: APEI: share GHES CPER helpers
      dt-bindings: firmware: add arm,ras-ffh
      RAS: add DeviceTree firmware-first CPER provider

 Documentation/admin-guide/RAS/main.rst             |   18 +
 .../devicetree/bindings/firmware/arm,ras-ffh.yaml  |   71 ++
 MAINTAINERS                                        |    6 +
 drivers/Makefile                                   |    1 +
 drivers/acpi/Kconfig                               |    4 +
 drivers/acpi/apei/Kconfig                          |    1 +
 drivers/acpi/apei/apei-internal.h                  |   10 +-
 drivers/acpi/apei/ghes.c                           | 1024 +------------------
 drivers/acpi/apei/ghes_cper.c                      | 1026 ++++++++++++++++++++
 drivers/ras/Kconfig                                |   12 +
 drivers/ras/Makefile                               |    1 +
 drivers/ras/esource-dt.c                           |  264 +++++
 include/acpi/ghes.h                                |   10 +-
 include/acpi/ghes_cper.h                           |  143 +++
 include/cxl/event.h                                |    2 +-
 15 files changed, 1558 insertions(+), 1035 deletions(-)
---
base-commit: 8bf22c33e7a172fbc72464f4cc484d23a6b412ba
change-id: 20260220-topics-ahmtib01-ras_ffh_arm_internal_review-bfddc7fc7cab

Best regards,
-- 
Ahmed Tiba <ahmed.tiba@arm.com>

