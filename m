From: =?ISO-8859-1?Q?Fran=E7ois_Valenduc?= <fvalenduc-IWqWACnzNjyZIoH1IeqzKA@public.gmane.org>
Subject: Re: Re: Smart Battery System driver
Date: Tue, 06 Sep 2005 22:38:22 +0200
Message-ID: <431DFE3E.5010400@tiscali.be>
References: <41E81C2C.8010809@bartol.udel.edu>	 <1105747983.7368.3.camel@tyrosine>	 <47e0449d05011419037877f931@mail.gmail.com>	 <m2fz13x8mw.fsf@phoenix.squirrel.nl>	 <41EA2C1D.3030909@bartol.udel.edu> <41EC7C7D.1070003@bartol.udel.edu>	 <41EC9316.80109@bartol.udel.edu> <41EDE2EA.7090404@bartol.udel.edu>	 <41EF1F6A.5000807@bartol.udel.edu>	 <75eeb70e05090520257be89afa@mail.gmail.com> <75eeb70e050906125344c326ad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080503030600020908080607"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <75eeb70e050906125344c326ad-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

This is a multi-part message in MIME format.
--------------080503030600020908080607
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by outmx008.isp.belgacom.be id j86KcJRw026052

Antoni Villalonga a =E9crit :

>2005/9/6, Antoni Villalonga:
> =20
>
>>I know about sbs-linux project in sourceforge, but I get a big delay
>>(about ~20 seconds) with my Acer TM 4001 when I try to read battery
>>status.
>>
>>There are any way to fix it?
>>
>>Thanks!!
>>   =20
>>
>
>Thanks to Olaf and Yu!
>
>It doesn't work for me, I don't have more time today at weekend I'll ret=
ry. :-)
>
>THANKS!!
>
> =20
>
See the bug report here:=20
https://sourceforge.net/tracker/index.php?func=3Ddetail&aid=3D1191536&gro=
up_id=3D129330&atid=3D714494
I have exactely the same laptop than you and I manage to read battery=20
state without problem using a modified DSDT table. If you use kernels=20
2.6.11 or 2.6.12, you can use the attached patch which includes the=20
changes suggested in the bug report. If you use kernel 2.6.13, this=20
patch doesn't apply cleanly. However, without extra patch, it works=20
correctly for me.

Fran=E7ois Valenduc

--------------080503030600020908080607
Content-Type: text/x-patch;
 name="acpi-ec-nospinlock-2.6.11.diff"
Content-Disposition: inline;
 filename="acpi-ec-nospinlock-2.6.11.diff"
Content-Transfer-Encoding: 7bit

diff -urN linux-2.6.11.5-original/drivers/acpi/ec.c linux-2.6.11.5/drivers/acpi/ec.c
--- linux-2.6.11.5-original/drivers/acpi/ec.c	2005-03-21 15:58:25.000000000 +0000
+++ linux-2.6.11.5/drivers/acpi/ec.c	2005-03-21 16:03:55.000000000 +0000
@@ -31,6 +31,7 @@
 #include <linux/delay.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
+#include <asm/semaphore.h>
 #include <asm/io.h>
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
@@ -54,8 +55,8 @@
 #define ACPI_EC_EVENT_OBF	0x01	/* Output buffer full */
 #define ACPI_EC_EVENT_IBE	0x02	/* Input buffer empty */
 
-#define ACPI_EC_UDELAY		100	/* Poll @ 100us increments */
-#define ACPI_EC_UDELAY_COUNT	1000	/* Wait 10ms max. during EC ops */
+#define ACPI_EC_MSLEEP		1	/* Sleep 1ms between polling */
+#define ACPI_EC_MSLEEP_COUNT	10	/* Wait 10ms max. during EC ops */
 #define ACPI_EC_UDELAY_GLK	1000	/* Wait 1ms max. to get global lock */
 
 #define ACPI_EC_COMMAND_READ	0x80
@@ -87,7 +88,7 @@
 	struct acpi_generic_address	command_addr;
 	struct acpi_generic_address	data_addr;
 	unsigned long			global_lock;
-	spinlock_t			lock;
+	struct semaphore		sem;
 };
 
 /* If we find an EC via the ECDT, we need to keep a ptr to its context */
@@ -106,7 +107,7 @@
 	u8			event)
 {
 	u32			acpi_ec_status = 0;
-	u32			i = ACPI_EC_UDELAY_COUNT;
+	u32			i = ACPI_EC_MSLEEP_COUNT;
 
 	if (!ec)
 		return -EINVAL;
@@ -118,7 +119,7 @@
 			acpi_hw_low_level_read(8, &acpi_ec_status, &ec->status_addr);
 			if (acpi_ec_status & ACPI_EC_FLAG_OBF)
 				return 0;
-			udelay(ACPI_EC_UDELAY);
+			msleep(ACPI_EC_MSLEEP);
 		} while (--i>0);
 		break;
 	case ACPI_EC_EVENT_IBE:
@@ -126,7 +127,7 @@
 			acpi_hw_low_level_read(8, &acpi_ec_status, &ec->status_addr);
 			if (!(acpi_ec_status & ACPI_EC_FLAG_IBF))
 				return 0;
-			udelay(ACPI_EC_UDELAY);
+			msleep(ACPI_EC_MSLEEP);
 		} while (--i>0);
 		break;
 	default:
@@ -137,7 +138,7 @@
 }
 
 
