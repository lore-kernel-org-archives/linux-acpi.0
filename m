From: Dmitry Torokhov <dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org>
Subject: Re: [PATCH] Don't disable interrupts during EC access
Date: Wed, 17 Nov 2004 01:55:29 -0500
Message-ID: <200411170155.36801.dtor_core@ameritech.net>
References: <3ACA40606221794F80A5670F0AF15F84041AC082@pdsmsx403> <20041116153709.GA2392@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041116153709.GA2392-B4tOwbsTzaBolqkO4TVVkw@public.gmane.org>
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
Cc: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>, "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Matthew Wilcox <matthew-Ztpu424NOJ8@public.gmane.org>, "Fu, Michael" <michael.fu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tuesday 16 November 2004 10:37 am, Andi Kleen wrote:
> > For detail, please refer to ACPI spec :
> > 12 ? ACPI Embedded Controller Interface Specification.
> 
> Ok. But the problem is not the actual write, but the waiting 
> for the event which takes extremly long on these machines
> (it's not a single broken machine, but has been observed
> on several VIA based laptops). Would it work to only disable
> interrupts during the register write/read, but not during the
> polling delay? 

Actually, the proper solution would be to get rid of polling entirely,
like in the patch below. Could anyone with a box with EC verify that
it works?

Btw, what's up with initializing every variable in ACPI code? It is
not free after all...
 
-- 
Dmitry


===================================================================


ChangeSet@1.1998, 2004-11-17 01:44:59-05:00, dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org
  ACPI: EC - switch from busy-polling to event-based completion
        signalling. EC operations take quite a long time and busy
        polling with interrupts disabled causes big latencies or
        even losing timer interrupts.
        Also get rid of unneeded variable initializations.
  
        Based on patch by Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
  
  Signed-off-by: Dmitry Torokhov <dtor-JGs/UdohzUI@public.gmane.org>


 ec.c |  217 ++++++++++++++++++++++++++++++++++---------------------------------
 1 files changed, 113 insertions(+), 104 deletions(-)


===================================================================



diff -Nru a/drivers/acpi/ec.c b/drivers/acpi/ec.c
--- a/drivers/acpi/ec.c	2004-11-17 01:45:43 -05:00
+++ b/drivers/acpi/ec.c	2004-11-17 01:45:43 -05:00
@@ -31,6 +31,7 @@
 #include <linux/delay.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
+#include <linux/interrupt.h>
 #include <asm/io.h>
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
@@ -51,11 +52,7 @@
 #define ACPI_EC_FLAG_IBF	0x02	/* Input buffer full */
 #define ACPI_EC_FLAG_SCI	0x20	/* EC-SCI occurred */
 
-#define ACPI_EC_EVENT_OBF	0x01	/* Output buffer full */
-#define ACPI_EC_EVENT_IBE	0x02	/* Input buffer empty */
-
-#define ACPI_EC_UDELAY		100	/* Poll @ 100us increments */
-#define ACPI_EC_UDELAY_COUNT	1000	/* Wait 10ms max. during EC ops */
+#define ACPI_EC_DELAY		10	/* Wait 10ms max. during EC ops */
 #define ACPI_EC_UDELAY_GLK	1000	/* Wait 1ms max. to get global lock */
 
 #define ACPI_EC_COMMAND_READ	0x80
@@ -87,7 +84,9 @@
 	struct acpi_generic_address	command_addr;
 	struct acpi_generic_address	data_addr;
 	unsigned long			global_lock;
-	spinlock_t			lock;
+	unsigned int			expect_ibe;
+	struct semaphore		sem;
+	wait_queue_head_t		wait;
 };
 
 /* If we find an EC via the ECDT, we need to keep a ptr to its context */
@@ -100,53 +99,56 @@
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
 
-	/* Poll the EC status register waiting for the event to occur. */
-	switch (event) {
-	case ACPI_EC_EVENT_OBF:
-		do {
-			acpi_hw_low_level_read(8, &acpi_ec_status, &ec->status_addr);
-			if (acpi_ec_status & ACPI_EC_FLAG_OBF)
-				return 0;
-			udelay(ACPI_EC_UDELAY);
-		} while (--i>0);
-		break;
-	case ACPI_EC_EVENT_IBE:
-		do {
-			acpi_hw_low_level_read(8, &acpi_ec_status, &ec->status_addr);
-			if (!(acpi_ec_status & ACPI_EC_FLAG_IBF))
-				return 0;
-			udelay(ACPI_EC_UDELAY);
-		} while (--i>0);
-		break;
-	default:
-		return -EINVAL;
-	}
+static inline void acpi_ec_expect_ibe(struct acpi_ec *ec)
+{
+	ec->expect_ibe = 1;
+	mb();
+}
+
+static int acpi_ec_wait_ibe(struct acpi_ec *ec)
+{
+	int	result;
+
+	result = wait_event_interruptible_timeout(ec->wait,
+				!(acpi_ec_read_status(ec) & ACPI_EC_FLAG_IBF),
+				msecs_to_jiffies(ACPI_EC_DELAY));
+	if (result == 0)
+		result = -ETIME;
 
-	return -ETIME;
+	return result;
 }
 
 
