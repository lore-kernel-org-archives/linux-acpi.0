From: Dmitry Torokhov <dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org>
Subject: Re: [PATCH] Change spinlock mutex to semaphor in ec.c
Date: Mon, 7 Feb 2005 02:15:49 -0500
Message-ID: <200502070215.50079.dtor_core@ameritech.net>
References: <4202C0A4.1020700@bartol.udel.edu> <200502040055.53765.dtor_core@ameritech.net> <4203BE69.50004@bartol.udel.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
In-Reply-To: <4203BE69.50004-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
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
To: Rich Townsend <rhdt-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
Cc: Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Friday 04 February 2005 13:26, Rich Townsend wrote:
> 
> I've just tried your patch out on 2.6.11-rc3 (with acpi-dsdt-initrd and 
> swsusp2 patches), and it causes a kernel oops when the EC is accessed at 
> boot time.

Well, I said it was completely untested ;) But I see couple of problems
with it. Could you please try the patch below and see if it boots?

Thanks!

-- 
Dmitry

===== drivers/acpi/ec.c 1.46 vs edited =====
--- 1.46/drivers/acpi/ec.c	2005-02-07 01:09:52 -05:00
+++ edited/drivers/acpi/ec.c	2005-02-07 02:14:51 -05:00
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
@@ -86,8 +86,11 @@
 	struct acpi_generic_address	status_addr;
 	struct acpi_generic_address	command_addr;
 	struct acpi_generic_address	data_addr;
+	u32				data;
 	unsigned long			global_lock;
-	spinlock_t			lock;
+	unsigned int			expect_event;
+	struct semaphore		sem;
+	wait_queue_head_t		wait;
 };
 
 /* If we find an EC via the ECDT, we need to keep a ptr to its context */
@@ -100,53 +103,39 @@
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
+static inline void acpi_ec_prepare_for(struct acpi_ec *ec, unsigned int event)
+{
+	ec->expect_event = event;
+	mb();
+}
 
+static int acpi_ec_wait(struct acpi_ec *ec)
+{
+	if (wait_event_timeout(ec->wait, !ec->expect_event,
+				msecs_to_jiffies(ACPI_EC_DELAY)))
+		return 0;
+
+	ec->expect_event = 0;
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
 
@@ -160,27 +149,29 @@
 		if (ACPI_FAILURE(status))
 			return_VALUE(-ENODEV);
 	}
-	
-	spin_lock_irqsave(&ec->lock, flags);
 
+	WARN_ON(in_interrupt());
+	down(&ec->sem);
+
+	acpi_ec_prepare_for(ec, ACPI_EC_EVENT_IBE);
 	acpi_hw_low_level_write(8, ACPI_EC_COMMAND_READ, &ec->command_addr);
-	result = acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
+	result = acpi_ec_wait(ec);
 	if (result)
 		goto end;
 
+	acpi_ec_prepare_for(ec, ACPI_EC_EVENT_OBF);
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
@@ -195,10 +186,9 @@
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
 
@@ -211,20 +201,24 @@
 			return_VALUE(-ENODEV);
 	}
 
-	spin_lock_irqsave(&ec->lock, flags);
+	WARN_ON(in_interrupt());
+	down(&ec->sem);
 
+	acpi_ec_prepare_for(ec, ACPI_EC_EVENT_IBE);
 	acpi_hw_low_level_write(8, ACPI_EC_COMMAND_WRITE, &ec->command_addr);
-	result = acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
+	result = acpi_ec_wait(ec);
 	if (result)
 		goto end;
 
+	acpi_ec_prepare_for(ec, ACPI_EC_EVENT_IBE);
 	acpi_hw_low_level_write(8, address, &ec->data_addr);
-	result = acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
+	result = acpi_ec_wait(ec);
 	if (result)
 		goto end;
 
+	acpi_ec_prepare_for(ec, ACPI_EC_EVENT_IBE);
 	acpi_hw_low_level_write(8, data, &ec->data_addr);
-	result = acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
+	result = acpi_ec_wait(ec);
 	if (result)
 		goto end;
 
@@ -232,7 +226,7 @@
 		data, address));
 
 end:
-	spin_unlock_irqrestore(&ec->lock, flags);
+	up(&ec->sem);
 
 	if (ec->global_lock)
 		acpi_release_global_lock(glk);
