From: Pedro Venda <pjvenda-pQd4kjVL+REh2FBCd0jGRA@public.gmane.org>
Subject: patched sms-cm acpi/ec.c to 2.6.11.5
Date: Mon, 21 Mar 2005 16:14:35 +0000
Message-ID: <423EF2EB.5030505@arrakis.dhis.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6070C263DF5758BE5A83DB15"
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
Cc: rhdt-OBnUx95tOyn10jlvfTC4gA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6070C263DF5758BE5A83DB15
Content-Type: multipart/mixed;
 boundary="------------070906070207020109060601"

This is a multi-part message in MIME format.
--------------070906070207020109060601
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

hi everyone,

Since I'm still interested into using the sbs-cm DSDT patch from rich tow=
nsend
and the most recent release is for 2.6.10, refusing to apply to 2.6.11.X,=
 I
changed it.

here it is. rich: could you please take a look and, if it is ok, could yo=
u
just update your release?

thanks for your time. [patch is also attached]

regards,
pedro venda.




diff -urN linux-2.6.11.5-original/drivers/acpi/ec.c linux-2.6.11.5/driver=
s/acpi/ec.c
--- linux-2.6.11.5-original/drivers/acpi/ec.c   2005-03-21 15:58:25.00000=
0000 +0000
+++ linux-2.6.11.5/drivers/acpi/ec.c    2005-03-21 16:03:55.000000000 +00=
00
@@ -31,6 +31,7 @@
  #include <linux/delay.h>
  #include <linux/proc_fs.h>
  #include <linux/seq_file.h>
+#include <asm/semaphore.h>
  #include <asm/io.h>
  #include <acpi/acpi_bus.h>
  #include <acpi/acpi_drivers.h>
@@ -54,8 +55,8 @@
  #define ACPI_EC_EVENT_OBF      0x01    /* Output buffer full */
  #define ACPI_EC_EVENT_IBE      0x02    /* Input buffer empty */

-#define ACPI_EC_UDELAY         100     /* Poll @ 100us increments */
-#define ACPI_EC_UDELAY_COUNT   1000    /* Wait 10ms max. during EC ops *=
/
+#define ACPI_EC_MSLEEP         100     /* Sleep 1ms between polling */
+#define ACPI_EC_MSLEEP_COUNT   1000    /* Wait 10ms max. during EC ops *=
/
  #define ACPI_EC_UDELAY_GLK     1000    /* Wait 1ms max. to get global l=
ock */

  #define ACPI_EC_COMMAND_READ   0x80
@@ -87,7 +88,7 @@
         struct acpi_generic_address     command_addr;
         struct acpi_generic_address     data_addr;
         unsigned long                   global_lock;
-       spinlock_t                      lock;
+       struct semaphore                sem;
  };

  /* If we find an EC via the ECDT, we need to keep a ptr to its context =
*/
@@ -106,7 +107,7 @@
         u8                      event)
  {
         u32                     acpi_ec_status =3D 0;
-       u32                     i =3D ACPI_EC_UDELAY_COUNT;
+       u32                     i =3D ACPI_EC_MSLEEP_COUNT;

         if (!ec)
                 return -EINVAL;
@@ -118,7 +119,7 @@
                         acpi_hw_low_level_read(8, &acpi_ec_status, &ec->=
status_addr);
                         if (acpi_ec_status & ACPI_EC_FLAG_OBF)
                                 return 0;
-                       udelay(ACPI_EC_UDELAY);
+                       msleep(ACPI_EC_MSLEEP);
                 } while (--i>0);
                 break;
         case ACPI_EC_EVENT_IBE:
@@ -126,7 +127,7 @@
                         acpi_hw_low_level_read(8, &acpi_ec_status, &ec->=
status_addr);
                         if (!(acpi_ec_status & ACPI_EC_FLAG_IBF))
                                 return 0;
-                       udelay(ACPI_EC_UDELAY);

+                       msleep(ACPI_EC_MSLEEP);
                 } while (--i>0);
                 break;
         default:
@@ -137,7 +138,7 @@
  }


-static int
+int
  acpi_ec_read (
         struct acpi_ec          *ec,
         u8                      address,
@@ -145,7 +146,6 @@
  {
         acpi_status             status =3D AE_OK;
         int                     result =3D 0;
-       unsigned long           flags =3D 0;
         u32                     glk =3D 0;

         ACPI_FUNCTION_TRACE("acpi_ec_read");
@@ -161,7 +161,10 @@
                         return_VALUE(-ENODEV);
         }

-       spin_lock_irqsave(&ec->lock, flags);
+       if (down_interruptible (&ec->sem)) {
+               result =3D -ERESTARTSYS;
+               goto end_nosem;
+       }

         acpi_hw_low_level_write(8, ACPI_EC_COMMAND_READ, &ec->command_ad=
dr);
         result =3D acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
@@ -180,7 +183,8 @@
                 *data, address));

  end:
-       spin_unlock_irqrestore(&ec->lock, flags);
+       up (&ec->sem);
+end_nosem:

         if (ec->global_lock)
                 acpi_release_global_lock(glk);
@@ -189,7 +193,7 @@
  }


