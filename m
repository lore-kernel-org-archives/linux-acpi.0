From: James Cleverdon <jamesclv-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] 2.5.31 Summit NUMA patch with dynamic IRQ balancing
Date: Thu, 22 Aug 2002 19:31:35 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <49083.6707911969$1030070288@news.gmane.org>
References: <Pine.LNX.4.33.0208131421190.3110-100000@penguin.transmeta.com> <200208131729.50127.habanero@us.ibm.com> <20020813233007.GV14394@dualathlon.random>
Reply-To: jamesclv-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20020813233007.GV14394-YO0K3UtdbwQZxi9Dt0/nrQC/G2K4zDHf@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Andrea Arcangeli <andrea-l3A5Bk7waGM@public.gmane.org>, Andrew Theurer <habanero-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Linus Torvalds <torvalds-Lhe3bsMrZseB+jHODAdFcQ@public.gmane.org>, "Martin J. Bligh" <Martin.Bligh-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>, Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Dave Jones <davej-l3A5Bk7waGM@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Here's my first cut of the 2.5 summit patch that allows you to boot the x=
440=20
NUMA box and actually get all CPUs on-line.  While similar to the patch i=
n=20
Alan's 2.4 tree (and in SuSE 8.0), this patch uses logical mode interrupt=
s so=20
that we can make the TPR hardware to do real time IRQ routing to less bus=
y=20
CPUs.  As a result, this code may do P3 and earlier systems some good as=20
well.  No need for the balance_irq function (which is crudely commented o=
ut)=20
on P4 boxen.

What's the catch?  I'm glad you asked.  On my test systems this drops all=
 SCSI=20
interrupts when the ACPI hyperthreading-only config option is turned on. =
 The=20
system boots fine when turned off, using the MPS table.  Funny thing:  th=
e=20
IRQ table shows 38 entries with MPS but only 18 for ACPI -- just about wh=
at=20
you'd expect for the legacy IRQs plus some interrupt source overrides.  D=
oes=20
anyone know if this is expected behavior?  If not, what happened to the o=
ther=20
IRQs?

Note:  I can't do a thing about the xAPIC bridge HW's tie breaker rule.  =
On=20
idle systems the lowest numbered CPU in each APIC cluster is going to be =
hit=20
by most of the interrupts.  So what?  It was idle anyway.  On busier syst=
ems,=20
the interrupt counts start evening out.  So, folks should not expect=20
balance_irq's nicely spread IRQ counts across all CPUs, but can hopefully=
=20
enjoy some performance gains instead.

Anyway, here it is.  Applies to 2.5.31.  Comments and advice are very wel=
come:

diff -ruN 2.5.31/arch/i386/kernel/acpi.c s31/arch/i386/kernel/acpi.c
--- 2.5.31/arch/i386/kernel/acpi.c=09Sat Aug 10 18:41:53 2002
+++ s31/arch/i386/kernel/acpi.c=09Wed Aug 14 19:30:13 2002
@@ -114,6 +114,7 @@
 =09unsigned long=09=09size)
 {
 =09struct acpi_table_madt=09*madt =3D NULL;
+=09extern void acpi_madt_oem_check(char *oem_id, char *oem_table_id);
=20
 =09if (!phys_addr || !size)
 =09=09return -EINVAL;
@@ -130,6 +131,8 @@
 =09printk(KERN_INFO PREFIX "Local APIC address 0x%08x\n",
 =09=09madt->lapic_address);
=20
+=09acpi_madt_oem_check(madt->header.oem_id, madt->header.oem_table_id);
+
 =09return 0;
 }
=20
@@ -301,6 +304,7 @@
 =09char=09=09=09*cmdline)
 {
 =09int=09=09=09result =3D 0;
+=09extern void=09=09smp_cluster_apic_check(void);
=20
 =09/*
 =09 * The default interrupt routing model is PIC (8259).  This gets
@@ -416,8 +420,10 @@
 #endif /*CONFIG_X86_IO_APIC*/
=20
 #ifdef CONFIG_X86_LOCAL_APIC
-=09if (acpi_lapic && acpi_ioapic)
+=09if (acpi_lapic && acpi_ioapic) {
 =09=09smp_found_config =3D 1;
+=09=09smp_cluster_apic_check();
+=09}
 #endif
=20
 =09return 0;
diff -ruN 2.5.31/arch/i386/kernel/apic.c s31/arch/i386/kernel/apic.c
--- 2.5.31/arch/i386/kernel/apic.c=09Sat Aug 10 18:41:29 2002
+++ s31/arch/i386/kernel/apic.c=09Wed Aug 14 19:30:13 2002
@@ -29,6 +29,7 @@
 #include <asm/mtrr.h>
 #include <asm/mpspec.h>
 #include <asm/pgalloc.h>
+#include <asm/smpboot.h>
=20
 /* Using APIC to generate smp_local_timer_interrupt? */
 int using_apic_timer =3D 0;
@@ -272,6 +273,16 @@
 =09apic_write_around(APIC_LVT1, value);
 }
=20
+static inline unsigned long apic_ldr_value(unsigned long value)
+{
+=09if (clustered_apic_numaq)
+=09=09return (value);
+=09if (clustered_apic_xapic)
+=09=09return (((value) & ~APIC_LDR_MASK) |
+=09=09=09SET_APIC_LOGICAL_ID(physical_to_logical_apicid(hard_smp_process=
or_id())));
+=09return (((value) & ~APIC_LDR_MASK) | SET_APIC_LOGICAL_ID(1UL <<=20
smp_processor_id()));
+}
+
 void __init setup_local_APIC (void)
 {
 =09unsigned long value, ver, maxlvt;
@@ -304,21 +315,22 @@
 =09 * document number 292116).  So here it goes...
 =09 */
=20
-=09if (!clustered_apic_mode) {
+=09if (!clustered_apic_numaq) {
 =09=09/*
-=09=09 * In clustered apic mode, the firmware does this for us=20
-=09=09 * Put the APIC into flat delivery mode.
-=09=09 * Must be "all ones" explicitly for 82489DX.
+=09=09 * For NUMA-Q, the firmware does this for us.  Otherwise, put the =
APIC into=20
clustered or flat
+=09=09 *
+=09=09 * delivery mode.  Must be "all ones" explicitly for 82489DX.
 =09=09 */
-=09=09apic_write_around(APIC_DFR, 0xffffffff);
+=09=09if (clustered_apic_mode)
+=09=09=09apic_write_around(APIC_DFR, APIC_DFR_CLUSTER);
+=09=09else
+=09=09=09apic_write_around(APIC_DFR, APIC_DFR_FLAT);
=20
 =09=09/*
 =09=09 * Set up the logical destination ID.
 =09=09 */
 =09=09value =3D apic_read(APIC_LDR);
-=09=09value &=3D ~APIC_LDR_MASK;
-=09=09value |=3D (1<<(smp_processor_id()+24));
-=09=09apic_write_around(APIC_LDR, value);
+=09=09apic_write_around(APIC_LDR, apic_ldr_value(value));
 =09}
=20
 =09/*
diff -ruN 2.5.31/arch/i386/kernel/io_apic.c s31/arch/i386/kernel/io_apic.=
c
--- 2.5.31/arch/i386/kernel/io_apic.c=09Sat Aug 10 18:41:26 2002
+++ s31/arch/i386/kernel/io_apic.c=09Wed Aug 14 19:30:13 2002
@@ -35,6 +35,7 @@
 #include <asm/io.h>
 #include <asm/smp.h>
 #include <asm/desc.h>
+#include <asm/smpboot.h>
=20
 #undef APIC_LOCKUP_DEBUG
=20
@@ -261,7 +262,7 @@
 =09=09allowed_mask =3D cpu_online_map & irq_affinity[irq];
 =09=09entry->timestamp =3D now;
 =09=09entry->cpu =3D move(entry->cpu, allowed_mask, now, random_number);
-=09=09set_ioapic_affinity(irq, 1 << entry->cpu);
+=09=09set_ioapic_affinity(irq, cpu_present_to_apicid(entry->cpu));
 =09}
 }
 #else /* !SMP */
@@ -682,9 +683,40 @@
 =09return current_vector;
 }
