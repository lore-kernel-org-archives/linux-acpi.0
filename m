From: "Phil Endecott" <phil_hmpau_endecott@chezphil.org>
Subject: Re: Battery level alarm on Eee 901
Date: Thu, 18 Sep 2008 11:01:40 +0100
Message-ID: <1221732100885@dmwebmail.dmwebmail.chezphil.org>
References: <1221705183.3999.93.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; format="flowed"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from japan.chezphil.org ([77.240.5.4]:2816 "EHLO japan.chezphil.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753518AbYIRKBo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 18 Sep 2008 06:01:44 -0400
Received: from localhost ([127.0.0.1] helo=chezphil.org)
	by japan.chezphil.org with esmtp (Exim 4.69)
	(envelope-from <phil_hmpau_endecott@chezphil.org>)
	id 1KgGKU-00078R-AT
	for linux-acpi@vger.kernel.org; Thu, 18 Sep 2008 11:01:42 +0100
In-Reply-To: <1221705183.3999.93.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>

Zhao Yakui wrote:
> On Wed, 2008-09-17 at 22:43 +0100, Phil Endecott wrote:
>> Hello, it's me again...
>> 
>> I'm trying to get a low battery alarm to work on my Eee.  In 
>> /sys/class/power_supply/BAT0 I have a good selection of readable 
>> attributes like charge_now, current_now etc.  There is also a writeable 
>> "alarm" file.  But as far as I can see, the alarm is not implemented.
>> 
>> I have a couple of questions about this:
>> 
>> - Looking at the ACPI battery driver code, it knows that there is no 
>> support for an alarm when it tests the result of evaluating the _BTP 
>> method, which my BIOS doesn't seem to offer.  However, it doesn't 
>> subsequently return an error to the write, so my attempt to set an 
>> alarm succeeds.  Is this the desired behaviour?  Wouldn't it be better 
>> to either not create the alarm file, or to cause writes to fail, when 
>> it's known that there is no support?
> According to the ACPI spec the _BTP object should exist if the battery
> alarm is supported. If there is no _BTP object, maybe the alarm can't be
> supported. 
> Your suggestion is right. If alarm is not supported, OS had better not
> create the alarm file.

Right.  I could probably produce a patch to fix this, if people agree 
that it's the right thing to do.

>> - Presumably I could write a trivial daemon to poll the battery level.  
>> A quick search find bazillions of gui applets that do this.  I would 
>> prefer to generate a synthetic ACPI battery alarm event when I detect a 
>> low charge level, so that the action taken in response can be 
>> implemented independent of the method of detection.  Has this already 
>> been done?  Is there an easy way to inject a synthetic ACPI event from 
>> user-space?  What does a valid battery alarm event look like?
> You can use the daemon to poll the battery level and decide what action
> to take when the battery level is lower than the predefined level. 
> Why is the ACPI alarm event still expected to be triggered in such case?

Well, we have N alarm sources (i.e. ACPI and a polling daemon) and M 
alarm users (i.e. scripts that beep, GUI things etc) and it would be 
better to have 1 method for any alarm source to communicate with any 
alarm user rather then N*M combinations of communication to get right.  
I thought that the ACPI events would be that "1 method".  Do you have a 
better suggestion?

> And it is not easy to insert the synthetic the ACPI event from
> user-space.

OK.  Isn't there some sort of "ACPI test event" utility?  Maybe I'm 
thinking of something else.  udev maybe.


Thanks,  Phil.



