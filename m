From: =?UTF-8?B?w4lyaWMgUGllbA==?= <Eric.Piel@tremplin-utc.net>
Subject: Re: [PATCH 1/3] The basics of DSDT from initramfs
Date: Sun, 03 Feb 2008 18:55:12 +0100
Message-ID: <47A60000.7060004@tremplin-utc.net>
References: <4798E2A5.6020804@users.sf.net> <200801311417.57469.lenb@kernel.org> <1201859637.14573.41.camel@queen.suse.de> <200802012336.10687.lenb@kernel.org> <47A5F9C7.70402@tremplin-utc.net> <alpine.LSU.1.00.0802031835580.14446@phoenix.kerstin.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:30666 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755309AbYBCRzV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 3 Feb 2008 12:55:21 -0500
In-Reply-To: <alpine.LSU.1.00.0802031835580.14446@phoenix.kerstin.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Markus Gaugusch <markus@gaugusch.at>
Cc: Len Brown <lenb@kernel.org>, trenn@suse.de, Andrew Morton <akpm@linux-foundation.org>, Philippe Coval <rzr@users.sourceforge.net>, linux-acpi@vger.kernel.org

03/02/08 18:39, Markus Gaugusch wrote/a =C3=A9crit:
 > Hi,
 > My email address is dsdt at gaugusch dot at (not "dot org")
 > And the Markus has only one "s".
Duh! It was too simple for me to notice ;-) Sorry, here is a fixed vers=
ion.

See you,
Eric
--

The basics of DSDT from initramfs. In case this option is selected,
populate_rootfs() is called a bit earlier to have the initramfs content
available during ACPI initialisation.

This is a very similar path to the one available at
http://gaugusch.at/kernel.shtml but with some update in the
documentation, default set to No and the change of populate_rootfs() th=
e
"Jeff Mahony way" (which avoids reading the initramfs twice).

Signed-off-by: Eric Piel <eric.piel@tremplin-utc.net>

---
  Documentation/dsdt-initrd.txt |  100 ++++++++++++++++++++++++++++++++=
+++++++++
  drivers/acpi/Kconfig          |   17 +++++++
  drivers/acpi/osl.c            |   73 ++++++++++++++++++++++++++++--
  init/initramfs.c              |    8 +++-
  init/main.c                   |    7 +++
  5 files changed, 200 insertions(+), 5 deletions(-)
  create mode 100644 Documentation/dsdt-initrd.txt

diff --git a/Documentation/dsdt-initrd.txt b/Documentation/dsdt-initrd.=
txt
new file mode 100644
index 0000000..b2e9460
--- /dev/null
+++ b/Documentation/dsdt-initrd.txt
@@ -0,0 +1,100 @@
+ACPI Custom DSDT read from initramfs
+
+2003 by Markus Gaugusch < dsdt at gaugusch dot at >
+Special thanks go to Thomas Renninger from SuSE, who updated the patch=
 for
+2.6.0 and later modified it to read inside initramfs
+2004 - 2008 maintained by Eric Piel < eric dot piel at tremplin-utc do=
t net >
+
+This option is intended for people who would like to hack their DSDT a=
nd don't
+want to recompile their kernel after every change. It can also be usef=
ul to
+distros which offers pre-compiled kernels and want to allow their user=
s to use
+a modified DSDT. In the Kernel config, enable the initial RAM filesyst=
em
+support (in General Setup) and enable ACPI_CUSTOM_DSDT_INITRD at the A=
CPI
+options (General Setup|ACPI Support|Read Custom DSDT from initramfs).
+
+A custom DSDT (Differentiated System Description Table) is useful when=
 your
+computer uses ACPI but problems occur due to broken implementation. Ty=
pically,
+your computer works but there are some troubles with the hardware dete=
ction or
+the power management. You can check that troubles come from errors in =
the DSDT by
+activating the ACPI debug option and reading the logs. This table is p=
rovided
+by the BIOS, therefore it might be a good idea to check for BIOS updat=
e on your
+vendor website before going any further. Errors are often caused by ve=
ndors
+testing their hardware only with Windows or because there is code whic=
h is
+executed only on a specific OS with a specific version and Linux hasn'=
t been
+considered during the development.
+
+Before you run away from customising your DSDT, you should note that a=
lready
+corrected tables are available for a fair amount of computers on this =
web-page:
+http://acpi.sf.net/dsdt . Be careful though, to work correctly a DSDT =
has to
+match closely the hardware, including the amount of RAM, the frequency=
 of the