+static int acpi_ec_wait_obf(struct acpi_ec *ec)
+{
+	int	result;
+
+	result = wait_event_interruptible_timeout(ec->wait,
+				(acpi_ec_read_status(ec) & ACPI_EC_FLAG_OBF),
+				msecs_to_jiffies(ACPI_EC_DELAY));
+	if (result == 0)
+		result = -ETIME;
+
+	return result;
+}
+
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
 
@@ -160,27 +162,28 @@
 		if (ACPI_FAILURE(status))
 			return_VALUE(-ENODEV);
 	}
-	
-	spin_lock_irqsave(&ec->lock, flags);
 
+	WARN_ON(in_interrupt());
+	down(&ec->sem);
+
+	acpi_ec_expect_ibe(ec);
 	acpi_hw_low_level_write(8, ACPI_EC_COMMAND_READ, &ec->command_addr);
-	result = acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
-	if (result)
+	result = acpi_ec_wait_ibe(ec);
+	if (result < 0)
 		goto end;
 
 	acpi_hw_low_level_write(8, address, &ec->data_addr);
-	result = acpi_ec_wait(ec, ACPI_EC_EVENT_OBF);
-	if (result)
+	result = acpi_ec_wait_obf(ec);
+	if (result < 0)
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
@@ -195,10 +198,9 @@
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
 
@@ -211,28 +213,32 @@
 			return_VALUE(-ENODEV);
 	}
 
-	spin_lock_irqsave(&ec->lock, flags);
+	WARN_ON(in_interrupt());
+	down(&ec->sem);
 
+	acpi_ec_expect_ibe(ec);
 	acpi_hw_low_level_write(8, ACPI_EC_COMMAND_WRITE, &ec->command_addr);
-	result = acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
-	if (result)
+	result = acpi_ec_wait_ibe(ec);
+	if (result < 0)
 		goto end;
 
+	acpi_ec_expect_ibe(ec);
 	acpi_hw_low_level_write(8, address, &ec->data_addr);
-	result = acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
-	if (result)
+	result = acpi_ec_wait_ibe(ec);
+	if (result < 0)
 		goto end;
 
+	acpi_ec_expect_ibe(ec);
 	acpi_hw_low_level_write(8, data, &ec->data_addr);
-	result = acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
-	if (result)
+	result = acpi_ec_wait_ibe(ec);
+	if (result < 0)
 		goto end;
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Wrote [%02x] to address [%02x]\n",
 		data, address));
 
 end:
-	spin_unlock_irqrestore(&ec->lock, flags);
+	up(&ec->sem);
 
 	if (ec->global_lock)
 		acpi_release_global_lock(glk);
@@ -287,10 +293,9 @@
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
 
@@ -310,19 +315,20 @@
 	 * Note that successful completion of the query causes the ACPI_EC_SCI
 	 * bit to be cleared (and thus clearing the interrupt source).
 	 */
-	spin_lock_irqsave(&ec->lock, flags);
+	WARN_ON(in_interrupt());
+	down(&ec->sem);
 
 	acpi_hw_low_level_write(8, ACPI_EC_COMMAND_QUERY, &ec->command_addr);
-	result = acpi_ec_wait(ec, ACPI_EC_EVENT_OBF);
-	if (result)
+	result = acpi_ec_wait_obf(ec);
+	if (result < 0)
 		goto end;
-	
+
 	acpi_hw_low_level_read(8, data, &ec->data_addr);
 	if (!*data)
 		result = -ENODATA;
 
 end:
-	spin_unlock_irqrestore(&ec->lock, flags);
+	up(&ec->sem);
 
 	if (ec->global_lock)
 		acpi_release_global_lock(glk);
