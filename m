From: Taku Izumi <izumi.taku@jp.fujitsu.com>
Subject: [PATCH 1/2] ACPI: add acpi_osi_dmi_table evaluation procedure for
 ia64 machines
Date: Fri, 23 May 2008 15:39:54 +0900
Message-ID: <483666BA.1060106@jp.fujitsu.com>
References: <4816F9B9.3090609@jp.fujitsu.com> <4836660B.3080406@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:35847 "EHLO
	fgwmail7.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753772AbYEWGi7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 23 May 2008 02:38:59 -0400
In-Reply-To: <4836660B.3080406@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Currently, acpi_osi_dmi_table is valid only for x86 machines.
This patch makes its table valid for ia64 machines too and adds
evaluation procedure for the purpose of checking if OSI(Linux)
should be enabled or not.

Signed-off-by: Taku Izumi <izumi.taku@jp.fujitsu.com>

---
  arch/ia64/kernel/setup.c |    7 +++++++
  drivers/acpi/Makefile    |    1 +
  2 files changed, 8 insertions(+)

Index: linux-2.6.25.4/arch/ia64/kernel/setup.c
===================================================================
--- linux-2.6.25.4.orig/arch/ia64/kernel/setup.c
+++ linux-2.6.25.4/arch/ia64/kernel/setup.c
@@ -985,3 +985,10 @@ static int __init run_dmi_scan(void)
  	return 0;
  }
  core_initcall(run_dmi_scan);
+
+static int __init invoke_acpi_blacklisted(void)
+{
+	acpi_blacklisted();
+	return 0;
+}
+postcore_initcall(invoke_acpi_blacklisted);
Index: linux-2.6.25.4/drivers/acpi/Makefile
===================================================================
--- linux-2.6.25.4.orig/drivers/acpi/Makefile
+++ linux-2.6.25.4/drivers/acpi/Makefile
@@ -17,6 +17,7 @@ EXTRA_CFLAGS	+= $(ACPI_CFLAGS)
  #
  obj-y				+= tables.o
  obj-$(CONFIG_X86)		+= blacklist.o
+obj-$(CONFIG_IA64)		+= blacklist.o

  #
  # ACPI Core Subsystem (Interpreter)



