From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: [Suspend-devel] 2.6.25-rc2 System no longer powers off after
 suspend-to-disk. Screen becomes green.
Date: Thu, 21 Feb 2008 00:26:12 +0300
Message-ID: <47BC9AF4.10807@gmail.com>
References: <Pine.LNX.4.64.0802210101050.3576@boston.corp.fedex.com> <200802202114.43007.rjw@sisk.pl> <alpine.LFD.1.00.0802201224380.7833@woody.linux-foundation.org> <200802202145.01882.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:49226 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753640AbYBTV0T (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Feb 2008 16:26:19 -0500
Received: by ug-out-1314.google.com with SMTP id z38so852886ugc.16
        for <linux-acpi@vger.kernel.org>; Wed, 20 Feb 2008 13:26:17 -0800 (PST)
In-Reply-To: <200802202145.01882.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, suspend-devel@lists.sourceforge.net, Jeff Chua <jeff.chua.linux@gmail.com>, Dave Airlie <airlied@linux.ie>, Greg KH <gregkh@suse.de>, lkml <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Jesse Barnes <jesse.barnes@intel.com>

Rafael J. Wysocki wrote:
> On Wednesday, 20 of February 2008, Linus Torvalds wrote:
>   
>> On Wed, 20 Feb 2008, Rafael J. Wysocki wrote:
>>     
>>> I think we should export the target sleep state somehow.
>>>       
>> Yeah. By *not* using "->suspend()" for freezing or hibernate.
>>
>> Please, Rafael - just make the f*cking suspend-to-disk use other routines 
>> already.
>>     
>
> Okay, I think I'll just start sending patches for that, but rather not earlier
> than in the 2.6.27 time frame.  No one else works on that and I've been busy
> with other things recently.  Besides, I'm not even a full time kernel
> developer ...
>
>   
Rafael,
If I can help, please  say so.

Regards,
Alex.
>> 99% of all hardware needs to do exactly *nothing* on suspend-to-disk, and the
>> ones that really do need things tend to need to not do a whole lot.
>>
>> For example, the "freeze" action for USB (which is one of the hardest 
>> things to suspend) should literally be something like just setting the 
>> controller STOP bit, and waiting for it to have stopped. The "unfreeze" 
>> should be to just clear the stop bit, while the "restart" should be just a 
>> controller reset to use the current memory image.
>>
>> NONE OF THIS HAS ABSOLUTELY ANYTHING TO DO WITH SUSPEND.
>>
>> It never did. I've told people so for years. Maybe actually seeing the 
>> problems will make people realize.
>>     
>
> I think so.
>
>   
>> So please, we shouldn't call "->suspend[_late]" or "->resume[_early]" at 
>> all. Not with PMSG_FREEZE, not with PMSG_*anything*.
>>
>> Can we please get this fixed some day? 
>>     
>
> Yes, we can (hopefully).
>
> Thanks,
> Rafael
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>   

