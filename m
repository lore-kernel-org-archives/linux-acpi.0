From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH] MAINTAINERS: Add ARM64-specific ACPI maintainers entry
Date: Wed,  5 Oct 2016 12:25:40 +0100
Message-ID: <20161005112540.22189-1-lorenzo.pieralisi@arm.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:40228 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751128AbcJELZP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 5 Oct 2016 07:25:15 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

The ARM64 architecture defines ARM64 specific ACPI bindings to
configure and set-up arch specific components. To simplify
code reviews/updates and streamline the maintainership structure
supporting the arch specific code, a new arm64 directory was created in
/drivers/acpi, to contain ACPI code that is specific to ARM64
architecture.

Add the ARM64-specific ACPI maintainers entry in MAINTAINERS for
the newly created subdirectory and respective code content.

Lorenzo Pieralisi will be in charge of submitting and managing
the pull requests on behalf of all maintainers listed.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Link: http://lkml.kernel.org/r/1603704.EGiVTcCxLR@vostro.rjw.lan
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f593300..2a70dd9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -316,6 +316,14 @@ W:	https://01.org/linux-acpi
 S:	Supported
 F:	drivers/acpi/fan.c
 
+ACPI FOR ARM64 (ACPI/arm64)
+M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
+M:	Hanjun Guo <hanjun.guo@linaro.org>
+M:	Sudeep Holla <sudeep.holla@arm.com>
+L:	linux-acpi@vger.kernel.org
+S:	Maintained
+F:	drivers/acpi/arm64
+
 ACPI THERMAL DRIVER
 M:	Zhang Rui <rui.zhang@intel.com>
 L:	linux-acpi@vger.kernel.org
-- 
2.10.0

