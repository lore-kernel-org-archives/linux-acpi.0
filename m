From: Dmitry Torokhov <dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org>
Subject: Re: [PATCH] Don't disable interrupts during EC access
Date: Thu, 18 Nov 2004 01:14:29 -0500
Message-ID: <200411180114.31434.dtor_core@ameritech.net>
References: <3ACA40606221794F80A5670F0AF15F84041AC08B@pdsmsx403> <200411170302.58634.dtor_core@ameritech.net> <1100728389.993.23.camel@d845pe>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1100728389.993.23.camel@d845pe>
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
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Luming Yu <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>, Matthew Wilcox <matthew-Ztpu424NOJ8@public.gmane.org>, Michael Fu <michael.fu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Robert Moore <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wednesday 17 November 2004 04:53 pm, Len Brown wrote:
> just to add some fuel to this fire,
> here is an example of where we don't wait long enough for the EC:
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=2845
> 
> 

Ok, so here is the new version that tries to hanle level-triggered SCIs
while using event signalling instead of polling.

Since we serialize access to EC via ec->sem semaphore there can be only
one reader/writer at one time so they can not race with each other.
acpi_ec_gpe_query() also holds ec->sem until EC is queried which should
reset SCI condition. The only poblem window that I see is when there is
an SCI was raised and acpi_ec_gpe_handler() scheduled acpi_ec_gpe_query()
and there comes a reader or writer. To take care of it instead of doing
normal "down" in acpi_ec_gpe_query() we will do down_trylock(). If it is 
unsuccessful that means that other thread is waiting on IO completion and
we will do the soft polling (interrupts enabled) for it and wake it up
when IO completes.

Am I missing somethig?

Please give it a try - it compiles but since I don't have EC I am not
able to test it. 

-- 
Dmitry


===================================================================


ChangeSet@1.2001, 2004-11-18 01:11:46-05:00, dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org
  ACPI: EC - switch from busy-polling to event-based completion
        signalling. EC operations take quite a long time and busy
        polling with interrupts disabled causes big latencies or
        even losing timer interrupts.
        EC IO timeout has been increased from 10 to 50ms.
        Also get rid of unneeded variable initializations.
  
        Based on patch by Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
  
  Signed-off-by: Dmitry Torokhov <dtor-JGs/UdohzUI@public.gmane.org>


 ec.c |  222 ++++++++++++++++++++++++++++++++++++++-----------------------------
 1 files changed, 126 insertions(+), 96 deletions(-)


===================================================================



diff -Nru a/drivers/acpi/ec.c b/drivers/acpi/ec.c
--- a/drivers/acpi/ec.c	2004-11-18 01:13:03 -05:00
+++ b/drivers/acpi/ec.c	2004-11-18 01:13:03 -05:00
@@ -31,6 +31,7 @@
 #include <linux/delay.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
+#include <linux/interrupt.h>
 #include <asm/io.h>
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
@@ -54,8 +55,7 @@
 #define ACPI_EC_EVENT_OBF	0x01	/* Output buffer full */
 #define ACPI_EC_EVENT_IBE	0x02	/* Input buffer empty */
 
-#define ACPI_EC_UDELAY		100	/* Poll @ 100us increments */
-#define ACPI_EC_UDELAY_COUNT	1000	/* Wait 10ms max. during EC ops */
+#define ACPI_EC_DELAY		50	/* Wait 50ms max. during EC ops */
 #define ACPI_EC_UDELAY_GLK	1000	/* Wait 1ms max. to get global lock */
 
 #define ACPI_EC_COMMAND_READ	0x80
@@ -87,7 +87,9 @@
 	struct acpi_generic_address	command_addr;
 	struct acpi_generic_address	data_addr;
 	unsigned long			global_lock;
-	spinlock_t			lock;
+	unsigned int			expect_event;
+	struct semaphore		sem;
+	wait_queue_head_t		wait;
 };
 
 /* If we find an EC via the ECDT, we need to keep a ptr to its context */
