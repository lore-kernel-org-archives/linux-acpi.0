From: Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 07/23] acpi doc: convert acpi/DSD-properties-rules.txt to rst format
Date: Fri, 29 Mar 2019 00:27:05 +0800
Message-ID: <20190328162721.26138-8-changbin.du@gmail.com>
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
 ...ies-rules.txt => DSD-properties-rules.rst} | 19 ++++++++++---------
 Documentation/acpi/index.rst                  |  1 +
 2 files changed, 11 insertions(+), 9 deletions(-)
 rename Documentation/acpi/{DSD-properties-rules.txt => DSD-properties-rules.rst} (89%)

diff --git a/Documentation/acpi/DSD-properties-rules.txt b/Documentation/acpi/DSD-properties-rules.rst
similarity index 89%
rename from Documentation/acpi/DSD-properties-rules.txt
rename to Documentation/acpi/DSD-properties-rules.rst
index 3e4862bdad98..8e018d768c4f 100644
--- a/Documentation/acpi/DSD-properties-rules.txt
+++ b/Documentation/acpi/DSD-properties-rules.rst
@@ -1,8 +1,9 @@
+==================================
 _DSD Device Properties Usage Rules
-----------------------------------
+==================================
 
 Properties, Property Sets and Property Subsets
-----------------------------------------------
+==============================================
 
 The _DSD (Device Specific Data) configuration object, introduced in ACPI 5.1,
 allows any type of device configuration data to be provided via the ACPI
@@ -18,7 +19,7 @@ specific type) associated with it.
 
 In the ACPI _DSD context it is an element of the sub-package following the
 generic Device Properties UUID in the _DSD return package as specified in the
-Device Properties UUID definition document [1].
+Device Properties UUID definition document [1]_.
 
 It also may be regarded as the definition of a key and the associated data type
 that can be returned by _DSD in the Device Properties UUID sub-package for a
@@ -33,14 +34,14 @@ Property subsets are nested collections of properties.  Each of them is
 associated with an additional key (name) allowing the subset to be referred
 to as a whole (and to be treated as a separate entity).  The canonical
 representation of property subsets is via the mechanism specified in the
-Hierarchical Properties Extension UUID definition document [2].
+Hierarchical Properties Extension UUID definition document [2]_.
 
 Property sets may be hierarchical.  That is, a property set may contain
 multiple property subsets that each may contain property subsets of its
 own and so on.
 
 General Validity Rule for Property Sets
----------------------------------------
+=======================================
 
 Valid property sets must follow the guidance given by the Device Properties UUID
 definition document [1].
@@ -73,7 +74,7 @@ suitable for the ACPI environment and consequently they cannot belong to a valid
 property set.
 
 Property Sets and Device Tree Bindings
---------------------------------------
+======================================
 
 It often is useful to make _DSD return property sets that follow Device Tree
 bindings.
@@ -91,7 +92,7 @@ expected to automatically work in the ACPI environment regardless of their
 contents.
 
 References
-----------
+==========
 
-[1] http://www.uefi.org/sites/default/files/resources/_DSD-device-properties-UUID.pdf
-[2] http://www.uefi.org/sites/default/files/resources/_DSD-hierarchical-data-extension-UUID-v1.1.pdf
+.. [1] http://www.uefi.org/sites/default/files/resources/_DSD-device-properties-UUID.pdf
+.. [2] http://www.uefi.org/sites/default/files/resources/_DSD-hierarchical-data-extension-UUID-v1.1.pdf
diff --git a/Documentation/acpi/index.rst b/Documentation/acpi/index.rst
index dac49d27e841..376e12a65f3f 100644
--- a/Documentation/acpi/index.rst
+++ b/Documentation/acpi/index.rst
@@ -9,4 +9,5 @@ Linux ACPI (Advanced Configuration and Power Interface)
    namespace
    enumeration
    osi
+   DSD-properties-rules
    scan_handlers
-- 
2.20.1
