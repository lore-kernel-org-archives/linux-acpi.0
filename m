From: Len Brown <lenb@kernel.org>
Subject: [PATCH] ACPI: update DSDT override documentation
Date: Wed,  6 Feb 2008 20:12:52 -0500
Message-ID: <1202346773-1893-5-git-send-email-lenb@kernel.org>
References: <47AA4F9D.7010601@tremplin-utc.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:1827 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758122AbYBGBXJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Feb 2008 20:23:09 -0500
In-Reply-To: <47AA4F9D.7010601@tremplin-utc.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/acpi/dsdt-initrd.txt       |  100 ------------------------------
 Documentation/acpi/dsdt-override.txt     |   15 +++++
 Documentation/acpi/initramfs-add-dsdt.sh |   43 +++++++++++++
 drivers/acpi/Kconfig                     |   22 +++----
 4 files changed, 67 insertions(+), 113 deletions(-)
 delete mode 100644 Documentation/acpi/dsdt-initrd.txt
 create mode 100644 Documentation/acpi/dsdt-override.txt
 create mode 100755 Documentation/acpi/initramfs-add-dsdt.sh

diff --git a/Documentation/acpi/dsdt-initrd.txt b/Documentation/acpi/dsdt-initrd.txt
deleted file mode 100644
index 59f8609..0000000
--- a/Documentation/acpi/dsdt-initrd.txt
+++ /dev/null
@@ -1,100 +0,0 @@
-ACPI Custom DSDT read from initramfs
-
-2003 by Markus Gaugusch < dsdt at gaugusch dot at >
-Special thanks go to Thomas Renninger from SuSE, who updated the patch for
-2.6.0 and later modified it to read inside initramfs
-2004 - 2008 maintained by Eric Piel < eric dot piel at tremplin-utc dot net >
-
-This option is intended for people who would like to hack their DSDT and don't
-want to recompile their kernel after every change. It can also be useful to
-distros which offers pre-compiled kernels and want to allow their users to use
-a modified DSDT. In the Kernel config, enable the initial RAM filesystem
-support (in General Setup) and enable ACPI_CUSTOM_DSDT_INITRD at the ACPI
-options (General Setup|ACPI Support|Read Custom DSDT from initramfs).
-
-A custom DSDT (Differentiated System Description Table) is useful when your
-computer uses ACPI but problems occur due to broken implementation. Typically,
-your computer works but there are some troubles with the hardware detection or
-the power management. You can check that troubles come from errors in the DSDT by
-activating the ACPI debug option and reading the logs. This table is provided
-by the BIOS, therefore it might be a good idea to check for BIOS update on your
-vendor website before going any further. Errors are often caused by vendors
-testing their hardware only with Windows or because there is code which is
-executed only on a specific OS with a specific version and Linux hasn't been
-considered during the development.
-
-Before you run away from customising your DSDT, you should note that already
-corrected tables are available for a fair amount of computers on this web-page:
-http://acpi.sf.net/dsdt . Be careful though, to work correctly a DSDT has to
-match closely the hardware, including the amount of RAM, the frequency of the
-processor and the PCI cards present! If you are part of the unluckies who
-cannot find their hardware in this database, you can modify your DSDT by
-yourself. This process is less painful than it sounds. Download the Intel ASL
-compiler/decompiler at http://www.intel.com/technology/IAPC/acpi/downloads.htm .
-As root, you then have to dump your DSDT and decompile it. By using the
-compiler messages as well as the kernel ACPI debug messages and the reference
-book (available at the Intel website and also at http://www.acpi.info), it is
-quite easy to obtain a fully working table.
-
-Once your new DSDT is ready you'll have to add it to an initramfs so that the
-kernel can read the table at the very beginning of the boot. As the file has to
-be accessed very early during the boot process the initramfs has to be an
-initramfs. The file is contained into the initramfs under the name /DSDT.aml .
-To obtain such an initramfs, you might have to modify your initramfs script or
-you can add it later to the initramfs with the script appended to this
-document. The command will look like:
-initramfs-add-dsdt initramfs.img my-dsdt.aml
-
-In case you don't use any initramfs, the possibilities you have are to either
-start using one (try mkinitrd or yaird), or use the "Include Custom DSDT"
-configure option to directly include your DSDT inside the kernel.
-
-The message "Looking for DSDT in initramfs..." will tell you if the DSDT was
-found or not. If you need to update your DSDT, generate a new initramfs and
-perform the steps above. Don't forget that with Lilo, you'll have to re-run it.
-
-
-====================== Here starts initramfs-add-dsdt ==========================
-#!/bin/bash
-# Adds a DSDT file to the initrd (if it's an initramfs)
-# first argument is the name of archive
-# second argument is the name of the file to add
-# The file will be copied as /DSDT.aml
-
-# 20060126: fix "Premature end of file" with some old cpio (Roland Robic)
-# 20060205: this time it should really work
-
-# check the arguments
-if [ $# -ne 2 ]; then
-	program_name=$(basename $0)
-	echo "\
-$program_name: too few arguments
-Usage: $program_name initrd-name.img DSDT-to-add.aml
-Adds a DSDT file to an initrd (in initramfs format)
-
-  initrd-name.img: filename of the initrd in initramfs format
-  DSDT-to-add.aml: filename of the DSDT file to add
-  " 1>&2
-    exit 1
-fi
-
-# we should check it's an initramfs
-
-tempcpio=$(mktemp -d)
-# cleanup on exit, hangup, interrupt, quit, termination
-trap 'rm -rf $tempcpio' 0 1 2 3 15
-
-# extract the archive
-gunzip -c "$1" > "$tempcpio"/initramfs.cpio || exit 1
-
-# copy the DSDT file at the root of the directory so that we can call it "/DSDT.aml"
-cp -f "$2" "$tempcpio"/DSDT.aml
-
-# add the file
-cd "$tempcpio"
-(echo DSDT.aml | cpio --quiet -H newc -o -A -O "$tempcpio"/initramfs.cpio) || exit 1
-cd "$OLDPWD"
-
-# re-compress the archive
-gzip -c "$tempcpio"/initramfs.cpio > "$1"
-
diff --git a/Documentation/acpi/dsdt-override.txt b/Documentation/acpi/dsdt-override.txt
new file mode 100644
index 0000000..5008f25
--- /dev/null
+++ b/Documentation/acpi/dsdt-override.txt
@@ -0,0 +1,15 @@
+Linux supports two methods of overriding the BIOS DSDT:
+
+CONFIG_ACPI_CUSTOM_DSDT builds the image into the kernel.
+
+CONFIG_ACPI_CUSTOM_DSDT_INITRD adds the image to the initrd.
+
+When to use these methods is described in detail on the
+Linux/ACPI home page:
+http://www.lesswatts.org/projects/acpi/overridingDSDT.php
+
+Note that if both options are used, the DSDT supplied
+by the INITRD method takes precedence.
+
+Documentation/initramfs-add-dsdt.sh is provided for convenience
+for use with the CONFIG_ACPI_CUSTOM_DSDT_INITRD method.
diff --git a/Documentation/acpi/initramfs-add-dsdt.sh b/Documentation/acpi/initramfs-add-dsdt.sh
new file mode 100755
index 0000000..17ef6e8
--- /dev/null
+++ b/Documentation/acpi/initramfs-add-dsdt.sh
@@ -0,0 +1,43 @@
+#!/bin/bash
+# Adds a DSDT file to the initrd (if it's an initramfs)
+# first argument is the name of archive
+# second argument is the name of the file to add
+# The file will be copied as /DSDT.aml
+
+# 20060126: fix "Premature end of file" with some old cpio (Roland Robic)
+# 20060205: this time it should really work
+
+# check the arguments
+if [ $# -ne 2 ]; then
+	program_name=$(basename $0)
+	echo "\
+$program_name: too few arguments
+Usage: $program_name initrd-name.img DSDT-to-add.aml
+Adds a DSDT file to an initrd (in initramfs format)
+
+  initrd-name.img: filename of the initrd in initramfs format
+  DSDT-to-add.aml: filename of the DSDT file to add
+  " 1>&2
+    exit 1
+fi
+
+# we should check it's an initramfs
+
+tempcpio=$(mktemp -d)
+# cleanup on exit, hangup, interrupt, quit, termination
+trap 'rm -rf $tempcpio' 0 1 2 3 15
+
+# extract the archive
+gunzip -c "$1" > "$tempcpio"/initramfs.cpio || exit 1
+
+# copy the DSDT file at the root of the directory so that we can call it "/DSDT.aml"
+cp -f "$2" "$tempcpio"/DSDT.aml
+
+# add the file
+cd "$tempcpio"
+(echo DSDT.aml | cpio --quiet -H newc -o -A -O "$tempcpio"/initramfs.cpio) || exit 1
+cd "$OLDPWD"
+
+# re-compress the archive
+gzip -c "$tempcpio"/initramfs.cpio > "$1"
+
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 0442ae1..c8e8320 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -263,8 +263,10 @@ config ACPI_CUSTOM_DSDT
 	depends on !STANDALONE
 	default n 
 	help
-	  This option is to load a custom ACPI DSDT
-	  If you don't know what that is, say N.
+	  This option supports a custom DSDT by linking it into the kernel.
+	  See Documentation/acpi/dsdt-override.txt
+
+	  If unsure, say N.
 
 config ACPI_CUSTOM_DSDT_FILE
 	string "Custom DSDT Table file to include"
@@ -279,17 +281,11 @@ config ACPI_CUSTOM_DSDT_INITRD
 	depends on BLK_DEV_INITRD
 	default n
 	help
-	  The DSDT (Differentiated System Description Table) often needs to be
-	  overridden because of broken BIOS implementations. If this feature is
-	  activated you will be able to provide a customized DSDT by adding it
-	  to your initramfs. If your mkinitrd tool does not support this feature
-	  a script is provided in the documentation. For more details see
-	  <file:Documentation/dsdt-initrd.txt> or <http://gaugusch.at/kernel.shtml>.
-	  If there is no table found, it will fall-back to the custom DSDT
-	  in-kernel (if activated) or to the DSDT from the BIOS.
-
-	  Even if you do not need a new one at the moment, you may want to use a
-	  better DSDT later. It is safe to say Y here.
+	  This option supports a custom DSDT by optionally loading it from initrd.
+	  See Documentation/acpi/dsdt-override.txt
+
+	  If you are not using this feature now, but may use it later,
+	  it is safe to say Y here.
 
 config ACPI_BLACKLIST_YEAR
 	int "Disable ACPI for systems before Jan 1st this year" if X86_32
-- 
1.5.4.23.gef5b9