=20
+/*
+ * round_robin_cpu_apic_id -- Since i386 Linux doesn't use the APIC TPRs=
 to
+ * set task/interrupt priority, xAPICs' tiebreaker rule tends to hit one=
 CPU
+ * with all interrupts for each quad.  Distribute the interrupts using a
+ * simple round robin scheme.
+ */
+static int round_robin_cpu_apic_id(void)
+{
+=09int val;
+=09static unsigned=09next_cpu =3D 0;
+
+=09if (next_cpu >=3D NR_CPUS || cpu_2_logical_apicid[next_cpu] =3D=3D BA=
D_APICID)
+=09=09next_cpu =3D 0;
+=09val =3D cpu_present_to_apicid(next_cpu) | APIC_DEST_CPUS_MASK;
+=09++next_cpu;
+=09return (val);
+}
+
+static inline int target_cpus(void)
+{
+=09if (clustered_apic_numaq)
+=09=09return APIC_BROADCAST_ID_APIC;=09/* broadcast to local quad */
+=09if (clustered_apic_xapic)
+=09=09return round_robin_cpu_apic_id();
+=09return logical_cpu_present_map & 0xFFu;
+//=09return cpu_online_map;
+}
+
 static struct hw_interrupt_type ioapic_level_irq_type;
 static struct hw_interrupt_type ioapic_edge_irq_type;
