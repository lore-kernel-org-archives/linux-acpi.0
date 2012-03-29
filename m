From: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/5] usb: move struct usb_device->children to struct usb_hub_port->child
Date: Thu, 29 Mar 2012 16:35:35 +0800
Message-ID: <4F741ED7.8010105@intel.com>
References: <Pine.LNX.4.44L0.1203281502450.1599-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1203281502450.1599-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, mjg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

hi alan:
	Great thanks for your such careful review.
On 2012=E5=B9=B403=E6=9C=8829=E6=97=A5 03:13, Alan Stern wrote:
> On Wed, 28 Mar 2012, Lan Tianyu wrote:
>
>> Move child's pointer to the struct usb_hub_port since the child devi=
ce
>> is directly associated with the port. Provide usb_get_hub_child_devi=
ce()
>> to get child's pointer.
>
>> --- a/drivers/usb/core/devices.c
>> +++ b/drivers/usb/core/devices.c
>> @@ -590,7 +590,9 @@ static ssize_t usb_device_dump(char __user **buf=
fer, size_t *nbytes,
>>
>>   	/* Now look at all of this device's children. */
>>   	for (chix =3D 0; chix<  usbdev->maxchild; chix++) {
>> -		struct usb_device *childdev =3D usbdev->children[chix];
>> +		struct usb_device *childdev;
>> +		if (usb_get_hub_child_device(usbdev, chix + 1,&childdev)<  0)
>> +			continue;
>>
>
> Whitespace issue: The blank line should come before the new executabl=
e
> statement, not after it.
>
>> @@ -1475,11 +1477,12 @@ bool usb_device_is_owned(struct usb_device *=
udev)
>>
>>   static void recursively_mark_NOTATTACHED(struct usb_device *udev)
>>   {
>> +	struct usb_hub	*hub =3D hdev_to_hub(udev);
>
> I'm not sure this is good.  You are calling hdev_to_hub without knowi=
ng
> beforehand that udev really is a hub -- in fact, most of the time ude=
v
> won't be a hub.  The routine wasn't meant to be used that way.  Have
> you checked that hdev_to_hub won't crash when the argument isn't a hu=
b?
> What happens if the active configuration has no interfaces?
About this, I have an idea to add a check of hdev->maxchild. I have
verified that hdev->maxchild only is set in the hub_configure() and
hub_disconnect(). So we can identify whether the udev is a usb hub or
not through hdev->maxchild. Does this make sense?

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index c70c170..d29a5dc 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -177,7 +177,7 @@ static inline char *portspeed(struct usb_hub *hub, =
int=20
portstatus)
   /* Note that hdev or one of its children must be locked! */
   static struct usb_hub *hdev_to_hub(struct usb_device *hdev)
   {
-       if (!hdev || !hdev->actconfig)
+       if (!hdev || !hdev->actconfig || hdev->maxchild =3D=3D 0)
                  return NULL;
          return usb_get_intfdata(hdev->actconfig->interface[0]);
   }


>> @@ -4147,3 +4151,15 @@ void usb_queue_reset_device(struct usb_interf=
ace *iface)
>>   	schedule_work(&iface->reset_ws);
>>   }
>>   EXPORT_SYMBOL_GPL(usb_queue_reset_device);
>> +
>> +int usb_get_hub_child_device(struct usb_device *hdev, int port1,
>> +	struct usb_device **child)
>> +{
>> +	struct usb_hub *hub =3D hdev_to_hub(hdev);
>> +
>> +	if (port1>  hdev->maxchild || port1<  1)
>> +		return -EINVAL;
>> +	*child =3D hub->port_data[port1 - 1].child;
>> +	return 0;
>> +}
>
> This new routine is more complicated that it needs to be.  You don't
> have to return an error code; none of the callers make use of it.
> Just return the child pointer, and return NULL if there's an error.
>
> Alan Stern
>
>

--=20
Best Regards
Tianyu Lan
linux kernel enabling team
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
