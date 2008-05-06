From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH] bay: Exit if notify handler cannot be installed
Date: Tue, 6 May 2008 12:39:01 -0300
Message-ID: <20080506153901.GC22828@khazad-dum.debian.net>
References: <20080505202508.GA3690@homac> <20080506091522.GA4378@homac> <1210065811.12668.1.camel@sli10-desk.sh.intel.com> <20080506151846.GA22828@khazad-dum.debian.net> <20080506162049.237af49c@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:43195 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1764888AbYEFPjE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 6 May 2008 11:39:04 -0400
Content-Disposition: inline
In-Reply-To: <20080506162049.237af49c@core>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Shaohua Li <shaohua.li@intel.com>, Holger Macht <hmacht@suse.de>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Accardi, Kristen C" <kristen.c.accardi@intel.com>

On Tue, 06 May 2008, Alan Cox wrote:
> On Tue, 6 May 2008 12:18:46 -0300
> Henrique de Moraes Holschuh <hmh@hmh.eng.br> wrote:
> > On Tue, 06 May 2008, Shaohua Li wrote:
> > > The bay driver is duplicated with libata, I thought we should delete it.
> > > See bug http://bugzilla.kernel.org/show_bug.cgi?id=9526
> > 
> > The bay driver is currently useless, BUT it should handle a lot of stuff
> > libata won't, such as bay batteries, bay floppies, and anything else in
> > a bay that is not a hard disk.
> 
> The bay driver needs to become a service that hands out bay events to
> all the other drivers for that to happen.

Seems sensible.  Any pointers?  I wouldn't know how to do it (and
actually, right now I am busy working on rfkill for some stuff
thinkpad-acpi needs), but I could try to tack bay after rfkill, if
nobody beats me to it (hint!)

BTW: dock handling might share these issues as well.

The problem has a bit of a hard edge, though: if nobody binds to an ACPI
node that has an EJ0 subnode, bay needs to do it.  But if someone wants
to, bay should give the node up, and somehow help that someone handle
the ejection stuff.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
