From: "Wang, Zhenyu Z" <zhenyu.z.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH 1/2] acpi_bus_register_driver conflict fix patchesannounce
Date: Fri, 12 Nov 2004 14:58:37 +0800
Message-ID: <9DE394C12A921946AEECE1F71944ECD58E416E@pdsmsx404>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
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
To: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, bjorn.helgaas-VXdhtT5mjnY@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-acpi <linux-acpi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Len Brown wrote:
> this patch is in direct conflict with bjorn's proposal to make
> acpi_bus_register_driver() consistent (again) with
> pci_register_driver().
>=20
> We can't have it both ways...
Oh, yes...I've just found bjorn's patch, very neat.
but some user will still be confused with question like "why my fan is
not work well", etc.
this is maybe my personal annoyance, forget it...

thanks
>=20
> -Len
>=20
> On Fri, 2004-11-12 at 01:22, Wang, Zhenyu Z wrote:
>> a00-acpi_bus_register_driver_fix.patch
>>=20
>> This patch is for correct the return value flaw of
>> acpi_bus_register_driver.
>> It should return the number of devices claimed by the driver, or
>> negative error code. I've also seperate out
>> acpi_bus_driver_add/acpi_bus_driver_del, which will be used by acpi
>> drivers on error condition handling.=20
>>=20
>> Signed-off-by: Wang, Zhenyu <zhenyu.z.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>>=20
>> ---
>>=20
>> drivers/acpi/acpi_ksyms.c |    2 ++
>>  drivers/acpi/scan.c       |   42
>> ++++++++++++++++++++++++++++++------------
>>  include/acpi/acpi_bus.h   |    2 ++
>>  3 files changed, 34 insertions(+), 12 deletions(-)
>>=20
>> --- a/drivers/acpi/scan.c~driver_attach	2004-11-12
>> 11:34:14.000000000 +0800 +++ a/drivers/acpi/scan.c	2004-11-12
>> 12:39:34.000000000 +0800 @@ -372,7 +372,7 @@ acpi_bus_driver_init (
>>  static int acpi_driver_attach(struct acpi_driver * drv)  {
>>  	struct list_head * node, * next;
>> -	int count =3D 0;
>> +	int count =3D 0, result =3D 0;
>>=20
>>  	ACPI_FUNCTION_TRACE("acpi_driver_attach");
>>=20
>> @@ -384,18 +384,23 @@ static int acpi_driver_attach(struct acp=20
>>  		continue; spin_unlock(&acpi_device_lock);
>>=20
>> -		if (!acpi_bus_match(dev, drv)) {
>> -			if (!acpi_bus_driver_init(dev, drv)) {
>> +		if (!(result =3D acpi_bus_match(dev, drv))) {
>> +			if (!(result =3D acpi_bus_driver_init(dev, drv)))
{
>>  				atomic_inc(&drv->references);
>>  				count++;
>>  				ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found
>> driver [%s] for device [%s]\n",
>>  						  drv->name,
>> dev->pnp.bus_id));
>> +			} else {
>> +				ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Attach
>> driver [%s] for device [%s] fail!\n", drv->name, dev->pnp.bus_id));=20
>>  		} }
>>  		spin_lock(&acpi_device_lock);
>>  	}
>>  	spin_unlock(&acpi_device_lock);
>> -	return_VALUE(count);
>> +	if (result !=3D -ENOENT && !count)
>> +		return_VALUE(result);
>> +	else
>> +		return_VALUE(count);
>>  }
>>=20
>>  static int acpi_driver_detach(struct acpi_driver * drv)
>> @@ -422,6 +427,24 @@ static int acpi_driver_detach(struct acp=20
>>  return_VALUE(0); }
>>=20
>> +void
>> +acpi_bus_driver_add(
>> +	struct acpi_driver *driver)
>> +{
>> +	spin_lock(&acpi_device_lock);
>> +	list_add_tail(&driver->node, &acpi_bus_drivers);
>> +	spin_unlock(&acpi_device_lock);
>> +}
>> +
>> +void
>> +acpi_bus_driver_del(
>> +	struct acpi_driver *driver)
>> +{
>> +	spin_lock(&acpi_device_lock);
>> +	list_del_init(&driver->node);
>> +	spin_unlock(&acpi_device_lock);
>> +}
>> +
>>  /**
>>   * acpi_bus_register_driver
>>   * ------------------------
>> @@ -444,9 +467,7 @@ acpi_bus_register_driver (
>>  	if (!driver)
>>  		return_VALUE(-EINVAL);
>>=20
>> -	spin_lock(&acpi_device_lock);
>> -	list_add_tail(&driver->node, &acpi_bus_drivers);
>> -	spin_unlock(&acpi_device_lock);
>> +	acpi_bus_driver_add(driver);
>>  	count =3D acpi_driver_attach(driver);
>>=20
>>  	return_VALUE(count);
>> @@ -470,11 +491,8 @@ acpi_bus_unregister_driver (
>>  	if (driver) {
>>  		acpi_driver_detach(driver);
>>=20
>> -		if (!atomic_read(&driver->references)) {
>> -			spin_lock(&acpi_device_lock);
>> -			list_del_init(&driver->node);
>> -			spin_unlock(&acpi_device_lock);
>> -		}
>> +		if (!atomic_read(&driver->references))
>> +			acpi_bus_driver_del(driver);
>>  	} else
>>  		error =3D -EINVAL;
>>  	return_VALUE(error);
>> --- a/drivers/acpi/acpi_ksyms.c~fix	2004-11-12 12:40:12.000000000
>> +0800 +++ a/drivers/acpi/acpi_ksyms.c	2004-11-12
12:40:50.000000000
>> +0800 @@ -135,6 +135,8 @@ EXPORT_SYMBOL(acpi_bus_generate_event);
>>  EXPORT_SYMBOL(acpi_bus_receive_event);
>>  EXPORT_SYMBOL(acpi_bus_register_driver);
>>  EXPORT_SYMBOL(acpi_bus_unregister_driver);
>> +EXPORT_SYMBOL(acpi_bus_driver_add);
>> +EXPORT_SYMBOL(acpi_bus_driver_del);
>>=20
>>  #endif /*CONFIG_ACPI_BUS*/
>>=20
>> --- a/include/acpi/acpi_bus.h~fix	2004-11-12 12:38:53.000000000
+0800
>> +++ a/include/acpi/acpi_bus.h	2004-11-12 12:37:50.000000000
+0800
>> @@ -319,6 +319,8 @@ int acpi_bus_get_power (acpi_handle hand
>>  int acpi_bus_set_power (acpi_handle handle, int state);
>>  int acpi_bus_generate_event (struct acpi_device *device, u8 type,
>>  int data); int acpi_bus_receive_event (struct acpi_bus_event
>> *event); +void acpi_bus_driver_add (struct acpi_driver *driver);
>> +void acpi_bus_driver_del (struct acpi_driver *driver);
>>  int acpi_bus_register_driver (struct acpi_driver *driver);
>>  int acpi_bus_unregister_driver (struct acpi_driver *driver);



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
