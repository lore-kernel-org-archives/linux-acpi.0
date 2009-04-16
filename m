From: "Darrick J. Wong" <djwong@us.ibm.com>
Subject: [PATCH v2] acpi: Fix regression where _PPC is not read at boot
	even when ignore_ppc=0
Date: Wed, 15 Apr 2009 17:27:12 -0700
Message-ID: <20090416002712.GX8311@plum>
References: <20090415225348.GW8311@plum>
Reply-To: djwong@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:59066 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752574AbZDPA1O (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Apr 2009 20:27:14 -0400
Content-Disposition: inline
In-Reply-To: <20090415225348.GW8311@plum>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Renninger <trenn@suse.de>, cpufreq@vger.kernel.org, linux-acpi@vger.kernel.org

Earlier, Ingo Molnar posted a patch to make it so that the kernel would avoid
reading _PPC on his broken T60.  Unfortunately, it seems that with Thomas
Renninger's patch last July to eliminate _PPC evaluations when the processor
driver loads, the kernel never actually reads _PPC at all!  This is problematic
if you happen to boot your non-T60 computer in a state where the BIOS _wants_
_PPC to be something other than zero.

So, put the _PPC evaluation back into acpi_processor_get_performance_info if
ignore_ppc isn't 1.

This second version restores the correct function call, which simplifies
the patch.  I apologize for the churn and the poor eyesight.

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
---

 drivers/acpi/processor_perflib.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)


diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index cafb410..85af717 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -348,7 +348,11 @@ static int acpi_processor_get_performance_info(struct acpi_processor *pr)
 	if (result)
 		goto update_bios;
 
-	return 0;
+	/* We need to call _PPC once when cpufreq starts */
+	if (ignore_ppc != 1)
+		result = acpi_processor_get_platform_limit(pr);
+
+	return result;
 
 	/*
 	 * Having _PPC but missing frequencies (_PSS, _PCT) is a very good hint that
