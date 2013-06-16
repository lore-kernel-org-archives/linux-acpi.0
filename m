From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: Wishlist: Disable C6 in intel_idle for Model 44 processors
Date: Sun, 16 Jun 2013 00:29:52 -0300
Message-ID: <20130616032952.GC10838@khazad-dum.debian.net>
References: <38D8523B-C50E-4D81-A9E2-526292B19AF3@usgs.gov>
 <20130612134002.GA15317@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:33240 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754796Ab3FPDiL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 15 Jun 2013 23:38:11 -0400
Content-Disposition: inline
In-Reply-To: <20130612134002.GA15317@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Larry Baker <baker@usgs.gov>, linux-acpi@vger.kernel.org, Rob E Russell <robr@us.ibm.com>

On Wed, 12 Jun 2013, Matthew Garrett wrote:
> On Tue, Jun 11, 2013 at 02:30:30PM -0700, Larry Baker wrote:
> > I have an IBM System x3650 M3 with an Intel Xeon L5630 processor.  My
> > IBM support team alerted me to an issue with C6 states for those
> > processors when running Linux and the intel_idle kernel module is used.
> > The IBM solutions page,
> > http://www-947.ibm.com/support/entry/portal/docdisplay?lndocid=migr-5091901,
> > recommends disabling intel_idle.  I propose intel_idle disable C6 for
> > the affected processors.
> 
> As you note:
> 
> > > Workaround: It is possible for the BIOS to contain a workaround for
> > > this erratum.
> 
> Are you actually seeing this specific problem? If so, you should probably
> request a firmware update from IBM. If that's not a possibility, and if it
> is necessary to disable package C6 in this situation, it'd be nice to
> determine what the BIOS workaround actually does and limit the quirk to
> that case.

"It is possible for the BIOS to contain a workaround for this erratum." is
Intel speak for either "there is a processor microcode update that fixes
this", or "there is an undocumented bit somewhere you can toggle that
disables some functionality, and also works around this bug".

Now, good luck finding out WHICH microcode update is required or which bit
to toggle on whichever MSR/PCIe register.  It is certainly something we
could easily detect and disable C6 only when required (i.e. workaround not
in place) or even fix it ourselves... IF we had enough information.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
