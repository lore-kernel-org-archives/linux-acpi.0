From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [PATCH 5/7] usb: move struct usb_device->children to struct usb_hub_port->child
Date: Wed, 18 Apr 2012 10:19:59 +0800
Message-ID: <4F8E24CF.8050300@intel.com>
References: <1334642522-22021-1-git-send-email-tianyu.lan@intel.com> <1334642522-22021-6-git-send-email-tianyu.lan@intel.com> <20120417170225.GA4670@xanatos>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:63953 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752512Ab2DRCYA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 17 Apr 2012 22:24:00 -0400
In-Reply-To: <20120417170225.GA4670@xanatos>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Cc: lenb@kernel.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, stern@rowland.harvard.edu, mjg59@srcf.ucam.org

hi sarah:
             Oh. Thanks for review.  Good catching. This is a missing=20
caused
by carelessness during updating patch.  I will update patch soon.

=E4=BA=8E2012=E5=B9=B404=E6=9C=8818=E6=97=A5 =E6=98=9F=E6=9C=9F=E4=B8=89=
 01=E6=97=B602=E5=88=8625=E7=A7=92,Sarah Sharp=E5=86=99=E5=88=B0:
> On Tue, Apr 17, 2012 at 02:02:00PM +0800, Lan Tianyu wrote:
>> Move child's pointer to the struct usb_hub_port since the child devi=
ce
>> is directly associated with the port. Provide usb_get_hub_child_devi=
ce()
>> to get child's pointer.
>
> It looks like you deleted the documentation for the children pointer
> from usb_hub_port, but didn't actually remove the pointer from the
> structure.  Did you mean to do that?
>
>> diff --git a/include/linux/usb.h b/include/linux/usb.h
>> index 73b68d1..1ea01a5 100644
>> --- a/include/linux/usb.h
>> +++ b/include/linux/usb.h
>> @@ -428,7 +428,6 @@ enum usb_device_removable {
>>    *	access from userspace
>>    * @usbfs_dentry: usbfs dentry entry for the device
>>    * @maxchild: number of ports if hub
>> - * @children: child devices - USB devices that are attached to this=
 hub
>>    * @quirks: quirks of the whole device
>>    * @urbnum: number of URBs submitted for the whole device
>>    * @active_duration: total time device is not suspended
>> @@ -527,6 +526,8 @@ static inline struct usb_device *interface_to_us=
bdev(struct usb_interface *intf)
>>
>>   extern struct usb_device *usb_get_dev(struct usb_device *dev);
>>   extern void usb_put_dev(struct usb_device *dev);
>> +extern struct usb_device *usb_get_hub_child_device(struct usb_devic=
e *hdev,
>> +	int port1);
>>
>>   /* USB device locking */
>>   #define usb_lock_device(udev)		device_lock(&(udev)->dev)
>> --=20
>> 1.7.6.rc2.8.g28eb
>>
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
