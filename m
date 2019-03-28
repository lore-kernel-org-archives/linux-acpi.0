From: Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 06/23] acpi doc: convert acpi/scan_handlers.txt to rst format
Date: Fri, 29 Mar 2019 00:27:04 +0800
Message-ID: <20190328162721.26138-7-changbin.du@gmail.com>
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
 Documentation/acpi/index.rst                  |  1 +
 .../{scan_handlers.txt => scan_handlers.rst}  | 23 +++++++++++--------
 2 files changed, 15 insertions(+), 9 deletions(-)
 rename Documentation/acpi/{scan_handlers.txt => scan_handlers.rst} (91%)

diff --git a/Documentation/acpi/index.rst b/Documentation/acpi/index.rst
index 0ba63d0ec9c7..dac49d27e841 100644
--- a/Documentation/acpi/index.rst
+++ b/Documentation/acpi/index.rst
@@ -9,3 +9,4 @@ Linux ACPI (Advanced Configuration and Power Interface)
    namespace
    enumeration
    osi
+   scan_handlers
diff --git a/Documentation/acpi/scan_handlers.txt b/Documentation/acpi/scan_handlers.rst
similarity index 91%
rename from Documentation/acpi/scan_handlers.txt
rename to Documentation/acpi/scan_handlers.rst
index 3246ccf15992..6036127a9571 100644
--- a/Documentation/acpi/scan_handlers.txt
+++ b/Documentation/acpi/scan_handlers.rst
@@ -1,7 +1,12 @@
+.. include:: <isonum.txt>
+
+==================
 ACPI Scan Handlers
+==================
+
+:Copyright: |copy| 2012, Intel Corporation
 
-Copyright (C) 2012, Intel Corporation
-Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
+:Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
 
 During system initialization and ACPI-based device hot-add, the ACPI namespace
 is scanned in search of device objects that generally represent various pieces
@@ -30,14 +35,14 @@ to configure that link so that the kernel can use it.
 Those additional configuration tasks usually depend on the type of the hardware
 component represented by the given device node which can be determined on the
 basis of the device node's hardware ID (HID).  They are performed by objects
-called ACPI scan handlers represented by the following structure:
+called ACPI scan handlers represented by the following structure::
 
-struct acpi_scan_handler {
-	const struct acpi_device_id *ids;
-	struct list_head list_node;
-	int (*attach)(struct acpi_device *dev, const struct acpi_device_id *id);
-	void (*detach)(struct acpi_device *dev);
-};
+	struct acpi_scan_handler {
+		const struct acpi_device_id *ids;
+		struct list_head list_node;
+		int (*attach)(struct acpi_device *dev, const struct acpi_device_id *id);
+		void (*detach)(struct acpi_device *dev);
+	};
 
 where ids is the list of IDs of device nodes the given handler is supposed to
 take care of, list_node is the hook to the global list of ACPI scan handlers
-- 
2.20.1
