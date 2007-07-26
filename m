From: Benson Chow <blc+acpi@q.dyndns.org>
Subject: ACPI hang on startup, inconsistent
Date: Thu, 26 Jul 2007 13:19:54 -0600 (MDT)
Message-ID: <Pine.LNX.4.64.0707261305230.25067@q.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from doujima.mine.nu ([70.57.19.177]:58545 "EHLO q.dyndns.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761772AbXGZTeI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 26 Jul 2007 15:34:08 -0400
Received: from q.dyndns.org (localhost [127.0.0.1])
	by q.dyndns.org (8.14.0/8.14.0) with ESMTP id l6QJJtew025218
	for <linux-acpi@vger.kernel.org>; Thu, 26 Jul 2007 13:20:30 -0600
Received: from localhost (blc@localhost)
	by q.dyndns.org (8.14.0/8.14.0/Submit) with ESMTP id l6QJJsI9025212
	for <linux-acpi@vger.kernel.org>; Thu, 26 Jul 2007 13:19:54 -0600
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I'm seeing a fairly strange hang on my Foxconn G9657MA with firmware 50.

Upon bootup I get a hang while working with ACPI.  With ACPI debug 
statements turned on, it hangs after (Kernel 2.6.21.5 stock):


[...]
Compat vDSO mapped to ffffe000.
Checking 'hlt' instruction... OK.
Freeing SMP alternatives: 12k freed
ACPI: Core revision 20070126
Parsing all Control Methods:
Table [DSDT](id 0001) - 694 Objects with 62 Devices 187 Methods 43 Regions
  tbxface-0587 [02] tb_load_namespace     : ACPI Tables successfully acquired
[hang occurs here]

The kicker is these few observations:
1) Booting off the Ubuntu 7.04 CD seems to always works fine.
2) Booting off the Windows XP CD seems to always works fine.
3) Booting with ACPI=OFF always works (but then my PATA port fails to work)
4) the trick: If I let it boot with ACPI=OFF past the timeouts while 
detecting the above PATA port, and then immediately control-alt-delete 
reboot the machine, it will once boot fine without ACPI=OFF, just that 
one time!


When I did get the machine to come up, I was able to grab and decompile 
the DSDT.  There were a couple of errors in it.  However should a bad DSDT 
cause a hang at this point?  I believe I've seen some sillyness such as
"Store(Local0, Local0)" and getting "use before assignment" of Local0, 
but I don't have the DSDT handy right.

Any other hints I could try to get to the bottom of this issue?  Let me 
know if there's some more data I can collect.

Thanks,

-bc

Reference:
If the machine doesn't hang, the next two lines displayed in dmesg are:

evxfevnt-0091 [02] enable                : Transition to ACPI mode successful
CPU0: Intel(R) Core(TM)2 CPU          6700  @ 2.66GHz stepping 06
