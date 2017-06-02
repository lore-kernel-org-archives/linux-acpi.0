From: Ross Zwisler <ross.zwisler@linux.intel.com>
Subject: [RFC 2/6] acpi: add missing include in acpi_numa.h
Date: Fri,  2 Jun 2017 14:59:52 -0600
Message-ID: <20170602205956.28351-3-ross.zwisler@linux.intel.com>
References: <20170602205956.28351-1-ross.zwisler@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:55914 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750966AbdFBVAD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 2 Jun 2017 17:00:03 -0400
In-Reply-To: <20170602205956.28351-1-ross.zwisler@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>, "Anaczkowski, Lukasz" <lukasz.anaczkowski@intel.com>, "Box, David E" <david.e.box@intel.com>, "Kogut, Jaroslaw" <Jaroslaw.Kogut@intel.com>, "Lahtinen, Joonas" <joonas.lahtinen@intel.com>, "Moore, Robert" <robert.moore@intel.com>, "Nachimuthu, Murugasamy" <murugasamy.nachimuthu@intel.com>, "Odzioba, Lukasz" <lukasz.odzioba@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Schmauss, Erik" <erik.schmauss@intel.com>, "Verma, Vishal L" <vishal.l.verma@intel.com>, "Zheng, Lv" <lv.zheng@intel.com>, Dan Williams <dan.j.williams@intel.com>, Dave Hansen <dave.hansen@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Right now if a file includes acpi_numa.h and they don't happen to include
linux/numa.h before it, they get the following warning:

./include/acpi/acpi_numa.h:9:5: warning: "MAX_NUMNODES" is not defined [-Wundef]
 #if MAX_NUMNODES > 256
     ^~~~~~~~~~~~

Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
---
 include/acpi/acpi_numa.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/acpi/acpi_numa.h b/include/acpi/acpi_numa.h
index d4b7294..1e3a74f 100644
--- a/include/acpi/acpi_numa.h
+++ b/include/acpi/acpi_numa.h
@@ -3,6 +3,7 @@
 
 #ifdef CONFIG_ACPI_NUMA
 #include <linux/kernel.h>
+#include <linux/numa.h>
 
 /* Proximity bitmap length */
 #if MAX_NUMNODES > 256
-- 
2.9.4

