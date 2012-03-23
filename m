From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH] ACPI: Implement overriding of arbitrary ACPI tables via initrd
Date: Fri, 23 Mar 2012 13:54:12 -0700
Message-ID: <CAE9FiQVFd=Zef2bH_3MinLEV_V+cEShrmRTe7Sr8HT2R46yHHw@mail.gmail.com>
References: <1332512984-79664-1-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:49598 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754981Ab2CWUyN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 23 Mar 2012 16:54:13 -0400
In-Reply-To: <1332512984-79664-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: eric.piel@tremplin-utc.net, vojcek@tlen.pl, dsdt@gaugusch.at, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, Lin Ming <ming.m.lin@intel.com>, lenb@kernel.org, robert.moore@intel.com, hpa@zytor.com

On Fri, Mar 23, 2012 at 7:29 AM, Thomas Renninger <trenn@suse.de> wrote=
:
> Details can be found in:
> Documentation/acpi/initrd_table_override.txt
>
> Additional dmesg output of a booted system with
> FACP (FADT), DSDT and SSDT (the 9th dynamically loaded one)
> tables overridden (with ### marked comments):
>
> ### ACPI tables found glued to initrd
> DSDT ACPI table found in initrd - size: 16234
> FACP ACPI table found in initrd - size: 116
> SSDT ACPI table found in initrd - size: 334
> ### Re-printed e820 map via e820_update() with additionally created
> ### ACPI data section at 0xcff55000 where the ACPI tables passed via
> ### initrd where copied to
> modified physical RAM map:
> ...
> =A0### New ACPI data section:
> =A0modified: 00000000cff55000 - 00000000cff5912c (ACPI data)
> =A0### BIOS e820 provided ACPI data section:
> =A0modified: 00000000cff60000 - 00000000cff69000 (ACPI data)
> ...
> ### Total size of all ACPI tables glued to initrd
> ### The address is initrd_start which gets updated to
> ### initrd_start =3D initrd_start + "size of all ACPI tables glued to=
 initrd"
> Found acpi tables of size: 16684 at 0xffff8800374c4000
>
> Disabling lock debugging due to kernel taint
> ### initrd provided FACP and DSDT tables are used instead of BIOS pro=
vided ones
> ACPI: FACP @ 0x00000000cff68dd8 Phys table override, replaced with:
> ACPI: FACP 00000000cff58f6a 00074 (v01 INTEL =A0TUMWATER 06040000 PTL=
 =A000000003)
> ACPI: DSDT @ 0x00000000cff649d4 Phys table override, replaced with:
> ACPI: DSDT 00000000cff55000 04404 (v01 =A0Intel BLAKFORD 06040000 MSF=
T 0100000E)
> ...
> ### Much later, the 9th (/sys/firmware/acpi/table/dynamic/SSDT9) dyna=
mically
> ### loaded ACPI table matches and gets overridden:
> ACPI: SSDT @ 0x00000000cff64824 Phys table override, replaced with:
> ACPI: SSDT 00000000cff58fde 0014E (v01 =A0PmRef =A0Cpu7Ist 00003000 I=
NTL 20110316)
> ACPI: Dynamic OEM Table Load:
> ACPI: SSDT =A0 =A0 =A0 =A0 =A0 (null) 0014E (v01 =A0PmRef =A0Cpu7Ist =
00003000 INTL 20110316)
> ...
>
> If the initrd does not start with a valid ACPI table signature or the=
 ACPI
> table's checksum is wrong, there is no functional change.

great. that is very good feature for development and debug.

will not need to ask for testbios ...

>
> Signed-off-by: Thomas Renninger <trenn@suse.de>
> CC: linux-acpi@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> CC: x86@kernel.org
> CC: Lin Ming <ming.m.lin@intel.com>
> CC: lenb@kernel.org
> CC: robert.moore@intel.com
> CC: hpa@zytor.com
> ---
> =A0Documentation/acpi/initrd_table_override.txt | =A0110 ++++++++++++=
+++++++
> =A0arch/x86/kernel/setup.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 18 ++-
> =A0arch/x86/mm/init.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0 =A06 +
> =A0drivers/acpi/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0 10 ++
> =A0drivers/acpi/osl.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0152 +++++++++++++++++++++++++-
> =A0include/linux/acpi.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0 =A04 +
> =A0include/linux/initrd.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0 =A03 +
> =A07 files changed, 294 insertions(+), 9 deletions(-)
> =A0create mode 100644 Documentation/acpi/initrd_table_override.txt
>
> diff --git a/Documentation/acpi/initrd_table_override.txt b/Documenta=
tion/acpi/initrd_table_override.txt
> new file mode 100644
> index 0000000..7b29d5f
> --- /dev/null
> +++ b/Documentation/acpi/initrd_table_override.txt
> @@ -0,0 +1,110 @@
> +Overriding ACPI tables via initrd
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +1) Introduction (What is this about)
> +2) What is this for
> +3) How does it work
> +4) References (Where to retrieve userspace tools)
> +
> +1) What is this about
> +---------------------
> +
> +If ACPI_INITRD_TABLE_OVERRIDE compile option is true, it is possible=
 to
