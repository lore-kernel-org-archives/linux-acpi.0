From: Chris Ball <cjb@mrao.cam.ac.uk>
Subject: Alienware m5500 wifi kill switch?
Date: Wed, 19 Apr 2006 18:46:44 -0400
Message-ID: <87fyk9i3or.fsf@mrao.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:22944 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751306AbWDSWuG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 19 Apr 2006 18:50:06 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1FWLUo-0005NO-LN
	for linux-acpi@vger.kernel.org; Thu, 20 Apr 2006 00:50:02 +0200
Received: from pool-151-203-216-9.bos.east.verizon.net ([151.203.216.9])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Thu, 20 Apr 2006 00:50:02 +0200
Received: from cjb by pool-151-203-216-9.bos.east.verizon.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Thu, 20 Apr 2006 00:50:02 +0200
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

I have a new Alienware m5500/Uniwill 259EN3 laptop with an ipw2200.
ACPI works fine in general, including S3, but I can't get the wifi kill
switch to turn off.  It uses a button next to the power button rather
than a keyboard function key, but pressing that button makes the 
"sleep" LED on the front panel come on, rather than the "wifi" LED!

I don't have a Windows install on the laptop; I'd like to see what
happens in Windows, but the XP recovery CD I was given seems to hang
during hardware detection.

Does anyone have any ideas?  The mismatch between the button and which
LED comes on makes me think ACPI might be involved, but on the other
hand the button could be in pure hardware; I can't get a scancode out of
it.  I'm happy to provide anything that could help to debug, of course.
I see there are many drivers that provide software kill-switch support,
but none of them seem to work on this AMIBIOS laptop.

Many thanks,

- Chris.
-- 
Chris Ball   <cjb@mrao.cam.ac.uk>    <http://blog.printf.net/> 

