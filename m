From: Len Brown <len.brown@intel.com>
Subject: Re: new ibm-acpi maintainer
Date: Mon, 6 Nov 2006 13:18:22 -0500
Message-ID: <200611061318.23326.len.brown@intel.com>
References: <20061102220422.GJ19761@aero.ensim.com> <20061103161933.GD4257@khazad-dum.debian.net>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:25833 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1753753AbWKFSQQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Nov 2006 13:16:16 -0500
In-Reply-To: <20061103161933.GD4257@khazad-dum.debian.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Borislav Deianov <borislav@users.sourceforge.net>, Linux ACPI <linux-acpi@vger.kernel.org>, Arno Willig <akw@thinkwiki.org>

On Friday 03 November 2006 11:19, Henrique de Moraes Holschuh wrote:
> On Thu, 02 Nov 2006, Borislav Deianov wrote:
> > I've handed over ibm-acpi to Henrique de Moraes Holschuh

Thanks Boris, I know that a lot of thinkpad users are happier because of your efforts.

> Len, as the ACPI subsystem maintainer, is there any specific way you'd like
> me to handle ibm-acpi?

Yes, we should sync up on both the logistics and the strategy here.

Logistics are pretty much covered by Documentation/SubmittingPatches
Send to me, cc linux-acpi@vger.kernel.org
Subject: ACPI: ibm_acpi: fix foo for model bar

Put some thought into the Subject and check-in comments --
they are the "permanent record" and people do read them.

Also, it is ideal if we can maintain the invariant that the source is Lindent clean.
(right now ibm_acpi.c is very close to clean.  I often Lindent after patches,
 but not always -- simpler if you do it before sending to me)

The strategy for platform specific drivers that use ACPI is:
1. make the machines as useful as possible
2. be supportable by distributors w/o any special user-land effort

Linux does an okay job on #1, but not such a good job on #2 -- yet.

For #2 we are generally trying to make features available to the user
(think HAL, or X) with generic interfaces.  ie. if the word "acpi"
appears in the path, we are probably not generic enough for general use.

This is why I generally do not permit any new files under /proc/acpi,
and why we are trying over time to delete them all and use generic sysfs
places instead.

  eg. you've seen the recent changes to put brightness under sysfs
  in the backlight section, and the recent discussion about a generic
  battery interface, and the recent dock driver and bay driver.
  As these generic interfaces come on-line, we need to delete
  the old ones from these platforms drivers w/o screwing up users.
  This means announcing feature removal and documenting
  it in Documentation/feature-removal.txt and adding #ifdefs
  for the legacy stuff, then finally removing it.
 
 On a minor, but related note,  at some point, ibm_acpi.c should be moved
 outside of /drivers/acpi, probably to drivers/misc where other
 platform specific drivers are starting to congregate.
  This is because it is an OEM specific driver using un-documented
   OEM features that happen to depend on ACPI, but it is not implementing
   the ACPI spec itself, and is thus not part of ACPI.  Can still call it
  ibm_acpi.c, and I'll still be happy to handle patches to it,
  but the line between the implementation of the ACPI spec and the
  platform specific drivers that use ACPI has to be more clear.

thanks,
-Len
