From: Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v2 15/24] acpi doc: convert acpi/dsd/data-node-references.txt to rst format
Date: Fri, 29 Mar 2019 08:11:26 +0800
Message-ID: <20190329001135.15847-16-changbin.du@gmail.com>
References: <20190329001135.15847-1-changbin.du@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190329001135.15847-1-changbin.du@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Corbet <corbet@lwn.net>
Cc: rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
List-Id: linux-acpi@vger.kernel.org

This converts the plain text documentation to reStructuredText format and
add it to Sphinx TOC tree. No essential content change.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 ...eferences.txt => data-node-references.rst} | 28 +++++++++++--------
 Documentation/acpi/index.rst                  |  1 +
 2 files changed, 17 insertions(+), 12 deletions(-)
 rename Documentation/acpi/dsd/{data-node-references.txt => data-node-references.rst} (79%)

diff --git a/Documentation/acpi/dsd/data-node-references.txt b/Documentation/acpi/dsd/data-node-references.rst
similarity index 79%
rename from Documentation/acpi/dsd/data-node-references.txt
rename to Documentation/acpi/dsd/data-node-references.rst
index c3871565c8cf..79c5368eaecf 100644
--- a/Documentation/acpi/dsd/data-node-references.txt
+++ b/Documentation/acpi/dsd/data-node-references.rst
@@ -1,9 +1,12 @@
-Copyright (C) 2018 Intel Corporation
-Author: Sakari Ailus <sakari.ailus@linux.intel.com>
-
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: <isonum.txt>
 
+===================================
 Referencing hierarchical data nodes
------------------------------------
+===================================
+
+:Copyright: |copy| 2018 Intel Corporation
+:Author: Sakari Ailus <sakari.ailus@linux.intel.com>
 
 ACPI in general allows referring to device objects in the tree only.
 Hierarchical data extension nodes may not be referred to directly, hence this
@@ -28,13 +31,14 @@ extension key.
 
 
 Example
--------
+=======
 
-	In the ASL snippet below, the "reference" _DSD property [2] contains a
-	device object reference to DEV0 and under that device object, a
-	hierarchical data extension key "node@1" referring to the NOD1 object
-	and lastly, a hierarchical data extension key "anothernode" referring to
-	the ANOD object which is also the final target node of the reference.
+In the ASL snippet below, the "reference" _DSD property [2] contains a
+device object reference to DEV0 and under that device object, a
+hierarchical data extension key "node@1" referring to the NOD1 object
+and lastly, a hierarchical data extension key "anothernode" referring to
+the ANOD object which is also the final target node of the reference.
+::
 
 	Device (DEV0)
 	{
@@ -75,10 +79,10 @@ Example
 	    })
 	}
 
-Please also see a graph example in graph.txt .
+Please also see a graph example in :doc:`graph`.
 
 References
-----------
+==========
 
 [1] Hierarchical Data Extension UUID For _DSD.
     <URL:http://www.uefi.org/sites/default/files/resources/_DSD-hierarchical-data-extension-UUID-v1.1.pdf>,
diff --git a/Documentation/acpi/index.rst b/Documentation/acpi/index.rst
index 40a628b2be21..b680fb13f445 100644
--- a/Documentation/acpi/index.rst
+++ b/Documentation/acpi/index.rst
@@ -10,6 +10,7 @@ Linux ACPI (Advanced Configuration and Power Interface)
    linuxized-acpica
    namespace
    dsd/graph
+   dsd/data-node-references
    enumeration
    osi
    DSD-properties-rules
-- 
2.20.1
