From: Dmitry Torokhov <dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org>
Subject: [PATCH 1/4] properly create kobjects in acpi/scan.c
Date: Tue, 24 Aug 2004 01:34:15 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200408240134.16962.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Len Brown <len.brow-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

I have a bunch of patches that I would like you to take a look at:

01-acpi-scan-kobject.patch
	- properly create/register kobjects - take reference to the parent
	  since kobject_unregister will try dropping it potentially
	  (if ACPI was ever to release created devices) causing parent be
	  destroyed early) and use kobject_set_name to properly set name.

02-acpi-event-code.patch
	- move event (userspace signalling) code from acpi/bus.c to
          acpi/event.c as too many implementation details were exported,
	  plus some additional fixes to the event handling code.

03-acpi-use-rwsem.patch
	- kill brandead usage of acpi_device_lock & list_for_eacj_safe.
	  list_for_each_safe is only safe in the sense that current
	  element can be safely removed by the same thread that is using
	  list_for_each_safe. List still has to be protected from other
	  threads for entire duration of list traversal.
	  Use acpi_subsys.rwsem instead of acpi_device_lock to protect
	  lists.

Btw, why don't we just convert ACPI to be standard driver core bus with
standard drivers and devices? I could cook up something... The
/sys/firmware/acpi hierarchy is not populated with any useful data yet
so there should be no concern of breakign userspace interface (I am mot
talking about removing /proc/acpi part at the moment).

04-acpi-multiple-readers.patch
	- allow multiple readrs access /proc/acpi/event, every event is
	  delivered to all readers. Also limit number of pending events
	  to 64 (per reader) so if reader is stuck ACPI does not consume
	  all memory.

	  Can be user by various daemons, I could see cpufreqd listening
	  for battery insertion/removal events and debugging is much
	  easier too.

The patches are against last night pull from Linus repo.
	
-- 
Dmitry


===================================================================


ChangeSet@1.1842, 2004-08-24 01:09:40-05:00, dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org
  ACPI: Properly create kobj when registering acpi_device:
        - use kobject_set_name to initialize name;
        - take teference to parent's kobj as kobject_unregister
          will drop it
        - do not call kobject_init and kobject_add, just use
          kobject_register as everyone else does.
  
  Signed-off-by: Dmitry Torokhov <dtor-JGs/UdohzUI@public.gmane.org>


 scan.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)


===================================================================



diff -Nru a/drivers/acpi/scan.c b/drivers/acpi/scan.c
--- a/drivers/acpi/scan.c	2004-08-24 01:16:25 -05:00
+++ b/drivers/acpi/scan.c	2004-08-24 01:16:25 -05:00
@@ -66,13 +66,11 @@
 		list_add_tail(&device->g_list,&acpi_device_list);
 	spin_unlock(&acpi_device_lock);
 
-	kobject_init(&device->kobj);
-	strlcpy(device->kobj.name,device->pnp.bus_id,KOBJ_NAME_LEN);
+	kobject_set_name(&device->kobj, device->pnp.bus_id);
 	if (parent)
-		device->kobj.parent = &parent->kobj;
-	device->kobj.ktype = &ktype_acpi_ns;
+		device->kobj.parent = kobject_get(&parent->kobj);
 	device->kobj.kset = &acpi_namespace_kset;
-	kobject_add(&device->kobj);
+	kobject_register(&device->kobj);
 }
 
 static int


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
