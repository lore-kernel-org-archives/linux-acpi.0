From: Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [patch request test] disable PIC/APIC/IOAPIC at S3 suspend
Date: Wed, 09 Nov 2005 14:40:31 +0800
Message-ID: <1131518431.4594.10.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
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
To: acpi-dev <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,
Zwane submitted a patch for reboot bug here:
http://marc.theaimsgroup.com/?l=linux-kernel&m=113098129126352&w=2
I guess we need the same thing for S3 suspend/resume, as S3 also jumps
to BIOS. Could anybody with S3 failure try below patch?

Thanks,
Shaohua


---

 linux-2.6.14-root/arch/i386/kernel/apic.c    |    4 +++-
 linux-2.6.14-root/arch/i386/kernel/i8259.c   |    2 ++
 linux-2.6.14-root/arch/i386/kernel/io_apic.c |    1 +
 3 files changed, 6 insertions(+), 1 deletion(-)

diff -puN arch/i386/kernel/i8259.c~disalbe_some_devices arch/i386/kernel/i8259.c
--- linux-2.6.14/arch/i386/kernel/i8259.c~disalbe_some_devices	2005-11-09 14:11:04.000000000 +0800
+++ linux-2.6.14-root/arch/i386/kernel/i8259.c	2005-11-09 14:11:04.000000000 +0800
@@ -262,6 +262,8 @@ static int i8259A_resume(struct sys_devi
 static int i8259A_suspend(struct sys_device *dev, pm_message_t state)
 {
 	save_ELCR(irq_trigger);
+	outb(0xff, 0x21);	/* mask all of 8259A-1 */
+	outb(0xff, 0xA1);	/* mask all of 8259A-1 */
 	return 0;
 }
 
diff -puN arch/i386/kernel/io_apic.c~disalbe_some_devices arch/i386/kernel/io_apic.c
--- linux-2.6.14/arch/i386/kernel/io_apic.c~disalbe_some_devices	2005-11-09 14:11:04.000000000 +0800
+++ linux-2.6.14-root/arch/i386/kernel/io_apic.c	2005-11-09 14:11:04.000000000 +0800
@@ -2350,6 +2350,7 @@ static int ioapic_suspend(struct sys_dev
 		*(((int *)entry) + 0) = io_apic_read(dev->id, 0x10 + 2 * i);
 	}
 	spin_unlock_irqrestore(&ioapic_lock, flags);
+	disable_IO_APIC();
 	return 0;
 }
 
diff -puN arch/i386/kernel/apic.c~disalbe_some_devices arch/i386/kernel/apic.c
--- linux-2.6.14/arch/i386/kernel/apic.c~disalbe_some_devices	2005-11-09 14:13:26.000000000 +0800
+++ linux-2.6.14-root/arch/i386/kernel/apic.c	2005-11-09 14:17:57.000000000 +0800
@@ -612,7 +612,9 @@ static int lapic_suspend(struct sys_devi
 	apic_pm_state.apic_thmr = apic_read(APIC_LVTTHMR);
 
 	local_irq_save(flags);
-	disable_local_APIC();
+	clear_local_APIC();
+	if (enabled_via_apicbase)
+		disable_local_APIC();
 	local_irq_restore(flags);
 	return 0;
 }
_




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
