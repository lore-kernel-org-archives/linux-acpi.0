From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 1/3] The basics of DSDT from initramfs
Date: Tue, 05 Feb 2008 15:43:48 +0100
Message-ID: <1202222629.14573.257.camel@queen.suse.de>
References: <4798E2A5.6020804@users.sf.net>
	 <200801311417.57469.lenb@kernel.org>
	 <1201859637.14573.41.camel@queen.suse.de>
	 <200802012336.10687.lenb@kernel.org>  <47A5F9C7.70402@tremplin-utc.net>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:47543 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750708AbYBEOnw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 5 Feb 2008 09:43:52 -0500
In-Reply-To: <47A5F9C7.70402@tremplin-utc.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?ISO-8859-1?Q?=C9ric?= Piel <Eric.Piel@tremplin-utc.net>
Cc: Len Brown <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Philippe Coval <rzr@users.sourceforge.net>, linux-acpi@vger.kernel.org, dsdt <dsdt@gaugusch.at>

Hi Eric,

nice. Some minor comments below...

On Sun, 2008-02-03 at 18:28 +0100, =C3=89ric Piel wrote:
> The basics of DSDT from initramfs. In case this option is selected,
> populate_rootfs() is called a bit earlier to have the initramfs conte=
nt
> available during ACPI initialisation.
>=20
> This is a very similar path to the one available at
> http://gaugusch.at/kernel.shtml but with some update in the
> documentation, default set to No and the change of populate_rootfs() =
the
> "Jeff Mahony way" (which avoids reading the initramfs twice).
>=20
> Signed-off-by: Eric Piel <eric.piel@tremplin-utc.net>
>=20
> ---
>   Documentation/dsdt-initrd.txt |  100 ++++++++++++++++++++++++++++++=
+++++++++++
>   drivers/acpi/Kconfig          |   17 +++++++
>   drivers/acpi/osl.c            |   73 ++++++++++++++++++++++++++++--
>   init/initramfs.c              |    8 +++-
>   init/main.c                   |    7 +++
>   5 files changed, 200 insertions(+), 5 deletions(-)
>   create mode 100644 Documentation/dsdt-initrd.txt
>=20
> diff --git a/Documentation/dsdt-initrd.txt b/Documentation/dsdt-initr=
d.txt
> new file mode 100644
> index 0000000..b2e9460
> --- /dev/null
> +++ b/Documentation/dsdt-initrd.txt
> @@ -0,0 +1,100 @@
> +ACPI Custom DSDT read from initramfs
> +
> +2003 by Markuss Gaugusch < dsdt at gaugusch dot org >
> +Special thanks go to Thomas Renninger from SuSE, who updated the pat=
ch for
> +2.6.0 and later modified it to read inside initramfs
> +2004 - 2008 maintained by Eric Piel < eric dot piel at tremplin-utc =
dot net >
> +
> +This option is intended for people who would like to hack their DSDT=
 and don't
> +want to recompile their kernel after every change. It can also be us=
eful to
> +distros which offers pre-compiled kernels and want to allow their us=
ers to use
> +a modified DSDT. In the Kernel config, enable the initial RAM filesy=
stem
> +support (in General Setup) and enable ACPI_CUSTOM_DSDT_INITRD at the=
 ACPI
> +options (General Setup|ACPI Support|Read Custom DSDT from initramfs)=
=2E
> +
> +A custom DSDT (Differentiated System Description Table) is useful wh=
en your
> +computer uses ACPI but problems occur due to broken implementation. =
Typically,
> +your computer works but there are some troubles with the hardware de=
tection or
> +the power management. You can check that troubles come from errors i=
n the DSDT by
> +activating the ACPI debug option and reading the logs. This table is=
 provided
> +by the BIOS, therefore it might be a good idea to check for BIOS upd=
ate on your
> +vendor website before going any further. Errors are often caused by =
vendors
> +testing their hardware only with Windows or because there is code wh=
ich is
> +executed only on a specific OS with a specific version and Linux has=
n't been
> +considered during the development.
> +
> +Before you run away from customising your DSDT, you should note that=
 already
