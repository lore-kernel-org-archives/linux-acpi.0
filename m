From: Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 19/23] acpi doc: convert acpi/apei/einj.txt to rst format
Date: Fri, 29 Mar 2019 00:27:17 +0800
Message-ID: <20190328162721.26138-20-changbin.du@gmail.com>
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
 .../acpi/apei/{einj.txt => einj.rst}          | 96 ++++++++++---------
 Documentation/acpi/index.rst                  |  1 +
 2 files changed, 51 insertions(+), 46 deletions(-)
 rename Documentation/acpi/apei/{einj.txt => einj.rst} (68%)

diff --git a/Documentation/acpi/apei/einj.txt b/Documentation/acpi/apei/einj.rst
similarity index 68%
rename from Documentation/acpi/apei/einj.txt
rename to Documentation/acpi/apei/einj.rst
index e550c8b98139..541787d81767 100644
--- a/Documentation/acpi/apei/einj.txt
+++ b/Documentation/acpi/apei/einj.rst
@@ -1,13 +1,14 @@
-			APEI Error INJection
-			~~~~~~~~~~~~~~~~~~~~
+====================
+APEI Error INJection
+====================
 
 EINJ provides a hardware error injection mechanism. It is very useful
 for debugging and testing APEI and RAS features in general.
 
 You need to check whether your BIOS supports EINJ first. For that, look
-for early boot messages similar to this one:
+for early boot messages similar to this one::
 
-ACPI: EINJ 0x000000007370A000 000150 (v01 INTEL           00000001 INTL 00000001)
+  ACPI: EINJ 0x000000007370A000 000150 (v01 INTEL           00000001 INTL 00000001)
 
 which shows that the BIOS is exposing an EINJ table - it is the
 mechanism through which the injection is done.
@@ -23,11 +24,11 @@ order to see the APEI,EINJ,... functionality supported and exposed by
 the BIOS menu.
 
 To use EINJ, make sure the following are options enabled in your kernel
-configuration:
+configuration::
 
-CONFIG_DEBUG_FS
-CONFIG_ACPI_APEI
-CONFIG_ACPI_APEI_EINJ
+  CONFIG_DEBUG_FS
+  CONFIG_ACPI_APEI
+  CONFIG_ACPI_APEI_EINJ
 
 The EINJ user interface is in <debugfs mount point>/apei/einj.
 
@@ -35,22 +36,22 @@ The following files belong to it:
 
 - available_error_type
 
-  This file shows which error types are supported:
-
-  Error Type Value	Error Description
-  ================	=================
-  0x00000001		Processor Correctable
-  0x00000002		Processor Uncorrectable non-fatal
-  0x00000004		Processor Uncorrectable fatal
-  0x00000008		Memory Correctable
-  0x00000010		Memory Uncorrectable non-fatal
-  0x00000020		Memory Uncorrectable fatal
-  0x00000040		PCI Express Correctable
-  0x00000080		PCI Express Uncorrectable fatal
-  0x00000100		PCI Express Uncorrectable non-fatal
-  0x00000200		Platform Correctable
-  0x00000400		Platform Uncorrectable non-fatal
-  0x00000800		Platform Uncorrectable fatal
+  This file shows which error types are supported::
+
+    Error Type Value	Error Description
+    ================	=================
+    0x00000001		Processor Correctable
+    0x00000002		Processor Uncorrectable non-fatal
+    0x00000004		Processor Uncorrectable fatal
+    0x00000008		Memory Correctable
+    0x00000010		Memory Uncorrectable non-fatal
+    0x00000020		Memory Uncorrectable fatal
+    0x00000040		PCI Express Correctable
+    0x00000080		PCI Express Uncorrectable fatal
+    0x00000100		PCI Express Uncorrectable non-fatal
+    0x00000200		Platform Correctable
+    0x00000400		Platform Uncorrectable non-fatal
+    0x00000800		Platform Uncorrectable fatal
 
   The format of the file contents are as above, except present are only
   the available error types.
@@ -73,9 +74,12 @@ The following files belong to it:
   injection. Value is a bitmask as specified in ACPI5.0 spec for the
   SET_ERROR_TYPE_WITH_ADDRESS data structure:
 
-	Bit 0 - Processor APIC field valid (see param3 below).
-	Bit 1 - Memory address and mask valid (param1 and param2).
-	Bit 2 - PCIe (seg,bus,dev,fn) valid (see param4 below).
+    Bit 0
+      Processor APIC field valid (see param3 below).
+    Bit 1
+      Memory address and mask valid (param1 and param2).
+    Bit 2
+      PCIe (seg,bus,dev,fn) valid (see param4 below).
 
   If set to zero, legacy behavior is mimicked where the type of
   injection specifies just one bit set, and param1 is multiplexed.
