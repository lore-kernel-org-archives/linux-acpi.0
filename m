From: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>
Subject: [PATCH] make ibm_acpi work right with notify handlers.
Date: Wed, 25 Oct 2006 18:29:04 +0400
Message-ID: <453F74B0.8080105@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000708010703090001070704"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:8553 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751706AbWJYO3Q (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Oct 2006 10:29:16 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux ACPI <linux-acpi@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, Borislav Deianov <borislav@users.sf.net>

This is a multi-part message in MIME format.
--------------000708010703090001070704
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

There is a bug in ibm_acpi module, which prevents its clean removal.
This patch fixes the problem by moving setting notify_installed to the right place.

Thanks,
Alex.

--------------000708010703090001070704
Content-Type: text/x-patch;
 name="ibm_acpi-do_notify_remove.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ibm_acpi-do_notify_remove.patch"

make unload of ibm_acpi right.

From:  Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>


---

 drivers/acpi/ibm_acpi.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/ibm_acpi.c b/drivers/acpi/ibm_acpi.c
index 003a987..719a320 100644
--- a/drivers/acpi/ibm_acpi.c
+++ b/drivers/acpi/ibm_acpi.c
@@ -1805,7 +1805,7 @@ static int __init setup_notify(struct ib
 		       ibm->name, status);
 		return -ENODEV;
 	}
-
+	ibm->notify_installed = 1;
 	return 0;
 }
 
@@ -1882,7 +1882,6 @@ static int __init ibm_init(struct ibm_st
 		ret = setup_notify(ibm);
 		if (ret < 0)
 			return ret;
-		ibm->notify_installed = 1;
 	}
 
 	return 0;

--------------000708010703090001070704--
