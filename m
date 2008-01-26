From: Len Brown <lenb@kernel.org>
Subject: initrd DSDT override (Re: Feedback about your talk in Rennes France (20080124) : Evolution of the Linux kernel & virtualization technologies)
Date: Fri, 25 Jan 2008 23:39:44 -0500
Message-ID: <200801252339.44246.lenb@kernel.org>
References: <4798E2A5.6020804@users.sf.net> <20080125063328.4e3b4752.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:52791 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752402AbYAZEk0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 25 Jan 2008 23:40:26 -0500
In-Reply-To: <20080125063328.4e3b4752.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: Andrew Morton <akpm@linux-foundation.org>, Philippe Coval <rzr@users.sourceforge.net>, linux-acpi@vger.kernel.org


> > I am annoyed by this missing (or rejected) feature upstream : DSDT
> >   http://gaugusch.at/kernel.shtml
> > 
> > So to use "custom DSDT loading" I have to patch my laptop buggy BIOS
> > 
> > As usual, I reported this issue to the vendor (which goes nowhere so far) :
> >   http://support.fujitsu-siemens.de/forum/viewtopic.php?p=37001
> > 
> > Hopefully many distro already include this patch, but not all of them
> > such as debian :
> >   http://bugs.debian.org/251023
> >   http://wiki.debian.org/DebianKernelPatchAcceptanceGuidelines
> > 
> > So as a debian contributor, I keep staying on debian and compile my own
> > kernel
> >   and provide it to a "amiloa laptop" community I am managing :
> >   http://tech.groups.yahoo.com/group/amilo/
> > 
> > It's ok for me I can live with this,  but what average users have to do
> > with their (buggy) hardware ?
> 
> Philosophically speaking: we sholdn't be making decisions for other people
> like this.
> 
> Practically speaking: the fact that distros are shipping it is a huge
> indication that the decision was wrong.
> 
> Len?  I think we goofed here.

Here is the existing supported DSDT override method:

http://www.lesswatts.org/projects/acpi/overridingDSDT.php

and at the bottom of that page I point to the alternate initrd
method and explain why I've not applied it upstream.

My goal for the Linux/ACPI project is to make Linux
work out-of-the-box on any system where Windows works.

Giving "Joe User", who is incapable of compiling
a kernel, an easy method to override his BIOS image
makes him more likely to settle for a workaround.
And that effort undermines, rather than supports, our goal.

However, Philippe points out that the FSC Amilo box
also fails the same way under Windows -- and the
vendor is unwilling or unable to fix their BIOS.
While Phillippe could build a kernel from source
and link in a DSDT via the supported developer method above,
or he could run SuSE or Ubuntu which include the initrd
patch, he'd prefer to track Debian w/o re-compiling.

I'm fine with making it more convenient for
FSC Amilo ownersr to make their laptops work better
under Linux than under Windows -- even if it is impossible
for a Linux distro to support the resulting configuration.
They're otherwise stuck with junk hardware or extra work.

Also, Thomas continues to assert that this patch
makes SuSE easier to debug in the field b/c he can convince
users who are unable to re-compile their kernel
go ahead and override their BIOS image for debugging
(bless their trusting hearts;-)

So at the risk that we're giving "Joe User" more
than enough rope to hang themselves, lets do it --
with some strings attached...

Thomas,
Since you've been a big supporter of this patch, perhaps you
can update it and submit it to the list for review?

I think it needs the following changes:

1. tainted bit needs to be set when a DSDT override is used.
   (this is common both to the new patch and the current
    override method)

2. upon setting the tainted bit, print a BIG FAT WARNING
   that this is not a supported configuration.

3. cmdline option needs to be available to disable
   an override.  Otherwise a bad image in the intrd
   may be a serious pickle for some users.

4. get rid of alarming failure message:

+	printk(KERN_INFO "Looking for DSDT in initrd ...");
...
+	printk(" not found!\n");

Probably it is best to forward the original patch
w/ proper credits, and then send updates to address 1-4.

thanks,
-Len

