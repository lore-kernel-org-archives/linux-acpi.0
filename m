From: Nathan Bryant <nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>
Subject: Re: bug in acpid scripts
Date: Thu, 12 Aug 2004 20:55:15 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <411C1173.9010100@optonline.net>
References: <B44D37711ED29844BEA67908EAF36F038ADB3E@pdsmsx401.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_zfyM/OFUDdEO1l5qcf1Kow)"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <B44D37711ED29844BEA67908EAF36F038ADB3E-4yWAQGcml65pB2pF5aRoyrfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: russell-1vnkWVZi4QaVc3sceRu5cw@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_zfyM/OFUDdEO1l5qcf1Kow)
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT

Li, Shaohua wrote:

>Hi,
>Oops, I'm sorry the patch has typo. I changed the parameter name after
>my test, but I forgot changing all. Could you please try this one? Sorry
>for the inconvenience.
>
>Thanks,
>Shaohua
>
Yes, I just changed your patch to the following and it works. I can 
confirm it fixes the problem, no adverse effects

--Boundary_(ID_zfyM/OFUDdEO1l5qcf1Kow)
Content-type: text/plain; name=maskevent.patch3
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=maskevent.patch3

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/08/12 20:47:40-04:00 nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org 
#   This is a fixed version of shaohua's double-button-event patch
# 
# drivers/acpi/sleep/main.c
#   2004/08/12 20:47:32-04:00 nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org +3 -3
#   Fixed shaohua's double-button event patch
# 
# drivers/acpi/event.c
#   2004/08/12 20:47:32-04:00 nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org +1 -1
#   Fixed shaohua's double-button event patch
# 
# drivers/acpi/sleep/main.c
#   2004/08/12 02:41:13-04:00 nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org +3 -1
#   Import patch maskevent.patch
# 
# drivers/acpi/event.c
#   2004/08/12 02:40:13-04:00 nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org +2 -1
#   Import patch maskevent.patch
# 
# drivers/acpi/bus.c
#   2004/08/12 02:39:43-04:00 nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org +2 -1
#   Import patch maskevent.patch
# 
diff -Nru a/drivers/acpi/bus.c b/drivers/acpi/bus.c
--- a/drivers/acpi/bus.c	2004-08-12 20:49:37 -04:00
+++ b/drivers/acpi/bus.c	2004-08-12 20:49:37 -04:00
@@ -283,6 +283,7 @@
 DECLARE_WAIT_QUEUE_HEAD(acpi_bus_event_queue);
 
 extern int			event_is_open;
+extern int			acpi_event_is_masked;
 
 int
 acpi_bus_generate_event (
@@ -299,7 +300,7 @@
 		return_VALUE(-EINVAL);
 
 	/* drop event on the floor if no one's listening */
-	if (!event_is_open)
+	if (!event_is_open || acpi_event_is_masked)
 		return_VALUE(0);
 
 	event = kmalloc(sizeof(struct acpi_bus_event), GFP_ATOMIC);
diff -Nru a/drivers/acpi/event.c b/drivers/acpi/event.c
--- a/drivers/acpi/event.c	2004-08-12 20:49:37 -04:00
+++ b/drivers/acpi/event.c	2004-08-12 20:49:37 -04:00
@@ -17,7 +17,8 @@
 
 /* Global vars for handling event proc entry */
 static spinlock_t		acpi_system_event_lock = SPIN_LOCK_UNLOCKED;
-int				event_is_open = 0;
+int				event_is_open;
+int				acpi_event_is_masked;
 extern struct list_head		acpi_bus_event_list;
 extern wait_queue_head_t	acpi_bus_event_queue;
 
diff -Nru a/drivers/acpi/sleep/main.c b/drivers/acpi/sleep/main.c
--- a/drivers/acpi/sleep/main.c	2004-08-12 20:49:37 -04:00
+++ b/drivers/acpi/sleep/main.c	2004-08-12 20:49:37 -04:00
@@ -73,7 +73,7 @@
  *	arch-specific assembly, which in turn call acpi_enter_sleep_state().
  *	It's unfortunate, but it works. Please fix if you're feeling frisky.
  */
-
+extern int acpi_event_is_masked;
 static int acpi_pm_enter(u32 pm_state)
 {
 	acpi_status status = AE_OK;
@@ -92,6 +92,7 @@
 
 	local_irq_save(flags);
 	acpi_enable_wakeup_device(acpi_state);
+	acpi_event_is_masked = 1;
 	switch (pm_state)
 	{
 	case PM_SUSPEND_STANDBY:
@@ -142,6 +143,7 @@
 
 	acpi_leave_sleep_state(acpi_state);
 	acpi_disable_wakeup_device(acpi_state);
+	acpi_event_is_masked = 0;
 
 	/* reset firmware waking vector */
 	acpi_set_firmware_waking_vector((acpi_physical_address) 0);

--Boundary_(ID_zfyM/OFUDdEO1l5qcf1Kow)--


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
