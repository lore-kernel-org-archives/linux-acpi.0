From: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Subject: Fw: panic during IO-APIC detection
Date: Tue, 15 Feb 2005 12:25:59 -0800
Message-ID: <20050215122559.37c9a47b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Andreas Deresch <aderesch-cg1h10c7RbKzQB+pC5nmwQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org



Begin forwarded message:

Date: Wed, 16 Feb 2005 17:26:22 +0100 (CET)
From: Andreas Deresch <aderesch-cg1h10c7RbKzQB+pC5nmwQ@public.gmane.org>
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Subject: panic during IO-APIC detection


Hi lkml,

my notebook (Acer Aspire 1691WLMi, chipset: Intel 915PM) hangs during
IO-APIC detection. I am currently using 2.6.11-rc4-bk1, but this should be
the same for other versions.

Reason:
ACPI MADT contains info on 2 IO-APICs.
io_apic_get_unique_id panics due to being unable to assign an id to the
second one (the memory location reads as all ones). The chipset spec
(specifically: ICH6-M) is only talking about one IO-APIC, so most likely the
MADT is in error.

The question is, should io_apic_get_unique_id be more fault tolerant, or
where else should this be fixed?

TIA,
ad

For the moment I did the following:

diff -rbBu linux-2.6.11.orig/arch/i386/kernel/io_apic.c linux-2.6.11/arch/i386/kernel/io_apic.c
--- linux-2.6.11.orig/arch/i386/kernel/io_apic.c	2005-02-15 20:50:11.000000000 +0100
+++ linux-2.6.11/arch/i386/kernel/io_apic.c	2005-02-14 23:49:04.000000000 +0100
@@ -2449,8 +2449,10 @@
  		spin_unlock_irqrestore(&ioapic_lock, flags);

  		/* Sanity check */
-		if (reg_00.bits.ID != apic_id)
-			panic("IOAPIC[%d]: Unable change apic_id!\n", ioapic);
+		if (reg_00.bits.ID != apic_id) {
+			printk("IOAPIC[%d]: Unable change apic_id!\n", ioapic);
+			return -1;
+		}
  	}

  	apic_printk(APIC_VERBOSE, KERN_INFO
diff -rbBu linux-2.6.11.orig/arch/i386/kernel/mpparse.c linux-2.6.11/arch/i386/kernel/mpparse.c
--- linux-2.6.11.orig/arch/i386/kernel/mpparse.c	2005-02-15 20:50:11.000000000 +0100
+++ linux-2.6.11/arch/i386/kernel/mpparse.c	2005-02-14 23:49:23.000000000 +0100
@@ -895,6 +895,7 @@
  	u32			gsi_base)
  {
  	int			idx = 0;
+	int			tmpid = 0;

  	if (nr_ioapics >= MAX_IO_APICS) {
  		printk(KERN_ERR "ERROR: Max # of I/O APICs (%d) exceeded "
@@ -914,7 +915,11 @@
  	mp_ioapics[idx].mpc_apicaddr = address;

  	set_fixmap_nocache(FIX_IO_APIC_BASE_0 + idx, address);
-	mp_ioapics[idx].mpc_apicid = io_apic_get_unique_id(idx, id);
+	if ((tmpid = io_apic_get_unique_id(idx, id)) == -1) {
+		nr_ioapics--;
+		return;
+	}
+	mp_ioapics[idx].mpc_apicid = (u8)(tmpid);
  	mp_ioapics[idx].mpc_apicver = io_apic_get_version(idx);

  	/*
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
