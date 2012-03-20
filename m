From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [RFC PATCH 1/4] usb: add struct usb_hub_port to store port related
 members.
Date: Tue, 20 Mar 2012 14:16:17 +0800
Message-ID: <4F6820B1.6070004@intel.com>
References: <Pine.LNX.4.44L0.1203191156280.1641-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:60746 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753182Ab2CTGSp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Mar 2012 02:18:45 -0400
In-Reply-To: <Pine.LNX.4.44L0.1203191156280.1641-100000@iolanthe.rowland.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: lenb@kernel.org, gregkh@linuxfoundation.org, linux-acpi@vger.kernel.org, mjg@redhat.com, linux-usb@vger.kernel.org, sarah.a.sharp@intel.com

On 2012=E5=B9=B403=E6=9C=8820=E6=97=A5 00:04, Alan Stern wrote:
> On Mon, 19 Mar 2012, Lan Tianyu wrote:
>
>> Add struct usb_hub_port pointer port_data in the struct usb_hub and =
allocate
>> struct usb_hub_port perspectively for each ports to store private da=
ta.
>
> You might as well add the child device pointer into your new data
> structure.  This will require changes to at least three other files i=
n
> addition to hub.c:
hi alan:
	Great thanks for your review.
	But I still confuse about "You might as well add the child device poin=
ter
into your new data structure." Could you help me to make it clear? :)
	Do you mean add struct usb_device pointer toward the device attached t=
o the=20
port in the
struct usb_hub_port? If yes,Why?
>
> 	devices.c, host/r8a66597-hcd.c,
> 	drivers/staging/usbip/usbip_common.c
>
> Maybe some others; I didn't look through the entire kernel source.  I=
t
> also means you will have to export a function to get a pointer to the
> child device, given the port number.
	If it was necessary, could I fill the child pointer in the=20
hub_port_connect_change()? just
after a new usb device being created.

static void hub_port_connect_change(struct usb_hub *hub, int port1,
					u16 portstatus, u16 portchange) {
		...
		/* Run it through the hoops (find a driver, etc) */
		if (!status) {
			status =3D usb_new_device(udev);
			if (status) {
				spin_lock_irq(&device_state_lock);
				hdev->children[port1-1] =3D NULL;
				spin_unlock_irq(&device_state_lock);
			}
			/* like here?*/
		}
		...
}

Thanks again. Look forward for your reply.
>
>> @@ -1451,13 +1456,12 @@ void usb_hub_release_all_ports(struct usb_de=
vice *hdev, void *owner)
>>   	int n;
>>   	void **powner;
>>
>> -	n =3D find_port_owner(hdev, 1,&powner);
>> -	if (n =3D=3D 0) {
>> -		for (; n<  hdev->maxchild; (++n, ++powner)) {
>> -			if (*powner =3D=3D owner)
>> -				*powner =3D NULL;
>> -		}
>> +	for (n =3D 1; n<=3D hdev->maxchild; n++) {
>> +		find_port_owner(hdev, n,&powner);
>> +		if (*powner =3D=3D owner)
>> +			*powner =3D NULL;
>>   	}
>
> This is wrong; find_port_owner() doesn't set powner to anything if an
> error occurs.
>
> You can just set the pointer field directly to NULL, instead of looki=
ng
> it up in find_port_owner().  I don't remember why it was written that
> way originally.
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