=20
+#undef KERN_DEBUG
+#define KERN_DEBUG
+
 void __init setup_IO_APIC_irqs(void)
 {
 =09struct IO_APIC_route_entry entry;
@@ -702,9 +734,9 @@
 =09=09memset(&entry,0,sizeof(entry));
=20
 =09=09entry.delivery_mode =3D dest_LowestPrio;
-=09=09entry.dest_mode =3D INT_DELIVERY_MODE;
+=09=09entry.dest_mode =3D INT_DEST_ADDR_MODE;
 =09=09entry.mask =3D 0;=09=09=09=09/* enable IRQ */
-=09=09entry.dest.logical.logical_dest =3D TARGET_CPUS;
+=09=09entry.dest.logical.logical_dest =3D target_cpus();
=20
 =09=09idx =3D find_irq_entry(apic,pin,mp_INT);
 =09=09if (idx =3D=3D -1) {
@@ -722,7 +754,6 @@
 =09=09if (irq_trigger(idx)) {
 =09=09=09entry.trigger =3D 1;
 =09=09=09entry.mask =3D 1;
-=09=09=09entry.dest.logical.logical_dest =3D TARGET_CPUS;
 =09=09}
=20
 =09=09irq =3D pin_2_irq(idx, apic, pin);
@@ -782,9 +813,9 @@
 =09 * We use logical delivery to get the timer IRQ
 =09 * to the first CPU.
 =09 */
-=09entry.dest_mode =3D INT_DELIVERY_MODE;
+=09entry.dest_mode =3D INT_DEST_ADDR_MODE;
 =09entry.mask =3D 0;=09=09=09=09=09/* unmask IRQ now */
-=09entry.dest.logical.logical_dest =3D TARGET_CPUS;
+=09entry.dest.logical.logical_dest =3D target_cpus();
 =09entry.delivery_mode =3D dest_LowestPrio;
 =09entry.polarity =3D 0;
 =09entry.trigger =3D 0;
@@ -1141,7 +1172,7 @@
 =09=09
 =09=09old_id =3D mp_ioapics[apic].mpc_apicid;
=20
-=09=09if (mp_ioapics[apic].mpc_apicid >=3D 0xf) {
+=09=09if (mp_ioapics[apic].mpc_apicid >=3D apic_broadcast_id) {
 =09=09=09printk(KERN_ERR "BIOS bug, IO-APIC#%d ID is %d in the MPC table=
!...\n",
 =09=09=09=09apic, mp_ioapics[apic].mpc_apicid);
 =09=09=09printk(KERN_ERR "... fixing up to %d. (tell your hw vendor)\n",
@@ -1153,14 +1184,16 @@
 =09=09 * Sanity check, is the ID really free? Every APIC in a
 =09=09 * system must have a unique ID or we get lots of nice
 =09=09 * 'stuck on smp_invalidate_needed IPI wait' messages.
+=09=09 * I/O APIC IDs no longer have any meaning for xAPICs.
 =09=09 */
-=09=09if (phys_id_present_map & (1 << mp_ioapics[apic].mpc_apicid)) {
+=09=09if (!clustered_apic_xapic &&
+=09=09    (phys_id_present_map & (1 << mp_ioapics[apic].mpc_apicid))) {
 =09=09=09printk(KERN_ERR "BIOS bug, IO-APIC#%d ID %d is already used!...=
\n",
 =09=09=09=09apic, mp_ioapics[apic].mpc_apicid);
 =09=09=09for (i =3D 0; i < 0xf; i++)
 =09=09=09=09if (!(phys_id_present_map & (1 << i)))
 =09=09=09=09=09break;
-=09=09=09if (i >=3D 0xf)
+=09=09=09if (i >=3D apic_broadcast_id)
 =09=09=09=09panic("Max APIC ID exceeded!\n");
 =09=09=09printk(KERN_ERR "... fixing up to %d. (tell your hw vendor)\n",
 =09=09=09=09i);
@@ -1288,7 +1321,7 @@
  */
 static void ack_edge_ioapic_irq(unsigned int irq)
 {
-=09balance_irq(irq);
+//=09balance_irq(irq);
 =09if ((irq_desc[irq].status & (IRQ_PENDING | IRQ_DISABLED))
 =09=09=09=09=09=3D=3D (IRQ_PENDING | IRQ_DISABLED))
 =09=09mask_IO_APIC_irq(irq);
@@ -1328,7 +1361,7 @@
 =09unsigned long v;
 =09int i;
=20
-=09balance_irq(irq);
+//=09balance_irq(irq);
 /*
  * It appears there is an erratum which affects at least version 0x11
  * of I/O APIC (that's the 82093AA and cores integrated into various
@@ -1849,8 +1882,8 @@
 =09memset(&entry,0,sizeof(entry));
=20
 =09entry.delivery_mode =3D dest_LowestPrio;
-=09entry.dest_mode =3D INT_DELIVERY_MODE;
-=09entry.dest.logical.logical_dest =3D TARGET_CPUS;
+=09entry.dest_mode =3D INT_DEST_ADDR_MODE;
+=09entry.dest.logical.logical_dest =3D target_cpus();
 =09entry.mask =3D 1;=09=09=09=09=09 /* Disabled (masked) */
 =09entry.trigger =3D 1;=09=09=09=09   /* Level sensitive */
 =09entry.polarity =3D 1;=09=09=09=09=09/* Low active */
diff -ruN 2.5.31/arch/i386/kernel/irq.c s31/arch/i386/kernel/irq.c
--- 2.5.31/arch/i386/kernel/irq.c=09Sat Aug 10 18:41:19 2002
+++ s31/arch/i386/kernel/irq.c=09Thu Aug 22 17:48:15 2002
@@ -332,6 +332,7 @@
=20
 =09irq_enter();
 =09kstat.irqs[cpu][irq]++;
+=09apic_adj_tpr(TPR_IRQ);
 =09spin_lock(&desc->lock);
 =09desc->handler->ack(irq);
 =09/*
@@ -389,6 +390,7 @@
 =09 */
 =09desc->handler->end(irq);
 =09spin_unlock(&desc->lock);
+=09apic_adj_tpr(-TPR_IRQ);
=20
 =09irq_exit();
=20
diff -ruN 2.5.31/arch/i386/kernel/mpparse.c s31/arch/i386/kernel/mpparse.=
c
--- 2.5.31/arch/i386/kernel/mpparse.c=09Sat Aug 10 18:41:25 2002
+++ s31/arch/i386/kernel/mpparse.c=09Wed Aug 14 19:30:13 2002
@@ -30,6 +30,7 @@
 #include <asm/mpspec.h>
 #include <asm/pgalloc.h>
 #include <asm/io_apic.h>
+#include <asm/smpboot.h>
=20
 /* Have we found an MP table */
 int smp_found_config;
@@ -68,6 +69,13 @@
=20
 /* Bitmask of physically existing CPUs */
 unsigned long phys_cpu_present_map;
+unsigned long logical_cpu_present_map;
+
+u32 apic_broadcast_id =3D APIC_BROADCAST_ID_APIC;
+u8 clustered_apic_mode =3D 0;
+u8 esr_disable =3D 0;
+u8 raw_phys_apicid[NR_CPUS] =3D { [0 ... NR_CPUS-1] =3D BAD_APICID };
+static u8 clustered_hint =3D 0;
=20
 /*
  * Intel MP BIOS table parsing routines:
@@ -104,8 +112,8 @@
 =09if (!(m->mpc_cpuflag & CPU_ENABLED))
 =09=09return;
=20
-=09logical_apicid =3D m->mpc_apicid;
-=09if (clustered_apic_mode) {
+=09logical_apicid =3D 0x01;
+=09if (clustered_apic_numaq) {
 =09=09quad =3D translation_table[mpc_record]->trans_quad;
 =09=09logical_apicid =3D (quad << 4) +=20
 =09=09=09(m->mpc_apicid ? m->mpc_apicid << 1 : 1);
@@ -186,11 +194,8 @@
 =09}
 =09ver =3D m->mpc_apicver;
=20
-=09if (clustered_apic_mode) {
-=09=09phys_cpu_present_map |=3D (logical_apicid&0xf) << (4*quad);
-=09} else {
-=09=09phys_cpu_present_map |=3D 1 << m->mpc_apicid;
-=09}
+=09logical_cpu_present_map |=3D 1 << (num_processors-1);
+=09phys_cpu_present_map |=3D apicid_to_phys_cpu_present(m->mpc_apicid);
 =09/*
 =09 * Validate version
 =09 */
@@ -199,6 +204,7 @@
 =09=09ver =3D 0x10;
 =09}
 =09apic_version[m->mpc_apicid] =3D ver;
+=09raw_phys_apicid[num_processors - 1] =3D m->mpc_apicid;
 }
=20
 static void __init MP_bus_info (struct mpc_config_bus *m)
@@ -209,7 +215,7 @@
 =09memcpy(str, m->mpc_bustype, 6);
 =09str[6] =3D 0;
 =09
-=09if (clustered_apic_mode) {
+=09if (clustered_apic_numaq) {
 =09=09quad =3D translation_table[mpc_record]->trans_quad;
 =09=09mp_bus_id_to_node[m->mpc_busid] =3D quad;
 =09=09mp_bus_id_to_local[m->mpc_busid] =3D=20
translation_table[mpc_record]->trans_local;
@@ -253,6 +259,15 @@
 =09}
 =09mp_ioapics[nr_ioapics] =3D *m;
 =09nr_ioapics++;
+=09/******
+=09 * Warning!  We have an APIC version number collision between the API=
Cs
+=09 * on Scorpio-based NUMA-Q boxes and Summit xAPICs.  Intel didn't
+=09 * define the xAPIC ver ID range until late in the development cycle,
+=09 * so there is working silicon out there that doesn't match it.
+=09 * A test in smp_cluster_apic_check() resolves the above conflict.
+=09 ******/
+=09if (m->mpc_apicver >=3D XAPIC_VER_LOW && m->mpc_apicver <=3D XAPIC_VE=
R_HIGH)
+=09=09clustered_hint |=3D CLUSTERED_APIC_XAPIC;
 }
=20
 static void __init MP_intsrc_info (struct mpc_config_intsrc *m)
@@ -348,12 +363,39 @@
 }
=20
 /*
+ * Common code for MPS and ACPI/MADT.
+ */
+void __init smp_cluster_apic_check(void)
+{
+=09int i;
+=09u8 cluster;
+=09static const char *mode_names[] =3D {
+=09=09"Flat", "Clustered NUMA-Q", "Clustered xAPIC", "???"
+=09};
+
+=09if (clustered_hint) {
+=09=09if (clustered_hint & CLUSTERED_APIC_NUMAQ) {
+=09=09=09/* NUMA-Q boxes never had xAPICs */
+=09=09=09clustered_hint &=3D ~CLUSTERED_APIC_XAPIC;
+=09=09}
+=09=09clustered_apic_mode =3D clustered_hint;
+=09=09esr_disable =3D 1;
+=09=09if (clustered_apic_xapic)
+=09=09=09apic_broadcast_id =3D APIC_BROADCAST_ID_XAPIC;
+=09=09phys_cpu_present_map =3D logical_cpu_present_map;
+=09}
+=09printk("Enabling APIC mode:  %s.  Using %d I/O APICs\n",
+=09=09mode_names[clustered_apic_mode], nr_ioapics);
+}
+
+/*
  * Read/parse the MPC
  */
=20
 static int __init smp_read_mpc(struct mp_config_table *mpc)
 {
-=09char str[16];
+=09char oem[10];
+=09char prod[14];
 =09int count=3Dsizeof(*mpc);
 =09unsigned char *mpt=3D((unsigned char *)mpc)+count;
=20
@@ -378,13 +440,21 @@
 =09=09printk(KERN_ERR "SMP mptable: null local APIC address!\n");
 =09=09return 0;
 =09}
-=09memcpy(str,mpc->mpc_oem,8);
-=09str[8]=3D0;
-=09printk("OEM ID: %s ",str);
-
-=09memcpy(str,mpc->mpc_productid,12);
-=09str[12]=3D0;
-=09printk("Product ID: %s ",str);
+=09memcpy(oem, mpc->mpc_oem, 8);
+=09oem[8] =3D 0;
+=09memcpy(prod, mpc->mpc_productid, 12);
+=09prod[12] =3D 0;
+=09printk("OEM ID: %s ", oem);
+=09printk("Product ID: %s ",prod);
+=09/*
+=09 * Can't recognize Summit xAPICs (see MP_ioapic_info), so use
+=09 * OEM/Product IDs.
+=09 */
+=09if (!strncmp(oem, "IBM ENSW", 8) &&
+=09    (!strncmp(prod, "NF 6000R", 8) || !strncmp(prod, "VIGIL SMP", 9))=
 )
+=09=09clustered_hint |=3D CLUSTERED_APIC_XAPIC;
+=09else if (!strncmp(oem, "IBM NUMA", 8))
+=09=09clustered_hint |=3D CLUSTERED_APIC_NUMAQ;
=20
 =09printk("APIC at: 0x%lX\n",mpc->mpc_lapic);
=20
@@ -395,7 +465,7 @@
 =09if (!acpi_lapic)
 =09=09mp_lapic_addr =3D mpc->mpc_lapic;
=20
-=09if (clustered_apic_mode && mpc->mpc_oemptr) {
+=09if (clustered_apic_numaq && mpc->mpc_oemptr) {
 =09=09/* We need to process the oem mpc tables to tell us which quad thi=
ngs are=20
in ... */
 =09=09mpc_record =3D 0;
 =09=09smp_read_mpc_oem((struct mp_config_oemtable *) mpc->mpc_oemptr,=20
mpc->mpc_oemsize);
@@ -463,6 +533,7 @@
 =09=09}
 =09=09++mpc_record;
 =09}
+=09smp_cluster_apic_check();
 =09if (!num_processors)
 =09=09printk(KERN_ERR "SMP mptable: no processors registered!\n");
 =09return num_processors;
@@ -934,6 +1005,17 @@
 =09=09mp_ioapic_routing[idx].irq_start,
 =09=09mp_ioapic_routing[idx].irq_end);
=20
+=09/******
+=09 * Warning!  We have an APIC version number collision between the API=
Cs
+=09 * on Scorpio-based NUMA-Q boxes and Summit xAPICs.  Intel didn't
+=09 * define the xAPIC ver ID range until late in the development cycle,
+=09 * so there is working silicon out there that doesn't match it.
+=09 * A test in smp_cluster_apic_check() resolves the above conflict.
+=09 ******/
+=09if (mp_ioapics[idx].mpc_apicver >=3D XAPIC_VER_LOW &&
+=09    mp_ioapics[idx].mpc_apicver <=3D XAPIC_VER_HIGH)
+=09=09clustered_hint |=3D CLUSTERED_APIC_XAPIC;
+
 =09return;
 }
=20
@@ -1051,6 +1133,13 @@
 =09return;
 }
=20
+/* Hook from generic ACPI tables.c */
+void __init acpi_madt_oem_check(char *oem_id, char *oem_table_id)
+{
+=09if (!strncmp(oem_id, "IBM", 3) && !strncmp(oem_table_id, "SERVIGIL", =
8))
+=09=09clustered_hint |=3D CLUSTERED_APIC_XAPIC;
+}
+
 #ifdef CONFIG_ACPI_PCI
=20
 void __init mp_parse_prt (void)
diff -ruN 2.5.31/arch/i386/kernel/process.c s31/arch/i386/kernel/process.=
c
--- 2.5.31/arch/i386/kernel/process.c=09Sat Aug 10 18:41:15 2002
+++ s31/arch/i386/kernel/process.c=09Wed Aug 14 19:30:13 2002
@@ -145,7 +145,9 @@
 =09=09irq_stat[smp_processor_id()].idle_timestamp =3D jiffies;
 =09=09while (!need_resched())
 =09=09=09idle();
+=09=09apic_set_tpr(TPR_TASK);
 =09=09schedule();
+=09=09apic_set_tpr(TPR_IDLE);
 =09}
 }
