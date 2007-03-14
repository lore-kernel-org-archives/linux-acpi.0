From: Bret Hughes <bhughes@elevating.com>
Subject: serial port discovery on a motion computing tablet
Date: Tue, 13 Mar 2007 22:14:19 -0500
Message-ID: <45F7688B.8000101@elevating.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from h186.102.16.72.ip.alltel.net ([72.16.102.186]:30419 "EHLO
	mail1.imperiumsolutions.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752700AbXCNDn0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 13 Mar 2007 23:43:26 -0400
Received: from localhost (unknown [127.0.0.1])
	by mail1.imperiumsolutions.net (Postfix) with ESMTP id 01BDCBF9057
	for <linux-acpi@vger.kernel.org>; Wed, 14 Mar 2007 03:14:29 +0000 (UTC)
Received: from mail1.imperiumsolutions.net ([127.0.0.1])
	by localhost (xypris.imperiumsolutions.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e-1WnLlyEbnP for <linux-acpi@vger.kernel.org>;
	Tue, 13 Mar 2007 22:14:27 -0500 (CDT)
Received: from [10.23.0.144] (wsip-68-99-77-157.tu.ok.cox.net [68.99.77.157])
	by mail1.imperiumsolutions.net (Postfix) with ESMTP id C2EB5BF8FBE
	for <linux-acpi@vger.kernel.org>; Tue, 13 Mar 2007 22:14:26 -0500 (CDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I am evaluating a motion computing LE1600 tablet for possible use with 
linux using Centos 4.4 since that is what we use for several servers and 
had the installation media handy.  This device uses a TouchKO serial 
touchscreen that has been used by linux in the past but the issue I am 
facing is that the bios does not expose the serial ports.  I spoke with 
an engineer at TouchKO familiar with the LE1600 project an he told me I 
would have to access the serial port via acpi.  Hmm says I, I guess I 
have some reading to do.  DO after a day or so of trying to get up to 
speed, I feel I can ask a fairly decent question or two. 

I found a lot of wacom references but as this touchscreen has ELO and 
Microtouch emulations I am hard pressed to figure out where to separate 
the detection of the port from the driver of the device.

What I need to do is get a connection to the serial port send a couple 
of commands to it to set the baud rate and emulation mode and then start 
X where the MuTouch Driver should work.

So.  Is this where I need to be asking acpi serial port questions?  I 
found a tc1100 prog somewhere but could not get it to compile 
correctly,  pacpidump compiled ok and I have the output of of acpidump 
if that helps.

Is this a doable deal?  I dled the current (2.6.9-42xxx I think) kernel 
tree from Centos as the last thing I did before leaving work today and 
will look at both how Centos (and the upstream provider) configure the 
kernel and if there are options that look like it might work. 

Googling today turned up several references to a 8250_acpi module and 
then I found a patch somewhere that indicated that it was no longer 
needed.  I wish I had looked at the kernel tree before leaving today but 
I thought i would ask for some tips to get me going and possibly add 
some known good hardware to the list before I am done.

Am I correct in thinking that I should be able to get a reference to the 
serial port through acpi on this box?  Any tips ?  Any testing that you 
guys would like done while I have this hardware?

TIA

Bret
