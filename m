From: Dmitry Torokhov <dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org>
Subject: Re: [PATCH] Change spinlock mutex to semaphor in ec.c
Date: Fri, 4 Feb 2005 00:55:53 -0500
Message-ID: <200502040055.53765.dtor_core@ameritech.net>
References: <4202C0A4.1020700@bartol.udel.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
In-Reply-To: <4202C0A4.1020700-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
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
Cc: Rich Townsend <rhdt-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thursday 03 February 2005 19:24, Rich Townsend wrote:
> Hi all --
> 
> Attached is a patch against the 2.6.10 kernel, to convert the mutexing 
> in the embdedded controller driver from a spinlock to a semaphore. The 
> rationale behind this is to permit sleeping inside the acpi_ec_wait() 
> polling routine.
> 

Hi,

Last time such patch was proposed there were some concerns regarding
possible interrupt storm, see the follwing thread:

http://marc.theaimsgroup.com/?l=acpi4linux&m=110055992814866&w=2

I have an alternative patch that tries to address these concerns,
unfortunately I do not have a box with EC controller so it is
completely untested.

-- 
Dmitry


===================================================================


ChangeSet@1.1997, 2005-02-04 00:43:27-05:00, dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org
  ACPI: EC - switch from busy-polling to event-based completion
        signalling. EC operations take quite a long time and busy
        polling with interrupts disabled causes big latencies or
        even losing timer interrupts.
        EC IO timeout has been increased from 10 to 50ms.
        Also get rid of unneeded variable initializations.
  
        Based on patch by Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
  
  Signed-off-by: Dmitry Torokhov <dtor-JGs/UdohzUI@public.gmane.org>


 ec.c |  264 +++++++++++++++++++++++++++++++++++--------------------------------
 1 files changed, 141 insertions(+), 123 deletions(-)


===================================================================



diff -Nru a/drivers/acpi/ec.c b/drivers/acpi/ec.c
--- a/drivers/acpi/ec.c	2005-02-04 00:47:16 -05:00
+++ b/drivers/acpi/ec.c	2005-02-04 00:47:16 -05:00
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
+#define ACPI_EC_DELAY		50	/* Wait 50ms max. during EC ops */
 #define ACPI_EC_UDELAY_GLK	1000	/* Wait 1ms max. to get global lock */
 
 #define ACPI_EC_COMMAND_READ	0x80
@@ -86,8 +83,11 @@
 	struct acpi_generic_address	status_addr;
 	struct acpi_generic_address	command_addr;
 	struct acpi_generic_address	data_addr;
+	u32				data;
 	unsigned long			global_lock;
-	spinlock_t			lock;
+	unsigned int			rw_in_progress;
+	struct semaphore		sem;
+	wait_queue_head_t		wait;
 };
 
 /* If we find an EC via the ECDT, we need to keep a ptr to its context */
@@ -100,53 +100,40 @@
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
+static inline void acpi_ec_prepare_for_wait(struct acpi_ec *ec)
+{
+	ec->rw_in_progress = 1;
+	mb();
+}
+
+static int acpi_ec_wait(struct acpi_ec *ec)
+{
+	if (wait_event_timeout(ec->wait, !ec->rw_in_progress,
+				msecs_to_jiffies(ACPI_EC_DELAY)) == 0) {
+		ec->rw_in_progress = 0;
+		return -ETIME;
 	}
 
-	return -ETIME;
+	return 0;
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
 
@@ -160,27 +147,29 @@
 		if (ACPI_FAILURE(status))
 			return_VALUE(-ENODEV);
 	}
-	
-	spin_lock_irqsave(&ec->lock, flags);
 
+	WARN_ON(in_interrupt());
+	down(&ec->sem);
+
+	acpi_ec_prepare_for_wait(ec);
 	acpi_hw_low_level_write(8, ACPI_EC_COMMAND_READ, &ec->command_addr);
