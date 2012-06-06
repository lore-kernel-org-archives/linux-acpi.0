From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [RFC PATCH V3 3/3] usb : Add sysfs files to control usb port's
 power
Date: Wed, 06 Jun 2012 09:53:18 +0800
Message-ID: <4FCEB80E.3070100@intel.com>
References: <Pine.LNX.4.44L0.1206051017040.1542-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:38014 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751327Ab2FFB7x (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 5 Jun 2012 21:59:53 -0400
In-Reply-To: <Pine.LNX.4.44L0.1206051017040.1542-100000@iolanthe.rowland.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: gregkh@linuxfoundation.org, lenb@kernel.org, linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, sarah.a.sharp@linux.intel.com

On 2012=E5=B9=B406=E6=9C=8805=E6=97=A5 22:18, Alan Stern wrote:
> On Tue, 5 Jun 2012, Lan Tianyu wrote:
>
>>> The patch does not implement anything at all for "auto".  It should=
 do
>>> _something_.
>>>
>> Yeah, if we don't power off port without device when echo "auto">  p=
ortX/control,
>> this patch does nothing about "auto". Original plan is to deal with =
port without
>> devices firstly. Do you mean I should add the process of port with d=
evice in this
>> patch?
>
> At least make a start.  For example, have "auto" turn off the power i=
f
> no device is attached to the port.

In your reply for v2, hint that user space can power off port without
device, so I removed related code. Did I misunderstand?

>> control has three options. "auto", "on" and "off"
>> "auto" - if port without device, power off the port.
>> 	(This patch only cover ports without device)
> Is this option really needed?  Can't userspace check first to see
> whether there is a device, and then write "off" if there isn't?
>
>> 	For ports with device, there is a proposal that if the device was n=
ot
>> 	in the suspend at that pointer, the power would remain on but it wo=
uld
>> 	power off when it was suspended. If the the device was in the suspe=
nd,
>> 	"auto" means the device could be put into much lower state so the d=
evice
>> 	need to resume and suspend again.
> That makes more sense.  Without this, however, there is no need for
> "auto".
>


>
> If "auto" does nothing, there's no reason to put it in this patch at
> all.  It could be added in a later patch, along with its
> implementation.
OK. I prefer to remove "auto" option in this patch. We can further disc=
uss
the function of "auto".

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