> +override nearly any ACPI table provided by the BIOS with an instrume=
nted,
> +modified one.
> +
> +Up to 10 arbitrary ACPI tables can be passed.
> +For a full list of ACPI tables that can be overridden, take a look a=
t
> +the char *table_sigs[MAX_ACPI_SIGNATURE]; definition in drivers/acpi=
/osl.c
> +All ACPI tables iasl (Intel's ACPI compiler and disassembler) knows =
should
> +be overridable, except:
> + =A0 - ACPI_SIG_RSDP (has a signature of 6 bytes)
> + =A0 - ACPI_SIG_FACS (does not have an ordinary ACPI table header)
> +Both could get implemented as well.
> +
> +
> +2) What is this for
> +-------------------
> +
> +Please keep in mind that this is a debug option.
> +ACPI tables should not get overridden for productive use.
> +If BIOS ACPI tables are overridden the kernel will get tainted with =
the
> +TAINT_OVERRIDDEN_ACPI_TABLE flag.
> +Complain to your platform/BIOS vendor if you find a bug which is tha=
t sever
> +that a workaround is not accepted in the Linus kernel.
> +
> +Still, it can and should be enabled in any kernel, because:
> + =A0- There is no functional change with not instrumented initrds
> + =A0- It provides a powerful feature to easily debug and test ACPI B=
IOS table
> + =A0 =A0compatibility with the Linux kernel.
> +
> +Until now it was only possible to override the DSDT by compiling it =
into
> +the kernel. This is a nightmare when trying to work on ACPI related =
bugs
> +and a lot bugs got stuck because of that.
> +Even for people with enough kernel knowledge, building a kernel to t=
ry out
> +things is very time consuming. Also people may have to browse and mo=
dify the
> +ACPI interpreter code to find a possible BIOS bug. With this feature=
, people
> +can correct the ACPI tables and try out quickly whether this is the =
root cause
> +that needs to get addressed in the kernel.
> +
> +This could even ease up testing for BIOS providers who could flush t=
heir BIOS
> +to test, but overriding table via initrd is much easier and quicker.
> +For example one could prepare different initrds overriding NUMA tabl=
es with
> +different affinity settings. Set up a script, let the machine reboot=
 and
> +run tests over night and one can get a picture how these settings in=
fluence
> +the Linux kernel and which values are best.
> +
> +People can instrument the dynamic ACPI (ASL) code (for example with =
debug
> +statements showing up in syslog when the ACPI code is processed, etc=
=2E),
> +to better understand BIOS to OS interfaces, to hunt down ACPI BIOS c=
ode related
> +bugs quickly or to easier develop ACPI based drivers.
> +
> +Intstrumenting ACPI code in SSDTs is now much easier. Before, one ha=
d to copy
> +all SSDTs into the DSDT to compile it into the kernel for testing
> +(because only DSDT could get overridden). That's what the acpi_no_au=
to_ssdt
> +boot param is for: the BIOS provided SSDTs are ignored and all have =
to get
> +copied into the DSDT, complicated and time consuming.
> +
> +Much more use cases, depending on which ACPI parts you are working o=
n...
> +
> +
> +3) How does it work
> +-------------------
> +
> +# Extract the machine's ACPI tables:
> +acpidump >acpidump
> +acpixtract -a acpidump
> +# Disassemble, modify and recompile them:
> +iasl -d *.dat
> +# For example add this statement into a _PRT (PCI Routing Table) fun=
ction
> +# of the DSDT:
> +Store("Hello World", debug)
> +iasl -sa *.dsl
> +# glue them together with the initrd. ACPI tables go first, original=
 initrd
