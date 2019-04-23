From: Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v4 49/63] Documentation: x86: convert intel_mpx.txt to reST
Date: Wed, 24 Apr 2019 00:29:18 +0800
Message-ID: <20190423162932.21428-50-changbin.du@gmail.com>
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
 Documentation/x86/index.rst                   |   1 +
 .../x86/{intel_mpx.txt => intel_mpx.rst}      | 120 ++++++++++--------
 2 files changed, 65 insertions(+), 56 deletions(-)
 rename Documentation/x86/{intel_mpx.txt => intel_mpx.rst} (75%)

diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index 576628b121cc..20091d3e5d97 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -19,3 +19,4 @@ Linux x86 Support
    mtrr
    pat
    protection-keys
+   intel_mpx
diff --git a/Documentation/x86/intel_mpx.txt b/Documentation/x86/intel_mpx.rst
similarity index 75%
rename from Documentation/x86/intel_mpx.txt
rename to Documentation/x86/intel_mpx.rst
index 85d0549ad846..387a640941a6 100644
--- a/Documentation/x86/intel_mpx.txt
+++ b/Documentation/x86/intel_mpx.rst
@@ -1,5 +1,11 @@
-1. Intel(R) MPX Overview
-========================
+.. SPDX-License-Identifier: GPL-2.0
+
+===========================================
+Intel(R) Memory Protection Extensions (MPX)
+===========================================
+
+Intel(R) MPX Overview
+=====================
 
 Intel(R) Memory Protection Extensions (Intel(R) MPX) is a new capability
 introduced into Intel Architecture. Intel MPX provides hardware features
@@ -7,7 +13,7 @@ that can be used in conjunction with compiler changes to check memory
 references, for those references whose compile-time normal intentions are
 usurped at runtime due to buffer overflow or underflow.
 
-You can tell if your CPU supports MPX by looking in /proc/cpuinfo:
+You can tell if your CPU supports MPX by looking in /proc/cpuinfo::
 
 	cat /proc/cpuinfo  | grep ' mpx '
 
@@ -21,8 +27,8 @@ can be downloaded from
 http://software.intel.com/en-us/articles/intel-software-development-emulator
 
 
-2. How to get the advantage of MPX
-==================================
+How to get the advantage of MPX
+===============================
 
 For MPX to work, changes are required in the kernel, binutils and compiler.
 No source changes are required for applications, just a recompile.
@@ -84,14 +90,15 @@ Kernel MPX Code:
    is unmapped.
 
 
-3. How does MPX kernel code work
-================================
+How does MPX kernel code work
+=============================
 
 Handling #BR faults caused by MPX
 ---------------------------------
 
 When MPX is enabled, there are 2 new situations that can generate
 #BR faults.
+
   * new bounds tables (BT) need to be allocated to save bounds.
   * bounds violation caused by MPX instructions.
 
@@ -124,37 +131,37 @@ the kernel. It can theoretically be done completely from userspace. Here
 are a few ways this could be done. We don't think any of them are practical
 in the real-world, but here they are.
 
