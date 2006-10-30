From: Michael Blakeley <mike@blakeley.com>
Subject: why use acpi for cpufreq?
Date: Mon, 30 Oct 2006 15:03:53 -0800
Message-ID: <454684D9.1080805@blakeley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailbigip.dreamhost.com ([208.97.132.5]:42394 "EHLO
	spunkymail-a1.dreamhost.com") by vger.kernel.org with ESMTP
	id S1161032AbWJ3XDz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 30 Oct 2006 18:03:55 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I've recently been bitten by 
http://bugzilla.kernel.org/show_bug.cgi?id=7157 - I also have an HP 
nc6400, with bios F.05, and can't downgrade to F.03 because my CPU only 
became supported in F.05. While I'm waiting to see if HP will fix this 
problem in a future bios rev, I wondered why cpufreq needs any bios 
information in the first place?

This is all well outside my technical expertise, so I'm sure that I'm 
misunderstanding the problem - but that's why I'm asking. Basically my 
question is: why can't cpufreq interrogate the CPU directly, in order to 
find out what sort of cpu frequency scaling it supports (SpeedStep in 
various flavors, PowerNow, and whatever else is out there in the wild)? 
Wouldn't that be more robust than relying on the bios to get it right?

As a side issue, how does Windows XP solve this problem? From what I can 
tell, Windows XP does use frequency-scaling with my CPU (according to 
the NHC software from http://www.pbus-167.com/).

Again, I'm sure that I'm misunderstanding the technical issues here, but 
I'd like to understand them. I'm also happy to post a summary on the 
acpi wiki, so that the question is less likely to come up again.

thanks,
-- Mike