> +# goes on top:
> +cat TBL1.dat >>instrumented_initrd
> +cat TBL2.dat >>instrumented_initrd
> +cat TBL3.dat >>instrumented_initrd
> +cat /boot/initrd >>instrumented_initrd
> +# reboot with increased acpi debug level, e.g. boot params:
> +acpi.debug_level=3D0x2 acpi.debug_layer=3D0xFFFFFFFF
> +# and check your syslog:
> +[ =A0 =A01.268089] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PR=
T]
> +[ =A0 =A01.272091] [ACPI Debug] =A0String [0x0B] "HELLO WORLD"
> +
> +iasl is able to disassemble and recompile quite a lot different,
> +also static ACPI tables.
> +
> +4) Where to retrieve userspace tools
> +------------------------------------
> +
> +iasl and acpixtract are part of Intel's ACPICA project:
> +http://acpica.org/
> +and should be packaged by distributions (for example in the acpica p=
ackage
> +on SUSE).
> +
> +acpidump can be found in Len Browns pmtools:
> +ftp://kernel.org/pub/linux/kernel/people/lenb/acpi/utils/pmtools/acp=
idump
> +This tool is also part of the acpica package on SUSE.
> +Alternatively used ACPI tables can be retrieved via sysfs in latest =
kernels:
> +/sys/firmware/acpi/tables
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index d7d5099..5a5a33f 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -412,12 +412,20 @@ static void __init reserve_initrd(void)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0initrd_start =3D ramdisk_image + PAGE_=
OFFSET;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0initrd_end =3D initrd_start + ramdisk_=
size;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 relocate_initrd();
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 memblock_free(ramdisk_image, ramdisk_en=
d - ramdisk_image);
> =A0 =A0 =A0 =A0}
> -
> - =A0 =A0 =A0 relocate_initrd();
> -
> - =A0 =A0 =A0 memblock_free(ramdisk_image, ramdisk_end - ramdisk_imag=
e);
> +#ifdef CONFIG_ACPI_INITRD_TABLE_OVERRIDE
> + =A0 =A0 =A0 acpi_initrd_offset =3D acpi_initrd_table_override((void=
 *)initrd_start,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (void *)initrd_end);
> + =A0 =A0 =A0 if (!acpi_initrd_offset)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 printk(KERN_INFO "Found acpi tables of size: %lu at 0x%=
lx\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0acpi_initrd_offset, initrd_start);
> + =A0 =A0 =A0 initrd_start +=3D acpi_initrd_offset;
> + =A0 =A0 =A0 return;
> +#endif
> =A0}
> =A0#else
> =A0static void __init reserve_initrd(void)
> diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
> index 6cabf65..8df3fda 100644
> --- a/arch/x86/mm/init.c
> +++ b/arch/x86/mm/init.c
> @@ -391,6 +391,12 @@ void free_initrd_mem(unsigned long start, unsign=
ed long end)
> =A0 =A0 =A0 =A0 * =A0 - relocate_initrd()
> =A0 =A0 =A0 =A0 * So here We can do PAGE_ALIGN() safely to get partia=
l page to be freed
> =A0 =A0 =A0 =A0 */
> +#ifdef CONFIG_ACPI_INITRD_TABLE_OVERRIDE
> + =A0 =A0 =A0 if (acpi_initrd_offset)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_init_pages("initrd memory", start =
- acpi_initrd_offset,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 PAGE_AL=
IGN(end));
> + =A0 =A0 =A0 else
> +#endif

table already get copied to allocated ram, So you don't need to keep
the portion in initrd range.

