From: Lin Ming <ming.m.lin@intel.com>
Subject: [PATCH] ACPICA: Update version to 20101209
Date: Mon, 27 Dec 2010 09:07:43 +0800
Message-ID: <1293412063.2565.253.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:32176 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753100Ab0L0BEF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 26 Dec 2010 20:04:05 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>

Version 20101209.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---

Len,

The linuxized patches for this version include the Scope() op fix(8df3fc98)
and the GPE divergence fix which are already in your test branch.

This is the last one to tag the version number.

 include/acpi/acpixf.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index e8142d5..241b8a0 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -47,7 +47,7 @@
 
 /* Current ACPICA subsystem version in YYYYMMDD format */
 
-#define ACPI_CA_VERSION                 0x20101013
+#define ACPI_CA_VERSION                 0x20101209
 
 #include "actypes.h"
 #include "actbl.h"


