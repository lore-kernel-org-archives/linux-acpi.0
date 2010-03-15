From: Thomas Renninger <trenn@suse.de>
Subject: Re: [Devel] Reserved method has too many arguments (_OSC requires 4)
Date: Mon, 15 Mar 2010 10:30:38 +0100
Message-ID: <201003151030.38752.trenn@suse.de>
References: <201003121500.53220.trenn@suse.de> <4911F71203A09E4D9981D27F9D83085859F8A2C7@orsmsx503.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:39109 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756491Ab0COJal (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 15 Mar 2010 05:30:41 -0400
In-Reply-To: <4911F71203A09E4D9981D27F9D83085859F8A2C7@orsmsx503.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>

On Friday 12 March 2010 16:58:41 Moore, Robert wrote:
> 
> >My other concern/question is: what exactly happens in such a case?
> >Will _OSC get invoked at all?
> >If yes, what will be the last argument, zero, -1?
> 
> The method will be invoked with the 4 arguments, the correct number.
> What will happen then is one of three things:
> 
> 1) The method attempts to access the phantom fifth argument and it
> will then be aborted with an AE_AML_UNINITIALIZED_ARG exception.
> 
> 2) The method has some other confusion about the first four arguments
> (given that it is already confused about the number of arguments in
> the first place), and does something unpredictable.
> 
> 3) The method does not attempt to access the fifth argument, understands
> the first four arguments correctly and runs to completion correctly.

I expect I have the first with acpiexec I get:
execute \_SB_.PCI0._OSC 1 1 1 1
Executing \_SB_.PCI0._OSC
ACPI Error: Uninitialized Arg[4] at node 0x6c9648 (20100304/dsmthdat-544)
ACPI Exception: AE_AML_UNINITIALIZED_ARG, While resolving operands for [Store] (20100304/dswexec-554)
[AcpiExec] Exception AE_AML_UNINITIALIZED_ARG during execution of method [_OSC] Opcode [Store] @12

**** Exception AE_AML_UNINITIALIZED_ARG during execution of method [\_SB_.PCI0._OSC] (Node 0x67b7c0)

Thanks!

> >This is not the first time I see this message.
> >It would be great to get (from include/linux/kernel.h):
> 
> I've seen this suggestion before, I'll add it as something to look at
> -- since it goes far beyond one or two error messages.
Great, would be the possibilty/interface, first for now.
This would help with most important/upcoming messages and newly written code.
No need to go through all files and adjust every potential message.

> In the meantime, the existing error message could use some improvement
> to clarify it, any suggestions?
Hm, not sure if this is necessary or possible.
More important would be to find out what the fifth argument is for and how
to solve this if Linux has to be able to differ _OSC 4 vs 5 arguments?
As this is the 2nd OEM (maybe only one BIOS devel company?) making use of this...
It's always the PCI root bridge _OSC method with 5 arguments, there are
other _OSC methods (e.g. processor capabilities) which still have 4 args.
This should be the first kind of such differentiation and probably is really
ugly to implement?

With the one vendor we are a bit in touch, I try to find out more.

Thanks,

     Thomas
 
> >-----Original Message-----
> >From: devel-bounces@acpica.org [mailto:devel-bounces@acpica.org] On Behalf
> >Of Thomas Renninger
> >Sent: Friday, March 12, 2010 6:01 AM
> >To: linux-acpi@vger.kernel.org
> >Cc: devel@acpica.org
> >Subject: [Devel] Reserved method has too many arguments (_OSC requires 4)
> >
> >Hi,
> >
> >I have a laptop freezing early, acpi=off and noapic helps.
> >I wonder whether this could have to do with the broken _OSC method.
> >
> >I cannot access the machine myself, eventually I can get more info
> >if needed, but the machine is freezing really early (after ACPI
> >initialization, somewhere around bringing up CPUs (possibly when
> >starting PCI init already?).
> >
> >This is not the first time I see this message.
> >It would be great to get (from include/linux/kernel.h):
> >#define FW_BUG          "[Firmware Bug]: "
> >#define FW_WARN         "[Firmware Warn]: "
> >#define FW_INFO         "[Firmware Info]: "
> >marked messages into ACPICA and blame the guys who are responsible
> >for that.
> >
> >My other concern/question is: what exactly happens in such a case?
> >Will _OSC get invoked at all?
> >If yes, what will be the last argument, zero, -1?
> >
> >Hmm, I doubt it has to do with the freeze, but it would still be
> >great if someone knowing these parts could comment what people
> >with such a BIOS could expect to happen.
> >
> >Thanks,
> >
> >  Thomas
> >
> >Method (_OSC, 5, NotSerialized)
> >{
> >   Store (Arg3, Local0)
> >   Multiply (Local0, 0x04, Local1)
> >   Name (BUF1, Buffer (Local1) {})
> >   Store (Arg4, BUF1)
> >   Store (Zero, Local1)
> >   Store (Zero, Local2)
> >   While (Local0)
> >   {
> >       Multiply (Local1, 0x04, Local2)
> >       CreateDWordField (BUF1, Local2, CAPB)
> >       If (Arg2)
> >       {
> >           If (LEqual (Local1, Zero))
> >           {
> >               And (CAPB, 0xFFFFFFFC)
> >           }
> >       }
> >       Increment (Local1)
> >       Decrement (Local0)
> >   }
> >   Return (BUF1)
> >}
> >_______________________________________________
> >Devel mailing list
> >Devel@acpica.org
> >http://lists.acpica.org/listinfo/devel
> 

