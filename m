From: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH] Don't disable interrupts during EC access
Date: Mon, 15 Nov 2004 23:56:23 +0100
Message-ID: <20041115225623.GA5383@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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
List-Id: linux-acpi@vger.kernel.org


On VIA chipset + A64 laptops the EC access can take a long time. This causes
the system to lose timer interrupts while ACPI waits for the event, 
and causes it to always fallback to slower timer sources.

This patch replaces the spinlock with a semaphore and sleeps instead
of busy polling. This should also save power. 

Signed-off-by: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>

-Andi

diff -u linux/drivers/acpi/ec.c-o linux/drivers/acpi/ec.c
--- linux/drivers/acpi/ec.c-o	2004-10-26 09:57:32.000000000 -0700
+++ linux/drivers/acpi/ec.c	2004-11-15 12:55:58.000000000 -0800
@@ -29,10 +29,12 @@
 #include <linux/types.h>
 #include <linux/delay.h>
 #include <linux/proc_fs.h>
+#include <linux/interrupt.h>
 #include <asm/io.h>
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
 #include <acpi/actypes.h>
+#include <asm/msr.h>
 
 #define _COMPONENT		ACPI_EC_COMPONENT
 ACPI_MODULE_NAME		("acpi_ec")
@@ -53,7 +55,7 @@
 #define ACPI_EC_EVENT_IBE	0x02	/* Input buffer empty */
 
 #define ACPI_EC_UDELAY		100	/* Poll @ 100us increments */
-#define ACPI_EC_UDELAY_COUNT	1000	/* Wait 10ms max. during EC ops */
+#define ACPI_EC_UDELAY_COUNT	10	/* Wait 10ms max. during EC ops */
 #define ACPI_EC_UDELAY_GLK	1000	/* Wait 1ms max. to get global lock */
 
 #define ACPI_EC_COMMAND_READ	0x80
@@ -85,7 +87,6 @@
 	struct acpi_generic_address	command_addr;
 	struct acpi_generic_address	data_addr;
 	unsigned long			global_lock;
-	spinlock_t			lock;
 };
 
 /* If we find an EC via the ECDT, we need to keep a ptr to its context */
@@ -116,7 +117,7 @@
 			acpi_hw_low_level_read(8, &acpi_ec_status, &ec->status_addr);
 			if (acpi_ec_status & ACPI_EC_FLAG_OBF)
 				return 0;
-			udelay(ACPI_EC_UDELAY);
+			msleep(1);
 		} while (--i>0);
 		break;
 	case ACPI_EC_EVENT_IBE:
@@ -124,16 +125,16 @@
 			acpi_hw_low_level_read(8, &acpi_ec_status, &ec->status_addr);
 			if (!(acpi_ec_status & ACPI_EC_FLAG_IBF))
 				return 0;
-			udelay(ACPI_EC_UDELAY);
+			msleep(1);
 		} while (--i>0);
 		break;
 	default:
 		return -EINVAL;
 	}
-
 	return -ETIME;
 }
 
+static DECLARE_MUTEX(ec_mutex);
 
 static int
 acpi_ec_read (
@@ -143,7 +144,6 @@
 {
 	acpi_status		status = AE_OK;
 	int			result = 0;
-	unsigned long		flags = 0;
 	u32			glk = 0;
 
 	ACPI_FUNCTION_TRACE("acpi_ec_read");
@@ -158,8 +158,9 @@
 		if (ACPI_FAILURE(status))
 			return_VALUE(-ENODEV);
 	}
-	
-	spin_lock_irqsave(&ec->lock, flags);
+
+	WARN_ON(in_interrupt());
+	down(&ec_mutex);
 
 	acpi_hw_low_level_write(8, ACPI_EC_COMMAND_READ, &ec->command_addr);
 	result = acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
@@ -173,16 +174,15 @@
 
 
 	acpi_hw_low_level_read(8, data, &ec->data_addr);
-
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Read [%02x] from address [%02x]\n",
 		*data, address));
 