> =A0 =A0 =A0 =A0free_init_pages("initrd memory", start, PAGE_ALIGN(end=
));
> =A0}
> =A0#endif
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 7556913..7113327 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -261,6 +261,16 @@ config ACPI_CUSTOM_DSDT
> =A0 =A0 =A0 =A0bool
> =A0 =A0 =A0 =A0default ACPI_CUSTOM_DSDT_FILE !=3D ""
>
> +config ACPI_INITRD_TABLE_OVERRIDE
> + =A0 =A0 =A0 bool
> + =A0 =A0 =A0 depends on X86
> + =A0 =A0 =A0 default y
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 This option provides functionality to override arbi=
trary ACPI tables
> + =A0 =A0 =A0 =A0 via initrd. No functional change if no ACPI tables =
are glued to the
> + =A0 =A0 =A0 =A0 initrd, therefore it's safe to say Y.
> + =A0 =A0 =A0 =A0 See Documentation/acpi/initrd_table_override.txt fo=
r details
> +
> =A0config ACPI_BLACKLIST_YEAR
> =A0 =A0 =A0 =A0int "Disable ACPI for systems before Jan 1st this year=
" if X86_32
> =A0 =A0 =A0 =A0default 0
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index ad92131..a78b6f6 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -45,6 +45,7 @@
> =A0#include <linux/list.h>
> =A0#include <linux/jiffies.h>
> =A0#include <linux/semaphore.h>
> +#include <linux/memblock.h>
>
> =A0#include <asm/io.h>
> =A0#include <asm/uaccess.h>
> @@ -534,6 +535,107 @@ acpi_os_predefined_override(const struct acpi_p=
redefined_names *init_val,
> =A0 =A0 =A0 =A0return AE_OK;
> =A0}
>
> +#ifdef CONFIG_ACPI_INITRD_TABLE_OVERRIDE
> +#include <asm/e820.h>
> +
> +#define ACPI_OVERRIDE_TABLES 10
> +
> +static unsigned long acpi_table_override_offset[ACPI_OVERRIDE_TABLES=
];
> +static u64 acpi_tables_inram;
> +
> +unsigned long acpi_initrd_offset;
> +
> +/* Copied from acpica/tbutils.c:acpi_tb_checksum() */
> +u8 __init acpi_table_checksum(u8 *buffer, u32 length)
> +{
> + =A0 =A0 =A0 u8 sum =3D 0;
> + =A0 =A0 =A0 u8 *end =3D buffer + length;
> +
> + =A0 =A0 =A0 while (buffer < end)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sum =3D (u8) (sum + *(buffer++));
> + =A0 =A0 =A0 return sum;
> +}
> +
> +/* All but ACPI_SIG_RSDP and ACPI_SIG_FACS: */
> +#define MAX_ACPI_SIGNATURE 35
> +static const char *table_sigs[MAX_ACPI_SIGNATURE] =3D {
> + =A0 =A0 =A0 ACPI_SIG_BERT, ACPI_SIG_CPEP, ACPI_SIG_ECDT, ACPI_SIG_E=
INJ,
> + =A0 =A0 =A0 ACPI_SIG_ERST, ACPI_SIG_HEST, ACPI_SIG_MADT, ACPI_SIG_M=
SCT,
> + =A0 =A0 =A0 ACPI_SIG_SBST, ACPI_SIG_SLIT, ACPI_SIG_SRAT, ACPI_SIG_A=
SF,
> + =A0 =A0 =A0 ACPI_SIG_BOOT, ACPI_SIG_DBGP, ACPI_SIG_DMAR, ACPI_SIG_H=
PET,
> + =A0 =A0 =A0 ACPI_SIG_IBFT, ACPI_SIG_IVRS, ACPI_SIG_MCFG, ACPI_SIG_M=
CHI,
> + =A0 =A0 =A0 ACPI_SIG_SLIC, ACPI_SIG_SPCR, ACPI_SIG_SPMI, ACPI_SIG_T=
CPA,
> + =A0 =A0 =A0 ACPI_SIG_UEFI, ACPI_SIG_WAET, ACPI_SIG_WDAT, ACPI_SIG_W=
DDT,
> + =A0 =A0 =A0 ACPI_SIG_WDRT, ACPI_SIG_DSDT, ACPI_SIG_FADT, ACPI_SIG_P=
SDT,
> + =A0 =A0 =A0 ACPI_SIG_RSDT, ACPI_SIG_XSDT, ACPI_SIG_SSDT };
> +
> +int __init acpi_initrd_table_override(void *start_addr, void *end_ad=
dr)
> +{
> + =A0 =A0 =A0 int table_nr, sig;
> + =A0 =A0 =A0 unsigned long offset =3D 0, max_len =3D end_addr - star=
t_addr;
> + =A0 =A0 =A0 char *p;
> +
> + =A0 =A0 =A0 for (table_nr =3D 0; table_nr < ACPI_OVERRIDE_TABLES; t=
able_nr++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct acpi_table_header *table;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (max_len < offset + sizeof(struct ac=
pi_table_header)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 WARN_ON(1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 table =3D start_addr + offset;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (sig =3D 0; sig < MAX_ACPI_SIGNATUR=
E; sig++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!memcmp(table->sign=
ature, table_sigs[sig], 4))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (sig >=3D MAX_ACPI_SIGNATURE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (max_len < offset + table->length) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 WARN_ON(1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (acpi_table_checksum(start_addr + of=
fset, table->length)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 WARN(1, "%4.4s has inva=
lid checksum\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0table->signa=
ture);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO "%4.4s ACPI table foun=
d in initrd"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0" - size: %d\n", table->=
signature, table->length);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 offset +=3D table->length;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 acpi_table_override_offset[table_nr] =3D=
 offset;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (!offset)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 acpi_tables_inram =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 memblock_find_in_range(0, max_low_pfn_m=
apped << PAGE_SHIFT,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0offset, PAGE_SIZE);

please don't use max_low_pfn_mapped. that will leave another blocker
to allocate kdump block with 512M.

could use max_low_pfn, and use io_remap to access it for copying purpos=
e.



> + =A0 =A0 =A0 if (!acpi_tables_inram)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 panic("Cannot find place for ACPI overr=
ide tables\n");
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Only calling e820_add_reserve does not work and th=
e
> + =A0 =A0 =A0 =A0* tables are invalid (memory got used) later.
> + =A0 =A0 =A0 =A0* memblock_x86_reserve_range works as expected and t=
he tables
> + =A0 =A0 =A0 =A0* won't get modified. But it's not enough because io=
remap will
> + =A0 =A0 =A0 =A0* complain later (used by acpi_os_map_memory) that t=
he pages
> + =A0 =A0 =A0 =A0* that should get mapped are not marked "reserved".
> + =A0 =A0 =A0 =A0* Both memblock_x86_reserve_range and e820_add_regio=
n works fine.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 memblock_reserve(acpi_tables_inram, acpi_tables_inram +=
 offset);
> + =A0 =A0 =A0 e820_add_region(acpi_tables_inram, offset, E820_ACPI);
> + =A0 =A0 =A0 update_e820();

could use __weak function to avoid use e820 related calling here in osl=
=2Ec

> +
> + =A0 =A0 =A0 p =3D early_ioremap(acpi_tables_inram, offset);
> + =A0 =A0 =A0 memcpy(p, start_addr, offset);
> + =A0 =A0 =A0 early_iounmap(p, offset);
> + =A0 =A0 =A0 return offset;
> +}
> +
> +#endif
> +
> =A0acpi_status
> =A0acpi_os_table_override(struct acpi_table_header * existing_table,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct acpi_table_header =
** new_table)
> @@ -559,12 +661,54 @@ acpi_os_table_override(struct acpi_table_header=
 * existing_table,
>
> =A0acpi_status
> =A0acpi_os_physical_table_override(struct acpi_table_header *existing=
_table,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 acpi_ph=
ysical_address * new_address,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 *ne=
w_table_length)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 acpi_ph=
ysical_address *address,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 *ta=
ble_length)
> =A0{
> - =A0 =A0 =A0 return AE_SUPPORT;
> -}
> +#ifndef CONFIG_ACPI_INITRD_TABLE_OVERRIDE
> + =A0 =A0 =A0 *table_length =3D 0;
> + =A0 =A0 =A0 *address =3D 0;
> + =A0 =A0 =A0 return AE_OK;
> +#endif
> +
> + =A0 =A0 =A0 int table_nr =3D 0;
> + =A0 =A0 =A0 *table_length =3D 0;
> + =A0 =A0 =A0 *address =3D 0;
> + =A0 =A0 =A0 for (; table_nr < ACPI_OVERRIDE_TABLES &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0acpi_table_override_offset[t=
able_nr]; table_nr++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int table_offset;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int table_len;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct acpi_table_header *table;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (table_nr =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 table_offset =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 table_offset =3D acpi_t=
able_override_offset[table_nr - 1];
>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 table_len =3D acpi_table_override_offse=
t[table_nr] - table_offset;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 table =3D acpi_os_map_memory(acpi_table=
s_inram + table_offset,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0table_len);
> +

maybe could have dmi checking for more strict checking.

also would help if have one boot command that could skip overriding.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (memcmp(existing_table->signature, t=
able->signature, 4)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 acpi_os_unmap_memory(ta=
ble, table_len);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Only override tables with matching o=
em id */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (memcmp(table->oem_table_id, existin=
g_table->oem_table_id,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ACPI_OEM_TABLE_I=
D_SIZE)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 acpi_os_unmap_memory(ta=
ble, table_len);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 acpi_os_unmap_memory(table, table_len);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *address =3D acpi_tables_inram + table_=
offset;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *table_length =3D table_len;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 add_taint(TAINT_OVERRIDDEN_ACPI_TABLE);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return AE_OK;
> +}
>
> =A0static irqreturn_t acpi_irq(int irq, void *dev_id)
> =A0{
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 104eda7..12bda6a 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -76,6 +76,10 @@ typedef int (*acpi_table_handler) (struct acpi_tab=
le_header *table);
>
> =A0typedef int (*acpi_table_entry_handler) (struct acpi_subtable_head=
er *header, const unsigned long end);
>
> +#ifdef CONFIG_ACPI_INITRD_TABLE_OVERRIDE
> +int __init acpi_initrd_table_override(void *start_addr, void *end_ad=
dr);

> +#endif

if you have
#else
static inline int __init acpi_initrd_table_override(void *start_addr,
void *end_addr) { return 0 }
#endif

here, you can avoid one #ifdef in .c

Thanks

Yinghai
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