@@ -100,53 +102,59 @@
                              Transaction Management
    -------------------------------------------------------------------------- */
 
-static int
-acpi_ec_wait (
-	struct acpi_ec		*ec,
-	u8			event)
+static inline u32 acpi_ec_read_status(struct acpi_ec *ec)
 {
-	u32			acpi_ec_status = 0;
-	u32			i = ACPI_EC_UDELAY_COUNT;
+	u32	status = 0;
 
-	if (!ec)
-		return -EINVAL;
+	acpi_hw_low_level_read(8, &status, &ec->status_addr);
+	return status;
+}
+
+static int acpi_ec_wait(struct acpi_ec *ec, unsigned int event)
+{
+	int	result;
 
-	/* Poll the EC status register waiting for the event to occur. */
+	ec->expect_event = event;
+	smp_mb();
+
+	result = wait_event_interruptible_timeout(ec->wait,
+					!ec->expect_event,
+					msecs_to_jiffies(ACPI_EC_DELAY));
+	ec->expect_event = 0;
+	smp_mb();
+
+	if (result < 0)
+		return result;
+
+	/*
+	 * Verify that the event in question has actually happened by
+	 * querying EC status. Do the check even if operation timed-out
+	 * to make sure that we did not miss interrupt.
+	 */
 	switch (event) {
 	case ACPI_EC_EVENT_OBF:
-		do {
-			acpi_hw_low_level_read(8, &acpi_ec_status, &ec->status_addr);
-			if (acpi_ec_status & ACPI_EC_FLAG_OBF)
-				return 0;
-			udelay(ACPI_EC_UDELAY);
-		} while (--i>0);
+		if (acpi_ec_read_status(ec) & ACPI_EC_FLAG_OBF)
+			return 0;
 		break;
+
 	case ACPI_EC_EVENT_IBE:
-		do {
-			acpi_hw_low_level_read(8, &acpi_ec_status, &ec->status_addr);
-			if (!(acpi_ec_status & ACPI_EC_FLAG_IBF))
-				return 0;
-			udelay(ACPI_EC_UDELAY);
-		} while (--i>0);
+		if (~acpi_ec_read_status(ec) & ACPI_EC_FLAG_IBF)
+			return 0;
 		break;
-	default:
-		return -EINVAL;
 	}
 
 	return -ETIME;
 }
 
-
 static int
 acpi_ec_read (
 	struct acpi_ec		*ec,
 	u8			address,
 	u32			*data)
 {
-	acpi_status		status = AE_OK;
-	int			result = 0;
-	unsigned long		flags = 0;
-	u32			glk = 0;
+	acpi_status		status;
+	int			result;
+	u32			glk;
 
 	ACPI_FUNCTION_TRACE("acpi_ec_read");
 
@@ -160,8 +168,9 @@
 		if (ACPI_FAILURE(status))
 			return_VALUE(-ENODEV);
 	}
-	
-	spin_lock_irqsave(&ec->lock, flags);
+
+	WARN_ON(in_interrupt());
+	down(&ec->sem);
 
 	acpi_hw_low_level_write(8, ACPI_EC_COMMAND_READ, &ec->command_addr);
 	result = acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
@@ -173,14 +182,13 @@
 	if (result)
 		goto end;
 
-
 	acpi_hw_low_level_read(8, data, &ec->data_addr);
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Read [%02x] from address [%02x]\n",
 		*data, address));
 
 end:
-	spin_unlock_irqrestore(&ec->lock, flags);
+	up(&ec->sem);
 
 	if (ec->global_lock)
 		acpi_release_global_lock(glk);