-Q: Can virtual space simply be reserved for the bounds tables so that we
-   never have to allocate them?
-A: MPX-enabled application will possibly create a lot of bounds tables in
-   process address space to save bounds information. These tables can take
-   up huge swaths of memory (as much as 80% of the memory on the system)
-   even if we clean them up aggressively. In the worst-case scenario, the
-   tables can be 4x the size of the data structure being tracked. IOW, a
-   1-page structure can require 4 bounds-table pages. An X-GB virtual
-   area needs 4*X GB of virtual space, plus 2GB for the bounds directory.
-   If we were to preallocate them for the 128TB of user virtual address
-   space, we would need to reserve 512TB+2GB, which is larger than the
-   entire virtual address space today. This means they can not be reserved
-   ahead of time. Also, a single process's pre-populated bounds directory
-   consumes 2GB of virtual *AND* physical memory. IOW, it's completely
-   infeasible to prepopulate bounds directories.
-
-Q: Can we preallocate bounds table space at the same time memory is
-   allocated which might contain pointers that might eventually need
-   bounds tables?
-A: This would work if we could hook the site of each and every memory
-   allocation syscall. This can be done for small, constrained applications.
-   But, it isn't practical at a larger scale since a given app has no
-   way of controlling how all the parts of the app might allocate memory
-   (think libraries). The kernel is really the only place to intercept
-   these calls.
-
-Q: Could a bounds fault be handed to userspace and the tables allocated
-   there in a signal handler instead of in the kernel?
-A: mmap() is not on the list of safe async handler functions and even
-   if mmap() would work it still requires locking or nasty tricks to
-   keep track of the allocation state there.
+:Q: Can virtual space simply be reserved for the bounds tables so that we
+    never have to allocate them?
+:A: MPX-enabled application will possibly create a lot of bounds tables in
+    process address space to save bounds information. These tables can take
+    up huge swaths of memory (as much as 80% of the memory on the system)
+    even if we clean them up aggressively. In the worst-case scenario, the
+    tables can be 4x the size of the data structure being tracked. IOW, a
+    1-page structure can require 4 bounds-table pages. An X-GB virtual
+    area needs 4*X GB of virtual space, plus 2GB for the bounds directory.
+    If we were to preallocate them for the 128TB of user virtual address
+    space, we would need to reserve 512TB+2GB, which is larger than the
+    entire virtual address space today. This means they can not be reserved
+    ahead of time. Also, a single process's pre-populated bounds directory
+    consumes 2GB of virtual *AND* physical memory. IOW, it's completely
+    infeasible to prepopulate bounds directories.
+
+:Q: Can we preallocate bounds table space at the same time memory is
+    allocated which might contain pointers that might eventually need
+    bounds tables?
+:A: This would work if we could hook the site of each and every memory
+    allocation syscall. This can be done for small, constrained applications.
+    But, it isn't practical at a larger scale since a given app has no
+    way of controlling how all the parts of the app might allocate memory
+    (think libraries). The kernel is really the only place to intercept
+    these calls.
+
+:Q: Could a bounds fault be handed to userspace and the tables allocated
+    there in a signal handler instead of in the kernel?
+:A: mmap() is not on the list of safe async handler functions and even
+    if mmap() would work it still requires locking or nasty tricks to
+    keep track of the allocation state there.
 
 Having ruled out all of the userspace-only approaches for managing
 bounds tables that we could think of, we create them on demand in
@@ -167,20 +174,20 @@ If a #BR is generated due to a bounds violation caused by MPX.
 We need to decode MPX instructions to get violation address and
 set this address into extended struct siginfo.
 
-The _sigfault field of struct siginfo is extended as follow:
-
-87		/* SIGILL, SIGFPE, SIGSEGV, SIGBUS */
-88		struct {
-89			void __user *_addr; /* faulting insn/memory ref. */
-90 #ifdef __ARCH_SI_TRAPNO
-91			int _trapno;	/* TRAP # which caused the signal */
-92 #endif
-93			short _addr_lsb; /* LSB of the reported address */
-94			struct {
-95				void __user *_lower;
-96				void __user *_upper;
-97			} _addr_bnd;
-98		} _sigfault;
+The _sigfault field of struct siginfo is extended as follow::
+
+  87		/* SIGILL, SIGFPE, SIGSEGV, SIGBUS */
+  88		struct {
+  89			void __user *_addr; /* faulting insn/memory ref. */
+  90 #ifdef __ARCH_SI_TRAPNO
+  91			int _trapno;	/* TRAP # which caused the signal */
+  92 #endif
+  93			short _addr_lsb; /* LSB of the reported address */
+  94			struct {
+  95				void __user *_lower;
+  96				void __user *_upper;
+  97			} _addr_bnd;
+  98		} _sigfault;
 
 The '_addr' field refers to violation address, and new '_addr_and'
 field refers to the upper/lower bounds when a #BR is caused.
@@ -209,9 +216,10 @@ Adding new prctl commands
 
 Two new prctl commands are added to enable and disable MPX bounds tables
 management in kernel.
+::
 
-155	#define PR_MPX_ENABLE_MANAGEMENT	43
-156	#define PR_MPX_DISABLE_MANAGEMENT	44
+  155	#define PR_MPX_ENABLE_MANAGEMENT	43
+  156	#define PR_MPX_DISABLE_MANAGEMENT	44
 
 Runtime library in userspace is responsible for allocation of bounds
 directory. So kernel have to use XSAVE instruction to get the base
@@ -223,8 +231,8 @@ into struct mm_struct to be used in future during PR_MPX_ENABLE_MANAGEMENT
 command execution.
 
 
-4. Special rules
-================
+Special rules
+=============
 
 1) If userspace is requesting help from the kernel to do the management
 of bounds tables, it may not create or modify entries in the bounds directory.
-- 
2.20.1