=20
@@ -197,7 +199,7 @@
 =09=09=09}
 =09=09=09=09/* we will leave sorting out the final value=20
 =09=09=09=09when we are ready to reboot, since we might not
- =09=09=09=09have set up boot_cpu_id or smp_num_cpu */
+ =09=09=09=09have set up boot_cpu_physical_apicid or smp_num_cpu */
 =09=09=09break;
 #endif
 =09=09}
diff -ruN 2.5.31/arch/i386/kernel/smpboot.c s31/arch/i386/kernel/smpboot.=
c
--- 2.5.31/arch/i386/kernel/smpboot.c=09Sat Aug 10 18:41:28 2002
+++ s31/arch/i386/kernel/smpboot.c=09Wed Aug 14 19:30:13 2002
@@ -498,59 +498,23 @@
 =09return do_fork(CLONE_VM|CLONE_IDLETASK, 0, &regs, 0);
 }
=20
-/* which physical APIC ID maps to which logical CPU number */
-volatile int physical_apicid_2_cpu[MAX_APICID];
 /* which logical CPU number maps to which physical APIC ID */
-volatile int cpu_2_physical_apicid[NR_CPUS];
+volatile u8 cpu_2_physical_apicid[NR_CPUS] =3D { [0 ... NR_CPUS-1] =3D B=
AD_APICID=20
};
=20
-/* which logical APIC ID maps to which logical CPU number */
-volatile int logical_apicid_2_cpu[MAX_APICID];
 /* which logical CPU number maps to which logical APIC ID */
-volatile int cpu_2_logical_apicid[NR_CPUS];
+volatile u8 cpu_2_logical_apicid[NR_CPUS] =3D { [0 ... NR_CPUS-1] =3D BA=
D_APICID=20
};
=20
-static inline void init_cpu_to_apicid(void)
-/* Initialize all maps between cpu number and apicids */
-{
-=09int apicid, cpu;
-
-=09for (apicid =3D 0; apicid < MAX_APICID; apicid++) {
-=09=09physical_apicid_2_cpu[apicid] =3D -1;
-=09=09logical_apicid_2_cpu[apicid] =3D -1;
-=09}
-=09for (cpu =3D 0; cpu < NR_CPUS; cpu++) {
-=09=09cpu_2_physical_apicid[cpu] =3D -1;
-=09=09cpu_2_logical_apicid[cpu] =3D -1;
-=09}
-}
=20
-static inline void map_cpu_to_boot_apicid(int cpu, int apicid)
-/*=20
- * set up a mapping between cpu and apicid. Uses logical apicids for=20
multiquad,
- * else physical apic ids
- */
+static inline void map_cpu_to_boot_apicid(int cpu, u8 phys_apicid, u8=20
log_apicid)
 {
-=09if (clustered_apic_mode) {
-=09=09logical_apicid_2_cpu[apicid] =3D cpu;=09
-=09=09cpu_2_logical_apicid[cpu] =3D apicid;
-=09} else {
-=09=09physical_apicid_2_cpu[apicid] =3D cpu;=09
-=09=09cpu_2_physical_apicid[cpu] =3D apicid;
-=09}
+=09cpu_2_logical_apicid[cpu] =3D log_apicid;
+=09cpu_2_physical_apicid[cpu] =3D phys_apicid;
 }
