From: Rich Townsend <rhdt-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
Subject: [PATCH] Change spinlock mutex to semaphor in ec.c
Date: Thu, 03 Feb 2005 19:24:04 -0500
Message-ID: <4202C0A4.1020700@bartol.udel.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010200070303070106050800"
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------010200070303070106050800
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi all --

Attached is a patch against the 2.6.10 kernel, to convert the mutexing 
in the embdedded controller driver from a spinlock to a semaphore. The 
rationale behind this is to permit sleeping inside the acpi_ec_wait() 
polling routine.

The way things are done at the moment, the pause between each poll of 
the EC is done using udelay(). Unfortunately, a typical SMBus access via 
the EC takes around 3ms, during which interrupts cannot be serviced. In 
my smart battery driver, each read of the battery status takes 5 SMBus 
transactions, so we have a total 15ms of interrupt deadtime. Considering 
that typical monitoring tools (e.g., gkrellm, wmacpi) will read the 
battery every few seconds, we can see that we are almost certain to 
start losing interrupts. And we do; using my most recent version of the 
smart battery driver, I get lost keystrokes all over the place.

This patch changes the spinlock mutexes into semaphores, which in turn 
allows msleep() calls to replace the udelay() calls in acpi_ec_wait. 
I've found that this seems to work great; no more lost keystrokes (or at 
least, a reduction to the point where I can't distinguish them from my 
own bad typing), and my system hasn't exploded yet.

I'll be including this patch when I release the new DSDT stuff for smart 
batteries (should be ready by the weekend, just doing final testing); 
but I'd appreciate some input as to whether this patch is OK, or whether 
I've done a Very Bad Thing.

cheers,

Rich

--------------010200070303070106050800
Content-Type: text/plain;
 name="acpi-ec-nospinlock-2.6.10.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="acpi-ec-nospinlock-2.6.10.diff"

diff -Nurp linux-2.6.10/drivers/acpi/ec.c linux-2.6.10-ec-nospinlock/drivers/acpi/ec.c
--- linux-2.6.10/drivers/acpi/ec.c	2004-12-24 16:34:58.000000000 -0500
+++ linux-2.6.10-ec-nospinlock/drivers/acpi/ec.c	2005-02-03 19:01:25.490539512 -0500
@@ -31,6 +31,7 @@
 #include <linux/delay.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
+#include <asm/semaphore.h>
 #include <asm/io.h>
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
@@ -54,8 +55,8 @@ ACPI_MODULE_NAME		("acpi_ec")
 #define ACPI_EC_EVENT_OBF	0x01	/* Output buffer full */
 #define ACPI_EC_EVENT_IBE	0x02	/* Input buffer empty */
 
-#define ACPI_EC_UDELAY		100	/* Poll @ 100us increments */
-#define ACPI_EC_UDELAY_COUNT	1000	/* Wait 10ms max. during EC ops */
+#define ACPI_EC_MSLEEP		1	/* Sleep 1ms between polling */
+#define ACPI_EC_MSLEEP_COUNT	10	/* Wait 10ms max. during EC ops */
 #define ACPI_EC_UDELAY_GLK	1000	/* Wait 1ms max. to get global lock */
 
 #define ACPI_EC_COMMAND_READ	0x80
@@ -87,7 +88,7 @@ struct acpi_ec {
 	struct acpi_generic_address	command_addr;
 	struct acpi_generic_address	data_addr;
 	unsigned long			global_lock;
-	spinlock_t			lock;
+	struct semaphore		sem;
 };
 
 /* If we find an EC via the ECDT, we need to keep a ptr to its context */
