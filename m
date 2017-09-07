From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] ACPI / PMIC: Add code reviewers to MAINTAINERS
Date: Thu, 07 Sep 2017 13:18:23 +0200
Message-ID: <3133187.xxVeAdigRk@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Lee Jones <lee.jones@linaro.org>
List-Id: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Andy and Mika review code changes under drivers/acpi/pmic/ on
a regular basis and I rely on their help with that, so add them
as code reviwewers for that part of the kernel.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
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
+L:	linux-acpi@vger.kernel.org
+R:	Andy Shevchenko <andy@infradead.org>
+R:	Mika Westerberg <mika.westerberg@linux.intel.com>
+Q:	https://patchwork.kernel.org/project/linux-acpi/list/
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
+B:	https://bugzilla.kernel.org
+S:	Supported
+F:	drivers/acpi/pmic/
+
 ACPI THERMAL DRIVER
 M:	Zhang Rui <rui.zhang@intel.com>
 L:	linux-acpi@vger.kernel.org
