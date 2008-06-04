From: Leonid Podolny <leonidp@gmail.com>
Subject: MSI PR200
Date: Wed, 04 Jun 2008 23:18:45 +0300
Message-ID: <4846F8A5.20604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:56103 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751283AbYFDUSw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Jun 2008 16:18:52 -0400
Received: by ug-out-1314.google.com with SMTP id h2so373849ugf.16
        for <linux-acpi@vger.kernel.org>; Wed, 04 Jun 2008 13:18:49 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

After a while, my laptop stops recognizing both its battery and 
ac_adapter. With both the battery fully charged and AC plugged in:

looptop ~ # cat /proc/acpi/battery/BAT1/*
present:                 no
present:                 no
present:                 no
looptop ~ # cat /proc/acpi/ac_adapter/ADP1/*
state:                   off-line

I also stop seeing ACPI events in dmesg.
After a reboot, these files have sane values for a while, but then, in a 
matter of minutes, something happens and it reverts to the wrong 
situation as described above. dmesg displays some errors during boot-up, 
but I don't think it's relevant because the system runs fine for some 
time after. I have opened a bug in kernel bugzilla and attached every 
info I could think of.
http://bugzilla.kernel.org/show_bug.cgi?id=10855
I have this laptop since about 2.6.22 and it was like that since then, 
so it's not a regression.
All the similar issues I see in Internet mention MSI laptops.
I will increase the debug level now and see if something interesting 
pops up. If it does, I'll report back.

