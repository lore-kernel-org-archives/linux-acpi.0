From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: the errors about two EC patches
Date: Thu, 11 Sep 2008 12:14:00 +0400
Message-ID: <48C8D348.6050209@gmail.com>
References: <1221036693.3989.175.camel@yakui_zhao.sh.intel.com>	 <48C7BF94.6010204@gmail.com> <1221100968.3989.224.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-gx0-f16.google.com ([209.85.217.16]:49765 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752254AbYIKIOG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 11 Sep 2008 04:14:06 -0400
Received: by gxk9 with SMTP id 9so15837407gxk.13
        for <linux-acpi@vger.kernel.org>; Thu, 11 Sep 2008 01:14:04 -0700 (PDT)
In-Reply-To: <1221100968.3989.224.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, andi@firstfloor.org, rui.zhang@intel.com

Zhao Yakui wrote:
> On Wed, 2008-09-10 at 16:37 +0400, Alexey Starikovskiy wrote:
> thanks for the so quick response. 
>
> In the update patch it seems that spin_lock is used in the function of
> ec_read_command/acpi_ec_write_cmd.
>    IMO this is not reasonable. 
>    Maybe the spin_lock is already called before OS evaluates some ACPI
> object, in which the EC internal register will be accessed. In such case
> there will give the following warning message.
>       >2 locks held by swapper/1
>
>   
I've just consulted with Greg KH about the non-sense you tell about.
spinlock will always be acquired while already holding a mutex, and
released while still holding mutex. This is perfectly fine use of mutexes
and spinlocks. You should never use reverse order, obviously.
>>  
>> Ok. Fixed, now -ETIME is returned in this case.
>>     
> Yes. The code flow seems logic and reasonable after the -Etime is added.
> If the timeout happens when EC transaction is not finished, it is
> regarded as timeout.
>
> But we should investigate why EC transaction is not finished when
> timeout happens. Is it related with EC hardware or EC driver?
> If EC can't update the status register in time after issuing
> command/address, it is reasonable that it is regarded as timeout. If
> not, maybe it is related with the EC driver.
>
>   
We should investigate that only if we receive such timeouts.
This is clearly only needed for debug purposes, as no user
of EC driver is interested in why exactly it did not made a
transaction, only that it failed temporarily (as opposed to
-EFAIL or -ENODEV), which indicate permanent failure.
Thus, there is no reason to make flowchart (your favorite)
any more complex.
> In fact when timeout happens in the above cases, OS has no opportunity
> to issue the EC command set completely.
>     For example: Read Command: 
>       a. Maybe OS has no opportunity to issue the accessed EC register
> address.
>       b. Maybe OS has no opportunity to read the returned data from EC
> controller
> In such case it is not appropriate that it is still regarded as timeout.
>
> Maybe we should use the several phases to issue the EC transaction. And
> In every phase OS should check whether the EC status is what OS expected
> in the predefined time. If in some phase EC status is not what OS
> expected, it can be regarded as timeout.
> For example: EC Read transaction:
>       a. Issuing the read command. (Write the 0x80 to EC Cmd port)
>       b. Checking whether the input buffer is empty(IBF bit) and write
> the accessed address to EC Data port.
>       c. Checking wheter the data is already(OBF bit) and read the
> returned data from EC controller
>
> Based on the above analysis IMO the flow of EC transaction is quite
> reasonable. Of course what should be improved is how to make it
> reasonable when waiting whether EC status is what OS expected.
>
> Please check whether the attached is reasonable.
>
> Of course in the attached patch there is no detect mechanism of EC GPE
> interrupt storm.
>
>   
Regards,
Alex.
