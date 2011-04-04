From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Necessity of SMM/SMI use on ACPI x86 systems
Date: Mon, 4 Apr 2011 14:53:39 +0100
Message-ID: <20110404135338.GA17898@srcf.ucam.org>
References: <SNT111-DS81E1BD67986CA3A41C144A7A00@phx.gbl>
 <20110403153436.GA30667@srcf.ucam.org>
 <SNT111-DS15AC3C0257159ED491332BA7A30@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:42980 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798Ab1DDNxo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Apr 2011 09:53:44 -0400
Content-Disposition: inline
In-Reply-To: <SNT111-DS15AC3C0257159ED491332BA7A30@phx.gbl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: limp <johnkyr83@hotmail.com>
Cc: linux-acpi@vger.kernel.org

On Mon, Apr 04, 2011 at 02:41:45PM +0100, limp wrote:
> Thanks for the reply Matthew,
> 
> > It's a turing-complete language with full access to the hardware, so 
> > there's no reason why you can't entirely eliminate SMIs. The usual 
> > reason not to would be to retain commonality of code for non-ACPI 
> > environments like the setup screen.
> 
> So, there is no case that SMIs can be irreplaceable? For example, when you
> go to S5 I know from coreboot developers that you need to disable bus
> mastering on all devices or the machine will not power off. Since the OS
> does not know this, and neither does acpi, the S5 sleep command will cause
> an SMI that disables BM and then goes to S5.

I don't think there's any reason you couldn't do that in the _GTS 
method.

> Furthermore, is ACPI AML BIOS code interruptible or not? 
> That is, what happens if an interrupt occurs during ACPI code execution? 
> Will it be pended and get served after the completion of ACPI code
> execution? 

Depends on whether we're interruptible or not at that point. Interrupts 
will be disabled at certain points.

> Furthermore, can a SMI interrupt ACPI code or not? 

It can.

> One last question is regarding the location in memory of ACPI tables. Are
> they written to standard RAM or to a specially protected RAM similar to
> SMRAM? How ACPI tables can prevent the OS from corrupting them?

RAM, but in an e820 region that indicates to the OS that it's not 
available for normal use. There's no protection from the OS.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
