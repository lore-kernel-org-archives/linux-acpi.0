From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [ACPI] p2b-ds blacklisted?
Date: Fri, 3 Oct 2003 02:07:48 -0400
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE0CC874E@hdsmsx402.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
content-class: urn:content-classes:message
To: =?iso-8859-1?Q?Sven_K=F6hler?= <skoehler-yTMzxJmGYpQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> > I would like to try what happens if i remove the board from the 
> > blacklist.
> 
> ... I removed the board from the blacklist, 

> The kernel started and there were some issues with the interrupt 
> routing....

> With "pci=noapci" the computer hang upon loading the kernel 
> module for the SCSI controller.
...
> At first sight ACPI (without pci=noacpi) seemed to work but 
> pressing the 
> power button didn't generate any events although the power button was 
> detected properly during boot.

Nothing registered on the acpi interrupt in /proc/interrupts?

> After all i think i know why P2B-S and -DS are blacklisted. The board 
> with on-board SCSI controller are messed up somehow.
> 
> I haven't tried to install BIOS 1014beta3 yet. BIOS 1014beta2 is 
> currently installed but i guess the update won't solve anything.

Depends on the root cause -- try it.  If it works we can replace the current blacklist entry with one keyed off the BIOS date.

If you want Linux/ACPI to work on this board, or proof that the board can't possibly support it, then then file a bug:

http://bugzilla.kernel.org/
Category: Power Management
Component: ACPI

Attach the console log and /proc/interrupts of the failure, dmidecode output, and acpidmp output.

> With acpi=ht it works for now, but doesn't acpi=ht imply pci=noacpi?

Booting with acpi=force should be the same as removing the P2B-DS from the dmi blacklist.

acpi=ht will use ACPI for enumerating processors, and then ACPI will exit.
ACPI will not be used to configure interrupts and the interpreter will not
run so you'll get no run-time events.  If this system doesn't have HT and has MPS, then ACPI with acpi=ht does nothing for you that you don't have already.

pci=noacpi is the same as above except the interpreter _will_ run in support of run-time events.

Ie. Acpi=ht will give you "ACPI: Interpreter disabled" and pci=noacpi will not.

Cheers,
-Len
