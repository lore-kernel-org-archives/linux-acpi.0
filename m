From: Len Brown <len.brown@intel.com>
Subject: [PATCH 05/20] ACPI: Altix: reinitialize acpi tables
Date: Fri,  9 Mar 2007 22:49:23 -0500
Message-ID: <11734985822425-git-send-email-len.brown@intel.com>
References: <11734985781377-git-send-email-len.brown@intel.com> <11734985791126-git-send-email-len.brown@intel.com> <1173498580364-git-send-email-len.brown@intel.com> <11734985813852-git-send-email-len.brown@intel.com> <11734985822692-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:23581 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965668AbXCJDto (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 9 Mar 2007 22:49:44 -0500
In-Reply-To: <11734985822692-git-send-email-len.brown@intel.com>
Message-Id: <3fd0b2d9ad7612f249e5516d887ab7c61b24ddb9.1173498420.git.len.brown@intel.com>
In-Reply-To: <7292576043666ff39946dee14641fe719ba8c7e8.1173498420.git.len.brown@intel.com>
References: <7292576043666ff39946dee14641fe719ba8c7e8.1173498420.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: John Keller <jpk@sgi.com>, Len Brown <len.brown@intel.com>

From: John Keller <jpk@sgi.com>

To provide compatibilty with SN kernels that do and do not
have ACPI IO support, the SN PROM must build different
versions of some ACPI tables based on which kernel is booting.
As such, the tables may have to change at kernel boot time.
By default, prior to kernel boot, the PROM builds an empty
DSDT (header only) and no SSDTs. If an ACPI capable kernel
boots, the kernel will notify the PROM, at platform setup time,
and the PROM will build full DSDT and SSDT tables.

With the latest changes to acpi_table_init(), the table lengths
are saved, and when our PROM changes them, the changes are not seen,
and the kernel will crash on boot. Because of issues with kexec support,
we are not able to create the tables prior to acpi_table_init().
As a result, we are making a second call to acpi_table_init() to
process the rebuilt DSDT and SSDTs.

Signed-off-by: John Keller <jpk@sgi.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/ia64/sn/kernel/setup.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/ia64/sn/kernel/setup.c b/arch/ia64/sn/kernel/setup.c
index 8571e52..bd5373d 100644
--- a/arch/ia64/sn/kernel/setup.c
+++ b/arch/ia64/sn/kernel/setup.c
@@ -397,6 +397,8 @@ void __init sn_setup(char **cmdline_p)
 	ia64_sn_set_os_feature(OSF_PCISEGMENT_ENABLE);
 	ia64_sn_set_os_feature(OSF_ACPI_ENABLE);
 
+	/* Load the new DSDT and SSDT tables into the global table list. */
+	acpi_table_init();
 
 #if defined(CONFIG_VT) && defined(CONFIG_VGA_CONSOLE)
 	/*
-- 
1.5.0.3.310.g05ef5
