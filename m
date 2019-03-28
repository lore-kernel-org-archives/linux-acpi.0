From: Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 22/23] acpi doc: convert acpi/ssdt-overlays.txt to rst format
Date: Fri, 29 Mar 2019 00:27:20 +0800
Message-ID: <20190328162721.26138-23-changbin.du@gmail.com>
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
 Documentation/acpi/index.rst                  |   1 +
 .../{ssdt-overlays.txt => ssdt-overlays.rst}  | 166 +++++++++---------
 2 files changed, 87 insertions(+), 80 deletions(-)
 rename Documentation/acpi/{ssdt-overlays.txt => ssdt-overlays.rst} (50%)

diff --git a/Documentation/acpi/index.rst b/Documentation/acpi/index.rst
index 407b7e0aa54b..7909199e16ff 100644
--- a/Documentation/acpi/index.rst
+++ b/Documentation/acpi/index.rst
@@ -26,3 +26,4 @@ Linux ACPI (Advanced Configuration and Power Interface)
    apei/einj
    cppc_sysfs
    lpit
+   ssdt-overlays
diff --git a/Documentation/acpi/ssdt-overlays.txt b/Documentation/acpi/ssdt-overlays.rst
similarity index 50%
rename from Documentation/acpi/ssdt-overlays.txt
rename to Documentation/acpi/ssdt-overlays.rst
index 5ae13f161ea2..3914e454c793 100644
--- a/Documentation/acpi/ssdt-overlays.txt
+++ b/Documentation/acpi/ssdt-overlays.rst
@@ -1,3 +1,6 @@
+=============
+SSDT Overlays
+=============
 
 In order to support ACPI open-ended hardware configurations (e.g. development
 boards) we need a way to augment the ACPI configuration provided by the firmware
@@ -15,55 +18,56 @@ user defined SSDT tables that contain the board specific information.
 
 For example, to enumerate a Bosch BMA222E accelerometer on the I2C bus of the
 Minnowboard MAX development board exposed via the LSE connector [1], the
-following ASL code can be used:
+following ASL code can be used::
 
-DefinitionBlock ("minnowmax.aml", "SSDT", 1, "Vendor", "Accel", 0x00000003)
-{
-    External (\_SB.I2C6, DeviceObj)
-
-    Scope (\_SB.I2C6)
+    DefinitionBlock ("minnowmax.aml", "SSDT", 1, "Vendor", "Accel", 0x00000003)
     {
-        Device (STAC)
-        {
-            Name (_ADR, Zero)
-            Name (_HID, "BMA222E")
+        External (\_SB.I2C6, DeviceObj)
 
-            Method (_CRS, 0, Serialized)
+        Scope (\_SB.I2C6)
+        {
+            Device (STAC)
             {
-                Name (RBUF, ResourceTemplate ()
+                Name (_ADR, Zero)
+                Name (_HID, "BMA222E")
+
+                Method (_CRS, 0, Serialized)
                 {
-                    I2cSerialBus (0x0018, ControllerInitiated, 0x00061A80,
-                                  AddressingMode7Bit, "\\_SB.I2C6", 0x00,
-                                  ResourceConsumer, ,)
-                    GpioInt (Edge, ActiveHigh, Exclusive, PullDown, 0x0000,
-                             "\\_SB.GPO2", 0x00, ResourceConsumer, , )
-                    { // Pin list
-                        0
-                    }
-                })
-                Return (RBUF)
+                    Name (RBUF, ResourceTemplate ()
+                    {
+                        I2cSerialBus (0x0018, ControllerInitiated, 0x00061A80,
+                                    AddressingMode7Bit, "\\_SB.I2C6", 0x00,
+                                    ResourceConsumer, ,)
+                        GpioInt (Edge, ActiveHigh, Exclusive, PullDown, 0x0000,
+                                "\\_SB.GPO2", 0x00, ResourceConsumer, , )
+                        { // Pin list
+                            0
+                        }
+                    })
+                    Return (RBUF)
+                }
             }
         }
     }
-}
 
-which can then be compiled to AML binary format:
+which can then be compiled to AML binary format::
 
-$ iasl minnowmax.asl
+    $ iasl minnowmax.asl
 
-Intel ACPI Component Architecture
-ASL Optimizing Compiler version 20140214-64 [Mar 29 2014]
-Copyright (c) 2000 - 2014 Intel Corporation
+    Intel ACPI Component Architecture
+    ASL Optimizing Compiler version 20140214-64 [Mar 29 2014]
+    Copyright (c) 2000 - 2014 Intel Corporation
 
-ASL Input:     minnomax.asl - 30 lines, 614 bytes, 7 keywords
-AML Output:    minnowmax.aml - 165 bytes, 6 named objects, 1 executable opcodes
+    ASL Input:     minnomax.asl - 30 lines, 614 bytes, 7 keywords
+    AML Output:    minnowmax.aml - 165 bytes, 6 named objects, 1 executable opcodes
 
 [1] http://wiki.minnowboard.org/MinnowBoard_MAX#Low_Speed_Expansion_Connector_.28Top.29
 
 The resulting AML code can then be loaded by the kernel using one of the methods
 below.
 
-== Loading ACPI SSDTs from initrd ==
+Loading ACPI SSDTs from initrd
+==============================
 
 This option allows loading of user defined SSDTs from initrd and it is useful
 when the system does not support EFI or when there is not enough EFI storage.
