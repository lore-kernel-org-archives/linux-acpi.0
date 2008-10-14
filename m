From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: Patch needed for ASUS EEEPC 701 2.6.27 (perhaps a regession)
Date: Tue, 14 Oct 2008 10:12:41 +0100
Message-ID: <48F46289.5050508@tuffmail.co.uk>
References: <48F0BD2D.8000001@tuffmail.co.uk> <20081013203648.GA3260@ucw.cz> <48F45D52.2010407@tuffmail.co.uk> <48F46053.6070306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.27]:31662 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753372AbYJNJMq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 14 Oct 2008 05:12:46 -0400
Received: by ey-out-2122.google.com with SMTP id 6so740262eyi.37
        for <linux-acpi@vger.kernel.org>; Tue, 14 Oct 2008 02:12:44 -0700 (PDT)
In-Reply-To: <48F46053.6070306@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: Alan Jenkins <aj504@student.cs.york.ac.uk>, Pavel Machek <pavel@suse.cz>, Robert Goldner <robert@au-79.de>, linux-kernel <linux-kernel@vger.kernel.org>, linux acpi <linux-acpi@vger.kernel.org>, linux-stable@vger.kernel.org

Alexey Starikovskiy wrote:
> Alan Jenkins wrote:
>> It could be a coincidence. But it's suspicious enough to advise
>> caution. We know what the bug is, and we have a very nice workaround
>> queued up now. There's no reason to test any more of these specific
>> systems to destruction :).
>> I did try re-installing off the vendor DVD and it was still broken. 
>> I fear I bought it from the wrong place to get sympathetic
>> _frontline_ support / warrantee.  I'm not interested in RMA back to
>> Asus - too much work and downtime for a cheap system, when I have an
>> easy workaround.  I haven't noticed any problems with "noapic".
>>
>>
>> The symptoms strongly suggest overflow in an event buffer or counter
>> maintained by the Embedded Controller.  So the EC firmware may have a
>> bug, of the sort that results in "unspecified behaviour".  A bug in a
>> special purpose (read: not subject to wide testing) subsystem which
>> has direct connections to things like frequency and voltage control.
>>
>> Hopefully I'm wrong, and I don't really know what I'm talking about
>> here.
>>
>> Regards
>> Alan
>>   
> Did you try to disconnect all power resources (e.g. AC adapter and all
> batteries and wait for some time)?

Yes, I tried leaving it with AC + battery unplugged overnight.

> May be there are some default settings in the BIOS?
> This looks small enough to be a HW failure...

I also upgraded the BIOS to the latest version.  And tried the BIOS
setup option to restore defaults.  Maybe there is some more state, but
it's not like a desktop where I can easily remove the CMOS battery.

Thanks
Alan