@@ -195,10 +203,9 @@
 	u8			address,
 	u8			data)
 {
-	int			result = 0;
-	acpi_status		status = AE_OK;
-	unsigned long		flags = 0;
-	u32			glk = 0;
+	int			result;
+	acpi_status		status;
+	u32			glk;
 
 	ACPI_FUNCTION_TRACE("acpi_ec_write");
 
@@ -211,7 +218,8 @@
 			return_VALUE(-ENODEV);
 	}
 
-	spin_lock_irqsave(&ec->lock, flags);
+	WARN_ON(in_interrupt());
+	down(&ec->sem);
 
 	acpi_hw_low_level_write(8, ACPI_EC_COMMAND_WRITE, &ec->command_addr);
 	result = acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
@@ -232,7 +240,7 @@
 		data, address));
 
 end:
-	spin_unlock_irqrestore(&ec->lock, flags);
+	up(&ec->sem);
 
 	if (ec->global_lock)
 		acpi_release_global_lock(glk);
@@ -287,10 +295,9 @@
 	struct acpi_ec		*ec,
 	u32			*data)
 {
-	int			result = 0;
-	acpi_status		status = AE_OK;
-	unsigned long		flags = 0;
-	u32			glk = 0;
+	int			result;
+	acpi_status		status;
+	u32			glk;
 
 	ACPI_FUNCTION_TRACE("acpi_ec_query");
 
@@ -310,20 +317,16 @@
 	 * Note that successful completion of the query causes the ACPI_EC_SCI
 	 * bit to be cleared (and thus clearing the interrupt source).
 	 */
-	spin_lock_irqsave(&ec->lock, flags);
-
 	acpi_hw_low_level_write(8, ACPI_EC_COMMAND_QUERY, &ec->command_addr);
 	result = acpi_ec_wait(ec, ACPI_EC_EVENT_OBF);
 	if (result)
 		goto end;
-	
+
 	acpi_hw_low_level_read(8, data, &ec->data_addr);
 	if (!*data)
 		result = -ENODATA;
 
 end:
-	spin_unlock_irqrestore(&ec->lock, flags);
-
 	if (ec->global_lock)
 		acpi_release_global_lock(glk);
 
@@ -345,33 +348,50 @@
 	void			*ec_cxt)
 {
 	struct acpi_ec		*ec = (struct acpi_ec *) ec_cxt;
-	u32			value = 0;
-	unsigned long		flags = 0;
+	u32			value;
+	int			result = -ENODATA;
 	static char		object_name[5] = {'_','Q','0','0','\0'};
 	const char		hex[] = {'0','1','2','3','4','5','6','7',
 				         '8','9','A','B','C','D','E','F'};
 
 	ACPI_FUNCTION_TRACE("acpi_ec_gpe_query");
 
-	if (!ec_cxt)
-		goto end;	
-
-	spin_lock_irqsave(&ec->lock, flags);
-	acpi_hw_low_level_read(8, &value, &ec->command_addr);
-	spin_unlock_irqrestore(&ec->lock, flags);
-
-	/* TBD: Implement asynch events!
-	 * NOTE: All we care about are EC-SCI's.  Other EC events are
-	 * handled via polling (yuck!).  This is because some systems
-	 * treat EC-SCIs as level (versus EDGE!) triggered, preventing
-	 *  a purely interrupt-driven approach (grumble, grumble).
+	/*
+	 * Because some systems treat EC-SCIs as level (versus EDGE!)
+	 * triggered we can not just check SCI flag here. If there is
+	 * a reader/writer waiting on response we need to wait till
+	 * data is available and wake it up. Only when there is no
+	 * outstanding requests we can finally service SCI.
 	 */
-	if (!(value & ACPI_EC_FLAG_SCI))
-		goto end;
 
-	if (acpi_ec_query(ec, &value))
+	while (unlikely(down_trylock(&ec->sem))) {
+
+		/* Reader or writer is waiting holding ec->sem */
+		value = acpi_ec_read_status(ec);
+
+		if ((ec->expect_event == ACPI_EC_EVENT_OBF &&
+					(value & ACPI_EC_FLAG_OBF)) ||
+		    (ec->expect_event == ACPI_EC_EVENT_IBE &&
+					!(value & ACPI_EC_FLAG_IBF))) {
+			ec->expect_event = 0;
+			wake_up(&ec->wait);
+		}
+
+		/*
+		 * Even if we never get IBE/OBF condition client
+		 * will eventually time out allowing us proceed.
+		 */
+		msleep(1);
+	}
+
+	if (acpi_ec_read_status(ec) & ACPI_EC_FLAG_SCI)
+		result = acpi_ec_query(ec, &value);
+
+	up(&ec->sem);
+
+	if (result)
 		goto end;
-	
+
 	object_name[2] = hex[((value >> 4) & 0x0F)];
 	object_name[3] = hex[(value & 0x0F)];
 
@@ -388,6 +408,7 @@
 	void			*data)
 {
 	acpi_status		status = AE_OK;
+	u32			value;
 	struct acpi_ec		*ec = (struct acpi_ec *) data;
 
 	if (!ec)
@@ -395,13 +416,22 @@
 
 	acpi_disable_gpe(NULL, ec->gpe_bit, ACPI_ISR);
 
-	status = acpi_os_queue_for_execution(OSD_PRIORITY_GPE,
-		acpi_ec_gpe_query, ec);
+	value = acpi_ec_read_status(ec);
 
-	if (status == AE_OK)
-		return ACPI_INTERRUPT_HANDLED;
-	else
-		return ACPI_INTERRUPT_NOT_HANDLED;
+	if ((ec->expect_event == ACPI_EC_EVENT_OBF &&
+				(value & ACPI_EC_FLAG_OBF)) ||
+	    (ec->expect_event == ACPI_EC_EVENT_IBE &&
+				!(value & ACPI_EC_FLAG_IBF))) {
+		ec->expect_event = 0;
+		wake_up(&ec->wait);
+	}
+
+	if (value & ACPI_EC_FLAG_SCI)
+		status = acpi_os_queue_for_execution(OSD_PRIORITY_GPE,
+						acpi_ec_gpe_query, ec);
+
+	return status == AE_OK ?
+		ACPI_INTERRUPT_HANDLED : ACPI_INTERRUPT_NOT_HANDLED;
 }
 
 /* --------------------------------------------------------------------------
@@ -419,10 +449,8 @@
 	 * The EC object is in the handler context and is needed
 	 * when calling the acpi_ec_space_handler.
 	 */