> +corrected tables are available for a fair amount of computers on thi=
s web-page:
> +http://acpi.sf.net/dsdt . Be careful though, to work correctly a DSD=
T has to
> +match closely the hardware, including the amount of RAM, the frequen=
cy of the
> +processor and the PCI cards present! If you are part of the unluckie=
s who
> +cannot find their hardware in this database, you can modify your DSD=
T by
> +yourself. This process is less painful than it sounds. Download the =
Intel ASL
> +compiler/decompiler at http://www.intel.com/technology/IAPC/acpi/dow=
nloads.htm .
AFAIK Intel wants to move away from this address.
There should have been an opensource project for the ACPICA code
started, we should reference this one instead. Len?

> +As root, you then have to dump your DSDT and decompile it. By using =
the
> +compiler messages as well as the kernel ACPI debug messages and the =
reference
> +book (available at the Intel website and also at http://www.acpi.inf=
o), it is
> +quite easy to obtain a fully working table.
Hmm, IMO this sentence should not go in, but instead a reference to:
Something like: You can learn how to extract your BIOS ACPI tables,
disassemble, modify and recompile them here:
http://www.lesswatts.org/projects/acpi/overridingDSDT.php
(which then still needs to be updated).

> +Once your new DSDT is ready you'll have to add it to an initramfs so=
 that the
> +kernel can read the table at the very beginning of the boot. As the =
file has to
> +be accessed very early during the boot process the initramfs has to =
be an
> +initramfs. The file is contained into the initramfs under the name /=
DSDT.aml .
So this patch is still using /DSDT.aml...
> +To obtain such an initramfs, you might have to modify your initramfs=
 script or
> +you can add it later to the initramfs with the script appended to th=
is
> +document. The command will look like:
> +initramfs-add-dsdt initramfs.img my-dsdt.aml
> +
> +In case you don't use any initramfs, the possibilities you have are =
to either
> +start using one (try mkinitrd or yaird), or use the "Include Custom =
DSDT"
> +configure option to directly include your DSDT inside the kernel.
> +
> +The message "Looking for DSDT in initramfs..."
Removing this was point 4. of Len's wish list.
IMO it can stay, but I don't really care.

> will tell you if the DSDT was
> +found or not. If you need to update your DSDT, generate a new initra=
mfs and
> +perform the steps above. Don't forget that with Lilo, you'll have to=
 re-run it.
