From: Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v5 03/23] Documentation: ACPI: move osi.txt to firmware-guide/acpi and convert to reST
Date: Thu, 25 Apr 2019 01:52:46 +0800
Message-ID: <20190424175306.25880-4-changbin.du@gmail.com>
References: <20190424175306.25880-1-changbin.du@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190424175306.25880-1-changbin.du@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, Jonathan Corbet <corbet@lwn.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, fenghua.yu@intel.com, linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org, mchehab+samsung@kernel.org, Changbin Du <changbin.du@gmail.com>
List-Id: linux-acpi@vger.kernel.org

This converts the plain text documentation to reStructuredText format and
add it to Sphinx TOC tree. No essential content change.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/firmware-guide/acpi/index.rst       |  1 +
 .../{acpi/osi.txt => firmware-guide/acpi/osi.rst} | 15 +++++++++------
 2 files changed, 10 insertions(+), 6 deletions(-)
 rename Documentation/{acpi/osi.txt => firmware-guide/acpi/osi.rst} (97%)

diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/firmware-guide/acpi/index.rst
index 99677c73f1fb..868bd25a3398 100644
--- a/Documentation/firmware-guide/acpi/index.rst
+++ b/Documentation/firmware-guide/acpi/index.rst
@@ -9,3 +9,4 @@ ACPI Support
 
    namespace
    enumeration
+   osi
diff --git a/Documentation/acpi/osi.txt b/Documentation/firmware-guide/acpi/osi.rst
similarity index 97%
rename from Documentation/acpi/osi.txt
rename to Documentation/firmware-guide/acpi/osi.rst
index 50cde0ceb9b0..29e9ef79ebc0 100644
--- a/Documentation/acpi/osi.txt
+++ b/Documentation/firmware-guide/acpi/osi.rst
@@ -1,5 +1,8 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==========================
 ACPI _OSI and _REV methods
---------------------------
+==========================
 
 An ACPI BIOS can use the "Operating System Interfaces" method (_OSI)
 to find out what the operating system supports. Eg. If BIOS
@@ -14,7 +17,7 @@ This document explains how and why the BIOS and Linux should use these methods.
 It also explains how and why they are widely misused.
 
 How to use _OSI
----------------
+===============
 
 Linux runs on two groups of machines -- those that are tested by the OEM
 to be compatible with Linux, and those that were never tested with Linux,
@@ -62,7 +65,7 @@ the string when that support is added to the kernel.
 That was easy.  Read on, to find out how to do it wrong.
 
 Before _OSI, there was _OS
---------------------------
+==========================
 
 ACPI 1.0 specified "_OS" as an
 "object that evaluates to a string that identifies the operating system."
@@ -96,7 +99,7 @@ That is the *only* viable strategy, as that is what modern Windows does,
 and so doing otherwise could steer the BIOS down an untested path.
 
 _OSI is born, and immediately misused
---------------------------------------
+=====================================
 
 With _OSI, the *BIOS* provides the string describing an interface,
 and asks the OS: "YES/NO, are you compatible with this interface?"
@@ -144,7 +147,7 @@ catastrophic failure resulting from the BIOS taking paths that
 were never validated under *any* OS.
 
 Do not use _REV
----------------
+===============
 
 Since _OSI("Linux") went away, some BIOS writers used _REV
 to support Linux and Windows differences in the same BIOS.
@@ -164,7 +167,7 @@ from mid-2015 onward.  The ACPI specification will also be updated
 to reflect that _REV is deprecated, and always returns 2.
 
 Apple Mac and _OSI("Darwin")
-----------------------------
+============================
 
 On Apple's Mac platforms, the ACPI BIOS invokes _OSI("Darwin")
 to determine if the machine is running Apple OSX.
-- 
2.20.1
