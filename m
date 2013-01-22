From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [PATCH v6 2/8] usb: Register usb port's acpi power resources
Date: Tue, 22 Jan 2013 11:11:59 +0800
Message-ID: <50FE037F.2090003@intel.com>
References: <1358777887-2656-1-git-send-email-tianyu.lan@intel.com> <1358777887-2656-3-git-send-email-tianyu.lan@intel.com> <20130121212056.GA14908@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:58556 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752581Ab3AVDNs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 Jan 2013 22:13:48 -0500
In-Reply-To: <20130121212056.GA14908@kroah.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: lenb@kernel.org, sarah.a.sharp@linux.intel.com, stern@rowland.harvard.edu, rjw@sisk.pl, oneukum@suse.de, linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org

Hi Greg:
	Great thanks for your review. I learn a lot from your comments which I
have not noticed before.

On 2013=E5=B9=B401=E6=9C=8822=E6=97=A5 05:20, Greg KH wrote:
> On Mon, Jan 21, 2013 at 10:18:01PM +0800, Lan Tianyu wrote:
>> This patch is to register usb port's acpi power resources. Create
>> link between usb port device and its acpi power resource.
>>
>> Acked-by: Alan Stern <stern@rowland.harvard.edu>
>> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
>> ---
>>  drivers/usb/core/port.c     |    3 +++
>>  drivers/usb/core/usb-acpi.c |   20 ++++++++++++++++++++
>>  drivers/usb/core/usb.h      |    6 ++++++
>>  3 files changed, 29 insertions(+)
>>
>> diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
>> index fe5959f..4dfa254 100644
>> --- a/drivers/usb/core/port.c
>> +++ b/drivers/usb/core/port.c
>> @@ -66,6 +66,7 @@ static void usb_port_device_release(struct device =
*dev)
>>  {
>>  	struct usb_port *port_dev =3D to_usb_port(dev);
>> =20
>> +	usb_acpi_unregister_power_resources(dev);
>>  	kfree(port_dev);
>>  }
>> =20
>> @@ -95,6 +96,8 @@ int usb_hub_create_port_device(struct usb_hub *hub=
, int port1)
>>  	if (retval)
>>  		goto error_register;
>> =20
>> +	usb_acpi_register_power_resources(&port_dev->dev);
>> +
>>  	return 0;
>> =20
>>  error_register:
>> diff --git a/drivers/usb/core/usb-acpi.c b/drivers/usb/core/usb-acpi=
=2Ec
>> index cef4252..558ab01 100644
>> --- a/drivers/usb/core/usb-acpi.c
>> +++ b/drivers/usb/core/usb-acpi.c
>> @@ -216,6 +216,26 @@ static struct acpi_bus_type usb_acpi_bus =3D {
>>  	.find_device =3D usb_acpi_find_device,
>>  };
>> =20
>> +int usb_acpi_register_power_resources(struct device *dev)
>> +{
>> +	acpi_handle port_handle =3D DEVICE_ACPI_HANDLE(dev);
>> +
>> +	if (!port_handle)
>> +		return -ENODEV;
>> +
>> +	if (acpi_power_resource_register_device(dev, port_handle) < 0)
>> +		return -ENODEV;
>> +	return 0;
>> +}
>=20
> Why return a value if you never check it?  Either properly handle the
> error in the place you call this function, or don't have a return val=
ue.
>=20
> I'd prefer you to handle the error properly.
Not all system will provide acpi power resouces for usb port and this
will not damage usb device function. So I think I should produce some
warning if the return value is not ENODEV.
>=20
> thanks,
>=20
> greg k-h
>=20


--=20
Best regards
Tianyu Lan
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
