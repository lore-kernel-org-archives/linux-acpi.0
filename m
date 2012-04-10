From: Ang Way Chuang <wcang79@gmail.com>
Subject: [PATCH]: Trivial modification to ACPI custom method doc
Date: Tue, 10 Apr 2012 13:14:16 +0800
Message-ID: <4F83C1A8.2010809@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pz0-f52.google.com ([209.85.210.52]:55935 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321Ab2DJFOU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Apr 2012 01:14:20 -0400
Received: by dake40 with SMTP id e40so6121251dak.11
        for <linux-acpi@vger.kernel.org>; Mon, 09 Apr 2012 22:14:19 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Trivial modification to ACPI custom method doc.

Note: Yours truly is not a native speaker.

Sign-off-by: Ang Way Chuang <wcang79@gmail.com>
---
diff --git a/Documentation/acpi/method-customizing.txt b/Documentation/acpi/method-customizing.txt
index 5f55373..9541709 100644
--- a/Documentation/acpi/method-customizing.txt
+++ b/Documentation/acpi/method-customizing.txt
@@ -13,12 +13,12 @@ Users can use this to
    method such as _OFF, _ON, _STA, _INI, etc.
 For these cases, it is far simpler to dynamically install a single
 control method rather than override the entire DSDT, because kernel
-rebuild/reboot is not needed and test result can be got in minutes.
+rebuild/reboot is not needed and test result can be obtained in minutes.
 
 Note: Only ACPI METHOD can be overridden, any other object types like
       "Device", "OperationRegion", are not recognized.
-Note: The same ACPI control method can be overridden for many times,
-      and it's always the latest one that used by Linux/kernel.
+Note: The same ACPI control method can be overridden many times, Linux
+      always uses the latest ACPI control method.
 Note: To get the ACPI debug object output (Store (AAAA, Debug)),
       please run "echo 1 > /sys/module/acpi/parameters/aml_debug_output".
 
@@ -47,7 +47,9 @@ Note: To get the ACPI debug object output (Store (AAAA, Debug)),
       e.g. "iasl psr.asl" (psr.aml is generated as a result)
    f) mount debugfs by "mount -t debugfs none /sys/kernel/debug"
    g) override the old method via the debugfs by running
-      "cat /tmp/psr.aml > /sys/kernel/debug/acpi/custom_method"
+      "cat /tmp/psr.aml > /sys/kernel/debug/acpi/custom_method".
+      If ACPI_CUSTOM_METHOD is compiled as a module. Please load
+      the "custom_method" module first.
 
 2. insert a new method
    This is easier than overriding an existing method.
@@ -57,9 +59,9 @@ Note: To get the ACPI debug object output (Store (AAAA, Debug)),
 3. undo your changes
    The "undo" operation is not supported for a new inserted method
    right now, i.e. we can not remove a method currently.
-   For an overrided method, in order to undo your changes, please
-   save a copy of the method original ASL code in step c) section 1,
-   and redo step c) ~ g) to override the method with the original one.
+   To restore an overriden method to its original form, please
+   save a copy of the method in the original ASL code in step c) section 1,
+   and redo step c) ~ g) to restore the original method.
 
 
 Note: We can use a kernel with multiple custom ACPI method running,
