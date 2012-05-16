From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [RFC PATCH] usb/acpi: Add support usb port power off mechanism
 for device fixed on the motherboard
Date: Wed, 16 May 2012 14:26:51 +0800
Message-ID: <4FB348AB.5050308@intel.com>
References: <20120511202113.GH18754@xanatos> <Pine.LNX.4.44L0.1205111629150.1865-100000@iolanthe.rowland.org> <20120511235922.GJ18754@xanatos> <20120512001722.GA28011@kroah.com> <20120514232123.GK18754@xanatos> <4FB268CA.9060304@intel.com> <20120515151800.GC23916@kroah.com> <20120515200047.GA20507@xanatos>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:27228 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759077Ab2EPGcZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 May 2012 02:32:25 -0400
In-Reply-To: <20120515200047.GA20507@xanatos>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sarah Sharp <sarah.a.sharp@linux.intel.com>, Greg KH <gregkh@linuxfoundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Dan Williams <dcbw@redhat.com>, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org

On 2012=E5=B9=B405=E6=9C=8816=E6=97=A5 04:00, Sarah Sharp wrote:
> On Tue, May 15, 2012 at 08:18:00AM -0700, Greg KH wrote:
>> On Tue, May 15, 2012 at 10:31:38PM +0800, Lan Tianyu wrote:
>>> Since alan suggested we should start simpler version(power
>>> down port that have no devices attached) firstly. And we
>>> also should provide general power off mechanism.
>>>
>>> I have a proposal.
>>> first:  add portx_power_control sys file.
>>>       echo "auto" =3D>  portx_power_control
>>>                      check whether there is a device. if no, send t=
he clear
>>>                      USB_PORT_FEAT_POWER request. (since general wa=
y
>>>                      to control port power is via set or clear PORT=
_POWER)
>>>
>>>      echo "on" =3D>   portx_power_control
>>>                      send the set  USB_PORT_FEAT_POWER request.
>>
>> No "off"?
>
> Yeah, we probably need an "off" for those libusb and ModemManager
> developers who want to try and simulate a disconnect of a misbehaving
> device.
>
> Sarah Sharp

Ok. Let me reconfirm the meaning of these opinions.

"auto"
	if port without device, turn off power directly.
	if port with device, turn off power when the device is suspended.

"on"	the port's power must be on.

"off"	the port's power must be off.

Right?

> On Tue, May 15, 2012 at 08:18:00AM -0700, Greg KH wrote:
>> Do you have a patch showing that this works?
Currently no. I will write a RFC version and send out for discuss.

--=20
Best Regards
Tianyu Lan
linux kernel enabling team
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
