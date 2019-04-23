From: Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v4 63/63] Documentation: x86: convert x86_64/machinecheck to reST
Date: Wed, 24 Apr 2019 00:29:32 +0800
Message-ID: <20190423162932.21428-64-changbin.du@gmail.com>
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
 Documentation/x86/x86_64/index.rst                    |  1 +
 .../x86/x86_64/{machinecheck => machinecheck.rst}     | 11 ++++++-----
 2 files changed, 7 insertions(+), 5 deletions(-)
 rename Documentation/x86/x86_64/{machinecheck => machinecheck.rst} (92%)

diff --git a/Documentation/x86/x86_64/index.rst b/Documentation/x86/x86_64/index.rst
index c04b6eab3c76..d6eaaa5a35fc 100644
--- a/Documentation/x86/x86_64/index.rst
+++ b/Documentation/x86/x86_64/index.rst
@@ -13,3 +13,4 @@ x86_64 Support
    5level-paging
    fake-numa-for-cpusets
    cpu-hotplug-spec
+   machinecheck
diff --git a/Documentation/x86/x86_64/machinecheck b/Documentation/x86/x86_64/machinecheck.rst
similarity index 92%
rename from Documentation/x86/x86_64/machinecheck
rename to Documentation/x86/x86_64/machinecheck.rst
index d0648a74fceb..8e9d2d529a8d 100644
--- a/Documentation/x86/x86_64/machinecheck
+++ b/Documentation/x86/x86_64/machinecheck.rst
@@ -1,5 +1,8 @@
+.. SPDX-License-Identifier: GPL-2.0
 
-Configurable sysfs parameters for the x86-64 machine check code.
+===============================================================
+Configurable sysfs parameters for the x86-64 machine check code
+===============================================================
 
 Machine checks report internal hardware error conditions detected
 by the CPU. Uncorrected errors typically cause a machine check
@@ -16,14 +19,12 @@ log then mcelog should run to collect and decode machine check entries
 from /dev/mcelog. Normally mcelog should be run regularly from a cronjob.
 
 Each CPU has a directory in /sys/devices/system/machinecheck/machinecheckN
-(N = CPU number)
+(N = CPU number).
 
 The directory contains some configurable entries:
 
-Entries:
-
 bankNctl
-(N bank number)
+	(N bank number)
 	64bit Hex bitmask enabling/disabling specific subevents for bank N
 	When a bit in the bitmask is zero then the respective
 	subevent will not be reported.
-- 
2.20.1
