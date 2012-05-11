From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [RFC PATCH] usb/acpi: Add support usb port power off mechanism
 for device fixed on the motherboard
Date: Sat, 12 May 2012 02:18:54 +0800
Message-ID: <4FAD580E.2010301@intel.com>
References: <Pine.LNX.4.44L0.1205111302080.1865-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:10469 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756764Ab2EKSYO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 11 May 2012 14:24:14 -0400
In-Reply-To: <Pine.LNX.4.44L0.1205111302080.1865-100000@iolanthe.rowland.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Sarah Sharp <sarah.a.sharp@linux.intel.com>, lenb@kernel.org, gregkh@linuxfoundation.org, linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org

On 2012=E5=B9=B405=E6=9C=8812=E6=97=A5 01:44, Alan Stern wrote:
> On Sat, 12 May 2012, Lan Tianyu wrote:
>
>>      The power saving depends on devices. I test a usb3.0 ssd. The p=
ower saving of
>> power off is about 2.2w more than just selective suspend. In theory,=
 power
>> off can help to save remaining power after selective suspend.
>
> That's a lot of power!  Suspended USB devices aren't supposed to
> consume more than 2.5 mA of bus current, which at 5 V amounts to<=3D
> 0.0125 W.  Does the port really use that much?  Or does the SSD have =
a
> separate power supply that it disables when port power is removed?

The device consumes about 3.1w. The selective suspend can cut down 0.7-=
0.9w
After power off port, all power will removed.
I test all the motherboard power consumption and get the result.
 From lsusb, it's self-powered.

lsusb
Bus 003 Device 006: ID 174c:55aa ASMedia Technology Inc.
Device Descriptor:
   bLength                18
   bDescriptorType         1
   bcdUSB               2.10
   bDeviceClass            0 (Defined at Interface level)
   bDeviceSubClass         0
   bDeviceProtocol         0
   bMaxPacketSize0        64
   idVendor           0x174c ASMedia Technology Inc.
   idProduct          0x55aa
   bcdDevice            1.00
   iManufacturer           2 012345678901234567890123456789012345678901=
23
   iProduct                3 012345678901234567890123456789012345678901=
234567
   iSerial                 1 0123456789ABCDEF019F
   bNumConfigurations      1
   Configuration Descriptor:
     bLength                 9
     bDescriptorType         2
     wTotalLength           32
     bNumInterfaces          1
     bConfigurationValue     1
     iConfiguration          0
     bmAttributes         0xc0
       Self Powered
     MaxPower                0mA
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        0
       bAlternateSetting       0
       bNumEndpoints           2
       bInterfaceClass         8 Mass Storage
       bInterfaceSubClass      6 SCSI
       bInterfaceProtocol     80 Bulk (Zip)
       iInterface              0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x81  EP 1 IN
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0200  1x 512 bytes
         bInterval               0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x02  EP 2 OUT
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0200  1x 512 bytes
         bInterval               0
Device Status:     0x0001
   Self Powered



--=20
Best Regards
Tianyu Lan
linux kernel enabling team
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