@@ -345,8 +351,7 @@
 	void			*ec_cxt)
 {
 	struct acpi_ec		*ec = (struct acpi_ec *) ec_cxt;
-	u32			value = 0;
-	unsigned long		flags = 0;
+	u32			value;
 	static char		object_name[5] = {'_','Q','0','0','\0'};
 	const char		hex[] = {'0','1','2','3','4','5','6','7',
 				         '8','9','A','B','C','D','E','F'};
@@ -354,11 +359,7 @@
 	ACPI_FUNCTION_TRACE("acpi_ec_gpe_query");
 
 	if (!ec_cxt)
-		goto end;	
-
-	spin_lock_irqsave(&ec->lock, flags);
-	acpi_hw_low_level_read(8, &value, &ec->command_addr);
-	spin_unlock_irqrestore(&ec->lock, flags);
+		goto end;
 
 	/* TBD: Implement asynch events!
 	 * NOTE: All we care about are EC-SCI's.  Other EC events are
@@ -366,12 +367,12 @@
 	 * treat EC-SCIs as level (versus EDGE!) triggered, preventing
 	 *  a purely interrupt-driven approach (grumble, grumble).
 	 */
-	if (!(value & ACPI_EC_FLAG_SCI))
+	if (!(acpi_ec_read_status(ec) & ACPI_EC_FLAG_SCI))
 		goto end;
 
 	if (acpi_ec_query(ec, &value))
 		goto end;
-	
+
 	object_name[2] = hex[((value >> 4) & 0x0F)];
 	object_name[3] = hex[(value & 0x0F)];
 
@@ -388,6 +389,7 @@
 	void			*data)
 {
 	acpi_status		status = AE_OK;
+	u32			value;
 	struct acpi_ec		*ec = (struct acpi_ec *) data;
 
 	if (!ec)
@@ -395,13 +397,20 @@
 
 	acpi_disable_gpe(NULL, ec->gpe_bit, ACPI_ISR);
 
-	status = acpi_os_queue_for_execution(OSD_PRIORITY_GPE,
-		acpi_ec_gpe_query, ec);
+	value = acpi_ec_read_status(ec);
 
-	if (status == AE_OK)
-		return ACPI_INTERRUPT_HANDLED;
-	else
-		return ACPI_INTERRUPT_NOT_HANDLED;
+	if ((value & ACPI_EC_FLAG_OBF) ||
+	    (ec->expect_ibe && !(value & ACPI_EC_FLAG_IBF))) {
+		ec->expect_ibe = 0;
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
@@ -419,10 +428,8 @@
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
@@ -437,9 +444,9 @@
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
 
@@ -529,7 +536,7 @@
 acpi_ec_add_fs (
 	struct acpi_device	*device)
 {
-	struct proc_dir_entry	*entry = NULL;
+	struct proc_dir_entry	*entry;
 
 	ACPI_FUNCTION_TRACE("acpi_ec_add_fs");
 
@@ -580,9 +587,9 @@
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
@@ -597,7 +604,8 @@
 
 	ec->handle = device->handle;
 	ec->uid = -1;
-	ec->lock = SPIN_LOCK_UNLOCKED;
+	init_MUTEX(&ec->sem);
+	init_waitqueue_head(&ec->wait);
 	strcpy(acpi_device_name(device), ACPI_EC_DEVICE_NAME);
 	strcpy(acpi_device_class(device), ACPI_EC_CLASS);
 	acpi_driver_data(device) = ec;
@@ -611,7 +619,7 @@
 	if (ec_ecdt && ec_ecdt->uid == uid) {
 		acpi_remove_address_space_handler(ACPI_ROOT_OBJECT,
 			ACPI_ADR_SPACE_EC, &acpi_ec_space_handler);
-	
+
 		acpi_remove_gpe_handler(NULL, ec_ecdt->gpe_bit, &acpi_ec_gpe_handler);
 
 		kfree(ec_ecdt);
@@ -651,7 +659,7 @@
 	struct acpi_device	*device,
 	int			type)
 {
-	struct acpi_ec		*ec = NULL;
+	struct acpi_ec		*ec;
 
 	ACPI_FUNCTION_TRACE("acpi_ec_remove");
 
@@ -706,8 +714,8 @@
 acpi_ec_start (
 	struct acpi_device	*device)
 {
-	acpi_status		status = AE_OK;
-	struct acpi_ec		*ec = NULL;
+	acpi_status		status;
+	struct acpi_ec		*ec;
 
 	ACPI_FUNCTION_TRACE("acpi_ec_start");
 
@@ -763,8 +771,8 @@
 	struct acpi_device	*device,
 	int			type)
 {
-	acpi_status		status = AE_OK;
-	struct acpi_ec		*ec = NULL;
+	acpi_status		status;
+	struct acpi_ec		*ec;
 
 	ACPI_FUNCTION_TRACE("acpi_ec_stop");
 
@@ -792,7 +800,7 @@
 	acpi_status		status;
 	struct acpi_table_ecdt 	*ecdt_ptr;
 
-	status = acpi_get_firmware_table("ECDT", 1, ACPI_LOGICAL_ADDRESSING, 
+	status = acpi_get_firmware_table("ECDT", 1, ACPI_LOGICAL_ADDRESSING,
 		(struct acpi_table_header **) &ecdt_ptr);
 	if (ACPI_FAILURE(status))
 		return 0;
@@ -807,11 +815,12 @@
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
@@ -855,7 +864,7 @@
 
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