=20
-static inline void unmap_cpu_to_boot_apicid(int cpu, int apicid)
-/*=20
- * undo a mapping between cpu and apicid. Uses logical apicids for multi=
quad,
- * else physical apic ids
- */
+static inline void unmap_cpu_to_boot_apicid(int cpu, u8 phys_apicid, u8=20
log_apicid)
 {
-=09if (clustered_apic_mode) {
-=09=09logical_apicid_2_cpu[apicid] =3D -1;=09
-=09=09cpu_2_logical_apicid[cpu] =3D -1;
-=09} else {
-=09=09physical_apicid_2_cpu[apicid] =3D -1;=09
-=09=09cpu_2_physical_apicid[cpu] =3D -1;
-=09}
+=09cpu_2_logical_apicid[cpu] =3D BAD_APICID;
+=09cpu_2_physical_apicid[cpu] =3D BAD_APICID;
 }
=20
 #if APIC_DEBUG
@@ -764,7 +728,7 @@
=20
 extern unsigned long cpu_initialized;
=20
-static void __init do_boot_cpu (int apicid)=20
+static void __init do_boot_cpu(u8 phys_apicid, u8 log_apicid)
 /*
  * NOTE - on most systems this is a PHYSICAL apic ID, but on multiquad
  * (ie clustered apic addressing mode), this is a LOGICAL apic ID.
@@ -774,7 +738,7 @@
 =09unsigned long boot_error =3D 0;
 =09int timeout, cpu;
 =09unsigned long start_eip;
-=09unsigned short nmi_high, nmi_low;
+=09unsigned short nmi_high =3D 0, nmi_low =3D 0;
=20
 =09cpu =3D ++cpucount;
 =09/*
@@ -791,7 +755,7 @@
 =09 */
 =09init_idle(idle, cpu);
=20
-=09map_cpu_to_boot_apicid(cpu, apicid);
+=09map_cpu_to_boot_apicid(cpu, phys_apicid, log_apicid);
=20
 =09idle->thread.eip =3D (unsigned long) start_secondary;
=20
@@ -801,7 +765,8 @@
 =09start_eip =3D setup_trampoline();
=20
 =09/* So we see what's up   */
-=09printk("Booting processor %d/%d eip %lx\n", cpu, apicid, start_eip);
+=09printk("Booting processor %d/0x%02X/0x%02X eip 0x%lX\n",
+=09=09cpu, phys_apicid, log_apicid, start_eip);
 =09stack_start.esp =3D (void *) (1024 + PAGE_SIZE + (char *)idle->thread=
_info);
=20
 =09/*
@@ -813,7 +778,7 @@
=20
 =09Dprintk("Setting warm reset code and vector.\n");
=20
-=09if (clustered_apic_mode) {
+=09if (clustered_apic_numaq) {
 =09=09/* stash the current NMI vector, so we can put things back */
 =09=09nmi_high =3D *((volatile unsigned short *) TRAMPOLINE_HIGH);
 =09=09nmi_low =3D *((volatile unsigned short *) TRAMPOLINE_LOW);
@@ -830,7 +795,7 @@
 =09/*
 =09 * Be paranoid about clearing APIC errors.
 =09 */