-	result = acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
+	result = acpi_ec_wait(ec);
 	if (result)
 		goto end;
 
+	acpi_ec_prepare_for_wait(ec);
 	acpi_hw_low_level_write(8, address, &ec->data_addr);
-	result = acpi_ec_wait(ec, ACPI_EC_EVENT_OBF);
+	result = acpi_ec_wait(ec);
 	if (result)
 		goto end;
 
-
-	acpi_hw_low_level_read(8, data, &ec->data_addr);
+	*data = ec->data;
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Read [%02x] from address [%02x]\n",
 		*data, address));
 
 end:
-	spin_unlock_irqrestore(&ec->lock, flags);
+	up(&ec->sem);
 
 	if (ec->global_lock)
 		acpi_release_global_lock(glk);
@@ -195,10 +184,9 @@
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
 
@@ -211,20 +199,24 @@
 			return_VALUE(-ENODEV);
 	}
 
-	spin_lock_irqsave(&ec->lock, flags);
+	WARN_ON(in_interrupt());
+	down(&ec->sem);
 
+	acpi_ec_prepare_for_wait(ec);
 	acpi_hw_low_level_write(8, ACPI_EC_COMMAND_WRITE, &ec->command_addr);
-	result = acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
+	result = acpi_ec_wait(ec);
 	if (result)
 		goto end;
 
+	acpi_ec_prepare_for_wait(ec);
 	acpi_hw_low_level_write(8, address, &ec->data_addr);
-	result = acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
+	result = acpi_ec_wait(ec);
 	if (result)
 		goto end;
 
+	acpi_ec_prepare_for_wait(ec);
 	acpi_hw_low_level_write(8, data, &ec->data_addr);
-	result = acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
+	result = acpi_ec_wait(ec);
 	if (result)
 		goto end;
 
@@ -232,7 +224,7 @@
 		data, address));
 
 end:
-	spin_unlock_irqrestore(&ec->lock, flags);
+	up(&ec->sem);
 
 	if (ec->global_lock)
 		acpi_release_global_lock(glk);
@@ -289,10 +281,9 @@
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
 
@@ -312,20 +303,18 @@
 	 * Note that successful completion of the query causes the ACPI_EC_SCI
 	 * bit to be cleared (and thus clearing the interrupt source).
 	 */
-	spin_lock_irqsave(&ec->lock, flags);
-
+	acpi_ec_prepare_for_wait(ec);
 	acpi_hw_low_level_write(8, ACPI_EC_COMMAND_QUERY, &ec->command_addr);
-	result = acpi_ec_wait(ec, ACPI_EC_EVENT_OBF);
+	result = acpi_ec_wait(ec);
 	if (result)
 		goto end;
-	
-	acpi_hw_low_level_read(8, data, &ec->data_addr);
+
+	*data = ec->data;
+
 	if (!*data)
 		result = -ENODATA;
 
 end:
-	spin_unlock_irqrestore(&ec->lock, flags);
-
 	if (ec->global_lock)
 		acpi_release_global_lock(glk);
 
@@ -342,38 +331,63 @@
 	u8			data;
 };
 
