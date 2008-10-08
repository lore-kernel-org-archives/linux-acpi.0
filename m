From: Thomas Renninger <trenn@suse.de>
Subject: Re: Problem: ACPI related soft lockup on Fujitsu-Siemens AMILO Si 2636
Date: Thu, 9 Oct 2008 00:19:20 +0200
Message-ID: <200810090019.21303.trenn@suse.de>
References: <48E9F51A.4080107@gmail.com> <200810081308.52221.trenn@suse.de> <48EC9F0B.3090207@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:60290 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754915AbYJHWTW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 8 Oct 2008 18:19:22 -0400
In-Reply-To: <48EC9F0B.3090207@gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: Thomas Lindroth <thomas.lindroth@gmail.com>, linux-acpi@vger.kernel.org

On Wednesday 08 October 2008 01:52:43 pm Alexey Starikovskiy wrote:
> Thomas Renninger wrote:
> > On Wednesday 08 October 2008 12:48:36 Thomas Lindroth wrote:
...
> > Is there a general hint I could add into the ACPI Linux guideline, like:
> > Don't implement EC data/index register reads/writes in AML yourself.
> > Define a EC variable and e.g. use Store(ECXY, Local0) to read and
> > Store(Local0, ECXY) to write to specific EC bytes.
>
> Declare EC interface might be a better wording.
>
> > Did I get this right?
>
> Yes.
> My understanding is that Windows does not support 2 EC devices, so
> these people need to implement second in AML.
> So, it might be worth noting that Linux can handle any number of EC
> devices.
Can these guys do it right if we return true for:
_OSI("Multiple EC capable")

How does a second EC declaration look like?
Just a second EC OperationRegion?
Ahh, it's a whole device, it would still work. It's just the first time that 
the device is only used on Linux and not on Windows.
This would also be declared in Windows, because you cannot set conditions 
around declarations, but it would not hurt:
This is done in _OSI init section:

                    If (\_OSI ("Multiple EC capable"))
                    {
                        Store (0x01, \MIEC)
                    }

Somewhere in the Scope you have this unconditionally.
Arghh, that would certainly not work on Windows then or could at least
be a potential risk there?:
                    /* Second EC, unused on Windows */
                    Device (EC2)
                   {
                        Name (_HID, EisaId ("PNP0C09"))
                        OperationRegion (ECOR, EmbeddedControl, 0x00, 0x0100)
                        Field (ECOR, ByteAcc, NoLock, Preserve)
                        {
                            RTMP,   1,
                            ...
                        }
                   }

Where the actual value is read:

/* Linux case */
if(LEqual(MIEC, 1))
   Store(RTMP, 1)

/* Windows case */
else {
    While (RCMD (0x80, Local0))
    {
        Noop
        Noop
        Store (PMUC, Local5)
        If (And (Local5, One, Local2))
        {
            Store (PMUD, Local5)
        }
    }
}

---------------
Better ideas?
The problem is the second EC HID device which cannot be hidden on Windows...
If Windows is really too dumb for two ECs and vendors are therefore really 
doing such crap as above, we should think about alternatives..., the EC 
driver simulation looks rather unsupportable (It misses some locks, but not 
in AML namespace, but the ones in drivers/acpi/ec.c, right?).

IIRC the ACPI spec explicitly mentions a two (or multiple?) EC PC 
configuration somewhere? Anyway...

     Thomas