+		
 end:
-	spin_unlock_irqrestore(&ec->lock, flags);
+	up(&ec_mutex);
 
 	if (ec->global_lock)
 		acpi_release_global_lock(glk);
-
 	return_VALUE(result);
 }
 
@@ -195,7 +195,6 @@
 {
 	int			result = 0;
 	acpi_status		status = AE_OK;
-	unsigned long		flags = 0;
 	u32			glk = 0;
 
 	ACPI_FUNCTION_TRACE("acpi_ec_write");
@@ -209,7 +208,8 @@
 			return_VALUE(-ENODEV);
 	}
 
-	spin_lock_irqsave(&ec->lock, flags);
+	WARN_ON(in_interrupt());
+	down(&ec_mutex);
 
 	acpi_hw_low_level_write(8, ACPI_EC_COMMAND_WRITE, &ec->command_addr);
 	result = acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
@@ -230,7 +230,7 @@
 		data, address));
 
 end:
-	spin_unlock_irqrestore(&ec->lock, flags);
+	up(&ec_mutex);
 
 	if (ec->global_lock)
 		acpi_release_global_lock(glk);
@@ -287,7 +287,6 @@
 {
 	int			result = 0;
 	acpi_status		status = AE_OK;
-	unsigned long		flags = 0;
 	u32			glk = 0;
 
 	ACPI_FUNCTION_TRACE("acpi_ec_query");
@@ -308,7 +307,7 @@
 	 * Note that successful completion of the query causes the ACPI_EC_SCI
 	 * bit to be cleared (and thus clearing the interrupt source).
 	 */
-	spin_lock_irqsave(&ec->lock, flags);
+	down(&ec_mutex);
 
 	acpi_hw_low_level_write(8, ACPI_EC_COMMAND_QUERY, &ec->command_addr);
 	result = acpi_ec_wait(ec, ACPI_EC_EVENT_OBF);
@@ -320,7 +319,7 @@
 		result = -ENODATA;
 
 end:
-	spin_unlock_irqrestore(&ec->lock, flags);
+	up(&ec_mutex);
 
 	if (ec->global_lock)
 		acpi_release_global_lock(glk);
@@ -344,7 +343,6 @@
 {
 	struct acpi_ec		*ec = (struct acpi_ec *) ec_cxt;
 	u32			value = 0;
-	unsigned long		flags = 0;
 	static char		object_name[5] = {'_','Q','0','0','\0'};
 	const char		hex[] = {'0','1','2','3','4','5','6','7',
 				         '8','9','A','B','C','D','E','F'};
@@ -354,9 +352,9 @@
 	if (!ec_cxt)
 		goto end;	
 
-	spin_lock_irqsave(&ec->lock, flags);
+	down(&ec_mutex);
 	acpi_hw_low_level_read(8, &value, &ec->command_addr);
-	spin_unlock_irqrestore(&ec->lock, flags);
+	up(&ec_mutex);
 
 	/* TBD: Implement asynch events!
 	 * NOTE: All we care about are EC-SCI's.  Other EC events are
@@ -588,7 +586,6 @@
 
 	ec->handle = device->handle;
 	ec->uid = -1;
-	ec->lock = SPIN_LOCK_UNLOCKED;
 	strcpy(acpi_device_name(device), ACPI_EC_DEVICE_NAME);
 	strcpy(acpi_device_class(device), ACPI_EC_CLASS);
 	acpi_driver_data(device) = ec;
@@ -802,7 +799,6 @@
 	ec_ecdt->status_addr = ecdt_ptr->ec_control;
 	ec_ecdt->data_addr = ecdt_ptr->ec_data;
 	ec_ecdt->gpe_bit = ecdt_ptr->gpe_bit;
-	ec_ecdt->lock = SPIN_LOCK_UNLOCKED;
 	/* use the GL just to be safe */
 	ec_ecdt->global_lock = TRUE;
 	ec_ecdt->uid = ecdt_ptr->uid;


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
