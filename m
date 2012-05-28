From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [RFC PATCH 3/3] usb : Add sysfs files to control usb port's power
Date: Mon, 28 May 2012 13:35:56 +0800
Message-ID: <4FC30EBC.2010607@intel.com>
References: <Pine.LNX.4.44L0.1205251127180.1907-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:43493 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752675Ab2E1FmC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 28 May 2012 01:42:02 -0400
In-Reply-To: <Pine.LNX.4.44L0.1205251127180.1907-100000@iolanthe.rowland.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: gregkh@linuxfoundation.org, lenb@kernel.org, linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, sarah.a.sharp@linux.intel.com

hi alan:
	Great thanks for you review. Sorry for later reply due to my travel :)
On 2012=E5=B9=B405=E6=9C=8825=E6=97=A5 23:41, Alan Stern wrote:
> On Fri, 25 May 2012, Lan Tianyu wrote:
>
>> This patch is to add two sys files for each usb hub ports to control=
 port's power,
>> e.g port1_power_control and port1_power_state both for port one. Con=
trol port's
>> power through setting or clearing PORT_POWER feature.
>>
>> port1_power_control has three options. "auto", "on" and "off"
>> "auto" - if port without device, power off the port.
>> "on" - port must be power on.
>> "off" - port must be power off.
>
> Remind me again -- what's the point of the "auto" setting?  It doesn'=
t
> seem to mean anything as a port power state.
>
> That is, if you write "auto" to the sysfs file then the power will
> remain on if it is already on and a device is plugged in, or it will =
go
> off if it is already off or no device is plugged in.  Either way, it
> won't remain at "auto" because once the power is off, there's no way =
to
> tell when a new device gets plugged in.
>
> Given this, do the power_control and power_state files need to be
> separate?
 From my opinion, power_control determines the work pattern.
Currently, we just consider port without device. When "auto", power off
the port directly. For port with device, if the device was not in the s=
uspend
at that pointer, the power would remain on but it would power off when =
it was
suspended. If the the device was in the suspend, "auto" means the devic=
e could
be put into much lower state so the device need to resume and suspend a=
gain.

Different patterns have different time of power off.
I think their relation just like power/control and power/runtime_status=
=2E
when power/control =3D> "auto", power_/runtime_status maybe "active" or=
 "suspended".

>
>> --- a/drivers/usb/core/hub.c
>> +++ b/drivers/usb/core/hub.c
>
>> @@ -4985,6 +4992,37 @@ usb_get_hub_port_connect_type(struct usb_devi=
ce *hdev,	int port1)
>>   	return hub->port_data[port1 - 1].connect_type;
>>   }
>>
>> +enum port_power_policy
>> +usb_get_hub_port_power_policy(struct usb_device *hdev, int port1)
>> +{
>> +	struct usb_hub *hub =3D hdev_to_hub(hdev);
>> +	return hub->port_data[port1 - 1].port_power_policy;
>> +}
>> +
>> +void usb_set_hub_port_power_policy(struct usb_device *hdev, int por=
t1,
>> +	enum port_power_policy value)
>> +{
>> +	struct usb_hub *hub =3D hdev_to_hub(hdev);
>> +	hub->port_data[port1 - 1].port_power_policy =3D value;
>> +}
>
> I suspect these routines aren't needed at all.
>
>> +void usb_set_hub_port_power(struct usb_device *hdev, int port1, boo=
l enabled)
>> +{
>> +	if (enabled)
>> +		set_port_feature(hdev, port1, USB_PORT_FEAT_POWER);
>> +	else
>> +		clear_port_feature(hdev, port1, USB_PORT_FEAT_POWER);
>> +}
>> +
>> +int usb_get_hub_port_power_state(struct usb_device *hdev, int port1=
)
>> +{
>> +	struct usb_hub *hub =3D hdev_to_hub(hdev);
>> +	u16 portstatus, portchange;
>> +
>> +	hub_port_status(hub, port1,&portstatus,&portchange);
>
> Use get_port_status(), not hub_port_status().
>
>> +	return port_is_power_on(hub, portstatus);
>> +}
>
> These routines don't belong here at the end of the file.  They belong
> near the start, close to set_port_feature() and get_port_status().
>
Ok.
>
>> --- a/drivers/usb/core/sysfs.c
>> +++ b/drivers/usb/core/sysfs.c
>
> No, no, no!  sysfs.c is meant for attributes that apply to all USB
> devices.  Your new attributes apply only to hubs, so they don't belon=
g
> here.
>
> Furthermore, the attributes defined in sysfs.c go in the device's
> sysfs directory, but your attributes belong in the hub's interface
> directory.  That is, the files should go into
> /sys/bus/usb/devices/1-0:1.0, not /sys/bus/usb/devices/usb1.
>
Ok. So I should put these code in the hub.c or create a hub-sysfs.c?

> And they probably don't belong in the power/ subdirectory either.  In
> fact, you might want to create a separate subdirectory for each port
> with one or two files in each subdirectory.
Do you mean
ls /sys/bus/usb/devices/1-0:1.0
bAlternateSetting  bInterfaceClass  bInterfaceNumber  bInterfaceProtoco=
l
bInterfaceSubClass  bNumEndpoints  driver  ep_81  modalias  power
subsystem  supports_autosuspend  uevent port1 port2 port3 port4

ls /sys/bus/usb/devices/1-0:1.0/port1
power_control power_state
?

>
> Alan Stern
>

--=20
Best Regards
Tianyu Lan
linux kernel enabling team
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
