From: Nathan Bryant <nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>
Subject: Re: acpi-20040715: functional regression on ASUS M2N
Date: Fri, 06 Aug 2004 09:36:04 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <41138944.3060309@optonline.net>
References: <4112814C.2070808@optonline.net> <m37jsc3424.fsf@reason.gnu-hamburg>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_WLprEnvfZ1q+zF0/gro6oQ)"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <m37jsc3424.fsf-glUV91rXKAHWIjgkaejU9x2eb7JE58TQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Georg C. F. Greve" <greve-mXXj517/zsQ@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_WLprEnvfZ1q+zF0/gro6oQ)
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT

Georg C. F. Greve wrote:

> nb> Georg, can you add some printk's to save_ELCR and log the values
> nb> that we are actually saving?
>
>I'll be glad to do that, but will have to see how to do it in a way
>that I actually see what is printed. Haven't done much kernel hacking
>really, is there "the right way" to do it?
>  
>
The attached patch is good enough. Since the call to restore_ELCR is 
crashing you, we comment it out, and log the raw values from save_ELCR:

By the way, can you send the output of lspci?

--Boundary_(ID_WLprEnvfZ1q+zF0/gro6oQ)
Content-type: text/x-patch; name=elcrlog.patch
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=elcrlog.patch

===== arch/i386/kernel/i8259.c 1.35 vs edited =====
--- 1.35/arch/i386/kernel/i8259.c	2004-07-14 16:00:16 -04:00
+++ edited/arch/i386/kernel/i8259.c	2004-08-06 09:33:02 -04:00
@@ -244,21 +244,23 @@
  */
 static void restore_ELCR(char *trigger)
 {
-	outb(trigger[0], 0x4d0);
-	outb(trigger[1], 0x4d1);
+	/* IRQ 0,1,2,8,13 are marked as reserved */
+	outb(trigger[0] & 0xF8, 0x4d0);
+	outb(trigger[1] & 0xDE, 0x4d1);
 }
 
 static void save_ELCR(char *trigger)
 {
-	/* IRQ 0,1,2,8,13 are marked as reserved */
-	trigger[0] = inb(0x4d0) & 0xF8;
-	trigger[1] = inb(0x4d1) & 0xDE;
+	trigger[0] = inb(0x4d0);
+	trigger[1] = inb(0x4d1);
+	printk(KERN_DEBUG "i8259: saving ELCR: 0x%02x 0x%02x\n",
+		trigger[0], trigger[1]);
 }
 
 static int i8259A_resume(struct sys_device *dev)
 {
 	init_8259A(0);
-	restore_ELCR(irq_trigger);
+	/*restore_ELCR(irq_trigger);*/
 	return 0;
 }
 

--Boundary_(ID_WLprEnvfZ1q+zF0/gro6oQ)--


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
