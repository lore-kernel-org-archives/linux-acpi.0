From: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Subject: Re: [ACPI] Re: [PATCH] Next round of ACPI IRQ fixes (VIA ACPI fixed)
Date: Sat, 6 Sep 2003 02:21:30 +0100
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <200309060221.30741.adq_dvb@lidskialf.net>
References: <200309051958.02818.adq_dvb@lidskialf.net> <200309060016.16545.adq_dvb@lidskialf.net> <20030905170224.A16217@osdlab.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20030905170224.A16217-BI/OLcgY7/cyyg0EjBt7GtHuzzzSOjJt@public.gmane.org>
Content-Disposition: inline
To: Chris Wright <chrisw-3NddpPZAyC0@public.gmane.org>
Cc: lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Saturday 06 Sep 2003 1:02 am, Chris Wright wrote:
> * Andrew de Quincey (adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org) wrote:
> > On Friday 05 Sep 2003 10:35 pm, Jeff Garzik wrote:
> > > This is why we _really_ need you to split up your patches.  Multiple
> > > split-up patches, one per email, is preferred.  Don't worry about
> > > sending us too much email:  we like it like that.
> >
> > If/when I split it up, is it acceptable to number the patches to give the
> > order they have to be applied in? The major problem with these particular
> > fixes is that they all run over the same set of files, even the same
> > functions, so they all conflict with each other.
>
> Yes, please split them up.
>
> I finally narrowed down to the ChangeSet 1.1046.1.424 (ACPI: Allow irqs >
> 15...) as cause to my current hang-on-boot problem.  Quick test to see
> if this patch fixes...nope ;-(

I have reports of a number of systems with issues like this. 

I have a machine here (A Fujitsu Siemens TX150 server) in which the SCSI 
controller actually corrupts the low level format of the hard disk if I 
enable ACPI! (low level reformat required!). The ACPI IRQ setup seems to work 
fine on it (as I assume it does on your system). Its just that there seems to 
be "something else" wrong in ACPI still. Weirdly enough, it can read sector 0 
of the HDD fine.. just any reads of any other sectors cause this corruption.

Now that I've got the bulk of the changes to the basic ACPI IRQ setup done, I 
can concentrate on these issues. Can you give me details of your system and 
the following items:

successful dmesg
dmesg from a failed boot
/proc/acpi/dsdt
/proc/interrupts