@@ -74,23 +78,24 @@ aml code must be placed in the first, uncompressed, initrd under the
 in loading multiple tables. Only SSDT and OEM tables are allowed. See
 initrd_table_override.txt for more details.
 
-Here is an example:
+Here is an example::
 
-# Add the raw ACPI tables to an uncompressed cpio archive.
-# They must be put into a /kernel/firmware/acpi directory inside the
-# cpio archive.
-# The uncompressed cpio archive must be the first.
-# Other, typically compressed cpio archives, must be
-# concatenated on top of the uncompressed one.
-mkdir -p kernel/firmware/acpi
-cp ssdt.aml kernel/firmware/acpi
+    # Add the raw ACPI tables to an uncompressed cpio archive.
+    # They must be put into a /kernel/firmware/acpi directory inside the
+    # cpio archive.
+    # The uncompressed cpio archive must be the first.
+    # Other, typically compressed cpio archives, must be
+    # concatenated on top of the uncompressed one.
+    mkdir -p kernel/firmware/acpi
+    cp ssdt.aml kernel/firmware/acpi
 
-# Create the uncompressed cpio archive and concatenate the original initrd
-# on top:
-find kernel | cpio -H newc --create > /boot/instrumented_initrd
-cat /boot/initrd >>/boot/instrumented_initrd
+    # Create the uncompressed cpio archive and concatenate the original initrd
+    # on top:
+    find kernel | cpio -H newc --create > /boot/instrumented_initrd
+    cat /boot/initrd >>/boot/instrumented_initrd
 
-== Loading ACPI SSDTs from EFI variables ==
+Loading ACPI SSDTs from EFI variables
+=====================================
 
 This is the preferred method, when EFI is supported on the platform, because it
 allows a persistent, OS independent way of storing the user defined SSDTs. There
@@ -116,48 +121,49 @@ include/linux/efi.h). Writing to the file must also be done with one write
 operation.
 
 For example, you can use the following bash script to create/update an EFI
-variable with the content from a given file:
+variable with the content from a given file::
 
-#!/bin/sh -e
+    #!/bin/sh -e
 
-while ! [ -z "$1" ]; do
-        case "$1" in
-        "-f") filename="$2"; shift;;
-        "-g") guid="$2"; shift;;
-        *) name="$1";;
-        esac
-        shift
-done
+    while ! [ -z "$1" ]; do
+            case "$1" in
+            "-f") filename="$2"; shift;;
+            "-g") guid="$2"; shift;;
+            *) name="$1";;
+            esac
+            shift
+    done
 
-usage()
-{
-        echo "Syntax: ${0##*/} -f filename [ -g guid ] name"
-        exit 1
-}
+    usage()
+    {
+            echo "Syntax: ${0##*/} -f filename [ -g guid ] name"
+            exit 1
+    }
 
-[ -n "$name" -a -f "$filename" ] || usage
+    [ -n "$name" -a -f "$filename" ] || usage
 
-EFIVARFS="/sys/firmware/efi/efivars"
+    EFIVARFS="/sys/firmware/efi/efivars"
 
-[ -d "$EFIVARFS" ] || exit 2
+    [ -d "$EFIVARFS" ] || exit 2
 
-if stat -tf $EFIVARFS | grep -q -v de5e81e4; then
-        mount -t efivarfs none $EFIVARFS
-fi
+    if stat -tf $EFIVARFS | grep -q -v de5e81e4; then
+            mount -t efivarfs none $EFIVARFS
+    fi
 
-# try to pick up an existing GUID
-[ -n "$guid" ] || guid=$(find "$EFIVARFS" -name "$name-*" | head -n1 | cut -f2- -d-)
+    # try to pick up an existing GUID
+    [ -n "$guid" ] || guid=$(find "$EFIVARFS" -name "$name-*" | head -n1 | cut -f2- -d-)
 
-# use a randomly generated GUID
-[ -n "$guid" ] || guid="$(cat /proc/sys/kernel/random/uuid)"
+    # use a randomly generated GUID
+    [ -n "$guid" ] || guid="$(cat /proc/sys/kernel/random/uuid)"
 
-# efivarfs expects all of the data in one write
-tmp=$(mktemp)
-/bin/echo -ne "\007\000\000\000" | cat - $filename > $tmp
-dd if=$tmp of="$EFIVARFS/$name-$guid" bs=$(stat -c %s $tmp)
-rm $tmp
+    # efivarfs expects all of the data in one write
+    tmp=$(mktemp)
+    /bin/echo -ne "\007\000\000\000" | cat - $filename > $tmp
+    dd if=$tmp of="$EFIVARFS/$name-$guid" bs=$(stat -c %s $tmp)
+    rm $tmp
 
-== Loading ACPI SSDTs from configfs ==
+Loading ACPI SSDTs from configfs
+================================
 
 This option allows loading of user defined SSDTs from userspace via the configfs
 interface. The CONFIG_ACPI_CONFIGFS option must be select and configfs must be
@@ -165,8 +171,8 @@ mounted. In the following examples, we assume that configfs has been mounted in
 /config.
 
 New tables can be loading by creating new directories in /config/acpi/table/ and
-writing the SSDT aml code in the aml attribute:
+writing the SSDT aml code in the aml attribute::
 
-cd /config/acpi/table
-mkdir my_ssdt
-cat ~/ssdt.aml > my_ssdt/aml
+    cd /config/acpi/table
+    mkdir my_ssdt
+    cat ~/ssdt.aml > my_ssdt/aml
-- 
2.20.1
