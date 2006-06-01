From: David <daz@undertaker.homeip.net>
Subject: resume not working
Date: Wed, 31 May 2006 20:11:13 -0700 (MST)
Message-ID: <Pine.LNX.4.63.0605312004510.23329@undertaker.underworld.net>
Reply-To: david@damnetwork.net
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from damnetwork.net ([208.186.80.209]:53455 "EHLO
	undertaker.homeip.net") by vger.kernel.org with ESMTP
	id S1751500AbWFADT2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 31 May 2006 23:19:28 -0400
Received: from undertaker.underworld.net (nobody@localhost [127.0.0.1])
	by undertaker.homeip.net (8.13.4/8.12.9) with ESMTP id k513BDLD023404
	for <linux-acpi@vger.kernel.org>; Wed, 31 May 2006 20:11:13 -0700
Received: from localhost (daz@localhost)
	by undertaker.underworld.net (8.13.4/8.12.11/Submit) with ESMTP id k513BDBD023401
	for <linux-acpi@vger.kernel.org>; Wed, 31 May 2006 20:11:13 -0700
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I have a fairly generic laptop I inherited from a relative.  The suspend 
feature works great (from closing the list or via any other method).  The 
only problem is waking it back up.  It doesn't.  The power button is 
supposed to resume it, and it does in Windows.

In my acpi log, the only messages regarding the power button are:

received event "button/power PWRF 00000080 00000002"

I see nothing that has PWBN (which I would assume would resume?).

I'm wondering if this might have something to do with it, but I'm not 
sure:

Handle 0x001C, DMI type 32, 20 bytes.
System Boot Information
         Status: <OUT OF SPEC>

Handle 0x001D, DMI type 127, 4 bytes.
End Of Table

Wrong DMI structures count: 30 announced, only 29 decoded.


Where can I start working on this?

Thanks,
David

-- 
"I find your lack of faith disturbing."
--Darth Vader
---
  20:04:01 up 46 days,  2:46,  1 user,  load average: 0.00, 0.00, 0.00
