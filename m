From: Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v4 61/63] Documentation: x86: convert x86_64/fake-numa-for-cpusets to reST
Date: Wed, 24 Apr 2019 00:29:30 +0800
Message-ID: <20190423162932.21428-62-changbin.du@gmail.com>
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
 ...a-for-cpusets => fake-numa-for-cpusets.rst} | 18 +++++++++++++-----
 Documentation/x86/x86_64/index.rst             |  1 +
 2 files changed, 14 insertions(+), 5 deletions(-)
 rename Documentation/x86/x86_64/{fake-numa-for-cpusets => fake-numa-for-cpusets.rst} (90%)

diff --git a/Documentation/x86/x86_64/fake-numa-for-cpusets b/Documentation/x86/x86_64/fake-numa-for-cpusets.rst
similarity index 90%
rename from Documentation/x86/x86_64/fake-numa-for-cpusets
rename to Documentation/x86/x86_64/fake-numa-for-cpusets.rst
index 4b09f18831f8..3c23f45d38f6 100644
--- a/Documentation/x86/x86_64/fake-numa-for-cpusets
+++ b/Documentation/x86/x86_64/fake-numa-for-cpusets.rst
@@ -1,5 +1,12 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====================
+Fake NUMA For CPUSets
+=====================
+
+:Author: David Rientjes <rientjes@cs.washington.edu>
+
 Using numa=fake and CPUSets for Resource Management
-Written by David Rientjes <rientjes@cs.washington.edu>
 
 This document describes how the numa=fake x86_64 command-line option can be used
 in conjunction with cpusets for coarse memory management.  Using this feature,
@@ -20,7 +27,7 @@ you become more familiar with using this combination for resource control,
 you'll determine a better setup to minimize the number of nodes you have to deal
 with.
 
-A machine may be split as follows with "numa=fake=4*512," as reported by dmesg:
+A machine may be split as follows with "numa=fake=4*512," as reported by dmesg::
 
 	Faking node 0 at 0000000000000000-0000000020000000 (512MB)
 	Faking node 1 at 0000000020000000-0000000040000000 (512MB)
@@ -34,7 +41,7 @@ A machine may be split as follows with "numa=fake=4*512," as reported by dmesg:
 
 Now following the instructions for mounting the cpusets filesystem from
 Documentation/cgroup-v1/cpusets.txt, you can assign fake nodes (i.e. contiguous memory
-address spaces) to individual cpusets:
+address spaces) to individual cpusets::
 
 	[root@xroads /]# mkdir exampleset
 	[root@xroads /]# mount -t cpuset none exampleset
@@ -47,7 +54,7 @@ Now this cpuset, 'ddset', will only allowed access to fake nodes 0 and 1 for
 memory allocations (1G).
 
 You can now assign tasks to these cpusets to limit the memory resources
-available to them according to the fake nodes assigned as mems:
+available to them according to the fake nodes assigned as mems::
 
 	[root@xroads /exampleset/ddset]# echo $$ > tasks
 	[root@xroads /exampleset/ddset]# dd if=/dev/zero of=tmp bs=1024 count=1G
@@ -56,7 +63,8 @@ available to them according to the fake nodes assigned as mems:
 Notice the difference between the system memory usage as reported by
 /proc/meminfo between the restricted cpuset case above and the unrestricted
 case (i.e. running the same 'dd' command without assigning it to a fake NUMA
-cpuset):
+cpuset)::
+
 				Unrestricted	Restricted
 	MemTotal:		3091900 kB	3091900 kB
 	MemFree:		  42113 kB	1513236 kB
diff --git a/Documentation/x86/x86_64/index.rst b/Documentation/x86/x86_64/index.rst
index 7b8c82151358..e2a324cde671 100644
--- a/Documentation/x86/x86_64/index.rst
+++ b/Documentation/x86/x86_64/index.rst
@@ -11,3 +11,4 @@ x86_64 Support
    uefi
    mm
    5level-paging
+   fake-numa-for-cpusets
-- 
2.20.1
