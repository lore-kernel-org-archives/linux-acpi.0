From: Len Brown <lenb@kernel.org>
Subject: Re: Power button not working on T61
Date: Fri, 10 Oct 2008 11:45:45 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0810101140310.3131@localhost.localdomain>
References: <200810101319.52021.hanno@hboeck.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_i3aGQTKYmicj9/9Iy5M6Xg)"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:44855 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757583AbYJJPpx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Oct 2008 11:45:53 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K8J00AOK54CA0K3@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 10 Oct 2008 10:45:49 -0500 (CDT)
In-reply-to: <200810101319.52021.hanno@hboeck.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?ISO-8859-15?Q?Hanno_B=F6ck?= <hanno@hboeck.de>
Cc: acpi@linux.intel.com, linux-acpi@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_i3aGQTKYmicj9/9Iy5M6Xg)
Content-type: TEXT/PLAIN; charset=utf-8
Content-transfer-encoding: 8BIT



On Fri, 10 Oct 2008, Hanno Böck wrote:

> I have a T61 8859WFJ. thinkpad_acpi module is loaded (kernel is 2.6.27, same 
> was with 2.6.26).

what is the most recent kernel that worked properly?

> When I press the power button, nothing happens and no acpi event is generated. 
> 
> I already posted this on the ibm-acpi-devel list and they told me it's 
> probably a problem in acpi core.
> 
> My dmesg, if that helps:
> http://rafb.net/p/EYOHpq12.html

I have a T61 7660-CTO running 2.6.27 and power, lid, sleep seem to be
working normally.

Try killing acpid an
# cat /proc/acpi/event
then press the power button, close/open the lid, and the sleep button
(Fn-F4 on mine) and see if anything appears.
the standard acpi button driver should handle power and lid.
in this case the thinkpad driver handles the sleep hotkey.

see if things work differently when thinkpad_acpi is not
included in your kernel.

one difference I see is how your devices are registered
with the input layer:

input: Power Button (FF) as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
ACPI: Power Button (FF) [PWRF]
input: Lid Switch as 
/devices/LNXSYSTM:00/device:00/PNP0C0D:00/input/input1
ACPI: Lid Switch [LID]
input: Sleep Button (CM) as 
/devices/LNXSYSTM:00/device:00/PNP0C0E:00/input/input2
ACPI: Sleep Button (CM) [SLPB]


Where I see this:

input: Power Button (FF) as /class/input/input0
ACPI: Power Button (FF) [PWRF]
PM: Adding info for No Bus:input1
input: Lid Switch as /class/input/input1
ACPI: Lid Switch [LID]
PM: Adding info for No Bus:input2
input: Sleep Button (CM) as /class/input/input2
ACPI: Sleep Button (CM) [SLPB]

if you send me your .config, I'll try it out.

cheers,
-Len

--Boundary_(ID_i3aGQTKYmicj9/9Iy5M6Xg)--
