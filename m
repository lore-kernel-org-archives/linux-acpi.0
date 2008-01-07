From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: brightness control on thinkpad t61p
Date: Sun, 6 Jan 2008 23:36:23 -0200
Message-ID: <20080107013623.GA6667@khazad-dum.debian.net>
References: <20071223000057.739d5891.akpm@linux-foundation.org> <20071224073406.GA1018@srcf.ucam.org> <20071226141027.6d1a509f.akpm@linux-foundation.org> <20071226222321.GA32297@srcf.ucam.org> <20071227123358.GB25535@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:35137 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752161AbYAGBg2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 6 Jan 2008 20:36:28 -0500
Content-Disposition: inline
In-Reply-To: <20071227123358.GB25535@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>

On Thu, 27 Dec 2007, Henrique de Moraes Holschuh wrote:
> On Wed, 26 Dec 2007, Matthew Garrett wrote:
> > On Wed, Dec 26, 2007 at 02:10:27PM -0800, Andrew Morton wrote:
> > 
> > > Vice versa for me.  The thinkpad_acpi driver in 2.6.23 _does_ work,
> > > but its interface vanished in 2.6.24-rc5 and the acpi driver does not
> > > work.
> > 
> > As I said, the interface for the ACPI backlight driver is confusing. 10 
> > will only work if the firmware supports it - have you tried other 
> > values?
> 
> Not on a thinkpad.  The AML code is not that stupid, it rounds down to the
> nearest supported value.   It takes a brightness percentage (0 to 100), maps
> it through a table to get the visual brightness -> hardware brightness curve
> right (it is non-linear), then does what thinkpad-acpi does to set backlight
> brightness.

Bah, I spoke too soon.  Latest round of BIOSes seems to have broken this,
either that or I completely misunderstood the older AML code.

Rounding to the nearest supplied _BCL value before we call _BCM apparently
will be needed on thinkpads as well.

Oh, just another datapoint for Andrew: your thinkpad backlight firmware
behaves differently before and after something calls _BCL.  And I believe it
also behaves differently before Linux boots (my guess is that it changes
behaviour when ACPI inits), so it is getting more and more complicated to
debug this thing without direct access to one such thinkpad.

I heavily recommend calling the ACPI _BCL method (e.g. by loading ACPI video
and unloading it later if you don't want it), so that at least you have a
small chance of things working consistently :) The AML code is supposed to
just issue normal ACPI events and leave the backlight hardware alone after
you call _BCL.

But if X.org is messing with the BIOS scratch registers, not even ACPI
video.c will work, as the SMBIOS crap the thinkpad AML code calls to
implement BQC/BCQ and BCM will be disabled.  In that case, X.org has to be
able to modify the hardware directly (through xbacklight) in order to get
anything done.

I am seriously considering a call to _BCM in thinkpad-acpi, to make sure we
get a more-or-less sane thinkpad behaviour on these newer Lenovo BIOSes,
even if the user doesn't want to use ACPI video.c for some reason.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
