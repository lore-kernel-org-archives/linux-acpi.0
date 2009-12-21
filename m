From: Pavel Troller <patrol@sinus.cz>
Subject: Re: ACPI error during boot - does it need fixing ?
Date: Mon, 21 Dec 2009 09:47:49 +0100
Message-ID: <20091221084749.GA14145@tangens.sinus.cz>
References: <20091220070223.GA8334@tangens.sinus.cz> <1261357849.27291.276.camel@rzhang1-desktop> <20091221041119.GA27565@tangens.sinus.cz> <1261373160.12263.0.camel@rzhang1-desktop> <20091221060430.GA2839@tangens.sinus.cz> <1261381508.12263.11.camel@rzhang1-desktop> <20091221074746.GA9895@tangens.sinus.cz> <1261383857.12263.24.camel@rzhang1-desktop>
Reply-To: Pavel Troller <patrol@sinus.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tangens.sinus.cz ([89.250.251.168]:32915 "EHLO tangens.sinus.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753321AbZLUIry (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 Dec 2009 03:47:54 -0500
Content-Disposition: inline
In-Reply-To: <1261383857.12263.24.camel@rzhang1-desktop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Pavel Troller <patrol@sinus.cz>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

> > 
> > Hi!
> >   OK, here are the tables (I hope I've found the addresses right :-) ).
> 
> yes.
> I have found the root caused of this issue.
> 
> BIOS provides duplicate ACPI method _CST, which is used for processor
> c-state control, for each processor. And the error message is printed
> out when ACPI tries to install the second _CST method.
> 
> This is a BIOS problem to me.
> 
> But anyway, it's harmless, the two _CST methods are the same, and the
> second _CST will be ignored automatically.
> 
> If you still don't like this warning message, you need to upgrade your
> BIOS to see if they have already been fixed. :)
> 
> thanks,
> rui
> 
Hi Rui,
  thanks for your expertise.
  There is not a BIOS update yet for this motherboard, this was the first thing
I was checking before I started this thread. So, if it is harmless, I will let
it be.
  With regards,
    Pavel.
