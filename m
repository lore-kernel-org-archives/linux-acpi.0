From: Loc Ho <lho@apm.com>
Subject: [PATCH v3 0/2] acpi: apei: Bug fix to enable APEI support for ARMv8
Date: Fri,  6 Nov 2015 17:51:57 -0700
Message-ID: <1446857519-5908-1-git-send-email-lho@apm.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34742 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751941AbbKGAwM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 6 Nov 2015 19:52:12 -0500
Received: by padhx2 with SMTP id hx2so129877145pad.1
        for <linux-acpi@vger.kernel.org>; Fri, 06 Nov 2015 16:52:12 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: dougthompson@xmission.com, bp@alien8.de, mchehab@osg.samsung.com, tomasz.nowicki@linaro.org, fu.wei@linaro.org, rjw@rjwysocki.net, lenb@kernel.org
Cc: linux-edac@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, jcm@redhat.com, patches@apm.com, Loc Ho <lho@apm.com>

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

 drivers/acpi/apei/ghes.c |    2 +-
 drivers/acpi/gsi.c       |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)
