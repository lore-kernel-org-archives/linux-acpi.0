From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [RFC PATCH 1/4] usb: add struct usb_hub_port to store port related
 members.
Date: Wed, 21 Mar 2012 16:53:57 +0800
Message-ID: <4F699725.3080404@intel.com>
References: <Pine.LNX.4.44L0.1203200957260.3013-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:34376 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750744Ab2CUI41 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 21 Mar 2012 04:56:27 -0400
In-Reply-To: <Pine.LNX.4.44L0.1203200957260.3013-100000@netrider.rowland.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: lenb@kernel.org, gregkh@linuxfoundation.org, linux-acpi@vger.kernel.org, mjg@redhat.com, linux-usb@vger.kernel.org, sarah.a.sharp@intel.com

On 2012=E5=B9=B403=E6=9C=8820=E6=97=A5 22:04, Alan Stern wrote:
> On Tue, 20 Mar 2012, Lan Tianyu wrote:
>
>> On 2012=E5=B9=B403=E6=9C=8820=E6=97=A5 00:04, Alan Stern wrote:
>>> On Mon, 19 Mar 2012, Lan Tianyu wrote:
>>>
>>>> Add struct usb_hub_port pointer port_data in the struct usb_hub an=
d allocate
>>>> struct usb_hub_port perspectively for each ports to store private =
data.
>>>
>>> You might as well add the child device pointer into your new data
>>> structure.  This will require changes to at least three other files=
 in
>>> addition to hub.c:
>> hi alan:
>> 	Great thanks for your review.
>> 	But I still confuse about "You might as well add the child device p=
ointer
>> into your new data structure." Could you help me to make it clear? :=
)
>> 	Do you mean add struct usb_device pointer toward the device attache=
d to the
>> port in the
>> struct usb_hub_port? If yes,Why?
>
> Yes, that's what I mean.  It's a natural thing to do; the child devic=
e
> is directly associated with the port.  It's better than allocating a
> separate array for hdev->children.
OK. That' mean that I should replace the hdev->children with=20
port_data->child_device.
In the hub.c, the struct usb_hub_port can be visited and the child_devi=
ce can be=20
accessed
directly. Out of hub.c, I should provide function to return child point=
er. Is=20
that right?
>
>>> 	devices.c, host/r8a66597-hcd.c,
>>> 	drivers/staging/usbip/usbip_common.c
>>>
>>> Maybe some others; I didn't look through the entire kernel source. =
 It
>>> also means you will have to export a function to get a pointer to t=
he
>>> child device, given the port number.
>> 	If it was necessary, could I fill the child pointer in the
>> hub_port_connect_change()? just
>> after a new usb device being created.
>>
>> static void hub_port_connect_change(struct usb_hub *hub, int port1,
>> 					u16 portstatus, u16 portchange) {
>> 		...
>> 		/* Run it through the hoops (find a driver, etc) */
>> 		if (!status) {
>> 			status =3D usb_new_device(udev);
>> 			if (status) {
>> 				spin_lock_irq(&device_state_lock);
>> 				hdev->children[port1-1] =3D NULL;
>> 				spin_unlock_irq(&device_state_lock);
>> 			}
>> 			/* like here?*/
>> 		}
>> 		...
>> }
>
> That's the right idea, but the wrong place.  The right place to fill
> in the pointer is a few lines higher, where the code already does
>
> 			hdev->children[port1-1] =3D udev;
>
> while holding the device_state_lock.
>
> Alan Stern
>
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