@@ -121,7 +125,7 @@ BIOS versions based on the ACPI 5.0 specification have more control over
 the target of the injection. For processor-related errors (type 0x1, 0x2
 and 0x4), you can set flags to 0x3 (param3 for bit 0, and param1 and
 param2 for bit 1) so that you have more information added to the error
-signature being injected. The actual data passed is this:
+signature being injected. The actual data passed is this::
 
 	memory_address = param1;
 	memory_address_range = param2;
@@ -131,7 +135,7 @@ signature being injected. The actual data passed is this:
 For memory errors (type 0x8, 0x10 and 0x20) the address is set using
 param1 with a mask in param2 (0x0 is equivalent to all ones). For PCI
 express errors (type 0x40, 0x80 and 0x100) the segment, bus, device and
-function are specified using param1:
+function are specified using param1::
 
          31     24 23    16 15    11 10      8  7        0
 	+-------------------------------------------------+
@@ -152,26 +156,26 @@ documentation for details (and expect changes to this API if vendors
 creativity in using this feature expands beyond our expectations).
 
 
-An error injection example:
+An error injection example::
 
-# cd /sys/kernel/debug/apei/einj
-# cat available_error_type		# See which errors can be injected
-0x00000002	Processor Uncorrectable non-fatal
-0x00000008	Memory Correctable
-0x00000010	Memory Uncorrectable non-fatal
-# echo 0x12345000 > param1		# Set memory address for injection
-# echo $((-1 << 12)) > param2		# Mask 0xfffffffffffff000 - anywhere in this page
-# echo 0x8 > error_type			# Choose correctable memory error
-# echo 1 > error_inject			# Inject now
+  # cd /sys/kernel/debug/apei/einj
+  # cat available_error_type		# See which errors can be injected
+  0x00000002	Processor Uncorrectable non-fatal
+  0x00000008	Memory Correctable
+  0x00000010	Memory Uncorrectable non-fatal
+  # echo 0x12345000 > param1		# Set memory address for injection
+  # echo $((-1 << 12)) > param2		# Mask 0xfffffffffffff000 - anywhere in this page
+  # echo 0x8 > error_type			# Choose correctable memory error
+  # echo 1 > error_inject			# Inject now
 
-You should see something like this in dmesg:
+You should see something like this in dmesg::
 
-[22715.830801] EDAC sbridge MC3: HANDLING MCE MEMORY ERROR
-[22715.834759] EDAC sbridge MC3: CPU 0: Machine Check Event: 0 Bank 7: 8c00004000010090
-[22715.834759] EDAC sbridge MC3: TSC 0
-[22715.834759] EDAC sbridge MC3: ADDR 12345000 EDAC sbridge MC3: MISC 144780c86
-[22715.834759] EDAC sbridge MC3: PROCESSOR 0:306e7 TIME 1422553404 SOCKET 0 APIC 0
-[22716.616173] EDAC MC3: 1 CE memory read error on CPU_SrcID#0_Channel#0_DIMM#0 (channel:0 slot:0 page:0x12345 offset:0x0 grain:32 syndrome:0x0 -  area:DRAM err_code:0001:0090 socket:0 channel_mask:1 rank:0)
+  [22715.830801] EDAC sbridge MC3: HANDLING MCE MEMORY ERROR
+  [22715.834759] EDAC sbridge MC3: CPU 0: Machine Check Event: 0 Bank 7: 8c00004000010090
+  [22715.834759] EDAC sbridge MC3: TSC 0
+  [22715.834759] EDAC sbridge MC3: ADDR 12345000 EDAC sbridge MC3: MISC 144780c86
+  [22715.834759] EDAC sbridge MC3: PROCESSOR 0:306e7 TIME 1422553404 SOCKET 0 APIC 0
+  [22716.616173] EDAC MC3: 1 CE memory read error on CPU_SrcID#0_Channel#0_DIMM#0 (channel:0 slot:0 page:0x12345 offset:0x0 grain:32 syndrome:0x0 -  area:DRAM err_code:0001:0090 socket:0 channel_mask:1 rank:0)
 
 For more information about EINJ, please refer to ACPI specification
 version 4.0, section 17.5 and ACPI 5.0, section 18.6.
diff --git a/Documentation/acpi/index.rst b/Documentation/acpi/index.rst
index 6ecd7736449f..431edc664135 100644
--- a/Documentation/acpi/index.rst
+++ b/Documentation/acpi/index.rst
@@ -23,3 +23,4 @@ Linux ACPI (Advanced Configuration and Power Interface)
    method-tracing
    aml-debugger
    apei/output_format
+   apei/einj
-- 
2.20.1
