From: Sergey Vlasov <vsu-u2l5PoMzF/Uox3rIn2DAYQ@public.gmane.org>
Subject: [BUG 2.4] INT_SRC_OVR information is lost
Date: Wed, 12 May 2004 21:08:10 +0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040512210810.52eb345a.vsu@altlinux.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Wed__12_May_2004_21_08_10_+0400_JQ70RHahAhM/1dfy"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

--Signature=_Wed__12_May_2004_21_08_10_+0400_JQ70RHahAhM/1dfy
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hello!

Trying to run 2.4.26 with the ACPI patch
(http://www.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.4.26/acpi-20040326-2.4.26.diff.bz2),
I got this:

..TIMER: vector=0x31 pin1=0 pin2=-1
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ...  failed.
...trying to set up timer as Virtual Wire IRQ... failed.
...trying to set up timer as ExtINT IRQ... works.


Previous versions (and 2.4.26 without the ACPI patch) did not have any
problems with the APIC timer on this machine:

..TIMER: vector=0x31 pin1=2 pin2=-1
Using local APIC timer interrupts.

Note that the pin1 value is different - no wonder that with pin1=0 the
APIC timer does not work.

I have tracked this down to a bug introduced by this changeset:

http://linux.bkbits.net:8080/linux-2.4/cset-/MfijFki0w/FbKanZc64klQ35bramzZVgttLm9hokYQ@public.gmane.org
[ACPI] enhance intr-src-override parsing to handle ES7000
http://bugme.osdl.org/show_bug.cgi?id=2520

This patch moves the call to mp_config_acpi_legacy_irqs() later -
after parsing MADT and getting INT_SRC_OVR from there.  However, in
2.4.x mp_config_acpi_legacy_irqs() allocates the memory for the MP
tables and initialises mp_irqs, so the changes made before calling it
are lost (and I'm not sure where they end up in the memory...).

This problem is 2.4.x-specific (in 2.6.x mp_irqs and other related
data is not dynamically allocated).

The following patch fixes the problem by splitting
mp_config_acpi_legacy_irqs() into two functions and allocating the MP
table data before it is filled.


--- kernel-source-2.4.26/include/asm-i386/mpspec.h.acpi-madt-fix	2004-05-11 15:22:38 +0400
+++ kernel-source-2.4.26/include/asm-i386/mpspec.h	2004-05-12 15:19:02 +0400
@@ -226,6 +226,7 @@ extern void mp_register_lapic_address (u
 #ifdef CONFIG_X86_IO_APIC
 extern void mp_register_ioapic (u8 id, u32 address, u32 irq_base);
 extern void mp_override_legacy_irq (u8 bus_irq, u8 polarity, u8 trigger, u32 global_irq);
+extern void mp_config_acpi_init (void);
 extern void mp_config_acpi_legacy_irqs (void);
 extern void mp_parse_prt (void);
 #endif /*!CONFIG_X86_IO_APIC*/
--- kernel-source-2.4.26/arch/i386/kernel/mpparse.c.acpi-madt-fix	2004-05-11 15:14:46 +0400
+++ kernel-source-2.4.26/arch/i386/kernel/mpparse.c	2004-05-12 15:19:02 +0400
@@ -1148,10 +1148,9 @@ void __init mp_override_legacy_irq (
 }
 
 
-void __init mp_config_acpi_legacy_irqs (void)
+void __init mp_config_acpi_init (void)
 {
-	int			i = 0;
-	int			ioapic = -1;
+	int i;
 
 	/*
 	 * Initialize mp_irqs for IRQ configuration.
@@ -1178,6 +1177,12 @@ void __init mp_config_acpi_legacy_irqs (
 	 */
 	mp_bus_id_to_type[MP_ISA_BUS] = MP_BUS_ISA;
 	Dprintk("Bus #%d is ISA\n", MP_ISA_BUS);
+}
+
+void __init mp_config_acpi_legacy_irqs (void)
+{
+	int i;
+	int ioapic;
 
 	/* 
 	 * Locate the IOAPIC that manages the ISA IRQs (0-15). 
--- kernel-source-2.4.26/arch/i386/kernel/acpi.c.acpi-madt-fix	2004-05-11 15:14:46 +0400
+++ kernel-source-2.4.26/arch/i386/kernel/acpi.c	2004-05-12 15:19:02 +0400
@@ -543,6 +543,8 @@ acpi_boot_init (void)
 		return result;
 	}
 
+	mp_config_acpi_init();
+
 	/* Record sci_int for use when looking for MADT sci_int override */
 	acpi_table_parse(ACPI_FADT, acpi_parse_fadt);
 


-- 
Sergey Vlasov

--Signature=_Wed__12_May_2004_21_08_10_+0400_JQ70RHahAhM/1dfy
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAoln8W82GfkQfsqIRAvedAJ4t/p8HKVqGf/Y4fY9OiHpZ+TeCqACcCwCG
Y1p8ulWd7Vuh36QAxK2iJe4=
=t4mf
-----END PGP SIGNATURE-----

--Signature=_Wed__12_May_2004_21_08_10_+0400_JQ70RHahAhM/1dfy--



-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
