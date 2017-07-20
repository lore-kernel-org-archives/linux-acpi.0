From: Loc Ho <lho@apm.com>
Subject: [PATCH v5 0/1] acpi: apei: Bug fix to enable APEI support for ARMv8
Date: Thu, 20 Jul 2017 14:36:02 -0700
Message-ID: <1500586563-7088-1-git-send-email-lho@apm.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:36736 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935258AbdGTVgH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Jul 2017 17:36:07 -0400
Received: by mail-pf0-f182.google.com with SMTP id o88so16543429pfk.3
        for <linux-acpi@vger.kernel.org>; Thu, 20 Jul 2017 14:36:07 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: bp@suse.de, msalter@redhat.com, rafael@kernel.org, tbaicar@codeaurora.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@apm.com, Loc Ho <lho@apm.com>

v5:
* Remove the patch set 1/2 as it was accepted
* Fix the signed-off-by using Co-authored-by

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
Loc Ho (1):
  acpi: apei: Enable APEI multiple GHES source to share an single
    external IRQ

 drivers/acpi/apei/ghes.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
1.8.3.1