+processor and the PCI cards present! If you are part of the unluckies =
who
+cannot find their hardware in this database, you can modify your DSDT =
by
+yourself. This process is less painful than it sounds. Download the In=
tel ASL
+compiler/decompiler at http://www.intel.com/technology/IAPC/acpi/downl=
oads.htm .
+As root, you then have to dump your DSDT and decompile it. By using th=
e
+compiler messages as well as the kernel ACPI debug messages and the re=
ference
+book (available at the Intel website and also at http://www.acpi.info)=
, it is
+quite easy to obtain a fully working table.
+
+Once your new DSDT is ready you'll have to add it to an initramfs so t=
hat the
+kernel can read the table at the very beginning of the boot. As the fi=
le has to
+be accessed very early during the boot process the initramfs has to be=
 an
+initramfs. The file is contained into the initramfs under the name /DS=
DT.aml .
+To obtain such an initramfs, you might have to modify your initramfs s=
cript or
+you can add it later to the initramfs with the script appended to this
+document. The command will look like:
+initramfs-add-dsdt initramfs.img my-dsdt.aml
+
+In case you don't use any initramfs, the possibilities you have are to=
 either
+start using one (try mkinitrd or yaird), or use the "Include Custom DS=
DT"
+configure option to directly include your DSDT inside the kernel.
+
+The message "Looking for DSDT in initramfs..." will tell you if the DS=
DT was
+found or not. If you need to update your DSDT, generate a new initramf=
s and
+perform the steps above. Don't forget that with Lilo, you'll have to r=
e-run it.
+
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Her=
e starts initramfs-add-dsdt =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+#!/bin/bash
+# Adds a DSDT file to the initrd (if it's an initramfs)
+# first argument is the name of archive
+# second argument is the name of the file to add
+# The file will be copied as /DSDT.aml
+
+# 20060126: fix "Premature end of file" with some old cpio (Roland Rob=
ic)
+# 20060205: this time it should really work
+
+# check the arguments
+if [ $# -ne 2 ]; then
+	program_name=3D$(basename $0)
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
+tempcpio=3D$(mktemp -d)
+# cleanup on exit, hangup, interrupt, quit, termination
+trap 'rm -rf $tempcpio' 0 1 2 3 15
+
+# extract the archive
+gunzip -c "$1" > "$tempcpio"/initramfs.cpio || exit 1
+
+# copy the DSDT file at the root of the directory so that we can call =
it "/DSDT.aml"
+cp -f "$2" "$tempcpio"/DSDT.aml
+
+# add the file
+cd "$tempcpio"
+(echo DSDT.aml | cpio --quiet -H newc -o -A -O "$tempcpio"/initramfs.c=
pio) || exit 1
+cd "$OLDPWD"
+
+# re-compress the archive
+gzip -c "$tempcpio"/initramfs.cpio > "$1"
+
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index ccf6ea9..8607ed3 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -274,6 +274,23 @@ config ACPI_CUSTOM_DSDT_FILE
  	  Enter the full path name to the file which includes the AmlCode
  	  declaration.

+config ACPI_CUSTOM_DSDT_INITRD
+	bool "Read Custom DSDT from initramfs"
+	depends on BLK_DEV_INITRD
+	default n
+	help
+	  The DSDT (Differentiated System Description Table) often needs to b=
e
+	  overridden because of broken BIOS implementations. If this feature =
is
+	  activated you will be able to provide a customized DSDT by adding i=
t
+	  to your initramfs. If your mkinitrd tool does not support this feat=
ure
+	  a script is provided in the documentation. For more details see
+	  <file:Documentation/dsdt-initrd.txt> or <http://gaugusch.at/kernel.=
shtml>.
+	  If there is no table found, it will fall-back to the custom DSDT
+	  in-kernel (if activated) or to the DSDT from the BIOS.
+
+	  Even if you do not need a new one at the moment, you may want to us=
e a
+	  better DSDT later. It is safe to say Y here.
+
  config ACPI_BLACKLIST_YEAR
  	int "Disable ACPI for systems before Jan 1st this year" if X86_32
  	default 0
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index e53fb51..4568a59 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -312,6 +312,66 @@ acpi_os_predefined_override(const struct acpi_pred=
efined_names *init_val,
  	return AE_OK;
  }

+#ifdef CONFIG_ACPI_CUSTOM_DSDT_INITRD
+struct acpi_table_header *acpi_find_dsdt_initrd(void)
+{
+	struct file *firmware_file;
+	mm_segment_t oldfs;
+	unsigned long len, len2;
+	struct acpi_table_header *dsdt_buffer, *ret =3D NULL;
+	struct kstat stat;
+	char *ramfs_dsdt_name =3D "/DSDT.aml";
+
+	printk(KERN_INFO PREFIX "Looking for DSDT in initramfs... ");
+
+	/*
+	 * Never do this at home, only the user-space is allowed to open a fi=
le.
+	 * The clean way would be to use the firmware loader. But this code m=
ust be run
+	 * before there is any userspace available. So we need a static/init =
firmware
+	 * infrastructure, which doesn't exist yet...
+	 */
+	if (vfs_stat(ramfs_dsdt_name, &stat) < 0) {
+		printk("not found.\n");
+		return ret;
+	}
+
+	len =3D stat.size;
+	/* check especially against empty files */
+	if (len <=3D 4) {
+		printk("error, file is too small: only %lu bytes.\n", len);
+		return ret;
+	}
+
+	firmware_file =3D filp_open(ramfs_dsdt_name, O_RDONLY, 0);
+	if (IS_ERR(firmware_file)) {
+		printk("error, could not open file %s.\n", ramfs_dsdt_name);
+		return ret;
+	}
+
+	dsdt_buffer =3D ACPI_ALLOCATE(len);
+	if (!dsdt_buffer) {
+		printk("error when allocating %lu bytes of memory.\n", len);
+		goto err;
+	}
+
+	oldfs =3D get_fs();
+	set_fs(KERNEL_DS);
+	len2 =3D vfs_read(firmware_file, (char __user *)dsdt_buffer, len, &fi=
rmware_file->f_pos);
+	set_fs(oldfs);
+	if (len2 < len) {
+		printk("error trying to read %lu bytes from %s.\n", len, ramfs_dsdt_=
name);
+		ACPI_FREE(dsdt_buffer);
+		goto err;
+	}
+
+	printk("successfully read %lu bytes from %s.\n", len, ramfs_dsdt_name=
);
+	ret =3D dsdt_buffer;
+err:
+	filp_close(firmware_file, NULL);
+	return ret;
+}
+#endif
+
  acpi_status
  acpi_os_table_override(struct acpi_table_header * existing_table,
  		       struct acpi_table_header ** new_table)
@@ -319,13 +379,18 @@ acpi_os_table_override(struct acpi_table_header *=
 existing_table,
  	if (!existing_table || !new_table)
  		return AE_BAD_PARAMETER;

+	*new_table =3D NULL;
+
  #ifdef CONFIG_ACPI_CUSTOM_DSDT
  	if (strncmp(existing_table->signature, "DSDT", 4) =3D=3D 0)
  		*new_table =3D (struct acpi_table_header *)AmlCode;
-	else
-		*new_table =3D NULL;
-#else
-	*new_table =3D NULL;
+#endif
+#ifdef CONFIG_ACPI_CUSTOM_DSDT_INITRD
+	if (strncmp(existing_table->signature, "DSDT", 4) =3D=3D 0) {
+		struct acpi_table_header *initrd_table =3D acpi_find_dsdt_initrd();
+		if (initrd_table)
+			*new_table =3D initrd_table;
+	}
  #endif
  	return AE_OK;
  }
diff --git a/init/initramfs.c b/init/initramfs.c
index 1db02a0..f2662e2 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -541,7 +541,7 @@ skip:

  #endif

-static int __init populate_rootfs(void)
+int __init populate_rootfs(void)
  {
  	char *err =3D unpack_to_rootfs(__initramfs_start,
  			 __initramfs_end - __initramfs_start, 0);
@@ -582,4 +582,10 @@ static int __init populate_rootfs(void)
  #endif
  	return 0;
  }
+#ifndef CONFIG_ACPI_CUSTOM_DSDT_INITRD
+/*
+ * if this option is enabled, populate_rootfs() is called _earlier_ in=
 the
+ * boot sequence. This insures that the ACPI initialisation can find t=
he file.
+ */
  rootfs_initcall(populate_rootfs);
+#endif
diff --git a/init/main.c b/init/main.c
index f287ca5..7eb1b89 100644
--- a/init/main.c
+++ b/init/main.c
@@ -102,6 +102,12 @@ static inline void mark_rodata_ro(void) { }
  extern void tc_init(void);
  #endif

+#ifdef CONFIG_ACPI_CUSTOM_DSDT_INITRD
+extern int populate_rootfs(void);
+#else
+static inline void populate_rootfs(void) {}
+#endif
+
  enum system_states system_state;
  EXPORT_SYMBOL(system_state);

@@ -643,6 +649,7 @@ asmlinkage void __init start_kernel(void)

  	check_bugs();

+	populate_rootfs(); /* For DSDT override from initramfs */
  	acpi_early_init(); /* before LAPIC and SMP init */

  	/* Do the rest non-__init'ed, we're now alive */
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
