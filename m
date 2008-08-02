From: Thomas Renninger <trenn@suse.de>
Subject: Re: Do not return true to all kind of Windows OSI calls
Date: Sat, 2 Aug 2008 18:48:15 +0200
Message-ID: <200808021848.16457.trenn@suse.de>
References: <1217632817.4610.6.camel@hidalgo> <1217696279-23848-1-git-send-email-trenn@suse.de> <20080802165952.GA30580@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.suse.de ([195.135.220.2]:56876 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751006AbYHBRXi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 2 Aug 2008 13:23:38 -0400
In-Reply-To: <20080802165952.GA30580@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: corsac@debian.org, ak@linux.intel.com, rui.zhang@intel.com, nokos@gmx.net, linux-acpi@vger.kernel.org, hmh@debian.org

On Saturday 02 August 2008 06:59:52 pm Matthew Garrett wrote:
> On Sat, Aug 02, 2008 at 06:57:57PM +0200, Thomas Renninger wrote:
> > ThinkPads store OSI calls in separate variables and later
> > check for NT/XP/VISTA specific code to process.
> >
> > I lately saw a line on a ThinkPad checking for XP and VISTA
> > at video device specific code.
> >
> > So currently some ThinkPads run into code paths which should
> > either run on XP or VISTA, but Linux might execute them both
> > or in a way that is not intended by BIOS developers.
>
> Could you please show the code in question? I think you're misdiagnosing
> the issue.


If (CondRefOf (\_OSI, Local0))
                {
                    If (\_OSI ("Windows 2001"))
                    {
                        Store (0x01, \WNTF)
                        Store (0x01, \WXPF)
                        Store (0x00, \WSPV)
                    }

                    If (\_OSI ("Windows 2001 SP1"))
                    {
                        Store (0x01, \WSPV)
                    }

                    If (\_OSI ("Windows 2001 SP2"))
                    {
                        Store (0x02, \WSPV)
                    }

                    If (\_OSI ("Windows 2006"))
                    {
                        Store (0x01, \WVIS)
                    }
                }

...
# Only process this on XP, not on Linux and Vista
                           If (LAnd (\WXPF, LNot (\WVIS)))
                            {
                                Notify (\_SB.PCI0, Arg1)
                            }
                            Else
                            {
                                Notify (\_SB.PCI0.VID, Arg1)
                            }
                        }
...

# Only process this on XP, not on Linux and Vista
                        If (LAnd (LNot (\WXPF), \WNTF))
                        {
                            Store (0x00, \_SB.PCI0.LPC.C4C3)
                        }
...
                Device (HPET)
                {
                    Name (_HID, EisaId ("PNP0103"))
                    Method (_STA, 0, NotSerialized)
                    {
  ...
# Only disable HPET on NT, not on Linux
                          If (LAnd (\WNTF, LNot (\WXPF)))
                            {
                                Return (0x00)
                            }


Amazing, it looks like they already check for Linux by checking if
OSI returned true on two major Windows versions which would indicate
Linux running.

So yes, everything looks fine and it seems this was not luck, but
they already realized Linux does not return true for OSI(Linux)
anymore.

Why must we force vendors to implement such a madness, the OSI
implementation is so wrong.

So this seems to get the state-of-the-art then..., check whether several
Windows versions return true and you do not need to process broken code
which is only intended to run on a very specific broken Windows version.

     Thomas
