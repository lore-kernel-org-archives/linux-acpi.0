From: Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v2 12/24] acpi doc: convert acpi/i2c-muxes.txt to rst format
Date: Fri, 29 Mar 2019 08:11:23 +0800
Message-ID: <20190329001135.15847-13-changbin.du@gmail.com>
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
 Documentation/acpi/i2c-muxes.rst | 61 ++++++++++++++++++++++++++++++++
 Documentation/acpi/i2c-muxes.txt | 58 ------------------------------
 Documentation/acpi/index.rst     |  1 +
 3 files changed, 62 insertions(+), 58 deletions(-)
 create mode 100644 Documentation/acpi/i2c-muxes.rst
 delete mode 100644 Documentation/acpi/i2c-muxes.txt

diff --git a/Documentation/acpi/i2c-muxes.rst b/Documentation/acpi/i2c-muxes.rst
new file mode 100644
index 000000000000..3a8997ccd7c4
--- /dev/null
+++ b/Documentation/acpi/i2c-muxes.rst
@@ -0,0 +1,61 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==============
+ACPI I2C Muxes
+==============
+
+Describing an I2C device hierarchy that includes I2C muxes requires an ACPI
+Device () scope per mux channel.
+
+Consider this topology::
+
+    +------+   +------+
+    | SMB1 |-->| MUX0 |--CH00--> i2c client A (0x50)
+    |      |   | 0x70 |--CH01--> i2c client B (0x50)
+    +------+   +------+
+
+which corresponds to the following ASL::
+
+    Device (SMB1)
+    {
+        Name (_HID, ...)
+        Device (MUX0)
+        {
+            Name (_HID, ...)
+            Name (_CRS, ResourceTemplate () {
+                I2cSerialBus (0x70, ControllerInitiated, I2C_SPEED,
+                            AddressingMode7Bit, "^SMB1", 0x00,
+                            ResourceConsumer,,)
+            }
+
+            Device (CH00)
+            {
+                Name (_ADR, 0)
+
+                Device (CLIA)
+                {
+                    Name (_HID, ...)
+                    Name (_CRS, ResourceTemplate () {
+                        I2cSerialBus (0x50, ControllerInitiated, I2C_SPEED,
+                                    AddressingMode7Bit, "^CH00", 0x00,
+                                    ResourceConsumer,,)
+                    }
+                }
+            }
+
+            Device (CH01)
+            {
+                Name (_ADR, 1)
+
+                Device (CLIB)
+                {
+                    Name (_HID, ...)
+                    Name (_CRS, ResourceTemplate () {
+                        I2cSerialBus (0x50, ControllerInitiated, I2C_SPEED,
+                                    AddressingMode7Bit, "^CH01", 0x00,
+                                    ResourceConsumer,,)
+                    }
+                }
+            }
+        }
+    }
diff --git a/Documentation/acpi/i2c-muxes.txt b/Documentation/acpi/i2c-muxes.txt
deleted file mode 100644
index 9fcc4f0b885e..000000000000
--- a/Documentation/acpi/i2c-muxes.txt
+++ /dev/null
@@ -1,58 +0,0 @@
-ACPI I2C Muxes
---------------
-
-Describing an I2C device hierarchy that includes I2C muxes requires an ACPI
-Device () scope per mux channel.
-
-Consider this topology:
-
-+------+   +------+
-| SMB1 |-->| MUX0 |--CH00--> i2c client A (0x50)
-|      |   | 0x70 |--CH01--> i2c client B (0x50)
-+------+   +------+
-
-which corresponds to the following ASL:
-
-Device (SMB1)
-{
-    Name (_HID, ...)
-    Device (MUX0)
-    {
-        Name (_HID, ...)
-        Name (_CRS, ResourceTemplate () {
-            I2cSerialBus (0x70, ControllerInitiated, I2C_SPEED,
-                          AddressingMode7Bit, "^SMB1", 0x00,
-                          ResourceConsumer,,)
-        }
-
-        Device (CH00)
-        {
-            Name (_ADR, 0)
-
-            Device (CLIA)
-            {
-                Name (_HID, ...)
-                Name (_CRS, ResourceTemplate () {
-                    I2cSerialBus (0x50, ControllerInitiated, I2C_SPEED,
-                                  AddressingMode7Bit, "^CH00", 0x00,
-                                  ResourceConsumer,,)
-                }
-            }
-        }
-
-        Device (CH01)
-        {
-            Name (_ADR, 1)
-
-            Device (CLIB)
-            {
-                Name (_HID, ...)
-                Name (_CRS, ResourceTemplate () {
-                    I2cSerialBus (0x50, ControllerInitiated, I2C_SPEED,
-                                  AddressingMode7Bit, "^CH01", 0x00,
-                                  ResourceConsumer,,)
-                }
-            }
-        }
-    }
-}
diff --git a/Documentation/acpi/index.rst b/Documentation/acpi/index.rst
index 72fe855f567e..78f72a525a3f 100644
--- a/Documentation/acpi/index.rst
+++ b/Documentation/acpi/index.rst
@@ -13,6 +13,7 @@ Linux ACPI (Advanced Configuration and Power Interface)
    osi
    DSD-properties-rules
    gpio-properties
+   i2c-muxes
    scan_handlers
    method-customizing
    initrd_table_override
-- 
2.20.1
