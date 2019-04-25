From: Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v6 13/24] Documentation: ACPI: move acpi-lid.txt to firmware-guide/acpi and convert to reST
Date: Thu, 25 Apr 2019 23:31:06 +0800
Message-ID: <20190425153117.16057-14-changbin.du@gmail.com>
References: <20190425153117.16057-1-changbin.du@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190425153117.16057-1-changbin.du@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, Jonathan Corbet <corbet@lwn.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, fenghua.yu@intel.com, linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org, mchehab+samsung@kernel.org, Changbin Du <changbin.du@gmail.com>
List-Id: linux-acpi@vger.kernel.org

This converts the plain text documentation to reStructuredText format and
add it to Sphinx TOC tree. No essential content change.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 .../acpi/acpi-lid.rst}                        | 40 ++++++++++++++-----
 Documentation/firmware-guide/acpi/index.rst   |  1 +
 2 files changed, 30 insertions(+), 11 deletions(-)
 rename Documentation/{acpi/acpi-lid.txt => firmware-guide/acpi/acpi-lid.rst} (86%)

diff --git a/Documentation/acpi/acpi-lid.txt b/Documentation/firmware-guide/acpi/acpi-lid.rst
similarity index 86%
rename from Documentation/acpi/acpi-lid.txt
rename to Documentation/firmware-guide/acpi/acpi-lid.rst
index effe7af3a5af..874ce0ed340d 100644
--- a/Documentation/acpi/acpi-lid.txt
+++ b/Documentation/firmware-guide/acpi/acpi-lid.rst
@@ -1,13 +1,18 @@
-Special Usage Model of the ACPI Control Method Lid Device
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: <isonum.txt>
 
-Copyright (C) 2016, Intel Corporation
-Author: Lv Zheng <lv.zheng@intel.com>
+=========================================================
+Special Usage Model of the ACPI Control Method Lid Device
+=========================================================
 
+:Copyright: |copy| 2016, Intel Corporation
 
-Abstract:
+:Author: Lv Zheng <lv.zheng@intel.com>
 
-Platforms containing lids convey lid state (open/close) to OSPMs using a
-control method lid device. To implement this, the AML tables issue
+Abstract
+========
+Platforms containing lids convey lid state (open/close) to OSPMs
+using a control method lid device. To implement this, the AML tables issue
 Notify(lid_device, 0x80) to notify the OSPMs whenever the lid state has
 changed. The _LID control method for the lid device must be implemented to
 report the "current" state of the lid as either "opened" or "closed".
@@ -19,7 +24,8 @@ taken into account. This document describes the restrictions and the
 expections of the Linux ACPI lid device driver.
 
 
-1. Restrictions of the returning value of the _LID control method
+Restrictions of the returning value of the _LID control method
+==============================================================
 
 The _LID control method is described to return the "current" lid state.
 However the word of "current" has ambiguity, some buggy AML tables return
@@ -30,7 +36,8 @@ initial returning value. When the AML tables implement this control method
 with cached value, the initial returning value is likely not reliable.
 There are platforms always retun "closed" as initial lid state.
 
-2. Restrictions of the lid state change notifications
+Restrictions of the lid state change notifications
+==================================================
 
 There are buggy AML tables never notifying when the lid device state is
 changed to "opened". Thus the "opened" notification is not guaranteed. But
@@ -39,18 +46,22 @@ state is changed to "closed". The "closed" notification is normally used to
 trigger some system power saving operations on Windows. Since it is fully
 tested, it is reliable from all AML tables.
 
-3. Expections for the userspace users of the ACPI lid device driver
+Expections for the userspace users of the ACPI lid device driver
+================================================================
 
 The ACPI button driver exports the lid state to the userspace via the
-following file:
+following file::
+
   /proc/acpi/button/lid/LID0/state
+
 This file actually calls the _LID control method described above. And given
 the previous explanation, it is not reliable enough on some platforms. So
 it is advised for the userspace program to not to solely rely on this file
 to determine the actual lid state.
 
 The ACPI button driver emits the following input event to the userspace:
-  SW_LID
+  * SW_LID
+
 The ACPI lid device driver is implemented to try to deliver the platform
 triggered events to the userspace. However, given the fact that the buggy
 firmware cannot make sure "opened"/"closed" events are paired, the ACPI
@@ -59,20 +70,25 @@ button driver uses the following 3 modes in order not to trigger issues.
 If the userspace hasn't been prepared to ignore the unreliable "opened"
 events and the unreliable initial state notification, Linux users can use
 the following kernel parameters to handle the possible issues:
+
 A. button.lid_init_state=method:
    When this option is specified, the ACPI button driver reports the
    initial lid state using the returning value of the _LID control method
    and whether the "opened"/"closed" events are paired fully relies on the
    firmware implementation.
+
    This option can be used to fix some platforms where the returning value
    of the _LID control method is reliable but the initial lid state
    notification is missing.
+
    This option is the default behavior during the period the userspace
    isn't ready to handle the buggy AML tables.
+
 B. button.lid_init_state=open:
    When this option is specified, the ACPI button driver always reports the
    initial lid state as "opened" and whether the "opened"/"closed" events
    are paired fully relies on the firmware implementation.
+
    This may fix some platforms where the returning value of the _LID
    control method is not reliable and the initial lid state notification is
    missing.
@@ -80,6 +96,7 @@ B. button.lid_init_state=open:
 If the userspace has been prepared to ignore the unreliable "opened" events
 and the unreliable initial state notification, Linux users should always
 use the following kernel parameter:
+
 C. button.lid_init_state=ignore:
    When this option is specified, the ACPI button driver never reports the
    initial lid state and there is a compensation mechanism implemented to
@@ -89,6 +106,7 @@ C. button.lid_init_state=ignore:
    notifications can be delivered to the userspace when the lid is actually
    opens given that some AML tables do not send "opened" notifications
    reliably.
+
    In this mode, if everything is correctly implemented by the platform
    firmware, the old userspace programs should still work. Otherwise, the
    new userspace programs are required to work with the ACPI button driver.
diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/firmware-guide/acpi/index.rst
index 1c89888f6ee8..bedcb0b242a2 100644
--- a/Documentation/firmware-guide/acpi/index.rst
+++ b/Documentation/firmware-guide/acpi/index.rst
@@ -14,3 +14,4 @@ ACPI Support
    DSD-properties-rules
    gpio-properties
    i2c-muxes
+   acpi-lid
\ No newline at end of file
-- 
2.20.1
