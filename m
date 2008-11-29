From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [RFC PATCH] x86: create drivers/x86/ from drivers/misc/
Date: Sat, 29 Nov 2008 08:23:21 +0100
Message-ID: <20081129072321.GA8351@uranus.ravnborg.org>
References: <20081128213620.2ec593d4.sfr@canb.auug.org.au> <4930307C.30106@oracle.com> <20081129083550.3c23af37.sfr@canb.auug.org.au> <alpine.LFD.2.00.0811281649001.24773@localhost.localdomain> <alpine.LFD.2.00.0811281702570.24773@localhost.localdomain> <alpine.LFD.2.00.0811281706540.24773@localhost.localdomain> <20081128223533.GA5175@uranus.ravnborg.org> <alpine.LFD.2.00.0811281801520.24773@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0811281801520.24773@localhost.localdomain>
Sender: linux-next-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Len Brown <len.brown@intel.com>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Randy Dunlap <randy.dunlap@oracle.com>, x86@kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

> 
> I followed the example of drivers/s390/,
> per Linus' suggestion.

And in s390 we have:

block/
char/
cio/
crypto/
ebcdic.c
kvm/
Makefile
net/
s390mach.c
s390mach.h
s390_rdev.c
scsi/
sysinfo.c

So we end up with block drivers in drivers/block AND drivers/s390/block
This is the wrong way to divide up things.

find -name arm
./net/arm
./scsi/arm

find -name cris
./net/cris

find -name x86
./lguest/x86


See above. I have all net drivers under drivers/net/ and for 
arm and cris they have their own subdirectory.
Except for s390 where I have to go finding them in other places.

> The other place that seemed to suggest itself was
> arch/x86/drivers/, as we already have:
> 
> arch/um/drivers/
> arch/sh/drivers/
> arch/cris/*/drivers/

The approach has been for a long time to move away from
storing drivers under arch/*/drivers and cris is slowly
moving their drivers.
I dunno about um and sh.

	Sam
