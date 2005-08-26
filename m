From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [patch 1/1] ES7000 broken build for non-ACPI config
Date: Fri, 26 Aug 2005 11:36:12 -0400
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B30046DB0CE@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Natalie.Protasevich-GLv8BlqOqDDQT0dZR+AlfA@public.gmane.org
Cc: akpm-3NddpPZAyC0@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

can't apply this one because in the latest ACPI patch both
CONFIG_ACPI_BOOT and CONFIG_ACPI_INTERPRETER no longer exist.

I'll see if I can sort this out later today.

thanks,
-Len


>-----Original Message-----
>From: Natalie.Protasevich-GLv8BlqOqDDQT0dZR+AlfA@public.gmane.org=20
>[mailto:Natalie.Protasevich-GLv8BlqOqDDQT0dZR+AlfA@public.gmane.org]=20
>Sent: Thursday, August 25, 2005 7:06 AM
>To: Brown, Len
>Cc: akpm-3NddpPZAyC0@public.gmane.org; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org;=20
>Natalie.Protasevich-GLv8BlqOqDDQT0dZR+AlfA@public.gmane.org
>Subject: [patch 1/1] ES7000 broken build for non-ACPI config
>
>Added #ifdefs in several places for items meant for ACPI boot only.
>Moved es7000_plat global var outside of CONFIG_ACPI_BOOT scope, so it's
>available for non-ACPI build.
>
>Signed-off-by: <Natalie.Protasevich-GLv8BlqOqDDQT0dZR+AlfA@public.gmane.org>
>
>---
>
> arch/i386/kernel/mpparse.c                  |    4 ++--
> arch/i386/mach-es7000/es7000.h              |    2 ++
> arch/i386/mach-es7000/es7000plat.c          |    6 ++----
> include/asm-i386/mach-es7000/mach_mpparse.h |    4 ++++
> 4 files changed, 10 insertions(+), 6 deletions(-)
>
>diff -puN arch/i386/mach-es7000/es7000.h~build-fix-1=20
>arch/i386/mach-es7000/es7000.h
>---=20
>linux-2.6.13-rc6/arch/i386/mach-es7000/es7000.h~build-fix-1=09
>2005-08-25 00:57:54.998988192 -0700
>+++ linux-2.6.13-rc6-root/arch/i386/mach-es7000/es7000.h=09
>2005-08-25 00:58:39.812175552 -0700
>@@ -74,6 +74,7 @@ struct es7000_oem_table {
> 	struct psai psai;
> };
>=20
>+#ifdef CONFIG_ACPI_BOOT
> struct acpi_table_sdt {
> 	unsigned long pa;
> 	unsigned long count;
>@@ -89,6 +90,7 @@ struct oem_table {
> 	u32 OEMTableAddr;
> 	u32 OEMTableSize;
> };
>+#endif
>=20
> struct mip_reg {
> 	unsigned long long off_0;
>diff -puN arch/i386/mach-es7000/es7000plat.c~build-fix-1=20
>arch/i386/mach-es7000/es7000plat.c
>---=20
>linux-2.6.13-rc6/arch/i386/mach-es7000/es7000plat.c~buil
>d-fix-1	2005-08-25 00:57:55.033982872 -0700
>+++ linux-2.6.13-rc6-root/arch/i386/mach-es7000/es7000plat.c=09
>2005-08-25 00:59:26.518075176 -0700
>@@ -51,8 +51,6 @@ struct mip_reg		*host_reg;
> int 			mip_port;
> unsigned long		mip_addr, host_addr;
>=20
>-#if defined(CONFIG_X86_IO_APIC) &&=20
>(defined(CONFIG_ACPI_INTERPRETER) || defined(CONFIG_ACPI_BOOT))
>-
> /*
>  * GSI override for ES7000 platforms.
>  */
>@@ -73,8 +71,6 @@ es7000_rename_gsi(int ioapic, int gsi)
> 	return gsi;
> }
>=20
>-#endif // (CONFIG_X86_IO_APIC) && (CONFIG_ACPI_INTERPRETER ||=20
>CONFIG_ACPI_BOOT)
>-
> /*
>  * Parse the OEM Table
>  */
>@@ -156,6 +152,7 @@ parse_unisys_oem (char *oemptr, int oem_
> 	return es7000_plat;
> }
>=20
>+#ifdef CONFIG_ACPI_BOOT
> int __init
> find_unisys_acpi_oem_table(unsigned long *oem_addr, int *length)
> {
>@@ -210,6 +207,7 @@ find_unisys_acpi_oem_table(unsigned long
> 	Dprintk("ES7000: did not find Unisys ACPI OEM table!\n");
> 	return -1;
> }
>+#endif
>=20
> static void
> es7000_spin(int n)
>diff -puN=20
>include/asm-i386/mach-es7000/mach_mpparse.h~build-fix-1=20
>include/asm-i386/mach-es7000/mach_mpparse.h
>---=20
>linux-2.6.13-rc6/include/asm-i386/mach-es7000/mach_mpparse.h~bu
>ild-fix-1	2005-08-25 01:30:43.906668728 -0700
>+++=20
>linux-2.6.13-rc6-root/include/asm-i386/mach-es7000/mach_mp
>parse.h	2005-08-25 01:31:35.785781904 -0700
>@@ -13,7 +13,9 @@ static inline void mpc_oem_pci_bus(struc
> }
>=20
> extern int parse_unisys_oem (char *oemptr, int oem_entries);
>+#ifdef CONFIG_ACPI_BOOT
> extern int find_unisys_acpi_oem_table(unsigned long=20
>*oem_addr, int *length);
>+#endif
>=20
> static inline int mps_oem_check(struct mp_config_table *mpc,=20
>char *oem,
> 		char *productid)
>@@ -30,10 +32,12 @@ static inline int mps_oem_check(struct m
> /* Hook from generic ACPI tables.c */
> static inline int acpi_madt_oem_check(char *oem_id, char=20
>*oem_table_id)
> {
>+#ifdef CONFIG_ACPI_BOOT
> 	unsigned long oem_addr;=20
> 	int oem_entries;
> 	if (!find_unisys_acpi_oem_table(&oem_addr, &oem_entries))
> 		return parse_unisys_oem((char *)oem_addr, oem_entries);
>+#endif
> 	return 0;
> }
>=20
>diff -puN arch/i386/kernel/mpparse.c~build-fix-1=20
>arch/i386/kernel/mpparse.c
>--- linux-2.6.13-rc6/arch/i386/kernel/mpparse.c~build-fix-1=09
>2005-08-25 01:50:46.237886600 -0700
>+++ linux-2.6.13-rc6-root/arch/i386/kernel/mpparse.c=09
>2005-08-25 01:51:57.733017688 -0700
>@@ -812,6 +812,8 @@ void __init find_smp_config (void)
>                             ACPI-based MP Configuration
>   =20
>---------------------------------------------------------------
>----------- */
>=20
>+int es7000_plat;
>+
> #ifdef CONFIG_ACPI_BOOT
>=20
> void __init mp_register_lapic_address (
>@@ -982,8 +984,6 @@ void __init mp_override_legacy_irq (
> 	return;
> }
>=20
>-int es7000_plat;
>-
> void __init mp_config_acpi_legacy_irqs (void)
> {
> 	struct mpc_config_intsrc intsrc;
>_
>


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
