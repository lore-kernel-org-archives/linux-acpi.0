From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH] Change spinlock mutex to semaphor in ec.c
Date: Fri, 4 Feb 2005 14:31:44 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F84041AC120@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="GB2312"
Content-Transfer-Encoding: quoted-printable
Content-class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dmitry Torokhov <dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Rich Townsend <rhdt-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

I have patch set for this issue filed at
 http://bugzilla.kernel.org/show_bug.cgi?id=3D3851#c28 .

The first patch is from you.

I think that is the right solution, but the patch itself needs wider =
test, and solve
any possible regression.


Thanks
Luming=20

>-----Original Message-----
>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org=20
>[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of=20
>Dmitry Torokhov
>Sent: 2005=C4=EA2=D4=C24=C8=D5 13:56
>To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Cc: Rich Townsend
>Subject: Re: [ACPI] [PATCH] Change spinlock mutex to semaphor in ec.c
>
>On Thursday 03 February 2005 19:24, Rich Townsend wrote:
>> Hi all --
>>=20
>> Attached is a patch against the 2.6.10 kernel, to convert=20
>the mutexing=20
>> in the embdedded controller driver from a spinlock to a=20
>semaphore. The=20
>> rationale behind this is to permit sleeping inside the=20
>acpi_ec_wait()=20
>> polling routine.
>>=20
>
>Hi,
>
>Last time such patch was proposed there were some concerns regarding
>possible interrupt storm, see the follwing thread:
>
>http://marc.theaimsgroup.com/?l=3Dacpi4linux&m=3D110055992814866&w=3D2
>
>I have an alternative patch that tries to address these concerns,
>unfortunately I do not have a box with EC controller so it is
>completely untested.
>
>--=20
>Dmitry
>
>
>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>
>ChangeSet@1.1997, 2005-02-04 00:43:27-05:00, dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org
>  ACPI: EC - switch from busy-polling to event-based completion
>        signalling. EC operations take quite a long time and busy
>        polling with interrupts disabled causes big latencies or
>        even losing timer interrupts.
>        EC IO timeout has been increased from 10 to 50ms.
>        Also get rid of unneeded variable initializations.
> =20
>        Based on patch by Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
> =20
>  Signed-off-by: Dmitry Torokhov <dtor-JGs/UdohzUI@public.gmane.org>
>
>
> ec.c |  264=20
>+++++++++++++++++++++++++++++++++++--------------------------------
> 1 files changed, 141 insertions(+), 123 deletions(-)
>
>
>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>
>
>diff -Nru a/drivers/acpi/ec.c b/drivers/acpi/ec.c
>--- a/drivers/acpi/ec.c	2005-02-04 00:47:16 -05:00
>+++ b/drivers/acpi/ec.c	2005-02-04 00:47:16 -05:00
>@@ -31,6 +31,7 @@
> #include <linux/delay.h>
> #include <linux/proc_fs.h>
> #include <linux/seq_file.h>
>+#include <linux/interrupt.h>
> #include <asm/io.h>
> #include <acpi/acpi_bus.h>
> #include <acpi/acpi_drivers.h>
>@@ -51,11 +52,7 @@
> #define ACPI_EC_FLAG_IBF	0x02	/* Input buffer full */
> #define ACPI_EC_FLAG_SCI	0x20	/* EC-SCI occurred */
>=20
>-#define ACPI_EC_EVENT_OBF	0x01	/* Output buffer full */
>-#define ACPI_EC_EVENT_IBE	0x02	/* Input buffer empty */
>-
>-#define ACPI_EC_UDELAY		100	/* Poll @ 100us=20
>increments */
>-#define ACPI_EC_UDELAY_COUNT	1000	/* Wait 10ms max.=20
>during EC ops */
>+#define ACPI_EC_DELAY		50	/* Wait 50ms max.=20
>during EC ops */
> #define ACPI_EC_UDELAY_GLK	1000	/* Wait 1ms max. to get=20
>global lock */
>=20
> #define ACPI_EC_COMMAND_READ	0x80
>@@ -86,8 +83,11 @@
> 	struct acpi_generic_address	status_addr;
> 	struct acpi_generic_address	command_addr;
> 	struct acpi_generic_address	data_addr;
>+	u32				data;
> 	unsigned long			global_lock;
>-	spinlock_t			lock;
>+	unsigned int			rw_in_progress;
>+	struct semaphore		sem;
>+	wait_queue_head_t		wait;
> };
>=20
> /* If we find an EC via the ECDT, we need to keep a ptr to=20
>its context */
>@@ -100,53 +100,40 @@
>                              Transaction Management
>   =20
>---------------------------------------------------------------
>----------- */
>=20
>-static int
>-acpi_ec_wait (
>-	struct acpi_ec		*ec,
>-	u8			event)
>+static inline u32 acpi_ec_read_status(struct acpi_ec *ec)
> {
>-	u32			acpi_ec_status =3D 0;
>-	u32			i =3D ACPI_EC_UDELAY_COUNT;
>+	u32	status =3D 0;
>=20
>-	if (!ec)
>-		return -EINVAL;
>+	acpi_hw_low_level_read(8, &status, &ec->status_addr);
>+	return status;
>+}
>=20
>-	/* Poll the EC status register waiting for the event to=20
>occur. */
>-	switch (event) {
>-	case ACPI_EC_EVENT_OBF:
>-		do {
>-			acpi_hw_low_level_read(8,=20
>&acpi_ec_status, &ec->status_addr);
>-			if (acpi_ec_status & ACPI_EC_FLAG_OBF)
>-				return 0;
>-			udelay(ACPI_EC_UDELAY);
>-		} while (--i>0);
>-		break;
>-	case ACPI_EC_EVENT_IBE:
>-		do {
>-			acpi_hw_low_level_read(8,=20
>&acpi_ec_status, &ec->status_addr);
>-			if (!(acpi_ec_status & ACPI_EC_FLAG_IBF))
>-				return 0;
>-			udelay(ACPI_EC_UDELAY);
>-		} while (--i>0);
>-		break;
>-	default:
>-		return -EINVAL;
>+static inline void acpi_ec_prepare_for_wait(struct acpi_ec *ec)
>+{
>+	ec->rw_in_progress =3D 1;
>+	mb();
>+}
>+
>+static int acpi_ec_wait(struct acpi_ec *ec)
>+{
>+	if (wait_event_timeout(ec->wait, !ec->rw_in_progress,
>+				msecs_to_jiffies(ACPI_EC_DELAY)) =3D=3D 0) {
>+		ec->rw_in_progress =3D 0;
>+		return -ETIME;
> 	}
>=20
>-	return -ETIME;
>+	return 0;
> }
>=20
>-
> static int
> acpi_ec_read (
> 	struct acpi_ec		*ec,
> 	u8			address,
> 	u32			*data)
> {
>-	acpi_status		status =3D AE_OK;
>-	int			result =3D 0;
>-	unsigned long		flags =3D 0;
>-	u32			glk =3D 0;
>+	acpi_status		status;
>+	int			result;
>+	u32			glk;
>=20
> 	ACPI_FUNCTION_TRACE("acpi_ec_read");
>=20
>@@ -160,27 +147,29 @@
> 		if (ACPI_FAILURE(status))
> 			return_VALUE(-ENODEV);
> 	}
>-=09
>-	spin_lock_irqsave(&ec->lock, flags);
>=20
>+	WARN_ON(in_interrupt());
>+	down(&ec->sem);
>+
>+	acpi_ec_prepare_for_wait(ec);
> 	acpi_hw_low_level_write(8, ACPI_EC_COMMAND_READ,=20
>&ec->command_addr);
>-	result =3D acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
>+	result =3D acpi_ec_wait(ec);
> 	if (result)
> 		goto end;
>=20
>+	acpi_ec_prepare_for_wait(ec);
> 	acpi_hw_low_level_write(8, address, &ec->data_addr);
>-	result =3D acpi_ec_wait(ec, ACPI_EC_EVENT_OBF);
>+	result =3D acpi_ec_wait(ec);
> 	if (result)
> 		goto end;
>=20
>-
>-	acpi_hw_low_level_read(8, data, &ec->data_addr);
>+	*data =3D ec->data;
>=20
> 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Read [%02x] from=20
>address [%02x]\n",
> 		*data, address));
>=20
> end:
>-	spin_unlock_irqrestore(&ec->lock, flags);
>+	up(&ec->sem);
>=20
> 	if (ec->global_lock)
> 		acpi_release_global_lock(glk);
>@@ -195,10 +184,9 @@
> 	u8			address,
> 	u8			data)
> {
>-	int			result =3D 0;
>-	acpi_status		status =3D AE_OK;
>-	unsigned long		flags =3D 0;
>-	u32			glk =3D 0;
>+	int			result;
>+	acpi_status		status;
>+	u32			glk;
>=20
> 	ACPI_FUNCTION_TRACE("acpi_ec_write");
>=20
>@@ -211,20 +199,24 @@
> 			return_VALUE(-ENODEV);
> 	}
>=20
>-	spin_lock_irqsave(&ec->lock, flags);
>+	WARN_ON(in_interrupt());
>+	down(&ec->sem);
>=20
>+	acpi_ec_prepare_for_wait(ec);
> 	acpi_hw_low_level_write(8, ACPI_EC_COMMAND_WRITE,=20
>&ec->command_addr);
>-	result =3D acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
>+	result =3D acpi_ec_wait(ec);
> 	if (result)
> 		goto end;
>=20
>+	acpi_ec_prepare_for_wait(ec);
> 	acpi_hw_low_level_write(8, address, &ec->data_addr);
>-	result =3D acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
>+	result =3D acpi_ec_wait(ec);
> 	if (result)
> 		goto end;
>=20
>+	acpi_ec_prepare_for_wait(ec);
> 	acpi_hw_low_level_write(8, data, &ec->data_addr);
>-	result =3D acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
>+	result =3D acpi_ec_wait(ec);
> 	if (result)
> 		goto end;
>=20
>@@ -232,7 +224,7 @@
> 		data, address));
>=20
> end:
>-	spin_unlock_irqrestore(&ec->lock, flags);
>+	up(&ec->sem);
>=20
> 	if (ec->global_lock)
> 		acpi_release_global_lock(glk);
>@@ -289,10 +281,9 @@
> 	struct acpi_ec		*ec,
> 	u32			*data)
> {
>-	int			result =3D 0;
>-	acpi_status		status =3D AE_OK;
>-	unsigned long		flags =3D 0;
>-	u32			glk =3D 0;
>+	int			result;
>+	acpi_status		status;
>+	u32			glk;
>=20
> 	ACPI_FUNCTION_TRACE("acpi_ec_query");
>=20
>@@ -312,20 +303,18 @@
> 	 * Note that successful completion of the query causes=20
>the ACPI_EC_SCI
> 	 * bit to be cleared (and thus clearing the interrupt source).
> 	 */
>-	spin_lock_irqsave(&ec->lock, flags);
>-
>+	acpi_ec_prepare_for_wait(ec);
> 	acpi_hw_low_level_write(8, ACPI_EC_COMMAND_QUERY,=20
>&ec->command_addr);
>-	result =3D acpi_ec_wait(ec, ACPI_EC_EVENT_OBF);
>+	result =3D acpi_ec_wait(ec);
> 	if (result)
> 		goto end;
>-=09
>-	acpi_hw_low_level_read(8, data, &ec->data_addr);
>+
>+	*data =3D ec->data;
>+
> 	if (!*data)
> 		result =3D -ENODATA;
>=20
> end:
>-	spin_unlock_irqrestore(&ec->lock, flags);
>-
> 	if (ec->global_lock)
> 		acpi_release_global_lock(glk);
>=20
>@@ -342,38 +331,63 @@
> 	u8			data;
> };
>=20
>+static void acpi_ec_check_rw_complete(struct acpi_ec *ec, u32 status)
>+{
>+	u32		data =3D 0;
>+
>+	if (status & ACPI_EC_FLAG_OBF)
>+		acpi_hw_low_level_read(8, &data, &ec->data_addr);
>+
>+	if (ec->rw_in_progress &&
>+	    ((status & ACPI_EC_FLAG_OBF) || (~status &=20
>ACPI_EC_FLAG_IBF))) {
>+		ec->data =3D data;
>+		ec->rw_in_progress =3D 0;
>+		wake_up(&ec->wait);
>+	}
>+}
>+
> static void
> acpi_ec_gpe_query (
> 	void			*ec_cxt)
> {
> 	struct acpi_ec		*ec =3D (struct acpi_ec *) ec_cxt;
>-	u32			value =3D 0;
>-	unsigned long		flags =3D 0;
>+	u32			value;
>+	int			result =3D -ENODATA;
> 	static char		object_name[5] =3D {'_','Q','0','0','\0'};
> 	const char		hex[] =3D=20
>{'0','1','2','3','4','5','6','7',
> 				        =20
>'8','9','A','B','C','D','E','F'};
>=20
> 	ACPI_FUNCTION_TRACE("acpi_ec_gpe_query");
>=20
>-	if (!ec_cxt)
>-		goto end;=09
>-
>-	spin_lock_irqsave(&ec->lock, flags);
>-	acpi_hw_low_level_read(8, &value, &ec->command_addr);
>-	spin_unlock_irqrestore(&ec->lock, flags);
>-
>-	/* TBD: Implement asynch events!
>-	 * NOTE: All we care about are EC-SCI's.  Other EC events are
>-	 * handled via polling (yuck!).  This is because some systems
>-	 * treat EC-SCIs as level (versus EDGE!) triggered, preventing
>-	 *  a purely interrupt-driven approach (grumble, grumble).
>+	/*
>+	 * Because some systems treat EC-SCIs as level (versus EDGE!)
>+	 * triggered we can not just check SCI flag here. If there is
>+	 * a reader/writer waiting on response we need to wait till
>+	 * data is available and wake it up. Only when there is no
>+	 * outstanding requests we can finally service SCI.
> 	 */
>-	if (!(value & ACPI_EC_FLAG_SCI))
>-		goto end;
>=20
>-	if (acpi_ec_query(ec, &value))
>+	while (unlikely(down_trylock(&ec->sem))) {
>+
>+		/* Reader or writer is waiting holding ec->sem */
>+		value =3D acpi_ec_read_status(ec);
>+		acpi_ec_check_rw_complete(ec, value);
>+
>+		/*
>+		 * Even if we never get IBE/OBF condition client
>+		 * will eventually time out allowing us proceed.
>+		 */
>+		msleep(1);
>+	}
>+
>+	if (acpi_ec_read_status(ec) & ACPI_EC_FLAG_SCI)
>+		result =3D acpi_ec_query(ec, &value);
>+
>+	up(&ec->sem);
>+
>+	if (result)
> 		goto end;
>-=09
>+
> 	object_name[2] =3D hex[((value >> 4) & 0x0F)];
> 	object_name[3] =3D hex[(value & 0x0F)];
>=20
>@@ -390,6 +404,7 @@
> 	void			*data)
> {
> 	acpi_status		status =3D AE_OK;
>+	u32			value;
> 	struct acpi_ec		*ec =3D (struct acpi_ec *) data;
>=20
> 	if (!ec)
>@@ -397,13 +412,15 @@
>=20
> 	acpi_disable_gpe(NULL, ec->gpe_bit, ACPI_ISR);
>=20
>-	status =3D acpi_os_queue_for_execution(OSD_PRIORITY_GPE,
>-		acpi_ec_gpe_query, ec);
>+	value =3D acpi_ec_read_status(ec);
>+	acpi_ec_check_rw_complete(ec, value);
>=20
>-	if (status =3D=3D AE_OK)
>-		return ACPI_INTERRUPT_HANDLED;
>-	else
>-		return ACPI_INTERRUPT_NOT_HANDLED;
>+	if (value & ACPI_EC_FLAG_SCI)
>+		status =3D acpi_os_queue_for_execution(OSD_PRIORITY_GPE,
>+						acpi_ec_gpe_query, ec);
>+
>+	return status =3D=3D AE_OK ?
>+		ACPI_INTERRUPT_HANDLED : ACPI_INTERRUPT_NOT_HANDLED;
> }
>=20
> /*=20
>---------------------------------------------------------------
>-----------
>@@ -421,10 +438,8 @@
> 	 * The EC object is in the handler context and is needed
> 	 * when calling the acpi_ec_space_handler.
> 	 */
>-	if(function =3D=3D ACPI_REGION_DEACTIVATE)=20
>-		*return_context =3D NULL;
>-	else=20
>-		*return_context =3D handler_context;
>+	*return_context  =3D (function !=3D ACPI_REGION_DEACTIVATE) ?
>+						handler_context : NULL;
>=20
> 	return AE_OK;
> }
>@@ -439,9 +454,9 @@
> 	void			*handler_context,
> 	void			*region_context)
> {
>-	int			result =3D 0;
>-	struct acpi_ec		*ec =3D NULL;
>-	u32			temp =3D 0;
>+	int			result;
>+	struct acpi_ec		*ec;
>+	u32			temp;
> 	acpi_integer		f_v =3D 0;
> 	int 			i =3D 0;
>=20
>@@ -450,7 +465,7 @@
> 	if ((address > 0xFF) || !value || !handler_context)
> 		return_VALUE(AE_BAD_PARAMETER);
>=20
>-	if(bit_width !=3D 8) {
>+	if (bit_width !=3D 8) {
> 		printk(KERN_WARNING PREFIX=20
>"acpi_ec_space_handler: bit_width should be 8\n");
> 		if (acpi_strict)
> 			return_VALUE(AE_BAD_PARAMETER);
>@@ -474,23 +489,23 @@
> 	}
>=20
> 	bit_width -=3D 8;
>-	if(bit_width){
>+	if (bit_width) {
>=20
>-		if(function =3D=3D ACPI_READ)
>+		if (function =3D=3D ACPI_READ)
> 			f_v |=3D (acpi_integer) (*value) << 8*i;
>-		if(function =3D=3D ACPI_WRITE)
>-			(*value) >>=3D8;=20
>+		if (function =3D=3D ACPI_WRITE)
>+			(*value) >>=3D8;
> 		i++;
> 		goto next_byte;
> 	}
>=20
>=20
>-	if(function =3D=3D ACPI_READ){
>+	if (function =3D=3D ACPI_READ) {
> 		f_v |=3D (acpi_integer) (*value) << 8*i;
> 		*value =3D f_v;
> 	}
>=20
>-	=09
>+
> out:
> 	switch (result) {
> 	case -EINVAL:
>@@ -505,8 +520,6 @@
> 	default:
> 		return_VALUE(AE_OK);
> 	}
>-=09
>-
> }
>=20
>=20
>@@ -532,7 +545,7 @@
> 	seq_printf(seq, "ports:                   0x%02x, 0x%02x\n",
> 		(u32) ec->status_addr.address, (u32)=20
>ec->data_addr.address);
> 	seq_printf(seq, "use global lock:         %s\n",
>-		ec->global_lock?"yes":"no");
>+		ec->global_lock ? "yes" : "no");
>=20
> end:
> 	return_VALUE(0);
>@@ -555,7 +568,7 @@
> acpi_ec_add_fs (
> 	struct acpi_device	*device)
> {
>-	struct proc_dir_entry	*entry =3D NULL;
>+	struct proc_dir_entry	*entry;
>=20
> 	ACPI_FUNCTION_TRACE("acpi_ec_add_fs");
>=20
>@@ -606,9 +619,9 @@
> acpi_ec_add (
> 	struct acpi_device	*device)
> {
>-	int			result =3D 0;
>-	acpi_status		status =3D AE_OK;
>-	struct acpi_ec		*ec =3D NULL;
>+	int			result;
>+	acpi_status		status;
>+	struct acpi_ec		*ec;
> 	unsigned long		uid;
>=20
> 	ACPI_FUNCTION_TRACE("acpi_ec_add");
>@@ -623,7 +636,8 @@
>=20
> 	ec->handle =3D device->handle;
> 	ec->uid =3D -1;
>-	spin_lock_init(&ec->lock);
>+	init_MUTEX(&ec->sem);
>+	init_waitqueue_head(&ec->wait);
> 	strcpy(acpi_device_name(device), ACPI_EC_DEVICE_NAME);
> 	strcpy(acpi_device_class(device), ACPI_EC_CLASS);
> 	acpi_driver_data(device) =3D ec;
>@@ -637,7 +651,7 @@
> 	if (ec_ecdt && ec_ecdt->uid =3D=3D uid) {
> 		acpi_remove_address_space_handler(ACPI_ROOT_OBJECT,
> 			ACPI_ADR_SPACE_EC, &acpi_ec_space_handler);
>-=09
>+
> 		acpi_remove_gpe_handler(NULL, ec_ecdt->gpe_bit,=20
>&acpi_ec_gpe_handler);
>=20
> 		kfree(ec_ecdt);
>@@ -677,7 +691,7 @@
> 	struct acpi_device	*device,
> 	int			type)
> {
>-	struct acpi_ec		*ec =3D NULL;
>+	struct acpi_ec		*ec;
>=20
> 	ACPI_FUNCTION_TRACE("acpi_ec_remove");
>=20
>@@ -732,8 +746,8 @@
> acpi_ec_start (
> 	struct acpi_device	*device)
> {
>-	acpi_status		status =3D AE_OK;
>-	struct acpi_ec		*ec =3D NULL;
>+	acpi_status		status;
>+	struct acpi_ec		*ec;
>=20
> 	ACPI_FUNCTION_TRACE("acpi_ec_start");
>=20
>@@ -789,8 +803,8 @@
> 	struct acpi_device	*device,
> 	int			type)
> {
>-	acpi_status		status =3D AE_OK;
>-	struct acpi_ec		*ec =3D NULL;
>+	acpi_status		status;
>+	struct acpi_ec		*ec;
>=20
> 	ACPI_FUNCTION_TRACE("acpi_ec_stop");
>=20
>@@ -824,6 +838,7 @@
> 		acpi_ec_io_ports, ec_ecdt);
> 	if (ACPI_FAILURE(status))
> 		return status;
>+
> 	ec_ecdt->status_addr =3D ec_ecdt->command_addr;
>=20
> 	ec_ecdt->uid =3D -1;
>@@ -832,7 +847,9 @@
> 	status =3D acpi_evaluate_integer(handle, "_GPE", NULL,=20
>&ec_ecdt->gpe_bit);
> 	if (ACPI_FAILURE(status))
> 		return status;
>-	spin_lock_init(&ec_ecdt->lock);
>+
>+	init_MUTEX(&ec_ecdt->sem);
>+	init_waitqueue_head(&ec_ecdt->wait);
> 	ec_ecdt->global_lock =3D TRUE;
> 	ec_ecdt->handle =3D handle;
>=20
>@@ -890,7 +907,7 @@
> 	acpi_status		status;
> 	struct acpi_table_ecdt 	*ecdt_ptr;
>=20
>-	status =3D acpi_get_firmware_table("ECDT", 1,=20
>ACPI_LOGICAL_ADDRESSING,=20
>+	status =3D acpi_get_firmware_table("ECDT", 1,=20
>ACPI_LOGICAL_ADDRESSING,
> 		(struct acpi_table_header **) &ecdt_ptr);
> 	if (ACPI_FAILURE(status))
> 		return -ENODEV;
>@@ -905,11 +922,12 @@
> 		return -ENOMEM;
> 	memset(ec_ecdt, 0, sizeof(struct acpi_ec));
>=20
>+	init_MUTEX(&ec_ecdt->sem);
>+	init_waitqueue_head(&ec_ecdt->wait);
> 	ec_ecdt->command_addr =3D ecdt_ptr->ec_control;
> 	ec_ecdt->status_addr =3D ecdt_ptr->ec_control;
> 	ec_ecdt->data_addr =3D ecdt_ptr->ec_data;
> 	ec_ecdt->gpe_bit =3D ecdt_ptr->gpe_bit;
>-	spin_lock_init(&ec_ecdt->lock);
> 	/* use the GL just to be safe */
> 	ec_ecdt->global_lock =3D TRUE;
> 	ec_ecdt->uid =3D ecdt_ptr->uid;
>@@ -978,7 +996,7 @@
>=20
> static int __init acpi_ec_init (void)
> {
>-	int			result =3D 0;
>+	int			result;
>=20
> 	ACPI_FUNCTION_TRACE("acpi_ec_init");
>=20
>
>
>-------------------------------------------------------
>This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
>Tool for open source databases. Create drag-&-drop reports. Save time
>by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
>Download a FREE copy at http://www.intelliview.com/go/osdn_nl
>_______________________________________________
>Acpi-devel mailing list
>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>https://lists.sourceforge.net/lists/listinfo/acpi-devel
>


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
