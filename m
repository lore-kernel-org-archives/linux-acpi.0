From: Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v4 60/63] Documentation: x86: convert x86_64/5level-paging.txt to reST
Date: Wed, 24 Apr 2019 00:29:29 +0800
Message-ID: <20190423162932.21428-61-changbin.du@gmail.com>
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
 .../{5level-paging.txt => 5level-paging.rst}     | 16 +++++++++++-----
 Documentation/x86/x86_64/index.rst               |  1 +
 2 files changed, 12 insertions(+), 5 deletions(-)
 rename Documentation/x86/x86_64/{5level-paging.txt => 5level-paging.rst} (91%)

diff --git a/Documentation/x86/x86_64/5level-paging.txt b/Documentation/x86/x86_64/5level-paging.rst
similarity index 91%
rename from Documentation/x86/x86_64/5level-paging.txt
rename to Documentation/x86/x86_64/5level-paging.rst
index 2432a5ef86d9..ab88a4514163 100644
--- a/Documentation/x86/x86_64/5level-paging.txt
+++ b/Documentation/x86/x86_64/5level-paging.rst
@@ -1,5 +1,11 @@
-== Overview ==
+.. SPDX-License-Identifier: GPL-2.0
 
+==============
+5-level paging
+==============
+
+Overview
+========
 Original x86-64 was limited by 4-level paing to 256 TiB of virtual address
 space and 64 TiB of physical address space. We are already bumping into
 this limit: some vendors offers servers with 64 TiB of memory today.
@@ -16,16 +22,17 @@ QEMU 2.9 and later support 5-level paging.
 Virtual memory layout for 5-level paging is described in
 Documentation/x86/x86_64/mm.txt
 
-== Enabling 5-level paging ==
 
+Enabling 5-level paging
+=======================
 CONFIG_X86_5LEVEL=y enables the feature.
 
 Kernel with CONFIG_X86_5LEVEL=y still able to boot on 4-level hardware.
 In this case additional page table level -- p4d -- will be folded at
 runtime.
 
-== User-space and large virtual address space ==
-
+User-space and large virtual address space
+==========================================
 On x86, 5-level paging enables 56-bit userspace virtual address space.
 Not all user space is ready to handle wide addresses. It's known that
 at least some JIT compilers use higher bits in pointers to encode their
@@ -58,4 +65,3 @@ One important case we need to handle here is interaction with MPX.
 MPX (without MAWA extension) cannot handle addresses above 47-bit, so we
 need to make sure that MPX cannot be enabled we already have VMA above
 the boundary and forbid creating such VMAs once MPX is enabled.
-
diff --git a/Documentation/x86/x86_64/index.rst b/Documentation/x86/x86_64/index.rst
index 4b65d29ef459..7b8c82151358 100644
--- a/Documentation/x86/x86_64/index.rst
+++ b/Documentation/x86/x86_64/index.rst
@@ -10,3 +10,4 @@ x86_64 Support
    boot-options
    uefi
    mm
+   5level-paging
-- 
2.20.1
