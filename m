From: Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v4 52/63] Documentation: x86: convert microcode.txt to reST
Date: Wed, 24 Apr 2019 00:29:21 +0800
Message-ID: <20190423162932.21428-53-changbin.du@gmail.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190423162932.21428-1-changbin.du@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Corbet <corbet@lwn.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, x86@kernel.org, fenghua.yu@intel.com, linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org, mchehab+samsung@kernel.org, Changbin Du <changbin.du@gmail.com>
List-Id: linux-acpi@vger.kernel.org

This converts the plain text documentation to reStructuredText format and
add it to Sphinx TOC tree. No essential content change.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 Documentation/x86/index.rst                   |  1 +
 .../x86/{microcode.txt => microcode.rst}      | 62 ++++++++++---------
 2 files changed, 35 insertions(+), 28 deletions(-)
 rename Documentation/x86/{microcode.txt => microcode.rst} (81%)

diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index 1c675cef14d7..2fcd10f29b87 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -22,3 +22,4 @@ Linux x86 Support
    intel_mpx
    amd-memory-encryption
    pti
+   microcode
diff --git a/Documentation/x86/microcode.txt b/Documentation/x86/microcode.rst
similarity index 81%
rename from Documentation/x86/microcode.txt
rename to Documentation/x86/microcode.rst
index 79fdb4a8148a..a320d37982ed 100644
--- a/Documentation/x86/microcode.txt
+++ b/Documentation/x86/microcode.rst
@@ -1,7 +1,11 @@
-	The Linux Microcode Loader
+.. SPDX-License-Identifier: GPL-2.0
 
-Authors: Fenghua Yu <fenghua.yu@intel.com>
-	 Borislav Petkov <bp@suse.de>
+==========================
+The Linux Microcode Loader
+==========================
+
+:Authors: - Fenghua Yu <fenghua.yu@intel.com>
+          - Borislav Petkov <bp@suse.de>
 
 The kernel has a x86 microcode loading facility which is supposed to
 provide microcode loading methods in the OS. Potential use cases are
@@ -10,8 +14,8 @@ and updating the microcode on long-running systems without rebooting.
 
 The loader supports three loading methods:
 
-1. Early load microcode
-=======================
+Early load microcode
+====================
 
 The kernel can update microcode very early during boot. Loading
 microcode early can fix CPU issues before they are observed during
@@ -26,8 +30,10 @@ loader parses the combined initrd image during boot.
 
 The microcode files in cpio name space are:
 
-on Intel: kernel/x86/microcode/GenuineIntel.bin
-on AMD  : kernel/x86/microcode/AuthenticAMD.bin
+on Intel:
+  kernel/x86/microcode/GenuineIntel.bin
+on AMD  :
+  kernel/x86/microcode/AuthenticAMD.bin
 
 During BSP (BootStrapping Processor) boot (pre-SMP), the kernel
 scans the microcode file in the initrd. If microcode matching the
@@ -42,8 +48,8 @@ Here's a crude example how to prepare an initrd with microcode (this is
 normally done automatically by the distribution, when recreating the
 initrd, so you don't really have to do it yourself. It is documented
 here for future reference only).
+::
 
----
   #!/bin/bash
 
   if [ -z "$1" ]; then
@@ -76,15 +82,15 @@ here for future reference only).
   cat ucode.cpio $INITRD.orig > $INITRD
 
   rm -rf $TMPDIR
----
+
 
 The system needs to have the microcode packages installed into
 /lib/firmware or you need to fixup the paths above if yours are
 somewhere else and/or you've downloaded them directly from the processor
 vendor's site.
 
-2. Late loading
-===============
+Late loading
+============
 
 There are two legacy user space interfaces to load microcode, either through
 /dev/cpu/microcode or through /sys/devices/system/cpu/microcode/reload file
@@ -94,9 +100,9 @@ The /dev/cpu/microcode method is deprecated because it needs a special
 userspace tool for that.
 
 The easier method is simply installing the microcode packages your distro
-supplies and running:
+supplies and running::
 
-# echo 1 > /sys/devices/system/cpu/microcode/reload
+  # echo 1 > /sys/devices/system/cpu/microcode/reload
 
 as root.
 
@@ -104,29 +110,29 @@ The loading mechanism looks for microcode blobs in
 /lib/firmware/{intel-ucode,amd-ucode}. The default distro installation
 packages already put them there.
 
-3. Builtin microcode
-====================
+Builtin microcode
+=================
 
 The loader supports also loading of a builtin microcode supplied through
 the regular builtin firmware method CONFIG_EXTRA_FIRMWARE. Only 64-bit is
 currently supported.
 
-Here's an example:
+Here's an example::
 
-CONFIG_EXTRA_FIRMWARE="intel-ucode/06-3a-09 amd-ucode/microcode_amd_fam15h.bin"
-CONFIG_EXTRA_FIRMWARE_DIR="/lib/firmware"
+  CONFIG_EXTRA_FIRMWARE="intel-ucode/06-3a-09 amd-ucode/microcode_amd_fam15h.bin"
+  CONFIG_EXTRA_FIRMWARE_DIR="/lib/firmware"
 
-This basically means, you have the following tree structure locally:
+This basically means, you have the following tree structure locally::
 
-/lib/firmware/
-|-- amd-ucode
-...
-|   |-- microcode_amd_fam15h.bin
-...
-|-- intel-ucode
-...
-|   |-- 06-3a-09
-...
+  /lib/firmware/
+  |-- amd-ucode
+  ...
+  |   |-- microcode_amd_fam15h.bin
+  ...
+  |-- intel-ucode
+  ...
+  |   |-- 06-3a-09
+  ...
 
 so that the build system can find those files and integrate them into
 the final kernel image. The early loader finds them and applies them.
-- 
2.20.1
