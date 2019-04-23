From: Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v4 55/63] Documentation: x86: convert usb-legacy-support.txt to reST
Date: Wed, 24 Apr 2019 00:29:24 +0800
Message-ID: <20190423162932.21428-56-changbin.du@gmail.com>
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
 Documentation/x86/index.rst                               | 1 +
 .../{usb-legacy-support.txt => usb-legacy-support.rst}    | 8 ++++++--
 2 files changed, 7 insertions(+), 2 deletions(-)
 rename Documentation/x86/{usb-legacy-support.txt => usb-legacy-support.rst} (92%)

diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index c41c17906b6d..526f7a008b8e 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -25,3 +25,4 @@ Linux x86 Support
    pti
    microcode
    resctrl_ui
+   usb-legacy-support
diff --git a/Documentation/x86/usb-legacy-support.txt b/Documentation/x86/usb-legacy-support.rst
similarity index 92%
rename from Documentation/x86/usb-legacy-support.txt
rename to Documentation/x86/usb-legacy-support.rst
index 1894cdfc69d9..19abead7f1a8 100644
--- a/Documentation/x86/usb-legacy-support.txt
+++ b/Documentation/x86/usb-legacy-support.rst
@@ -1,7 +1,11 @@
+
+.. SPDX-License-Identifier: GPL-2.0
+
+==================
 USB Legacy support
-~~~~~~~~~~~~~~~~~~
+==================
 
-Vojtech Pavlik <vojtech@suse.cz>, January 2004
+:Author: Vojtech Pavlik <vojtech@suse.cz>, January 2004
 
 
 Also known as "USB Keyboard" or "USB Mouse support" in the BIOS Setup is a
-- 
2.20.1
