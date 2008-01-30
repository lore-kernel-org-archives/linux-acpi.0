From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH] Override DSDT and SSDTs via initramfs
Date: Wed, 30 Jan 2008 18:27:30 +0100
Message-ID: <1201714051.1222.131.camel@queen.suse.de>
References: <4798E2A5.6020804@users.sf.net>
	 <20080125063328.4e3b4752.akpm@linux-foundation.org>
	 <200801252339.44246.lenb@kernel.org>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:49443 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756988AbYA3R1g (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 30 Jan 2008 12:27:36 -0500
In-Reply-To: <200801252339.44246.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Philippe Coval <rzr@users.sourceforge.net>, linux-acpi@vger.kernel.org, eric@gaugusch.at, dsdt <dsdt@gaugusch.at>

Hi,

you find some comments inlined and the patch which is shipped in
OpenSUSE at the end.

On Fri, 2008-01-25 at 23:39 -0500, Len Brown wrote:
> > > I am annoyed by this missing (or rejected) feature upstream : DSDT
> > >   http://gaugusch.at/kernel.shtml
> > > 
> > > So to use "custom DSDT loading" I have to patch my laptop buggy BIOS
> > > 
> > > As usual, I reported this issue to the vendor (which goes nowhere so far) :
> > >   http://support.fujitsu-siemens.de/forum/viewtopic.php?p=37001
> > > 
> > > Hopefully many distro already include this patch, but not all of them
> > > such as debian :
> > >   http://bugs.debian.org/251023
> > >   http://wiki.debian.org/DebianKernelPatchAcceptanceGuidelines
> > > 
> > > So as a debian contributor, I keep staying on debian and compile my own
> > > kernel
> > >   and provide it to a "amiloa laptop" community I am managing :
> > >   http://tech.groups.yahoo.com/group/amilo/
> > > 
> > > It's ok for me I can live with this,  but what average users have to do
> > > with their (buggy) hardware ?
> > 
> > Philosophically speaking: we sholdn't be making decisions for other people
> > like this.
> > 
> > Practically speaking: the fact that distros are shipping it is a huge
> > indication that the decision was wrong.
IMO, Vista providing a feature to easily override the DSDT via a simple
registry pointer to a modified DSDT, is an argument you cannot come
around...

The purpose of the feature should definitely not be to provide the
possibility to workaround buggy BIOSes, but as done by Vista for
debugging and testing.
 
> > Len?  I think we goofed here.
> 
> Here is the existing supported DSDT override method:
> 
> http://www.lesswatts.org/projects/acpi/overridingDSDT.php
> 
> and at the bottom of that page I point to the alternate initrd
> method and explain why I've not applied it upstream.
> 
> My goal for the Linux/ACPI project is to make Linux
> work out-of-the-box on any system where Windows works.
> 
> Giving "Joe User", who is incapable of compiling
> a kernel, an easy method to override his BIOS image
> makes him more likely to settle for a workaround.
> And that effort undermines, rather than supports, our goal.
> 
> However, Philippe points out that the FSC Amilo box
> also fails the same way under Windows -- and the
> vendor is unwilling or unable to fix their BIOS.
> While Phillippe could build a kernel from source
> and link in a DSDT via the supported developer method above,
> or he could run SuSE or Ubuntu which include the initrd
> patch, he'd prefer to track Debian w/o re-compiling.
> 
> I'm fine with making it more convenient for
> FSC Amilo ownersr to make their laptops work better
> under Linux than under Windows -- even if it is impossible
> for a Linux distro to support the resulting configuration.
> They're otherwise stuck with junk hardware or extra work.
> 
> Also, Thomas continues to assert that this patch
> makes SuSE easier to debug in the field b/c he can convince
> users who are unable to re-compile their kernel
> go ahead and override their BIOS image for debugging
> (bless their trusting hearts;-)
> 
> So at the risk that we're giving "Joe User" more
> than enough rope to hang themselves, lets do it --
> with some strings attached...
> 
> Thomas,
> Since you've been a big supporter of this patch, perhaps you
> can update it and submit it to the list for review?
> 
> I think it needs the following changes:
> 
> 1. tainted bit needs to be set when a DSDT override is used.
>    (this is common both to the new patch and the current
>     override method)
> 
> 2. upon setting the tainted bit, print a BIG FAT WARNING
>    that this is not a supported configuration.
> 
> 3. cmdline option needs to be available to disable
>    an override.  Otherwise a bad image in the intrd
>    may be a serious pickle for some users.
> 
> 4. get rid of alarming failure message:
> 
> +	printk(KERN_INFO "Looking for DSDT in initrd ...");
> ...
> +	printk(" not found!\n");
> 
> Probably it is best to forward the original patch
> w/ proper credits, and then send updates to address 1-4.

I do not know who initially came up with this, I just modified/adjusted
the patch sometimes. I expect it's Markus, possibly Eric or best both
who should be mentioned as author.

The patch should be against a quite recent vanilla kernel, tell me if
you have problems with patching/merging and tell me against which
kernel/git version/tree you like to have it.

Jeff (Mahony) has adjusted the last bits of it when he updated it to the
latest rcX-gitY version:
Changes:
 We no longer call populate_rootfs() twice. If we want the custom DSDT,
 we load the rootfs before ACPI. Otherwise, it is loaded at the
appropriate
 initcall time. -jeffm
 There is a new version at
http://gaugusch.at/acpi-dsdt-initrd-patches/acpi-dsdt-initrd-v0.8.4-2.6.21.patch,
 but there doesn't seem to be any real changes other than elminating the
file
 name array.

In fact, I added the array some time ago.
Not sure whether the latest Version of Eric/Markus can also load several
DSDT/SSDTs? Maybe you found a more elegant way?
This is a quite useful feature (which is not provided by the current
"override via compile into kernel" method). You can add several SSDTs
and let them load before any other table is loaded. Duplicated tables
will be ignored later. Like this you can also override single and
multiple SSDTs easily.

There just need to be files:
/DSDT.aml, /SSDT[1-9]?.aml
in the initrd fs.

If you take this one, please do not forget to mention Eric and Markus as
authors.

    Thomas

-----------------

Override DSDT and SSDTs via initramfs

Searches and reads in the root of initramfs a DSDT.aml and SSDT[1-9]?.aml files.
The found DSDT and SSDTs are loaded into the ACPI namespace prior any BIOS
provided table. Later (BIOS provided) tables with the same signature are ignored
automatically. Like that the BIOS provided tables can be replaced.

Once a table is loaded via initrd, the kernel gets tainted.

More information can be found here: http://gaugusch.at/kernel.shtml


Signed-off-by: Thomas Renninger <trenn@suse.de>

---

 drivers/acpi/Kconfig    |   17 ++++++
 drivers/acpi/osl.c      |  127 ++++++++++++++++++++++++++++++++++++++++++++++--
 include/acpi/acpiosxf.h |    4 +
 init/initramfs.c        |    4 +
 init/main.c             |    9 +++
 5 files changed, 156 insertions(+), 5 deletions(-)

Signed-off-by: Thomas Renninger <trenn@suse.de>
Signed-off-by: Jeff Mahoney <jeffm@suse.com>

--- linux-2.6.24.orig/drivers/acpi/Kconfig
+++ linux-2.6.24/drivers/acpi/Kconfig
@@ -274,6 +274,23 @@ config ACPI_CUSTOM_DSDT_FILE
 	  Enter the full path name to the file which includes the AmlCode
 	  declaration.
 
+config ACPI_CUSTOM_DSDT_INITRD
+	bool "Read Custom DSDT from initramfs"
+	depends on BLK_DEV_INITRD
+	default y
+	help
+	  The DSDT (Differentiated System Description Table) often needs to be
+	  overridden because of broken BIOS implementations. If this feature is
+	  activated you will be able to provide a customized DSDT by adding it
+	  to your initramfs.  For now you need to use a special mkinitrd tool.
+	  For more details see <file:Documentation/dsdt-initrd.txt> or
+	  <http://gaugusch.at/kernel.shtml>. If there is no table found, it
+	  will fallback to the custom DSDT in-kernel (if activated) or to the
+	  DSDT from the BIOS.
+
+	  Even if you do not need a new one at the moment, you may want to use a
+	  better implemented DSDT later. It is safe to say Y here.
+
 config ACPI_BLACKLIST_YEAR
 	int "Disable ACPI for systems before Jan 1st this year" if X86_32
 	default 0
--- linux-2.6.24.orig/drivers/acpi/osl.c
+++ linux-2.6.24/drivers/acpi/osl.c
@@ -68,6 +68,10 @@ EXPORT_SYMBOL(acpi_in_debugger);
 extern char line_buf[80];
 #endif				/*ENABLE_DEBUGGER */
 
+#ifdef CONFIG_ACPI_CUSTOM_DSDT_INITRD
+int acpi_must_unregister_table = FALSE;
+#endif
+
 static unsigned int acpi_irq_irq;
 static acpi_osd_handler acpi_irq_handler;
 static void *acpi_irq_context;
@@ -312,6 +316,113 @@ acpi_os_predefined_override(const struct
 	return AE_OK;
 }
 
+#ifdef CONFIG_ACPI_CUSTOM_DSDT_INITRD
+#define MAX_DS_SDTS 10
+static struct acpi_table_header *ds_sdt_buffers[MAX_DS_SDTS];
+static unsigned int tables_loaded = 0;
+
+void acpi_load_override_tables(void){
+	struct file         *firmware_file;
+	mm_segment_t        oldfs;
+	unsigned long       len, len2;
+	struct kstat        stat;
+	unsigned int        x, y;
+	char *ramfs_ds_sdt_names[MAX_DS_SDTS] = {
+		"/DSDT.aml",
+		"/SSDT.aml",
+		"/SSDT1.aml",
+		"/SSDT2.aml",
+		"/SSDT3.aml",
+		"/SSDT4.aml",
+		"/SSDT5.aml",
+		"/SSDT6.aml",
+		"/SSDT7.aml",
+		"/SSDT8.aml",
+	};
+	/*
+	 * Never do this at home, only the user-space is allowed to open a file.
+	 * The clean way would be to use the firmware loader. But this code must be run
+	 * before there is any userspace available. So we need a static/init firmware
+	 * infrastructure, which doesn't exist yet...
+	 */
+	for (x = 0; x < MAX_DS_SDTS; x++){
+		if (vfs_stat(ramfs_ds_sdt_names[x], &stat) < 0) {
+			continue;
+		}
+		len = stat.size;
+		/* check especially against empty files */
+		if (len <= 4) {
+			printk("error file %s is too small, only %lu bytes.\n",
+			       ramfs_ds_sdt_names[x], len);
+			continue;
+		}
+
+		ds_sdt_buffers[x] = kmalloc(len, GFP_KERNEL);
+		if (!ds_sdt_buffers[x]) {
+			printk("error when allocating %lu bytes of memory.\n",
+			       len);
+			/* better free all tables again */
+			for (y = 0; y < x; y++){
+				if (ds_sdt_buffers[y])
+					kfree(ds_sdt_buffers[x]);
+			}
+			acpi_must_unregister_table = FALSE;
+			return;
+		}
+
+		firmware_file = filp_open(ramfs_ds_sdt_names[x], O_RDONLY, 0);
+		if (IS_ERR(firmware_file)) {
+			printk("error, could not open file %s.\n",
+			       ramfs_ds_sdt_names[x]);
+			kfree(ds_sdt_buffers[x]);
+			continue;
+		}
+
+		oldfs = get_fs();
+		set_fs(KERNEL_DS);
+		len2 = vfs_read(firmware_file,
+				(char __user *)ds_sdt_buffers[x],
+				len,
+				&firmware_file->f_pos);
+		set_fs(oldfs);
+		filp_close(firmware_file, NULL);
+		if (len2 < len) {
+			printk("error trying to read %lu bytes from %s.\n",
+			       len, ramfs_ds_sdt_names[x]);
+			kfree(ds_sdt_buffers[x]);
+			continue;
+		}
+		printk(PREFIX "successfully read %lu bytes from file %s\n",
+		       len, ramfs_ds_sdt_names[x]);
+	}
+}
+
+struct acpi_table_header * acpi_find_dsdt_initrd(struct acpi_table_header * t)
+{
+	struct acpi_table_header	*ret = NULL;
+	unsigned int                     x;
+	for (x = 0; x < MAX_DS_SDTS; x++){
+		if (ds_sdt_buffers[x]){
+			if (!memcmp(ds_sdt_buffers[x]->signature,
+				    t->signature, 4) &&
+			    !memcmp(ds_sdt_buffers[x]->oem_table_id,
+				    t->oem_table_id, 8)){
+				ret = ds_sdt_buffers[x];
+				printk(PREFIX "Override [%4.4s-%8.8s]"
+				       " from initramfs -"
+				       " tainting kernel\n",
+				       t->signature,
+				       t->oem_table_id);
+				add_taint(TAINT_NO_SUPPORT);
+				acpi_must_unregister_table = TRUE;
+				break;
+			}
+		}
+	}
+	return ret;
+}
+#endif
+
 acpi_status
 acpi_os_table_override(struct acpi_table_header * existing_table,
 		       struct acpi_table_header ** new_table)
@@ -319,13 +430,21 @@ acpi_os_table_override(struct acpi_table
 	if (!existing_table || !new_table)
 		return AE_BAD_PARAMETER;
 
+	*new_table = NULL;
+
 #ifdef CONFIG_ACPI_CUSTOM_DSDT
 	if (strncmp(existing_table->signature, "DSDT", 4) == 0)
 		*new_table = (struct acpi_table_header *)AmlCode;
-	else
-		*new_table = NULL;
-#else
-	*new_table = NULL;
+#endif
+#ifdef CONFIG_ACPI_CUSTOM_DSDT_INITRD
+	if (!tables_loaded){
+		acpi_load_override_tables();
+		tables_loaded = 1;
+	}
+	if (!strncmp(existing_table->signature, "DSDT", 4) ||
+	    !strncmp(existing_table->signature, "SSDT", 4)){
+		*new_table = acpi_find_dsdt_initrd(existing_table);
+	}
 #endif
 	return AE_OK;
 }
--- linux-2.6.24.orig/include/acpi/acpiosxf.h
+++ linux-2.6.24/include/acpi/acpiosxf.h
@@ -95,6 +95,10 @@ acpi_status
 acpi_os_table_override(struct acpi_table_header *existing_table,
 		       struct acpi_table_header **new_table);
 
+#ifdef CONFIG_ACPI_CUSTOM_DSDT_INITRD
+extern int acpi_must_unregister_table;
+#endif
+
 /*
  * Spinlock primitives
  */
--- linux-2.6.24.orig/init/initramfs.c
+++ linux-2.6.24/init/initramfs.c
@@ -541,7 +541,7 @@ skip:
 
 #endif
 
-static int __init populate_rootfs(void)
+int __init populate_rootfs(void)
 {
 	char *err = unpack_to_rootfs(__initramfs_start,
 			 __initramfs_end - __initramfs_start, 0);
@@ -582,4 +582,6 @@ static int __init populate_rootfs(void)
 #endif
 	return 0;
 }
+#ifndef CONFIG_ACPI_CUSTOM_DSDT_INITRD
 rootfs_initcall(populate_rootfs);
+#endif
--- linux-2.6.24.orig/init/main.c
+++ linux-2.6.24/init/main.c
@@ -102,6 +102,12 @@ static inline void mark_rodata_ro(void) 
 extern void tc_init(void);
 #endif
 
+#ifdef CONFIG_BLK_DEV_INITRD
+extern int populate_rootfs(void);
+#else
+static inline void populate_rootfs(void) {}
+#endif
+
 enum system_states system_state;
 EXPORT_SYMBOL(system_state);
 
@@ -642,6 +648,9 @@ asmlinkage void __init start_kernel(void
 
 	check_bugs();
 
+#ifdef CONFIG_ACPI_CUSTOM_DSDT_INITRD
+	populate_rootfs(); /* For DSDT override from initramfs */
+#endif
 	acpi_early_init(); /* before LAPIC and SMP init */
 
 	/* Do the rest non-__init'ed, we're now alive */


