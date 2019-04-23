From: Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v4 45/63] Documentation: x86: convert tlb.txt to reST
Date: Wed, 24 Apr 2019 00:29:14 +0800
Message-ID: <20190423162932.21428-46-changbin.du@gmail.com>
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
 Documentation/x86/index.rst            |  1 +
 Documentation/x86/{tlb.txt => tlb.rst} | 30 ++++++++++++++++----------
 2 files changed, 20 insertions(+), 11 deletions(-)
 rename Documentation/x86/{tlb.txt => tlb.rst} (81%)

diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index 9a0b5f38ef6b..fd54b859db9b 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -15,3 +15,4 @@ Linux x86 Support
    entry_64
    earlyprintk
    zero-page
+   tlb
diff --git a/Documentation/x86/tlb.txt b/Documentation/x86/tlb.rst
similarity index 81%
rename from Documentation/x86/tlb.txt
rename to Documentation/x86/tlb.rst
index 6a0607b99ed8..82ec58ae63a8 100644
--- a/Documentation/x86/tlb.txt
+++ b/Documentation/x86/tlb.rst
@@ -1,5 +1,12 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=======
+The TLB
+=======
+
 When the kernel unmaps or modified the attributes of a range of
 memory, it has two choices:
+
  1. Flush the entire TLB with a two-instruction sequence.  This is
     a quick operation, but it causes collateral damage: TLB entries
     from areas other than the one we are trying to flush will be
@@ -10,6 +17,7 @@ memory, it has two choices:
     damage to other TLB entries.
 
 Which method to do depends on a few things:
+
  1. The size of the flush being performed.  A flush of the entire
     address space is obviously better performed by flushing the
     entire TLB than doing 2^48/PAGE_SIZE individual flushes.
@@ -33,7 +41,7 @@ well.  There is essentially no "right" point to choose.
 You may be doing too many individual invalidations if you see the
 invlpg instruction (or instructions _near_ it) show up high in
 profiles.  If you believe that individual invalidations being
-called too often, you can lower the tunable:
+called too often, you can lower the tunable::
 
 	/sys/kernel/debug/x86/tlb_single_page_flush_ceiling
 
@@ -43,7 +51,7 @@ Setting it to 1 is a very conservative setting and it should
 never need to be 0 under normal circumstances.
 
 Despite the fact that a single individual flush on x86 is
-guaranteed to flush a full 2MB [1], hugetlbfs always uses the full
+guaranteed to flush a full 2MB [1]_, hugetlbfs always uses the full
 flushes.  THP is treated exactly the same as normal memory.
 
 You might see invlpg inside of flush_tlb_mm_range() show up in
@@ -54,15 +62,15 @@ Essentially, you are balancing the cycles you spend doing invlpg
 with the cycles that you spend refilling the TLB later.
 
 You can measure how expensive TLB refills are by using
-performance counters and 'perf stat', like this:
+performance counters and 'perf stat', like this::
 
-perf stat -e
-	cpu/event=0x8,umask=0x84,name=dtlb_load_misses_walk_duration/,
-	cpu/event=0x8,umask=0x82,name=dtlb_load_misses_walk_completed/,
-	cpu/event=0x49,umask=0x4,name=dtlb_store_misses_walk_duration/,
-	cpu/event=0x49,umask=0x2,name=dtlb_store_misses_walk_completed/,
-	cpu/event=0x85,umask=0x4,name=itlb_misses_walk_duration/,
-	cpu/event=0x85,umask=0x2,name=itlb_misses_walk_completed/
+  perf stat -e
+    cpu/event=0x8,umask=0x84,name=dtlb_load_misses_walk_duration/,
+    cpu/event=0x8,umask=0x82,name=dtlb_load_misses_walk_completed/,
+    cpu/event=0x49,umask=0x4,name=dtlb_store_misses_walk_duration/,
+    cpu/event=0x49,umask=0x2,name=dtlb_store_misses_walk_completed/,
+    cpu/event=0x85,umask=0x4,name=itlb_misses_walk_duration/,
+    cpu/event=0x85,umask=0x2,name=itlb_misses_walk_completed/
 
 That works on an IvyBridge-era CPU (i5-3320M).  Different CPUs
 may have differently-named counters, but they should at least
@@ -70,6 +78,6 @@ be there in some form.  You can use pmu-tools 'ocperf list'
 (https://github.com/andikleen/pmu-tools) to find the right
 counters for a given CPU.
 
-1. A footnote in Intel's SDM "4.10.4.2 Recommended Invalidation"
+.. [1] A footnote in Intel's SDM "4.10.4.2 Recommended Invalidation"
    says: "One execution of INVLPG is sufficient even for a page
    with size greater than 4 KBytes."
-- 
2.20.1
