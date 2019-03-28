From: Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 20/23] acpi doc: convert acpi/cppc_sysfs.txt to rst format
Date: Fri, 29 Mar 2019 00:27:18 +0800
Message-ID: <20190328162721.26138-21-changbin.du@gmail.com>
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
 .../acpi/{cppc_sysfs.txt => cppc_sysfs.rst}   | 69 ++++++++++---------
 Documentation/acpi/index.rst                  |  1 +
 2 files changed, 38 insertions(+), 32 deletions(-)
 rename Documentation/acpi/{cppc_sysfs.txt => cppc_sysfs.rst} (51%)

diff --git a/Documentation/acpi/cppc_sysfs.txt b/Documentation/acpi/cppc_sysfs.rst
similarity index 51%
rename from Documentation/acpi/cppc_sysfs.txt
rename to Documentation/acpi/cppc_sysfs.rst
index f20fb445135d..e8a13d6e7a6c 100644
--- a/Documentation/acpi/cppc_sysfs.txt
+++ b/Documentation/acpi/cppc_sysfs.rst
@@ -1,5 +1,9 @@
+==================================================
+Collaborative Processor Performance Control (CPPC)
+==================================================
 
-	Collaborative Processor Performance Control (CPPC)
+CPPC
+====
 
 CPPC defined in the ACPI spec describes a mechanism for the OS to manage the
 performance of a logical processor on a contigious and abstract performance
@@ -10,31 +14,28 @@ For more details on CPPC please refer to the ACPI specification at:
 
 http://uefi.org/specifications
 
-Some of the CPPC registers are exposed via sysfs under:
+Some of the CPPC registers are exposed via sysfs under::
 
-/sys/devices/system/cpu/cpuX/acpi_cppc/
+  /sys/devices/system/cpu/cpuX/acpi_cppc/
 
-for each cpu X
+for each cpu X::
 
---------------------------------------------------------------------------------
-
-$ ls -lR  /sys/devices/system/cpu/cpu0/acpi_cppc/
-/sys/devices/system/cpu/cpu0/acpi_cppc/:
-total 0
--r--r--r-- 1 root root 65536 Mar  5 19:38 feedback_ctrs
--r--r--r-- 1 root root 65536 Mar  5 19:38 highest_perf
--r--r--r-- 1 root root 65536 Mar  5 19:38 lowest_freq
--r--r--r-- 1 root root 65536 Mar  5 19:38 lowest_nonlinear_perf
--r--r--r-- 1 root root 65536 Mar  5 19:38 lowest_perf
--r--r--r-- 1 root root 65536 Mar  5 19:38 nominal_freq
--r--r--r-- 1 root root 65536 Mar  5 19:38 nominal_perf
--r--r--r-- 1 root root 65536 Mar  5 19:38 reference_perf
--r--r--r-- 1 root root 65536 Mar  5 19:38 wraparound_time
-
---------------------------------------------------------------------------------
+  $ ls -lR  /sys/devices/system/cpu/cpu0/acpi_cppc/
+  /sys/devices/system/cpu/cpu0/acpi_cppc/:
+  total 0
+  -r--r--r-- 1 root root 65536 Mar  5 19:38 feedback_ctrs
+  -r--r--r-- 1 root root 65536 Mar  5 19:38 highest_perf
+  -r--r--r-- 1 root root 65536 Mar  5 19:38 lowest_freq
+  -r--r--r-- 1 root root 65536 Mar  5 19:38 lowest_nonlinear_perf
+  -r--r--r-- 1 root root 65536 Mar  5 19:38 lowest_perf
+  -r--r--r-- 1 root root 65536 Mar  5 19:38 nominal_freq
+  -r--r--r-- 1 root root 65536 Mar  5 19:38 nominal_perf
+  -r--r--r-- 1 root root 65536 Mar  5 19:38 reference_perf
+  -r--r--r-- 1 root root 65536 Mar  5 19:38 wraparound_time
 
 * highest_perf : Highest performance of this processor (abstract scale).
-* nominal_perf : Highest sustained performance of this processor (abstract scale).
+* nominal_perf : Highest sustained performance of this processor
+  (abstract scale).
 * lowest_nonlinear_perf : Lowest performance of this processor with nonlinear
   power savings (abstract scale).
 * lowest_perf : Lowest performance of this processor (abstract scale).
@@ -48,22 +49,26 @@ total 0
 * feedback_ctrs : Includes both Reference and delivered performance counter.
   Reference counter ticks up proportional to processor's reference performance.
   Delivered counter ticks up proportional to processor's delivered performance.
-* wraparound_time: Minimum time for the feedback counters to wraparound (seconds).
+* wraparound_time: Minimum time for the feedback counters to wraparound
+  (seconds).
 * reference_perf : Performance level at which reference performance counter
   accumulates (abstract scale).
 
---------------------------------------------------------------------------------
 
-		Computing Average Delivered Performance
+Computing Average Delivered Performance
+=======================================
+
+Below describes the steps to compute the average performance delivered by
+taking two different snapshots of feedback counters at time T1 and T2.
+
+  T1: Read feedback_ctrs as fbc_t1
+      Wait or run some workload
 
-Below describes the steps to compute the average performance delivered by taking
-two different snapshots of feedback counters at time T1 and T2.
+  T2: Read feedback_ctrs as fbc_t2
 
-T1: Read feedback_ctrs as fbc_t1
-    Wait or run some workload
-T2: Read feedback_ctrs as fbc_t2
+::
 
-delivered_counter_delta = fbc_t2[del] - fbc_t1[del]
-reference_counter_delta = fbc_t2[ref] - fbc_t1[ref]
+  delivered_counter_delta = fbc_t2[del] - fbc_t1[del]
+  reference_counter_delta = fbc_t2[ref] - fbc_t1[ref]
 
-delivered_perf = (refernce_perf x delivered_counter_delta) / reference_counter_delta
+  delivered_perf = (refernce_perf x delivered_counter_delta) / reference_counter_delta
diff --git a/Documentation/acpi/index.rst b/Documentation/acpi/index.rst
index 431edc664135..f59e6ddb0f99 100644
--- a/Documentation/acpi/index.rst
+++ b/Documentation/acpi/index.rst
@@ -24,3 +24,4 @@ Linux ACPI (Advanced Configuration and Power Interface)
    aml-debugger
    apei/output_format
    apei/einj
+   cppc_sysfs
-- 
2.20.1
