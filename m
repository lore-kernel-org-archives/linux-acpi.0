From: "Phil Endecott" <phil_hmpau_endecott@chezphil.org>
Subject: Battery level alarm on Eee 901
Date: Wed, 17 Sep 2008 22:43:27 +0100
Message-ID: <1221687807792@dmwebmail.dmwebmail.chezphil.org>
Mime-Version: 1.0
Content-Type: text/plain; format="flowed"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from japan.chezphil.org ([77.240.5.4]:5041 "EHLO japan.chezphil.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755949AbYIQVna (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 17 Sep 2008 17:43:30 -0400
Received: from localhost ([127.0.0.1] helo=chezphil.org)
	by japan.chezphil.org with esmtp (Exim 4.69)
	(envelope-from <phil_hmpau_endecott@chezphil.org>)
	id 1Kg4o4-0000QH-SC
	for linux-acpi@vger.kernel.org; Wed, 17 Sep 2008 22:43:28 +0100
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux acpi <linux-acpi@vger.kernel.org>

Hello, it's me again...

I'm trying to get a low battery alarm to work on my Eee.  In 
/sys/class/power_supply/BAT0 I have a good selection of readable 
attributes like charge_now, current_now etc.  There is also a writeable 
"alarm" file.  But as far as I can see, the alarm is not implemented.

I have a couple of questions about this:

- Looking at the ACPI battery driver code, it knows that there is no 
support for an alarm when it tests the result of evaluating the _BTP 
method, which my BIOS doesn't seem to offer.  However, it doesn't 
subsequently return an error to the write, so my attempt to set an 
alarm succeeds.  Is this the desired behaviour?  Wouldn't it be better 
to either not create the alarm file, or to cause writes to fail, when 
it's known that there is no support?

- Presumably I could write a trivial daemon to poll the battery level.  
A quick search find bazillions of gui applets that do this.  I would 
prefer to generate a synthetic ACPI battery alarm event when I detect a 
low charge level, so that the action taken in response can be 
implemented independent of the method of detection.  Has this already 
been done?  Is there an easy way to inject a synthetic ACPI event from 
user-space?  What does a valid battery alarm event look like?

Many thanks for any suggestions.


Phil.



