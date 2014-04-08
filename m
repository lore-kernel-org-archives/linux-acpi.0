From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH V3] ACPI: Update the ownership and developers for ACPI in Kconfig
Date: Tue,  8 Apr 2014 20:59:48 +0800
Message-ID: <1396961988-27557-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:44807 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756540AbaDHNBW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Apr 2014 09:01:22 -0400
Received: by mail-pd0-f169.google.com with SMTP id fp1so984411pdb.0
        for <linux-acpi@vger.kernel.org>; Tue, 08 Apr 2014 06:01:21 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Grant Likely <grant.likely@linaro.org>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, Hanjun Guo <hanjun.guo@linaro.org>

The UEFI Forum included the ACPI spec in its portfolio in October 2013
and will host future spec iterations, following the ACPI v5.0a release.

A UEFI Forum working group named ACPI Specification Working Group (ASWG)
has been established to handle future ACPI developments, any UEFI member
can join the group and contribute to ACPI specification.

So update the ownership and developers for ACPI in Kconfig accordingly,
and add another website link to ACPI specification too.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/acpi/Kconfig |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index c205653..ab686b3 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -31,10 +31,14 @@ menuconfig ACPI
 	  ACPI CA, see:
 	  <http://acpica.org/>
 
-	  ACPI is an open industry specification co-developed by
-	  Hewlett-Packard, Intel, Microsoft, Phoenix, and Toshiba.
+	  ACPI is an open industry specification originally co-developed by
+	  Hewlett-Packard, Intel, Microsoft, Phoenix, and Toshiba. Currently,
+	  it is developed by the ACPI Specification Working Group (ASWG) under
+	  the UEFI Forum and any UEFI member can join the ASWG and contribute
+	  to the ACPI specification.
 	  The specification is available at:
 	  <http://www.acpi.info>
+	  <http://www.uefi.org/acpi/specs>
 
 if ACPI
 
-- 
1.7.9.5

