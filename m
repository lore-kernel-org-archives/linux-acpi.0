From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Subject: [PATCH 0/2] ACPI : Introduce support for _CCA object
Date: Wed, 29 Apr 2015 08:44:07 -0500
Message-ID: <1430315049-4663-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-by2on0120.outbound.protection.outlook.com ([207.46.100.120]:45248
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1422991AbbD2NoQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 29 Apr 2015 09:44:16 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, catalin.marinas@arm.com, will.deacon@arm.com
Cc: msalter@redhat.com, hanjun.guo@linaro.org, al.stone@linaro.org, grant.likely@linaro.org, arnd@arndb.de, leo.duran@amd.com, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

This patch series introduce support for _CCA object, which is currently
used mainly by ARM64 platform to specify DMA coherency attribute for
devices when booting with ACPI.

A copy of ACPIv6 can be found here:
    http://www.uefi.org/sites/default/files/resources/ACPI_6.0.pdf

This has been tested on AMD-Seattle platform, which implements _CCA 
object as described in the AMD Opteron A1100 Series Processor ACPI Porting Guide:

http://amd-dev.wpengine.netdna-cdn.com/wordpress/media/2012/10/Seattle_ACPI_Guide.pdf

Changes From RFC: (https://lkml.org/lkml/2015/4/1/389)
    * New logic for deriving and propagating coherent attribute from
      parent devices. (by Mark)
    * Introducing acpi_dma_is_coherent() API (Per Tom suggestion)
    * Introducing CONFIG_ACPI_MUST_HAVE_CCA kernel configuration.
    * Rebased to linux-4.1-rc1

Suravee Suthikulpanit (2):
  arm/arm64: ACPI: Introduce CONFIG_ACPI_MUST_HAVE_CCA
  ACPI / scan: Parse _CCA and setup device coherency

 arch/arm/Kconfig             |  1 +
 arch/arm64/Kconfig           |  1 +
 drivers/acpi/Kconfig         |  3 +++
 drivers/acpi/acpi_platform.c |  5 ++++-
 drivers/acpi/scan.c          | 45 ++++++++++++++++++++++++++++++++++++++++++++
 include/acpi/acpi_bus.h      |  9 ++++++++-
 6 files changed, 62 insertions(+), 2 deletions(-)

-- 
2.1.0