> +
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D H=
ere starts initramfs-add-dsdt =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +#!/bin/bash
> +# Adds a DSDT file to the initrd (if it's an initramfs)
> +# first argument is the name of archive
> +# second argument is the name of the file to add
> +# The file will be copied as /DSDT.aml
> +
> +# 20060126: fix "Premature end of file" with some old cpio (Roland R=
obic)
> +# 20060205: this time it should really work
> +
> +# check the arguments
> +if [ $# -ne 2 ]; then
> +	program_name=3D$(basename $0)
> +	echo "\
> +$program_name: too few arguments
> +Usage: $program_name initrd-name.img DSDT-to-add.aml
> +Adds a DSDT file to an initrd (in initramfs format)
> +
> +  initrd-name.img: filename of the initrd in initramfs format
> +  DSDT-to-add.aml: filename of the DSDT file to add
> +  " 1>&2
> +    exit 1
> +fi
> +
> +# we should check it's an initramfs
> +
> +tempcpio=3D$(mktemp -d)
> +# cleanup on exit, hangup, interrupt, quit, termination
> +trap 'rm -rf $tempcpio' 0 1 2 3 15
> +
> +# extract the archive
> +gunzip -c "$1" > "$tempcpio"/initramfs.cpio || exit 1
> +
> +# copy the DSDT file at the root of the directory so that we can cal=
l it "/DSDT.aml"
> +cp -f "$2" "$tempcpio"/DSDT.aml
DSDT.aml...
> +
> +# add the file
> +cd "$tempcpio"
> +(echo DSDT.aml | cpio --quiet -H newc -o -A -O "$tempcpio"/initramfs=
=2Ecpio) || exit 1
> +cd "$OLDPWD"
> +
> +# re-compress the archive
> +gzip -c "$tempcpio"/initramfs.cpio > "$1"
> +
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index ccf6ea9..8607ed3 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -274,6 +274,23 @@ config ACPI_CUSTOM_DSDT_FILE
>   	  Enter the full path name to the file which includes the AmlCode
>   	  declaration.
>=20
> +config ACPI_CUSTOM_DSDT_INITRD
> +	bool "Read Custom DSDT from initramfs"
> +	depends on BLK_DEV_INITRD
> +	default n
> +	help
> +	  The DSDT (Differentiated System Description Table) often needs to=
 be
> +	  overridden because of broken BIOS implementations. If this featur=
e is
> +	  activated you will be able to provide a customized DSDT by adding=
 it
> +	  to your initramfs. If your mkinitrd tool does not support this fe=
ature
> +	  a script is provided in the documentation. For more details see
> +	  <file:Documentation/dsdt-initrd.txt> or <http://gaugusch.at/kerne=
l.shtml>.
> +	  If there is no table found, it will fall-back to the custom DSDT
> +	  in-kernel (if activated) or to the DSDT from the BIOS.
> +
> +	  Even if you do not need a new one at the moment, you may want to =
use a
> +	  better DSDT later. It is safe to say Y here.
This one should be rephrased. Don't invite all users to modify or use
foreign DSDTs just for little improvements.
I think the main goal of this patch should be debugging/testing
purposes.
Better phrase it like:
If you have problems with ACPI on your machine and you have fixed it up
by modifying the DSDT, don't override the DSDT as a long term solution.
E.g. if you add new memory to your machine, it will invalidate the
modified DSDT (BIOS would generate a slightly adjusted one).
Always report bugs in a DSDT to bugzilla.kernel.org and assign it to th=
e
ACPI component.
Overriding of the DSDT is mainly thought for developing/testing
purposes!

> +
>   config ACPI_BLACKLIST_YEAR
>   	int "Disable ACPI for systems before Jan 1st this year" if X86_32
>   	default 0
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index e53fb51..4568a59 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -312,6 +312,66 @@ acpi_os_predefined_override(const struct acpi_pr=
edefined_names *init_val,
>   	return AE_OK;
>   }
>=20
> +#ifdef CONFIG_ACPI_CUSTOM_DSDT_INITRD
> +struct acpi_table_header *acpi_find_dsdt_initrd(void)
> +{
> +	struct file *firmware_file;
> +	mm_segment_t oldfs;
> +	unsigned long len, len2;
> +	struct acpi_table_header *dsdt_buffer, *ret =3D NULL;
> +	struct kstat stat;
> +	char *ramfs_dsdt_name =3D "/DSDT.aml";
DSDT.aml
> +
> +	printk(KERN_INFO PREFIX "Looking for DSDT in initramfs... ");
> +
> +	/*
> +	 * Never do this at home, only the user-space is allowed to open a =
file.
> +	 * The clean way would be to use the firmware loader. But this code=
 must be run
> +	 * before there is any userspace available. So we need a static/ini=
t firmware
> +	 * infrastructure, which doesn't exist yet...
> +	 */
> +	if (vfs_stat(ramfs_dsdt_name, &stat) < 0) {
> +		printk("not found.\n");
> +		return ret;
> +	}
> +
> +	len =3D stat.size;
> +	/* check especially against empty files */
> +	if (len <=3D 4) {
> +		printk("error, file is too small: only %lu bytes.\n", len);
> +		return ret;
> +	}
> +
> +	firmware_file =3D filp_open(ramfs_dsdt_name, O_RDONLY, 0);
> +	if (IS_ERR(firmware_file)) {
> +		printk("error, could not open file %s.\n", ramfs_dsdt_name);
> +		return ret;
> +	}
> +
> +	dsdt_buffer =3D ACPI_ALLOCATE(len);
> +	if (!dsdt_buffer) {
> +		printk("error when allocating %lu bytes of memory.\n", len);
> +		goto err;
> +	}
> +
> +	oldfs =3D get_fs();
> +	set_fs(KERNEL_DS);
> +	len2 =3D vfs_read(firmware_file, (char __user *)dsdt_buffer, len, &=
firmware_file->f_pos);
> +	set_fs(oldfs);
> +	if (len2 < len) {
> +		printk("error trying to read %lu bytes from %s.\n", len, ramfs_dsd=
t_name);
> +		ACPI_FREE(dsdt_buffer);
> +		goto err;
> +	}
> +
> +	printk("successfully read %lu bytes from %s.\n", len, ramfs_dsdt_na=
me);
> +	ret =3D dsdt_buffer;
> +err:
> +	filp_close(firmware_file, NULL);
> +	return ret;
> +}
> +#endif
> +
>   acpi_status
>   acpi_os_table_override(struct acpi_table_header * existing_table,
>   		       struct acpi_table_header ** new_table)
> @@ -319,13 +379,18 @@ acpi_os_table_override(struct acpi_table_header=
 * existing_table,
>   	if (!existing_table || !new_table)
>   		return AE_BAD_PARAMETER;
>=20
> +	*new_table =3D NULL;
> +
>   #ifdef CONFIG_ACPI_CUSTOM_DSDT
>   	if (strncmp(existing_table->signature, "DSDT", 4) =3D=3D 0)
>   		*new_table =3D (struct acpi_table_header *)AmlCode;
> -	else
> -		*new_table =3D NULL;
> -#else
> -	*new_table =3D NULL;
> +#endif
> +#ifdef CONFIG_ACPI_CUSTOM_DSDT_INITRD
> +	if (strncmp(existing_table->signature, "DSDT", 4) =3D=3D 0) {
> +		struct acpi_table_header *initrd_table =3D acpi_find_dsdt_initrd()=
;
> +		if (initrd_table)
> +			*new_table =3D initrd_table;
> +	}
>   #endif
>   	return AE_OK;
>   }
> diff --git a/init/initramfs.c b/init/initramfs.c
> index 1db02a0..f2662e2 100644
> --- a/init/initramfs.c
> +++ b/init/initramfs.c
> @@ -541,7 +541,7 @@ skip:
>=20
>   #endif
>=20
> -static int __init populate_rootfs(void)
> +int __init populate_rootfs(void)
>   {
>   	char *err =3D unpack_to_rootfs(__initramfs_start,
>   			 __initramfs_end - __initramfs_start, 0);
> @@ -582,4 +582,10 @@ static int __init populate_rootfs(void)
>   #endif
>   	return 0;
>   }
> +#ifndef CONFIG_ACPI_CUSTOM_DSDT_INITRD
> +/*
> + * if this option is enabled, populate_rootfs() is called _earlier_ =
in the
> + * boot sequence. This insures that the ACPI initialisation can find=
 the file.
> + */
>   rootfs_initcall(populate_rootfs);
> +#endif
> diff --git a/init/main.c b/init/main.c
> index f287ca5..7eb1b89 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -102,6 +102,12 @@ static inline void mark_rodata_ro(void) { }
>   extern void tc_init(void);
>   #endif
>=20
> +#ifdef CONFIG_ACPI_CUSTOM_DSDT_INITRD
> +extern int populate_rootfs(void);
> +#else
> +static inline void populate_rootfs(void) {}
> +#endif
> +
>   enum system_states system_state;
>   EXPORT_SYMBOL(system_state);
>=20
> @@ -643,6 +649,7 @@ asmlinkage void __init start_kernel(void)
>=20
>   	check_bugs();
>=20
> +	populate_rootfs(); /* For DSDT override from initramfs */
>   	acpi_early_init(); /* before LAPIC and SMP init */
>=20
>   	/* Do the rest non-__init'ed, we're now alive */

IMO it should go in as it is for now.
It could still be extended on the next rcX cycle. All comments are only
minor enhancements.

About the /DSDT.aml vs. /dsdt/DSDT.aml location:
As said this is for SSDT overrides.
If someone sees (beside the table signature, I think I can
handle/workaround this), why this has no use or not worth to look at it=
,
pls let me know.
Otherwise I will have a look at it (but possibly not that soon...)
I expect it need to be checked then whether /dsdt exists at all, is a
directory and find all files in it.
The advantage to at least change the name now to dsdt/DSDT.aml, would b=
e
to have a consistent naming. If DSDT.aml changes to dsdt/DSDT.aml at
some later time we need to adjust userspace tools and will get userspac=
e
vs kernel version problems.

I test-compiled the patches on various archs and configs, but didn't do
any real DSDT override tests (the patches are in use for quite some
time...). All builds succeeded.

    Thomas

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