-	if(function == ACPI_REGION_DEACTIVATE) 
-		*return_context = NULL;
-	else 
-		*return_context = handler_context;
+	*return_context  = (function != ACPI_REGION_DEACTIVATE) ?
+						handler_context : NULL;
 
 	return AE_OK;
 }
@@ -437,9 +465,9 @@
 	void			*handler_context,
 	void			*region_context)
 {
-	int			result = 0;
-	struct acpi_ec		*ec = NULL;
-	u32			temp = 0;
+	int			result;
+	struct acpi_ec		*ec;
+	u32			temp;
 
 	ACPI_FUNCTION_TRACE("acpi_ec_space_handler");
 
@@ -506,7 +534,7 @@
 	seq_printf(seq, "ports:                   0x%02x, 0x%02x\n",
 		(u32) ec->status_addr.address, (u32) ec->data_addr.address);
 	seq_printf(seq, "use global lock:         %s\n",
-		ec->global_lock?"yes":"no");
+		ec->global_lock ? "yes" : "no");
 
 end:
 	return_VALUE(0);
@@ -529,7 +557,7 @@
 acpi_ec_add_fs (
 	struct acpi_device	*device)
 {
-	struct proc_dir_entry	*entry = NULL;
+	struct proc_dir_entry	*entry;
 
 	ACPI_FUNCTION_TRACE("acpi_ec_add_fs");
 
@@ -580,9 +608,9 @@
 acpi_ec_add (
 	struct acpi_device	*device)
 {
-	int			result = 0;
-	acpi_status		status = AE_OK;
-	struct acpi_ec		*ec = NULL;
+	int			result;
+	acpi_status		status;
+	struct acpi_ec		*ec;
 	unsigned long		uid;
 
 	ACPI_FUNCTION_TRACE("acpi_ec_add");
@@ -597,7 +625,8 @@
 
 	ec->handle = device->handle;
 	ec->uid = -1;
-	ec->lock = SPIN_LOCK_UNLOCKED;
+	init_MUTEX(&ec->sem);
+	init_waitqueue_head(&ec->wait);
 	strcpy(acpi_device_name(device), ACPI_EC_DEVICE_NAME);
 	strcpy(acpi_device_class(device), ACPI_EC_CLASS);
 	acpi_driver_data(device) = ec;
@@ -611,7 +640,7 @@
 	if (ec_ecdt && ec_ecdt->uid == uid) {
 		acpi_remove_address_space_handler(ACPI_ROOT_OBJECT,
 			ACPI_ADR_SPACE_EC, &acpi_ec_space_handler);
-	
+
 		acpi_remove_gpe_handler(NULL, ec_ecdt->gpe_bit, &acpi_ec_gpe_handler);
 
 		kfree(ec_ecdt);
@@ -651,7 +680,7 @@
 	struct acpi_device	*device,
 	int			type)
 {
-	struct acpi_ec		*ec = NULL;
+	struct acpi_ec		*ec;
 
 	ACPI_FUNCTION_TRACE("acpi_ec_remove");
 
@@ -706,8 +735,8 @@
 acpi_ec_start (
 	struct acpi_device	*device)
 {
-	acpi_status		status = AE_OK;
-	struct acpi_ec		*ec = NULL;
+	acpi_status		status;
+	struct acpi_ec		*ec;
 
 	ACPI_FUNCTION_TRACE("acpi_ec_start");
 
@@ -763,8 +792,8 @@
 	struct acpi_device	*device,
 	int			type)
 {
-	acpi_status		status = AE_OK;
-	struct acpi_ec		*ec = NULL;
+	acpi_status		status;
+	struct acpi_ec		*ec;
 
 	ACPI_FUNCTION_TRACE("acpi_ec_stop");
 
@@ -792,7 +821,7 @@
 	acpi_status		status;
 	struct acpi_table_ecdt 	*ecdt_ptr;
 
-	status = acpi_get_firmware_table("ECDT", 1, ACPI_LOGICAL_ADDRESSING, 
+	status = acpi_get_firmware_table("ECDT", 1, ACPI_LOGICAL_ADDRESSING,
 		(struct acpi_table_header **) &ecdt_ptr);
 	if (ACPI_FAILURE(status))
 		return 0;
@@ -807,11 +836,12 @@
 		return -ENOMEM;
 	memset(ec_ecdt, 0, sizeof(struct acpi_ec));
 
+	init_MUTEX(&ec_ecdt->sem);
+	init_waitqueue_head(&ec_ecdt->wait);
 	ec_ecdt->command_addr = ecdt_ptr->ec_control;
 	ec_ecdt->status_addr = ecdt_ptr->ec_control;
 	ec_ecdt->data_addr = ecdt_ptr->ec_data;
 	ec_ecdt->gpe_bit = ecdt_ptr->gpe_bit;
-	ec_ecdt->lock = SPIN_LOCK_UNLOCKED;
 	/* use the GL just to be safe */
 	ec_ecdt->global_lock = TRUE;
 	ec_ecdt->uid = ecdt_ptr->uid;
@@ -855,7 +885,7 @@
 
 static int __init acpi_ec_init (void)
 {
-	int			result = 0;
+	int			result;
 
 	ACPI_FUNCTION_TRACE("acpi_ec_init");
 


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
