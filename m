From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: Battery level alarm on Eee 901
Date: Thu, 18 Sep 2008 10:33:03 +0800
Message-ID: <1221705183.3999.93.camel@yakui_zhao.sh.intel.com>
References: <1221687807792@dmwebmail.dmwebmail.chezphil.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:54840 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752860AbYIRC2S (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 17 Sep 2008 22:28:18 -0400
In-Reply-To: <1221687807792@dmwebmail.dmwebmail.chezphil.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Phil Endecott <phil_hmpau_endecott@chezphil.org>
Cc: linux acpi <linux-acpi@vger.kernel.org>

On Wed, 2008-09-17 at 22:43 +0100, Phil Endecott wrote:
> Hello, it's me again...
> 
> I'm trying to get a low battery alarm to work on my Eee.  In 
> /sys/class/power_supply/BAT0 I have a good selection of readable 
> attributes like charge_now, current_now etc.  There is also a writeable 
> "alarm" file.  But as far as I can see, the alarm is not implemented.
> 
> I have a couple of questions about this:
> 
> - Looking at the ACPI battery driver code, it knows that there is no 
> support for an alarm when it tests the result of evaluating the _BTP 
> method, which my BIOS doesn't seem to offer.  However, it doesn't 
> subsequently return an error to the write, so my attempt to set an 
> alarm succeeds.  Is this the desired behaviour?  Wouldn't it be better 
> to either not create the alarm file, or to cause writes to fail, when 
> it's known that there is no support?
According to the ACPI spec the _BTP object should exist if the battery
alarm is supported. If there is no _BTP object, maybe the alarm can't be
supported. 
Your suggestion is right. If alarm is not supported, OS had better not
create the alarm file. 
> 
> - Presumably I could write a trivial daemon to poll the battery level.  
> A quick search find bazillions of gui applets that do this.  I would 
> prefer to generate a synthetic ACPI battery alarm event when I detect a 
> low charge level, so that the action taken in response can be 
> implemented independent of the method of detection.  Has this already 
> been done?  Is there an easy way to inject a synthetic ACPI event from 
> user-space?  What does a valid battery alarm event look like?
You can use the daemon to poll the battery level and decide what action
to take when the battery level is lower than the predefined level. 
Why is the ACPI alarm event still expected to be triggered in such case?
In fact when the ACPI event is triggered, the user-space decides what
action to take. 
And it is not easy to insert the synthetic the ACPI event from
user-space.

> 
> Many thanks for any suggestions.
> 
> 
> Phil.
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

