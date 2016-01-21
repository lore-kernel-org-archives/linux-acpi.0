From: Loc Ho <lho@apm.com>
Subject: [PATCH v4 0/2] acpi: apei: Bug fix to enable APEI support for ARMv8
Date: Wed, 20 Jan 2016 17:17:37 -0700
Message-ID: <1453335459-3617-1-git-send-email-lho@apm.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:33294 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750781AbcAUARs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Jan 2016 19:17:48 -0500
Received: by mail-pf0-f182.google.com with SMTP id e65so13072961pfe.0
        for <linux-acpi@vger.kernel.org>; Wed, 20 Jan 2016 16:17:48 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: bp@alien8.de, dougthompson@xmission.com, mchehab@osg.samsung.com, tomasz.nowicki@linaro.org, fu.wei@linaro.org, rjw@rjwysocki.net, lenb@kernel.org
Cc: linux-edac@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, patches@apm.com, Loc Ho <lho@apm.com>

v4:
* Update patch commit log for gsi.c patch
* Make change to be 80 column aligned

v3
* Change the title of the patch to reflect the patch
* Completely dropped the driver. Instead, move completely to the FW by
  accessing the GIC directly.
* Fix a bug with function acpi_gsi_to_irq
* Enable APEI multiple GHES source to share an single external IRQ

v2
* Make all code more generic naming
* Still waiting for comment from Linaro folks on APEI

---
Loc Ho (2):
  acpi: Fix proper return code for function acpi_gsi_to_irq
  acpi: apei: Enable APEI multiple GHES source to share an single
    external IRQ

 drivers/acpi/apei/ghes.c |    3 ++-
 drivers/acpi/gsi.c       |    4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