@@ -289,16 +283,13 @@
 	struct acpi_ec		*ec,
 	u32			*data)
 {
-	int			result = 0;
-	acpi_status		status = AE_OK;
-	unsigned long		flags = 0;
-	u32			glk = 0;
+	acpi_status		status;
+	u32			glk;
+	int			result = -ETIME;
+	int			i = ACPI_EC_DELAY;
 
 	ACPI_FUNCTION_TRACE("acpi_ec_query");
 
-	if (!ec || !data)
-		return_VALUE(-EINVAL);
-
 	*data = 0;
 
 	if (ec->global_lock) {
@@ -311,20 +302,18 @@
 	 * Query the EC to find out which _Qxx method we need to evaluate.
 	 * Note that successful completion of the query causes the ACPI_EC_SCI
 	 * bit to be cleared (and thus clearing the interrupt source).
+	 * Here we do polling for command completion because GPE is disabled.
 	 */
-	spin_lock_irqsave(&ec->lock, flags);
-
 	acpi_hw_low_level_write(8, ACPI_EC_COMMAND_QUERY, &ec->command_addr);
-	result = acpi_ec_wait(ec, ACPI_EC_EVENT_OBF);
-	if (result)
-		goto end;
-	
-	acpi_hw_low_level_read(8, data, &ec->data_addr);
-	if (!*data)
-		result = -ENODATA;
 
-end:
-	spin_unlock_irqrestore(&ec->lock, flags);
+	do {
+		if (acpi_ec_read_status(ec) & ACPI_EC_FLAG_OBF) {
+			acpi_hw_low_level_read(8, data, &ec->data_addr);
+			result = *data ? 0 : -ENODATA;
+			break;
+		}
+		msleep(1);
+	} while (--i > 0);
 
 	if (ec->global_lock)
 		acpi_release_global_lock(glk);
@@ -342,38 +331,66 @@
 	u8			data;
 };
 
+static void acpi_ec_check_rw_complete(struct acpi_ec *ec, u32 status)
+{
+	if (ec->expect_event == ACPI_EC_EVENT_OBF) {
+
+		if (status & ACPI_EC_FLAG_OBF) {
+			acpi_hw_low_level_read(8, &ec->data, &ec->data_addr);
+			ec->expect_event = 0;
+			wake_up(&ec->wait);
+		}
+	} else if (ec->expect_event == ACPI_EC_EVENT_IBE) {
+
+	 	if (~status & ACPI_EC_FLAG_IBF) {
+			ec->expect_event = 0;
+			wake_up(&ec->wait);
+		}
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
+		 * will eventually time out allowing us to proceed.
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
 
@@ -390,6 +407,7 @@
 	void			*data)
 {
 	acpi_status		status = AE_OK;
+	u32			value;
 	struct acpi_ec		*ec = (struct acpi_ec *) data;
 
 	if (!ec)
@@ -397,13 +415,17 @@
 
 	acpi_disable_gpe(NULL, ec->gpe_bit, ACPI_ISR);
 
-	status = acpi_os_queue_for_execution(OSD_PRIORITY_GPE,
-		acpi_ec_gpe_query, ec);
+	value = acpi_ec_read_status(ec);
+	acpi_ec_check_rw_complete(ec, value);
 
-	if (status == AE_OK)
-		return ACPI_INTERRUPT_HANDLED;
+	if (value & ACPI_EC_FLAG_SCI)
+		status = acpi_os_queue_for_execution(OSD_PRIORITY_GPE,
+						acpi_ec_gpe_query, ec);
 	else
-		return ACPI_INTERRUPT_NOT_HANDLED;
+		acpi_enable_gpe(NULL, ec->gpe_bit, ACPI_ISR);
+
+	return status == AE_OK ?
+		ACPI_INTERRUPT_HANDLED : ACPI_INTERRUPT_NOT_HANDLED;
 }
 
 /* --------------------------------------------------------------------------
@@ -421,10 +443,8 @@
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
@@ -439,9 +459,9 @@
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
 
@@ -450,7 +470,7 @@
 	if ((address > 0xFF) || !value || !handler_context)
 		return_VALUE(AE_BAD_PARAMETER);
 
-	if(bit_width != 8) {
+	if (bit_width != 8) {
 		printk(KERN_WARNING PREFIX "acpi_ec_space_handler: bit_width should be 8\n");
 		if (acpi_strict)
 			return_VALUE(AE_BAD_PARAMETER);
@@ -474,23 +494,23 @@
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
@@ -505,8 +525,6 @@
 	default:
 		return_VALUE(AE_OK);
 	}
-	
-
 }
 
 
@@ -532,7 +550,7 @@
 	seq_printf(seq, "ports:                   0x%02x, 0x%02x\n",
 		(u32) ec->status_addr.address, (u32) ec->data_addr.address);
 	seq_printf(seq, "use global lock:         %s\n",
-		ec->global_lock?"yes":"no");
+		ec->global_lock ? "yes" : "no");
 
 end:
 	return_VALUE(0);
@@ -555,7 +573,7 @@
 acpi_ec_add_fs (
 	struct acpi_device	*device)
 {
-	struct proc_dir_entry	*entry = NULL;
+	struct proc_dir_entry	*entry;
 
 	ACPI_FUNCTION_TRACE("acpi_ec_add_fs");
 
@@ -606,9 +624,9 @@
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
@@ -623,7 +641,8 @@
 
 	ec->handle = device->handle;
 	ec->uid = -1;
-	spin_lock_init(&ec->lock);
+	init_MUTEX(&ec->sem);
+	init_waitqueue_head(&ec->wait);
 	strcpy(acpi_device_name(device), ACPI_EC_DEVICE_NAME);
 	strcpy(acpi_device_class(device), ACPI_EC_CLASS);
 	acpi_driver_data(device) = ec;
@@ -637,7 +656,7 @@
 	if (ec_ecdt && ec_ecdt->uid == uid) {
 		acpi_remove_address_space_handler(ACPI_ROOT_OBJECT,
 			ACPI_ADR_SPACE_EC, &acpi_ec_space_handler);
-	
+
 		acpi_remove_gpe_handler(NULL, ec_ecdt->gpe_bit, &acpi_ec_gpe_handler);
 
 		kfree(ec_ecdt);
@@ -677,7 +696,7 @@
 	struct acpi_device	*device,
 	int			type)
 {
-	struct acpi_ec		*ec = NULL;
+	struct acpi_ec		*ec;
 
 	ACPI_FUNCTION_TRACE("acpi_ec_remove");
 
@@ -732,8 +751,8 @@
 acpi_ec_start (
 	struct acpi_device	*device)
 {
-	acpi_status		status = AE_OK;
-	struct acpi_ec		*ec = NULL;
+	acpi_status		status;
+	struct acpi_ec		*ec;
 
 	ACPI_FUNCTION_TRACE("acpi_ec_start");
 
@@ -789,8 +808,8 @@
 	struct acpi_device	*device,
 	int			type)
 {
-	acpi_status		status = AE_OK;
-	struct acpi_ec		*ec = NULL;
+	acpi_status		status;
+	struct acpi_ec		*ec;
 
 	ACPI_FUNCTION_TRACE("acpi_ec_stop");
 
@@ -824,6 +843,7 @@
 		acpi_ec_io_ports, ec_ecdt);
 	if (ACPI_FAILURE(status))
 		return status;
+
 	ec_ecdt->status_addr = ec_ecdt->command_addr;
 
 	ec_ecdt->uid = -1;
@@ -832,7 +852,9 @@
 	status = acpi_evaluate_integer(handle, "_GPE", NULL, &ec_ecdt->gpe_bit);
 	if (ACPI_FAILURE(status))
 		return status;
-	spin_lock_init(&ec_ecdt->lock);
+
+	init_MUTEX(&ec_ecdt->sem);
+	init_waitqueue_head(&ec_ecdt->wait);
 	ec_ecdt->global_lock = TRUE;
 	ec_ecdt->handle = handle;
 
@@ -890,7 +912,7 @@
 	acpi_status		status;
 	struct acpi_table_ecdt 	*ecdt_ptr;
 
-	status = acpi_get_firmware_table("ECDT", 1, ACPI_LOGICAL_ADDRESSING, 
+	status = acpi_get_firmware_table("ECDT", 1, ACPI_LOGICAL_ADDRESSING,
 		(struct acpi_table_header **) &ecdt_ptr);
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
@@ -905,11 +927,12 @@
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
@@ -978,7 +1001,7 @@
 
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
