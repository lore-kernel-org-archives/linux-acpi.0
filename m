From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [RFC PATCH] usb/acpi: Add support usb port power off mechanism
 for device fixed on the motherboard
Date: Wed, 16 May 2012 23:32:26 +0800
Message-ID: <4FB3C88A.2030302@intel.com>
References: <4FB348AB.5050308@intel.com> <Pine.LNX.4.44L0.1205161033340.1852-100000@iolanthe.rowland.org> <20120516143958.GA612@kroah.com> <4FB3BF95.50600@intel.com> <20120516150846.GB3293@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:21517 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753950Ab2EPPca (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 May 2012 11:32:30 -0400
In-Reply-To: <20120516150846.GB3293@kroah.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Sarah Sharp <sarah.a.sharp@linux.intel.com>, Dan Williams <dcbw@redhat.com>, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org

On 2012/5/16 23:08, Greg KH wrote:
> On Wed, May 16, 2012 at 10:54:13PM +0800, Lan Tianyu wrote:
>> On 2012/5/16 22:39, Greg KH wrote:
>>> On Wed, May 16, 2012 at 10:36:02AM -0400, Alan Stern wrote:
>>>> On Wed, 16 May 2012, Lan Tianyu wrote:
>>>>
>>>>> Ok. Let me reconfirm the meaning of these opinions.
>>>>>
>>>>> "auto"
>>>>> 	if port without device, turn off power directly.
>>>>> 	if port with device, turn off power when the device is suspended.
>>>>>
>>>>> "on"	the port's power must be on.
>>>>>
>>>>> "off"	the port's power must be off.
>>>>>
>>>>> Right?
>>>> Maybe the "auto" setting should be renamed "active".  Then "auto" can
>>>> be used for:
>>>>
>>>> 	If the port has a device, turn the power on.
>>>> 	If the port doesn't have a device, turn the power off.
>>> And plugging a new device into a port that was powered off is going to
>>> cause the power to come back on, right?
>> When the port was powered off, the connect-change event will not be
>> detected and
>> we don't know a device was plugged in. :(
> Then that doesn't seem like a very good thing to ever do, right?
Maybe. In some situations, user don't care whether there is device 
plugged in
for example, the blank screen. This is user space policy. We provide a way
for them to control the power on the port and they control when power
off the port.
> greg k-h


-- 
Best Regards
Tianyu Lan
linux kernel enabling team

