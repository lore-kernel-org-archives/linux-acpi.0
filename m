From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: suspend kills serial wacom tablet
Date: Fri, 13 Apr 2007 12:49:23 -0600
Message-ID: <200704131249.23640.bjorn.helgaas@hp.com>
References: <pan.2007.02.20.13.52.07.111117@metm.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel8.hp.com ([156.153.255.206]:35648 "EHLO atlrel8.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754140AbXDMStd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 13 Apr 2007 14:49:33 -0400
In-Reply-To: <pan.2007.02.20.13.52.07.111117@metm.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: marco <marco@metm.org>
Cc: linux-acpi@vger.kernel.org

On Tuesday 20 February 2007 06:52, marco wrote:
> I have a thinkpad X41-tablet which uses the linuxwacom serial drivers. 
> The tablet works perfectly when the laptop first boots, but does not work
> at all after resuming from sleep.  I posted to the linuxwacom list but
> think that the problem might be more general in how acpi resumes the
> serial ports.
> 
> As suggested here:
> http://www.thinkwiki.org/wiki/Installing_Ubuntu_6.10_on_a_ThinkPad_X41_Tablet
> I have added a script to resume.d which calls the setserial command:
>   /bin/setserial /dev/ttyS0 port 0x0200 irq 5 autoconfig

Using setserial to change port or IRQ usage is a good clue that the
kernel is doing something wrong.  Usually it's "we KNOW that ttyS0
lives at 0x3f8 and IRQ 4, so we'll ignore what ACPI is telling us."
But it sounds like this is a tangent and not related to your current
problem.

Can you post the dmesg log from a boot where the tablet works
correctly?  That will tell us exactly what kernel you're running
and how the kernel detected the serial port.  There've been some
serial port resume changes in the not-too-distant past, and I
don't know whether they're in the Ubuntu kernel yet.

Bjorn