-=09if (!clustered_apic_mode && APIC_INTEGRATED(apic_version[apicid])) {
+=09if (!clustered_apic_mode && APIC_INTEGRATED(apic_version[phys_apicid]=
)) {
 =09=09apic_read_around(APIC_SPIV);
 =09=09apic_write(APIC_ESR, 0);
 =09=09apic_read(APIC_ESR);
@@ -845,10 +810,10 @@
 =09 * Starting actual IPI sequence...
 =09 */
=20
-=09if (clustered_apic_mode)
-=09=09boot_error =3D wakeup_secondary_via_NMI(apicid);
-=09else=20
-=09=09boot_error =3D wakeup_secondary_via_INIT(apicid, start_eip);
+=09if (clustered_apic_numaq)
+=09=09boot_error =3D wakeup_secondary_via_NMI(log_apicid);
+=09else
+=09=09boot_error =3D wakeup_secondary_via_INIT(phys_apicid, start_eip);
=20
 =09if (!boot_error) {
 =09=09/*
@@ -883,14 +848,15 @@
 =09=09=09=09/* trampoline code not run */
 =09=09=09=09printk("Not responding.\n");
 #if APIC_DEBUG
+=09=09=09/* xAPICs don't do remote inquiries. */
 =09=09=09if (!clustered_apic_mode)
-=09=09=09=09inquire_remote_apic(apicid);
+=09=09=09=09inquire_remote_apic(phys_apicid);
 #endif
 =09=09}
 =09}
 =09if (boot_error) {
 =09=09/* Try to put things back the way they were before ... */
-=09=09unmap_cpu_to_boot_apicid(cpu, apicid);
+=09=09unmap_cpu_to_boot_apicid(cpu, phys_apicid, log_apicid);
 =09=09clear_bit(cpu, &cpu_callout_map); /* was set here (do_boot_cpu()) =
*/
 =09=09clear_bit(cpu, &cpu_initialized); /* was set by cpu_init() */
 =09=09cpucount--;
@@ -899,7 +865,7 @@
 =09/* mark "stuck" area as not stuck */
 =09*((volatile unsigned long *)phys_to_virt(8192)) =3D 0;
=20
-=09if(clustered_apic_mode) {
+=09if (clustered_apic_numaq) {
 =09=09printk("Restoring NMI vector\n");
 =09=09*((volatile unsigned short *) TRAMPOLINE_HIGH) =3D nmi_high;
 =09=09*((volatile unsigned short *) TRAMPOLINE_LOW) =3D nmi_low;
@@ -958,7 +924,6 @@
 extern int prof_old_multiplier[NR_CPUS];
 extern int prof_counter[NR_CPUS];
=20
-static int boot_cpu_logical_apicid;
 /* Where the IO area was mapped on multiquad, always 0 otherwise */
 void *xquad_portio;
=20
@@ -966,9 +931,11 @@
=20
 static void __init smp_boot_cpus(unsigned int max_cpus)
 {
-=09int apicid, cpu, bit;
+=09int cpu, bit;
+=09u8 phys_apicid, log_apicid;
=20
-        if (clustered_apic_mode && (numnodes > 1)) {
+#ifdef CONFIG_MULTIQUAD
+        if (clustered_apic_numaq && (numnodes > 1)) {
                 printk("Remapping cross-quad port I/O for %d quads\n",
 =09=09=09numnodes);
                 printk("xquad_portio vaddr 0x%08lx, len %08lx\n",
@@ -977,6 +944,7 @@
                 xquad_portio =3D ioremap (XQUAD_PORTIO_BASE,=20
 =09=09=09numnodes * XQUAD_PORTIO_LEN);
         }
+#endif
=20
 #ifdef CONFIG_MTRR
 =09/*  Must be done before other processors booted  */
@@ -993,8 +961,6 @@
 =09=09prof_multiplier[cpu] =3D 1;
 =09}
=20
-=09init_cpu_to_apicid();
-
 =09/*
 =09 * Setup boot CPU information
 =09 */
@@ -1007,8 +973,14 @@
 =09 */
 =09set_bit(0, &cpu_online_map);
 =09set_bit(0, &cpu_callout_map);
-=09boot_cpu_logical_apicid =3D logical_smp_processor_id();
-=09map_cpu_to_boot_apicid(0, boot_cpu_apicid);
+=09if (clustered_apic_xapic)
+=09=09boot_cpu_logical_apicid =3D=20
physical_to_logical_apicid(boot_cpu_physical_apicid);
+=09else if (clustered_apic_numaq)
+=09=09boot_cpu_logical_apicid =3D logical_smp_processor_id();
+=09else
+=09=09boot_cpu_logical_apicid =3D 0x01;
+=09map_cpu_to_boot_apicid(0, boot_cpu_physical_apicid,=20
boot_cpu_logical_apicid);
+printk("Boot CPU #0/0x%02X/0x%02X\n", boot_cpu_physical_apicid,=20
boot_cpu_logical_apicid);
=20
 =09current_thread_info()->cpu =3D 0;
 =09smp_tune_scheduling();
@@ -1085,28 +1057,44 @@
 =09 */
 =09Dprintk("CPU present map: %lx\n", phys_cpu_present_map);
=20
-=09for (bit =3D 0; bit < NR_CPUS; bit++) {
-=09=09apicid =3D cpu_present_to_apicid(bit);
+=09for (cpu =3D 1, bit =3D 0; bit < NR_CPUS; bit++) {
+=09=09if (!(logical_cpu_present_map & (1ul << bit)))
+=09=09=09continue;
+=09=09if ((max_cpus >=3D 0) && (max_cpus <=3D cpucount + 1))
+=09=09=09continue;
+=09=09phys_apicid =3D raw_phys_apicid[bit];
 =09=09/*
 =09=09 * Don't even attempt to start the boot CPU!
 =09=09 */
-=09=09if (apicid =3D=3D boot_cpu_apicid)
+=09=09if (phys_apicid =3D=3D boot_cpu_physical_apicid)
 =09=09=09continue;
-
-=09=09if (!(phys_cpu_present_map & (1 << bit)))
-=09=09=09continue;
-=09=09if (max_cpus <=3D cpucount+1)
+=09=09if (phys_apicid =3D=3D BAD_APICID)
 =09=09=09continue;
+=09=09if (clustered_apic_xapic)
+=09=09=09log_apicid =3D (u8)physical_to_logical_apicid(phys_apicid);
+=09=09else if (clustered_apic_numaq)
+=09=09=09log_apicid =3D ((bit >> 2) << 4) | (1 << (bit & 0x3));
+=09=09else {
+=09=09=09/* Yes, this overflows if cpu > 7.  The APIC
+=09=09=09 * destination register is only 8 bits wide.
+=09=09=09 * For more than 8 CPUs, must use clustered mode. */
+=09=09=09log_apicid =3D 1u << cpu;
+=09=09=09if (log_apicid =3D=3D 0)
+=09=09=09=09BUG();
+=09=09}
=20
-=09=09do_boot_cpu(apicid);
+=09=09do_boot_cpu(phys_apicid, log_apicid);
=20
 =09=09/*
 =09=09 * Make sure we unmap all failed CPUs
 =09=09 */
-=09=09if ((boot_apicid_to_cpu(apicid) =3D=3D -1) &&
-=09=09=09=09(phys_cpu_present_map & (1 << bit)))
-=09=09=09printk("CPU #%d not responding - cannot use it.\n",
-=09=09=09=09=09=09=09=09apicid);
+=09=09if ((cpu_2_physical_apicid[cpu] =3D=3D BAD_APICID) &&
+=09=09=09=09(logical_cpu_present_map & (1ul << bit))) {
+=09=09=09printk("CPU #%d/0x%02X/0x%02X not responding - cannot use it.\n=
",
+=09=09=09=09=09bit, phys_apicid, log_apicid);
+=09=09=09logical_cpu_present_map &=3D ~(1ul << bit);
+=09=09} else
+=09=09=09++cpu;=09=09/* Got a live one. */
 =09}
=20
 =09/*
diff -ruN 2.5.31/arch/i386/kernel/trampoline.S=20
s31/arch/i386/kernel/trampoline.S
--- 2.5.31/arch/i386/kernel/trampoline.S=09Sat Aug 10 18:41:27 2002
+++ s31/arch/i386/kernel/trampoline.S=09Wed Aug 14 19:30:13 2002
@@ -36,9 +36,7 @@
=20
 ENTRY(trampoline_data)
 r_base =3D .
-#ifdef CONFIG_MULTIQUAD
 =09wbinvd
-#endif /* CONFIG_MULTIQUAD */
 =09mov=09%cs, %ax=09# Code and data in the same place
 =09mov=09%ax, %ds
=20
diff -ruN 2.5.31/include/asm-i386/apic.h s31/include/asm-i386/apic.h
--- 2.5.31/include/asm-i386/apic.h=09Sat Aug 10 18:42:05 2002
+++ s31/include/asm-i386/apic.h=09Wed Aug 14 19:31:11 2002
@@ -64,6 +64,22 @@
 =09apic_write_around(APIC_EOI, 0);
 }
=20
+static inline void apic_set_tpr(unsigned long val)
+{
+=09unsigned long value;
+
+=09value =3D apic_read(APIC_TASKPRI);
+=09apic_write_around(APIC_TASKPRI, (value & ~APIC_TPRI_MASK) + val);
+}
+
+static inline void apic_adj_tpr(long adj)
+{
+=09unsigned long value;
+
+=09value =3D apic_read(APIC_TASKPRI);
+=09apic_write_around(APIC_TASKPRI, value + adj);
+}
+
 extern int get_maxlvt(void);
 extern void clear_local_APIC(void);
 extern void connect_bsp_APIC (void);
@@ -96,6 +112,15 @@
 #define NMI_LOCAL_APIC=092
 #define NMI_INVALID=093
=20
+#else /* CONFIG_X86_LOCAL_APIC */
+#define apic_set_tpr(val)
+#define apic_adj_tpr(adj)
 #endif /* CONFIG_X86_LOCAL_APIC */
=20
+/* Priority values for apic_adj_tpr() and apic_set_tpr() */
+/* xAPICs only do priority comparisons on the upper nibble. */
+#define TPR_IDLE=09(0x00L)
+#define TPR_TASK=09(0x10L)
+#define TPR_IRQ=09=09(0x10L)
+
 #endif /* __ASM_APIC_H */
diff -ruN 2.5.31/include/asm-i386/apicdef.h s31/include/asm-i386/apicdef.=
h
--- 2.5.31/include/asm-i386/apicdef.h=09Sat Aug 10 18:41:36 2002
+++ s31/include/asm-i386/apicdef.h=09Wed Aug 14 19:30:13 2002
@@ -11,8 +11,10 @@
 #define=09=09APIC_DEFAULT_PHYS_BASE=090xfee00000
 =20
 #define=09=09APIC_ID=09=090x20
-#define=09=09=09APIC_ID_MASK=09=09(0x0F<<24)
-#define=09=09=09GET_APIC_ID(x)=09=09(((x)>>24)&0x0F)
+#define=09=09=09APIC_ID_MASK=09=09(0xFF<<24)
+#define=09=09=09GET_APIC_ID(x)=09=09(((x)>>24)&0xFF)
+#define=09=09=09=09XAPIC_VER_LOW=090x14=09/* Version num range */
+#define=09=09=09=09XAPIC_VER_HIGH=090x1F
 #define=09=09APIC_LVR=090x30
 #define=09=09=09APIC_LVR_MASK=09=090xFF00FF
 #define=09=09=09GET_APIC_VERSION(x)=09((x)&0xFF)
@@ -32,6 +34,8 @@
 #define=09=09=09SET_APIC_LOGICAL_ID(x)=09(((x)<<24))
 #define=09=09=09APIC_ALL_CPUS=09=090xFF
 #define=09=09APIC_DFR=090xE0
+#define=09=09=09APIC_DFR_CLUSTER=090x0FFFFFFFul=09/* Clustered */
+#define=09=09=09APIC_DFR_FLAT=09=090xFFFFFFFFul=09/* Flat mode */
 #define=09=09APIC_SPIV=090xF0
 #define=09=09=09APIC_SPIV_FOCUS_DISABLED=09(1<<9)
 #define=09=09=09APIC_SPIV_APIC_ENABLED=09=09(1<<8)
@@ -58,6 +62,7 @@
 #define=09=09=09APIC_INT_ASSERT=09=090x04000
 #define=09=09=09APIC_ICR_BUSY=09=090x01000
 #define=09=09=09APIC_DEST_LOGICAL=090x00800
+#define=09=09=09=09APIC_DEST_PHYSICAL=090x0=09/* For symmetry */
 #define=09=09=09APIC_DM_FIXED=09=090x00000
 #define=09=09=09APIC_DM_LOWEST=09=090x00100
 #define=09=09=09APIC_DM_SMI=09=090x00200
@@ -108,7 +113,13 @@
=20
 #define APIC_BASE (fix_to_virt(FIX_APIC_BASE))
=20
-#define MAX_IO_APICS 8
+#define MAX_IO_APICS 32=09/* Summit boxes can have 4*(2+3*2) I/O APICs *=
/
+
+/*
+ * The intr broadcast ID is 0xF for old APICs and 0xFF for xAPICs.
+ */
+#define APIC_BROADCAST_ID_XAPIC=090xFF
+#define APIC_BROADCAST_ID_APIC=090x0F
=20
 /*
  * the local APIC register structure, memory mapped. Not terribly well
diff -ruN 2.5.31/include/asm-i386/mpspec.h s31/include/asm-i386/mpspec.h
--- 2.5.31/include/asm-i386/mpspec.h=09Sat Aug 10 18:41:16 2002
+++ s31/include/asm-i386/mpspec.h=09Wed Aug 14 19:30:13 2002
@@ -14,13 +14,10 @@
 #define SMP_MAGIC_IDENT=09(('_'<<24)|('P'<<16)|('M'<<8)|'_')
=20
 /*
- * a maximum of 16 APICs with the current APIC ID architecture.
+ * A maximum of 16 APICs with the classic APIC ID architecture.
+ * xAPICs can have up to 256.
  */
-#ifdef CONFIG_MULTIQUAD
 #define MAX_APICS 256
-#else /* !CONFIG_MULTIQUAD */
-#define MAX_APICS 16
-#endif /* CONFIG_MULTIQUAD */
=20
 #define MAX_MPC_ENTRY 1024
=20
@@ -204,6 +201,7 @@
 extern int mp_bus_id_to_pci_bus [MAX_MP_BUSSES];
=20
 extern unsigned int boot_cpu_physical_apicid;
+extern unsigned int boot_cpu_logical_apicid;
 extern unsigned long phys_cpu_present_map;
 extern int smp_found_config;
 extern void find_smp_config (void);
diff -ruN 2.5.31/include/asm-i386/smp.h s31/include/asm-i386/smp.h
--- 2.5.31/include/asm-i386/smp.h=09Sat Aug 10 18:41:18 2002
+++ s31/include/asm-i386/smp.h=09Wed Aug 14 19:30:13 2002
@@ -19,33 +19,56 @@
 #include <asm/io_apic.h>
 #endif
 #include <asm/apic.h>
-#endif
-#endif
+#endif /* !__ASSEMBLY__ */
+#endif /* CONFIG_X86_LOCAL_APIC */
=20
-#ifdef CONFIG_SMP
-# ifdef CONFIG_MULTIQUAD
-#  define TARGET_CPUS 0xf     /* all CPUs in *THIS* quad */
-#  define INT_DELIVERY_MODE 0     /* physical delivery on LOCAL quad */
-# else
-#  define TARGET_CPUS cpu_online_map
-#  define INT_DELIVERY_MODE 1     /* logical delivery broadcast to all p=
rocs=20
*/
-# endif
-#else
-# define INT_DELIVERY_MODE 1     /* logical delivery */
-# define TARGET_CPUS 0x01
-#endif
+#ifndef __ASSEMBLY__
+extern u8 clustered_apic_mode;
+extern u8 esr_disable;
+extern u32 apic_broadcast_id;
+extern unsigned long logical_cpu_present_map;
+extern unsigned long phys_cpu_present_map;
+
+/*
+ * Some lowlevel functions might want to know about
+ * the real APIC ID <-> CPU # mapping.
+ */
+#define MAX_APICID 256
+#define BAD_APICID 0xFFu
+extern volatile u8 cpu_2_physical_apicid[NR_CPUS];
+extern volatile u8 physical_apicid_2_cpu[MAX_APICID];
+extern volatile u8 cpu_2_logical_apicid[NR_CPUS];
+extern volatile u8 logical_apicid_2_cpu[MAX_APICID];
+
+/*
+ * This function is needed by all SMP systems. It must _always_ be valid
+ * from the initial startup. We map APIC_BASE very early in page_setup()=
,
+ * so this is correct in the x86 case.
+ */
+
+#ifndef CONFIG_X86_LOCAL_APIC
+
+#define clustered_apic_mode=09(0)
+#define esr_disable=09=09(0)
+
+#endif /* !CONFIG_X86_LOCAL_APIC */
+
+#endif /* !__ASSEMBLY__ */
+
+#define CLUSTERED_APIC_NUMAQ=090x01
+#define CLUSTERED_APIC_XAPIC=090x02
+
+#define clustered_apic_numaq=09(clustered_apic_mode & CLUSTERED_APIC_NUM=
AQ)
+#define clustered_apic_xapic=09(clustered_apic_mode & CLUSTERED_APIC_XAP=
IC)
+
+#define APIC_DEST_CPUS_MASK=090x0Fu=09/* Destination masks for */
+#define APIC_DEST_CLUSTER_MASK=090xF0u=09/* clustered mode. */
+#define INT_DEST_ADDR_MODE=091=09/* logical delivery */
=20
-#ifndef clustered_apic_mode
- #ifdef CONFIG_MULTIQUAD
-  #define clustered_apic_mode (1)
-  #define esr_disable (1)
- #else /* !CONFIG_MULTIQUAD */
-  #define clustered_apic_mode (0)
-  #define esr_disable (0)
- #endif /* CONFIG_MULTIQUAD */
-#endif=20
=20
 #ifdef CONFIG_SMP
+#define smp_processor_id() (current->processor)
+
 #ifndef __ASSEMBLY__
=20
 /*
@@ -53,7 +76,6 @@
  */
 =20
 extern void smp_alloc_memory(void);
-extern unsigned long phys_cpu_present_map;
 extern unsigned long cpu_online_map;
 extern volatile unsigned long smp_invalidate_needed;
 extern int pic_mode;
@@ -69,16 +91,6 @@
 extern void zap_low_mappings (void);
=20
 /*
- * Some lowlevel functions might want to know about
- * the real APIC ID <-> CPU # mapping.
- */
-#define MAX_APICID 256
-extern volatile int cpu_to_physical_apicid[NR_CPUS];
-extern volatile int physical_apicid_to_cpu[MAX_APICID];
-extern volatile int cpu_to_logical_apicid[NR_CPUS];
-extern volatile int logical_apicid_to_cpu[MAX_APICID];
-
-/*
  * This function is needed by all SMP systems. It must _always_ be valid
  * from the initial startup. We map APIC_BASE very early in page_setup()=
,
  * so this is correct in the x86 case.
@@ -123,7 +135,7 @@
=20
 #endif /* !__ASSEMBLY__ */
=20
-#define NO_PROC_ID=09=090xFF=09=09/* No processor magic marker */
+#define NO_PROC_ID=09=090xFFu=09=09/* No processor magic marker */
=20
-#endif
-#endif
+#endif /* CONFIG_SMP */
+#endif /* __ASM_SMP_H */
diff -ruN 2.5.31/include/asm-i386/smpboot.h s31/include/asm-i386/smpboot.=
h
--- 2.5.31/include/asm-i386/smpboot.h=09Sat Aug 10 18:41:55 2002
+++ s31/include/asm-i386/smpboot.h=09Wed Aug 14 19:30:13 2002
@@ -1,62 +1,50 @@
 #ifndef __ASM_SMPBOOT_H
 #define __ASM_SMPBOOT_H
=20
-#ifndef clustered_apic_mode
- #ifdef CONFIG_MULTIQUAD
-  #define clustered_apic_mode (1)
- #else /* !CONFIG_MULTIQUAD */
-  #define clustered_apic_mode (0)
- #endif /* CONFIG_MULTIQUAD */
-#endif=20
-=20
-#ifdef CONFIG_MULTIQUAD
- #define TRAMPOLINE_LOW phys_to_virt(0x8)
- #define TRAMPOLINE_HIGH phys_to_virt(0xa)
-#else /* !CONFIG_MULTIQUAD */
- #define TRAMPOLINE_LOW phys_to_virt(0x467)
- #define TRAMPOLINE_HIGH phys_to_virt(0x469)
-#endif /* CONFIG_MULTIQUAD */
-
-#ifdef CONFIG_MULTIQUAD
- #define boot_cpu_apicid boot_cpu_logical_apicid
-#else /* !CONFIG_MULTIQUAD */
- #define boot_cpu_apicid boot_cpu_physical_apicid
-#endif /* CONFIG_MULTIQUAD */
+#ifndef __ASM_SMP_H
+#include "asm/smp.h"
+#endif
+
+#define TRAMPOLINE_LOW phys_to_virt(clustered_apic_numaq?0x8:0x467)
+#define TRAMPOLINE_HIGH phys_to_virt(clustered_apic_numaq?0xa:0x469)
+
+//#define boot_cpu_apicid=20
(clustered_apic_numaq?boot_cpu_logical_apicid:boot_cpu_physical_apicid)
+
+/*
+ * To build the logical APIC ID for each CPU we have three cases:
+ *  1) Normal flat mode:  use a bitmap of the CPU numbers
+ *  2) NUMA-Q:  do nothing, the BIOS has set it up
+ *  3) xAPIC:  convert the Intel standard physical APIC ID to a cluster
+ *=09nibble/cpu bitmap nibble
+ */
+/* cpu index numbr:  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, ... */
+/* phys xAPIC IDs : 00, 01, 02, 03, 10, 11, 12, 13, 20, 21, 22, ... */
+/* logical APIC ID: 01, 02, 04, 08, 11, 12, 14, 18, 21, 22, 24, ... */
+#define physical_to_logical_apicid(phys_apic) ((1ul << ((phys_apic) & 0x=
3)) |=20
((phys_apic) & APIC_DEST_CLUSTER_MASK))
=20
 /*
- * How to map from the cpu_present_map
+ * How to map from phys_cpu_present_map.
+ *  1) Normal flat mode:  use the mps_cpu, apicid bitmap
+ *  2) Multi-Quad:  only 4 CPUs per cluster, cluster ID in high nibble
  */
-#ifdef CONFIG_MULTIQUAD
- #define cpu_present_to_apicid(mps_cpu) ( ((mps_cpu/4)*16) + (1<<(mps_cp=
u%4))=20
)
-#else /* !CONFIG_MULTIQUAD */
- #define cpu_present_to_apicid(apicid) (apicid)
-#endif /* CONFIG_MULTIQUAD */
+#if 1
+#define cpu_present_to_apicid(cpu)=09(cpu_to_logical_apicid(cpu))
+#else
+#define cpu_present_to_apicid(mps_cpu)=09(clustered_apic_numaq ? \
+ =09( (((u32)(mps_cpu) >> 2) << 4) + (1u << ((mps_cpu) & 0x3)) ) : \
+=09 (clustered_apic_xapic ? cpu_to_logical_apicid(mps_cpu) : 1u << (mps_=
cpu) )=20
)
+#endif
+extern unsigned char raw_phys_apicid[NR_CPUS];
+#define apicid_to_phys_cpu_present(apicid)=09(clustered_apic_mode ? (1ul=
 <<=20
