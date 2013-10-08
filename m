From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] MAINTAINERS / ACPICA: Add ACPICA information to MAINTAINERS
Date: Wed, 09 Oct 2013 01:57:55 +0200
Message-ID: <3304433.p9nzUXSsBt@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:57778 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755710Ab3JHXqP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Oct 2013 19:46:15 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>
Cc: Zhang Rui <rui.zhang@intel.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

ACPICA (ACPI Component Architecture) is an external project that
some ACPI kernel code, including the AML interpreter, is derived
from.  That kernel code is generated automatically out of the
original upstream ACPICA sources and therefore, as a general rule,
all changes to it have to go through the ACPICA upstream.

Add ACPICA information to MAINTAINERS to provide the upstream
ACPICA maintainers contact information and pointers to the original
ACPICA Web site and source code.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Bob, Lv,

Please let me know what you think about the patch below.

Thanks,
Rafael

---
 MAINTAINERS |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

Index: linux-pm/MAINTAINERS
===================================================================
--- linux-pm.orig/MAINTAINERS
+++ linux-pm/MAINTAINERS
@@ -253,6 +253,20 @@ F:	drivers/pci/*acpi*
 F:	drivers/pci/*/*acpi*
 F:	drivers/pci/*/*/*acpi*
 
+ACPI COMPONENT ARCHITECTURE (ACPICA)
+M:	Robert Moore <robert.moore@intel.com>
+M:	Lv Zheng <lv.zheng@intel.com>
+M:	Rafael J. Wysocki <rafael.j.wysocki@intel.com>
+L:	linux-acpi@vger.kernel.org
+L:	devel@acpica.org
+W:	https://acpica.org/
+W:	https://github.com/acpica/acpica/
+Q:	https://patchwork.kernel.org/project/linux-acpi/list/
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
+S:	Supported
+F:	drivers/acpi/acpica/
+F:	include/acpi/
+
 ACPI FAN DRIVER
 M:	Zhang Rui <rui.zhang@intel.com>
 L:	linux-acpi@vger.kernel.org