@@ -106,7 +107,7 @@ acpi_ec_wait (
 	u8			event)
 {
 	u32			acpi_ec_status = 0;
-	u32			i = ACPI_EC_UDELAY_COUNT;
+	u32			i = ACPI_EC_MSLEEP_COUNT;
 
 	if (!ec)
 		return -EINVAL;
@@ -118,7 +119,7 @@ acpi_ec_wait (
 			acpi_hw_low_level_read(8, &acpi_ec_status, &ec->status_addr);
 			if (acpi_ec_status & ACPI_EC_FLAG_OBF)
 				return 0;
-			udelay(ACPI_EC_UDELAY);
+			msleep(ACPI_EC_MSLEEP);
 		} while (--i>0);
 		break;
 	case ACPI_EC_EVENT_IBE:
@@ -126,7 +127,7 @@ acpi_ec_wait (
 			acpi_hw_low_level_read(8, &acpi_ec_status, &ec->status_addr);
 			if (!(acpi_ec_status & ACPI_EC_FLAG_IBF))
 				return 0;
-			udelay(ACPI_EC_UDELAY);
+			msleep(ACPI_EC_MSLEEP);
 		} while (--i>0);
 		break;
 	default:
@@ -137,7 +138,7 @@ acpi_ec_wait (
 }
 
 
-static int
+int
 acpi_ec_read (
 	struct acpi_ec		*ec,
 	u8			address,
@@ -145,7 +146,6 @@ acpi_ec_read (
 {
 	acpi_status		status = AE_OK;
 	int			result = 0;
-	unsigned long		flags = 0;
 	u32			glk = 0;
 
 	ACPI_FUNCTION_TRACE("acpi_ec_read");
@@ -160,9 +160,12 @@ acpi_ec_read (
 		if (ACPI_FAILURE(status))
 			return_VALUE(-ENODEV);
 	}
-	
-	spin_lock_irqsave(&ec->lock, flags);
 
+	if (down_interruptible (&ec->sem)) {
+		result = -ERESTARTSYS;
+		goto end_nosem;
+	}
+	
 	acpi_hw_low_level_write(8, ACPI_EC_COMMAND_READ, &ec->command_addr);
 	result = acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
 	if (result)
@@ -180,16 +183,15 @@ acpi_ec_read (
 		*data, address));
 
 end:
-	spin_unlock_irqrestore(&ec->lock, flags);
-
+	up (&ec->sem);
+end_nosem:
 	if (ec->global_lock)
 		acpi_release_global_lock(glk);
 
 	return_VALUE(result);
 }
 
-
-static int
+int
 acpi_ec_write (
 	struct acpi_ec		*ec,
 	u8			address,
@@ -197,7 +199,6 @@ acpi_ec_write (
 {
 	int			result = 0;
 	acpi_status		status = AE_OK;
-	unsigned long		flags = 0;
 	u32			glk = 0;
 
 	ACPI_FUNCTION_TRACE("acpi_ec_write");
@@ -211,8 +212,11 @@ acpi_ec_write (
 			return_VALUE(-ENODEV);
 	}
 
-	spin_lock_irqsave(&ec->lock, flags);
-
+	if (down_interruptible (&ec->sem)) {
+		result = -ERESTARTSYS;
+		goto end_nosem;
+	}
+	
 	acpi_hw_low_level_write(8, ACPI_EC_COMMAND_WRITE, &ec->command_addr);
 	result = acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
 	if (result)
@@ -232,8 +236,8 @@ acpi_ec_write (
 		data, address));
 
 end:
-	spin_unlock_irqrestore(&ec->lock, flags);
-
+	up (&ec->sem);
+end_nosem:
 	if (ec->global_lock)
 		acpi_release_global_lock(glk);
 
@@ -291,7 +295,6 @@ acpi_ec_query (
 {
 	int			result = 0;
 	acpi_status		status = AE_OK;
-	unsigned long		flags = 0;
 	u32			glk = 0;
 
 	ACPI_FUNCTION_TRACE("acpi_ec_query");
@@ -312,8 +315,11 @@ acpi_ec_query (
 	 * Note that successful completion of the query causes the ACPI_EC_SCI
 	 * bit to be cleared (and thus clearing the interrupt source).
 	 */
-	spin_lock_irqsave(&ec->lock, flags);
-
+	if (down_interruptible (&ec->sem)) {
+		result = -ERESTARTSYS;
+		goto end_nosem;
+	}
+	
 	acpi_hw_low_level_write(8, ACPI_EC_COMMAND_QUERY, &ec->command_addr);
 	result = acpi_ec_wait(ec, ACPI_EC_EVENT_OBF);
 	if (result)
@@ -324,8 +330,8 @@ acpi_ec_query (
 		result = -ENODATA;
 
 end:
-	spin_unlock_irqrestore(&ec->lock, flags);
-
+	up (&ec->sem);
+end_nosem:
 	if (ec->global_lock)
 		acpi_release_global_lock(glk);
 
@@ -348,7 +354,6 @@ acpi_ec_gpe_query (
 {
 	struct acpi_ec		*ec = (struct acpi_ec *) ec_cxt;
 	u32			value = 0;
-	unsigned long		flags = 0;
 	static char		object_name[5] = {'_','Q','0','0','\0'};
 	const char		hex[] = {'0','1','2','3','4','5','6','7',
 				         '8','9','A','B','C','D','E','F'};
@@ -358,9 +363,11 @@ acpi_ec_gpe_query (
 	if (!ec_cxt)
 		goto end;	
 
-	spin_lock_irqsave(&ec->lock, flags);
+	if (down_interruptible (&ec->sem)) {
+		return_VOID;
+	}
 	acpi_hw_low_level_read(8, &value, &ec->command_addr);
-	spin_unlock_irqrestore(&ec->lock, flags);
+	up (&ec->sem);
 
 	/* TBD: Implement asynch events!
 	 * NOTE: All we care about are EC-SCI's.  Other EC events are
@@ -599,7 +606,7 @@ acpi_ec_add (
 
 	ec->handle = device->handle;
 	ec->uid = -1;
-	ec->lock = SPIN_LOCK_UNLOCKED;
+	sema_init(&ec->sem, 1);
 	strcpy(acpi_device_name(device), ACPI_EC_DEVICE_NAME);
 	strcpy(acpi_device_class(device), ACPI_EC_CLASS);
 	acpi_driver_data(device) = ec;
@@ -813,7 +820,7 @@ acpi_ec_ecdt_probe (void)
 	ec_ecdt->status_addr = ecdt_ptr->ec_control;
 	ec_ecdt->data_addr = ecdt_ptr->ec_data;
 	ec_ecdt->gpe_bit = ecdt_ptr->gpe_bit;
-	ec_ecdt->lock = SPIN_LOCK_UNLOCKED;
+	sema_init(&ec_ecdt->sem, 1);
 	/* use the GL just to be safe */
 	ec_ecdt->global_lock = TRUE;
 	ec_ecdt->uid = ecdt_ptr->uid;

--------------010200070303070106050800--


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
