From: Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 13/23] acpi doc: convert acpi/acpi-lid.txt to rst format
Date: Fri, 29 Mar 2019 00:27:11 +0800
Message-ID: <20190328162721.26138-14-changbin.du@gmail.com>
References: <20190328162721.26138-1-changbin.du@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190328162721.26138-1-changbin.du@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Corbet <corbet@lwn.net>
Cc: rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
List-Id: linux-acpi@vger.kernel.org

This converts the plain text documentation to reStructuredText format and
add it to Sphinx TOC tree. No essential content change.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 .../acpi/{acpi-lid.txt => acpi-lid.rst}       | 47 ++++++++++++-------
 Documentation/acpi/index.rst                  |  1 +
 2 files changed, 32 insertions(+), 16 deletions(-)
 rename Documentation/acpi/{acpi-lid.txt => acpi-lid.rst} (78%)

diff --git a/Documentation/acpi/acpi-lid.txt b/Documentation/acpi/acpi-lid.rst
similarity index 78%
rename from Documentation/acpi/acpi-lid.txt
rename to Documentation/acpi/acpi-lid.rst
index effe7af3a5af..2f597ada7a68 100644
--- a/Documentation/acpi/acpi-lid.txt
+++ b/Documentation/acpi/acpi-lid.rst
@@ -1,25 +1,28 @@
-Special Usage Model of the ACPI Control Method Lid Device
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
-Notify(lid_device, 0x80) to notify the OSPMs whenever the lid state has
-changed. The _LID control method for the lid device must be implemented to
-report the "current" state of the lid as either "opened" or "closed".
+:Abstract: Platforms containing lids convey lid state (open/close) to OSPMs
+  using a control method lid device. To implement this, the AML tables issue
+  Notify(lid_device, 0x80) to notify the OSPMs whenever the lid state has
+  changed. The _LID control method for the lid device must be implemented to
+  report the "current" state of the lid as either "opened" or "closed".
 
-For most platforms, both the _LID method and the lid notifications are
-reliable. However, there are exceptions. In order to work with these
-exceptional buggy platforms, special restrictions and expections should be
-taken into account. This document describes the restrictions and the
-expections of the Linux ACPI lid device driver.
+  For most platforms, both the _LID method and the lid notifications are
+  reliable. However, there are exceptions. In order to work with these
+  exceptional buggy platforms, special restrictions and expections should be
+  taken into account. This document describes the restrictions and the
+  expections of the Linux ACPI lid device driver.
 
 
 1. Restrictions of the returning value of the _LID control method
+=================================================================
 
 The _LID control method is described to return the "current" lid state.
 However the word of "current" has ambiguity, some buggy AML tables return
@@ -31,6 +34,7 @@ with cached value, the initial returning value is likely not reliable.
 There are platforms always retun "closed" as initial lid state.
 
 2. Restrictions of the lid state change notifications
+=====================================================
 
 There are buggy AML tables never notifying when the lid device state is
 changed to "opened". Thus the "opened" notification is not guaranteed. But
@@ -40,17 +44,21 @@ trigger some system power saving operations on Windows. Since it is fully
 tested, it is reliable from all AML tables.
 
 3. Expections for the userspace users of the ACPI lid device driver
+===================================================================
 
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
@@ -59,20 +67,25 @@ button driver uses the following 3 modes in order not to trigger issues.
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
@@ -80,6 +93,7 @@ B. button.lid_init_state=open:
 If the userspace has been prepared to ignore the unreliable "opened" events
 and the unreliable initial state notification, Linux users should always
 use the following kernel parameter:
+
 C. button.lid_init_state=ignore:
    When this option is specified, the ACPI button driver never reports the
    initial lid state and there is a compensation mechanism implemented to
@@ -89,6 +103,7 @@ C. button.lid_init_state=ignore:
    notifications can be delivered to the userspace when the lid is actually
    opens given that some AML tables do not send "opened" notifications
    reliably.
+
    In this mode, if everything is correctly implemented by the platform
    firmware, the old userspace programs should still work. Otherwise, the
    new userspace programs are required to work with the ACPI button driver.
diff --git a/Documentation/acpi/index.rst b/Documentation/acpi/index.rst
index 9bf84570c91b..a5251782e781 100644
--- a/Documentation/acpi/index.rst
+++ b/Documentation/acpi/index.rst
@@ -12,6 +12,7 @@ Linux ACPI (Advanced Configuration and Power Interface)
    DSD-properties-rules
    gpio-properties
    i2c-muxes
+   acpi-lid
    scan_handlers
    method-customizing
    initrd_table_override
-- 
2.20.1
