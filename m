From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH] Don't disable interrupts during EC access
Date: Tue, 16 Nov 2004 14:15:47 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F84041AC076@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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
To: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: "Fu, Michael" <michael.fu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Andi,

This patch seems to break the atomic operation.
The original code enclosed by spin_lock_irqsave/spin_unlock_irqresotre =
is trying to make sure the first operation to EC_COMMAND
register , and the second operation to EC_DATA register belong to one =
atomic transaction.

Thanks
Luming=20

>-----Original Message-----
>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org=20
>[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Andi Kleen
>Sent: 2004=C4=EA11=D4=C216=C8=D5 6:56
>To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: [ACPI] [PATCH] Don't disable interrupts during EC access
>
>
>On VIA chipset + A64 laptops the EC access can take a long=20
>time. This causes
>the system to lose timer interrupts while ACPI waits for the event,=20
>and causes it to always fallback to slower timer sources.
>
>This patch replaces the spinlock with a semaphore and sleeps instead
>of busy polling. This should also save power.=20
>
>Signed-off-by: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
>
>-Andi
>
>diff -u linux/drivers/acpi/ec.c-o linux/drivers/acpi/ec.c
>--- linux/drivers/acpi/ec.c-o	2004-10-26 09:57:32.000000000 -0700
>+++ linux/drivers/acpi/ec.c	2004-11-15 12:55:58.000000000 -0800
>@@ -29,10 +29,12 @@
> #include <linux/types.h>
> #include <linux/delay.h>
> #include <linux/proc_fs.h>
>+#include <linux/interrupt.h>
> #include <asm/io.h>
> #include <acpi/acpi_bus.h>
> #include <acpi/acpi_drivers.h>
> #include <acpi/actypes.h>
>+#include <asm/msr.h>
>=20
> #define _COMPONENT		ACPI_EC_COMPONENT
> ACPI_MODULE_NAME		("acpi_ec")
>@@ -53,7 +55,7 @@
> #define ACPI_EC_EVENT_IBE	0x02	/* Input buffer empty */
>=20
> #define ACPI_EC_UDELAY		100	/* Poll @ 100us=20
>increments */
>-#define ACPI_EC_UDELAY_COUNT	1000	/* Wait 10ms max.=20
>during EC ops */
>+#define ACPI_EC_UDELAY_COUNT	10	/* Wait 10ms max.=20
>during EC ops */
> #define ACPI_EC_UDELAY_GLK	1000	/* Wait 1ms max. to get=20
>global lock */
>=20
> #define ACPI_EC_COMMAND_READ	0x80
>@@ -85,7 +87,6 @@
> 	struct acpi_generic_address	command_addr;
> 	struct acpi_generic_address	data_addr;
> 	unsigned long			global_lock;
>-	spinlock_t			lock;
> };
>=20
> /* If we find an EC via the ECDT, we need to keep a ptr to=20
>its context */
>@@ -116,7 +117,7 @@
> 			acpi_hw_low_level_read(8,=20
>&acpi_ec_status, &ec->status_addr);
> 			if (acpi_ec_status & ACPI_EC_FLAG_OBF)
> 				return 0;
>-			udelay(ACPI_EC_UDELAY);
>+			msleep(1);
> 		} while (--i>0);
> 		break;
> 	case ACPI_EC_EVENT_IBE:
>@@ -124,16 +125,16 @@
> 			acpi_hw_low_level_read(8,=20
>&acpi_ec_status, &ec->status_addr);
> 			if (!(acpi_ec_status & ACPI_EC_FLAG_IBF))
> 				return 0;
>-			udelay(ACPI_EC_UDELAY);
>+			msleep(1);
> 		} while (--i>0);
> 		break;
> 	default:
> 		return -EINVAL;
> 	}
>-
> 	return -ETIME;
> }
>=20
>+static DECLARE_MUTEX(ec_mutex);
>=20
> static int
> acpi_ec_read (
>@@ -143,7 +144,6 @@
> {
> 	acpi_status		status =3D AE_OK;
> 	int			result =3D 0;
>-	unsigned long		flags =3D 0;
> 	u32			glk =3D 0;
>=20
> 	ACPI_FUNCTION_TRACE("acpi_ec_read");
>@@ -158,8 +158,9 @@
> 		if (ACPI_FAILURE(status))
> 			return_VALUE(-ENODEV);
> 	}
>-=09
>-	spin_lock_irqsave(&ec->lock, flags);
>+
>+	WARN_ON(in_interrupt());
>+	down(&ec_mutex);
>=20
> 	acpi_hw_low_level_write(8, ACPI_EC_COMMAND_READ,=20
>&ec->command_addr);
> 	result =3D acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
>@@ -173,16 +174,15 @@
>=20
>=20
> 	acpi_hw_low_level_read(8, data, &ec->data_addr);
>-
> 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Read [%02x] from=20
>address [%02x]\n",
> 		*data, address));
>=20
>+	=09
> end:
>-	spin_unlock_irqrestore(&ec->lock, flags);
>+	up(&ec_mutex);
>=20
> 	if (ec->global_lock)
> 		acpi_release_global_lock(glk);
>-
> 	return_VALUE(result);
> }
>=20
>@@ -195,7 +195,6 @@
> {
> 	int			result =3D 0;
> 	acpi_status		status =3D AE_OK;
>-	unsigned long		flags =3D 0;
> 	u32			glk =3D 0;
>=20
> 	ACPI_FUNCTION_TRACE("acpi_ec_write");
>@@ -209,7 +208,8 @@
> 			return_VALUE(-ENODEV);
> 	}
>=20
>-	spin_lock_irqsave(&ec->lock, flags);
>+	WARN_ON(in_interrupt());
>+	down(&ec_mutex);
>=20
> 	acpi_hw_low_level_write(8, ACPI_EC_COMMAND_WRITE,=20
>&ec->command_addr);
> 	result =3D acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
>@@ -230,7 +230,7 @@
> 		data, address));
>=20
> end:
>-	spin_unlock_irqrestore(&ec->lock, flags);
>+	up(&ec_mutex);
>=20
> 	if (ec->global_lock)
> 		acpi_release_global_lock(glk);
>@@ -287,7 +287,6 @@
> {
> 	int			result =3D 0;
> 	acpi_status		status =3D AE_OK;
>-	unsigned long		flags =3D 0;
> 	u32			glk =3D 0;
>=20
> 	ACPI_FUNCTION_TRACE("acpi_ec_query");
>@@ -308,7 +307,7 @@
> 	 * Note that successful completion of the query causes=20
>the ACPI_EC_SCI
> 	 * bit to be cleared (and thus clearing the interrupt source).
> 	 */
>-	spin_lock_irqsave(&ec->lock, flags);
>+	down(&ec_mutex);
>=20
> 	acpi_hw_low_level_write(8, ACPI_EC_COMMAND_QUERY,=20
>&ec->command_addr);
> 	result =3D acpi_ec_wait(ec, ACPI_EC_EVENT_OBF);
>@@ -320,7 +319,7 @@
> 		result =3D -ENODATA;
>=20
> end:
>-	spin_unlock_irqrestore(&ec->lock, flags);
>+	up(&ec_mutex);
>=20
> 	if (ec->global_lock)
> 		acpi_release_global_lock(glk);
>@@ -344,7 +343,6 @@
> {
> 	struct acpi_ec		*ec =3D (struct acpi_ec *) ec_cxt;
> 	u32			value =3D 0;
>-	unsigned long		flags =3D 0;
> 	static char		object_name[5] =3D {'_','Q','0','0','\0'};
> 	const char		hex[] =3D=20
>{'0','1','2','3','4','5','6','7',
> 				        =20
>'8','9','A','B','C','D','E','F'};
>@@ -354,9 +352,9 @@
> 	if (!ec_cxt)
> 		goto end;=09
>=20
>-	spin_lock_irqsave(&ec->lock, flags);
>+	down(&ec_mutex);
> 	acpi_hw_low_level_read(8, &value, &ec->command_addr);
>-	spin_unlock_irqrestore(&ec->lock, flags);
>+	up(&ec_mutex);
>=20
> 	/* TBD: Implement asynch events!
> 	 * NOTE: All we care about are EC-SCI's.  Other EC events are
>@@ -588,7 +586,6 @@
>=20
> 	ec->handle =3D device->handle;
> 	ec->uid =3D -1;
>-	ec->lock =3D SPIN_LOCK_UNLOCKED;
> 	strcpy(acpi_device_name(device), ACPI_EC_DEVICE_NAME);
> 	strcpy(acpi_device_class(device), ACPI_EC_CLASS);
> 	acpi_driver_data(device) =3D ec;
>@@ -802,7 +799,6 @@
> 	ec_ecdt->status_addr =3D ecdt_ptr->ec_control;
> 	ec_ecdt->data_addr =3D ecdt_ptr->ec_data;
> 	ec_ecdt->gpe_bit =3D ecdt_ptr->gpe_bit;
>-	ec_ecdt->lock =3D SPIN_LOCK_UNLOCKED;
> 	/* use the GL just to be safe */
> 	ec_ecdt->global_lock =3D TRUE;
> 	ec_ecdt->uid =3D ecdt_ptr->uid;
>
>
>-------------------------------------------------------
>This SF.Net email is sponsored by: InterSystems CACHE
>FREE OODBMS DOWNLOAD - A multidimensional database that combines
>robust object and relational technologies, making it a perfect match
>for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
>_______________________________________________
>Acpi-devel mailing list
>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>https://lists.sourceforge.net/lists/listinfo/acpi-devel
>


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
