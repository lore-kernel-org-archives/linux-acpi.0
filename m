From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: new ibm-acpi maintainer
Date: Tue, 21 Nov 2006 14:26:54 -0200
Message-ID: <20061121162654.GC29510@khazad-dum.debian.net>
References: <20061102220422.GJ19761@aero.ensim.com> <20061103161933.GD4257@khazad-dum.debian.net> <200611061318.23326.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:15827 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1031053AbWKUQ1B (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 21 Nov 2006 11:27:01 -0500
Content-Disposition: inline
In-Reply-To: <200611061318.23326.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, ibm-acpi-devel@lists.sourceforge.net

On Mon, 06 Nov 2006, Len Brown wrote:
> Also, it is ideal if we can maintain the invariant that the source is Lindent clean.
> (right now ibm_acpi.c is very close to clean.  I often Lindent after patches,
>  but not always -- simpler if you do it before sending to me)

Lindent doesn't do that well with some of the stuff in the patches, but I
will keep everything as Lindent-clean as possible, yes.  I will also see if
I can reformat it to be Lindent-friendly on the areas where Lindent doesn't
do the right thing.

> This is why I generally do not permit any new files under /proc/acpi,
> and why we are trying over time to delete them all and use generic sysfs
> places instead.

ibm-acpi needs a serious revamp on the stuff it *already* exports to
/proc/acpi, so that people will stop blindly echoing stuff directly to EC
space through /proc/acpi/ibm/ecdump.

But as soon as it becomes practical to do so (i.e. as soon as I can find a
sane way to place ibm-acpi in the device model -- currently this means I am
waiting the ACPI patches to go in), I intend to fully move to sysfs, and
freeze (and schedule for removal) the procfs interface.

>   eg. you've seen the recent changes to put brightness under sysfs
>   in the backlight section, and the recent discussion about a generic
>   battery interface, and the recent dock driver and bay driver.

Yes, I have paid quite close attention to them all.

>   This means announcing feature removal and documenting
>   it in Documentation/feature-removal.txt and adding #ifdefs
>   for the legacy stuff, then finally removing it.

Indeed.  For ibm-acpi, I will go with the shortest deprecation periods you
allow me to when the time to do it comes.  Some userland is doing
unforgivable sins to parse the ibm-acpi procfs output, and I want to see all
that bogosity *gone*.

>  On a minor, but related note,  at some point, ibm_acpi.c should be moved
>  outside of /drivers/acpi, probably to drivers/misc where other
>  platform specific drivers are starting to congregate.

Sure.  Whenever you feel like it is the right time to do it, we shall do it.

>    the ACPI spec itself, and is thus not part of ACPI.  Can still call it
>   ibm_acpi.c, and I'll still be happy to handle patches to it,
>   but the line between the implementation of the ACPI spec and the
>   platform specific drivers that use ACPI has to be more clear.

It is a done deal, then.  Just tell me when you want it moved.

A first lot of patches for ibm-acpi will follow soon.  I can also provide
them through git if you'd prefer that.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
