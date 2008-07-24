From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] ACPI: Provide a spec conform OSI interface to the BIOS
Date: Thu, 24 Jul 2008 17:27:17 +0200
Message-ID: <200807241727.18392.trenn@suse.de>
References: <1216316268-24042-1-git-send-email-trenn@suse.de> <200807181922.11728.trenn@suse.de> <alpine.LFD.1.10.0807192224300.3543@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:45828 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751155AbYGXP1U (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 24 Jul 2008 11:27:20 -0400
In-Reply-To: <alpine.LFD.1.10.0807192224300.3543@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>, linux-acpi@vger.kernel.org

On Sunday 20 July 2008 04:27:19 Len Brown wrote:
> On Fri, 18 Jul 2008, Thomas Renninger wrote:
> > On Friday 18 July 2008 09:16:25 am Andi Kleen wrote:
> > > Thomas Renninger wrote:
> > > > Introduce acpi_osi=windows_false boot parameter
> > > > Introduce CONFIG_ACPI_OSI_SPEC_CONFORM config option
> > >
> > > Why are you adding the CONFIG option?
> > > In what circumstances would one
> > > set it? If anything I think this should be a boot option only for now.
> >
> > E.g. for OEMs that do not need to support all BIOSes in the world who
> > can just check for the config option and then know it behaves as written
> > in the spec and being able to support Linux and Windows through the same
> > BIOS.
> >
> > But you are right, the compile option only makes sense if
> > acpi_osi="Windows 2006" can be used to simulate a specific Windows OS via
> > boot param, which is not the case.
> >
> > But I want the boot param. This one makes very much sense to test BIOSes
> > whether they stick to the ACPI spec and work fine on Linux without
> > Windows simulation. Is that ok?
> >
> > > Probably needs more discussion first.
> >
> > I always wanted to write down the arguments again, but this takes a lot
> > time.
> >
> > Will you accept the boot param only?
>
> I don't see a case for this.

This is part of a T61 ThinkPad BIOS:

# BIOS thinks we are running on XP or NT
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
# WVIS -> Bios thinks we are running on Vista
       If (\_OSI ("Windows 2006"))
       {
                 Store (0x01, \WVIS)
       }

So this BIOS on Linux has all above variables set and thinks it
is running on Vista and on XP...
Later they check e.g. on (hmm, this could be a clever way to trick
current Linux implementation, having Vista and XP set should only
happen on Linux):

       If (LAnd (\WXPF, LNot (\WVIS)))
       {
                  Notify (\_SB.PCI0, Arg1)
       }
       Else
       {
                  Notify (\_SB.PCI0.VID, Arg1)
       }

or only:
       If (VIGD)
       {
                  If (\WVIS)
                  {
                         \VBTD ()
                  }
       }


> This workaround is needed only if there is a Linux bug.
?!?
One intent is to use it as a boot param to identify OSI issues.
If a problem points to _OSI and things are too complicated to figure out, one 
can pass acpi_osi=windows_false to test whether removing all Windows hooks 
works.
It is also for research to find out how broken BIOSes are out there and 
whether they run fine without Windows hooks.

> I'd rather expose and fix that Linux bug than open
> the door to sweeping it under the rug and making
> Linux harder to maintain.
Len, this (the boot param only) is to make our life (ACPI bug tracking) 
easier, could you please add it.

Thanks,

        Thomas
