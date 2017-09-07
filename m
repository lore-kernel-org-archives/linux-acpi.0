From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v2] ACPI / PMIC: Add code reviewers to MAINTAINERS
Date: Fri, 08 Sep 2017 01:20:54 +0200
Message-ID: <1526791.JLKQz4fugV@aspire.rjw.lan>
References: <3133187.xxVeAdigRk@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:42326 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750933AbdIGX3r (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Sep 2017 19:29:47 -0400
In-Reply-To: <3133187.xxVeAdigRk@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Joe Perches <joe@perches.com>

rom: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Andy and Mika review code changes under drivers/acpi/pmic/ on
a regular basis and I rely on their help with that, so add them
as code reviwewers for that part of the kernel.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Lee Jones <lee.jones@linaro.org>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---

-> v2: Reorder fields as per the Joe's comment.
       Add tags from Mika and Lee.

---
 MAINTAINERS |   12 ++++++++++++
 1 file changed, 12 insertions(+)

Index: linux-pm/MAINTAINERS
===================================================================
--- linux-pm.orig/MAINTAINERS
+++ linux-pm/MAINTAINERS
@@ -352,6 +352,18 @@ L:	linux-acpi@vger.kernel.org
 S:	Maintained
 F:	drivers/acpi/arm64
 
+ACPI PMIC DRIVERS
+M:	"Rafael J. Wysocki" <rjw@rjwysocki.net>
+M:	Len Brown <lenb@kernel.org>
+R:	Andy Shevchenko <andy@infradead.org>
+R:	Mika Westerberg <mika.westerberg@linux.intel.com>
+L:	linux-acpi@vger.kernel.org
+Q:	https://patchwork.kernel.org/project/linux-acpi/list/
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
+B:	https://bugzilla.kernel.org
+S:	Supported
+F:	drivers/acpi/pmic/
+
 ACPI THERMAL DRIVER
 M:	Zhang Rui <rui.zhang@intel.com>
 L:	linux-acpi@vger.kernel.org