-static int
+int
  acpi_ec_write (
         struct acpi_ec          *ec,
         u8                      address,
@@ -197,7 +201,6 @@
  {
         int                     result =3D 0;
         acpi_status             status =3D AE_OK;
-       unsigned long           flags =3D 0;
         u32                     glk =3D 0;

         ACPI_FUNCTION_TRACE("acpi_ec_write");
@@ -211,7 +214,10 @@
                         return_VALUE(-ENODEV);
         }

-       spin_lock_irqsave(&ec->lock, flags);
+       if (down_interruptible (&ec->sem)) {
+               result =3D -ERESTARTSYS;
+               goto end_nosem;
+       }

         acpi_hw_low_level_write(8, ACPI_EC_COMMAND_WRITE, &ec->command_a=
ddr);
         result =3D acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
@@ -232,7 +238,8 @@
                 data, address));

  end:
-       spin_unlock_irqrestore(&ec->lock, flags);
+       up (&ec->sem);
+end_nosem:

         if (ec->global_lock)
                 acpi_release_global_lock(glk);
@@ -284,14 +291,13 @@
  EXPORT_SYMBOL(ec_write);


-static int
+int
  acpi_ec_query (
         struct acpi_ec          *ec,
         u32                     *data)
  {
         int                     result =3D 0;
         acpi_status             status =3D AE_OK;
-       unsigned long           flags =3D 0;
         u32                     glk =3D 0;

         ACPI_FUNCTION_TRACE("acpi_ec_query");
@@ -312,7 +318,10 @@
          * Note that successful completion of the query causes the ACPI_=
EC_SCI
          * bit to be cleared (and thus clearing the interrupt source).
          */
-       spin_lock_irqsave(&ec->lock, flags);
+       if (down_interruptible (&ec->sem)) {
+               result =3D -ERESTARTSYS;
+               goto end_nosem;
+       }
         acpi_hw_low_level_write(8, ACPI_EC_COMMAND_QUERY, &ec->command_a=
ddr);
         result =3D acpi_ec_wait(ec, ACPI_EC_EVENT_OBF);
@@ -324,7 +333,8 @@
                 result =3D -ENODATA;

  end:
-       spin_unlock_irqrestore(&ec->lock, flags);
+       up (&ec->sem);
+end_nosem:

         if (ec->global_lock)
                 acpi_release_global_lock(glk);
@@ -348,7 +358,6 @@
  {
         struct acpi_ec          *ec =3D (struct acpi_ec *) ec_cxt;
         u32                     value =3D 0;
-       unsigned long           flags =3D 0;
         static char             object_name[5] =3D {'_','Q','0','0','\0'=
};
         const char              hex[] =3D {'0','1','2','3','4','5','6','=
7',
                                          '8','9','A','B','C','D','E','F'=
};
@@ -358,9 +367,11 @@
         if (!ec_cxt)
                 goto end;

-       spin_lock_irqsave(&ec->lock, flags);
+       if (down_interruptible (&ec->sem)) {
+               return_VOID;
+       }
         acpi_hw_low_level_read(8, &value, &ec->command_addr);
-       spin_unlock_irqrestore(&ec->lock, flags);
+       up(&ec->sem);

         /* TBD: Implement asynch events!
          * NOTE: All we care about are EC-SCI's.  Other EC events are
@@ -623,7 +634,7 @@

         ec->handle =3D device->handle;
         ec->uid =3D -1;
-       spin_lock_init(&ec->lock);
+       sema_init(&ec->sem, 1);
         strcpy(acpi_device_name(device), ACPI_EC_DEVICE_NAME);
         strcpy(acpi_device_class(device), ACPI_EC_CLASS);
         acpi_driver_data(device) =3D ec;
@@ -832,7 +843,7 @@
         status =3D acpi_evaluate_integer(handle, "_GPE", NULL, &ec_ecdt-=
>gpe_bit);
         if (ACPI_FAILURE(status))
                 return status;
-       spin_lock_init(&ec_ecdt->lock);
+       sema_init(&ec_ecdt->sem, 1);
         ec_ecdt->global_lock =3D TRUE;
         ec_ecdt->handle =3D handle;

@@ -909,7 +920,7 @@
         ec_ecdt->status_addr =3D ecdt_ptr->ec_control;
         ec_ecdt->data_addr =3D ecdt_ptr->ec_data;
         ec_ecdt->gpe_bit =3D ecdt_ptr->gpe_bit;
-       spin_lock_init(&ec_ecdt->lock);
+       sema_init(&ec_ecdt->sem, 1);
         /* use the GL just to be safe */
         ec_ecdt->global_lock =3D TRUE;
         ec_ecdt->uid =3D ecdt_ptr->uid;



--=20

Pedro Jo=E3o Lopes Venda
email: pjvenda < at > arrakis.dhis.org
http://arrakis.dhis.org

--------------070906070207020109060601
Content-Type: text/x-patch;
 name="acpi-ec-2.6.11.5.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="acpi-ec-2.6.11.5.diff"

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
+#define ACPI_EC_MSLEEP		100	/* Sleep 1ms between polling */
+#define ACPI_EC_MSLEEP_COUNT	1000	/* Wait 10ms max. during EC ops */
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

--------------070906070207020109060601--

--------------enig6070C263DF5758BE5A83DB15
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCPvLueRy7HWZxjWERAsvsAJ495g99igY9zU+eyh1dS4oScUOVvgCgh8if
15JwVoyaI4UdXory8TbSvBE=
=WTAx
-----END PGP SIGNATURE-----

--------------enig6070C263DF5758BE5A83DB15--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