+static void acpi_ec_check_rw_complete(struct acpi_ec *ec, u32 status)
+{
+	u32		data = 0;
+
+	if (status & ACPI_EC_FLAG_OBF)
+		acpi_hw_low_level_read(8, &data, &ec->data_addr);
+
+	if (ec->rw_in_progress &&
+	    ((status & ACPI_EC_FLAG_OBF) || (~status & ACPI_EC_FLAG_IBF))) {
+		ec->data = data;
+		ec->rw_in_progress = 0;
+		wake_up(&ec->wait);
+	}
+}
+
 static void
 acpi_ec_gpe_query (
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
+		acpi_ec_check_rw_complete(ec, value);
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
 
@@ -390,6 +404,7 @@
 	void			*data)
 {
 	acpi_status		status = AE_OK;
+	u32			value;
 	struct acpi_ec		*ec = (struct acpi_ec *) data;
 
 	if (!ec)
@@ -397,13 +412,15 @@
 
 	acpi_disable_gpe(NULL, ec->gpe_bit, ACPI_ISR);
 
-	status = acpi_os_queue_for_execution(OSD_PRIORITY_GPE,
-		acpi_ec_gpe_query, ec);
+	value = acpi_ec_read_status(ec);
+	acpi_ec_check_rw_complete(ec, value);
 
-	if (status == AE_OK)
-		return ACPI_INTERRUPT_HANDLED;
-	else
-		return ACPI_INTERRUPT_NOT_HANDLED;
+	if (value & ACPI_EC_FLAG_SCI)
+		status = acpi_os_queue_for_execution(OSD_PRIORITY_GPE,
+						acpi_ec_gpe_query, ec);
+
+	return status == AE_OK ?
+		ACPI_INTERRUPT_HANDLED : ACPI_INTERRUPT_NOT_HANDLED;
 }
 
 /* --------------------------------------------------------------------------
@@ -421,10 +438,8 @@
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
@@ -439,9 +454,9 @@
 	void			*handler_context,
 	void			*region_context)
 {
-	int			result = 0;
-	struct acpi_ec		*ec = NULL;
-	u32			temp = 0;
+	int			result;
+	struct acpi_ec		*ec;
+	u32			temp;
 	acpi_integer		f_v = 0;
 	int 			i = 0;
 
@@ -450,7 +465,7 @@
 	if ((address > 0xFF) || !value || !handler_context)
 		return_VALUE(AE_BAD_PARAMETER);
 
-	if(bit_width != 8) {
+	if (bit_width != 8) {
 		printk(KERN_WARNING PREFIX "acpi_ec_space_handler: bit_width should be 8\n");
 		if (acpi_strict)
 			return_VALUE(AE_BAD_PARAMETER);
@@ -474,23 +489,23 @@
 	}
 
 	bit_width -= 8;
-	if(bit_width){
+	if (bit_width) {
 
-		if(function == ACPI_READ)
+		if (function == ACPI_READ)
 			f_v |= (acpi_integer) (*value) << 8*i;
-		if(function == ACPI_WRITE)
-			(*value) >>=8; 
+		if (function == ACPI_WRITE)
+			(*value) >>=8;
 		i++;
 		goto next_byte;
 	}
 
 
-	if(function == ACPI_READ){
+	if (function == ACPI_READ) {
 		f_v |= (acpi_integer) (*value) << 8*i;
 		*value = f_v;
 	}
 
-		
+
 out:
 	switch (result) {
 	case -EINVAL:
@@ -505,8 +520,6 @@
 	default:
 		return_VALUE(AE_OK);
 	}
-	
-
 }
 
 
@@ -532,7 +545,7 @@
 	seq_printf(seq, "ports:                   0x%02x, 0x%02x\n",
 		(u32) ec->status_addr.address, (u32) ec->data_addr.address);
 	seq_printf(seq, "use global lock:         %s\n",
-		ec->global_lock?"yes":"no");
+		ec->global_lock ? "yes" : "no");
 
 end:
 	return_VALUE(0);
@@ -555,7 +568,7 @@
 acpi_ec_add_fs (
 	struct acpi_device	*device)
 {
-	struct proc_dir_entry	*entry = NULL;
+	struct proc_dir_entry	*entry;
 
 	ACPI_FUNCTION_TRACE("acpi_ec_add_fs");
 
@@ -606,9 +619,9 @@
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
@@ -623,7 +636,8 @@
 
 	ec->handle = device->handle;
 	ec->uid = -1;
-	spin_lock_init(&ec->lock);
+	init_MUTEX(&ec->sem);
+	init_waitqueue_head(&ec->wait);
 	strcpy(acpi_device_name(device), ACPI_EC_DEVICE_NAME);
 	strcpy(acpi_device_class(device), ACPI_EC_CLASS);
 	acpi_driver_data(device) = ec;
@@ -637,7 +651,7 @@
 	if (ec_ecdt && ec_ecdt->uid == uid) {
 		acpi_remove_address_space_handler(ACPI_ROOT_OBJECT,
 			ACPI_ADR_SPACE_EC, &acpi_ec_space_handler);
-	
+
 		acpi_remove_gpe_handler(NULL, ec_ecdt->gpe_bit, &acpi_ec_gpe_handler);
 
 		kfree(ec_ecdt);
@@ -677,7 +691,7 @@
 	struct acpi_device	*device,
 	int			type)
 {
-	struct acpi_ec		*ec = NULL;
+	struct acpi_ec		*ec;
 
 	ACPI_FUNCTION_TRACE("acpi_ec_remove");
 
@@ -732,8 +746,8 @@
 acpi_ec_start (
 	struct acpi_device	*device)
 {
-	acpi_status		status = AE_OK;
-	struct acpi_ec		*ec = NULL;
+	acpi_status		status;
+	struct acpi_ec		*ec;
 
 	ACPI_FUNCTION_TRACE("acpi_ec_start");
 
@@ -789,8 +803,8 @@
 	struct acpi_device	*device,
 	int			type)
 {
-	acpi_status		status = AE_OK;
-	struct acpi_ec		*ec = NULL;
+	acpi_status		status;
+	struct acpi_ec		*ec;
 
 	ACPI_FUNCTION_TRACE("acpi_ec_stop");
 
@@ -824,6 +838,7 @@
 		acpi_ec_io_ports, ec_ecdt);
 	if (ACPI_FAILURE(status))
 		return status;
+
 	ec_ecdt->status_addr = ec_ecdt->command_addr;
 
 	ec_ecdt->uid = -1;
@@ -832,7 +847,9 @@
 	status = acpi_evaluate_integer(handle, "_GPE", NULL, &ec_ecdt->gpe_bit);
 	if (ACPI_FAILURE(status))
 		return status;
-	spin_lock_init(&ec_ecdt->lock);
+
+	init_MUTEX(&ec_ecdt->sem);
+	init_waitqueue_head(&ec_ecdt->wait);
 	ec_ecdt->global_lock = TRUE;
 	ec_ecdt->handle = handle;
 
@@ -890,7 +907,7 @@
 	acpi_status		status;
 	struct acpi_table_ecdt 	*ecdt_ptr;
 
-	status = acpi_get_firmware_table("ECDT", 1, ACPI_LOGICAL_ADDRESSING, 
+	status = acpi_get_firmware_table("ECDT", 1, ACPI_LOGICAL_ADDRESSING,
 		(struct acpi_table_header **) &ecdt_ptr);
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
@@ -905,11 +922,12 @@
 		return -ENOMEM;
 	memset(ec_ecdt, 0, sizeof(struct acpi_ec));
 
+	init_MUTEX(&ec_ecdt->sem);
+	init_waitqueue_head(&ec_ecdt->wait);
 	ec_ecdt->command_addr = ecdt_ptr->ec_control;
 	ec_ecdt->status_addr = ecdt_ptr->ec_control;
 	ec_ecdt->data_addr = ecdt_ptr->ec_data;
 	ec_ecdt->gpe_bit = ecdt_ptr->gpe_bit;
-	spin_lock_init(&ec_ecdt->lock);
 	/* use the GL just to be safe */
 	ec_ecdt->global_lock = TRUE;
 	ec_ecdt->uid = ecdt_ptr->uid;
@@ -978,7 +996,7 @@
 
 static int __init acpi_ec_init (void)
 {
-	int			result = 0;
+	int			result;
 
 	ACPI_FUNCTION_TRACE("acpi_ec_init");
 


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
