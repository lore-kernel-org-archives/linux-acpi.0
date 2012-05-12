From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [RFC PATCH] usb/acpi: Add support usb port power off mechanism
 for device fixed on the motherboard
Date: Sun, 13 May 2012 02:00:57 +0800
Message-ID: <4FAEA559.804@intel.com>
References: <4FAD3A51.4010803@intel.com> <Pine.LNX.4.44L0.1205111302080.1865-100000@iolanthe.rowland.org> <20120511181256.GD18754@xanatos>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:60872 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750899Ab2ELSBA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 12 May 2012 14:01:00 -0400
In-Reply-To: <20120511181256.GD18754@xanatos>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, lenb@kernel.org, gregkh@linuxfoundation.org, linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org

On 2012/5/12 2:12, Sarah Sharp wrote:
> On Fri, May 11, 2012 at 01:44:26PM -0400, Alan Stern wrote:
>> On Sat, 12 May 2012, Lan Tianyu wrote:
>>
>>>      The power saving depends on devices. I test a usb3.0 ssd. The power saving of
>>> power off is about 2.2w more than just selective suspend. In theory, power
>>> off can help to save remaining power after selective suspend.
>> That's a lot of power!  Suspended USB devices aren't supposed to
>> consume more than 2.5 mA of bus current, which at 5 V amounts to<=
>> 0.0125 W.  Does the port really use that much?  Or does the SSD have a
>> separate power supply that it disables when port power is removed?
> I actually suspect that the host controller is powering off several PLLs
> if all the ports are powered off.  After all, if it doesn't have to pay
> attention to connects, disconnects, or remote wakeup, it can power off a
> lot more circuitry, and possibly even enter D3cold instead of D3hot when
> the PCI device is suspended (depending on what board Tianyu is testing
> on).  But I agree that it would be interesting to see if the SSD has a
> separate power supply that it's turning off.
>
There is no a separate power supply. All power came from host desktop 
via usb cable.

-- 
Best Regards
Tianyu Lan
linux kernel enabling team

