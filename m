From: Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: acpi-20040715+D600+Suspend
Date: Wed, 15 Sep 2004 11:34:22 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1095219261.29010.17.camel@sli10-desk.sh.intel.com>
References: <B44D37711ED29844BEA67908EAF36F03B0D6DE@pdsmsx401.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-VHY/zYcihFNvfno4ua74"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <B44D37711ED29844BEA67908EAF36F03B0D6DE-4yWAQGcml65pB2pF5aRoyrfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ow Mun Heng <Ow.Mun.Heng-Sjgp3cTcYWE@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Nathan Bryant <nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pallipadi Venkatesh <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--=-VHY/zYcihFNvfno4ua74
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Could you please try the attached workaround? If it really helps, we
will do cleanup soon. Untested, if there is any typo, please correct it.

Thanks,
Shaohua
> >-----Original Message-----
> >From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
> >admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Ow Mun Heng
> >Sent: Wednesday, September 01, 2004 9:17 AM
> >To: Acpi-List
> >Subject: [ACPI] acpi-20040715+D600+Suspend
> >
> >Hi guys,
> >
> >       Lo and Behold, I managed to get S3 to work on my laptop by
> following
> >instructions on this website.
> >
> >http://www.loria.fr/~thome/d600/
> >
> >However, I've not tested it further(as in using the normal kernel
> boot
> >up line in grub.conf) to verify if it is the same whether or not I
> use
> >video=radeonfb.
> >
> >I'm getting these errors during Suspend to disk.
> >
> >Warning: CPU frequency out of sync: cpufreq and timingcore thinks of
> 600000,
> >is 1400000 kHz.
> >Debug: sleeping function called from invalid context at
> mm/slab.c:1989
> >in_atomic():1, irqs_disabled():0
> > [<c01156ac>] __might_sleep+0xa5/0xaf
> > [<c0135d3f>] __kmalloc+0x40/0x76
> > [<c023bec9>] acpi_os_allocate+0xa/0xb
> > [<c024fa1f>] acpi_ut_allocate+0x34/0x57
> > [<c024f9b0>] acpi_ut_initialize_buffer+0x42/0x7d
> > [<c024c85e>] acpi_rs_create_byte_stream+0x23/0x39
> > [<c024dc1e>] acpi_rs_set_srs_method_data+0x1b/0x9d
> > [<c011ecd4>] __group_send_sig_info+0x36/0x9d
> > [<c011ee0a>] group_send_sig_info+0x58/0x61
> > [<c02556fd>] acpi_pci_link_set+0xde/0x155
> > [<c0255b0f>] irqrouter_resume+0x1c/0x30
> > [<c027bfff>] sysdev_resume+0x3e/0xc7
> > [<c027ea69>] device_power_up+0x5/0xa
> > [<c012b332>] do_magic_resume_2+0x63/0xb9
> > [<c02db0d9>] copy_done+0x49/0x4c
> > [<c012b536>] software_suspend+0x98/0xae
> > [<c0252322>] acpi_system_write_sleep+0x6a/0x85
> > [<c014650c>] vfs_write+0xb8/0xe4
> > [<c01465d6>] sys_write+0x3c/0x62
> > [<c01059fd>] sysenter_past_esp+0x52/0x71
> >ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 11 (level, low) -> IRQ 11
> >PCI: Setting latency timer of device 0000:00:1d.0 to 64
> >ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 11 (level, low) -> IRQ 11
> >PCI: Setting latency timer of device 0000:00:1d.1 to 64
> >ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 11 (level, low) -> IRQ 11
> >PCI: Setting latency timer of device 0000:00:1d.2 to 64
> >ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 11 (level, low) -> IRQ 11
> >PCI: Setting latency timer of device 0000:00:1d.7 to 64
> >ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 11 (level, low) -> IRQ 11
> >ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 7 (level, low) -> IRQ 7
> >PCI: Setting latency timer of device 0000:00:1f.5 to 64
> >radeonfb: resumed !
> >ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 11 (level, low) -> IRQ 11
> >Fixing swap signatures... ok
> >
> >
> >I also noticed that now, suspend does not work as it should/or was
> when
> >I was using 2.6.7 kernel.
> >
> >Right now, it will go to the Freeing memory section.. then the screen
> >goes blank. (blacklight still on) and then stays that way for quite
> >sometime before I see the words "radeonfb: resumed" and when that
> >happens, it's as though time stood still. It won't start writing to
> the
> >disk until I press a key. (I usually just press the spacebar) and
> then
> >it will start writing and works OK from that. (I am writing on my
> laptop
> >which is been suspended(hibernated) and resumed a few times already.
> >
> >Anything changed or broke??
> >
> >--
> >Ow Mun Heng
> >Fedora GNU/Linux Core 2 on D600 1.4Ghz CPU kernel 2.6.8.1.Aug.29
> >Neuromancer 01:06:38 up 1 day, 3:25, 1 user, load average: 0.73,
> 0.88,
> >0.93
> >
> >
> >-------------------------------------------------------
> >This SF.Net email is sponsored by BEA Weblogic Workshop
> >FREE Java Enterprise J2EE developer tools!
> >Get your free copy of BEA WebLogic Workshop 8.1 today.
> >http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
> >_______________________________________________
> >Acpi-devel mailing list
> >Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> >https://lists.sourceforge.net/lists/listinfo/acpi-devel
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by BEA Weblogic Workshop
> FREE Java Enterprise J2EE developer tools!
> Get your free copy of BEA WebLogic Workshop 8.1 today.
> http://ads.osdn.com/?ad_idP47&alloc_id808&op=ick
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
> 

--=-VHY/zYcihFNvfno4ua74
Content-Disposition: attachment; filename=wake1.patch
Content-Type: text/x-patch; name=wake1.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

===== arch/i386/kernel/i8259.c 1.37 vs edited =====
--- 1.37/arch/i386/kernel/i8259.c	2004-09-03 03:20:49 +08:00
+++ edited/arch/i386/kernel/i8259.c	2004-09-15 11:19:10 +08:00
@@ -288,7 +288,34 @@ static int __init i8259A_init_sysfs(void
 	return error;
 }
 
-device_initcall(i8259A_init_sysfs);
+late_initcall(i8259A_init_sysfs);
+
+static int dumy_8259_resume(struct sys_device *dev)
+{
+	outb(0xff, PIC_MASTER_IMR);	/* mask all of 8259A-1 */
+	outb(0xff, PIC_SLAVE_IMR);	/* mask all of 8259A-2 */
+	return 0;
+}
+
+static struct sysdev_class dumy_8259_class = {
+	set_kset_name("dumy_8259"),
+	.resume = dumy_8259_resume,
+};
+
+static struct sys_device dumy_i8259A = {
+	.id	= 0,
+	.cls	= &dumy_8259_class,
+};
+
+static int __init dumy_i8259A_init_sysfs(void)
+{
+	int error = sysdev_class_register(&dumy_8259_class);
+	if (!error)
+		error = sysdev_register(&dumy_i8259A);
+	return error;
+}
+
+fs_initcall(dumy_i8259A_init_sysfs);
 
 void init_8259A(int auto_eoi)
 {
===== arch/i386/kernel/io_apic.c 1.110 vs edited =====
--- 1.110/arch/i386/kernel/io_apic.c	2004-08-31 15:55:07 +08:00
+++ edited/arch/i386/kernel/io_apic.c	2004-09-15 11:18:57 +08:00
@@ -2374,7 +2374,33 @@ static int __init ioapic_init_sysfs(void
 	return 0;
 }
 
-device_initcall(ioapic_init_sysfs);
+late_initcall(ioapic_init_sysfs);
+
+static int dumy_ioapic_resume(struct sys_device *dev)
+{
+	clear_IO_APIC();
+	return 0;
+}
+
+static struct sysdev_class dumy_ioapic_class = {
+	set_kset_name("dumy_ioapic"),
+	.resume = dumy_ioapic_resume,
+};
+
+static struct sys_device dumy_ioapic = {
+	.id	= 0,
+	.cls	= &dumy_ioapic_class,
+};
+
+static int __init dumy_ioapic_init_sysfs(void)
+{
+	int error = sysdev_class_register(&dumy_ioapic_class);
+	if (!error)
+		error = sysdev_register(&dumy_ioapic);
+	return error;
+}
+
+fs_initcall(dumy_ioapic_init_sysfs);
 
 /* --------------------------------------------------------------------------
                           ACPI-based IOAPIC Configuration
===== drivers/acpi/pci_link.c 1.31 vs edited =====
--- 1.31/drivers/acpi/pci_link.c	2004-08-05 03:55:16 +08:00
+++ edited/drivers/acpi/pci_link.c	2004-09-15 11:09:03 +08:00
@@ -714,9 +714,13 @@ irqrouter_resume(
 {
 	struct list_head        *node = NULL;
 	struct acpi_pci_link    *link = NULL;
+	int			flags;
 
 	ACPI_FUNCTION_TRACE("irqrouter_resume");
 
+	local_save_flags(flags);
+	local_irq_enable();
+
 	list_for_each(node, &acpi_link.entries) {
 
 		link = list_entry(node, struct acpi_pci_link, node);
@@ -727,6 +731,7 @@ irqrouter_resume(
 
 		acpi_pci_link_resume(link);
 	}
+	local_irq_restore(flags);
 	return_VALUE(0);
 }
 

--=-VHY/zYcihFNvfno4ua74--



-------------------------------------------------------
This SF.Net email is sponsored by: thawte's Crypto Challenge Vl
Crack the code and win a Sony DCRHC40 MiniDV Digital Handycam
Camcorder. More prizes in the weekly Lunch Hour Challenge.
Sign up NOW http://ad.doubleclick.net/clk;10740251;10262165;m
