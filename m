From: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/3] USB/ACPI: Add usb port's acpi power control in the
 xhci PORT_POWER feature request process.
Date: Thu, 14 Jun 2012 15:22:42 +0800
Message-ID: <4FD99142.4010403@intel.com>
References: <1339381474-17413-1-git-send-email-tianyu.lan@intel.com> <1339381474-17413-3-git-send-email-tianyu.lan@intel.com> <20120613193038.GA6312@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120613193038.GA6312-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On 2012=E5=B9=B406=E6=9C=8814=E6=97=A5 03:30, Greg KH wrote:
> On Mon, Jun 11, 2012 at 10:24:33AM +0800, Lan Tianyu wrote:
>> On our developping machine, bios can provide usb port's  power contr=
ol via
>> acpi. This patch is to provide usb port's power control way through =
setting
>> or clearing PORT_POWER feature requests. Add two functions usb_acpi_=
power_manageable()
>> and usb_acpi_set_power_state(). The first one is used to find whethe=
r the
>> usb port has acpi power resource and the second is to set the power =
state.
>> They are invoked in the xhci_hub_control() where clearing or setting=
 PORT_POWER
>> feature requests are processed.
>>
>> Signed-off-by: Lan Tianyu<tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>> ---
>>   drivers/usb/core/usb-acpi.c |   28 ++++++++++++++++++++++++++++
>>   drivers/usb/host/xhci-hub.c |   10 ++++++++++
>>   include/linux/usb.h         |   10 ++++++++++
>>   3 files changed, 48 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/usb/core/usb-acpi.c b/drivers/usb/core/usb-acpi=
=2Ec
>> index 82c90d0..e95f26f 100644
>> --- a/drivers/usb/core/usb-acpi.c
>> +++ b/drivers/usb/core/usb-acpi.c
>> @@ -19,6 +19,34 @@
>>
>>   #include "usb.h"
>>
>> +bool usb_acpi_power_manageable(struct usb_device *hdev, int port1)
>> +{
>> +	acpi_handle port_handle;
>> +
>> +	port_handle =3D usb_get_hub_port_acpi_handle(hdev,
>> +		port1);
>> +	return port_handle ? acpi_bus_power_manageable(port_handle) : fals=
e;
>
> Ick, I _really_ hate the ? : usage in C, please use real if statement=
s
> so that everyone can read and understand them easier.  You do that a =
lot
> here, please fix them all.
>
Ok. But in some places, for example
dev_dbg(&hdev->dev, "The power of hub port %d was set to %s\n",
		port1, enable ? "enable" : "disable");
try to print two result. ?: is more convenient. If I use "if" statement=
,
that will be
if (enable)
	result =3D "enable";
else
	result =3D "disable";
dev_dbg(&hdev->dev, "The power of hub port %d was set to %s\n",
		port1, result);

This just looks a little complex.

>> +}
>> +EXPORT_SYMBOL_GPL(usb_acpi_power_manageable);
>> +
>> +int usb_acpi_set_power_state(struct usb_device *hdev, int port1, bo=
ol enable)
>> +{
>> +	acpi_handle port_handle;
>> +	unsigned char state;
>> +	int error =3D -EINVAL;
>> +
>> +	port_handle =3D (acpi_handle)usb_get_hub_port_acpi_handle(hdev,
>> +		port1);
>> +	state =3D enable ? ACPI_STATE_D0 : ACPI_STATE_D3_COLD;
>> +	error =3D acpi_bus_set_power(port_handle, state);
>
> You forgot to check port_handle here.
>
> Why not call usb_acpi_power_manageable() to ensure that you can do th=
is?

In my code, usb_acpi_power_manageable() is invoked before=20
usb_acpi_set_power_state().
Do you mean I should call usb_acpi_power_manageable() in the=20
usb_acpi_set_power_state()?

>
>> +	if (!error)
>> +		dev_dbg(&hdev->dev, "The power of hub port %d was set to %s\n",
>> +			port1, enable ? "enable" : "disabe");
>
> Why not report the error if debugging as well?

Ok.
>
>
>> +
>> +	return error;
>> +}
>> +EXPORT_SYMBOL_GPL(usb_acpi_set_power_state);
>> +
>>   static int usb_acpi_check_port_connect_type(struct usb_device *hde=
v,
>>   	acpi_handle handle, int port1)
>>   {
>> diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub=
=2Ec
>> index 2c55fcf..0ce48b3 100644
>> --- a/drivers/usb/host/xhci-hub.c
>> +++ b/drivers/usb/host/xhci-hub.c
>> @@ -728,6 +728,11 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 t=
ypeReq, u16 wValue,
>>
>>   			temp =3D xhci_readl(xhci, port_array[wIndex]);
>>   			xhci_dbg(xhci, "set port power, actual port %d status  =3D 0x%x=
\n", wIndex, temp);
>> +
>> +			if (usb_acpi_power_manageable(hcd->self.root_hub,
>> +					wIndex + 1))
>
> Why +1?  If you have to do this everywhere, then do it only in the
> function, so you can be 0 based properly.
>
> Also, minor coding style nit, please rewrite as:
> 			if (usb_acpi_power_manageable(hcd->self.root_hub,
> 						      wIndex + 1))
> Or even better yet, use a temp variable for the value returned and th=
en
> check that, it's clearer and easier to read, right?
>
Yeah. Thanks for you suggestion. I will do it.

>> +				usb_acpi_set_power_state(hcd->self.root_hub,
>> +					wIndex + 1, true);
>
> Same question about +1 here.
>
>>   			break;
>>   		case USB_PORT_FEAT_RESET:
>>   			temp =3D (temp | PORT_RESET);
>> @@ -830,6 +835,11 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 t=
ypeReq, u16 wValue,
>>   		case USB_PORT_FEAT_POWER:
>>   			xhci_writel(xhci, temp&  ~PORT_POWER,
>>   				port_array[wIndex]);
>> +
>> +			if (usb_acpi_power_manageable(hcd->self.root_hub,
>> +					wIndex + 1))
>> +				usb_acpi_set_power_state(hcd->self.root_hub,
>> +					wIndex + 1, false);
>>   			break;
>>   		default:
>>   			goto error;
>> diff --git a/include/linux/usb.h b/include/linux/usb.h
>> index feb0a04..92f8898 100644
>> --- a/include/linux/usb.h
>> +++ b/include/linux/usb.h
>> @@ -599,6 +599,16 @@ extern int usb_lock_device_for_reset(struct usb=
_device *udev,
>>   extern int usb_reset_device(struct usb_device *dev);
>>   extern void usb_queue_reset_device(struct usb_interface *dev);
>>
>> +#ifdef CONFIG_ACPI
>> +extern int usb_acpi_set_power_state(struct usb_device *hdev, int po=
rt,
>> +	bool enable);
>> +extern bool usb_acpi_power_manageable(struct usb_device *hdev, int =
port);
>> +#else
>> +static inline int usb_acpi_set_power_state(struct usb_device *hdev,=
 int port,
>> +	bool enable) { return 0; }
>> +static inline bool usb_acpi_power_manageable(struct usb_device *hde=
v, int port)
>> +	{ return 0; }
>
> is 0 a bool?  :)
>
> Please get the types right.
So careless. Thanks for reminder.
>
> greg k-h

--=20
Best Regards
Tianyu Lan
linux kernel enabling team
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