((((apicid) >> 4) << 2) | ((apicid) & 0x3))) : (1ul << (apicid)))
=20
 /*
  * Mappings between logical cpu number and logical / physical apicid
- * The first four macros are trivial, but it keeps the abstraction consi=
stent
  */
-extern volatile int logical_apicid_2_cpu[];
-extern volatile int cpu_2_logical_apicid[];
-extern volatile int physical_apicid_2_cpu[];
-extern volatile int cpu_2_physical_apicid[];
-
-#define logical_apicid_to_cpu(apicid) logical_apicid_2_cpu[apicid]
-#define cpu_to_logical_apicid(cpu) cpu_2_logical_apicid[cpu]
-#define physical_apicid_to_cpu(apicid) physical_apicid_2_cpu[apicid]
-#define cpu_to_physical_apicid(cpu) cpu_2_physical_apicid[cpu]
-#ifdef CONFIG_MULTIQUAD=09=09=09/* use logical IDs to bootstrap */
-#define boot_apicid_to_cpu(apicid) logical_apicid_2_cpu[apicid]
-#define cpu_to_boot_apicid(cpu) cpu_2_logical_apicid[cpu]
-#else /* !CONFIG_MULTIQUAD */=09=09/* use physical IDs to bootstrap */
-#define boot_apicid_to_cpu(apicid) physical_apicid_2_cpu[apicid]
-#define cpu_to_boot_apicid(cpu) cpu_2_physical_apicid[cpu]
-#endif /* CONFIG_MULTIQUAD */
-
-
-#ifdef CONFIG_MULTIQUAD
-#else /* !CONFIG_MULTIQUAD */
-#endif /* CONFIG_MULTIQUAD */
+extern volatile u8 cpu_2_logical_apicid[];
+extern volatile u8 cpu_2_physical_apicid[];
+
+#define cpu_to_logical_apicid(cpu)=09(int)cpu_2_logical_apicid[cpu]
+#define cpu_to_physical_apicid(cpu)=09(int)cpu_2_physical_apicid[cpu]
=20
=20
 #endif


--=20
James Cleverdon
IBM xSeries Linux Solutions
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot com



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
