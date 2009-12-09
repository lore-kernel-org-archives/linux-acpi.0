From: Len Brown <lenb@kernel.org>
Subject: [PATCH 07/14] ACPICA: Change package length error message to an info
 message
Date: Wed, 09 Dec 2009 12:22:08 -0500
Message-ID: <7d5d05d0704127c9acd24090c14731c111bd0af1.1260379153.git.len.brown@intel.com>
References: <1260379335-24263-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173015pub.verizon.net ([206.46.173.15]:41613 "EHLO
	vms173015pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754805AbZLIRWi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Dec 2009 12:22:38 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173015.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KUE00C6SAX85YT4@vms173015.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 09 Dec 2009 11:22:33 -0600 (CST)
In-reply-to: <1260379335-24263-1-git-send-email-lenb@kernel.org>
In-reply-to: <2752699392b828edf3123f911f6e8b4dd7daeb56.1260379153.git.len.brown@intel.com>
References: <2752699392b828edf3123f911f6e8b4dd7daeb56.1260379153.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

This message happens when the package element list is longer than
the declared length of the package. Changed to an info message
because this condition is not actually an error. It is caused by
the BIOS attempting to truncate the package on the fly by adjusting
the package element count at the start of the package definition.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/dsobject.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpica/dsobject.c b/drivers/acpi/acpica/dsobject.c
index 507e1f0..9bc1ba0 100644
--- a/drivers/acpi/acpica/dsobject.c
+++ b/drivers/acpi/acpica/dsobject.c
@@ -486,7 +486,7 @@ acpi_ds_build_internal_package_obj(struct acpi_walk_state *walk_state,
 		 *
 		 * Note: technically, this is an error, from ACPI spec: "It is an error
 		 * for NumElements to be less than the number of elements in the
-		 * PackageList". However, we just print an error message and
+		 * PackageList". However, we just print a message and
 		 * no exception is returned. This provides Windows compatibility. Some
 		 * BIOSs will alter the num_elements on the fly, creating this type
 		 * of ill-formed package object.
@@ -510,9 +510,9 @@ acpi_ds_build_internal_package_obj(struct acpi_walk_state *walk_state,
 			arg = arg->common.next;
 		}
 
-		ACPI_WARNING((AE_INFO,
-			    "Package List length (0x%X) larger than NumElements count (0x%X), truncated\n",
-			    i, element_count));
+		ACPI_INFO((AE_INFO,
+			   "Actual Package length (0x%X) is larger than NumElements field (0x%X), truncated\n",
+			   i, element_count));
 	} else if (i < element_count) {
 		/*
 		 * Arg list (elements) was exhausted, but we did not reach num_elements count.
-- 
1.6.0.6

