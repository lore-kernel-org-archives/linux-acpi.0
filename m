From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: acpi_tolerant (Re: ACPI patch status (2.6))
Date: 30 Sep 2003 13:45:34 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1064943934.2583.100.camel@dhcppc4>
References: <1064902694.2535.159.camel@dhcppc4>
	 <20030930070706.GB8827@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030930070706.GB8827-B4tOwbsTzaBolqkO4TVVkw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>, Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> > If you seen any regressions, please let me know.
> 
> My ACPI tolerant patch is not included. Without this it will not boot
> on many HP servers and some other multiprocessor boxes.

Thanks Andi,
I've included your "PIC fallback and SMP boxes" note below to give
others background if they haven't seen it yet.

My  understanding was that the acpi_tolerant patch is in response to
Andrew de Quincy's "Full dropback to PIC mode" patch -- the one that
creates pic.c.  That change is in the mm tree, but not yet in 2.4, 2.6,
or the acpi 2.4 or 2.6 trees.

If I'm confused and you believe that the acpi_tolerant patch is needed
for the current acpi tree to boot on some SMP servers, please straighten
me out.

thanks,
-Len

------------

Hi,

We had good success with Andrew's PIC fallback patches on SuSE Linux.
A lot of boxes that needed pci=noacpi or acpi=off before work now.

Unfortunately there were also some regressions, mostly on bigger SMP 
boxes (e.g. some HP servers). What usually happened was that some
unimportant device like one USB port would fail to set or get an
interrupt.

That would cause a full PIC mode fallback, which is not a good idea
on a SMP system and usually results in a failed boot.

People didn't notice the not working USB port before (or maybe it 
worked anyways).

I did a bit of an hack to work around this now. On a SMP system PIC 
mode fallback is probably not a good idea because it will perform awful
and more likely not work at all. This patch checks
if the box is a "true" SMP system (not just an uniprocessor box
with huperthreading), and if yes enables tolerant mode. Tolerant
mode means we don't do PIC fallback for failing to set an ACPI link.

This could be more improved, e.g. acpi_pci_get_prt_list should
probably also tolerate partial failure.

Another bigger problem we have with the PIC fallback is that there
are a some chipsets that don't like it when you first set a few
interrupts in APIC mode and then go back to PIC mode (e.g. 
that's the case on all NForce3 and some VIA boards). I'm not sure what 
to do with them yet. For our use for x86-64 I added an hack to always
force
PIC mode for Nvidia and VIA, but that's clearly an hack.

The patch is for a SuSE tree, will probably not apply directly to plain
2.4.

-Andi


diff -u linux-2.4.21/arch/i386/kernel/mpparse.c-o
linux-2.4.21/arch/i386/kernel/mpparse.c
--- linux-2.4.21/arch/i386/kernel/mpparse.c-o   2003-09-22
12:48:56.000000000 +0200
+++ linux-2.4.21/arch/i386/kernel/mpparse.c     2003-09-22
13:27:34.000000000 +0200
@@ -1293,6 +1293,8 @@
 
 #ifdef CONFIG_ACPI_PCI
 
+extern int acpi_tolerant;
+
 int __init mp_parse_prt (void)
 {
        struct list_head        *node = NULL;
@@ -1305,6 +1307,13 @@
        int                     edge_level = 0;
        int                     active_high_low = 0;
 
+#ifdef CONFIG_SMP
+       /* Hack: on "real" (not just HT) SMP boxes we do not fall back 
+          to PIC mode easily. Ignore interrupt setup failures then. */
+       if (acpi_tolerant != 2 && smp_num_cpus/smp_num_siblings > 1) 
+               acpi_tolerant = 1;
+#endif 
+
        /* Get the current PRT */
        prt_list = acpi_pci_get_prt_list();
    
@@ -1326,6 +1335,14 @@
                if (entry->link.handle) {
                        irq = acpi_pci_link_get_irq(entry->link.handle,
entry->link.index, &edge_level, &active_high_low);
                        if (irq < 0) {
+                               if (acpi_tolerant) { 
+                                       printk(KERN_INFO "Ignoring
failure to set interrupt for device %02x:%02x:%02x on pin %d (oldirq
%d)\n", 
+                                              entry->id.bus,
entry->id.device,
+                                              entry->id.function,
entry->pin,
+                                              entry->irq); 
+                               
+                                       continue; 
+                               }
                                acpi_pci_destroy_prt_list(prt_list);
                                return -ENODEV;
                        }
diff -u linux-2.4.21/arch/i386/kernel/setup.c-o
linux-2.4.21/arch/i386/kernel/setup.c
--- linux-2.4.21/arch/i386/kernel/setup.c-o     2003-09-22
12:48:58.000000000 +0200
+++ linux-2.4.21/arch/i386/kernel/setup.c       2003-09-22
13:27:37.000000000 +0200
@@ -202,6 +202,8 @@
 
 int acpi_tables __initdata = 0; 
 
+int acpi_tolerant; 
+
 extern int blk_nohighio;
 
 #ifndef CONFIG_SMP
@@ -897,6 +899,9 @@
                     acpi_force = 1;
                } 
 
+               else if (!memcmp(from, "acpi=tolerant", 13)) 
+                    acpi_tolerant = 2; 
+
                 /* disable IO-APIC */
                 else if (!memcmp(from, "noapic", 6))
                         disable_ioapic_setup();



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
