From: Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v4 42/63] Documentation: x86: convert entry_64.txt to reST
Date: Wed, 24 Apr 2019 00:29:11 +0800
Message-ID: <20190423162932.21428-43-changbin.du@gmail.com>
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
 Documentation/x86/{entry_64.txt => entry_64.rst} | 12 +++++++++---
 Documentation/x86/index.rst                      |  1 +
 2 files changed, 10 insertions(+), 3 deletions(-)
 rename Documentation/x86/{entry_64.txt => entry_64.rst} (95%)

diff --git a/Documentation/x86/entry_64.txt b/Documentation/x86/entry_64.rst
similarity index 95%
rename from Documentation/x86/entry_64.txt
rename to Documentation/x86/entry_64.rst
index c1df8eba9dfd..a48b3f6ebbe8 100644
--- a/Documentation/x86/entry_64.txt
+++ b/Documentation/x86/entry_64.rst
@@ -1,3 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==============
+Kernel Entries
+==============
+
 This file documents some of the kernel entries in
 arch/x86/entry/entry_64.S.  A lot of this explanation is adapted from
 an email from Ingo Molnar:
@@ -59,7 +65,7 @@ Now, there's a secondary complication: there's a cheap way to test
 which mode the CPU is in and an expensive way.
 
 The cheap way is to pick this info off the entry frame on the kernel
-stack, from the CS of the ptregs area of the kernel stack:
+stack, from the CS of the ptregs area of the kernel stack::
 
 	xorl %ebx,%ebx
 	testl $3,CS+8(%rsp)
@@ -67,7 +73,7 @@ stack, from the CS of the ptregs area of the kernel stack:
 	SWAPGS
 
 The expensive (paranoid) way is to read back the MSR_GS_BASE value
-(which is what SWAPGS modifies):
+(which is what SWAPGS modifies)::
 
 	movl $1,%ebx
 	movl $MSR_GS_BASE,%ecx
@@ -76,7 +82,7 @@ The expensive (paranoid) way is to read back the MSR_GS_BASE value
 	js 1f   /* negative -> in kernel */
 	SWAPGS
 	xorl %ebx,%ebx
-1:	ret
+  1:	ret
 
 If we are at an interrupt or user-trap/gate-alike boundary then we can
 use the faster check: the stack will be a reliable indicator of
diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index 489f4f4179c4..8a666c5abc85 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -12,3 +12,4 @@ Linux x86 Support
    topology
    exception-tables
    kernel-stacks
+   entry_64
-- 
2.20.1