-static int
+int
 acpi_ec_read (
 	struct acpi_ec		*ec,
 	u8			address,
@@ -145,7 +146,6 @@
 {
 	acpi_status		status = AE_OK;
 	int			result = 0;
-	unsigned long		flags = 0;
 	u32			glk = 0;
 
 	ACPI_FUNCTION_TRACE("acpi_ec_read");
@@ -161,7 +161,10 @@
 			return_VALUE(-ENODEV);
 	}
 	
-	spin_lock_irqsave(&ec->lock, flags);
+	if (down_interruptible (&ec->sem)) {
+		result = -ERESTARTSYS;
+		goto end_nosem;
+	}
 
 	acpi_hw_low_level_write(8, ACPI_EC_COMMAND_READ, &ec->command_addr);
 	result = acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
@@ -180,7 +183,8 @@
 		*data, address));
 
 end:
-	spin_unlock_irqrestore(&ec->lock, flags);
+	up (&ec->sem);
+end_nosem:
 
 	if (ec->global_lock)
 		acpi_release_global_lock(glk);
@@ -189,7 +193,7 @@
 }
 
 
-static int
+int
 acpi_ec_write (
 	struct acpi_ec		*ec,
 	u8			address,
@@ -197,7 +201,6 @@
 {
 	int			result = 0;
 	acpi_status		status = AE_OK;
-	unsigned long		flags = 0;
 	u32			glk = 0;
 
 	ACPI_FUNCTION_TRACE("acpi_ec_write");
@@ -211,7 +214,10 @@
 			return_VALUE(-ENODEV);
 	}
 
-	spin_lock_irqsave(&ec->lock, flags);
+	if (down_interruptible (&ec->sem)) {
+		result = -ERESTARTSYS;
+		goto end_nosem;
+	}
 
 	acpi_hw_low_level_write(8, ACPI_EC_COMMAND_WRITE, &ec->command_addr);
 	result = acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
@@ -232,7 +238,8 @@
 		data, address));
 
 end:
-	spin_unlock_irqrestore(&ec->lock, flags);
+	up (&ec->sem);
+end_nosem:
 
 	if (ec->global_lock)
 		acpi_release_global_lock(glk);
@@ -284,14 +291,13 @@
 EXPORT_SYMBOL(ec_write);
 
 
-static int
+int
 acpi_ec_query (
 	struct acpi_ec		*ec,
 	u32			*data)
 {
 	int			result = 0;
 	acpi_status		status = AE_OK;
-	unsigned long		flags = 0;
 	u32			glk = 0;
 
 	ACPI_FUNCTION_TRACE("acpi_ec_query");
@@ -312,7 +318,10 @@
 	 * Note that successful completion of the query causes the ACPI_EC_SCI
 	 * bit to be cleared (and thus clearing the interrupt source).
 	 */
-	spin_lock_irqsave(&ec->lock, flags);
+	if (down_interruptible (&ec->sem)) {
+		result = -ERESTARTSYS;
+		goto end_nosem;
+	}
 
 	acpi_hw_low_level_write(8, ACPI_EC_COMMAND_QUERY, &ec->command_addr);
 	result = acpi_ec_wait(ec, ACPI_EC_EVENT_OBF);
@@ -324,7 +333,8 @@
 		result = -ENODATA;
 
 end:
-	spin_unlock_irqrestore(&ec->lock, flags);
+	up (&ec->sem);
+end_nosem:
 
 	if (ec->global_lock)
 		acpi_release_global_lock(glk);
@@ -348,7 +358,6 @@
 {
 	struct acpi_ec		*ec = (struct acpi_ec *) ec_cxt;
 	u32			value = 0;
-	unsigned long		flags = 0;
 	static char		object_name[5] = {'_','Q','0','0','\0'};
 	const char		hex[] = {'0','1','2','3','4','5','6','7',
 				         '8','9','A','B','C','D','E','F'};
@@ -358,9 +367,11 @@
 	if (!ec_cxt)
 		goto end;	
 
-	spin_lock_irqsave(&ec->lock, flags);
+	if (down_interruptible (&ec->sem)) {
+		return_VOID;
+	}
 	acpi_hw_low_level_read(8, &value, &ec->command_addr);
-	spin_unlock_irqrestore(&ec->lock, flags);
+	up(&ec->sem);
 
 	/* TBD: Implement asynch events!
 	 * NOTE: All we care about are EC-SCI's.  Other EC events are
@@ -623,7 +634,7 @@
 
 	ec->handle = device->handle;
 	ec->uid = -1;
-	spin_lock_init(&ec->lock);
+	sema_init(&ec->sem, 1);
 	strcpy(acpi_device_name(device), ACPI_EC_DEVICE_NAME);
 	strcpy(acpi_device_class(device), ACPI_EC_CLASS);
 	acpi_driver_data(device) = ec;
@@ -832,7 +843,7 @@
 	status = acpi_evaluate_integer(handle, "_GPE", NULL, &ec_ecdt->gpe_bit);
 	if (ACPI_FAILURE(status))
 		return status;
-	spin_lock_init(&ec_ecdt->lock);
+	sema_init(&ec_ecdt->sem, 1);
 	ec_ecdt->global_lock = TRUE;
 	ec_ecdt->handle = handle;
 
@@ -909,7 +920,7 @@
 	ec_ecdt->status_addr = ecdt_ptr->ec_control;
 	ec_ecdt->data_addr = ecdt_ptr->ec_data;
 	ec_ecdt->gpe_bit = ecdt_ptr->gpe_bit;
-	spin_lock_init(&ec_ecdt->lock);
+	sema_init(&ec_ecdt->sem, 1);
 	/* use the GL just to be safe */
 	ec_ecdt->global_lock = TRUE;
 	ec_ecdt->uid = ecdt_ptr->uid;

--------------080503030600020908080607--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
